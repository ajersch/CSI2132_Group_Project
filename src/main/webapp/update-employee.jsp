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
    }

    if (session.getAttribute("userType") == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    if (!session.getAttribute("userType").equals("employee")) {
        session.invalidate();
        response.sendRedirect("index.jsp");
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
    <title>Update/Insert Employee</title>
    <link rel="stylesheet" href="not-ugly.css">
</head>
<body>
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
