/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

/**
 *
 * @author kosmima
 */


import java.io.*;
import static java.lang.System.out;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import static com.example.web.Authservlet.session;


public class Teacher extends HttpServlet {
    
                private final static String DB = "jdbc:mysql://localhost:3306/bscfinder_db";
                private final static String DBUSER = "root";
                private final static String DBPSW = "kosmima";
    
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
                    //stmt = conn.createStatement();
                    
                    
                    //db query for current user
                    
                    //HttpSession session;
            
            //String sql;
            //sql = "SELECT  id,brand_name,gas,laundry,address,latitube, longitude FROM gas_station\n" +
                   // "    GROUP BY brand_name";
            //ResultSet rs = stmt.executeQuery(sql);
                    
                    //session = request.getSession();
                    
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
                            out.println("<html><body>Title: "+title+"\n</body></html>");
                        } else{
                            out.println("<html><body>Inserting records get failure<br>\n</body></html>");
                            out.println("<html><body>TTTitle: "+title+"\n</body></html>");
                        }
                        rs = pstmt.executeQuery("SELECT * FROM projects ");
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
        //RequestDispatcher view = request.getRequestDispatcher("responsetwo.jsp");
        //view.forward(request, response);
        //session.setAttribute("TName",tname);
                
        }
}
