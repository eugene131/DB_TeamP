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
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

<% 
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "medicine";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	//System.out.println(url);
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	String clientID = request.getParameter("client_id");
	String chemistID = request.getParameter("chemist_id");
	
	
	//for session
	session.setAttribute("serverIP", serverIP);
	session.setAttribute("strSID", strSID);
	session.setAttribute("portNum", portNum);
	session.setAttribute("user",user);
	session.setAttribute("pass",pass);
	session.setAttribute("url",url);
	
	
	// client login
	if (chemistID==null && !clientID.equals("")){
		session.setAttribute("clientID",clientID);
		try {
			String sql = "SELECT ID"
					+ " FROM CLIENT"
					+ " WHERE ID = '"+clientID+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				// Fill out your code	
				rs.getString(1);
				cnt++;
			}
			if (cnt == 0) {
				out.println("존재하지 않는 clientID 입니다. 입력값: " +clientID+"<br>");
				out.println("<button onClick=\"location.href=\'main.html\'\">돌아가기</button><br>");
			}
			else {
				// *******************************************************
				// 합칠때 이동할 html 페이지 수정할 부분 **************************
				out.println("<button onClick=\"location.href=\'search_medicine.html\'\">약 검색</button><br>");
				out.println("<button onClick=\"location.href=\'shearch_p_name.html\'\">약국 검색</button><br>");
				out.println("<button onClick=\"location.href=\'client_order.html\'\">약 주문, 주문 조회</button><br>");
				out.println("<button onClick=\"location.href=\'test2-1.html\'\">병력 기록</button><br>");
				out.println("<button onClick=\"location.href=\'test4-1.jsp\'\">개인정보 수정</button><br><br>");
				out.println("<button onClick=\"location.href=\'main.html\'\">로그아웃</button><br>");
			}
			System.out.println("\n");
			//stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	else if (clientID==null && !chemistID.equals("")){
		session.setAttribute("chemistID",chemistID);
		try {
			String sql = "SELECT ID"
					+ " FROM CHEMIST"
					+ " WHERE ID = '"+chemistID+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				// Fill out your code	
				rs.getString(1);
				cnt++;
			}
			if (cnt == 0) {
				out.println("존재하지 않는 chemistID 입니다. 입력값: " +chemistID+"<br>");
				out.println("<button onClick=\"location.href=\'main.html\'\">돌아가기</button><br>");
			}
			else {
				// *******************************************************
				// 합칠때 이동할 html 페이지 수정할 부분 **************************
				out.println("<button onClick=\"location.href=\'test3-1.html\'\">고객 관리</button><br>");
				out.println("<button onClick=\"location.href=\'chemist_order_manage.jsp\'\">주문 관리</button><br>");
				out.println("<button onClick=\"location.href=\'medicine_stock.html\'\">약 재고 관리</button><br><br>");
				out.println("<button onClick=\"location.href=\'main.html\'\">로그아웃</button><br>");
			}
			System.out.println("\n");
			//stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	else{ 

		out.println("ID를 입력해 주세요.");
		
	}
	
%>

</body>
</html>
