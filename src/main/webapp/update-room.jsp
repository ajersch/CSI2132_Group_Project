<%@ page import="backend.Room" %>
<%@ page import="backend.RoomService" %>
<%@ page import="backend.Hotel" %>
<%@ page import="backend.HotelService" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:54 PM
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
    Room room = null;

    if (function == null) {
        response.sendRedirect("employee-room-manager.jsp");
        return;
    }

    int RoomId = request.getParameter("room_id") == null ? -1 : Integer.parseInt(request.getParameter("room_id"));

    HotelService hotelService = new HotelService();
    List<Hotel> hotels = hotelService.getAllHotels();

    if (function.equals("update")) {
        RoomService roomService = new RoomService();
        room = roomService.getRoom(RoomId);
    }

    Integer hotelId = room == null ? null : room.getHotelId();
    Float price = room == null ? null : room.getPrice();
    Integer capacity = room == null ? null : room.getCapacity();
    boolean extendable = room != null && room.isExtendable();
    Integer roomNumber = room == null ? null : room.getRoomNumber();
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Update Room</title>
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
        <h1 class="title">Update Room Info</h1>
    </div>
</div>
<form action="controller-room.jsp" method="POST">
    <input type="hidden" name="room_id" value="<%= RoomId %>">

    <label for="price">Price:</label>
    <input type="number" id="price" name="price" value="<%= price %>" required>
    <br>

    <label for="capacity">Capacity:</label>
    <input type="number" id="capacity" name="capacity" value="<%= capacity %>" required>
    <br>

    <label for="extendable">Extendable:</label>
    <input type="checkbox" id="extendable" name="extendable" value="<%= extendable %>" checked="<%= extendable ? "checked" : "unchecked" %>">
    <br>

    <label for="room_number">Room Number:</label>
    <input type="number" id="room_number" name="room_number" value="<%= roomNumber %>" required>
    <br>

    <label for="hotel_id">Hotel:</label>
    <select id="hotel_id" name="hotel_id" required>
        <% for (Hotel hotel : hotels) { %>
        <option value="<%= hotel.getId() %>" <%= room != null && room.getHotelId() == hotel.getId() ? "selected" : "" %>><%= hotel.getName() %></option>
        <% } %>
    </select>
    <br>

    <input type="submit" name="submit" value="<%= function %>">
</form>
</body>
</html>
