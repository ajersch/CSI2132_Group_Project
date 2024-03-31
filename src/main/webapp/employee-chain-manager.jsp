<%@ page import="backend.ChainService" %>
<%@ page import="backend.Chain" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 12:55 PM
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
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Chain Updates</title>
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
                    <a class="navbar-link" >
                      Find Rooms
                    </a>

                    <div class="navbar-dropdown">
                      <a class="navbar-item" href="employee-room-search.jsp">
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

            <div class="navbar-item has-dropdown is-hoverable">
              <a class="navbar-link">
                Manage...
              </a>

              <div class="navbar-dropdown">
                <a class="navbar-item" href="employee-customer-manager.jsp">
                  Manage Customers
                </a>
                <a class="navbar-item" href="employee-employee-manager.jsp">
                  Manage Employees
                </a>
                <a class="navbar-item" href="employee-room-manager.jsp">
                    Manage Rooms
                </a>
                <a class="navbar-item" href="employee-hotel-manager.jsp">
                  Manage Hotels
                </a>
                <a class="navbar-item" href="employee-chain-manager.jsp">
                  Manage Chains
                </a>
                <a class="navbar-item" href="employee-renting-manager.jsp">
                    Manage Rentings
                </a>
              </div>
            </div>
            <a class="navbar-item" href="employee-check-in.jsp">
                Check-In
            </a>
          </div>
          <a class="navbar-item" href="logout.jsp">
            Log out
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
        <h1 class="title">Chain Manager</h1>
        <h1 class="subtitle">Add, Edit, and Delete hotel chains.</h1>
    </div>
</div>
<div class="section">
    <form action="update-chain.jsp" method="POST">
        <input class="button is-link" type="submit" name="submit" value="add">
    </form>
    <div class="table-section">
        <table class="table">
            <tr>
                <th>Street Number</th>
                <th>Street Name</th>
                <th>City</th>
                <th>Country</th>
                <th>Name</th>
                <th>Archived</th>
            </tr>
            <% for (Chain chain : chains) { %>
            <tr>
                <td><%= chain.getStreetNumber() %></td>
                <td><%= chain.getStreetName() %></td>
                <td><%= chain.getCity() %></td>
                <td><%= chain.getCountry() %></td>
                <td><%= chain.getName() %></td>
                <td><%= chain.isArchived() %></td>
                <td>
                    <form action="update-chain.jsp" method="post">
                        <input type="hidden" name="street_number" value="<%= chain.getStreetNumber() %>">
                        <input type="hidden" name="street_name" value="<%= chain.getStreetName() %>">
                        <input type="hidden" name="city" value="<%= chain.getCity() %>">
                        <input type="hidden" name="country" value="<%= chain.getCountry() %>">
                        <input type="hidden" name="name" value="<%= chain.getName() %>">
                        <input class="button is-link is-light is-rounded" type="submit" name="submit" value="update">
                    </form>
                </td>
                <td>
                    <form action="controller-chain.jsp" method="POST">
                        <input type="hidden" name="name" value="<%= chain.getName() %>">
                        <input class="button is-danger is-rounded" type="submit" name="submit" value="delete">
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
