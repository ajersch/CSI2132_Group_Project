<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Bookings - Search</title>
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
    <form action="roomSelection.jsp" method="POST">
        <label class="label">Start Date</label>
        <input class="input" type="date" name="startDate" placeholder="Select start date" required>

        <label class="label">End Date</label>
        <input class="input" type="date" name="endDate" placeholder="Select end date" required>

        <label class="label">City</label>
        <input class="input" type="text" name="city" placeholder="City">


        <label class="label">Capacity</label>
        <div class="select">
            <select name="capacity">
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
                <option>6</option>
            </select>
        </div>

        <label class="label">Hotel Chain</label>
        <input class="input" type="text" name="chain" placeholder="Hotel Chain">

        <label class="label">Hotel Rating</label>
        <div class="select">
                    <select name="rating">
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                        <option>5</option>
                    </select>
                </div>

        <label class="label">Min. Hotel Rooms</label>
        <input class="input" type="text" name="hotelRooms" placeholder="Minimum # of hotel rooms">

        <label class="label">Min. Price</label>
        <input class="input" type="text" name="minPrice" placeholder="$">

        <label class="label">Max. Price</label>
        <input class="input" type="text" name="maxPrice" placeholder="$">

        <label class="label"> Extendable room?</label>
        <input type="checkbox" name="extendable"> I would like an extendable room.



        <div><br></div>
        <input class="button is-link" type="submit" name="search" value="search">
    </form>

</div>


</body>
</html>