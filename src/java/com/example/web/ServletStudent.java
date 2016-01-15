/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author kosmima
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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import static com.example.web.Authservlet.session;
import javax.servlet.RequestDispatcher;

public class ServletStudent extends HttpServlet{
    
    //The details of my db
    private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
    private final static String DBUSER = "root";
    private final static String DBPSW = "k0sm1m@6256";

    private PreparedStatement pstmt;
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String query=null;
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
                
        // Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        //Connection with my db
        try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        
        String myname = (String) session.getAttribute("cn");
        request.setCharacterEncoding("UTF-8");
        String[] check = request.getParameterValues("check" );
        out.println("<html><body>User:"+myname+"<br>\n</body></html>");
       
        try {
                    stmt = conn.createStatement();
                    
                    query = "UPDATE projects SET SName=? WHERE Id= ?";
                    for(int i = 0; i<check.length; ++i)
                    {
                        if(check[i].equals(check[i]))
                        {
                            out.println("<html><body>User:"+check[i]+"<br>\n</body></html>");
                            rs = stmt.executeQuery("SELECT * FROM projects WHERE Id='" + check[i] + "'");
                            while(rs.next()){
                                    String sname = rs.getString("SName");
                                    if((sname==null)||(sname==""))
                                    {
                                        pstmt = conn.prepareStatement(query);
                                        pstmt.setString(1,myname);
                                        pstmt.setString(2,check[i]);
                                    }
                            }
                        }
                    }
                    int i= pstmt.executeUpdate();
                    if (i!=0){
                        out.println("<html><body>Records have been inserted<br>\n</body></html>");
                        rs = stmt.executeQuery("SELECT * FROM projects WHERE SName='" + myname + "'");
                        while(rs.next()){

                            String title = rs.getString("Title");
                            out.println("<html><body>"+title+"<br>\n</body></html>");
                            rs.close();
                            pstmt.close();
                            
                            session.setAttribute("title",title);
                            request.setAttribute("check","Your apply has been successfully sent to the teacher."
                                        +"\n"+"You will be notified for the confirmation as soon as possible."
                                        +"\n"+"Thank you!");
                            RequestDispatcher view = request.getRequestDispatcher("final.jsp");
                            view.forward(request, response);
                        }
                    } else{
                        out.println("<html><body>Inserting records get failure<br>\n</body></html>");
                        request.setAttribute("check","Unfortunately, you cannot check this project.Maybe, it is already checked from another student or you have not the perimission."
                                        +"\n"+"Check for another one."
                                        +"\n"+"Thank you!");
                        RequestDispatcher view = request.getRequestDispatcher("final.jsp");
                        view.forward(request, response);
                    }        
            // Extract data from result set
            // Clean-up environment
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        }
        out.println("<html><body>Inserting records get failure<br>\n</body></html>");
        request.setAttribute("check","Unfortunately, you cannot check this project.Maybe, it is already checked from another student or you have not the perimission."
                        +"\n"+"Check for another one."
                        +"\n"+"Thank you!");
        RequestDispatcher view = request.getRequestDispatcher("final.jsp");
        view.forward(request, response);
        
        
     }
}
