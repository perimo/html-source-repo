<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jeasyui.member.MemberDao, java.util.List, java.util.Map" %>
<%@ page import="com.google.gson.Gson" %>
    <%-- html 땅  ==>jsp주석으로 반드시 처리할것 --%>
<%
	//스크립틀릿 - 자바 땅
	MemberDao mdao = new MemberDao();
	List<Map<String, Object>> mList = null;
	mList = mdao.memberList();
	Gson g = new Gson();
	String imsi = g.toJson(mList);
	out.print(imsi);
%>