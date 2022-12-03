<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%


String user = (String)session.getAttribute("user");
String pass = (String)session.getAttribute("pass");
String url = (String)session.getAttribute("url");
Connection conn = null; // Connection object
Statement stmt = null;	// Statement object

//out.print("Driver Loading: ");
try {
	// Load a JDBC driver for Oracle DBMS
	Class.forName("oracle.jdbc.driver.OracleDriver");
	// Get a Connection object 
	//out.println("Success!");
}catch(ClassNotFoundException e) {
	out.println("error = " + e.getMessage());
}


// Make a connection
try{
	conn = DriverManager.getConnection(url, user, pass); 
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//out.println("Oracle Connected.\n");
}catch(SQLException ex) {
	ex.printStackTrace();
	out.println("Cannot get a connection: " + ex.getLocalizedMessage());
	out.println("Cannot get a connection: " + ex.getMessage());

}

String clientID = (String)session.getAttribute("clientID");

ResultSet rs = null;
String sql = null;

	String address = request.getParameter("address");
	String phone_num = request.getParameter("phone_num");
	if (address.length() == 0) {
		out.println("주소를 입력해주십시오.");
	}
	else if (phone_num.length() != 11) {
		out.println("잘못된 전화번호입니다.");
	}
	else {
		sql = "UPDATE CLIENT"
				+ " SET C_address = '"+address+"', Phone_num = '"+phone_num+"' "
						+ "WHERE ID = '"+clientID+"'";
		rs = stmt.executeQuery(sql);
		
		out.println("성공적으로 수정하였습니다.");
		
	}
	


%>

<button onclick = "location.href = 'test4-1.jsp'">개인 정보 화면으로</button>

</body>
</html>