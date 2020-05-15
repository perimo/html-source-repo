/**
 * 윈도우 팝업창 처리구현
 * @param1: 화면에 띄울 페이지 URL
 * @param2: 팝업창의 가로 길이
 * @param3: 팝업창의 세로 길이
 * @param4: 팝업창의 이름
 */
function cmm_window_popup(url,popupwidth,popupheight,popupname){
	//해상도(1600*124), 팝업창 크기(700*400)
	Top = (window.screen.height-popupheight)/3; //(1024-450)/3 => ? 191
	Left = (window.screen.width-popupwidth)/2; //(1600-700)/2 => 450
	if (Top<0) Top=0;
	if (Left<0) Left=0;
	options = "location=yes, fullscreen=no, status=no";
	options += ", left="+Left+", top="+Top;
	options += ", width="+popupwidth+", height="+popupheight;
	popupname = window.open(url,popupname,options);//window.open(주소,타켓(어디에 띄울지),창 속성)//자바스크립트에서 제공하는 내장 객체
}