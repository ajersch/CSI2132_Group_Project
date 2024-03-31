<%--
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
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Room Search</title>
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
        <h1 class="title">Room Search</h1>
        <h1 class="subtitle">Find available rooms to book.</h1>
    </div>
</div>
    <form action="employee-renting-manager.jsp" method="POST">
        <label for="start">Start date:</label>
        <input type="date" id="start" name="start" required>
        <br>

        <label for="end">End date:</label>
        <input type="date" id="end" name="end" required>
        <br>

        <label for="capacity">Capacity:</label>
        <select id="capacity" name="capacity">
            <option value="0" selected>Select capacity</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
        </select>
        <br>

        <label for="stars">Stars:</label>
        <select id="stars" name="stars">
            <option value="0">Select stars</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
        <br>

        <label for="city">City:</label>
        <input type="text" id="city" name="city">
        <br>

        <label for="chain">Chain:</label>
        <input type="text" id="chain" name="chain">
        <br>

        <label for="min_rooms">Min rooms in hotel:</label>
        <input type="number" id="min_rooms" name="min_rooms">
        <br>

        <label for="min_price">Min Price:</label>
        <input type="number" id="min_price" name="min_price">
        <br>

        <label for="max_price">Max Price:</label>
        <input type="number" id="max_price" name="max_price">
        <br>

        <input type="checkbox" id="extendable" name="extendable" value="extendable">
        <label for="extendable">Extendable</label>
        <br>

        <input type="submit" name="submit" value="search">
    </form>
</body>
</html>
