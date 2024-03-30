<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="backend.*" %>
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
    BookingService bs = new BookingService();
    RoomService rs = new RoomService();
    CustomerService cs = new CustomerService();

    List<Booking> bookings = new ArrayList<>();

    boolean validSearch = (request.getParameter("submit") != null
                          && request.getParameter("customer_sin") != null
                          && request.getParameter("submit") != null
                          && request.getParameter("submit").equals("search"))
                          || "payed".equals(request.getAttribute("payed"));

    request.removeAttribute("payed");

    boolean doBooking = request.getParameter("submit") != null
                        && request.getParameter("room_id") != null
                        && request.getParameter("start") != null
                        && request.getParameter("customer_sin") != null
                        && request.getParameter("submit").equals("check-in");

    if (doBooking) {
        Employee employee = (Employee) session.getAttribute("user");
        bs.checkIn(Integer.parseInt(request.getParameter("room_id")), request.getParameter("start"), employee.getSin());
        validSearch = true;
    }

    if (validSearch) {
        bookings = bs.getCustomerBookings(Integer.parseInt(request.getParameter("customer_sin")));
    }
%>
<html>
<head>
    <title>Employee Check In</title>
</head>
<body>
<form action="employee-check-in.jsp" method="POST">
    <label for="customer_sin">Customer SIN:</label>
    <input type="text" id="customer_sin" name="customer_sin">
    <input type="submit" name="submit" value="search">
</form>
<table>
    <tr>
        <th>Customer SIN</th>
        <th>Customer Name</th>
        <th>Booking Start Date</th>
        <th>Booking End Date</th>
        <th>Room Number</th>
        <th>Checked In</th>
    </tr>
    <%
        if (validSearch) {
            for (Booking booking : bookings) {
                Customer customer = cs.getCustomer(booking.getCustomerSin());
    %>
                <tr>
                    <td> <%= booking.getCustomerSin() %></td>
                    <td> <%= customer.getFirstName() + ", " + customer.getLastName() %></td>
                    <td> <%= booking.getStartDate() %></td>
                    <td> <%= booking.getEndDate() %></td>
                    <td> <%= rs.getRoomNumber(booking.getRoomId()) %></td>
                    <td> <%= rs.isCheckedIn(booking.getRoomId()) %></td>
                    <td>
                    <form action="employee-check-in.jsp" method="POST">
                        <input type="submit" name="submit" value="check-in">
                        <input type="hidden" name="room_id" value="<%= booking.getRoomId() %>">
                        <input type="hidden" name="start" value="<%= booking.getStartDate() %>">
                        <input type="hidden" name="customer_sin" value="<%= booking.getCustomerSin() %>">
                    </form>
                    </td>
                </tr>
    <%
            }
        }
    %>
</table>
</body>
</html>
