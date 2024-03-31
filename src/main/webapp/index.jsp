<%@ page import="backend.CustomerService" %>
<%@ page import="backend.EmployeeService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
if (request.getParameter("login") != null && request.getParameter("login").equals("login")) {
    CustomerService cs = new CustomerService();
    EmployeeService es = new EmployeeService();

    String userType = request.getParameter("user-type");

    if ("customer".equals(userType) && cs.isCustomer(Integer.parseInt(request.getParameter("SIN")))) {
        session.setAttribute("user", cs.getCustomer(Integer.parseInt(request.getParameter("SIN"))));
        session.setAttribute("userType", request.getParameter("user-type"));
        response.sendRedirect("home-" + request.getParameter("user-type") + ".jsp");
    }
    if ("employee".equals(userType) && es.isEmployee(Integer.parseInt(request.getParameter("SIN")))) {
        session.setAttribute("user", es.getEmployee(Integer.parseInt(request.getParameter("SIN"))));
        session.setAttribute("userType", request.getParameter("user-type"));
        response.sendRedirect("home-" + request.getParameter("user-type") + ".jsp");
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Home</title>
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
              <a class="navbar-link" href="home-customer">
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
        <a class="navbar-link" href="home-employee">
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
        <h1 class="title">Log in</h1>
        <h1 class="subtitle">Log into your account to get started!</h1>
    </div>
</div>

<div class="columns">
    <div class="column is-one-third">
    <div class="box">
        <form action="index.jsp" method="POST">
            <label class="label" for="SIN">SIN</label>
            <input class="input is-rounded is-one-third" type="text" id="SIN" name="SIN" placeholder="SIN #"required>

            <br>
            <br>

            <label class="label" for="user-type">User Type</label>
            <input type="radio" id="customer" name="user-type" value="customer" required>
            <label for="customer">Customer</label>
            <br>


            <input type="radio" id="employee" name="user-type" value="employee">
            <label for="employee">Employee</label>

            <br>
            <br>

            <input class="button is-link" type="submit" name="login" value="login">
        </form>
        <br>
        <a class="button has-text-primary" href="register-customer.jsp">Register</a>
    </div>
    </div>

</div>
</body>
</html>