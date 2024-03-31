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
            <a class="navbar-item" href="roomsPerArea.jsp">
                Rooms Per Area
            </a>
          <a class="navbar-item" href="roomsPerHotel.jsp">
            Rooms per Hotel
          </a>
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

<div class="section">
    <div class="table-section">
        <table class="table">
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
    </div>
</div>
</body>
</html>
