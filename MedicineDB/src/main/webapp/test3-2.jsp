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
	width: 400px;
	height: 44px;
	left: calc(50% - 307px/2 - 0.5px);
	top: 100px;
	
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
table {
  border-collapse: separate;
  border-spacing: 0;
  width: 80%;
  left: 120px;
  border: none;
  position: absolute;
  height: 44px;
  top: 210px;
  align-items: center;
  text-align: center;
}
th,
td {
  padding: 6px 15px;
}
th {
  background: #42444e;
  color: #fff;
  text-align: left;
}
tr:first-child th:first-child {
  border-top-left-radius: 6px;
}
tr:first-child th:last-child {
  border-top-right-radius: 6px;
}
td {
  border-right: 1px solid #c6c9cc;
  border-bottom: 1px solid #c6c9cc;
}
td:first-child {
  border-left: 1px solid #c6c9cc;
}
tr:nth-child(even) td {
  background: #eaeaed;
}
tr:last-child td:first-child {
  border-bottom-left-radius: 6px;
}
tr:last-child td:last-child {
  border-bottom-right-radius: 6px;
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
	out.println("<h4> &nbsp;" + Symptom + "&nbsp;증상을 가진 고객 &nbsp;&nbsp;&nbsp;"+
	"<button onclick = \"location.href = 'test3-1.html'\" id=\"back_btn\">이전으로</button>");
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

</body>
</html>