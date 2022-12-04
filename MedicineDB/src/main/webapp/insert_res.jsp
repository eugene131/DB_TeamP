<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.text.*,java.sql.*" %>
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
	width: 1000px;
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
input[type=number]{
	width:30%;
	border:2px solid #aaa;
	border-radius:4px;
	margin: 8px 0;
	outline: none;
	padding:8px;
	box-sizing: border-box;
	align-items: center;
	transition:.3s;
}

input[type=number]:focus{
	border-color:dodgerBlue;
	box-shadow:0 0 8px 0 dodgetBlue;
}
.p1 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 210px;
	width: 50%;
}
.p2 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 270px;
	width: 50%;
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
				String Ch_ID = (String)session.getAttribute("chemistID");
				String sql = "select pharmacy_num "
						+"from chemist "
						+"where ID="+Ch_ID;
				
				//System.out.println(sql);
				pstmt=conn.prepareStatement(sql); 
				rs=pstmt.executeQuery(); 
				rs.next();
				System.out.println(rs.getString(1));
				String p_num=rs.getString(1);
				String m_num = (String)session.getAttribute("medicine_num");
				String m_stock = request.getParameter("medicine_stock");
				if(!m_stock.equals("0") && !m_stock.equals("")){
					//query====================================
					String query="INSERT INTO M_STORE VALUES (" + m_num + "," + p_num + "," + m_stock + ")";
					//System.out.println(query); 
					pstmt=conn.prepareStatement(query); 
					rs=pstmt.executeQuery();
					out.println("<h4>정상적으로 추가되었습니다. &nbsp;&nbsp;&nbsp;");
					out.println("<button onClick=\"location.href='chemist_menu.html'\" id=\"back_btn\">메뉴로 돌아가기</button></h4>");
	  				
				}
				else{
					out.println("<h3>잘못된 수량입니다. </h3>");
					out.println("<h4><button onClick=\"location.href='chemist_menu.html'\" id=\"back_btn\">메뉴로 돌아가기</button></h4>");
	  				
				}
				%>
				 

</body>
</html>