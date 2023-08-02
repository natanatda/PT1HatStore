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
					<li><a href="/pt1/member/mypage.jsp">마이페이지</a></li>
					<li><a href="/pt1/cart/cartForm.jsp">장바구니</a></li>
					<li><a href="/pt1/member/logoutForm.jsp">로그아웃</a></li>
				</ul>
			</div>
		</div>
		<div class="menuBar">
			<ul>
				<%-- 상품 페이지로 이동 --%>
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
				<%-- 브랜드 페이지로 이동 --%>
				<li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
				<li><a href="/pt1/inquiry/inquiryList.jsp">문의</a>
					<ul>
						<li><a href="/pt1/inquiry/inquiryList.jsp">전체문의</a>
						<li><a href="/pt1/inquiry/inquiryForm.jsp">문의하기</a></li>
						<li><a href="/pt1/inquiry/inquiryMyList.jsp">내 문의</a></li>
					</ul></li>
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