<%@ page import="backend.Booking" %>
<%@ page import="backend.BookingService" %>
<%@ page import="backend.Employee" %>
<%@ page import="backend.Customer" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String function = request.getParameter("submit");

    if (function == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    else if (function.equals("pay")) {
        Employee employee = (Employee) session.getAttribute("user");

        Booking booking = new Booking(
                Integer.parseInt(request.getParameter("room_id")),
                request.getParameter("start"),
                request.getParameter("end"),
                Integer.parseInt(request.getParameter("customer_sin"))
        );

        BookingService bookingService = new BookingService();
        bookingService.createBooking(booking);
        bookingService.checkIn(booking, employee.getSin());

        request.setAttribute("payed", "payed");
        request.getRequestDispatcher("employee-check-in.jsp").forward(request, response);
    }

    else if (function.equals("customer_add")) {
        Customer customer = (Customer) session.getAttribute("user");

        Booking booking = new Booking(
                Integer.parseInt(request.getParameter("room_id")),
                request.getParameter("start"),
                request.getParameter("end"),
                customer.getSin()
        );

        BookingService bookingService = new BookingService();
        bookingService.createBooking(booking);

        response.sendRedirect("customer-booking-manager.jsp");
    }

    else if (function.equals("customer_delete")) {
        System.out.println("delete");
        Customer customer = (Customer) session.getAttribute("user");

        int roomId = Integer.parseInt(request.getParameter("room_id"));
        String start = request.getParameter("start");

        BookingService bookingService = new BookingService();
        bookingService.deleteBooking(roomId, start);

        response.sendRedirect("customer-booking-manager.jsp");
    }
%>
