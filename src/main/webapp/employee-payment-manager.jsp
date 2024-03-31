<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %><%--
  Created by IntelliJ IDEA.
  User: alexa
  Date: 3/29/2024
  Time: 9:23 PM
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
    String function = request.getParameter("submit");

    if (function == null) {
        response.sendRedirect("home-employee.jsp");
        return;
    }

    int roomId = Integer.parseInt(request.getParameter("room_id"));
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    double price = Double.parseDouble(request.getParameter("price"));
%>
<html>
<head>
    <title>Payment Manager</title>
</head>
<body>
<form action="controller-booking.jsp" method="POST">

    <input type="hidden" name="room_id" value="<%=roomId%>">
    <input type="hidden" name="start" value="<%=start%>">
    <input type="hidden" name="end" value="<%=end%>">

    <label for="customer_sin">SIN</label>
    <input type="text" name="customer_sin" id="customer_sin" required>
    <br>

    <label for="cardNumber">Card Number</label>
    <input type="text" name="cardNumber" id="cardNumber" required>
    <br>
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        try {
            Date startDate = sdf.parse(start);
            Date endDate = sdf.parse(end);

            long difference = endDate.getTime() - startDate.getTime();

            long difference_In_Days
                    = (difference
                    / (1000 * 60 * 60 * 24))
                    % 365;

            price *= difference_In_Days;
        } catch (ParseException e) {
            System.out.println("Error parsing date");
            e.printStackTrace();
        }
    %>

    Price: $<%= price %>
    <br>
    <input type="submit" name="submit" value="pay">
</form>
</body>
</html>
