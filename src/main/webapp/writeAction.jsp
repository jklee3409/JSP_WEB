<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.bbs.BbsDAO" %>
<%@page import="java.io.PrintWriter" %>
<%@page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<jsp:useBean id="bbs" class="src.bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

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

  String saveFolder = "/bbsUpload";  // webapp의 bbsUpload 경로
  String realFolder = "C:/dev_factory/JSP/project/BBS/src/main/webapp" + saveFolder;  // 절대 경로로 강제 설정
  String encType = "utf-8"; // 변환 형식
  int maxSize = 5 * 1024 * 1024; // 사진의 size

  System.out.println(realFolder);

  File dir = new File(realFolder);

  if (!dir.exists()) {
    dir.mkdirs(); // Create directory if it does not exist
  }

  MultipartRequest multi = null;

  // 파일 업로드를 직접적으로 담당
  multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

  String fileName = multi.getFilesystemName("fileName");
  String bbsTitle = multi.getParameter("bbsTitle");
  String bbsContent = multi.getParameter("bbsContent");

  bbs.setBbsTitle(bbsTitle);
  bbs.setBbsContent(bbsContent);

  if (userID == null) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("로그인을 하세요.");
    script.println("location.href = 'login.jsp'");
    script.println("</script>");
  } else {
    if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('입력이 안 된 사항이 있습니다.')");
      script.println("history.back()");
      script.println("</script>");
    } else {
      BbsDAO bbsDAO = new BbsDAO();
      int bbsID = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), boardID);

      if (bbsID == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        if (fileName != null) {
          File oldFile = new File(realFolder + "\\" + fileName);
          File newFile = new File(realFolder + "\\" + (bbsID - 1) + "사진.jpg");
          oldFile.renameTo(newFile);
        }

        script.println("<script>");
        script.println("location.href= \'bbs.jsp?boardID="+boardID+"\'");
        script.println("</script>");
      }
    }
  }

%>
</body>
</html>
