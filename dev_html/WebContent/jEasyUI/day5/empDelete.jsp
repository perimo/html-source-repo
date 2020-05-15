<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empnoArr = request.getParameter("empno");//7899,9011,9013 이런식으로 담긴다.
	String empnos[] = null;
	if(empnoArr!=null){
		empnos = empnoArr.split(",");
	}
	int result = 0;
	orm.dao.SqlMapEmpDao eDao = new SqlMapEmpDao();
	result = eDao.empDEL(empnos);//Dao에서 반환값을 받아와서 result변수에 담는다. 즉,jsp(업무처리 부분- servlet)로 가져온다.
	//out.print("result: "+result);
	//response.sendRedirect("EmpManagerVer6.jsp");//여기서 페이지 이동이 일어난다. 새로 고침을 위한 것
	if(result > 0){//등록 성공 했을 떄
		response.sendRedirect("EmpManagerVer8.jsp?mode=update");//페이지 열기 전에 DB경유함. //여기서 페이지 이동이 일어난다
	}//url이 달라지면 페이지 유지가 안된다//sendRedirect 메소드: 파라미터의 페이지로간다. get방식으로.   단점은 url이 바낀다
	else{//등록 실패 했을 때
		response.sendRedirect("EmpInsertFail.jsp");//페이지 열기 전 DB 경유함.
		
	}
%>