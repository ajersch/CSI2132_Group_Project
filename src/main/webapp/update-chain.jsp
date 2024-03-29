<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 1:40 PM
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

<%
    String function = request.getParameter("submit");

    if (function == null) {
        response.sendRedirect("employee-chain-manager.jsp");
    }

    String name = request.getParameter("name") == null ? "" : request.getParameter("name");
    String streetNumber = request.getParameter("street_number") == null ? "" : request.getParameter("street_number");
    String streetName = request.getParameter("street_name") == null ? "" : request.getParameter("street_name");
    String city = request.getParameter("city") == null ? "" : request.getParameter("city");
    String country = request.getParameter("country") == null ? "" : request.getParameter("country");

%>
<html>
<head>
    <title>Update/Insert Chain</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="controller-chain.jsp" method="POST">
    <input type="hidden" id="name" name="name" value="<%= name %>">

    <label for="street_number">Street Number:</label>
    <input type="number" id="street_number" name="street_number" value="<%= streetNumber %>" required>
    <br>

    <label for="street_name">Street Name:</label>
    <input type="text" id="street_name" name="street_name" value="<%= streetName %>" required>
    <br>

    <label for="city">City:</label>
    <input type="text" id="city" name="city" value="<%= city %>" required>
    <br>

    <label for="country">Country:</label>
    <input type="text" id="country" name="country" value="<%= country %>" required>
    <br>

    <input type="submit" name="submit" value="<%= function %>" required>
</form>
</body>
</html>
