<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>json으로 받아서 처리</title>
<%@ include file="../day5/JEasyUICommon.jsp"%>	
</head>
<body>
<table id="dg" class="easyui-datagrid" data-options="url:'member.json'" title="데이터 출력방법 종류" style="width:600px">
	<thead>
	<tr><th data-options="field:'name',width:150">이름</th></tr>
	</thead>
	<tbody>
	<tr><td width="150px"><% out.print("이성계"); %></td></tr>
	</tbody>
</table>

<table border="1" title="데이터 출력방법 종류" style="width:600px">
	<thead>
	<tr>
		<th>이름</th>
		<th>주소</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td width="150px"><% out.print("이성계"); %></td>
		<td>주소</td>
	</tr>
	</tbody>
</table>
</body>
</html>