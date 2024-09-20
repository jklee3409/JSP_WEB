<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <title>JSP 게시판 웹 사이트</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
        }
        .navbar {
            background-color: #ffffff; /* 흰색 배경 */
        }
        .navbar-brand, .nav-link {
            color: #007bff; /* 파란색 글자 */
        }
        .active {
            font-weight: bold;
            color: #0056b3; /* 현재 페이지 글자 색상 (진한 파란색) */
        }
        .table-container {
            margin-top: 20px; /* 테이블 위쪽 여백 */
            display: flex;
            flex-direction: column;
            align-items: center; /* 가운데 정렬 */
        }
        .table {
            width: 80%; /* 테이블 너비 */
            margin-bottom: 20px; /* 버튼과의 간격 */
        }
        .btn-primary {
            background-color: #007bff; /* 버튼 색상 */
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3; /* 버튼 호버 색상 */
            border-color: #004085;
        }
    </style>
</head>
<body>
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
%>
<nav class="navbar navbar-light navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
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
            <%
                if(userID == null) {
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        접속하기
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown1">
                        <a class="dropdown-item" href="login.jsp">로그인</a>
                        <a class="dropdown-item" href="join.jsp">회원가입</a>
                    </div>
                </li>
            </ul>
            <%
            } else {
            %>
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
            <%
                }
            %>
        </div>
    </div>
</nav>

<div class="container table-container">
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
        <thead>
        <tr>
            <th style="background-color: #eeeeee; text-align: center;">번호</th>
            <th style="background-color: #eeeeee; text-align: center;">제목</th>
            <th style="background-color: #eeeeee; text-align: center;">작성자</th>
            <th style="background-color: #eeeeee; text-align: center;">작성일</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>1</td>
            <td>안녕하세요</td>
            <td>이종규</td>
            <td>2024-09-20</td>
        </tr>
        </tbody>
    </table>
    <a href="write.jsp" class="btn btn-primary">글쓰기</a>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
