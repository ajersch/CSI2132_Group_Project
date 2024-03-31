<%@ page import="backend.CustomerService" %>
<%@ page import="backend.Customer" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/30/2024
  Time: 4:54 PM
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
  CustomerService customerService = new CustomerService();
    List<Customer> customers = customerService.getAllCustomers();
%>

<html>
<head>
    <title>Customer Manager</title>
</head>
<body>
<form action="register-customer.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>
<table>
    <tr>
        <th>SIN</th>
        <th>Last Name</th>
        <th>First Name</th>
        <th>Street Number</th>
        <th>Street Name</th>
        <th>City</th>
        <th>Country</th>
    </tr>
    <%
        for (Customer customer : customers) {
    %>
    <tr>
        <td><%= customer.getSin() %></td>
        <td><%= customer.getLastName() %></td>
        <td><%= customer.getFirstName() %></td>
        <td><%= customer.getStreetNumber() %></td>
        <td><%= customer.getStreetName() %></td>
        <td><%= customer.getCity() %></td>
        <td><%= customer.getCountry() %></td>
        <td>
            <form action="update-customer.jsp" method="POST">
                <input type="hidden" name="sin" value="<%= customer.getSin() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-customer.jsp" method="POST">
                <input type="hidden" name="sin" value="<%= customer.getSin() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
