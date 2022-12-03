<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page language="java" import="java.text.*,java.sql.*" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="EUC-KR">
			<title>COMP322: Introduction to Databases</title>
		
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
			<% String serverIP=(String)session.getAttribute("serverIP"); 
			String strSID=(String)session.getAttribute("strSID");  
			String portNum=(String)session.getAttribute("portNum"); 
			String user=(String)session.getAttribute("user");  
			String pass=(String)session.getAttribute("pass");  
			String url=(String)session.getAttribute("url");
				Connection conn=null; 
				PreparedStatement pstmt; 
				ResultSet rs;
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn=DriverManager.getConnection(url,user,pass);
				//query====================================
				String query="select distinct p.name, p.Address "//쿼리문 입력
					+ "from pharmacy p inner join m_store s "
					+ "on p.pharmacy_num=s.pharmacy_num "
					+ "inner join medicine m "
					+ "on s.m_number=m.m_number "
					+ "where m.name like '%" + request.getParameter("m_name") + "%' and p.Address like '%" + request.getParameter("p_address")
					+ "%'";
				//System.out.println(query); 
				pstmt=conn.prepareStatement(query); 
				rs=pstmt.executeQuery(); %>
				<h4> 약국 검색 결과 
				&nbsp;&nbsp;&nbsp;<button name="button" onclick= "location.href='client_menu.html'" id="back_btn">메인 화면으로 돌아가기</button>
				</h4>
				

				<% out.println("<table border=\"1\">");
					ResultSetMetaData rsmd1 = rs.getMetaData();
					int cnt = rsmd1.getColumnCount();
					for(int i =1;i<=cnt;i++){ 
						out.println("<th>"+rsmd1.getColumnName(i)+"</th>");
						}
						while(rs.next()){
						out.println("<tr>");
							out.println("<td>"+rs.getString(1)+"</td>");
							out.println("<td>"+rs.getString(2)+"</td>");
							//System.out.println("<td>"+rs.getString(2)+"</td>"); // console
							out.println("</tr>");
						}
						out.println("</table>");
					
						rs.close();
						pstmt.close();
						%>
		</body>

		</html>

		
		