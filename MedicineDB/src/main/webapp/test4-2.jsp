<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.text.*" %>
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
}
h4 {
	position: absolute;
	width: 1500px;
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
.p1 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 210px;
	width: 50%;
}
.p2 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	top: 250px;
	width: 50%;
}
.p3 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 290px;
}
.p4 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 345px;
}
.p5 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 375px;
}
.p6 {
	position: absolute;
	left: calc(50% - 307px/2 - 0.5px);
	width: 50%;
	top: 430px;
}
</style>
</head>
<body>

<form action ="./test4-3.jsp">
<h4>아래의 항목을 빠짐없이 채워주십시오. &nbsp;&nbsp;&nbsp;
	<button onClick="location.href='client_menu.html'" id="back_btn">변경 취소</button>
</h4>
<p class="p1">
주소 : <input type ="text" name = "address"></p>
<p class="p2">
전화번호(숫자로만 입력): <input type ="text" name = "phone_num"></p>
<p class="p3">
<button type = "submit" class="btn"> 확인 </button></p>
</form>

</body>
</html>