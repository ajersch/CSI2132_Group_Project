<%@ page import="backend.Hotel" %>
<%@ page import="backend.HotelService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 1:33 PM
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
        Hotel hotel = new Hotel(
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("chain_name"),
                request.getParameter("name"),
                Integer.parseInt(request.getParameter("stars"))
        );

        HotelService hotelService = new HotelService();
        hotelService.createHotel(hotel);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("update")) {
        Hotel hotel = new Hotel(
                Integer.parseInt(request.getParameter("hotel_id")),
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("chain_name"),
                request.getParameter("name"),
                Integer.parseInt(request.getParameter("stars")),
                false
        );

        HotelService hotelService = new HotelService();
        hotelService.updateHotel(hotel);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("delete")) {
        int id = Integer.parseInt(request.getParameter("hotel_id"));

        HotelService hotelService = new HotelService();
        hotelService.deleteHotel(id);

        response.sendRedirect(request.getHeader("referer"));
    }

%>