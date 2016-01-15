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

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import static com.example.web.Authservlet.session;

public class Teacher extends HttpServlet {
    
                private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
                private final static String DBUSER = "root";
                private final static String DBPSW = "k0sm1m@6256";
    
                private PreparedStatement pstmt;
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null; 
    @Override
     public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
                
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
            
            //Get parameters from the input
            request.setCharacterEncoding("UTF-8");
            String title = request.getParameter("title");
            String department = request.getParameter("department");
            int year = Integer.parseInt(request.getParameter("year"));
            int type = Integer.parseInt(request.getParameter("type"));
            String info = request.getParameter("info");
            String link =request.getParameter("link");
            
            String tname = (String) session.getAttribute("cn");
            
            out.println("<html><body>Title: "+tname+"\n</body></html>");
            out.println("<html><body>Title: "+title+"\n</body></html>");
            out.println("<html><body>Department: "+department+"\n</body></html>");
            out.println("<html><body>Year: "+year+"\n</body></html>");
            out.println("<html><body>Type: "+type+"\n</body></html>");
            
        
        // Execute SQL query
        try {
                        pstmt = conn.prepareStatement("INSERT INTO projects (Title, Type, Department, Tname, Year, Info, Link) VALUES (?,?,?,?,?,?,?)");
                        pstmt.setString(1, title);
                        pstmt.setInt(2, type);
                        pstmt.setString(3, department);
                        pstmt.setString(4, tname);
                        pstmt.setInt(5, year);
                        pstmt.setString(6, info);
                        pstmt.setString(7,link);
                        int i= pstmt.executeUpdate();
                        if (i!=0){
                            out.println("<html><body>Records have been inserted<br>\n</body></html>");
                            
                        } else{
                            out.println("<html><body>Inserting records get failure<br>\n</body></html>");
                            
                        }
                        //rs.close();
                        pstmt.close();

            // Clean-up environment
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        }
        //Message for the correct insertion of the project
        session.setAttribute("insertproj","Your project is inserted successfully!" );
        response.sendRedirect("responsetwo.jsp");
        //RequestDispatcher view = request.getRequestDispatcher("responsetwo.jsp");
        //view.forward(request, response);
        //session.setAttribute("TName",tname);        
        }
}
