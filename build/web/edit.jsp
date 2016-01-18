<%-- 
    Document   : edit
    Created on : Jan 7, 2016, 9:27:32 PM
    Author     : kosmima
--%>
<!DOCTYPE html>
<html>
<head>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css"> 
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Update profile</title>
    <!-- BOOTSTRAP STYLE SHEET -->
    <link href="css/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT-AWESOME STYLE SHEET FOR BEAUTIFUL ICONS -->
    <link href="css/assets/css/font-awesome.css" rel="stylesheet" />
     <!-- CUSTOM STYLE CSS -->
     
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/animate.css">
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
    <div class="container">
        <!-- Fixed navbar -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
          <div class="container">
            <div class="navbar-header">
                <% if(affil.equals("student")){%>
                    <a class="navbar-brand" href="response.jsp"><strong>Profile</strong></a>
                <%}else{%>
                    <a class="navbar-brand" href="responsetwo.jsp"><strong>Profile</strong></a>
                <% }%>
            </div>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group-sm">
                  <input type="text" class="form-control" placeholder="Search">
                  <button type="submit" class="btn btn-sm">Go</button>
                </div>
                </form>
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
                <h2 align="center" style="font-size: 250%;color: white;">Edit your profile,<%=user%></h2>
                <br>
                <div class="col-sm-offset-0">
                    <br />
                    <form name="loginform" id="loginform" method="post" action="do.update">   
                        <label style="color: graytext;">Change your name </label>
                        <input type="text" class="form-control" id="input" name="name" placeholder="Name" value=""/>
                        <br>
                        <label style="color: graytext;">Change your mail </label>
                        <input type="text" class="form-control" id="input" name="mail" placeholder="E-mail" value=""/>
                        <br>
                        <% if(affil.equals("student")){%>
                            <label style="color: graytext;">Confirm the year of starting your courses </label>
                            <input type="number" class="form-control" id="input"name="year" min="2006" max="" placeholder="Year" value="" required/>
                            <br>
                        <%}%>
                        <label style="color: graytext;">Insert your department </label>
                        <input type="text" class="form-control" id="input" name="department" placeholder="Department" value=""/>
                        <br>
                        
                        <button class="btn btn-success submit"  type="submit" >Update</button>
                        <button class="btn btn-success submit" type="reset" >Reset</button>
                        <br>
                    </form>
                 <br/>
                </div>
            </div>
        </section>
    </div>
    <br>
    
    <%--<form action="logout.do" method="get">
        <button type="submit" class="submit">Log out</button>
    </form>--%>
    <footer class="footer" style="color: graytext;">
        <div class="container">
        <p class="pull-right"><a href="#" style="color: white;">Back to top</a></p>
        <p class="text-muted">&copy; 2016 WWW-University of Thessaly &middot; <a href="#" style="color: white;">Kosmidou Maria</a></p>
        </div>
    </footer>
    <!-- REQUIRED SCRIPTS FILES -->
    <!-- CORE JQUERY FILE -->
   <script src="css/assets/js/jquery-1.11.1.js"></script>
   <!-- REQUIRED BOOTSTRAP SCRIPTS -->
   <script src="css/assets/js/bootstrap.js"></script>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</body>
</html>
