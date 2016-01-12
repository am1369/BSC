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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import static java.lang.System.out;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import static com.example.web.Authservlet.session;
/**
 *
 * @author kosmima
 */
public class Student extends HttpServlet{
   // private static final long serialVersionUID = 1L;
                private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
                private final static String DBUSER = "root";
                private final static String DBPSW = "kosmima";
    
                private PreparedStatement pstmt;
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                
            //Object user2 = session.getAttribute("user");
            //String myusername=user2.toString();
            
    
    @Override
     public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
         String myusername = (String) session.getAttribute("user");
                
// Set response content type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
            

        try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB, DBUSER, DBPSW);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            request.setCharacterEncoding("UTF-8");
            //String username = request.getParameter("username");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String mail = request.getParameter("mail");
            
            //Authservlet myuser = new Authservlet();
            
            
            
            out.println("<html><body>UserN: "+myusername+"\n</body></html>");
            out.println("<html><body>FirstN: "+fname+"\n</body></html>");
            out.println("<html><body>LastN: "+lname+"\n</body></html>");
            out.println("<html><body>Mail: "+mail+"\n</body></html>");
            
        
            // Execute SQL query
        try {
                    stmt = conn.createStatement();
                    
                    
                    //db query for current user
                    
                    //HttpSession session;
            
                    //String sql;
                    //sql = "SELECT  id,brand_name,gas,laundry,address,latitube, longitude FROM gas_station\n" +
                    // "    GROUP BY brand_name";
            ResultSet rs = stmt.executeQuery("SELECT * from bsctable");
                    //String myusername = rs.getString("username");  
                    //out.println("<html><body>Username: "+myusername+"\n</body></html>");
                    //session = request.getSession();
                    
                        pstmt = conn.prepareStatement("UPDATE bsctable SET email=?, firstname=?, lastname=? WHERE username=?" );
                        //pstmt.setString(1, username);
                        pstmt.setString(1, mail);
                        pstmt.setString(2, fname);
                        pstmt.setString(3,lname);
                        pstmt.setString(4,myusername);
                        int i= pstmt.executeUpdate();
                    
                        if (i!=0){
                            out.println("<html><body>Records have been inserted<br>\n</body></html>");
                            
                        } else{
                            out.println("<html><body>Inserting records get failure<br>\n</body></html>");
                            
                        }
                        rs = pstmt.executeQuery("SELECT * FROM bsctable ");
                        rs.close();
                        pstmt.close();
                        
                        //RequestDispatcher view = request.getRequestDispatcher("responsetwo.jsp");
                        //view.forward(request, response);
                    
                    
                    
                    //String tname = rs.getString("TName");
                    //request.setAttribute("rs", rs);
                    //request.setAttribute("returnRes", rs);

            // Extract data from result set
            // Clean-up environment
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        }
        request.setAttribute("update","Your info are updated" );
                                            
        RequestDispatcher view = request.getRequestDispatcher("response.jsp");
        view.forward(request, response);
        //session.setAttribute("TName",tname);
                
        }
}

    

