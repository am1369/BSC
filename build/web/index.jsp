<%-- 
    Document   :index
    Created on : Dec 17, 2015
    Author     : kosmima
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="el">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>Login form</title>
    
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>

    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
  
    
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

        <%
            //invalidate the session if exists
            session = request.getSession(false);
            if((session.getAttribute("user") == "makosmid")){
                response.sendRedirect("responsetwo.jsp");
            }
            if((session.getAttribute("user") != null)){
                response.sendRedirect("response.jsp");
            }
            
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
    <h2 align="center" style="font-size: 250%;color: white;"><strong>Welcome!</strong></h2>
    <div class="container">
                    <%
                        String authCheck=(String) request.getAttribute("error");
                        if(null!=authCheck) {
                    %>
                    <div align=center id="findpass" class=" animated shake"><%=authCheck%></div>
                    <%
                        }
                    %>

    
        
        <form name="loginform" id="loginform" align="center" method="post" action="login.do" class="form-horizontal">
            <div class="form">
            <div class="forceColor"></div>
            <div class="topbar">
            <div class="spanColor"></div>
                <input type="text" class="input" id="input" name="uname" placeholder="Username" value="" required />
                <input type="password" class="input" id="input" placeholder="Password" name="pass" value="" required />
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
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- Latest compiled and minified JavaScript -->
    <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->
</body>
</html>