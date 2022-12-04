<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" session="true" import="java.text.*,java.sql.*, java.util.ArrayList, java.util.List, java.util.Iterator" %>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>
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
	<h4>주문 관리&nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'" id="back_btn">메뉴로 돌아가기</button>
	
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
	
	String chemistID = (String)session.getAttribute("chemistID");
	//모든 주문 내역 가져오기
	try {
		//stmt = conn.createStatement();
		String sql = "SELECT O.Client_ID as Client_ID, C.Name as Client_Name, O.Order_num, O.Order_date, O.Prescription, M.Name as Medicine_Name, CO.Count"
				+ " FROM M_ORDER O, CLIENT C, CONTAIN CO, MEDICINE M"
				+ " WHERE O.Order_num = CO.Order_num"
				+ " AND O.Chemist_ID = CO.Chemist_ID"
				+ " AND O.Client_ID = CO.Client_ID"
				+ " AND CO.M_number = M.M_number"
				+ " AND O.Client_ID = C.ID"
				+ " AND O.Chemist_ID = " + chemistID
				+ " ORDER BY O.Order_date";
		
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		out.println("<table>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		int m_count = 0;
		for(int i =1;i<=cnt;i++){
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		// 주문 리스트
		List<List<String>> order_list = new ArrayList<>();
		
		while(rs.next()){
			ArrayList<String> order = new ArrayList<>();
			order.add(rs.getString(1));
			order.add(rs.getString(2));
			order.add(Integer.toString(rs.getInt(3)));
			SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
			Date o_date = rs.getDate(4);
			String order_day = sdfDate.format(o_date);
			
			order.add(order_day);
			int prescript = rs.getInt(5);
			if (prescript == 1)
				order.add("O"); 
			else
				order.add("X"); 
			order.add(rs.getString(6)); 
			order.add(Integer.toString(rs.getInt(7)));
			order_list.add(order);
			m_count++;
		}

		if (m_count == 0)
			out.println("조회된 주문기록이 없습니다.");
		else{ // 주문 리스트 출력하기
			
			Iterator<List<String>> it = order_list.iterator();
			while(it.hasNext()){
				out.println("<tr>");
				Iterator<String> ot = it.next().iterator();
				String btn_data = "";
				int i = 1;
				while(ot.hasNext()){
					String str = ot.next();
					out.println("<td>"+str+"</td>");
					btn_data = btn_data + rsmd.getColumnName(i)+"="+str;
					if (ot.hasNext())
						btn_data += "&";
					i++;
				}
				out.println("<td><button onClick=\"location.href=\'chemist_order_update.jsp?"+btn_data+"\'\">수정</button></td>");
				out.println("<td><button onClick=\"location.href=\'chemist_order_delete.jsp?"+btn_data+"\'\">삭제</button></td>");
				out.println("</tr>");
			}
			
		}
		out.println("</table>");
		rs.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>	

</body>
</html>