<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
	<h4>약 주문 기록 조회
	&nbsp;&nbsp;&nbsp;<button name="button" onclick= "location.href='client_order.html'" id="back_btn">이전으로</button>
	</h4>
<%
	String serverIP = (String)session.getAttribute("serverIP");
	String strSID = (String)session.getAttribute("strSID");
	String portNum = (String)session.getAttribute("portNum");
	String user = (String)session.getAttribute("user");
	String pass = (String)session.getAttribute("pass");
	String url = (String)session.getAttribute("url");
	//System.out.println(url);
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	// get clientID by session
	String clientID = (String)session.getAttribute("clientID");
	
	// get medicine information
	String m_name = request.getParameter("m_name");
	String m_num = request.getParameter("m_num");
	
	
	try {
		// 이름 조회
		String sql = "SELECT Name FROM CLIENT WHERE ID = '" + clientID+"'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		int cnt = 0;
		rs.next();
		String c_name = rs.getString(1);
		
		//System.out.println(m_name);
		//System.out.println(m_num);
		
		if (m_num==null){ //약 이름으로 검색 클릭
			try {
				//stmt = conn.createStatement();
				sql = "SELECT M.Name as Medicine_name, O.Order_date, C.Count, O.Prescription, Ch.Name as CHEMIST_Name"
						+ " FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O, CHEMIST Ch"
						+ " WHERE C.Order_num = O.Order_num"
						+ " AND C.Chemist_ID = O.Chemist_ID"
						+ " AND C.Chemist_ID = Ch.ID"
						+ " AND C.Client_ID = O.Client_ID"
						+ " AND M.Name LIKE '%"+m_name+"%'"
						+ " AND C.Client_ID = '"+clientID+"'"
						
						+ " ORDER BY O.Order_date";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				out.println("<table border=\"1\">");
				ResultSetMetaData rsmd = rs.getMetaData();
				cnt = rsmd.getColumnCount();
				int m_count = 0;
				for(int i =1;i<=cnt;i++){
					out.println("<th>"+rsmd.getColumnName(i)+"</th>");
				}
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>"+rs.getString(1)+"</td>"); 
					SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
					Date o_date = rs.getDate(2);
					String order_day = sdfDate.format(o_date);
					out.println("<td>"+order_day+"</td>"); 
					out.println("<td>"+rs.getString(3)+"</td>"); 
					int prescript = rs.getInt(4);
					if (prescript == 1)
						out.println("<td>O</td>"); 
					else
						out.println("<td>X</td>"); 
					out.println("<td>"+rs.getString(5)+"</td>"); 
					out.println("</tr>");		
					m_count++;
				}
				if (m_count == 0)
					out.println(m_name+" 약으로 조회된 주문기록이 없습니다.");
				out.println("</table>");
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if (m_name==null){ //약 번호로 검색 클릭
			if (m_num.equals("")){
				out.println("<h3>약 번호를 입력해 주세요.<br><br></h3>");
			}
			else{
				try {
					//stmt = conn.createStatement();
					sql = "SELECT M.Name as Medicine_name, O.Order_date, C.Count, O.Prescription, Ch.Name as CHEMIST_Name"
								+ " FROM CONTAIN C JOIN MEDICINE M ON C.M_number = M.M_number, M_ORDER O, CHEMIST Ch"
								+ " WHERE C.Order_num = O.Order_num"
								+ " AND C.Chemist_ID = O.Chemist_ID"
								+ " AND C.Chemist_ID = Ch.ID"
								+ " AND C.Client_ID = O.Client_ID"
								+ " AND M.M_number = "+m_num+""
								+ " AND C.Client_ID = '"+clientID+"'"
								+ " ORDER BY O.Order_date";
					
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					out.println("<table border=\"1\">");
					ResultSetMetaData rsmd = rs.getMetaData();
					cnt = rsmd.getColumnCount();
					int m_count = 0;
					for(int i =1;i<=cnt;i++){
						out.println("<th>"+rsmd.getColumnName(i)+"</th>");
					}
					while(rs.next()){
						out.println("<tr>");
						out.println("<td>"+rs.getString(1)+"</td>"); 
						SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						Date o_date = rs.getDate(2);
						String order_day = sdfDate.format(o_date);
						out.println("<td>"+order_day+"</td>"); 
						out.println("<td>"+rs.getString(3)+"</td>"); 
						int prescript = rs.getInt(4);
						if (prescript == 1)
							out.println("<td>O</td>"); 
						else
							out.println("<td>X</td>"); 
						out.println("<td>"+rs.getString(5)+"</td>"); 
						out.println("</tr>");		
						m_count++;
					}
					if (m_count == 0)
						out.println("해당 약번호("+m_num+")의 약으로 조회된 주문기록이 없습니다.<br>");
					out.println("</table>");
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
		}
		
		//stmt.close(); 
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>
</body>
</html>