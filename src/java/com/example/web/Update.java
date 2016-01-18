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

public class Update extends HttpServlet{
                // private static final long serialVersionUID = 1L;
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
        String myusername = (String) session.getAttribute("user");
        //String affil = (String) session.getAttribute("affil");
        String affiliation = (String) session.getAttribute("eduPersonAffiliation");
        
        // Execute SQL query
        try {
                        stmt = conn.createStatement();
                        //db query for current user
                        rs = stmt.executeQuery("SELECT * FROM bsctable WHERE username='"+myusername +"'");
                        while(rs.next()){
                                    //get them from the db
                                    String namesql = rs.getString("name");
                                    String mailsql = rs.getString("email");
                                    String departmentsql = rs.getString("department");
                                    int yearsql = rs.getInt("year");

                                    out.println("<html><body>Name from sql: "+namesql+"\n</body></html>");
                                    out.println("<html><body>Year from sql: "+yearsql+"\n</body></html>");
                                    out.println("<html><body>Mail from sql: "+mailsql+"\n</body></html>");
                                    out.println("<html><body>Department from sql: "+departmentsql+"\n</body></html>");
                                    
                                    //if(affiliation.equals("student")){
                                    if(affiliation.equals("student")){
                                            request.setCharacterEncoding("UTF-8");
                                            String namenew = request.getParameter("name");
                                            String mailnew = request.getParameter("mail");
                                            String departmentnew = request.getParameter("department");
                                            int yearnew = Integer.parseInt(request.getParameter("year"));
                                            
                                            out.println("<html><body>User: "+myusername+"\n</body></html>");
                                            out.println("<html><body>Name: "+namenew+"\n</body></html>");
                                            out.println("<html><body>Year: "+yearnew+"\n</body></html>");
                                            out.println("<html><body>Mail: "+mailnew+"\n</body></html>");
                                            out.println("<html><body>Department: "+departmentnew+"\n</body></html>");
                                            out.println("<html><body>Affil: "+affiliation+"\n</body></html>");

                                            pstmt = conn.prepareStatement("UPDATE bsctable SET email=?, name=?, department=?, year=? WHERE username=? " );
                                            pstmt.setString(1, mailnew =="" ? mailsql : mailnew );
                                            pstmt.setString(2, namenew =="" ? namesql : namenew);
                                            pstmt.setString(3, departmentnew =="" ? departmentsql : departmentnew);
                                            pstmt.setInt(4, yearnew ==0 ? yearsql : yearnew);
                                            pstmt.setString(5, myusername);

                                            int i= pstmt.executeUpdate();
                                            if (i!=0){
                                                out.println("<html><body>Records have been inserted<br>\n</body></html>");

                                            } else{
                                                out.println("<html><body>Inserting records get failure<br>\n</body></html>");

                                            }
                                            rs.close();
                                            pstmt.close();
                                    }else{
                                            request.setCharacterEncoding("UTF-8");
                                            String namenew = request.getParameter("name");
                                            String mailnew = request.getParameter("mail");
                                            String departmentnew = request.getParameter("department");
                                            
                                            out.println("<html><body>User: "+myusername+"\n</body></html>");
                                            out.println("<html><body>Name: "+namenew+"\n</body></html>");
                                            out.println("<html><body>Mail: "+mailnew+"\n</body></html>");
                                            out.println("<html><body>Department: "+departmentnew+"\n</body></html>");
                                            out.println("<html><body>Affil: "+affiliation+"\n</body></html>");
                                            
                                            pstmt = conn.prepareStatement("UPDATE bsctable SET email=?, name=?, department=? WHERE username=? " );
                                            pstmt.setString(1, mailnew =="" ? mailsql : mailnew );
                                            pstmt.setString(2, namenew =="" ? namesql : namenew);
                                            pstmt.setString(3, departmentnew =="" ? departmentsql : departmentnew);
                                            pstmt.setString(4, myusername);

                                            int i= pstmt.executeUpdate();
                                            if (i!=0){
                                                out.println("<html><body>Records have been inserted<br>\n</body></html>");

                                            } else{
                                                out.println("<html><body>Inserting records get failure<br>\n</body></html>");

                                            }
                                            rs.close();
                                            pstmt.close();
                                    }
                        }
            // Clean-up environment
        } catch (SQLException se ) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        }
        //Message for the successfully update of data
        session.setAttribute("update","Your info are updated" );
        //if(myusername.equals("makosmid")){
        if(affiliation.equals("student")){   
            response.sendRedirect("response.jsp");
           //request.setCharacterEncoding("UTF-8");
           //request.getRequestDispatcher("responsetwo.jsp").forward(request, response);
                                   
        }else{
            response.sendRedirect("responsetwo.jsp");
            //request.setCharacterEncoding("UTF-8");            
            //RequestDispatcher view = request.getRequestDispatcher("response.jsp");
            //view.forward(request, response);
        }
        session.setAttribute("update","");
        }
}

    

