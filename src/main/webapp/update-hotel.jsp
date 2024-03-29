<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %>
<%@ page import="backend.ChainService" %>
<%@ page import="backend.Chain" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:11 PM
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
    ChainService chainService = new ChainService();
    List<Chain> chains = chainService.getAllChains();

    String function = request.getParameter("submit");
    Hotel hotel = null;

    if (function == null) {
        response.sendRedirect("employee-hotel-manager.jsp");
        return;
    }

    int hotelId = request.getParameter("hotel_id") == null ? -1 : Integer.parseInt(request.getParameter("hotel_id"));

    if (function.equals("update")) {
        HotelService hotelService = new HotelService();
        hotel = hotelService.getHotel(hotelId);
    }

    Integer streetNumber = hotel == null ? null : hotel.getStreetNumber();
    String streetName = hotel == null ? "" : hotel.getStreetName();
    String city = hotel == null ? "" : hotel.getCity();
    String country = hotel == null ? "" : hotel.getCountry();
    String chainName = hotel == null ? "" : hotel.getChainName();
    String name = hotel == null ? "" : hotel.getName();
    Integer stars = hotel == null ? null : hotel.getStars();

%>
<html>
<head>
    <title>Update/Insert Hotel</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="controller-hotel.jsp" method="POST">
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

    <label for="chain_name">Chain:</label>
    <select id="chain_name" name="chain_name" required>
        <% for (Chain chain : chains) { %>
        <option value="<%= chain.getName() %>" <%= chain.getName().equals(chainName) ? "selected" : "" %>><%= chain.getName() %></option>
        <% } %>
    </select>
    <br>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%= name %>" required>
    <br>

    <label for="stars">Stars:</label>
    <input type="number" id="stars" name="stars" value="<%= stars %>" required>
    <br>

    <input type="hidden" name="hotel_id" value="<%= hotelId %>">

    <input type="submit" name="submit" value="<%= function %>">
</form>
</body>
</html>
