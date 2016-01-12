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
    
    static void printAttrs(Attributes attrs) {
    if (attrs == null) {
      System.out.println("No attributes");
    } else {
      /* Print each attribute */
      try {
        for (NamingEnumeration ae = attrs.getAll(); ae.hasMore();) {
          Attribute attr = (Attribute) ae.next();
          System.out.println("attribute: " + attr.getID());

          /* print each value */
          for (NamingEnumeration e = attr.getAll(); e.hasMore(); ){
              System.out.println("value: " + e.next());
          }
        }
      }catch (NamingException e) {
        e.printStackTrace();
      }
  }
}


    //DETAILS OF MY DB
    private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
    private final static String DBUSER = "root";
    private final static String DBPSW = "kosmima";
    
    public static boolean auth = false;
    private  Attributes atr;
    private PreparedStatement pstmt;
    public static HttpSession session;
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    //ResultSet rs1 = null;
    
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
            //connect to my database
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
                
                user = request.getParameter("uname");
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
                auth=true;
                
                //System.out.println(ctx.getEnvironment());
                //Attributes answer = ctx.getAttributes("uid=makosmid,ou=people,dc=uth,dc=gr");
                
                //printAttrs(answer);
                
                //System.out.println(ctx.getAttributes("uid=makosmid,ou=people,dc=uth,dc=gr").get("eduPersonAffiliation"));
               
                ctx.close();
                
            } catch (ClassNotFoundException | SQLException | AuthenticationException ex) {
                //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                auth=false;
            } catch (NamingException ex) {
                //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                auth=false;
            }
            
        //get the username and password from the index.jsp-input
        //request.setCharacterEncoding("UTF-8");
        
            //get the username and password from the index.jsp-input
            //request.setCharacterEncoding("UTF-8");
          
            //System.out.println("telos\n");
            PrintWriter out = response.getWriter();
            out.println("<html><body>Auth: "+auth+"\n</body></html>");
            out.println("<html><body>Name: "+getName()+"\n</body></html>");
            out.println("<html><body>Type: "+getAffiliation()+"\n</body></html>");
            out.println("<html><body>Mail: "+getMail()+"\n</body></html>");
            
            if (auth){
             
                try {
                    stmt = conn.createStatement();
                    
                    
                    //db query for current user
                    rs = stmt.executeQuery("SELECT * FROM bsctable WHERE username='" + user + "'");
                    //rs = stmt.executeQuery("SELECT * FROM projects ");
                    
                    //HttpSession session;
                    
                    
                    if (rs.next()){ //uparxei sti basi mou
                        String name = getName();
                        String affil = getAffiliation();
                        String mail = getMail();
                        
                        out.println("<html><body>The user exists "+getName()+"\n</body></html>");
                     
                        //DELETE DATA FROM DB
                        /*pstmt = conn.prepareStatement("DELETE FROM bsctable WHERE id=2");
                        pstmt.executeUpdate();
                        pstmt.close();*/
                        
                        session = request.getSession();
                        //setting session to expiry in 30 mins
                        session.setMaxInactiveInterval(30*60);
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(30*60);
                        response.addCookie(userName);
                        //response.sendRedirect("response.jsp");
                        
                        String username = rs.getString("username");
                        
                        //request.setAttribute("rs", rs);
                        //request.setAttribute("rs1", rs1);
                        //request.setAttribute("username", username);
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        session.setAttribute("username",username);
                        
                                if(user.equals("makosmid")){
                                    response.sendRedirect("responsetwo.jsp");
                                   //request.setCharacterEncoding("UTF-8");
                                   //request.getRequestDispatcher("responsetwo.jsp").forward(request, response);
                                   
                                }
                                else{
                                    response.sendRedirect("response.jsp");
                                    //request.setCharacterEncoding("UTF-8");            
                                    //RequestDispatcher view = request.getRequestDispatcher("response.jsp");
                                    //view.forward(request, response);
                                }
                       
          
                        session.setAttribute("user", user);
                        session.setAttribute("cn;lang=el", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        session.setAttribute("username",username);
                        
                        //session.setAttribute("rs",rs);
                        //String username = rs.getString("username");   
                    }
                    else{ 
                        //den uparxei sti basi mou
                        String name = getName();
                        String affil = getAffiliation();
                        String mail = getMail();
                     
                        out.println("<html><body>Insert the user "+name+"\n</body></html>");
                        
                        session = request.getSession();
                        //setting session to expiry in 30 mins
                        session.setMaxInactiveInterval(30*60);
                        Cookie userName = new Cookie("user", user);
                        userName.setMaxAge(30*60);
                        response.addCookie(userName);
                        
                        pstmt = conn.prepareStatement("INSERT INTO bsctable(username, affiliation, email) VALUES (?,?,?)");
                        pstmt.setString(1, user);
                        pstmt.setString(2, affil);
                        pstmt.setString(3, mail);
                        pstmt.executeUpdate();
                        pstmt.close();
                        
                        RequestDispatcher view = request.getRequestDispatcher("response.jsp");
                        view.forward(request, response);
                        
                        session.setAttribute("user", user);
                        session.setAttribute("cn", name);
                        session.setAttribute("mail", mail);
                        session.setAttribute("eduPersonAffiliation", affil);
                        //String username = rs.getString("username");    
                    }
                    // RequestDispatcher view = request.getRequestDispatcher("response.jsp");
                    // view.forward(request, response);
                    
                } catch (SQLException ex) {
                    System.out.println("exception to login");
                    Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
                    
                }
            }
            else{
                request.setAttribute("error","Invalid Username or Password\n" 
                                            +"Please, try again!");
                RequestDispatcher view = request.getRequestDispatcher("index.jsp");
                view.forward(request, response);
            }
}
}