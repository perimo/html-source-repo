<%@page import="orm.dao.SqlMapCommonDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> zdoList = null;
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	zdoList = cDao.getZDOList(null);
%>
<!DOCTYPE html>
<html><!-- 앞으로 만드는 파일들은 view가 붙어있으면 화면 json이 붙어있으면 데이터 -->
<head>
<meta charset="UTF-8">
<title>Ajax 실전연습-[1:ajax, 2:html,html+js,js, 3:myBatis]</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
	table{
		border: 3px solid #CCAAFF;
	}
	td{
		border: 3px solid #CCAAFF;
		text-align: center;
		height: 45px;
	}
</style>
<script type="text/javascript">
	function siguIN(){
		$("#i_sigu").change(function(){
			$("#i_sigu option:selected").each(function(){
				$("#sigu").val($(this).text());//this가 가리키는것은 i_sigu
			});
		});
	}
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#i_zdo").change(function(){
			$("#i_zdo option:selected").each(function(){ //선택된 텍스트 값을 받아서 저장
				var p_zdo = $(this).text();
				//alert("p_zdo: "+p_zdo);
				$("#zdo").val(p_zdo);
				var param="zdo="+p_zdo;
				$.ajax({//ajax사용해보기
					method: "post"
				   ,url:"getSiGuList.jsp"
				   ,success:function(result){
					   $("#d_sigu").html(result); //도가 결정된 다음에 구에 대한 정보를 찍어줘야한다.
					   siguIN();//구에대한 정보를 넣어줘야 하니까 그건 siguIN함수에서 처리하자
				   }
				});
			});
		});
	});
</script>
<table width="600" height="60" callpadding="0" cellspacing="0">
	<tr><!-- 첫번째 로우  -->
		<td width="60px">시도</td>
		<td width="140px">
			<select id="i_zdo" style="width:120px">
				<option value="선택">선택</option>
<%
	for(int i=0;i<zdoList.size();i++){
		Map<String,Object> rmap = zdoList.get(i);
%>
				<option value="<%=rmap.get("ZDO")%>"><%=rmap.get("ZDO")%></option>
<%
	}//end of for
%>
			</select>
		</td>
		<td width="60px">구</td>
		<td width="140px">
			<div id="d_sigu"></div><!-- '시도'가 먼저 정해진 후에 여기(구)가 보여져야 하니까 여기는 <div>태그로 한다. -->
		</td>
		<td width="60px">동</td>
		<td width="140px">
			<div id="d_dong"></div>
		</td>
	</tr>
	<tr><!-- 두번째 로우 -->
		<td width="60px">시도</td>
		<td width="140px">
			<input type="text" id="zdo" name="zdo" size="12"/> <!-- 서버로 전달할 떄는 name, 화면에서 전달할 떄는 id -->
		</td>
		<td width="60px">구</td>
		<td width="140px">
			<input type="text" id="sigu" name="sigu" size="12"/>
		</td>
		<td width="60px">동</td>
		<td width="140px">
			<input type="text" id="dong" name="dong" size="12"/>
		</td>
	</tr>
</table>
</body>
</html>