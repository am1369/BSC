<%-- 
    Document   : results
    Created on : Jan 7, 2016, 9:27:32 PM
    Author     : kosmima
--%>


<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Result Page</title>
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>

<link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="css/animate.css">
 
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">  
  </head>

  <body>

        
            <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                url="jdbc:mysql://localhost/bscfinder_db"
                user="root"  password="k0sm1m@6256"/>

<sql:query var="result" dataSource="${snapshot}">
         
    SELECT * from projects as s 
    
    <c:choose>
        <c:when test="${param.select_type !='none'}">
            WHERE s.Type = ${param.select_type}
        </c:when>
        <c:otherwise>
            WHERE s.Type IS NOT NULL
        </c:otherwise>
    </c:choose>
    <c:if test="${param.select_year !='none'}">
           AND s.Year = ${param.select_year}
    </c:if>
    <c:if test="${param.select_department !='none'}">
           AND s.Department = '${param.select_department}'
    </c:if>
    <c:if test="${param.select_tname !='none'}">
           AND s.TName = '${param.select_tname}'
    </c:if>
          
   
</sql:query>
        
        <br><br>
    
                        <h2 align="center" style="font-size: 250%;color: white;"><strong>The results are:</strong></h2>
                       
                      
                            <div class="normal">
                             <table>
                        <tbody>   
                            <c:forEach var="row2" items="${result.rows}">
                            <c:set var="flag"  value="${1}"/>
                    
                <tr>
                <br>
                    <td><strong>Bachelor Title: </strong></td>
                    <td><strong>${row2.Title}<strong></td>
                        </tr>
                        <tr>

                            <td><strong>Teacher's Name: </strong></td>
                            <td>${row2.TName}<br>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Student's Name: </strong></td>
                            <td>${row2.SName} </td>
                        </tr>

                </c:forEach>
                        
                <c:if test="${flag!=1}" >
                    <td><strong>Nothing found .Try again </strong></td>
                </c:if>        
            </tbody>
        </table>
         <br><br>
        <!-- <a href="responsetwo.jsp">Go Back</a> -->
        <button onclick="goBack()"><strong>Go Back</strong></button>

          </div>
                                                    
                        <br><br><br><br>
    <div class="normal">
                            <br><br>
                            <form action="logout.do" method="get">
                                <button type="submit" class="submit">Log out</button>
                            </form>
                      
    </div>
        <script>
            function goBack() {
                window.history.back();
                //(window).bind("pageshow", function() { // update hidden input field $('#formid')[0].reset(); });
            }
        </script>
                 
                        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <!-- Latest compiled and minified JavaScript -->
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->
    </body>
</html>
