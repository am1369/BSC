<%-- 
    Document   : response
    Created on : Dec 17, 2015
    Author     : kosmima
--%>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
           //ResultSet rs1 = (ResultSet) request.getAttribute("rs1");
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
    <h2 align="center" style="font-size: 250%; font-family: 'Raleway'; color:white;">Welcome,<%=user%></h2>
          <%
                          String updateCheck=(String) request.getAttribute("update");
                          if(null!=updateCheck) {
                      %>
                      <div align=center class="animated shake"><%=updateCheck%></div>
                      <%
                          }
                          //updateCheck=null;
                      %>
              
    <div class="container">
        <section style="padding-bottom: 50px; padding-top: 50px;">
            <div class="row">
                <div class="col-md-4">
                    <img src="css/assets/img/blank-avatar.png" class="img-rounded img-responsive" />
                    <br />
                    <br />
                   <!-- 
                    <label>Registered Username</label>
                    <input type="text" class="form-control" placeholder="Demouser">
                    <label>Registered Name</label>
                    <input type="text" class="form-control" placeholder="Jhon Deo">
                    <label>Registered Email</label>
                    <input type="text" class="form-control" placeholder="jnondeao@gmail.com">
                    <br>
                    <a href="#" class="btn btn-success">Update Details</a>
                   -->
                    <br /><br/>
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
                        <h3>Search for the project you want</h3>
                        <br />
                        
                        <form action=" nextjsp.jsp" method="get">
                           
                            <select name="select_type" class="selectpicker">
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
                      
                      

                      
                    <%--  <div class="form">
                              <div class="forceColor"></div>
                              <div class="topbar">
                                  <h2 align="center" style="font-size: 250%;color: white;"><strong>Your info are:</strong></h2>
                                  <%--<div class ="normal">
                                  <table>
                                      <tbody>


                                 <tr>
                                 <td>Username:<%=user%></td>
                             </tr>
                             <tr>
                                  <br>
                                  <td>Name: <%=name%></td>
                                  </tr>
                                  <tr>
                                  <br>
                                  <td>Mail: <%=mail%></td>
          </tr>
          <tr>
                                  <br>
                                  <td>Type: <%=affil%></td>
          </tr>



                             </tbody>
                                  </table>
          </div>--%><%--
                              <div class="normal">
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
              </div>
              </div>

                              <br><br><br>                   
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
                              <h2>Hello</h2>                
              <form action="logout.do" method="get">

                      <button type="submit" class="submit">Log out</button>

                      <a href="edit.jsp">Edit</a>
                      <%=username%>
                      <%=user%>


              </form> --%>
                                  <script type='text/javascript'>
                                    $('.selectpicker').selectpicker({
                                    style: 'btn-info',
                                    size: 4
                                    });
                                  </script>
                                  
</body> 
</html>
