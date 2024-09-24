<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="src.bbs.Bbs" %>
<%@ page import="src.bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<html>
<head>
    <!-- 기존 헤더 내용 유지 -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/custom.css"/>
    <title>KHU Eats</title>
    <style>
        /* 기존 스타일 유지 */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f9;
            color: #343a40;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
        }
        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand, .nav-link {
            color: #007bff;
        }
        .active {
            font-weight: bold;
            color: #0056b3;
        }
        .content-box {
            max-width: 900px;
            width: 100%;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            margin-top: 60px;
        }
        .content-box table {
            width: 100%;
        }
        .content-box td {
            padding: 10px;
        }
        .content-box td:first-child {
            font-weight: bold;
            color: #495057;
            width: 20%;
        }
        .content-area {
            min-height: 300px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            border: 1px solid #ddd;
        }
        .image-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .image-container img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .form-title {
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
            font-size: 1.75rem;
            color: #007bff;
        }
        .button-container {
            display: flex;
            justify-content: flex-start;
            margin-top: 20px;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 30px;
            border: none;
            font-size: 1rem;
            margin-right: 10px;
            transition: background-color 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
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

    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <!-- 기존 네비게이션 바 내용 유지 -->
    <div class="container-fluid">
        <a class="navbar-brand" href="main.jsp"><h1>KHU Eats</h1></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="main.jsp">메인</a>
                </li>
                <% if(boardID == 1) {%>
                <li class="nav-item active"><a class="nav-link" href="bbs.jsp?boardID=1&pageNumber=1">맛집 공유</a> </li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a> </li>
                <%} else {%>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=1&pageNumber=1">맛집 공유</a> </li>
                <li class="nav-item active"><a class="nav-link" href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a></li>
                <%}%>
            </ul>
            <% if (userID == null) { %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        접속하기
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown1">
                        <a class="dropdown-item" href="login.jsp">로그인</a>
                        <a class="dropdown-item" href="join.jsp">회원가입</a>
                    </div>
                </li>
            </ul>
            <% } else { %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        회원 관리
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                        <a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
                    </div>
                </li>
            </ul>
            <% } %>
        </div>
    </div>
</nav>

<div class="content-box">
    <table>
        <tr>
            <td>글 제목</td>
            <td><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
        </tr>
        <tr>
            <td>작성자</td>
            <td><%= bbs.getUserID()%></td>
        </tr>
        <tr>
            <td>작성 일자</td>
            <td><%= bbs.getBbsDate().substring(0, 11) + " " + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
        </tr>
        <%
            String realPath = "C:\\dev_factory\\JSP\\project\\BBS\\src\\main\\webapp\\bbsUpload";
            File viewFile = new File(realPath + "\\" + bbsID + "사진.jpg");

            if (viewFile.exists()) {
        %>
        <tr>
            <td colspan="6">
                <br><br>
                <div class="image-container">
                    <img src="bbsUpload/<%=bbsID%>사진.jpg" class="img-fluid" alt="게시글 이미지">
                </div>
                <br><br>
            </td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td colspan="6"><br><br></td>
        </tr>
        <%
            }
        %>
        <tr>
            <td>내용</td>
            <td>
                <div class="content-area">
                    <%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%>
                </div>
            </td>
        </tr>
    </table>
    <div class="button-container">
        <a href="bbs.jsp" class="btn-custom">목록</a>
        <%
            if (userID != null && userID.equals(bbs.getUserID())) {
        %>
        <a href="update.jsp?bbsID=<%= bbsID%>" class="btn-custom">수정</a>
        <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID%>" class="btn-custom">삭제</a>
        <%
            }
        %>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
