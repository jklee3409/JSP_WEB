<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/custom.css"/>
    <title>KHU Eats</title>
    <style>
        .login-container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-box {
            padding: 30px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .gender-label {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .gender-label input[type="radio"] {
            display: none;
        }

        .gender-label.active {
            background-color: #007bff;
            color: white;
        }

        .gender-label:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
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
                <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=1&pageNumber=1">맛집 공유</a> </li>
                <li class="nav-item"><a class="nav-link" href="bbs.jsp?boardID=2&pageNumber=1">자유 게시판</a> </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        접속하기
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="login.jsp">로그인</a>
                        <a class="dropdown-item" href="join.jsp">회원가입</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container login-container">
    <div class="col-lg-4">
        <div class="login-box bg-light">
            <form method="post" action="joinAction.jsp" accept-charset="UTF-8">
                <h3 style="text-align: center;">회원가입</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20" required>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20" required>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" required>
                </div>
                <div class="form-group" style="text-align: center">
                    <label class="btn btn-primary active gender-label">
                        <input type="radio" name="userGender" value="남자" checked> 남자
                    </label>
                    <label class="btn btn-primary gender-label">
                        <input type="radio" name="userGender" value="여자"> 여자
                    </label>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">회원가입</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('input[name="userGender"]').forEach((radio) => {
        radio.addEventListener('change', function() {
            document.querySelectorAll('.gender-label').forEach((label) => {
                label.classList.remove('active');
            });
            this.closest('label').classList.add('active');
        });
    });
</script>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
