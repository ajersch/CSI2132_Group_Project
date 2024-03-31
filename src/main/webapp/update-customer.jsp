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
    <title>Update Customer</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
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