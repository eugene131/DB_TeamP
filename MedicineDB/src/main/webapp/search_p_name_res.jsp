<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page language="java" import="java.text.*,java.sql.*" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="EUC-KR">
			<title>COMP322: Introduction to Databases</title>
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
				<h4>------ 약국 검색 결과 --------</h4>

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
						out.println("<br><button name=\"button\" onclick= \"location.href='client_menu.html'\">메인 화면으로 돌아가기</button>");
						rs.close();
						pstmt.close();
						%>
		</body>

		</html>

		
		