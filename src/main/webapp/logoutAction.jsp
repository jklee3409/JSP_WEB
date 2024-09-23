<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<html>
<head>
    <title>KHU Eats</title>
</head>
<body>
<%
    session.invalidate();
%>
<script>
    location.href = 'main.jsp';
</script>
</body>
</html>
