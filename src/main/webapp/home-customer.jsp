<%@ page import="backend.SessionService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/28/2024
  Time: 1:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("user") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    if (session.getAttribute("userType") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    if (!session.getAttribute("userType").equals("customer")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>
<html>
<head>
    <title>Customer Home</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<a href="customer-room-search.jsp">Search for a room</a>
<br>
<a href="customer-booking-manager.jsp">My Bookings</a>
<br>
<a href="customer-profile.jsp">My Profile</a>
<br>
<a href="logout.jsp">Logout</a>
<br>
</body>
</html>
