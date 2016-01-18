/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Authservlet extends HttpServlet {
    //private static final long serialVersionUID = 1L;
    public String getName(){
        if(auth)
            return atr.get("cn").toString().replace("cn: ", "");
        return "Not authenticated";
    }
    public String getUsername(){
        if(auth)
            return atr.get("uid").toString().replace("uid: ", "");
        return "Not authenticated";
    }
    public String getAffiliation(){
        if(auth)
            return atr.get("eduPersonAffiliation").toString().replace("eduPersonAffiliation: ", "");
        return "Not authenticated";
    }
    public String getMail(){
        if(auth)
            return atr.get("mail").toString().replace("mail: ", "");
        return "Not authenticated";
    }
    //Testing the LDAP -> get all the attributes 
    /*static void printAttrs(Attributes attrs) {
    if (attrs == null) {
      System.out.println("No attributes");
    } else {
      try {
        for (NamingEnumeration ae = attrs.getAll(); ae.hasMore();) {
          Attribute attr = (Attribute) ae.next();
          System.out.println("attribute: " + attr.getID());

          for (NamingEnumeration e = attr.getAll(); e.hasMore(); ){
              System.out.println("value: " + e.next());
          }
        }
      }catch (NamingException e) {
        e.printStackTrace();
      }
    }
    }*/

    //The details of my db
    private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
    private final static String DBUSER = "root";
    private final static String DBPSW = "k0sm1m@6256";
    
    public static boolean auth = false;
    private  Attributes atr;
    private PreparedStatement pstmt;
    public static HttpSession session;
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    //A filter for encoding UTF-8
    /*protected void doFilterInternal(HttpServletRequest request,
            HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        //Set character encoding as UTF-8
        request.setCharacterEncoding("UTF-8");
        filterChain.doFilter(request, response);
    }*/
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {
            String user = "", pass = "";
            
            //Connection to my db with the details above
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
                
                //get from the input username and password
                user = request.getParameter("username");
                pass = request.getParameter("pass");

                // Set up ldap environment
                Hashtable<String,String> env = new Hashtable<String,String>();
                env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
                env.put(Context.PROVIDER_URL, "ldap://ldap.uth.gr:389/");
                // Authenticate as S.User and password "mysecret"
                env.put(Context.SECURITY_PRINCIPAL, "uid=" + user + ", ou=People, dc=uth,dc=gr");
                env.put(Context.SECURITY_AUTHENTICATION, "simple");
                env.put(Context.SECURITY_CREDENTIALS, pass);

                DirContext ctx = new InitialDirContext(env);
                atr = ctx.getAttributes("uid=" + user + ", ou=People, dc=uth, dc=gr");
                
                //if you are in the db of the LDAP set auth-flag=true
                auth=true;
               
                ctx.close();
                
            } catch (ClassNotFoundException | SQLException | AuthenticationException ex) {
                //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                auth=false;
            } catch (NamingException ex) {
                //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                auth=false;
            }
            PrintWriter out = response.getWriter();
            out.println("<html><body>Auth: "+auth+"\n</body></html>");
            out.println("<html><body>Name: "+getName()+"\n</body></html>");
            out.println("<html><body>Type: "+getAffiliation()+"\n</body></html>");
            out.println("<html><body>Mail: "+getMail()+"\n</body></html>");
            
            //If authentication from LDAP is true
            if (auth){
                        String name = getName();
                        String affil = getAffiliation();
                        String mail = getMail();
             
                try {
                    stmt = conn.createStatement();
                    //db query for current user
                    rs = stmt.executeQuery("SELECT * FROM bsctable WHERE username='" + user + "'");
                    
                    //If the user exists already in my db
                    if (rs.next()){ 
                        out.println("<html><body>The user "+getName()+"exists\n</body></html>");
                     
                        //Delete data from my db
                        /*pstmt = conn.prepareStatement("DELETE FROM bsctable WHERE id=2");
                        pstmt.executeUpdate();
                        pstmt.close();*/
                        
                        //Open a session from HttpSession
                        session = request.getSession();
                        //setting session to expiry in 5 mins or in 5*60 sec
                        session.setMaxInactiveInterval(5*60);
                        //Create a cookie for the username so as to expire in 5 min if the page is inactive
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(5*60);
                        response.addCookie(userName);
                        
                        //username is the username from my db
                        String username = rs.getString("username");
                        
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        session.setAttribute("username",username);
                        
                        //If the user is teacher go to the Teacher's Page
                                //if(user.equals("makosmid")){
                                  if(affil.equals("student")){
                                    response.sendRedirect("response.jsp");
                                   //request.setCharacterEncoding("UTF-8");
                                   //request.getRequestDispatcher("responsetwo.jsp").forward(request, response);  
                                }
                        //If the user is student go to the Student's Page
                                else{
                                    response.sendRedirect("responsetwo.jsp");
                                    //request.setCharacterEncoding("UTF-8");            
                                    //RequestDispatcher view = request.getRequestDispatcher("response.jsp");
                                    //view.forward(request, response);
                                }
                                
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        session.setAttribute("username",username);  
                    }
                    //The user doesn't exist in my db, so insert the data to it
                    else{
                        out.println("<html><body>Insert the user "+name+"\n</body></html>");
                        
                        //Open a session from HttpSession
                        session = request.getSession();
                        //setting session to expiry in 5 mins or 5*60 sec
                        session.setMaxInactiveInterval(5*60);
                        //Create a cookie for the username so as to expire in 5 min if the page is inactive
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(5*60);
                        response.addCookie(userName);
                        
                        //Insert query
                        pstmt = conn.prepareStatement("INSERT INTO bsctable(username, affiliation, email, name) VALUES (?,?,?,?)");
                        pstmt.setString(1, user);
                        pstmt.setString(2, affil);
                        pstmt.setString(3, mail);
                        pstmt.setString(4,name);
                        pstmt.executeUpdate();
                        pstmt.close();
                        
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        
                        //If the user is teacher go to the Teacher's Page
                        //if(user.equals("makosmid")){
                        if(affil.equals("student")){
                                    response.sendRedirect("response.jsp");
                                   //request.setCharacterEncoding("UTF-8");
                                   //request.getRequestDispatcher("responsetwo.jsp").forward(request, response);
                        }
                        //If the user is student go to the Student's Page
                        else{
                            response.sendRedirect("responsetwo.jsp");
                            //request.setCharacterEncoding("UTF-8");            
                            //RequestDispatcher view = request.getRequestDispatcher("response.jsp");
                            //view.forward(request, response);
                        }
                        
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);    
                    }
                } catch (SQLException ex) {
                    System.out.println("exception to login");
                    Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                    
                }
            }
            //If authentication from LDAP is false
            else{
                //Message for incorrect username or password
                request.setAttribute("error","Invalid Username or Password\n" 
                                            +"Please, try again!");
                RequestDispatcher view = request.getRequestDispatcher("index.jsp");
                view.forward(request, response);
            }
}
}