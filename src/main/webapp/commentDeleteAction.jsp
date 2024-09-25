<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.comment.CommentDAO" %>
<%@page import="src.comment.Comment" %>
<%@page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>

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
    String userID = null;
    if (session.getAttribute("userID") != null) {
        // userID 변수에 세션값 할당
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back();");
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

    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }

    int commentID = 0;
    if (request.getParameter("commentID") != null) {
        commentID = Integer.parseInt(request.getParameter("commentID"));
    }
    if (commentID == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 댓글 입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }

    Comment comment = new CommentDAO().getComment(commentID);
    if (!userID.equals(comment.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        CommentDAO commentDAO = new CommentDAO();
        int result = commentDAO.delete(commentID);

        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('댓글 삭제에 실패했습니다')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            PrintWriter script = response.getWriter();
            String realPath = "C:/dev_factory/JSP/project/BBS/src/main/webapp/commentUpload";
            File deFile = new File(realPath + "\\" + bbsID + "사진" + commentID + ".jpg");

            if (deFile.exists()) {
                deFile.delete();
            }
            script.println("<script>");
            script.println("location.href=document.referrer;");
            script.println("</script>");
        }
    }
%>
</body>
</html>
