
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.user.UserDAO" %>
<%@page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="src.user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<html>
<head>
    <title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user.getUserID(), user.getUserPassword());
    if (result == 1) {
        PrintWriter scrip = response.getWriter();
        
    }
%>

</body>
</html>
