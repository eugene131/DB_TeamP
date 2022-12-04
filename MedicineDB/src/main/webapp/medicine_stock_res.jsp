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
h2 {
	position: absolute;
	width: 1000px;
	height: 44px;
	left: calc(40% - 307px/2 - 0.5px);
	top: 300px;
	
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
.p1 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 350px;
	width: 50%;
}
.p2 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 345px;
	width: 50%;
}

.btn2 {
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
.btn3 {
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
</style>
		</head>

		<body>
		<h4>약국 검색 결과 &nbsp;&nbsp;&nbsp;
					<button onClick="location.href='chemist_menu.html'" id="back_btn">메뉴로 돌아가기</button></h4>
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
				String chemist_ID= request.getParameter("ID");
				String m_num= request.getParameter("medicine_num");
				//session.set다른 jsp에서 사용하기 위해서
				
				session.setAttribute("id",chemist_ID);
				session.setAttribute("medicine_num",m_num);
				String Ch_ID = (String)session.getAttribute("chemistID");
				if(!m_num.equals("")){
					//query====================================
					String query="select m.m_number, m.stock "
						+ "from M_STORE m inner join chemist c "
						+ "on m.pharmacy_num=c.pharmacy_num "
						+ "where c.ID = " + Ch_ID + " and m.m_number = " + request.getParameter("medicine_num");
					//System.out.println(query); 
					pstmt=conn.prepareStatement(query); 
					rs=pstmt.executeQuery(); %>
					
	  

					<% out.println("<table>");
						ResultSetMetaData rsmd1 = rs.getMetaData();
						int cnt = rsmd1.getColumnCount();
						int checkcount=0;
						for(int i =1;i<=cnt;i++){ 
							out.println("<th>"+rsmd1.getColumnName(i)+"</th>");
							}
							while(rs.next()){
								checkcount=1;
								out.println("<tr>");
								out.println("<td>"+rs.getString(1)+"</td>");
								out.println("<td>"+rs.getString(2)+"</td>");
								//System.out.println("<td>"+rs.getString(2)+"</td>"); // console
								out.println("</tr>");
							}
							out.println("</table>");
							if (checkcount==0){
								out.println("<h2>약을 추가 하시겠습니까?</h2>");
								out.println("<p class=\"p1\"> <button name=\"button\" onclick= \"location.href='m_insert.html'\" class=\"btn2\">예</button>");
								out.println("<button name=\"button\" onclick= \"location.href='medicine_stock.html'\" class=\"btn3\">아니오</button> </p>");//메인 화면으로 돌아
							}
							else{
								out.println("<h2>해당 약의 재고를 변경 하시겠습니까?</h2>");
								out.println("<p class=\"p1\"><button name=\"button\" onclick= \"location.href='update_medicine.html'\" class=\"btn2\">예</button>");
								out.println("<button name=\"button\" onclick= \"location.href='medicine_stock.html'\" class=\"btn3\">아니오</button> </p>");//메인 화면으로 돌아
					
								}
					
							rs.close();
							pstmt.close();
				}
				else{
					out.println("<h3>약 번호를 입력해주십시오.</h3>");
				}
				
						%>
		</body>

		</html>

		
		