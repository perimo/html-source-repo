<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String empno = request.getParameter("empno");
	int iempno = 0;
	if(request.getParameter("empno")!=null){
		iempno = Integer.parseInt(empno);
	}
	SqlMapEmpDao edao = new SqlMapEmpDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("empno",iempno);
	List<Map<String,Object>> elist = edao.empList(pmap);
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>