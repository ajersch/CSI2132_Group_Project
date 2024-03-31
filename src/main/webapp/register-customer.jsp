<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/28/2024
  Time: 9:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Register Customer</title>
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

<div class="box">
    <div class="container">
        <h1 class="title">Customer Registration</h1>
        <h1 class="subtitle">Sign up with ACR bookings to find your next dream hotel!</h1>
    </div>
</div>

<div class="section">
    <form action="controller-customer.jsp" method="POST">
        <label class="label" for="sin">SIN:</label>
        <input class="input" type="number" name="sin" id="sin" required>
        <br>

        <label class="label" for="first_name">First Name:</label>
        <input class="input" type="text" name="first_name" id="first_name" required>
        <br>

        <label class="label"for="last_name">Last Name:</label>
        <input class="input"type="text" name="last_name" id="last_name" required>
        <br>

        <label class="label"for="street_number">Street Number:</label>
        <input class="input"type="number" name="street_number" id="street_number" required>
        <br>

        <label class="label"for="street_name">Street Name:</label>
        <input class="input"type="text" name="street_name" id="street_name" required>
        <br>

        <label class="label"for="city">City:</label>
        <input class="input"type="text" name="city" id="city" required>
        <br>

        <label class="label"for="country">Country:</label>
        <input class="input"type="text" name="country" id="country" required>
        <br>

        <label class="label"for="registration_date">Date:</label>
        <input class="input"type="date" name="registration_date" id="registration_date" required>
        <br>
        <br>

        <input class="button is-link" type="submit" name="submit" value="add">
    </form>
</div>
</body>
</html>
