<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//화면이 없어도 단위테스트가 가능해야함.
//디자이너가 내 페이지를 아직 못 만들었어도 나는 코딩할 수 있다.
//그래서 클래스 쪼개기가 필요!
//192.168.0.244:dev_html/ajax/pictureInfo.jsp?id=picture2.jpg
	String img = request.getParameter("id");
	//out.print("img: "+img); //picture2.jpg 라고 찍힐것이다.
	String imgs[] = {"picture1.jpg","picture2.jpg","picture3.jpg","picture4.jpg"};
	String cimg = null;
	for(int i=0;i<imgs.length;i++){
		//"equals" -값이 같은지 비교  //"==" -주소번지가 같은지 비교
		if(img.equals(imgs[i])){
			cimg = imgs[i];
		}
	}
%>
<img src="./<% out.print(cimg); %>" width='400px' height='270px' border="1">