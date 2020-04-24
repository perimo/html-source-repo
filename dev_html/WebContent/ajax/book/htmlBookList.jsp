<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String book_title = request.getParameter("book_title");
	String choMode = request.getParameter("choMode");//이렇게 하면 book_title, choMode 변수에 각각 값이 저장된다.
													//여기서 저장되는 값은 위에서 ajax를 통해 전송된 값이다.
	//out.print(book_title+", "+choMode);
	SqlMapBookDao bDao = new SqlMapBookDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("book_title", book_title);//request.getParameter()로 받은 값을 Map에 추가했다.
	pmap.put("choMode", choMode);
	List<Map<String,Object>> bList = new ArrayList<>();
	bList = bDao.bookList(pmap);
	//out.print(bList);
%>
<table border="1" borderColor="red">
<%
//조회결과가 없을 떄
	if(bList==null){
%>
	<tr>
		<td>조회결과가 없습니다.</td>
	</tr>
<%
	}else{
//조회결과가 있을 때
		for(int i=0;i<bList.size();i++){
			Map<String,Object> rmap = bList.get(i);
%>
	<tr>
		<td id="<%=rmap.get("BOOK_NO") %>"><% out.print(rmap.get("BOOK_TITLE")); %></td>
	</tr>
<%  //<%= 위처럼 이렇게 생긴 것은 스클립틀릿 과 다르다. 교재 -53페이지
		}////////end of for
	}////////////end of else
%>
</table>
<%-- 이런 형식의 코드를 이해하자
자바 코드를 쓸 때는 스크립틀릿(<% %>)에 담아줘야한다.
화면에 테이블을 그릴 때는 태그를 사용해야 하고, 태그를 사용하는 것은 html 코드이다. 그래서 html코드를 쓸 때는 스크립틀릿 바깥의 영역에 있어야 하고, 적절한 위치에 사용 되어야 한다.
위에서 함수의 반환 값을 bList에 담아주었다. 조회된 결과가 bList에 담기는 것이다.
조회된 결과가 몇 개인지 모르기 때문에 for문을 사용하고, 조건은 bList.size()로 한다. bList의 i번째 인덱스(결국은 Map<String,Object> 타입이다)를 rMap에 담아주었다.
<tr>태그와 <td>태그를 사용해서 테이블의 한 칸을 만들어주고 그 안에 rMap에서 “BOOK_TITLE”의 키 값을 가진 value를 가져와서 출력해준다.
이렇게 해서 표에 책 제목이 채워지는 것이다. --%>
