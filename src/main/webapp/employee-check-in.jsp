<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="backend.*" %>
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Employee Check In</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">
</head>
<body>
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="index.jsp">
      <p class="button is-info"><strong>ACR Bookings</strong></p>
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-start">


      <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link" >
                      Find Rooms
                    </a>

                    <div class="navbar-dropdown">
                      <a class="navbar-item" href="employee-room-search.jsp">
                        Search Rooms
                      </a>
                      <a class="navbar-item" href="roomsPerHotel.jsp">
                        Rooms by Hotel
                      </a>
                      <a class="navbar-item" href="roomsPerArea.jsp">
                        Rooms by Area
                      </a>
                    </div>
                  </div>

            <div class="navbar-item has-dropdown is-hoverable">
              <a class="navbar-link">
                Manage...
              </a>

              <div class="navbar-dropdown">
                <a class="navbar-item" href="employee-customer-manager.jsp">
                  Manage Customers
                </a>
                <a class="navbar-item" href="employee-employee-manager.jsp">
                  Manage Employees
                </a>
                <a class="navbar-item" href="employee-room-manager.jsp">
                    Manage Rooms
                </a>
                <a class="navbar-item" href="employee-hotel-manager.jsp">
                  Manage Hotels
                </a>
                <a class="navbar-item" href="employee-chain-manager.jsp">
                  Manage Chains
                </a>
                <a class="navbar-item" href="employee-renting-manager.jsp">
                    Manage Rentings
                </a>
              </div>
            </div>
            <a class="navbar-item" href="employee-check-in.jsp">
                Check-In
            </a>
          </div>
          <a class="navbar-item" href="logout.jsp">
            Log out
          </a>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <a class="button is-primary" href="register-customer.jsp">
            <strong>Register</strong>
          </a>
          <a class="button is-link" href="index.jsp">
            Log in
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>
<section class="hero is-info">
  <div class="hero-body">
    <p class="title">ACR Bookings</p>
    <p class="subtitle">Travel the world with ACR</p>
  </div>
</section>
<div class="box">
    <div class="container">
        <h1 class="title">Check In</h1>
        <h1 class="subtitle">Check customers into their reserved rooms.</h1>
    </div>
</div>

<div class="container">

    <form action="employee-check-in.jsp" method="POST">
        <label class="label" for="customer_sin">Customer SIN:</label>
        <input class="input" type="text" id="customer_sin" name="customer_sin" required>
        <input class="button is-link is-rounded" type="submit" name="submit" value="search">
    </form>
    <div class="table-container">
    <table class="table">
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
                            <input class="button is-link is-rounded" type="submit" name="submit" value="check-in">
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
    </div>
    </div>
</div>
</body>
</html>
