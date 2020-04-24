<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
//선언부 - 디클러레이션 - 전역변수 이다.
//싱글톤으로 관리한다.(서블릿-newsData_jsp.java => HttpServlet - 이 객체는 계속 유지된다.(새로고침을 당해도.))
	int x = 1;//전역변수이다.
	public String newsList(String news[]){
		//자바 성능 튜닝팀 지적사항 - 삼성SDS - 지방공개정보시스템
		StringBuilder sb = new StringBuilder();
		sb.append("<table width='500px border='1'>");
		sb.append("<tr><td>"+news[0]+" > "+news[1]+"</td></tr>");
		sb.append("</table>");
		return sb.toString();
	}
%>
<%
	//int x = 1;//지역변수이다.- 지역변수라서 전역변수가 변경되지않아 새로고침해도 반응이 없다.
//스크립틀릿 - 메소드 선언 불가
	String news1[] = {"연합뉴스","사회적 거리두기 `완화`…마스크 착용-거리두기 유지해야"};
	String news2[] = {"연합뉴스","코로나 타격 일본, 아이폰 SE 출시일도 늦췄다"};
	String news3[] = {"연합뉴스","처참한 미국 코로나19 사망자 4만명 넘어…8일 만에 두배 급증"};
	String news4[] = {"연합뉴스","“가성비 꽉 잡았다”… 삼성 vs 애플, 중저가폰 ‘격돌’"};
	String news5[] = {"연합뉴스","KB국민카드, ‘애플 제품 리스 금융’ 개시"};
	//화면에 내보내 질 코드 담기
	String datas = "";
	switch(x){
	case 1:
		datas = newsList(news1);
		x++;
		break;
	case 2:
		datas = newsList(news2);
		x++;
		break;
	case 3:
		datas = newsList(news3);
		x++;
		break;
	case 4:
		datas = newsList(news4);
		x++;
		break;
	case 5:
		datas = newsList(news5);
		x=1;
		break;
	}
	out.clear();
	out.print(datas);
%>