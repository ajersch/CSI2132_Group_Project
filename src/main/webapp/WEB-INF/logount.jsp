<%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/30/2024
  Time: 4:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
