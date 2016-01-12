<%-- 
    Document   : responsetwo
    Created on : Jan 7, 2016, 9:27:32 PM
    Author     : kosmima
--%>
<!DOCTYPE html>
<html>
<head>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Teacher's Profile</title>
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
            //boolean authenticate=Authservlet.auth;
            //if((authenticate==false)&& (session.getAttribute("user") == null)){
            %>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost/bscfinder_db"
            user="root"  password="kosmima"/>
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
    <h2 align="center" style="font-size: 250%; color: white;">Welcome,<%=user%></h2>
    <div class="container">
        <section style="padding-bottom: 50px; padding-top: 50px;">
            <div class="row">
                <div class="col-md-4">
                    <img src="css/assets/img/blank-avatar.png" class="img-rounded img-responsive" />
                    <br />
                    <br />
                  <!--
                  <form name="loginform" id="loginform" align="center" method="post" action="teacher.do">
                        <div class="form">
                            <div class="forceColor"></div>
                            <div class="topbar">
                            <div class="spanColor"></div>
                                <input type="text" class="input" id="input" name="title" placeholder="Title" value="" required />
                                <input type="text" class="input" id="input" placeholder="Department" name="department" value="" required />
                                <input type="number" class="input" id="input" min="2015" max="" placeholder="Year" name="year" value="" required />
                                <input type="number" class="input" id="input" min="0" max="2" placeholder="Type" name="type" value="" required />
                                <!--<input type="checkbox"> Remember me-->
                            <!--</div>
                            <button class="submit" id="submit" type="submit" >Insert</button>
                            <br>
                            <button type="reset" class="submit">Reset</button>
                        </div>
                        <br><br>
                    </form>-->
                <form name="loginform" id="loginform" align="center" method="post" action="teacher.do">   
                <label>Insert Title </label>
                <input type="text" class="form-control" id="input" name="title" placeholder="Title" value="" required />
                <label>Insert Department </label>
                <input type="text" class="form-control" id="input" name="department" placeholder="Department" value="" required />
                <label>Insert Year </label>
                <input type="number" class="form-control" id="input" min="2015" max="" name="year" placeholder="Year" value="" required />
                <label>Insert Type </label>
                <input type="number" class="form-control" id="input" min="0" max="2" name="type" placeholder="Type" name="type" value="" required />
                <label>Insert Info </label>
                <input type="text" class="form-control" id="input" name="info" placeholder="Info" value=""  />
                <label>Insert Link </label>
                <input type="text" class="form-control" id="input" name="link" placeholder="Link" value=""  />
                <br>
                <a href="#" class="btn btn-success">Insert the project</a>
                <button class="submit" id="submit" type="submit" >Insert</button>
                <br>
                <button type="reset" class="submit">Reset</button>
                </form>

                <br/>
                </div>
                <div class="col-md-8">
                    <div class="alert alert-info">
                        <h2>Profile </h2>
                        <h4>Your info are: </h4>
                        <table>
                                <c:forEach var="row" items="${result.rows}">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${row.username==''}">
                                                <td>Username: -- </td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td>Username: ${row.username}</td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${row.affiliation==''}">
                                                <td>Type: -- </td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td>Type: ${row.affiliation}</td>
                                            </c:otherwise>
                                        </c:choose>

                                    </tr>
                                    <tr>
                                        <c:choose>
                                            <c:when test="${row.email==''}">
                                                <td>Mail: -- </td>
                                            </c:when> 
                                            <c:otherwise>
                                                <td>Mail: ${row.email}</td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>

                                </c:forEach>
                            </table>
                    </div>
                    
                    <div class="form-group col-md-8">
                        <h3 style="color:white;">Search for the project you want</h3>
                        <br />
                        
                        <form action=" nextjsp.jsp" method="get" accept-charset="UTF-8">
                            <select name="select_type">
                                <option value="none" selected='true'>Select Type</option>
                                <c:forEach var="row1" items="${result1.rows}">
                                    <c:choose>
                                        <c:when test="${row1.Type==0}">

                                            <option value="${row1.Type}">ΔΙΠΛΩΜΑΤΙΚΗ</option>
                                        </c:when>
                                        <c:when test="${row1.Type==1}">

                                            <option value="${row1.Type}"> ΜΕΤΑΠΤΥΧΙΑΚH</option>
                                        </c:when>
                                        <c:when test="${row1.Type==2}">

                                            <option value="${row1.Type}"> ΔΙΔΑΚΤΟΡΙΚH</option>
                                        </c:when>
                                    </c:choose>

                                </c:forEach>
                            </select>
                            <select name="select_year">
                                <option value="none" selected='true'>Select Year</option>
                                <c:forEach var="row1" items="${result2.rows}">
                                        <option value="${row1.Year}">${row1.Year}</option>
                                </c:forEach>
                            </select> 
                            <select name="select_department">
                                <option value="none" selected='true'>Select Department</option>
                                <c:forEach var="row1" items="${result3.rows}">
                                        <option value="${row1.Department}">${row1.Department}</option>
                                </c:forEach>
                            </select>
                            <select name="select_tname">
                                <option value="none" selected='true'>Select a Teacher</option>
                                <c:forEach var="row1" items="${result4.rows}">
                                        <option value="${row1.TName}">${row1.TName}</option>
                                </c:forEach>
                            </select>  

                            <br><br><br><br>    
                            <button type="submit" class="submit">Submit</button>    
                        </form>
                        <a href="edit.jsp" class="btn btn-warning">Edit</a>
                        <br>
                        <form action="logout.do" method="get">
                            <button type="submit" class="submit">Log out</button>
                            <br>
                            
                        </form>
                        <!--<label>Enter Old Password</label>
                        <input type="password" class="form-control">
                        <label>Enter New Password</label>
                        <input type="password" class="form-control">
                        <label>Confirm New Password</label>
                        <input type="password" class="form-control" />
                        <br>
                        <a href="#" class="btn btn-warning">Change Password</a>-->
                        
                    </div>
                </div>
            </div>
            <!-- ROW END -->
        </section>
        <!-- SECTION END -->
    </div>
    <!-- CONATINER END -->

                               <%--   <h2 align="center" style="font-size: 250%;color: white;"><strong>Your info are:</strong></h2>
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

                                            </div>

                      <form name="loginform" id="loginform" align="center" method="post" action="teacher.do">
                          <div class="form">
                              <div class="forceColor"></div>
                              <div class="topbar">
                                <div class="spanColor"></div>
                                  <input type="text" class="input" id="input" name="title" placeholder="Title" value="" required />
                                  <input type="text" class="input" id="input" placeholder="Department" name="department" value="" required />
                                  <input type="number" class="input" id="input" min="2015" max="" placeholder="Year" name="year" value="" required />
                                  <input type="number" class="input" id="input" min="0" max="2" placeholder="Type" name="type" value="" required />
                                  <!--<input type="checkbox"> Remember me-->
                              </div>
                              <button class="submit" id="submit" type="submit" >Insert</button>
                              <br>
                              <button type="reset" class="submit">Reset</button>
                          </div>

                          <br><br>

                      </form>
                                  <div normal><form action=" nextjsp.jsp" method="get">
                                  <select name="select_type">
                                     <option value="none" selected='true'>Select a Type</option>
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
                                 </select>
                                  <select name="select_year">
                                     <option value="none" selected='true'>Select a Year</option>
                                     <c:forEach var="row1" items="${result2.rows}">
                                              <option value="${row1.Year}">${row1.Year}</option>
                                     </c:forEach>
                                 </select> 
                                      <select name="select_department">
                                     <option value="none" selected='true'>Select a Department</option>
                                     <c:forEach var="row1" items="${result3.rows}">
                                              <option value="${row1.Department}">${row1.Department}</option>
                                     </c:forEach>
                                 </select>
                                      <select name="select_tname">
                                     <option value="none" selected='true'>Select a Teacher</option>
                                     <c:forEach var="row1" items="${result4.rows}">
                                              <option value="${row1.TName}">${row1.TName}</option>
                                     </c:forEach>
                                 </select>  

                               <br><br><br><br><br><br><br>    
                              <button type="submit" class="submit">Submit</button>    
                              </form>
                              </div>
                              <br>    

              <form action="logout.do" method="get">

                      <button type="submit" class="submit">Log out</button>
                      <%=username%>
                      <%=user%>


              </form> --%>
                               
        <!-- REQUIRED SCRIPTS FILES -->
        <!-- CORE JQUERY FILE -->
        <script src="css/assets/js/jquery-1.11.1.js"></script>
        <!-- REQUIRED BOOTSTRAP SCRIPTS -->
        <script src="css/assets/js/bootstrap.js"></script>


      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
      <!-- Include all compiled plugins (below), or include individual files as needed -->
      <!-- Latest compiled and minified JavaScript -->
      <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->
</body>
</html>
