<%@ page import="backend.SessionService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/28/2024
  Time: 1:36 PM
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
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Employee Home</title>
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
        <h1 class="title">Employee Home</h1>
    </div>
</div>
<div class="container">
    <div class="grid is-gap-5">
        <div class="cell button is-link is-light">
            <a href="employee-check-in.jsp">Check In Page</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="roomsPerArea.jsp">Rooms Per Area</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="roomsPerHotel.jsp">Rooms Per Hotel</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-chain-manager.jsp">Chain Manager</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-hotel-manager.jsp">Hotel Manager</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-room-manager.jsp">Room Manager</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-employee-manager.jsp">Employee Manager</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-customer-manager.jsp">Customer Manager</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="employee-room-search.jsp">Room Search</a>
        </div>
        <div class="cell button is-link is-light">
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</div>

</body>
</html>
