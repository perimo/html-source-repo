<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
	String u_id = request.getParameter("u_id");
	out.print("u_id: "+u_id);
%>
<!-- 확장자가 JSP지만 html로 인식 -->
<!-- get방식은 주소창에 ?u_id=apple 넣어볼 수 있다. 단위테스트 가능. 하지만 납품시에는 post방식 사용해야한다.-->