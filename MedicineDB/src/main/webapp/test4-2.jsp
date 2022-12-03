<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    <%@ page import = "java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action ="./test4-3.jsp">
아래의 항목을 빠짐없이 채워주십시오.<br><br>
주소 : <input type ="text" name = "address"><br><br>
전화번호(숫자로만 입력): <input type ="text" name = "phone_num"><br><br>
<button type = "submit"> 확인 </button>
</form>

</body>
</html>