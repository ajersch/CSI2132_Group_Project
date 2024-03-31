<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %>
<%@ page import="backend.ChainService" %>
<%@ page import="backend.Chain" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:11 PM
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
    ChainService chainService = new ChainService();
    List<Chain> chains = chainService.getAllChains();

    String function = request.getParameter("submit");
    Hotel hotel = null;

    if (function == null) {
        response.sendRedirect("employee-hotel-manager.jsp");
        return;
    }

    int hotelId = request.getParameter("hotel_id") == null ? -1 : Integer.parseInt(request.getParameter("hotel_id"));

    if (function.equals("update")) {
        HotelService hotelService = new HotelService();
        hotel = hotelService.getHotel(hotelId);
    }

    Integer streetNumber = hotel == null ? null : hotel.getStreetNumber();
    String streetName = hotel == null ? "" : hotel.getStreetName();
    String city = hotel == null ? "" : hotel.getCity();
    String country = hotel == null ? "" : hotel.getCountry();
    String chainName = hotel == null ? "" : hotel.getChainName();
    String name = hotel == null ? "" : hotel.getName();
    Integer stars = hotel == null ? null : hotel.getStars();

%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Update Hotel</title>
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
        <h1 class="title">Update Hotel Info</h1>
    </div>
</div>
<form action="controller-hotel.jsp" method="POST">
    <label for="street_number">Street Number:</label>
    <input type="number" id="street_number" name="street_number" value="<%= streetNumber %>" required>
    <br>

    <label for="street_name">Street Name:</label>
    <input type="text" id="street_name" name="street_name" value="<%= streetName %>" required>
    <br>

    <label for="city">City:</label>
    <input type="text" id="city" name="city" value="<%= city %>" required>
    <br>

    <label for="country">Country:</label>
    <input type="text" id="country" name="country" value="<%= country %>" required>
    <br>

    <label for="chain_name">Chain:</label>
    <select id="chain_name" name="chain_name" required>
        <% for (Chain chain : chains) { %>
        <option value="<%= chain.getName() %>" <%= chain.getName().equals(chainName) ? "selected" : "" %>><%= chain.getName() %></option>
        <% } %>
    </select>
    <br>

    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%= name %>" required>
    <br>

    <label for="stars">Stars:</label>
    <input type="number" id="stars" name="stars" value="<%= stars %>" required>
    <br>

    <input type="hidden" name="hotel_id" value="<%= hotelId %>">

    <input type="submit" name="submit" value="<%= function %>">
</form>
</body>
</html>
