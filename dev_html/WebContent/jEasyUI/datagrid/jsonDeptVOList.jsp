<%@page import="com.dept.DeptVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	com.dept.DeptDao ddao = new com.dept.DeptDao();
	java.util.List<DeptVO> dList = null;
	dList = ddao.deptVOList();
//	out.print(dList.size());
	com.google.gson.Gson g = new com.google.gson.Gson();
	String imsi = g.toJson(dList);
	out.print(imsi);
%>