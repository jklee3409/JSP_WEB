<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.bbs.BbsDAO" %>
<%@page import="src.bbs.Bbs" %>
<%@page import="java.io.PrintWriter" %>
<%@ page import="src.user.UserDAO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
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
    String realFolder = "";
    String saveFolder = "bbsUpload";
    String encType = "utf-8";
    int maxSize = 5 * 1024 * 1024;

    ServletContext context = config.getServletContext();
    realFolder = context.getRealPath(saveFolder);

    MultipartRequest multi = null;

    multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    String fileName = multi.getFilesystemName("fileName");
    String bbsTitle = multi.getParameter("bbsTitle");
    String bbsContent = multi.getParameter("bbsContent");

    bbs.setBbsTitle(bbsTitle);
    bbs.setBbsContent(bbsContent);

    if (!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    } else {
        if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
        || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.update(bbsID, bbs.getBbsTitle(), bbs.getBbsContent());

            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글 수정에 실패했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                if (fileName != null) {
                    String realPath = "C:\\dev_factory\\JSP\\project\\BBS\\src\\bbsUpload";
                    File deFile = new File(realPath + "\\" + bbsID + "사진.jpg");
                    if (deFile.exists()) {
                        deFile.delete();
                    }
                    File oldFile = new File(realFolder + "\\" + fileName);
                    File newFile = new File(realFolder + "\\" + bbsID + "사진.jpg");
                    oldFile.renameTo(newFile);
                }

                script.println("<script>");
                script.println("location.href = 'bbs.jsp'");
                script.println("</script>");
            }
        }
    }

%>
</body>
</html>
