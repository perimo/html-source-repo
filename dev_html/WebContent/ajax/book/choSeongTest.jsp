<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>choSeongTest.jsp</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
</head>
<!-- 
가 - 44032
나 - 45208
 -->
<body>
	<div id="d_msg"></div>
	<script type="text/javascript">
		function choSeongAccount(str){
			var cho = [
						"ㄱ","ㄲ","ㄴ","ㄷ","ㄸ"
					   ,"ㄹ","ㅁ","ㅂ","ㅃ","ㅅ"
					   ,"ㅆ","ㅇ","ㅈ","ㅉ","ㅊ"
					   ,"ㅋ","ㅌ","ㅍ","ㅎ"
					  ];
			var code;
			var result=''; //ㅎ을 반환하는 변수
			//alert(str.charCodeAt());
			for(i=0;i<str.length;i++){
				code = str.charCodeAt(i)-44032;
				$("#d_msg").append(code+" ");
				if (code > -1 && code < 11172) {/* 한글로 한글자에 표현할 수 있는 한글 글자수 = 11172 */
					result += cho[Math.floor(code/588)]; /* 예를들어 "한" 이라는 단어는 10588 이라는 숫자를 가지고 있고, 그걸 588로 나누고 내림해주는 함수floor()를 쓰면 cho배열의 인덱스 값이 나온다. */
				}/* 따라서 '한'이라는 문자의 인덱스 값은 10588/588=18.xxx(내림 함수로 결국 18) */
			}
			alert("result-------> "+result);
			return result;
		}
		var a = choSeongAccount("한");
		alert("a: "+a);
	</script>
</body>
</html>