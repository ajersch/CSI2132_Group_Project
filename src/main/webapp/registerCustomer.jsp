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
    <title>Register Customer</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="controller-customer.jsp" method="POST">
    <label for="sin">SIN:</label>
    <input type="number" name="sin" id="sin" required>
    <br>

    <label for="first_name">First Name:</label>
    <input type="text" name="first_name" id="first_name" required>
    <br>

    <label for="last_name">Last Name:</label>
    <input type="text" name="last_name" id="last_name" required>
    <br>

    <label for="street_number">Street Number:</label>
    <input type="number" name="street_number" id="street_number" required>
    <br>

    <label for="street_name">Street Name:</label>
    <input type="text" name="street_name" id="street_name" required>
    <br>

    <label for="city">City:</label>
    <input type="text" name="city" id="city" required>
    <br>

    <label for="country">Country:</label>
    <input type="text" name="country" id="country" required>
    <br>

    <label for="registration_date">Date:</label>
    <input type="date" name="registration_date" id="registration_date" required>
    <br>

    <input type="submit" name="submit" value="add">
</form>
</body>
</html>
