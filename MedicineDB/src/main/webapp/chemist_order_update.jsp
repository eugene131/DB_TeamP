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
.p1 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 290px;
	width: 50%;
}
.p2 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 345px;
	width: 50%;
}
.p3 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 370px;
}
.p4 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 410px;
}
.p5 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 470px;
}

input[type=text]{
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

input[type=text]:focus{
	border-color:dodgerBlue;
	box-shadow:0 0 8px 0 dodgetBlue;
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
input[type=date]{
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

input[type=date]:focus{
	border-color:dodgerBlue;
	box-shadow:0 0 8px 0 dodgetBlue;
}
</style>
</head>
<body>
	<h4>주문 수정 &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='chemist_menu.html'" id="back_btn">메뉴로 돌아가기</button>
	
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
	<table>
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
		<p class="p1"> 주문 날짜: 
		<input type="date" name="o_date"></p>
		<p class="p2"> 처방전 유무: 
		<input type="radio" name="o_prescription" value="1">O
		<input type="radio" name="o_prescription" value="0">X</p>
		<p class="p3"> 약 이름: 
		<input type="text" name = "m_name"></p>
		<p class="p4"> 수량: 
		<input type="number" name="count"></p>
		<p class="p5">
		<input type="reset" value="Reset" class="btn">&nbsp;<input type="submit" value="수정" class="btn"></p>
	</form>
	
</body>
</html>