<%@ page import="backend.SessionService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/28/2024
  Time: 1:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
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
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Customer Home</title>
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
        <h1 class="title">Customer Home</h1>
    </div>
</div>
<div class="container">
    <div class="grid is-gap-5">
        <div class="cell button is-link is-light">
            <a href="customer-room-search.jsp">Search for a room</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="customer-booking-manager.jsp">My Bookings</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</div>
</body>
</html>
