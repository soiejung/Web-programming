<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ include file="dbconn.jsp" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<%

	 String cartId = session.getId();
	
%>

<title>장바구니</title>
</head>
<body>
	<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left"><a href="./deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-danger">삭제하기</a></td>
					<td align="right"><a href="./shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-success">주문하기</a></td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%				
				/*********************************************************************/
						Statement stmt = conn.createStatement();
						String sql = "SELECT * , COUNT(productId) as cnt , SUM(price) as total FROM cart group by productId";
						ResultSet rs = stmt.executeQuery(sql);
						int sum = 0;
							
				%>
				<%
					while(rs.next()){
						sum += rs.getInt("total");
				%>

				<tr>
					<td><%=rs.getString("productId")%> - <%=rs.getString("productName") %></td>
					<td><%=rs.getInt("price") %></td>
					<td><%=rs.getInt("cnt") %>
					<td><%=rs.getInt("total")%></td>
					<td><a href="./removeCart.jsp?id=<%=rs.getString("productId") %> " class = "badge badge-danger"> 삭제</a></td>
				</tr>
				
				
				<%
					}
					if (stmt != null)
						stmt.close();
					if (conn != null)
						conn.close();
				/*********************************************************************/
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
			<a href="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
