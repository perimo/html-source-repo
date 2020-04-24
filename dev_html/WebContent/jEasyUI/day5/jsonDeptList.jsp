<%@page import="com.google.gson.Gson"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap, java.util.List" %>
<%@ page import="orm.dao.SqlMapDeptDao" %>
<%
	SqlMapDeptDao dDao = new SqlMapDeptDao();
	List<Map<String,Object>> dList = dDao.deptList();
	Gson g = new Gson();
	String imsi = g.toJson(dList);
	out.print(imsi);
%>