<%-- 
    Document   : final
    Created on : Jan 7, 2016, 9:27:32 PM
    Author     : kosmima
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">  
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Message</title>
    <!-- BOOTSTRAP STYLE SHEET -->
    <link href="css/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT-AWESOME STYLE SHEET FOR BEAUTIFUL ICONS -->
    <link href="css/assets/css/font-awesome.css" rel="stylesheet" />

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
            
    <%String title=(String) session.getAttribute("title");%>
    <%String Check=(String) request.getAttribute("check");%>
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
                <h2 align="center" style="font-size: 250%;color: white;">Confirmation</h2>
                <br>
                    <div class="col-md-offset-0">
                        <div class="alert alert-success">
                            <form action='do.student' method='post'>
                                <%if((null!=Check)&&(title!=null)) {%>
                                <h4 style="color: graytext">You checked the project with the title: <strong><%=title%></strong></h4>
                                <% } %>
                                <h4> <%=Check%> </h4>
                            </form>
                            <br>
                        <!-- <a href="responsetwo.jsp">Go Back</a> -->
                        </div>
                        <%--<% if(user.equals("pkoutsovasilis")){%>    
                        <a href="response.jsp" class="btn btn-warning">Go to profile</a>
                        <%}else{%>
                        <a href="responsetwo.jsp" class="btn btn-warning">Go to profile</a>
                        <%}%>--%>
                        <button onclick="goBack()" class="btn btn-default">Go Back</button>
                        <br>
                        <%--<form action="logout.do" method="get">
                            <button type="submit" class="submit">Log out</button>
                        </form>--%>
                    </div>
                </div>
            </section>
        </div>
        
        <script>
            function goBack() {
            window.history.back();
            //(window).bind("pageshow", function() { // update hidden input field $('#formid')[0].reset(); });
            }
        </script>
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
