<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 8:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ########################### CUSTOMER VALIDATION ###########################
    if (session.getAttribute("user") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

    if (session.getAttribute("userType") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

    if (!session.getAttribute("userType").equals("customer")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Room Search</title>
    <link rel="stylesheet" href="not-ugly.css">
</head>
<body>
<form action="customer-room-search-results.jsp" method="POST">
    <label for="start">Start date:</label>
    <input type="date" id="start" name="start" required>
    <br>

    <label for="end">End date:</label>
    <input type="date" id="end" name="end" required>
    <br>

    <label for="capacity">Capacity:</label>
    <select id="capacity" name="capacity">
        <option value="0" selected>Select capacity</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
    </select>
    <br>

    <label for="stars">Stars:</label>
    <select id="stars" name="stars">
        <option value="0">Select stars</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
    </select>
    <br>

    <label for="city">City:</label>
    <input type="text" id="city" name="city">
    <br>

    <label for="chain">Chain:</label>
    <input type="text" id="chain" name="chain">
    <br>

    <label for="min_rooms">Min rooms in hotel:</label>
    <input type="number" id="min_rooms" name="min_rooms">
    <br>

    <label for="min_price">Min Price:</label>
    <input type="number" id="min_price" name="min_price">
    <br>

    <label for="max_price">Max Price:</label>
    <input type="number" id="max_price" name="max_price">
    <br>

    <input type="checkbox" id="extendable" name="extendable" value="extendable">
    <label for="extendable">Extendable</label>
    <br>

    <input type="submit" name="submit" value="search">
</form>
</body>
</html>
