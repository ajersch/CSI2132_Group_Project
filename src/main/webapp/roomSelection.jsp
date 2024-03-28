<%@ page import="backend.BookingService" %>
<%@ page import="java.util.List" %>
<%@ page import="backend.Room" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Room Select</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">
</head>
<body>
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="index.jsp">
      hello imagine something is here
    </a>
  </div>

  <div id="navbarBasicExample" class="navbar-menu">
    <div class="navbar-start">
      <a class="navbar-item">
        Home
      </a>

      <a class="navbar-item">
        Hotel Search
      </a>

      <div class="navbar-item has-dropdown is-hoverable">
        <a class="navbar-link">
          More
        </a>

        <div class="navbar-dropdown">
          <a class="navbar-item">
            About
          </a>
          <a class="navbar-item is-selected">
            Jobs
          </a>
          <a class="navbar-item">
            Contact
          </a>
          <hr class="navbar-divider">
          <a class="navbar-item">
            Report an issue
          </a>
        </div>
      </div>
    </div>

    <div class="navbar-end">
      <div class="navbar-item">
        <div class="buttons">
          <a class="button is-primary">
            <strong>Sign in</strong>
          </a>
          <a class="button is-link">
            Employee Log in
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>

<%
        BookingService bookingService = new BookingService();
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String chain = request.getParameter("chain");
        String city = request.getParameter("city");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        int hotelRooms = Integer.parseInt(request.getParameter("hotelRooms"));
        boolean extendable = request.getParameter("extendable").equals("on");
        float minPrice = Float.valueOf(request.getParameter("minPrice"));
        float maxPrice = Float.valueOf(request.getParameter("maxPrice"));

        List<Room> rooms = bookingService.searchRooms(startDate,endDate,chain,city,capacity,rating,hotelRooms,minPrice,maxPrice,extendable);
%>

<section class="hero is-info">
  <div class="hero-body">
    <p class="title">ACR Bookings</p>
    <p class="subtitle">Travel the world with ACR</p>
  </div>
</section>
<div class="box">
    <div class="container">
        <h1 class="title">Room Search<h1>
        <h1 class="subtitle">Search our database of rooms based on your trip.<h1>
    </div>
</div>

<div class="section">
    <h1>Booking Search<h1>
    <% String customerSIN = request.getParameter("Customer SIN");
    if(customerSIN == null || customerSIN == ""){
        out.print("customer sin is null");
        }
    else{
        out.print("Welcome, Customer "+ customerSIN);
    }
    %>
</div>

<div class="section">
        <div class="table-container">
          <table class="table">
            <thead>
                <tr>
                  <th>Room id</th>
                  <th>Room #</th>
                  <th>Hotel #</th>
                  <th>Price per room</th>
                  <th>Capacity</th>
                  <th>Extendable?</th>

                </tr>

                <%for (Room room : rooms){%>
                <tr>
                    <td><%= room.getRoomId()%></td>
                    <td><%= room.getRoomNumber()%></td>
                    <td><%= room.getHotelId()%></td>
                    <td><%= room.getPrice()%></td>
                    <td><%= room.getCapacity()%></td>
                    <td><%= room.isExtendable()%></td>
                </tr>
                <%}%>


              </thead>
          </table>
        </div>

</div>


</body>
</html>