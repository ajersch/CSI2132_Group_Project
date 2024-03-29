<%@ page import="backend.Chain" %>
<%@ page import="backend.ChainService" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 1:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    System.out.println("here");
    String function = request.getParameter("submit");

    if (function == null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

    else if (function.equals("add")) {
        Chain chain = new Chain(
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("name")
        );

        ChainService chainService = new ChainService();
        chainService.createChain(chain);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("update")) {
        Chain chain = new Chain(
                Integer.parseInt(request.getParameter("street_number")),
                request.getParameter("street_name"),
                request.getParameter("city"),
                request.getParameter("country"),
                request.getParameter("name")
        );

        ChainService chainService = new ChainService();
        chainService.updateChain(chain);

        response.sendRedirect(request.getHeader("referer"));
    }

    else if (function.equals("delete")) {
        String name = request.getParameter("name");

        ChainService chainService = new ChainService();
        chainService.deleteChain(name);

        response.sendRedirect(request.getHeader("referer"));
    }

%>