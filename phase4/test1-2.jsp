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
	stmt = conn.createStatement();
	//out.println("Oracle Connected.\n");
}catch(SQLException ex) {
	ex.printStackTrace();
	out.println("Cannot get a connection: " + ex.getLocalizedMessage());
	out.println("Cannot get a connection: " + ex.getMessage());

}

int i = 0;
String compare1 = "";
String compare2 = "";
String date = request.getParameter("Date");
String medicine = request.getParameter("medicine");
String Id = (String)session.getAttribute("clientID");
ResultSet rs = null;

try {
	try {
		SimpleDateFormat test = new SimpleDateFormat("yyyy-MM-dd");
		test.setLenient(false);
		test.parse(date);
		}catch(ParseException e){
			out.println("올바른 형식이 아닙니다.<br>");
		}
	String sql ="select name from medicine";
	rs = stmt.executeQuery(sql);
	while(rs.next()) {
		compare1 = rs.getString(1);
		if(medicine.equals(compare1)) {
			i++;
			break;
		}
	}
	if(i == 0) {
		out.println("데이터베이스에 없는 약입니다.<br>");
	}
	
	else{
	sql = "select count(*) as cont from CASE_HISTORY where Client_ID =" + Id;
	rs = stmt.executeQuery(sql);
	int count = 0;
	if(rs.next()) {
		count = rs.getInt(1);
	}
	sql = "Insert INTO CASE_HISTORY VALUES(" + (count+1) + ", TO_DATE('" + date + "', 'yyyy-mm-dd'), '" + medicine +"','" + Id +"')";
	int res = stmt.executeUpdate(sql);
	if(res == 1)
		out.println("병력기록이 성공적으로 추가 되었습니다.<br>");
		conn.commit();
	}
	rs.close();
}catch(SQLException ex2) {
ex2.printStackTrace();
}

%>
<br><br>
<button onclick = "location.href = 'test1-1.html'">이전</button>

</body>
</html>