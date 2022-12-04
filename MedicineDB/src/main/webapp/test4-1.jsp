<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.text.*" %>
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
	background: #47C83E;
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	border-radius: 4px;
	font-size: 15px;
	color: #FFFFFF;

}
.btn2 {
	margin: 8px 0;
	height: 35.33px;
	width: 100px;
	border: none;
	background: #F15F5F;
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
.p1 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 210px;
	width: 50%;
}
.p2 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 250px;
	width: 50%;
}
.p3 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 290px;
}
.p4 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 330px;
}
.p5 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 370px;
}
.p6 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 440px;
}
</style>
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

out.println("<h4>"+clientID+" 님의 개인정보 &nbsp;&nbsp;&nbsp; <button onClick=\"location.href=\'client_menu.html\'\" id=\"back_btn\">메뉴로 돌아가기</button></h4> ");

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
	out.println("<p class=\"p1\"> 이름: "+c_name + "<br></p>");
	if (c_sex.equals("M"))
		out.println("<p class=\"p2\"> 성별: 남" + "<br></p>");
	else
		out.println("<p class=\"p2\"> 성별: 여" + "<br></p>");
	out.println("<p class=\"p3\"> 생일: "+c_birthday + "<br></p>");
	out.println("<p class=\"p4\"> 주소: "+c_address + "<br></p>");
	out.println("<p class=\"p5\"> 전화번호: "+c_phone_num + "<br></p>");
	out.println("<br><br>");
}catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

%>

<p class="p6">수정하시겠습니까?
<button onclick = "location.href='test4-2.jsp'" class="btn"> 네 </button>
<button onclick = "location.href='test4-4.jsp'" class="btn2"> 아니오 </button>
</p>



</body>
</html>