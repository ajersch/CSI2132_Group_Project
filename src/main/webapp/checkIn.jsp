<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="backend.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ########################### EMPLOYEE VALIDATION ###########################
    if (session.getAttribute("sin") == null) {
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

    boolean validSearch = request.getParameter("SUBMIT") != null
                          && request.getParameter("Customer_Sin") != null
                          && request.getParameter("SUBMIT") != null
                          && request.getParameter("SUBMIT").equals("SEARCH");

    boolean doBooking = request.getParameter("SUBMIT") != null
                        && request.getParameter("Room_Id") != null
                        && request.getParameter("Start_Date") != null
                        && request.getParameter("Customer_Sin") != null
                        && request.getParameter("SUBMIT").equals("check-in");

    if (doBooking) {

    }

    if (validSearch) {
        bookings = bs.getCustomerBookings(Integer.parseInt(request.getParameter("Customer_Sin")));
    }
%>
<html>
<head>
    <title>Employee Check In</title>
</head>
<body>
<form action="checkIn.jsp" method="POST">
    <label for="Customer_Sin">Customer SIN:</label>
    <input type="text" id="Customer_Sin" name="Customer_Sin">
    <input type="submit" name="SUBMIT" value="SEARCH">
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
                Pair<String, String> name = cs.getCustomerName(booking.getCustomerSin());
    %>
                <tr>
                    <td> <%= booking.getCustomerSin() %></td>
                    <td> <%= name.getSecond() + ", " + name.getFirst() %></td>
                    <td> <%= booking.getStartDate() %></td>
                    <td> <%= booking.getEndDate() %></td>
                    <td> <%= rs.getRoomNumber(booking.getRoomId()) %></td>
                    <td> <%= rs.isCheckedIn(booking.getRoomId()) %></td>
                    <td>
                    <form>
                        <input type="submit" name="SUBMIT" value="check-in">
                        <input type="hidden" name="Room_Id" value="<%= booking.getRoomId() %>">
                        <input type="hidden" name="Start_Date" value="<%= booking.getStartDate() %>">
                        <input type="hidden" name="Customer_Sin" value="<%= booking.getCustomerSin() %>">
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
