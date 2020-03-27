<!-- JSP를 사용하기 위한 필수 코드 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 목록</title>
</head>
<body>
<!---------------------- HTML 땅   ------------------>
<table border='1' borderColor='red' width='460'>
<tr><th>부서번호</th><th>부서명</th><th>지역</th></tr>
<%
	for(int i=0;i<3;i++) {
%>
<tr><td>1</td><td>2</td><td>3</td></tr>
<%
	}
%>
</body>
</html>