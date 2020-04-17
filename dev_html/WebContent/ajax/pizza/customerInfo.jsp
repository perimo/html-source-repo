<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Map, java.util.HashMap" %>
<%@ page import="com.google.gson.Gson" %>
<%-- jsp주석이다. 소스보기에서 안보인다.
	고객 정보를 관리할 List에 담고 json 포맷으로 만들기
	이름 : mem_name
	주소 : mem_addr
	전화번호 : mem_tel
	//->주석은 자바주석으로 소스보기에서 보인다. - json 포맷이 아니다.
  --%>
<% 
	List<Map<String, Object>> cusList = new ArrayList<>();
	Map<String, Object> rMap = null;
	rMap = new HashMap<>();
	rMap.put("mem_name", "이순신");
	rMap.put("mem_addr", "서울시 마포구 공덕동");
	rMap.put("mem_tel", "01011112222");
	cusList.add(rMap);
	
	rMap = new HashMap<>();
	rMap.put("mem_name", "김유신");
	rMap.put("mem_addr", "서울시 영등포구 당산동");
	rMap.put("mem_tel", "01011113333");
	cusList.add(rMap);
	
	rMap = new HashMap<>();
	rMap.put("mem_name", "이순신");
	rMap.put("mem_addr", "서울시 금천구 가산동");
	rMap.put("mem_tel", "01011114444");
	cusList.add(rMap);
	
	Gson g = new Gson();
	String result = g.toJson(cusList);
	out.print(result);
	
%>