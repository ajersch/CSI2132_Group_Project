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
    if (session.getAttribute("user") == null) {
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
    <title>Employee Home</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<a href="employee-check-in.jsp">Check In Page</a>
<br>
<a href="roomsPerArea.jsp">Rooms Per Area</a>
<br>
<a href="roomsPerHotel.jsp">Rooms Per Hotel</a>
<br>
<a href="employee-chain-manager.jsp">Chain Manager</a>
<br>
<a href="employee-hotel-manager.jsp">Hotel Manager</a>
<br>
<a href="employee-room-manager.jsp">Room Manager</a>
<br>
<a href="employee-employee-manager.jsp">Employee Manager</a>
<br>
<a href="employee-customer-manager.jsp">Customer Manager</a>
<br>
<a href="employee-room-search.jsp">Room Search</a>

</body>
</html>
