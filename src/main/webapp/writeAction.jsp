<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="src.bbs.BbsDAO" %>
<%@page import="java.io.PrintWriter" %>
<%@ page import="src.user.UserDAO" %>
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
  <title>아이유 사진 게시판</title>
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
  } else {
    if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('입력이 안 된 사항이 있습니다.')");
      script.println("history.back()");
      script.println("</script>");
    } else {
      BbsDAO bbsDAO = new BbsDAO();
      int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());

      if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
      }
    }
  }

%>
</body>
</html>
