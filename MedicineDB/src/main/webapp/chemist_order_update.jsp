<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>주문 수정 &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'">메뉴로 돌아가기</button>
	
	</h4>
<%
	String clientID = request.getParameter("CLIENT_ID");
	String clientName = request.getParameter("CLIENT_NAME");
	String o_num = request.getParameter("ORDER_NUM");
	String o_date = request.getParameter("ORDER_DATE");
	String o_prescription = request.getParameter("PRESCRIPTION");
	String m_name = request.getParameter("MEDICINE_NAME");
	String count = request.getParameter("COUNT");
	
	String chemistID = (String)session.getAttribute("chemistID");
	session.setAttribute("o_clientID",clientID);
	session.setAttribute("o_num",o_num);
%>
	<table border="1">
		<th>CLIENT_ID</th>
		<th>CLIENT_NAME</th>
		<th>ORDER_NUM</th>
		<th>ORDER_DATE</th>
		<th>PRESCRIPTION</th>
		<th>MEDICINE_NAME</th>
		<th>COUNT</th>
		<tr>
			<td><%=clientID%></td>
			<td><%=clientName%></td>
			<td><%=o_num%></td>
			<td><%=o_date%></td>
			<td><%=o_prescription%></td>
			<td><%=m_name%></td>
			<td><%=count%></td>
		</tr>
	</table>
	<br>
	<br>
	<form method="post" action="chemist_order_update_complete.jsp">
		<label>주문 날짜: </label>
		<input type="date" name="o_date"><br>
		<label>처방전 유무: </label>
		<input type="radio" name="o_prescription" value="1">O
		<input type="radio" name="o_prescription" value="0">X<br>
		<label>약 이름: </label>
		<input type="text" name = "m_name"><br>
		<label>수량: </label>
		<input type="number" name="count"><br><br>
		<input type="reset" value="Reset">&nbsp;<input type="submit" value="수정">
	</form>
	
</body>
</html>