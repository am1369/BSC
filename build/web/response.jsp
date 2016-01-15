<%-- 
    Document   : student
    Created on : Dec 17, 2015
    Author     : kosmima
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">
    
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Student's Page</title>
    <!-- BOOTSTRAP STYLE SHEET -->
    <link href="css/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT-AWESOME STYLE SHEET FOR BEAUTIFUL ICONS -->
    <link href="css/assets/css/font-awesome.css" rel="stylesheet" />

    
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/animate.css">
    
</head>
<body>
      <%
            //allow access only if session exists
            String user = null;
            String name = null ;
            String mail = null ;
            String affil = null ;
            if ((session.getAttribute("user") == null)) {
                response.sendRedirect("index.jsp");
            } else {
                user = (String) session.getAttribute("user");
                name = (String) session.getAttribute("cn");
                mail = (String) session.getAttribute("mail");
                affil = (String) session.getAttribute("eduPersonAffiliation"); 
            }
            String userName = null;
            String sessionID = null;
            Cookie[] cookies = request.getCookies();
            if(cookies !=null){
                for(Cookie cookie : cookies){
                    if(cookie.getName().equals("user")) userName = cookie.getValue();
                    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
                }
            }
           String username=(String) session.getAttribute("username");
           ResultSet rs = (ResultSet) request.getAttribute("rs");
           
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
          <%String updateCheck=(String) session.getAttribute("update");%>
    
    <div class="container">
        <!-- Fixed navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="response.jsp"><strong>Profile</strong></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav navbar-right">
                <li class="active"><a href="logout.do">Log out <span class="sr-only">(current)</span></a></li>
              </ul>
            </div><!--/.nav-collapse -->
          </div>
        </nav>
    </div>
    <div class="container">  
        <section style="padding-bottom: 50px; padding-top: 50px;">
            <div class="row">
                <br>
                <h2 align="center" style="font-size: 250%; font-family: 'Raleway'; color:white;">Welcome,<%=user%></h2>
                <br>
                <div class="col-md-4">
                    <img src="css/assets/img/blank-avatar1.png" class="img-rounded img-responsive" />
                    <br />
                    <br />
                    <h3 style="color: white;">Search for the project you want</h3>
                    <br />
                        <form action=" nextjsp.jsp" method="get">
                            <table style="border-collapse: separate; border-spacing: 15px;">
                                <tr>
                                    <td><select name="select_type" class="selectpicker">
                                    <option value="none" selected='true'>Select Type</option>

                                    <c:forEach var="row1" items="${result1.rows}">
                                        <c:choose>
                                            <c:when test="${row1.Type==0}">

                                                <option value="${row1.Type}"> ΔΙΠΛΩΜΑΤΙΚΗ</option>
                                            </c:when>
                                            <c:when test="${row1.Type==1}">

                                                <option value="${row1.Type}"> ΜΕΤΑΠΤΥΧΙΑΚH</option>
                                            </c:when>
                                            <c:when test="${row1.Type==2}">

                                                <option value="${row1.Type}"> ΔΙΔΑΚΤΟΡΙΚH</option>
                                            </c:when>
                                        </c:choose>

                                    </c:forEach>
                                        </select></td>
                                        <td><select name="select_year">
                                    <option value="none" selected='true'>Select Year</option>
                                    <c:forEach var="row1" items="${result2.rows}">
                                            <option value="${row1.Year}">${row1.Year}</option>
                                    </c:forEach>
                                            </select></td>
                                </tr>
                                <tr>
                                            <td><select name="select_department">
                                    <option value="none" selected='true'>Select Department</option>
                                    <c:forEach var="row1" items="${result3.rows}">
                                            <option value="${row1.Department}">${row1.Department}</option>
                                    </c:forEach>
                                                </select></td>
                                                <td><select name="select_tname">
                                    <option value="none" selected='true'>Select Teacher</option>
                                    <c:forEach var="row1" items="${result4.rows}">
                                            <option value="${row1.TName}">${row1.TName}</option>
                                    </c:forEach>
                                                    </select></td>
                                </tr>
                                <tr>
                                    <td><button type="submit" class="btn btn-success submit">Submit</button></td>
                                </tr>
                            </table>
                        </form>
                        
                        <br>
                </div>
                <form action="edit.jsp" method="post">
                <div class="col-md-8">
                    <div class="alert alert-info">
                        <h2>Profile </h2>
                        <h4>Your info are: </h4>
                        <table>
                               <c:forEach var="row" items="${result.rows}">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.name}">
                                                <td><strong>Name:</strong> ${row.name}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Name:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.username}">
                                                <td><strong>Username:</strong> ${row.username}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Username:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.email}">
                                                <td><strong>Mail:</strong> ${row.email}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Mail:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.department}">
                                                <td><strong>Department:</strong> ${row.department}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Department:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.year}">
                                                <td><strong>Year of starting your courses:</strong> ${row.year}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Year of starting your courses:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${not empty row.affiliation}">
                                                <td><strong>Activity:</strong> ${row.affiliation}</td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td><strong>Activity:</strong> -- </td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                </c:forEach>
                            </table>
                        <%if(null!=updateCheck) { updateCheck="UPDATED";%>
                            <div style="color: red;"><h5><%=updateCheck%></h5></div>
                        <%}else{ updateCheck="NOT UPDATED";%>
                            <div style="color: red;"><h5><%=updateCheck%></h5></div>
                       <%}%>
                    </div>
                    <button class="btn btn-success submit" type="submit" >Update profile</button>
                </div>
                </form>
                    <div class="form-group col-md-8">
                        
                        <%--<form action="logout.do" method="get">
                            <button type="submit" class="submit">Log out</button>
                            <br>
                        </form>--%>
                </div>
            </div>
            <!-- ROW END -->
        </section>
        <!-- SECTION END -->
    </div>
    <footer class="footer" style="color: graytext;">
        <div class="container">
        <p class="pull-right"><a href="#" style="color: white;">Back to top</a></p>
        <p class="text-muted">&copy; 2016 WWW-University of Thessaly &middot; <a href="#" style="color: white;">Kosmidou Maria</a></p>
        </div>
    </footer>
    <!-- CONATINER END -->
    <!-- REQUIRED SCRIPTS FILES -->
        <!-- CORE JQUERY FILE -->
        <script src="css/assets/js/jquery-1.11.1.js"></script>
        <!-- REQUIRED BOOTSTRAP SCRIPTS -->
        <script src="css/assets/js/bootstrap.js"></script>


      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    
</body> 
</html>
