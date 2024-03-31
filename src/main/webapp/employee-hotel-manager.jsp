<%@ page import="backend.HotelService" %>
<%@ page import="backend.Hotel" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 1:56 PM
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
    HotelService hotelService = new HotelService();
    List<Hotel> hotels = hotelService.getAllHotels();
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Hotel Manager</title>
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
        <h1 class="title">Hotel Manager</h1>
        <h1 class="subtitle">Create, Delete, and Edit hotels</h1>
    </div>
</div>
<form action="update-hotel.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>

<table>
    <tr>
        <th>Street Number</th>
        <th>Street Name</th>
        <th>City</th>
        <th>Country</th>
        <th>Chain</th>
        <th>Name</th>
        <th>Stars</th>
    </tr>
    <% for (Hotel hotel : hotels) { %>
    <tr>
        <td><%= hotel.getStreetNumber() %></td>
        <td><%= hotel.getStreetName() %></td>
        <td><%= hotel.getCity() %></td>
        <td><%= hotel.getCountry() %></td>
        <td><%= hotel.getChainName() %></td>
        <td><%= hotel.getName() %></td>
        <td><%= hotel.getStars() %></td>
        <td>
            <form action="update-hotel.jsp" method="POST">
                <input type="hidden" name="hotel_id" value="<%= hotel.getId() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-hotel.jsp" method="POST">
                <input type="hidden" name="hotel_id" value="<%= hotel.getId() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
