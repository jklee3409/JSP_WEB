<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="src.bbs.BbsDAO" %>
<%@ page import="src.bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
            background-color: #f8f9fa;
            color: #343a40;
        }
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand, .nav-link {
            color: #007bff;
        }
        .nav-link:hover {
            color: #0056b3;
        }
        .active {
            font-weight: bold;
            color: #0056b3;
        }
        .table-container {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .table {
            width: 85%;
            border-collapse: collapse;
            background-color: white;
        }
        .table th {
            background-color: #f1f1f1;
        }
        .table td, .table th {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: center;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }
        .btn-container {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
            width: 85%;
        }
        .btn {
            border-radius: 50px;
            padding: 10px 30px;
            transition: all 0.3s;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .btn-arrow-left, .btn-arrow-right {
            font-size: 1.1rem;
            background-color: #28a745;
            color: white;
        }
        .btn-arrow-left:hover, .btn-arrow-right:hover {
            background-color: #218838;
        }
        .pagination {
            display: flex;
            justify-content: flex-start; /* 왼쪽 정렬 */
        }
        .btn-write {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
        }
        .high-container{
            margin-top: 30px;
            margin-left: 250px;
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
        script.println("alert('권한이 없습니다.')");
        script.println("history.back();");
        script.println("</script>");
    }

    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
    int boardID = 0;
    if (request.getParameter("boardID") != null) {
        boardID = Integer.parseInt(request.getParameter("boardID"));
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
                <% if(boardID == 1) {%>
                    <li class="nav-item active"><a class="nav-link" href="bbs.jsp?boardID=1&pageNumber=1">맛집 공유</a> </li>
                    <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a> </li>
                <%} else {%>
                    <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=1&pageNumber=1">맛집 공유</a> </li>
                    <li class="nav-item active"><a class="nav-link" href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a></li>
                <%}%>
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

<div class="high-container">
    <%
        if (boardID == 1) {
    %>
    <h1>맛집 공유</h1>
    <p>경희대학교 주변의 맛집을 알려주세요!</p>
    <%
        } else if(boardID == 2) {
    %>
    <h1>자유 게시판</h1>
    <p>자유롭게 글을 쓰는 곳입니다. 학교의 다양한 소식들을 공유해주세요!</p>
    <%
        }
    %>
</div>

<div class="container table-container">
    <table class="table table-striped">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <%
            BbsDAO bbsDAO = new BbsDAO();
            ArrayList<Bbs> list = bbsDAO.getList(pageNumber, boardID);
            for (int i = 0; i < list.size(); i++) {
        %>
        <tr>
            <td><%= list.get(i).getBbsID() %></td>
            <td><a href="view.jsp?boardID=<%=boardID%>&bbsID=<%= list.get(i).getBbsID() %> "> <%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
            <td><%= list.get(i).getUserID() %></td>
            <td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분 " %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="btn-container">
        <div class="pagination">
            <%
                if (pageNumber != 1) {
            %>
            <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-arrow-left">이전</a>
            <%
                }
                if(bbsDAO.nextPage(pageNumber + 1)) {
            %>
            <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-arrow-right">다음</a>
            <%
                }
            %>
        </div>

        <div class="btn-write">
            <a href="write.jsp?boardID=<%=boardID%>" class="btn btn-primary">글쓰기</a>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
