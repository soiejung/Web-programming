<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ include file="dbconn.jsp" %>
<%
	
	String id = request.getParameter("id");
	
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}

	ProductRepository dao = ProductRepository.getInstance();

	Product product = dao.getProductById(id);
	if (product == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
	}

	ArrayList<Product> goodsList = dao.getAllProducts();
	Product goods = new Product();
	for (int i = 0; i < goodsList.size(); i++) {
		goods = goodsList.get(i);
		if (goods.getProductId().equals(id)) { 			
			break;
		}
	}
	
/*******************************************************************/
	
	PreparedStatement pstmt = null;	
	String cartId = session.getId();
	String userId = (String)session.getAttribute("sessionId");
	String sql = "insert into cart values(?,?,?,?,?)";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, cartId);
	pstmt.setString(2, userId);
	pstmt.setString(3, id);
	pstmt.setString(4, product.getPname());
	pstmt.setInt(5, product.getUnitPrice());
	pstmt.executeUpdate();
	
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
/*********************************************************************/	

	response.sendRedirect("product.jsp?id=" + id);
	

%>