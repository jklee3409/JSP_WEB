<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.bbs.BbsDAO" %>
<%@page import="src.bbs.Bbs" %>
<%@page import="java.io.PrintWriter" %>
<%@ page import="src.user.UserDAO" %>


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
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("로그인을 하세요.");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int bbsID = 0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }

    Bbs bbs = new BbsDAO().getBBS(bbsID);
    if (!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    } else {
        BbsDAO bbsDAO = new BbsDAO();
        int result = bbsDAO.delete(bbsID);

        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글 삭제에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'bbs.jsp'");
            script.println("</script>");
        }
    }

%>
</body>
</html>
