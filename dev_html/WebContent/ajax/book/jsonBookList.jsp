<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//사용자로부터 입력받은 문자열(a, aj, aja, ajax...)-이걸가지고 조회할 때 초성검색 대상이 아닌 경우
	String book_title = request.getParameter("book_title");
	SqlMapBookDao bdao = new SqlMapBookDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("book_title",book_title);
	List<Map<String,Object>> blist = bdao.bookList(pmap);
	Gson g = new Gson();
	String imsi = g.toJson(blist);
	out.print(imsi);
%>