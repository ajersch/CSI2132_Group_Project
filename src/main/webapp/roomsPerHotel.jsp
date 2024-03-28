<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/27/2024
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="backend.HotelService" %>
<%@ page import="backend.Pair" %>
<%@ page import="java.util.List" %>

<%
    HotelService hs = new HotelService();
    List<Pair<String, Integer>> roomsPerHotel = hs.getRoomsPerHotel();
%>
<html>
<head>
    <title>ACR Rooms Per Hotel</title>
</head>
<body>
<table>
    <tr>
        <th>Hotel Name</th>
        <th>Number of Rooms</th>
    </tr>
    <% for (Pair<String, Integer> pair : roomsPerHotel) { %>
        <tr>
            <td> <%= pair.getFirst() %> </td>
            <td> <%= pair.getSecond() %> </td>
        </tr>
    <% } %>
</table>
</body>
</html>
