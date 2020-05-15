<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//여기는 tomcat서버 내부에서 처리되는 코드이고
//처리 된 결과만이 클라이언트 측으로 다운로드 됨.
// - 서버측
	if(1==1) out.print("나야");
%>
<%@ include file="../day5/JEasyUICommon.jsp"%><!-- include 디렉티브 사용 //jQuery 와 easyUI import문장 파일 위치 -->
<script>
//여기는 처리 주체가 사용자의 컴퓨터이다.
// - 클라이언트측
	$(opener.location).attr("href","javascript:fun();"); //jQuery사용
	self.close();
</script>