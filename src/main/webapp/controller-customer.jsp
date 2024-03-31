<%@ page import="backend.Customer" %>
<%@ page import="backend.CustomerService" %><%--
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
        Customer customer = new Customer(
                Integer.parseInt(request.getParameter("sin")),
                request.getParameter("first_name"),
                request.getParameter("last_name"),
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("registration_date"),
                false
        );

        CustomerService cs = new CustomerService();
        cs.createCutsomer(customer);

        if ("employee".equals(session.getAttribute("userType"))) {
            response.sendRedirect("employee-customer-manager.jsp");
        } else {
            response.sendRedirect(request.getHeader("referer"));
        }
    }

    else if (function.equals("delete")) {
        int sin = Integer.parseInt(request.getParameter("sin"));

        CustomerService cs = new CustomerService();
        cs.deleteCustomer(sin);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("update")) {
        Customer customer = new Customer(
                Integer.parseInt(request.getParameter("sin")),
                request.getParameter("first_name"),
                request.getParameter("last_name"),
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("registration_date"),
                false
        );

        CustomerService cs = new CustomerService();
        cs.updateCustomer(customer);

        response.sendRedirect(request.getHeader("referer"));
    }
%>
