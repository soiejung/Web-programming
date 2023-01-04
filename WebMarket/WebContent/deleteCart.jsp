<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("cartId");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("cart.jsp");
		return;
	}
	
/*******************************************************************/
	//session.invalidate();
	PreparedStatement pstmt = null;	
	String sql = "DELETE FROM cart";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
/*******************************************************************/	
	response.sendRedirect("cart.jsp");
%>
