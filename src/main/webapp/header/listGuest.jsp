<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="/pt1/resources/css/header.css">
</head>
<body>
	<header>
		<div class="top">
			<h1 class="mainT">
				<a href="/pt1/main/main.jsp">PT1 STORE</a>
			</h1>
			<div class="login">
				<ul>
					<li><a href="/pt1/admin/adminloginForm.jsp">관리자 로그인</a></li>
					<li><a href="/pt1/store/storeloginForm.jsp">점주 로그인</a></li>
					<li><a href="/pt1/member/loginForm.jsp">고객 로그인</a></li>
				</ul>
			</div>
		</div>
		<div class="menuBar">
			<ul>
				<li><a href="/pt1/classification/classification.jsp">상품</a>
					<ul>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=beanie&category=beanie">Beanie</a>
						</li>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=beret&category=beret">Beret</a>
						</li>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=cap&category=cap">Cap</a>
						</li>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=hat&category=hat">Hap</a>
						</li>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=snapback&category=snapback">Snapback</a>
						</li>
						<li>
							<a href="/pt1/classification/classification.jsp?classificationName=etc&category=etc">etc</a>
						</li>
					</ul>
				</li>
				<li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a>
				<ul>
					<li><a href="/pt1/board/noticeMain.jsp">공지사항</a></li>
					<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
				</ul></li>
			</ul>
		</div>
	</header>
</body>
</html>