<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%request.setCharacterEncoding("utf-8"); %>
<html>
   <head>
      <title>main.jsp</title>
      <!-- <link rel="stylesheet" type="text/css" href="/pt1/main/css/style.css"> -->
      <link rel="stylesheet" type="text/css" href="/pt1/resources/css/main.css">
   </head>
   <style>
		/* 조회수 구매순 버튼*/
		.proSort {
			display: flex;
			text-align: center;
		}
		
		.proSort input {
			font-family: 'TheJamsil5Bold', sans-serif;
			background-color: #fff;
			width: 100px;
			height: 50px;
			border: 1px solid #212121;
			color: #212121;
			font-size: 1em;
			font-weight: bold;
			text-align: center;
			margin: 5px;
		}
	</style>
   <body>
      <header>
         <h1>PT1 STORE</h1>
         <div class="top1">
            <%-- 검색창에 text 입력하면 해당 text의 모든 상품 출력--%>
            <form action="/pt1/main/goods_search.jsp" method="post">
               <input type="text" name="pname" placeholder="상품이름" maxlength="12">
               <input type="submit" value="검색" />
            </form>
            
            <div class="login">
               <ul>
               <%
               //관리자 (3), 점주 (2), 회원 (1) 의 레벨 받아옴
               String admid=(String)session.getAttribute("admId");      //관리자 session
               String store_id=(String)session.getAttribute("stoId");   //점주 session
               String memid=(String)session.getAttribute("memId");      //회원 session
               String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)    
               String best = request.getParameter("best");
               // 로그아웃 상태 (세션받아올 게 없는 상태)
               if(level_num==null){ %>
                  <%-- 관리자 로그인 페이지로 이동 --%>
                  <li><a href="/pt1/admin/adminloginForm.jsp">관리자 로그인</a></li>
                  <%-- 점주 로그인 페이지로 이동 --%>
                  <li><a href="/pt1/store/storeloginForm.jsp">점주 로그인</a></li>
                  <%-- 회원 로그인 페이지로 이동 --%>
                  <li><a href="/pt1/member/loginForm.jsp">고객 로그인</a></li>
               <%}else if(level_num.equals("3")){%>
					<li><a href="/pt1/admin/adminmypage.jsp">마이페이지</a></li>
					<li><a href="/pt1/member/logoutForm.jsp">로그아웃</a></li>
				<%} else if(level_num.equals("2")){%>
                  <%--로그인 상태이므로 로그아웃 페이지로 이동--%>
					<li><a href="/pt1/store/storePage.jsp">마이페이지</a></li>
					<li><a href="/pt1/member/logoutForm.jsp">로그아웃</a></li>
				<%} else if(level_num.equals("1")){ %>
                     <%--로그인 상태이므로 로그아웃 페이지로 이동--%>
                  <li><a href="/pt1/member/mypage.jsp">마이페이지</a></li>
                  <li><a href="/pt1/cart/cartForm.jsp">장바구니</a></li>
                  <li><a href="/pt1/member/logoutForm.jsp">로그아웃</a></li>
               <%} %>
               </ul>
            </div>
         </div>
         <div id="menu_bar">
         <%if(level_num!=null){
               // level_num이 3일 경우 (레벨 3 =>관리자)
               if(level_num.equals("3")){%>
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
						<li><a href="/pt1/message/adminMs.jsp">메시지보내기</a></li>
						<li><a href="/pt1/message/adminMsList.jsp">보낸 메시지함</a></li>
					</ul></li>
			</ul>
			<%
			//level_num이 2일 경우 (레벨 2 =>점주)
			} else if (level_num.equals("2")) {
			%>
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
				<li><a href="/pt1/store/salesAll.jsp">매출 조회</a>
					<ul>
						<li><a href="/pt1/store/salesAll.jsp">기간내 매출 상세</a></li>
						<li><a href="/pt1/store/salesDaily.jsp">일별 매출</a></li>
						<li><a href="/pt1/store/salesProduct.jsp">상품 매출</a></li>
					</ul></li>
				<li><a href="/pt1/store/productList.jsp">관리</a>
					<ul>
						<li><a href="/pt1/store/productList.jsp">상품관리</a></li>
						<li><a href="/pt1/p_inquiry/storeinquiryList.jsp">문의관리</a></li>
						<li><a href="/pt1/store/orderList.jsp">주문관리</a></li>
						<li><a href="/pt1/delivery/deliveryCheck.jsp">배송관리</a></li>
						<li><a href="/pt1/store/stockCheck.jsp">재고관리</a></li>
						<li><a href="/pt1/store/brandList.jsp">브랜드관리</a></li>
						<li><a href="/pt1/store/reviewList.jsp">리뷰관리</a></li>
					</ul></li>

				<li><a href="/pt1/inquiry/inquiryList.jsp">문의</a>
					<ul>
						<li><a href="/pt1/inquiry/inquiryForm.jsp">문의하기</a></li>
						<li><a href="/pt1/inquiry/inquiryMyList.jsp">내 문의</a></li>
					</ul></li>
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a>
					<ul>
						<li><a href="/pt1/board/noticeMain.jsp">공지사항</a></li>
						<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
					</ul></li>
				<li><a href="/pt1/message/admin_MessageMain.jsp">받은 메시지</a></li>
			</ul>
			<%
			//level_num이 1일 경우 (레벨 1 =>회원)
			} else if (level_num.equals("1")) {
			%>
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
						<li><a href="/pt1/inquiry/inquiryForm.jsp">문의하기</a></li>
						<li><a href="/pt1/inquiry/inquiryMyList.jsp">내 문의</a></li>
					</ul></li>
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a>
					<ul>
						<li><a href="/pt1/board/noticeMain.jsp">공지사항</a></li>
						<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
					</ul></li>
			</ul>
			<%
			}
			} else {
			%>
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
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a>
				<ul>
					<li><a href="/pt1/board/noticeMain.jsp">공지사항</a></li>
					<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
				</ul></li>
			</ul>
			<%
			}
			%>
         </div>
		</header>
		<div>
		<!-- 
		<div class="product-grid">
			<%-- 카테고리 파일 include --%>
			<jsp:include page="category.jsp" flush="true" />
		</div>
		 -->
                  <section class="products">
                     <div class="product-grid">
					<div class="proSort">
						<form action="/pt1/main/main.jsp?best=read" method="post">
							<input class="proSort" type="submit" value="조회 많은 순" />
						</form>
						<form action="/pt1/main/main.jsp?best=purchase" method="post">
							<input class="proSort" type="submit" value="구매 많은 순" />
						</form>
					</div>
				<%
				//best 파라미터가 없는 경우 (홈페이지 처음 들어왔을 경우) or 조회순 버튼을 누른 경우 조회순으로 상품 10개 출력
				if (best == null || best.equals("read")) {
				%>
                  <div>
                      <jsp:include page="../product/bestReadProduct.jsp" flush="false" />
                  </div>
                  <%
                  //구매순 버튼을 누른 경우 구매순으로 상품 10개 출력
                  } else if(best.equals("purchase")){%>
                  <div>
                      <jsp:include page="../product/bestPurchaseProduct.jsp" flush="false" />
                  </div>
                  <%}%>
                     </div>
                </section>
      </div>
	<footer class="footerB">
		<p>Author: Hege Refsnes</p>
		<p><a href="mailto:html@example.com">html@example.com</a></p>
		<p>Copyright © 2023 team pt1 All rights reserved.</p>
		<address>Contact webmaster for more information.
			02-6020-0052</address>
	</footer>
</body>
</html>
