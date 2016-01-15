<%-- 
    Document   :index
    Created on : Dec 17, 2015
    Author     : Kosmidou Maria
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Login Page</title>
    
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    //invalidate the session if exists
    //session = request.getSession(false);
    //if((session.getAttribute("user") == "makosmid")){
       /* response.sendRedirect("responsetwo.jsp");
    }
    if((session.getAttribute("user") != null)){
        response.sendRedirect("response.jsp");
    }*/

    //no session? clear cookies
    Cookie[] cook = request.getCookies();
    if(cook!=null){
        for (int i = 0; i < cook.length; i++) {
            cook[i].setMaxAge(0);
            response.addCookie(cook[i]);
        }
    }
%>      
    <br><br>
    <h2 align="center" style="font-size: 250%;color: white;"><strong>Welcome to the BSC finder!</strong></h2>
    <div class="container">
        <!-- Message if the login is failed -->
        <%
            String authCheck=(String) request.getAttribute("error");
            if(null!=authCheck) {
        %>
        <div align=center id="findpass" class="animated shake"><%=authCheck%></div>
        <%
            }
        %>
        <form name="loginform" id="loginform" align="center" method="post" action="login.do" class="form-horizontal">
            <div class="form">
            <div class="forceColor"></div>
            <div class="topbar">
            <div class="spanColor"></div>
                <input type="text" class="input" id="input" name="username" placeholder="Username" value="" required />
                <input type="password" class="input" id="input" name="pass" placeholder="Password"  value="" required />
            </div>
            <button class="submit" id="submit" type="submit" >Login</button>
            <br>
            <button type="reset" class="submit">Reset</button>
            </div>
            <br><br>
        </form> 
    </div> <!-- /container -->
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
</body>
</html>