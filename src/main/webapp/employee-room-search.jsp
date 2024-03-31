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
        <h1 class="title">Room Search</h1>
        <h1 class="subtitle">Find available rooms to book.</h1>
    </div>
</div>

<div class="section">
    <form action="employee-renting-manager.jsp" method="POST">
        <label class="label" for="start">Start date:</label>
        <input class="input" type="date" id="start" name="start" required>
        <br>

        <label class="label" for="end">End date:</label>
        <input class="input" type="date" id="end" name="end" required>
        <br>

        <label class="label" for="capacity">Capacity:</label>
        <div class="select">
            <select class="input" id="capacity" name="capacity">
                <option value="0" selected>Select capacity</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
        </div>
        <br>

        <label class="label" for="stars">Stars:</label>
        <div class="select">
            <select id="stars" name="stars">
                <option value="0">Select stars</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
        <br>

        <label class="label" for="city">City:</label>
        <input class="input" type="text" id="city" name="city">
        <br>

        <label class="label" for="chain">Chain:</label>
        <input class="input" type="text" id="chain" name="chain">
        <br>

        <label class="label" for="min_rooms">Min rooms in hotel:</label>
        <input class="input" type="number" id="min_rooms" name="min_rooms">
        <br>

        <label class="label" for="min_price">Min Price:</label>
        <input class="input" type="number" id="min_price" name="min_price">
        <br>

        <label class="label" for="max_price">Max Price:</label>
        <input class="input" type="number" id="max_price" name="max_price">
        <br>
        <br>

        <label class="label" for="extendable">Extendable</label>
        <input type="checkbox" id="extendable" name="extendable" value="extendable">
        <br>

        <input class="button is-link" type="submit" name="submit" value="search">
    </form>
</div>
</body>
</html>
