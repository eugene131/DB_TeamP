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
	<h4>주문 수정 &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'">메뉴로 돌아가기</button>
	</h4>
	
<%	
	
	// connect to MedicineDB
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
	
	
	// get order information
	String o_date = request.getParameter("o_date");
	String o_prescription = request.getParameter("o_prescription");
	String m_name = request.getParameter("m_name");
	String count = request.getParameter("count");
	
	String chemistID = (String)session.getAttribute("chemistID");
	String clientID = (String)session.getAttribute("o_clientID");
	String o_num = (String)session.getAttribute("o_num");
	
	
	String sql ="";
	String m_num ="";
	
	// value check
	// m_name check
	try {
		sql = "SELECT M_number, NAME"
				+ " FROM MEDICINE"
				+ " WHERE Name LIKE '%"+m_name+"%'"
				+ " ORDER BY M_number";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if (!rs.next()){ // medicine name error
			out.println("잘못된 주문입니다. 입력된 약 이름: "+m_name);
		}
		else {
			m_num = rs.getString(1);
		}
		
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(!m_num.equals("")){
		// insert order
		try {
			//stmt = conn.createStatement();
			
			sql = "UPDATE M_ORDER"
				+" SET Order_date = TO_DATE(\'"+o_date+"\',\'yyyy-mm-dd\'),"
				+" Prescription = "+o_prescription
				+" WHERE Order_num = "+o_num
				+" AND Chemist_ID = "+chemistID
				+" AND Client_ID = "+clientID;
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql = "UPDATE CONTAIN"
				+" SET M_number = "+m_num+","
				+" Count = "+count
				+" WHERE Order_num = "+o_num
				+" AND Chemist_ID = "+chemistID
				+" AND Client_ID = "+clientID;
					
					
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			out.println("주문이 수정되었습니다.<br>");
			//stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
%>
</body>
</html>