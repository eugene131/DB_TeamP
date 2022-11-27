<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>주문 삭제 &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'">메뉴로 돌아가기</button>
	</h4>
<%
	//connect to MedicineDB
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "medicine";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);

	//get order information
	String clientID = request.getParameter("CLIENT_ID");
	String clientName = request.getParameter("CLIENT_NAME");
	String o_num = request.getParameter("ORDER_NUM");
	String o_date = request.getParameter("ORDER_DATE");
	String o_prescription = request.getParameter("PRESCRIPTION");
	String m_name = request.getParameter("MEDICINE_NAME");
	String count = request.getParameter("COUNT");
	
	String chemistID = (String)session.getAttribute("chemistID");
	
	try {
		//stmt = conn.createStatement();
		
		String sql = "DELETE FROM M_ORDER"
				+ " WHERE Order_num = "+o_num
						+ " AND Client_ID = '"+clientID+"'"
						+ " AND Chemist_ID = "+chemistID;
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		out.println("주문이 삭제되었습니다.<br>");
		//stmt.close(); 
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
%>
</body>
</html>