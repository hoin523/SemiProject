<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.lec.beans.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	// Controller 로부터 결과 데이터 받음
ProductDTO[] arr = (ProductDTO[]) request.getAttribute("list");
%>
<!-- 메인 페이지  -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/b95da9d126.js"
	crossorigin="anonymous"></script>
<title>쇼핑</title>
<link rel="stylesheet" href="CSS/shop.css">

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="common/header.jsp"></jsp:include>
	<h1>쇼핑</h1>
	<br>
	<br>
	<%
		int totalCnt = 0;
	int cnt = 0;
	if (arr != null) {
		for (int i = 0; i < arr.length; i++) {
			totalCnt++;
		}
	}
	System.out.println("totalCNT: " + totalCnt);
	System.out.println("-------1: " + totalCnt / 4);
	System.out.println("-------2: " + totalCnt % 4);
	%>

	<!-- 컨텐츠B -->
	<section class="conF">

		<div class="containerF">
			<%
				if (session.getAttribute("c_num") != null) {
				int c_num = Integer.parseInt(((String) session.getAttribute("c_num")));
				if (c_num == 1) {
			%>
			<button class="editBt" onclick="location.href = 'shopWrite.do'">상품
				추가</button>

			<%
				} else {
			}

			}
			%>
		</div>
	</section>
	<%
		if (arr != null) {
		if (totalCnt % 4 == 0) {
			for (int i = 0; i < totalCnt / 4; i++) { // for 1
	%>
	<section class"=conD">
		<div id="dddd">
			<table>
				<%
					for (int j = 0; j < 4; j++) { // for 2
				%>
				<th><img src="img/<%=arr[cnt].getPro_name()%>.jpg"
					onclick="
					<%if (session.getAttribute("c_num") == null) {%>
						location.href='login.do'"
					<%} else {
					if (arr[cnt].getPro_cnt() == 0) {%>
					alert('재고소진')"
								<%} else {%>
					editOpen('<%=arr[cnt].getPro_name()%>','<%=arr[cnt].getPro_kind()%>',<%=arr[cnt].getPro_price()%>,<%=arr[cnt].getPro_num()%>,<%=arr[cnt].getPro_cnt()%>)"
					<%}
					}%>><br> 
					종류 : <%=arr[cnt].getPro_kind()%><br>
					가격 : <%=arr[cnt].getPro_price()%><br> 
					재고 : <%=arr[cnt].getPro_cnt()%><br>
					<%
						if (arr[cnt].getPro_cnt() == 0) {
					%>
					<button disabled>재고소진</button></th>
				<%
					} else {
					if (session.getAttribute("c_num") == null) {
					} else {
				%>
				<button	onclick="editOpen('<%=arr[cnt].getPro_name()%>','<%=arr[cnt].getPro_kind()%>',<%=arr[cnt].getPro_price()%>,<%=arr[cnt].getPro_num()%>,<%=arr[cnt].getPro_cnt()%>)">수정하기</button>
				<%
					}
				}
				%>
				</th>
				<%
					cnt++;
				if (cnt == totalCnt)
					break;
				} // end for 2
				%>
			</table>
		</div>
	</section>
	<%
		if (cnt == totalCnt)
		break;
	} // end for 1
	} else {
		for (int i = 0; i < totalCnt / 4 + 1; i++) { // for 1
			%>
			<section class"=conD">
				<div id="dddd">
					<table>
						<%
							for (int j = 0; j < 4; j++) { // for 2
						%>
						<th><img src="img/<%=arr[cnt].getPro_name()%>.jpg"
							onclick="
							<%if (session.getAttribute("c_num") == null) {%>
								location.href='login.do'"
							<%} else {
							if (arr[cnt].getPro_cnt() == 0) {%>
							alert('재고소진')"
										<%} else {%>
							editOpen('<%=arr[cnt].getPro_name()%>','<%=arr[cnt].getPro_kind()%>',<%=arr[cnt].getPro_price()%>,<%=arr[cnt].getPro_num()%>,<%=arr[cnt].getPro_cnt()%>)"
							<%}
							}%>><br> 
							종류 : <%=arr[cnt].getPro_kind()%><br>
							가격 : <%=arr[cnt].getPro_price()%><br> 
							재고 : <%=arr[cnt].getPro_cnt()%><br>
							<%
								if (arr[cnt].getPro_cnt() == 0) {
							%>
							
							<button disabled>재고소진</button></th>
						<%
							} else {
							if (session.getAttribute("c_num") == null) {
							} else {
						%>
						<button	onclick="editOpen('<%=arr[cnt].getPro_name()%>','<%=arr[cnt].getPro_kind()%>',<%=arr[cnt].getPro_price()%>,<%=arr[cnt].getPro_num()%>,<%=arr[cnt].getPro_cnt()%>)">수정하기</button>
						<%
							}
						}
						%>
						</th>
						<%
							cnt++;
						if (cnt == totalCnt)
							break;
						} // end for 2
						%>
					</table>
				</div>
			</section>
			<%
				if (cnt == totalCnt)
				break;
			} // end for 4
	} // end for 3
	} // end if
	%>


	<!-- 푸터 -->
	<jsp:include page="common/footer.jsp"></jsp:include>

</body>

<script type="text/javascript" src="JS/shop.js"></script>

</html>




