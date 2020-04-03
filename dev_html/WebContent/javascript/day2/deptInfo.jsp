<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//out.print("[{code:a1,name:홍길동}]");
	
	//JSON포맷을 javascript코드에서 활용하기 연습   /* 쌍따옴표 앞에 \를 붙여야 한다 */
	out.print("[{\"DEPTNO\":10,\"DNAME\":\"영업부\",\"LOC\":\"대전\"},{\"DEPTNO\":20,\"DNAME\":\"개발부\",\"LOC\":\"서울\"},{\"DEPTNO\":30,\"DNAME\":\"기획부\",\"LOC\":\"부산\"}]");
%>