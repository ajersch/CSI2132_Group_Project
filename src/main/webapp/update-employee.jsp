<%@ page import="backend.Employee" %>
<%@ page import="backend.EmployeeService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 7:18 PM
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
    String function = request.getParameter("function");
    Employee employee = null;

    if (function == null) {
        response.sendRedirect("employee-employee-manager.jsp");
        return;
    }

    int employeeSin = request.getParameter("employeeSin") == null ? -1 : Integer.parseInt(request.getParameter("employee_sin"));

    if (function.equals("update")) {
        EmployeeService employeeService = new EmployeeService();
        employee = employeeService.getEmployee(employeeSin);
    }

    String firstName = employee == null ? "" : employee.getFirstName();
    String lastName = employee == null ? "" : employee.getLastName();
    Integer streetNumber = employee == null ? null : employee.getStreetNumber();
    String streetName = employee == null ? "" : employee.getStreetName();
    String city = employee == null ? "" : employee.getCity();
    String country = employee == null ? "" : employee.getCountry();
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Update Employee</title>
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
        <h1 class="title">Update Employee Info</h1>
    </div>
</div>
<form action="controller-employee.jsp" method="POST">
    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" value="<%= firstName %>" required>
    <br>

    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" value="<%= lastName %>" required>
    <br>

    <label for="streetNumber">Street Number:</label>
    <input type="number" id="streetNumber" name="streetNumber" value="<%= streetNumber %>" required>
    <br>

    <label for="streetName">Street Name:</label>
    <input type="text" id="streetName" name="streetName" value="<%= streetName %>" required>
    <br>

    <label for="city">City:</label>
    <input type="text" id="city" name="city" value="<%= city %>" required>
    <br>

    <label for="country">Country:</label>
    <input type="text" id="country" name="country" value="<%= country %>" required>
    <br>

    <input type="hidden" name="employee_sin" value="<%= employeeSin %>">

    <input type="submit" name="submit" value="<%= function %>">
</form>
</body>
</html>
