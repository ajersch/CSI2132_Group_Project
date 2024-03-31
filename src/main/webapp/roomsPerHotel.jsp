<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="backend.HotelService" %>
<%@ page import="backend.Pair" %>
<%@ page import="java.util.List" %>

<%
    HotelService hs = new HotelService();
    List<Pair<String, Integer>> roomsPerHotel = hs.getRoomsPerHotel();
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Rooms per Hotel</title>
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
        <h1 class="title">Rooms by Hotel</h1>
    </div>
</div>
<table>
    <tr>
        <th>Hotel Name</th>
        <th>Number of Rooms</th>
    </tr>
    <% for (Pair<String, Integer> pair : roomsPerHotel) { %>
        <tr>
            <td> <%= pair.getFirst() %> </td>
            <td> <%= pair.getSecond() %> </td>
        </tr>
    <% } %>
</table>
</body>
</html>
