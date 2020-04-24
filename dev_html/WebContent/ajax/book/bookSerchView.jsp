<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성 + 초성검사]</title>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css"> <!-- 아이콘 위치 -->
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		#d_search {
			position: absolute;
			border: 3px dotted red;
			background: #CCFFFF
		}
	</style>
	
	
	
</head>
<body>
	<script type="text/javascript">
	//DOM 구성이 되었을 때 이 쪽에서 필요한 이벤트 처리를 할 것이다.
		$(document).ready(function(){
			var t = $('.easyui-textbox');
			t.texbox('textbox').bind('keyup', function(e){
				var v_word = $("#_easyui_textbox_input1").val().toUpperCase();
				var choKeyword = choSeongAccount(v_word);//초성을 계산 해줄 함수를 호출하면서 파라미터로 위에서 받아온 v_word를 넘긴다. 함수에서 계산해서 나온 반환값을 choKeyword에 담는다. 
				//초성 검색 구분
				if (v_word != "" && choKeyword == "") {//v_word = 사용자가 화면에서 입력한 값이 담겨있다. //choKeyword = 사용자가 입력한 문자의 초성만 뽑아왔다.
					choMode = "Y";
				}
				else {
					choMode = "N";
				}
			});
		});

	</script>
	<input id="book_title" class="easyui-textbox" style="width:300px"/>
	<div id="d_search">조회 결과 처리 화면</div>
</body>
</html>












