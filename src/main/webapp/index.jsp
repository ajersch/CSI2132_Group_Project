<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%= request.getParameter("test")%>
Testing 1 2 3 4 5 6 7
<ul>

<%
    for(int i = 0; i < 10; i++) {
        out.print("<li>"+ i+"</li>");
    }


%>
</ul>
</body>
</html>