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
	<h4>약 주문하기&nbsp;&nbsp;&nbsp;
	<button onClick="location.href='client_menu.html'">메뉴로 돌아가기</button>
	</h4>
	<br>
<%
	String serverIP = (String)session.getAttribute("serverIP");
	String strSID = (String)session.getAttribute("strSID");
	String portNum = (String)session.getAttribute("portNum");
	String user = (String)session.getAttribute("user");
	String pass = (String)session.getAttribute("pass");
	String url = (String)session.getAttribute("url");
	//System.out.println(url);
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	// get clientID by session
	String clientID = (String)session.getAttribute("clientID");
	
	// get order information
	String o_num = request.getParameter("o_num");
	String m_name = request.getParameter("m_name");
	String m_count = request.getParameter("m_count");
	String m_prescription = request.getParameter("m_prescription");
	String chemist_name = request.getParameter("chemist_name");
	Date date = new Date(System.currentTimeMillis());
	SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
	String o_date = sdfDate.format(date);
	
	
	String sql ="";
	String chemistID ="";
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
	// chemist_name check
	try {
			sql = "SELECT ID, NAME"
					+ " FROM CHEMIST"
					+ " WHERE Name = '"+chemist_name+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (!rs.next()){ // medicine name error
				out.println("잘못된 주문입니다. 입력된 약사 이름: "+chemist_name);
			}
			else{
				chemistID = rs.getString(1);
			}
			
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	// insert order
	try {
			//stmt = conn.createStatement();
			
			sql = "INSERT INTO M_ORDER VALUES ("
					+ o_num + ", TO_DATE('" + o_date
							+ "', 'yyyy-mm-dd'), "+m_prescription
							+ ", "+chemistID+", "+clientID+")";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			sql = "INSERT INTO CONTAIN VALUES ("
					+ m_num + ", " + o_num
							+ ", " + m_count
							+ ", "+chemistID+", '"+clientID+"')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			out.println("주문이 접수되었습니다.<br>");
			//stmt.close(); 
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
%>
</body>
</html>