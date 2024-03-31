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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Renting Manager</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">
</head>
<body>
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="index.jsp">
      <p class="button is-info"><strong>ACR Bookings</strong></p>
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-start">

      <div class="navbar-item has-dropdown is-hoverable">
              <a class="navbar-link" href="home-customer.jsp">
                Customer Features
              </a>

              <div class="navbar-dropdown">
                <a class="navbar-item" href="customer-room-search.jsp">
                  Search Rooms
                </a>
                <a class="navbar-item is-selected" href="customer-booking-manager.jsp">
                  Manage Bookings
                </a>
              </div>
            </div>

      <div class="navbar-item has-dropdown is-hoverable">
        <a class="navbar-link" href="home-employee.jsp">
          Employee Features
        </a>

        <div class="navbar-dropdown">
          <a class="navbar-item" href="employee-customer-manager.jsp">
            Manage Customers
          </a>
          <a class="navbar-item is-selected" href="employee-employee-manager.jsp">
            Manage Employees
          </a>
          <a class="navbar-item" href="employee-hotel-manager.jsp">
            Manage Hotels
          </a>
          <a class="navbar-item" href="employee-chain-manager.jsp">
            Manage Chains
          </a>
        </div>
      </div>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <a class="button is-primary" href="register-customer.jsp">
            <strong>Register</strong>
          </a>
          <a class="button is-link" href="index.jsp">
            Log in
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>
<section class="hero is-info">
  <div class="hero-body">
    <p class="title">ACR Bookings</p>
    <p class="subtitle">Travel the world with ACR</p>
  </div>
</section>
<div class="box">
    <div class="container">
        <h1 class="title">Renting Manager</h1>
        <h1 class="subtitle">Create, Delete, and Edit room rentals.</h1>
    </div>
</div>
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
                <form action="employee-payment-manager.jsp" method="post">
                    <input type="hidden" name="room_id" value="<%= room.getRoomId() %>">
                    <input type="hidden" name="start" value="<%= start %>">
                    <input type="hidden" name="end" value="<%= end %>">
                    <input type="hidden" name="price" value="<%= room.getPrice() %>">
                    <input type="submit" name="submit" value="book">
                </form>
            </td>
        </tr>
    <% } %>
</table>
</body>