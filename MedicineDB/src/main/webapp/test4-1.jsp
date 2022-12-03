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

<button onClick="location.href='client_menu.html'">메뉴로 돌아가기</button><br>

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

out.println("-------- [ "+clientID+" 님의 개인정보 ] --------<br><br>");

ResultSet rs = null;
try {
	//stmt = conn.createStatement();
	// Q1: Complete your query.
	String sql = "SELECT Name, Sex, Birthday, C_address, Phone_num"
			+ " FROM CLIENT"
			+ " WHERE ID = "+clientID;
	rs = stmt.executeQuery(sql);
	
	rs.next();
	String c_name = rs.getString(1);
	String c_sex = rs.getString(2);
	SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy년 MM월 dd일");
	Date Birthday = rs.getDate(3);
	String c_birthday = sdfDate.format(Birthday);
	String c_address = rs.getString(4);
	String c_phone_num = rs.getString(5);
	out.println("이름: "+c_name + "<br>");
	if (c_sex.equals("M"))
		out.println("성별: 남" + "<br>");
	else
		out.println("성별: 여" + "<br>");
	out.println("생일: "+c_birthday + "<br>");
	out.println("주소: "+c_address + "<br>");
	out.println("전화번호: "+c_phone_num + "<br>");
	out.println("<br><br>");
}catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

%>

수정하시겠습니까?
<button onclick = "location.href='test4-2.jsp'"> 네 </button>
<button onclick = "location.href='test4-4.jsp'"> 아니오 </button>




</body>
</html>