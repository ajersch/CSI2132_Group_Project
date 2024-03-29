<%@ page import="backend.EmployeeService" %>
<%@ page import="backend.Employee" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 2:47 PM
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
    EmployeeService employeeService = new EmployeeService();
    List<Employee> employees = employeeService.getAllEmployees();
%>
<html>
<head>
    <title>Employee Manager</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="update-employee.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>

<table>
    <tr>
        <th>Last Name</th>
        <th>First Name</th>
        <th>SIN</th>
        <th>Street Number</th>
        <th>Street Name</th>
        <th>City</th>
        <th>Country</th>
    </tr>
    <% for (Employee employee : employees) { %>
    <tr>
        <td><%= employee.getLastName() %></td>
        <td><%= employee.getFirstName() %></td>
        <td><%= employee.getSin() %></td>
        <td><%= employee.getStreetNumber() %></td>
        <td><%= employee.getStreetName() %></td>
        <td><%= employee.getCity() %></td>
        <td><%= employee.getCountry() %></td>
        <td>
            <form action="update-employee.jsp" method="POST">
                <input type="hidden" name="employee_sin" value="<%= employee.getSin() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-employee.jsp" method="POST">
                <input type="hidden" name="employee_sin" value="<%= employee.getSin() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>