<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				String Ch_ID = (String)session.getAttribute("chemistID");
				String sql = "select pharmacy_num "
						+"from chemist "
						+"where ID="+Ch_ID;
				
				System.out.println(sql);
				pstmt=conn.prepareStatement(sql); 
				rs=pstmt.executeQuery(); 
				rs.next();
				System.out.println(rs.getString(1));
				String p_num=rs.getString(1);
				//query====================================
				String query="INSERT INTO M_STORE VALUES (" + request.getParameter("medicine_num") + "," + p_num + "," + request.getParameter("medicine_stock") + ")";
				System.out.println(query); 
				pstmt=conn.prepareStatement(query); 
				rs=pstmt.executeQuery(); %>
				<h4>------ insert complete --------</h4>

				
</body>
</html>