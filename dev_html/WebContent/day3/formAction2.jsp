<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- HTML땅 -->
<%
	//자바영역
	String mem_id = request.getParameter("mem_id");
	out.print(mem_id);
%>
</body>
</html>