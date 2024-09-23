<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/custom.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <title>KHU Eats</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
            justify-content: center;
        }
        .navbar {
            background-color: #ffffff;
        }
        .navbar-brand, .nav-link {
            color: #007bff;
        }
        .navbar-brand:hover, .nav-link:hover {
            color: #0056b3 !important;
        }
        .active {
            font-weight: bold;
            color: #0056b3;
        }
        .jumbotron {
            background-color: #ffffff;
            padding: 4rem 4rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin: 0 auto;
            top: 1px;
            position: relative;
        }
        .jumbotron h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .jumbotron p {
            font-size: 1.25rem;
            margin-bottom: 2rem;
        }
        .btn-custom {
            background-color: #007bff;
            color: #ffffff;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        /* 슬라이드 이미지 크기 조절 */
        .carousel-inner img {
            width: 100%;
            height: 500px; /* 이미지를 줄이기 위한 높이 설정 */
            object-fit: cover;
        }
        .carousel-control-prev, .carousel-control-next {
            width: 5%;
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
        <a class="navbar-brand" href="main.jsp"><h1>KHU Eats</h1></a>
        <button class="navbar-toggler" type="button"
                data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" href="main.jsp">메인</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="bbs.jsp">게시판</a>
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
<div class="navbar">
    <div class="jumbotron">
        <div class="container">
            <h1>KHU EATS 소개</h1>
            <p>경희대학교 주변의 맛집을 공유해보세요.</p>
            <p>동기, 선배, 후배들에게 소개시켜 주고 싶은 나만의 맛집!</p>
            <a class="btn btn-custom" href="https://github.com/jklee3409/JSP_WEB.git" role="button">GitHub</a>
        </div>
    </div>
</div>

<!-- 이미지 슬라이드 -->
<div class="container image-gap">
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- 슬라이드 표시 버튼 -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <!-- 슬라이드 이미지 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/1.png" alt="Slide 1">
            </div>
            <div class="carousel-item">
                <img src="images/2.png" alt="Slide 2">
            </div>
            <div class="carousel-item">
                <img src="images/3.png" alt="Slide 3">
            </div>
        </div>
        <!-- 좌우 이동 버튼 -->
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
