<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//사용자가 입력한 값 읽어오기
	int empno = 0;
	String ename = "";
	String job = "";
	int mgr = 0;
	String hiredate = "";
	double sal = 0.0;
	double comm = 0.0;
	int deptno = 0;
	if(request.getParameter("empno")!=null){
		empno = Integer.parseInt(request.getParameter("empno"));
	}
	ename = request.getParameter("ename");
	job = request.getParameter("job");
	if(request.getParameter("mgr")!=null){//그룹코드 임.
		mgr = Integer.parseInt(request.getParameter("mgr"));
	}
	if(request.getParameter("sal")!=null){
		sal = Double.parseDouble(request.getParameter("sal"));
	}
	if(request.getParameter("comm")!=null){
		comm = Integer.parseInt(request.getParameter("comm"));
	}
	if(request.getParameter("deptno")!=null){
		deptno = Integer.parseInt(request.getParameter("deptno"));
	}
	orm.dao.SqlMapEmpDao eDao = new SqlMapEmpDao();
	int result = 0;
	Map<String,Object> pMap = new HashMap<>();
	pMap.put("empno", empno);
	pMap.put("ename", ename);
	pMap.put("job", empno);
	pMap.put("mgr", mgr);
	pMap.put("hiredate", hiredate);
	pMap.put("sal", sal);
	pMap.put("comm", comm);
	pMap.put("deptno", deptno);
	result = eDao.empUPD(pMap);//Dao에서 반환값을 받아와서 result변수에 담는다. 즉,jsp(업무처리 부분- servlet)로 가져온다.
	//out.print("result: "+result);
	//response.sendRedirect("EmpManagerVer6.jsp");//여기서 페이지 이동이 일어난다. 새로 고침을 위한 것
	if(result == 1){//등록 성공 했을 떄
		response.sendRedirect("EmpManagerVer9.jsp?mode=update");//페이지 열기 전에 DB경유함. //여기서 페이지 이동이 일어난다
	}//url이 달라지면 페이지 유지가 안된다//sendRedirect 메소드: 파라미커의 페이지로간다. get방식으로.   단점은 url이 바낀다
	else{//등록 실패 했을 때
		response.sendRedirect("EmpInsertFail.jsp");//페이지 열기 전 DB 경유함.
		
	}
%>