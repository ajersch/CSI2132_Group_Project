<%@ page import="backend.RoomService" %>
<%@ page import="backend.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // ########################### EMPLOYEE VALIDATION ###########################
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

    if (!session.getAttribute("userType").equals("employee")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }
%>

<%
    HotelService hotelService = new HotelService();

    RoomService roomService = new RoomService();
    List<Room> rooms = roomService.getAllRooms();
%>
<html>
<head>
    <title>Room Manager</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="update-room.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>

<table>
    <tr>
        <th>Room Number</th>
        <th>Hotel</th>
        <th>Price</th>
        <th>Capacity</th>
        <th>Extendable</th>
    </tr>
    <% for (Room room : rooms) {
    Hotel hotel = hotelService.getHotel(room.getHotelId());
    %>
    <tr>
        <td><%= room.getRoomNumber() %></td>
        <td><%= hotel.getName() %></td>
        <td><%= room.getPrice() %></td>
        <td><%= room.getCapacity() %></td>
        <td><%= room.isExtendable() ? "Yes" : "No" %></td>
        <td>
            <form action="update-room.jsp" method="POST">
                <input type="hidden" name="room_id" value="<%= room.getRoomId() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-room.jsp" method="POST">
                <input type="hidden" name="room_id" value="<%= room.getRoomId() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
