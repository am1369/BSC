<%-- 
    Document   : responsetwo
    Created on : Jan 7, 2016, 9:27:32 PM
    Author     : kosmima
--%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    
    <title>Edit page</title>
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>

<link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="css/animate.css">
 
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">  
  </head>

  <body>

        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            }
         
                String user = (String) session.getAttribute("user");
                String name = (String) session.getAttribute("cn");
                String mail = (String) session.getAttribute("mail");
                String affil = (String) session.getAttribute("eduPersonAffiliation"); 
            
String username=(String) session.getAttribute("username");
           
            String userName = null;
            String sessionID = null;
            Cookie[] cookies = request.getCookies();
            if(cookies !=null){
                for(Cookie cookie : cookies){
                    if(cookie.getName().equals("user")) userName = cookie.getValue();
                    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
                }
            }
            //boolean authenticate=Authservlet.auth;
            //if((authenticate==false)&& (session.getAttribute("user") == null)){
            %>
        <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                url="jdbc:mysql://localhost/bscfinder_db"
                user="root"  password="k0sm1m@6256"/>
      <sql:query  var="result" dataSource="${snapshot}">
            SELECT * from bsctable WHERE username='${user}'
            
      </sql:query>
            
      <sql:query  var="result1" dataSource="${snapshot}">
            
            SELECT * from projects
            GROUP BY Type
      </sql:query>      
      <sql:query  var="result2" dataSource="${snapshot}">
            
            SELECT * from projects
            GROUP BY Year
      </sql:query>   
            <sql:query  var="result3" dataSource="${snapshot}">
            
            SELECT * from projects
            GROUP BY Department
      </sql:query>
            <sql:query  var="result4" dataSource="${snapshot}">
            
            SELECT * from projects
            GROUP BY TName
      </sql:query>
        <br><br>
    <h2 align="center" style="font-size: 250%;color: white;"><strong>Edit your profile,<%=user%></strong></h2>
                
                              
                                    <%--<h2 align="center" style="font-size: 250%;color: white;"><strong>Your info are:</strong></h2>
                                     <div class="normal">
                                    <table>
                               <c:forEach var="row" items="${result.rows}">
                                   <tr>
                                   <td>Username: ${row.username}</td>
                                   </tr>
                                   <tr>
                                   <td>Type: ${row.affiliation}</td>
                                   </tr>
                                   <tr>
                                   <td>Mail: ${row.email}</td>
                                   </tr>
                                   
                               </c:forEach>
                                    </table>
                           
                                              </div>--%>
                        
                        <form name="loginform" id="loginform" align="center" method="post" action="student.do">
                            <div class="form">
                                <div class="forceColor"></div>
                                <div class="topbar">
                                  <div class="spanColor"></div>
                                    
                                    <input type="text" class="input" id="input" placeholder="FirstName" name="fname" value=""  />
                                    <input type="text" class="input" id="input"  placeholder="LastName" name="lname" value=""  />
                                    <input type="text" class="input" id="input"  placeholder="Mail" name="mail" value=""  />
                                    <!--<input type="text" class="input" id="input" min="2006" max="" placeholder="Year" name="year" value="" required />-->
                                    <!--<input type="checkbox"> Remember me-->
                                </div>
                                <button class="submit" id="submit" type="submit" >Insert</button>
                                <br>
                                <button type="reset" class="submit">Reset</button>
                            </div>
    
                            <br><br>
                            
                        </form>
                              
                                <br>    
                                
                <form action="logout.do" method="get">
                    
                        <button type="submit" class="submit">Log out</button>
                        <%=username%>
                        <%=user%>

                       
                </form> 
                        
   
                        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <!-- Latest compiled and minified JavaScript -->
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->
    </body>
</html>
