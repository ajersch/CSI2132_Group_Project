<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 1:56 PM
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
    HotelService hotelService = new HotelService();
    List<Hotel> hotels = hotelService.getAllHotels();
%>

<html>
<head>
    <title>Hotel Manager</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">

</head>
<body>
<form action="update-hotel.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>

<table>
    <tr>
        <th>Street Number</th>
        <th>Street Name</th>
        <th>City</th>
        <th>Country</th>
        <th>Chain</th>
        <th>Name</th>
        <th>Stars</th>
    </tr>
    <% for (Hotel hotel : hotels) { %>
    <tr>
        <td><%= hotel.getStreetNumber() %></td>
        <td><%= hotel.getStreetName() %></td>
        <td><%= hotel.getCity() %></td>
        <td><%= hotel.getCountry() %></td>
        <td><%= hotel.getChainName() %></td>
        <td><%= hotel.getName() %></td>
        <td><%= hotel.getStars() %></td>
        <td>
            <form action="update-hotel.jsp" method="POST">
                <input type="hidden" name="hotel_id" value="<%= hotel.getId() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-hotel.jsp" method="POST">
                <input type="hidden" name="hotel_id" value="<%= hotel.getId() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
