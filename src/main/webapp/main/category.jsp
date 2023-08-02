<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
    <%-- 부 메뉴 숨겨놓기--%>
    ul ul{display:none;}
	<%-- 주 메뉴에 마우스 올렸을 때 부 메뉴 나오도록 설정--%>
    ul li:hover > ul {display:block;}
</style>

<body>
	<ul>
		<%-- 주 메뉴 --%>
		<li><a href="/pt1/classification/classification.jsp">카테고리</a>
			<ul>
				<%-- 부 메뉴 --%>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=beanie" method="post">
						<input type="hidden" value="beanie" name="category" maxlength="12">
						<input type="submit" value="beanie(hidden타입의 value값)" />
					</form>
				</li>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=beret" method="post">
						<input type="hidden" value="beret" name="category" maxlength="12">
						<input type="submit" value="beret(hidden타입의 value값)" />
					</form>
				</li>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=cap" method="post">
						<input type="hidden" value="cap" name="category" maxlength="12">
						<input type="submit" value="cap(hidden타입의 value값)" />
					</form>
				</li>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=hat" method="post">
						<input type="hidden" value="hat" name="category" maxlength="12">
						<input type="submit" value="hat(hidden타입의 value값)" />
					</form>
				</li>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=snapback" method="post">
						<input type="hidden" value="snapback" name="category" maxlength="12">
						<input type="submit" value="snapback(hidden타입의 value값)" />
					</form>
				</li>
				<li>
					<form action="/pt1/classification/classification.jsp?classificationName=etc" method="post">
						<input type="hidden" value="etc" name="category" maxlength="12">
						<input type="submit" value="etc(hidden타입의 value값)" />
					</form>
				</li>
			</ul>
		</li>
	</ul>
</body>
    
