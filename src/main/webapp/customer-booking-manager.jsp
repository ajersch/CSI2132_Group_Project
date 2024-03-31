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
        return;
    }

    if (session.getAttribute("userType") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

    if (!session.getAttribute("userType").equals("customer")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings</title>
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
        <a class="navbar-link">
            Find Rooms
        </a>

        <div class="navbar-dropdown">
            <a class="navbar-item" href="customer-room-search.jsp">
                Search Rooms
            </a>
            <a class="navbar-item" href="roomsPerHotel.jsp">
                Rooms by Hotel
            </a>
            <a class="navbar-item" href="roomsPerArea.jsp">
                Rooms by Area
            </a>
        </div>
      </div>

        <a class="navbar-item" href="customer-booking-manager.jsp">
            My Bookings
        </a>
    </div>

    <div class="navbar-end">
    <a class="navbar-item" href="logout.jsp">
        Log out
    </a>
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
        <h1 class="title">Booking Manager</h1>
        <h1 class="subtitle">View your upcoming room reservations.</h1>
    </div>
</div>

<div class="section">
    <button class="button is-link" onclick="window.location.href='customer-room-search.jsp'">Add</button>
    <div class="table-section">
        <table class="table">
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
                        <input class="button is-danger is-rounded" type="submit" name="not_submit" value="Remove Booking">
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
