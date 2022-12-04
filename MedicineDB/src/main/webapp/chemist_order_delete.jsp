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
<style>
.btn {
	margin: 8px 0;
	height: 35.33px;
	width: 100px;
	border: none;
	background: #648FFF;
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	border-radius: 4px;
	font-size: 15px;
	color: #FFFFFF;

}
#back_btn{
 	height: 35.33px;
	align-items: center;
	display: flex;
	border: none;
 	background: #606060;
 	top: 500px;
 	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	border-radius: 4px;
	font-size: 15px;
	color: #FFFFFF;
	width: 30%;
}
h4 {
	position: absolute;
	width: 700px;
	height: 44px;
	left: calc(50% - 307px/2 - 0.5px);
	top: 100px;
	
	font-family: 'Inter';
	font-style: normal;
	font-weight: 700;
	font-size: 36px;
	line-height: 44px;
	
	display: flex;
	align-items: center;
	text-align: center;
	
	color: #000000;
}
h3 {
	position: absolute;
	width: 1000px;
	height: 44px;
	left: calc(50% - 307px/2 - 0.5px);
	top: 200px;
	
	font-family: 'Inter';
	font-style: normal;
	font-weight: 700;
	font-size: 25px;
	line-height: 44px;
	
	display: flex;
	align-items: center;
	text-align: center;
	
	color: #000000;
}
</style>
</head>
<body>
	<h4>주문 삭제 &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'" id="back_btn">메뉴로 돌아가기</button>
	</h4>
<%
	//connect to MedicineDB
	String serverIP = (String)session.getAttribute("serverIP");
	String strSID = (String)session.getAttribute("strSID");
	String portNum = (String)session.getAttribute("portNum");
	String user = (String)session.getAttribute("user");
	String pass = (String)session.getAttribute("pass");
	String url = (String)session.getAttribute("url");

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
		
		out.println("<h3>주문이 삭제되었습니다.</h3>");
		//stmt.close(); 
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
%>
</body>
</html>