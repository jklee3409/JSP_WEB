<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="src.bbs.Bbs" %>
<%@ page import="src.bbs.BbsDAO" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/custom.css"/>
    <title>KHU Eats</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f9;
            color: #343a40;
        }
        .navbar {
            background-color: #fff; /* 흰색 배경 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        }
        .navbar-brand, .nav-link {
            color: #007bff; /* 파란색 글자 */
        }
        .active {
            font-weight: bold;
            color: #0056b3; /* 진한 파란색 */
        }
        .form-container {
            max-width: 800px; /* 최대 너비 설정 */
            margin: 40px auto; /* 중앙 정렬 */
            padding: 20px;
            background-color: #fff; /* 흰색 배경 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 */
            border-radius: 10px; /* 모서리 둥글게 */
        }
        .form-control {
            border-radius: 0.5rem; /* 더 둥글게 */
            border: 1px solid #ced4da;
            margin-bottom: 15px; /* 입력 필드 간격 */
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 테두리 효과 */
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            width: 100%; /* 버튼 너비를 100%로 설정 */
            padding: 10px; /* 버튼 패딩 */
            font-size: 1.1rem; /* 버튼 글자 크기 */
        }
        .btn-primary:hover {
            background-color: #0056b3; /* 호버 시 색상 */
            border-color: #004085;
        }
        .form-title {
            text-align: center;
            font-weight: bold;
            margin-bottom: 20px;
            font-size: 1.5rem; /* 제목 크기 */
            color: #007bff;
        }
        .navbar-toggler-icon {
            color: #007bff; /* 모바일 메뉴 버튼 색상 */
        }
    </style>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
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
    }
%>
<nav class="navbar navbar-light navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="main.jsp"><h1>KHU Eats</h1></a>
        <button class="navbar-toggler" type="button"
                data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="main.jsp">메인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="bbs.jsp">게시판</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        회원 관리
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                        <a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container form-container">
    <form method="post" enctype="multipart/form-data" action="updateAction.jsp?bbsID=<%= bbsID%>&keyValue=multipart">
        <div class="form-title">게시판 글수정 양식</div>
        <input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle()%>" required>
        <textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048"  style="height: 350px"  required><%= bbs.getBbsContent()%></textarea>
        <input type="file" name="bbsImage"/>
        <input type="submit" class="btn btn-primary" value="글수정">
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
