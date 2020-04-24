<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.util.DBConnectionMgr"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
	List<Map<String, Object>> dbSel = new ArrayList<>();
	StringBuilder sb = new StringBuilder();
	try{
		sb.append("SELECT 0 ck, empno, ename FROM emp");
		con = dbMgr.getConnection();
		pstmt = con.prepareStatement(sb.toString());
		rs = pstmt.executeQuery();
		Map<String, Object> rmap = null;
		while(rs.next()){
			rmap = new HashMap<>();
			rmap.put("ck", rs.getInt("ck"));
			rmap.put("empno", rs.getInt("empno"));
			rmap.put("ename", rs.getString("ename"));
			dbSel.add(rmap);
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	Gson g = new Gson();
	String temp = g.toJson(dbSel);
	out.print(temp);
%>