<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page language="java" import="java.text.*,java.sql.*" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>COMP322: Introduction to Databases</title>
		</head>

		<body>
			<% 
				if (request.getParameter("price")==""){
					out.println("잘못된 입력입니다.<p>");
					out.println("<button name=\"button\" onclick= \"location.href='search_medicine.html'\">이전으로 돌아가기</button>");
					
				}
				else{
					String serverIP=(String)session.getAttribute("serverIP"); 
					String strSID=(String)session.getAttribute("strSID");  
					String portNum=(String)session.getAttribute("portNum"); 
					String user=(String)session.getAttribute("user");  
					String pass=(String)session.getAttribute("pass");  
					String url=(String)session.getAttribute("url"); 
				Connection conn=null; PreparedStatement pstmt1,pstmt2,pstmt3,pstmt4,pstmt5; ResultSet rs1,rs2,rs3,rs4,rs5;
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn=DriverManager.getConnection(url,user,pass);
				//query1====================================
				String query1="select name, price, drug_type, dosing_interval, info "+ "from medicine " + "where price<=" +
				request.getParameter("price") + " and name like'%" + request.getParameter("m_name") + "%' and drug_type='" +
				request.getParameter("type")+ "' and info like'%" + request.getParameter("Condition") + "%'";
				System.out.println(query1); 
				pstmt1=conn.prepareStatement(query1); 
				rs1=pstmt1.executeQuery(); 
				out.println("<h4>------ 약 결과 --------</h4>");

				 out.println("<table border=\"1\">");
					ResultSetMetaData rsmd1 = rs1.getMetaData();
					int cnt = rsmd1.getColumnCount();
					for(int i =1;i<=cnt;i++){ out.println("<th>"+rsmd1.getColumnName(i)+"</th>");
						}
						while(rs1.next()){
						out.println("<tr>");
							out.println("<td>"+rs1.getString(1)+"</td>");
							out.println("<td>"+rs1.getString(2)+"</td>");
							out.println("<td>"+rs1.getString(3)+"</td>");
							out.println("<td>"+rs1.getString(4)+"</td>");
							out.println("<td>"+rs1.getString(5)+"</td>");
							System.out.println("<td>"+rs1.getString(5)+"</td>"); // console
							out.println("</tr>");
						}
						out.println("</table>");
						out.println("<button name=\"button\" onclick= \"location.href='main.html'\">메인 화면으로 돌아가기</button>");
						rs1.close();
						pstmt1.close();
						}
						%>
		</body>

		</html>

		
		