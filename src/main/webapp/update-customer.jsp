<%@ page import="backend.CustomerService" %>
<%@ page import="backend.Customer" %>
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
    String function = request.getParameter("submit");

    if (function == null) {
        response.sendRedirect("employee-customer-manager.jsp");
        return;
    }
    CustomerService customerService = new CustomerService();
    Customer customer = "customer".equals(session.getAttribute("userType")) ?  (Customer) session.getAttribute("user") : customerService.getCustomer(Integer.parseInt(request.getParameter("sin")));
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Update Customer</title>
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
        <h1 class="title">Update Customer Info</h1>
    </div>
</div>
<form action="controller-customer.jsp" method="POST">
    <label for="first_name">First Name:</label>
    <input type="text" name="first_name" id="first_name" value="<%= customer.getFirstName() %>" required>
    <br>

    <label for="last_name">Last Name:</label>
    <input type="text" name="last_name" id="last_name" value="<%= customer.getLastName() %>" required>
    <br>

    <label for="street_number">Street Number:</label>
    <input type="number" name="street_number" id="street_number" value="<%= customer.getStreetNumber() %>" required>
    <br>

    <label for="street_name">Street Name:</label>
    <input type="text" name="street_name" id="street_name" value="<%= customer.getStreetName() %>" required>
    <br>

    <label for="city">City:</label>
    <input type="text" name="city" id="city" value="<%= customer.getCity() %>" required>
    <br>

    <label for="country">Country:</label>
    <input type="text" name="country" id="country" value="<%= customer.getCountry() %>" required>
    <br>

    <label for="registration_date">Date:</label>
    <input type="date" name="registration_date" id="registration_date" value="<%= customer.getRegistrationDate() %>" required>
    <br>

    <input type="hidden" name="sin" value="<%= customer.getSin() %>">

    <input type="submit" name="submit" value="update">
</form>
</body>
</html>