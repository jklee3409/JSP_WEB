<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.user.UserDAO" %>
<%@page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="src.user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<html>
<head>
    <title>IU 사진 게시판</title>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        // userID 변수에 세션값 할당
        userID = (String) session.getAttribute("userID");
    }
    if (userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("이미 로그인이 되어있습니다.");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
            || user.getUserGender() == null || user.getUserEmail() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안 된 항목이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        // result 가 -1인 경우 : userID 중복이 발생한 경우
        // userID는 기본 키로 지정된 상태
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            session.setAttribute("userID", user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
    }
%>
</body>
</html>
