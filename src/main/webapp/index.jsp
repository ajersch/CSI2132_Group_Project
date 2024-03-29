<%@ page import="backend.SessionService" %>
<%@ page import="backend.CustomerService" %>
<%@ page import="backend.EmployeeService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
if (request.getParameter("login") != null && request.getParameter("login").equals("login")) {
    CustomerService cs = new CustomerService();
    EmployeeService es = new EmployeeService();

    if (cs.isCustomer(Integer.parseInt(request.getParameter("SIN")))) {
        session.setAttribute("sin", request.getParameter("SIN"));
        session.setAttribute("userType", request.getParameter("user-type"));
        response.sendRedirect(request.getParameter("user-type") + "Home.jsp");
    }
    if (es.isEmployee(Integer.parseInt(request.getParameter("SIN")))) {
        session.setAttribute("sin", request.getParameter("SIN"));
        session.setAttribute("userType", request.getParameter("user-type"));
        response.sendRedirect(request.getParameter("user-type") + "Home.jsp");
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
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
</body>
</html>