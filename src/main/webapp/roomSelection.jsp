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
    if(request.getParameter("book") != null){
    //create the booking now
    out.println("booking pending");
    }
    if(request.getParameter("search") != null){
        String startDate;
        String endDate;
        String chain;
        String city;
        int capacity;
        int rating;
        int hotelRooms;
        boolean extendable;
        float minPrice;
        float maxPrice;

        BookingService bookingService = new BookingService();

        startDate = request.getParameter("startDate");
        endDate = request.getParameter("endDate");

        if(request.getParameter("city").equals("")){
            city = null;
        } else{
            city = request.getParameter("city");
        }

        if(request.getParameter("chain").equals("")){
            chain = null;
        } else{
            chain = request.getParameter("chain");
        }

        if(request.getParameter("capacity")==null){
            capacity = 0;
        } else{
            capacity = Integer.parseInt(request.getParameter("capacity"));
        }

        if(request.getParameter("rating")==null){
            rating = 0;
        } else{
            rating = Integer.parseInt(request.getParameter("rating"));
        }

        if(request.getParameter("extendable")==null){
            extendable = false;
        } else{
            extendable = true;
        }

        if(request.getParameter("hotelRooms")==null){
            out.print("hotel rooms is null");
            hotelRooms = 0;
        }
        else if(request.getParameter("hotelRooms").equals("")){
            out.println("hotel rooms is empty");
            hotelRooms = 0;
        }
        else{
            hotelRooms = Integer.parseInt(request.getParameter("hotelRooms"));
        }
        if((request.getParameter("minPrice")==null)||(request.getParameter("minPrice").equals(""))){
            out.print("min price is empty");

            minPrice = 0;
        } else{
            minPrice = Float.parseFloat(request.getParameter("minPrice"));
        }

        if((request.getParameter("maxPrice")==null)||(request.getParameter("minPrice").equals(""))){
            out.print("max price is empty");
            maxPrice = 0;
        } else{
            maxPrice = Float.parseFloat(request.getParameter("maxPrice"));
        }

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
                    <td>
                        <form action="roomSelection.jsp" method="POST">
                            <input type="hidden" value="<%=startDate%>" name="startDate">
                            <input type="hidden" value="<%=endDate%>" name="endDate">
                            <input class="button is-link" type="submit" name="book" value="book" onclick="alert('ROOM BOOKED.')">
                        </form>
                    </td>
                </tr>
                <%}
                }%>


              </thead>
          </table>
        </div>

</div>


</body>
</html>