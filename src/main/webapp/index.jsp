<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ACR Travel - Customer Sign In</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css">
</head>
<body>
<h1>Homepage<h1>
<div class="section">
    <form action="bookingSearch.jsp" method="POST">
        <input type="text" name="Customer SIN">
        <input type="submit" value="submit">
    </form>
    <%= request.getParameter("Customer SIN")%>
</div>


</body>
</html>