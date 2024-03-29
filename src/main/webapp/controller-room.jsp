<%@ page import="backend.Room" %>
<%@ page import="backend.RoomService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String function = request.getParameter("submit");

    if (function == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    else if (function.equals("add")) {
        Room room = new Room(
                Integer.parseInt(request.getParameter("hotel_id")),
                Float.parseFloat(request.getParameter("price")),
                Integer.parseInt(request.getParameter("capacity")),
                request.getParameter("extendable") != null,
                Integer.parseInt(request.getParameter("room_number"))
        );

        RoomService roomService = new RoomService();
        roomService.createRoom(room);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("update")) {
        Room room = new Room(
                Integer.parseInt(request.getParameter("room_id")),
                Integer.parseInt(request.getParameter("hotel_id")),
                Float.parseFloat(request.getParameter("price")),
                Integer.parseInt(request.getParameter("capacity")),
                Boolean.parseBoolean(request.getParameter("extendable")),
                Integer.parseInt(request.getParameter("room_number")),
                false
        );

        RoomService roomService = new RoomService();
        roomService.updateRoom(room);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("delete")) {
        int id = Integer.parseInt(request.getParameter("room_id"));

        RoomService roomService = new RoomService();
        roomService.deleteRoom(id);

        response.sendRedirect(request.getHeader("referer"));
    }

%>