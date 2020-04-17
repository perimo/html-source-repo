<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% //스크립틀릿 구역은 자바땅으로 서버에 요청하는 역할이고, 파라미터로 id,class 식별자를 읽어올 수 없고, name 식별자만 읽을 수 있다.
//id와 class 식별자는 화면단에서 태그를 불러오는 용도로 사용

//<input id="tb_id" name="tb_id" width="100px" class="easyui-textbox" placeholder="아이디">
//textboxAction.jsp?tb_id=apple	
	//String tb_id = request.getParameter("tb_id");
	String tb_id = request.getParameter("umem_id");//name식별자를 파라미터로 받아와서 tb_id에 담았다.
	out.print("사용자가 입력한 아이디 : "+tb_id);
%>