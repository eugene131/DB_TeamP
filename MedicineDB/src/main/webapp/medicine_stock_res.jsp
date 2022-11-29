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
				out.println(url); 
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
				//query====================================
				String query="select m.m_number, m.stock "
					+ "from M_STORE m inner join chemist c "
					+ "on m.pharmacy_num=c.pharmacy_num "
					+ "where c.ID = " + Ch_ID + " and m.m_number = " + request.getParameter("medicine_num");
				System.out.println(query); 
				pstmt=conn.prepareStatement(query); 
				rs=pstmt.executeQuery(); %>
				<h4>------ 약국 검색 결과 --------</h4>

				<% out.println("<table border=\"1\">");
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
							System.out.println("<td>"+rs.getString(2)+"</td>"); // console
							out.println("</tr>");
						}
						out.println("</table>");
						if (checkcount==0){
							out.println("약을 추가 하시겠습니까?");
							out.println("<button name=\"button\" onclick= \"location.href='m_insert.html'\">예</button>");
							out.println("<button name=\"button\" onclick= \"location.href='main.html'\">메인 화면으로 돌아가기</button>");//메인 화면으로 돌아
						}
						else{
							out.println("해당 약의 재고를 변경 하시겠습니까?");
							out.println("<button name=\"button\" onclick= \"location.href='update_medicine.html'\">예</button>");
							out.println("<button name=\"button\" onclick= \"location.href='main.html'\">메인 화면으로 돌아가기</button>");//메인 화면으로 돌아
				
							}
				
						rs.close();
						pstmt.close();
						%>
		</body>

		</html>

		
		