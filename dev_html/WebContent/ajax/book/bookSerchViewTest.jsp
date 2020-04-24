<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성 + 초성검사]</title>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		#d_search {
			position: absolute; /* default 는 positive */
			border: 1px dotted black;
			background: #AACCFF
		}
		.listIn {
			background: #CCFFFF;                
		}
		.listOut {
			background: #FFFFFF;/* 아웃일떄는 흰색으로 */
		}
	</style>
	<script type="text/javascript">
	//함수선언, 전역변수 선언하는 위치
		function choSeongAccount(str){//str은 사용자가 화면에서 입력한 값(v_word)을 메소드를 호출하며 파라미터로 넘길떄 받아주는 변수 
			var cho = [
						"ㄱ","ㄲ","ㄴ","ㄷ","ㄸ"
					   ,"ㄹ","ㅁ","ㅂ","ㅃ","ㅅ"
					   ,"ㅆ","ㅇ","ㅈ","ㅉ","ㅊ"
					   ,"ㅋ","ㅌ","ㅍ","ㅎ"
					  ];
			var code;
			var result=''; //ㅎ을 반환하는 변수
			//alert(str.charCodeAt());
			for(i=0;i<str.length;i++){//예를들어 화면에 "자바"를 입력했다면 str.length는 2가 될것이다. 따라서 for문은 2번 돌아간다.
				//문자열.charCodeAt(자릿수)메소드는 문자열의 파라미터의 자릿수의 문자를 유니코드로 변환해주는 메소드.
				code = str.charCodeAt(i)-44032;//44032는 한글의 첫 글자'가'의 유니코드 값. 55203은 한글의 마지막 글자 '힣'의 유니코드 값. 따라서 입력한 한글의 유니코드에서 44032를 빼기해서 나오는 수를 code에 담는다.
				$("#d_msg").append(code+" ");
				if (code > -1 && code < 11172) {//55203-44032=11172에서 보여지듯이 11172보다 작은 유니코드를 가지고 있다면 한글인 것이다.
					result += cho[Math.floor(code/588)];//예를들어 "한" 이라는 단어는 10588 이라는 유니코드를 가지고 있고, 그걸 588로 나누고 내림해주는 함수floor()를 쓰면 cho배열의 인덱스 값이 나온다.
				}//따라서 '한'이라는 문자의 인덱스 값은 10588/588=18.xxx(내림 함수로 결국 인덱스 번호 18번의 값을 result에 붙여줘라 라는뜻)
			}
			//한글은 초성이 19개, 중성이 21개, 종성이 28개 초성 하나당 (중성 * 종성)개의 글자가 있을 것이다. 그래서 초성 하나당 19 * 21 = 588개의 글자가 있다. 다시 말하면 ‘ㄱ’으로 시작하는 글자가 588개, ‘ㄴ’으로 시작하는 글자가 588개…..라는 의미이다. 이게 code를 588로 나누는 이유이다.
			return result;//따라서 "한"을 입력했다면 위 과정을 거쳐 cho에 18번째 인덱스 값 "ㅎ"을 반환하게 된다.
		}
	//‘ㄱ’의 유니코드 값은 12593이고, ‘ㅎ’의 유니코드 값은 12622이다. 사용자가 초성만 입력했을 경우 code는 이 값에서 44032를 뺀 수이기 때문에 if문의 조건이 성립되지 않는다. 그래서 result에는 아무것도 추가되지 않고 빈 문자열인 상태로 함수가 반환되게 된다.
		function clearMethod(){
			//alert("clear메소드 호출");
			$("#d_search").css("backgroundColor","#FFFFFF")
			$("#d_search").css("border","none")
			$("#d_search").html("")
		}
	</script>
</head>
<body>
	<script type="text/javascript">
	//DOM구성이 되었을 때	이 쪽에서 필요한 이벤트 처리를 할것이다.
		$(document).ready(function (){
			var t = $('.textbox-f'); //textbox-f는 클래스='easyui-textbox'의 별칭 느낌 //쩜을 찍어서 클래스에 접근하는 방법-제이쿼리에서 제공하는 문법
			t.textbox('textbox').bind('keyup', function(e){
				var v_word = $("#_easyui_textbox_input1").val().toUpperCase();//toUpperCase()는 대문자로 바꿔주는 함수//.val() 메소드로 그 텍스트 박스의 값을 가져왔다.//따라서 화면에 입력한 문자를 가져와 v_word에 담았다.
				var choKeyword = choSeongAccount(v_word);//화면에 입력한 문자를 담은 v_word변수를 파라미터로 넘기면서 메소드를 호출하고 받아온 반환값(초성 혹은 null)을 choKeyword에 담았다.
				//초성 검색 구분
				if (v_word != "" && choKeyword == "") {//화면에 입력한 값(v_word)이 빈문자열이 아니거나 받아온 반환값(choKeyword)이 빈문자열이면 choMode변수에 Y를 담는다.
					var choMode = "Y";
				}
				else {//만약 사용자가 입력한 문자열에 완성형 문자가 존재해서 반환값에 초성이 담겼다면 choMode는 ‘N’
					choMode = "N";
				}
				//alert("choMode: "+choMode);
				var p_word = $("#_easyui_textbox_input1").val(); //아이디 _easyui_textbox_input1 는 이지유아이에서 자동으로 정해주는 아이디-개발자도구에서 확인가능하다.
				var param = "book_title="+p_word+"&choMode="+choMode;
////////////////////////////////ajax사용 시작///////////////////////////////////
				$.ajax({
					method:"get"
				   ,url:"htmlBookList.jsp"
//get 방식이니까 결국 도메인 뒤에 ?를 입력하고 나타낼 문장을 지정해준 것이다. 왜냐하면 이렇게 파라미터를 보내줘야 연결된 페이지에서 request.getParameter() 를 해서 필요한 정보를 받을 수 있다. 
//ajax에서 data : param을 하면 param에 저장된 값이 도메인? 뒤에 붙을 것이다. ‘book_title’이라는 파라미터 값으로 사용자가 텍스트박스에 입력한 값인 v_word를 보내고, ‘choMode’라는 파라미터 값으로 ‘Y’ 또는 ‘N’의 값을 가지고 있는 choMode를 보낸 것이다.
//그리고 url로 설정된 htmlBookList.jsp로 연결된다. ajax라서..? 페이지가 이동되지는 않는다. 내부적으로  htmlBookList.jsp에 갔다온다고 생각하자.
				   ,data:param //변수 param에 저장하는 값은 아래 ajax에서 data로 보내진다.
				   ,success:function(result){//성공했을 때 
						//alert("result: "+result);  
				   		$("#d_search").css("border","1px solid #000000");
				   		$("#d_search").css("background","#FFFFFF");
				   		$("#d_search").css("top",$("#_easyui_textbox_input1").offset().top+$("#_easyui_textbox_input1").offset().bottom+"px");
				   		$("#d_search").css("left",$("#_easyui_textbox_input1").offset().left+"px");
						$("#d_search").html(result);//result => htmlBookList.jsp 페이지 내용이 담긴다. result에 뿌려지는 정보가 html이니까 html(result)로 사용
				   		var tds = document.getElementsByTagName("td"); //여러개인 경우 배열(array)로 자동 변환된다. //태그네임중 "td"를 가져온다.
				   		//배열로 전환된게 맞는지 확인
				   		for (var i = 0; i < tds.length; i++) {
							tds[i].onmouseover = function(){
								this.className = "listIn";
								var b_no = $(this).attr("id");//여기서 this는 td //attr은 속성에 접근하는 함수. //1,2,3...
								//alert("b_no ==> "+b_no);
								/**/
								var targetURL = '';
								if ("2" == $(this).attr("id")) {
									targetURL = 'bookSearchDetail2.jsp';//이 파일이 없으면 404번 에러가 뜨기 때문에 파일을 만들어 준다.
								} else if ("3" == $(this).attr("id")) {
									targetURL = 'bookSearchDetail3.jsp';
								}
								$.ajax({//바깥쪽에 ajax가 있는데 이렇게 안쪽에 또 ajax를 중첩해서 사용할 수 있다.
									method:"get"
								   ,url:targetURL
								   ,success:function(result){
									   //alert(result);
									   //alert("b_no: "+b_no);
										if ("2" == $(this).attr("id")) {
											//$("#d_detail2").html(result);//2번을 클릭했을 떄 
											//$("#d_detail3").html("");//3번은 빈문자열로 처리해달라
											location.href=targetURL;
										} else if ("3" == $(this).attr("id")) {
											//$("#d_detail2").html("");
											//$("#d_detail3").html(result);
											location.href=targetURL;
										}
								   }
								});
							};//////td
							tds[i].onmouseout = function(){
								//clearMethod();
								this.className = "listOut"; //앞에 점(.) 붙이는거 아님
							}
							tds[i].onclick = function(){
								$("#_easyui_textbox_input1").val($(this).text());//여기서 this는 td로 onclick 이벤트에서는 조회된 결과에서 내가 클린한 로우를 가리킨다.
								clearMethod();//초성 검색으로 조회된 로우를 클리어해주는 메소드 호출
							}
						}
				   }
				   ,error:function(xhrObject){
						alert(xhrObject.responseText);  
				   }
				});//////end of ajax
////////////////////////////////ajax사용 끝  ///////////////////////////////////
				if ($("#_easyui_textbox_input1").val().length == 0) {
					//alert("아무것도 없음.");
					//clearMethod();//문자열이 없을때는 지워주는 메소드 호출 
					//$("#d_search").hide();
				}
			});//////////end of keyup
		});//////////////end of ready
	</script><!--HTML태그 안에 쓰는 [class="easyui-textbox"]이 문장은 easyui에서 제공하는 컴포넌트를 html에서 사용할거라는 뜻 -->
	<input id="book_title" class="easyui-textbox" style="width:400px"/> 
	<div id="d_search">조회결과처리화면</div>
	<div id="d_detail2"></div>
	<div id="d_detail3"></div>
</body>
</html>