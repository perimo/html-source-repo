<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.restaurant.RestaurantDao" %>
<%-- 스크립틀릿 - 자바코드를 쓸 수 있는 땅 , JSP에서는 주석을 달때 이렇게 달아야한다 --%>
<%
	RestaurantDao rDao = new RestaurantDao();
	List<Map<String, Object>> mrList = rDao.procRestList();
	Gson g = new Gson();
	String imsi = g.toJson(mrList);
	out.print(imsi);
	//out.print(mrList);//Gson을 사용하지 않고 java의 List를 사용한것이기 떄문에 브라우저가 인식을 못한다.
%>