<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 - [페이지 처리]</title>
<!--디렉티브 방식으로 변경 - 현재파일에  파일을 삽입시키므로  include 된 파일은 컴파일 저장 위치에서 확인할 수 없다. -->
<%@ include file="./JEasyUICommon.jsp"%>	
	<script type="text/javascript">
		//여기가 전역변수 자리이다.
		//전역 변수는 그 페이지 내에서 계속 유지되므로 업무 프로세스가 새로 시작할 땐 처음값으로 반드시 초기화
		var g_address='';//사용자가 선택한 주소 정보 담기
		var g_cnt = 0;//수정 시 한 건만 선택 되었는지 체크함.
		var g_empno = 0;
		//등록화면 열기
		function empINS(){//사원 등록 이벤트 처리
			//insert here
			$("#dlg_ins").dialog('open');
		}///////////end of empINS
		//수정화면 열기
		function empUPD(){
			if(g_cnt>1){
				$.messager.alert('Info','한번에 한건만 수정할 수 있습니다.');
				empList();
				return;//empUPD함수 탈출
			}
			if(g_empno==0){
				$.messager.alert('Info','수정 할 사원을 선택하세요.');
				return;//empUPD함수 탈출
			}
			else{
				$.ajax({
					url:'jsonEmpList.jsp?empno='+g_empno
				   ,success:function(data){//조회된 결과는 파라미터(data)로 가져온다.
					   var result = JSON.stringify(data);
				   	   var arr = JSON.parse(result);
				   	   for(var i=0;i<arr.length;i++){//값을 받아올 때 myBatis 사용시에는 디폴트로 대문자를 받아오기 떄문에 대문자로 처리해야한다.
				   		   $("#u_empno").numberbox('setValue',arr[i].EMPNO);//number->numberbox
				   		   $("#u_ename").textbox('setValue',arr[i].ENAME);//varchar->textbox
				   		   $("#u_job").textbox('setValue',arr[i].JOB);
				   		   $("#u_hiredate").textbox('setValue',arr[i].HIREDATE);
				   		   $("#u_sal").numberbox('setValue',arr[i].SAL);
				   		   $("#u_comm").numberbox('setValue',arr[i].COMM);
				   		   $("#u_deptno").combobox('setValue',arr[i].DEPTNO);
				   	   }
				   }
				});
			}
			$("#dlg_upd").dialog('open');
		}///////////end of empUPD
		function empnoSearch(){
			//alert("empnoSearch 호출 성공");
			var s_empno = $("#s_empno").val();
			$("#dg_emp").datagrid({
				url:'jsonEmpList.jsp?empno='+s_empno // ''안에는 문자로 인식, +다음 e_empno는 거기에 담긴 값으로 인식. 따라서 url
			});
		}
		function empList(){//아래 html 태그 코드를 이렇게 JS코드로 바꿀 수 있다.
			//조회될 때마다 새로 업무가 시작되도록 전역변수 초기화 해줄것.
			g_cnt = 0;
			$("#dg_emp").datagrid({
				url:"http://localhost:8000/jEasyUI/day5/jsonEmpList.jsp"//새로고침 처리
			   ,onLoadSuccess: function(data){
				   var result = JSON.stringify(data);
					alert("새로고침 처리 성공: "+data+", "+result);
				}
			});
		}//////////end of empList
		///////////////////////////////// DataGrid에 직접 수정 모드 추가하기 시작 ////////////////////////////////////
		function getRowIndex(target) {
			var tr = $(target).closest('tr.datagrid-row');
			return parseInt(tr.attr('datagrid-row-index'));
		}
		function editrow(target) {
			$('#dg_emp').datagrid('beginEdit', getRowIndex(target));
		}
		function deleterow(target) {
			$.messager.confirm('Confirm', 'Are you sure?', function(r) {
				if (r) {
					$('#dg_emp').datagrid('deleteRow', getRowIndex(target));
				}
			});
		}
		function saverow(target) {
			$('#dg_emp').datagrid('endEdit', getRowIndex(target));
		}
		function cancelrow(target) {
			$('#dg_emp').datagrid('cancelEdit', getRowIndex(target));
		}
		///////////////////////////////// DataGrid에 직접 수정 모드 추가하기 끝   ////////////////////////////////////
		function zipcode_search(){
			alert("우편번호검색기에서  찾기버튼  클릭 성공");
			//사용자가 입력한 동 정보 담기
			var u_dong = $("#dong").val();//사용자가 입력한 동 이름이 담김.
			if(u_dong == null || u_dong.length < 1){
				alert("동을 입력하세요.");
				return; //여기서는 함수의 영역을 빠져나감.
			}
			else{
				$("#dg_zipcode").datagrid({
					url:'jsonZipCodeList.jsp?dong=' + u_dong
				});
			}
		}
		//사원정보 등록 처리
		function emp_ins(){
			//alert("등록 저장 버튼 호출")
			/* 
			화면에서 입력받은 값은 http프로토콜을 이용해서 서버쪽으로 전송되는데 이 때 유니코드 변환되어 전달 됨.
			해결방법 - server.xml문서에서 포트번호 설정 위치(63번라인) URIEncoding="UTF-8"
			단. get방식에만 적용됨. post방식일때는 java코드를 활용하여 별도 처리.
			*/
			$("#f_ins").attr("method","get");
			$("#f_ins").attr("action","empInsert.jsp");
			$("#f_ins").submit();
		}
		//사원정보 수정 처리
		function emp_upd(){
			alert("수정 저장 버튼 호출")
			$("#f_upd").attr("method","get");
			$("#f_upd").attr("action","empUpdate.jsp");
			$("#f_upd").submit();
		}
		//사원정보 삭제 처리
		function emp_del(){
			var empnos = [];
			var rows = $('#dg_emp').datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
			    empnos.push(rows[i].EMPNO);
			}
			//alert(empnos.join(','));
			pempno = empnos.join(',');
			$.messager.progress();//막대기 바 0%~100%
			if(empnos.length>0){
				location.href="empDelete.jsp?empno="+pempno
			}
			$("dg_emp").datagrid('clearSelections');
		}
	</script>
</head>
<body>
<!--============================= 검색 조건 추가하기 시작  ============================= -->
<div id="tbar_emp">
	<form id="f_search">
		<table>
			<tr>
				<td width="190px">
					<label width="80px">사원번호</label>
					<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
				</td>
			</tr>
			<tr>
				<td>
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-man" plain="true" onclick="empINS()">사원등록</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="empUPD()">사원수정</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="emp_del()">사원삭제</a>				
				</td>
			</tr>
		</table>
	</form>
</div>
<!--============================= 검색 조건 추가하기 끝     ============================= -->
	<table id="dg_emp"></table>
	<!-- <div id="pp_emp" class="easyui-pagination" style="width:1100px"> -->
	<div id="pp_emp" class="easyui-pagination" style="border:1px solid #ccc;"
        data-options="total: 21
            		 ,pageSize: 5
            		 ,pageList: [2,3,5,10]
            		 ,onSelectPage: function(pageNumber, pageSize){
                		$('#content').panel('refresh', 'show_content.php?page='+pageNumber);
            		  }">
	</div>
	<script type="text/javascript">
		$(document).ready(function(){//DOM구성이 완료되었을 때
			//$('#empno').textbox("labelPosition","top");//무조건 이렇게 스크립트로 바꾸는게 다 좋은건 아니다. 아래쪽에 태그에서 바로 속성을 주는게 더 간단한 경우들도 있다.
			/* 동이름 입력 후 엔터 쳤을 때 처리하기 */
			var t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){
					//alert("엔터 쳤을 때");
					//t.textbox('setValue', $(this).val());//easyui-API
					$("#dg_zipcode").datagrid({
						url:'jsonZipCodeList.jsp?dong=' + $(this).val()
					   //,singleSelect:true
					   //선택한 로우의 우편번호와 주소 정보 읽어서 변수에 담기 처리
					   ,onSelect:function(index,row){//여기서 말하는 로우는 사용자가 선택한 로우의 정보를 가지고 있다.
						   //아래에서 선택된 로우인지는 어떻게 아는걸까?
						   //alert(row.ADDRESS);//여기서 row는 인덱스 번호이고, ADDRESS는 컬럼명으로!! 선택한 로우의 컬럼 정보를 가져옴.
						   g_address = row.ADDRESS;//필드명은 mybatis를 사용했으니까 꼭 대문자를 사용
					   }
 					   ,onDblClickCell:function(index,field,value){//선택한 셀의 값을 가져온다.(선택한 로우가 우편번호,주소인데 우편번호의 셀을 더블클릭해야 이벤트가 먹는다.)
 						   if("ZIPCODE"==field){//너 우편번호 셀(컬럼)을 선택한거니?
 							   //더블 클릭이벤트 핸들러를 셀을 선택했으니까 세번 째 파라미터의 value는 사용자가 선택한 로우에 그 셀에 값을 가짐.
 								$("#zipcode").textbox('setValue',value);
 							    $("#mem_addr").textbox('setValue',g_address);
 							    $("#dg_zipcode").datagrid("clearSelections");
 							    $("#dlg_zipcode").dialog('close');
 						   }
					   }
					});
				}
			});			
			/* 우편번호 찾기 화면에 대한 초기화 */
			$("#dlg_zipcode").dialog({
				title:'우편번호 검색기'//다이얼로그 기본창의 타이틀
			   ,width : 650
			   ,height: 550
			   ,closed:true
			});
		
			/* 우편번호 찾기 목록 초기화 */
			$("#dg_zipcode").datagrid({
				title: '우편번호 찾기 검색 결과'
			   ,columns:[[
				   {field:'ZIPCODE', title:'우편번호', width:120, align:'center'}
				  ,{field:'ADDRESS', title:'주소', width:400, align:'left'}
				   
			   ]]
			});
			
			/* 우편번호 찾기 버튼*/
			$('#btn_zipcode').linkbutton({
				onClick: function(){
					//alert("우편번호 찾기 버튼 클릭");
					$("#dlg_zipcode").dialog({
						closed: false
					   ,title: '우편번호 검색기'//클릭시 변경된 다이얼로그창의 타이틀
					});
				}
			});
			
			$('#dlg_upd').dialog({//사원등록 html코드처럼 되어있던걸 사원수정은 자바스크립트로 바꿔보기
				closed:true
			});
			
			$('#pp_emp').pagination({//페이지 처리
			    total:2000,
			   pageList: [2,3,5,10]
			  ,pageSize:5			
			});
			
			$('#dg_emp').datagrid({
				toolbar:'#tbar_emp'
			   //,pagination:'#pp_emp'
			   //,singleSelect:true
			   ,title: '사원관리 - 자바스크립트만으로 구성하기'
			   ,width: '1100px'
			   //,url:'jsonEmpList.jsp'//최초 페이지가 열릴 때 DB를 다녀오지 못하게 해서 정보가 뜨지 않게하기위해 주석처리.
			   ,columns:[[
			        {field:'CK',checkbox:true,width:50,align:'center'}
			       ,{field:'EMPNO',title:'사원번호',width:100,align:'center', editor:'numberbox'}//numberbox는 숫자만 입력가능하게 해준다.
			       ,{field:'ENAME',title:'사원이름',width:100,align:'center', editor:'text'}//numberbox는 숫자만 입력가능하게 해준다.
			       ,{field:'JOB',title:'JOB',width:100,align:'center', editor:'text'}
			       ,{field:'MGR',title:'MGR',width:100,align:'center', editor:'numberbox', hidden:'true'}//hidden속성은 정보를 가지고 있지만 컬럼에 표시는 안해줌.
			       ,{field:'HIREDATE',title:'입사일자',width:120,align:'center', editor:'text'}
			       ,{field:'SAL',title:'급여',width:100,align:'center', editor:'numberbox'}
			       ,{field:'COMM',title:'인센티브',width:80,align:'center', editor:'numberbox'}
			       ,{field:'DEPTNO',title:'부서번호',width:150,align:'center'
			    	   ,editor:{
			    		   type:'combobox'
			    		   ,options:{
			    			   valueField:'DEPTNO'//실제 서버에 넘어가는 필드
			    			   ,textField:'DNAME'//화면에 출력되는 필드
			    			   ,url:'./jsonDeptList.jsp'
			    			   ,required:true
			    		   }/////////end of options
			    	   }/////////////end fo editor
			       }
			       ,{field:'action',title:'Action',width:100,align:'center',
		                formatter:function(value,row,index){
		                    if (row.editing){
		                        var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
		                        var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
		                        return s+c;//오라클로 치면 파이프 연산자와 같다. 붙여쓰기 연산자.  '안녕'||'내일봐'  =>  안녕내일봐
		                    } else {
		                        var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
		                        var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
		                        return e+d;
		                    }
		                }
		            }
			    ]]
			,
	        onEndEdit:function(index,row){
	            var ed = $(this).datagrid('getEditor', {
	                index: index,
	                field: 'productid'
	            });
	            row.productname = $(ed.target).combobox('getText');
	        },
	        onBeforeEdit:function(index,row){
	            row.editing = true;
	            $(this).datagrid('refreshRow', index);
	        },
	        onAfterEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        },
	        onCancelEdit:function(index,row){
	            row.editing = false;
	            $(this).datagrid('refreshRow', index);
	        },
	        onClickRow:function(index,row){
				//alert("선택했네 --> "+index+", "+row.EMPNO);
	        	g_cnt++;//로우를 선택하는 부분이 여기니까
	        	if(g_cnt == 1){//한개 로우만 선택 했을 때 수정 가능하게 한다.
	        		g_empno = row.EMPNO;//선택한 값은 여기서 담기지만 처리는 위에서 해야하기 떄문에 전역변수로 초기화
	        	}
	        }
			});//////////////////end of datagrid
		});//////////////////////end of ready
	</script>
	<!-- =========================== 우편번호 찾기 시작 =================================== -->
	<div id="dlg_zipcode" style="width:100%; max-width: 600px; padding: 30px 30px;">
		<input class="easyui-textbox" id="dong" name="dong" labelPosition="top" data-options="prompt:'동 이름이나 주소 정보 입력...'" style="width: 210px;">
		<a id="btn_search" class="easyui-linkbutton" href="javascript:zipcode_search();" data-options="iconCls:'icon-search'">찾기</a> <!-- id로 접근하는것과 href태그로 접근하는것 둘다 알아야 한다. -->
		<div style="margin-bottom:10px;"></div>
		<table id="dg_zipcode"></table>
	</div>
	<!-- =========================== 우편번호 찾기 끝   =================================== -->
	<!-- =========================== 사원 등록 시작 =================================== -->
	<div id="dlg_ins" data-options="closed:true, title:'사원정보 등록', footer:'#d_ins', modal:'true'" class="easyui-dialog" style="width:100%; max-width:480px; padding:30px 60px">
		<form id="f_ins">
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="empno" name="empno" label="사원번호" data-options="prompt:'Enter a EmpNO'" style="width:250px"><!--prompt: 는 텍스트필드에 흐릿하게 되어있는 디폴ㅌ 메시지  -->
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="ename" name="ename" label="사원명" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="job" name="job" label="JOB" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="hiredate" name="hiredate" label="입사일자" data-options="prompt:'Enter a 입사일자'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="sal" name="sal" label="급여" data-options="prompt:'Enter a 급여'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="comm" name="comm" label="인센티브"  data-options="prompt:'Enter a 인센티브'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="deptno" name="deptno" label="부서번호"  style="width:250px"
			data-options="prompt:'Enter a 부서번호' 
        				 ,valueField: 'DEPTNO'
        				 ,textField: 'DNAME'
        				 ,url: './jsonDeptList.jsp'
        				 ,onSelect: function(rec){
        				 }"
			>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:120px">
			<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" labelPosition="top" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_ins" style="margin-bottom: 10px">
			<a id="btn_save" href="javascript:emp_ins()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<a id="btn_close" href="javascript:$('#dlg_ins').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
	</div>
	<!-- =========================== 사원 등록 끝   =================================== -->
	<!-- =========================== 사원 수정 시작 =================================== -->
	<div id="dlg_upd" data-options="closed:true, title:'사원정보 수정', footer:'#d_upd', modal:'true'" class="easyui-dialog" title="사원 정보 수정" style="width:100%; max-width:480px; padding:30px 60px">
		<form id="f_upd">
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="u_empno" name="empno" label="사원번호" data-options="prompt:'Enter a EmpNO'" style="width:250px"><!--prompt: 는 텍스트필드에 흐릿하게 되어있는 디폴ㅌ 메시지  -->
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_ename" name="ename" label="사원명" data-options="prompt:'Enter a ENAME'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_job" name="job" label="JOB" data-options="prompt:'Enter a JOB'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_hiredate" name="hiredate" label="입사일자" data-options="prompt:'Enter a 입사일자'" style="width:250px">
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="u_sal" name="sal" label="급여" data-options="prompt:'Enter a 급여'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-numberbox" id="u_comm" name="comm" label="인센티브"  data-options="prompt:'Enter a 인센티브'" style="width:250px">
			</div>			
			<div style="margin-bottom:10px">
			<input class="easyui-combobox" id="u_deptno" name="deptno" label="부서번호"  style="width:250px"
			data-options="prompt:'Enter a 부서번호' 
        				 ,valueField: 'DEPTNO'
        				 ,textField: 'DNAME'
        				 ,url: './jsonDeptList.jsp'
        				 ,onSelect: function(rec){
        				 }"
			>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt:'Enter a ZIPCODE'" style="width:120px">
			<a id="btn_zipcode" href="#" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom:10px">
			<input class="easyui-textbox" id="u_mem_addr" name="mem_addr" label="주소" labelPosition="top" data-options="prompt:'Enter a ADDRESS'" style="width:400px">
			</div>
		</form>
		<div id="d_upd" style="margin-bottom: 10px">
			<a id="btn_save" href="javascript:emp_upd()" class="easyui-linkbutton" data-options="iconCls:'icon-save'">저장</a>
			<a id="btn_close" href="javascript:$('#dlg_upd').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">닫기</a>
		</div>
		</form>	
	</div>
<%
	//수정 처리가 완료 된거니?
	String mode = request.getParameter("mode");//페이지가 이동하면 값은 넘어가지 않지만 response.sendRedirect(URL?mode=update)로 get방식으로 값을 가지고 넘어온다.
	if("update".equals(mode)){//if문의 조건 걸듯이 update와 mode의 값이 같다면 true로 if문 진입해서 새로고침.
%>
	<script type="text/javascript">
		empList();//수정이 끝났을때 새로고침을 해주는 함수를 호출 해줘야한다.
	</script>
<%
	}
%>
	<!-- =========================== 사원 수정 끝   =================================== -->
	<!-- =========================== 사원 삭제 시작 =================================== -->
	<div id="dlg_del" data-options="closed:true" class="easyui-dialog" style="width:100%; max-width:480px; padding:30px 60px">
		<form id="f_del">
		삭제
		</form>	
	</div>
	<!-- =========================== 사원 삭제 끝   =================================== -->
</body>
</html>