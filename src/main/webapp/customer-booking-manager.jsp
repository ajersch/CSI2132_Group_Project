<%@ page import="java.util.List" %>
<%@ page import="backend.*" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/30/2024
  Time: 3:51 PM
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
    Customer customer = (Customer) session.getAttribute("user");
    HotelService hotelService = new HotelService();
    RoomService roomService = new RoomService();

    BookingService bookingService = new BookingService();
    List<Booking> bookings = bookingService.getCustomerBookings(customer.getSin());
%>
<html>
<head>
    <title>Bookings</title>
</head>
<body>
<button onclick="window.location.href='customer-room-search.jsp'">Add</button>
<table>
    <tr>
        <th>Hotel Name</th>
        <th>Room Number</th>
        <th>Check In Date</th>
        <th>Check Out Date</th>
        <th>Price</th>
    </tr>
    <% for (Booking booking : bookings) {
    Room room = roomService.getRoom(booking.getRoomId());
    Hotel hotel = hotelService.getHotel(room.getHotelId());
    %>
    <tr>
        <td><%= hotel.getName() %></td>
        <td><%= room.getRoomNumber() %></td>
        <td><%= booking.getStartDate() %></td>
        <td><%= booking.getEndDate() %></td>
        <td><%= room.getPrice() %></td>
        <td>
            <form action="controller-booking.jsp" method="post">
                <input type="hidden" name="room_id" value="<%= booking.getRoomId() %>">
                <input type="hidden" name="start" value="<%= booking.getStartDate() %>">
                <input type="hidden" name="submit" value="customer_delete">
                <input type="submit" name="not_submit" value="Remove Booking">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
