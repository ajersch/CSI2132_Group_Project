<%@ page import="backend.ChainService" %>
<%@ page import="backend.Chain" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 12:55 PM
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
    ChainService chainService = new ChainService();
    List<Chain> chains = chainService.getAllChains();
%>
<html>
<head>
    <title>Chain Updates</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="update-chain.jsp" method="POST">
    <input type="submit" name="submit" value="add">
</form>
<table>
    <tr>
        <th>Street Number</th>
        <th>Street Name</th>
        <th>City</th>
        <th>Country</th>
        <th>Name</th>
        <th>Archived</th>
    </tr>
    <% for (Chain chain : chains) { %>
    <tr>
        <td><%= chain.getStreetNumber() %></td>
        <td><%= chain.getStreetName() %></td>
        <td><%= chain.getCity() %></td>
        <td><%= chain.getCountry() %></td>
        <td><%= chain.getName() %></td>
        <td><%= chain.isArchived() %></td>
        <td>
            <form action="update-chain.jsp" method="post">
                <input type="hidden" name="street_number" value="<%= chain.getStreetNumber() %>">
                <input type="hidden" name="street_name" value="<%= chain.getStreetName() %>">
                <input type="hidden" name="city" value="<%= chain.getCity() %>">
                <input type="hidden" name="country" value="<%= chain.getCountry() %>">
                <input type="hidden" name="name" value="<%= chain.getName() %>">
                <input type="submit" name="submit" value="update">
            </form>
        </td>
        <td>
            <form action="controller-chain.jsp" method="POST">
                <input type="hidden" name="name" value="<%= chain.getName() %>">
                <input type="submit" name="submit" value="delete">
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
