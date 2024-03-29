<%@ page import="backend.Employee" %>
<%@ page import="backend.EmployeeService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String function = request.getParameter("submit");

    if (function == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    else if (function.equals("add")) {
        Employee employee = new Employee(
                Integer.parseInt(request.getParameter("sin")),
                request.getParameter("first_name"),
                request.getParameter("last_name"),
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                false
        );

        EmployeeService es = new EmployeeService();
        es.createEmployee(employee);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("delete")) {
        int sin = Integer.parseInt(request.getParameter("sin"));

        EmployeeService es = new EmployeeService();
        es.deleteEmployee(sin);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("update")) {
        Employee employee = new Employee(
                Integer.parseInt(request.getParameter("sin")),
                request.getParameter("first_name"),
                request.getParameter("last_name"),
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                false
        );

        EmployeeService es = new EmployeeService();
        es.updateEmployee(employee);

        response.sendRedirect(request.getHeader("referer"));
    }
%>