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
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="not-ugly.css">
</head>
<body>
<form action="index.jsp" method="POST">
    <label for="SIN">SIN</label>
    <input type="text" id="SIN" name="SIN" required>

    <br>

    <input type="radio" id="customer" name="user-type" value="customer" required>
    <label for="customer">Customer</label>

    <br>

    <input type="radio" id="employee" name="user-type" value="employee">
    <label for="employee">Employee</label>

    <br>

    <input type="submit" name="login" value="login">
</form>

<a href="registerCustomer.jsp">Register</a>
</body>
</html>