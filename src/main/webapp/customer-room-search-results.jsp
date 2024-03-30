<%@ page import="backend.BookingService" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.Room" %>
<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %><%--
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

<%
    String function = request.getParameter("submit");

    if (function == null || !function.equals("search")) {
        response.sendRedirect("home-employee.jsp");
        return;
    }

    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String chainName = request.getParameter("chain").isEmpty() ? null : request.getParameter("chain");
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    int stars = Integer.parseInt(request.getParameter("stars"));
    String city = request.getParameter("city").isEmpty() ? null : request.getParameter("city");
    int minRooms = request.getParameter("min_rooms").isEmpty() ? 0 : Integer.parseInt(request.getParameter("min_rooms"));
    float minPrice = request.getParameter("min_price").isEmpty() ? 0 : Float.parseFloat(request.getParameter("min_price"));
    float maxPrice = request.getParameter("max_price").isEmpty() ? 0 : Float.parseFloat(request.getParameter("max_price"));
    boolean extendable = request.getParameter("extendable") != null;

    HotelService hotelService = new HotelService();
    BookingService bookingService = new BookingService();
    List<Room> bookings = bookingService.searchRooms(
            start,
            end,
            chainName,
            city,
            capacity,
            stars,
            minRooms,
            minPrice,
            maxPrice,
            extendable
    );
%>
<html>
<head>
    <title>Room Search</title>
    <link rel="stylesheet" href="not-ugly.css">
</head>
<body>
<table>
    <tr>
        <th>Chain</th>
        <th>Hotel</th>
        <th>Room Number</th>
        <th>City</th>
        <th>Capacity</th>
        <th>Stars</th>
        <th>Price</th>
        <th>Extendable</th>
    </tr>
    <% for (Room room : bookings) {
        Hotel hotel = hotelService.getHotel(room.getHotelId());
    %>
    <tr>
        <td><%= hotel.getChainName() %></td>
        <td><%= hotel.getName() %></td>
        <td><%= room.getRoomNumber() %></td>
        <td><%= hotel.getCity()%></td>
        <td><%= room.getCapacity() %></td>
        <td><%= hotel.getStars() %></td>
        <td><%= room.getPrice() %></td>
        <td><%= room.isExtendable() ? "Yes" : "No" %></td>
        <td>
            <form action="controller-booking.jsp" method="post">
                <input type="hidden" name="room_id" value="<%= room.getRoomId() %>">
                <input type="hidden" name="start" value="<%= start %>">
                <input type="hidden" name="end" value="<%= end %>">
                <input type="hidden" name="submit" value="customer_add">
                <input type="submit" name="not_submit" value="add">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>