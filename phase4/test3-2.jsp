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
String URL = "jdbc:oracle:thin:@localhost:1600:xe";
String USER_UNIVERSITY ="test";
String USER_PASSWD ="comp322";
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
	conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD); 
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//out.println("Oracle Connected.\n");
}catch(SQLException ex) {
	ex.printStackTrace();
	out.println("Cannot get a connection: " + ex.getLocalizedMessage());
	out.println("Cannot get a connection: " + ex.getMessage());

}

ResultSet rs = null;
String Symptom = request.getParameter("Symptom");
String sql = null;
	try{
		
	sql = "select * from CLIENT, HAVE where Symptom_num in (select Symptom_num from Symptom where name ='" + Symptom +"') and ID = Client_ID";
	rs = stmt.executeQuery(sql);
	

	if(rs.next()){
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	out.println("------------" + Symptom + " 증상을 가진 고객 ------------");
	out.println("<br><br>");
	cnt -= 2;

	
	rs.beforeFirst();
	for(int t =1;t<=cnt;t++){
		out.println("<th>"+rsmd.getColumnName(t)+"</th>");
	}

	while(rs.next()) {
				
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			SimpleDateFormat checkDate = new SimpleDateFormat("yyyy-MM-dd");
			Date date = rs.getDate(4);
			out.println("<td>"+date+"</td>");
			out.println("<td>"+rs.getString(5)+"</td>");
			out.println("<td>"+rs.getString(6)+"</td>");;
			// html 
			//System.out.println("<td>"+rs.getString(3)+"</td>"); // console
			out.println("</tr>");
		}
	
	}
	else{
		out.println("조회된 기록이 없습니다<br>");
	}	
	
rs.close();

}
catch(SQLException ex2) {
	out.println("sql error = " + ex2.getMessage());
}

%>
<br><br>
<button onclick = "location.href = 'test3-1.html'">이전</button>
</body>
</html>