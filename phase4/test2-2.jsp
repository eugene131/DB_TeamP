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

ResultSet rs = null;

try {
	String Id = (String)session.getAttribute("clientID");
	//stmt = conn.createStatement();
	//String sql = "select Record_date, Record_name from Case_history, Client where Client.ID = Case_history.Client_ID and Client.Name ='"+ Name +"' and Client.Phone_num = '"+Phone_num+"' and Client.Birthday = '"+Birth+"'";
	String sql = "select distinct Record_date, Record_name from Case_history, Client where Client.ID = Case_history.Client_ID and Client.ID = '"+Id+"'";
	rs = stmt.executeQuery(sql);

	if(rs.next()){
		
		out.println("<table border=\"1\">");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("------------ 병력 기록 조회 화면 ------------");
		out.println("<br><br>");

		
		rs.beforeFirst();
		for(int t =1;t<=cnt;t++){
			out.println("<th>"+rsmd.getColumnName(t)+"</th>");
		}

		while(rs.next()) {
					
				out.println("<tr>");
				SimpleDateFormat checkDate = new SimpleDateFormat("yyyy-MM-dd");
				Date date = rs.getDate(1);
				out.println("<td>"+date+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				// html 
				//System.out.println("<td>"+rs.getString(3)+"</td>"); // console
				out.println("</tr>");
			}
		
		}
	
	else {
		out.println("조회된 기록이 없습니다");
	}
	rs.close();
}catch(SQLException ex2) {
	out.println("sql error = " + ex2.getMessage());
}

%>
<br><br>
<button onclick = "location.href = 'test2-1.html'">이전</button>
</body>
</html>