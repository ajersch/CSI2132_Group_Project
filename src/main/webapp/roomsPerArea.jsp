<%@ page import="backend.Pair" %>
<%@ page import="backend.RoomService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    RoomService rs = new RoomService();
    List<Pair<String, Integer>> roomsPerArea = rs.getRoomsInArea();
%>
<html>
<head>
    <title>ACR Rooms Per Area</title>
</head>
<body>
<table>
    <tr>
        <th>City</th>
        <th>Number of Rooms</th>
    </tr>
    <% for (Pair<String, Integer> pair : roomsPerArea) { %>
    <tr>
        <td> <%= pair.getFirst() %> </td>
        <td> <%= pair.getSecond() %> </td>
    </tr>
    <% } %>
</table>
</body>
</html>
