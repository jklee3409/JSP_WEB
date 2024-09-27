<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.comment.CommentDAO" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id="comment" class="src.comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="commentText"/>

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

    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }

    String saveFolder = "/commentUpload";  // webapp의 commentUpload 경로
    String realFolder = "C:/dev_factory/JSP/project/BBS/src/main/webapp" + saveFolder;  // 절대 경로로 강제 설정
    String encType = "utf-8"; // 변환 형식
    int maxSize = 5 * 1024 * 1024; // 사진의 size

    MultipartRequest multi = null;

    File dir = new File(realFolder);

    if (!dir.exists()) {
        dir.mkdirs(); // Create directory if it does not exist
    }

    // 파일 업로드를 직접적으로 담당
    multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    String fileName = multi.getFilesystemName("fileName");
    String commentText = multi.getParameter("commentText");

    comment.setCommentText(commentText);

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("history.back();");
        script.println("</script>");
    } else {
        int bbsID = 0;
        if (request.getParameter("bbsID") != null) {
            bbsID = Integer.parseInt(request.getParameter("bbsID"));
        }

        if (bbsID == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('유효하지 않은 글입니다.')");
            script.println("location.href = 'login.jsp'");
            script.println("</script>");
        }
        if (comment.getCommentText() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            CommentDAO commentDAO = new CommentDAO();
            int commentID = commentDAO.write(boardID, bbsID, userID, comment.getCommentText());
            if (commentID == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('댓글 쓰기에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                if(fileName != null){
                    File oldFile = new File(realFolder + "\\" + fileName);
                    File newFile = new File(realFolder + "\\" + bbsID+"사진"+(commentID-1)+".jpg");
                    oldFile.renameTo(newFile);
                }
                script.println("<script>");
                script.println("location.href=document.referrer;");
                script.println("</script>");
            }
        }
    }

%>
</body>
</html>
