<%@ page import="backend.SessionService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/28/2024
  Time: 1:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ########################### EMPLOYEE VALIDATION ###########################
    if (session.getAttribute("sin") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    if (session.getAttribute("userType") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    if (!session.getAttribute("userType").equals("employee")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="checkIn.jsp">Check In Page</a>
<br>
<a href="roomsPerArea.jsp">Rooms Per Area</a>
<br>
<a href="roomsPerHotel.jsp">Rooms Per Hotel</a>
</body>
</html>
