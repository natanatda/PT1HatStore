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
					<li><a href="/pt1/admin/adminmypage.jsp">마이페이지</a></li>
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
				<li><a href="/pt1/admin/sales.jsp">매출조회</a>
					<ul>
						<li><a href="/pt1/admin/sales.jsp">일별 매출</a></li>
						<li><a href="/pt1/admin/salesBrand.jsp">브랜드별 매출</a></li>
						<li><a href="/pt1/admin/salesStore.jsp">점주별 매출</a></li>
						<li><a href="/pt1/admin/salesProduct.jsp">상품별 매출</a></li>
					</ul></li>
				<li><a href="/pt1/admin/memList.jsp">관리</a>
					<ul>
						<li><a href="/pt1/admin/memList.jsp">회원관리</a></li>
						<li><a href="/pt1/admin/adminOrderList.jsp">주문조회</a></li>
						<li><a href="/pt1/admin/storeList.jsp">점주관리</a></li>
						<li><a href="/pt1/admin/brandList.jsp">브랜드관리</a></li>
						<li><a href="/pt1/admin/productList.jsp">상품관리</a></li>
						<li><a href="/pt1/inquiry/admininquiryList.jsp">문의관리</a></li>
						<li><a href="/pt1/admin/adReviewList.jsp">리뷰관리</a></li>
					</ul></li>
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a>
				<ul>
					<li><a href="/pt1/board/noticeMain.jsp">공지사항</a></li>
					<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
				</ul></li>
				<li><a href="/pt1/message/adminMsList.jsp">메시지</a>
					<ul>
						<li><a href="/pt1/message/adminMsList.jsp">메시지 목록</a></li>
						<li><a href="/pt1/message/adminMs.jsp">메시지보내기</a></li>
						<li><a href="/pt1/message/adminMsList.jsp">보낸 메시지함</a></li>
					</ul></li>
			</ul>
		</div>
	</header>
</body>
</html>