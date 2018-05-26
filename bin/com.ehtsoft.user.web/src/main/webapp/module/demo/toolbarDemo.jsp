<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common.jsp"></jsp:include>
</head>
<script type="text/javascript">
$(function(){
	
	$("#addbtn").click(function(){
		$("#aaaa").disable();
	});
	$("#del").click(function(){
		$("#aaaa").enable();
	});
	
	var bar = new Eht.Toolbar({selector:"#toolbar"});
	//bar.disable("#addbtn,#savebtn");
	
});
</script>
<body>
<div id="toolbar" style="vertical-align: middle;">
	<a icon="eht-talk-icon">消息</a>
	<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
	<a id="savebtn" icon='eht-savebtn-icon'>保存</a>
	<a id="editbtn" icon='eht-editbtn-icon'>编辑</a>
	<a id="del" icon="eht-deletebtn-icon">删除</a>
	<a icon="eht-search-icon">查询</a>
	<a icon="eht-export-icon">导出</a>
	<a icon="eht-checkbtn-icon">检测</a>
	<a icon="eht-preview-icon">浏览</a>
	<a icon="eht-printer-icon">打印</a>
	<a icon="eht-upbtn-icon">上报</a>
	<a icon="eht-refresh-icon">刷新</a>
	<a icon="eht-notepad-icon">eht-notepad-icon:记事本</a>
	<a icon="eht-imppdf-icon">eht-imppdf-icon:导入PDF</a>
	<a icon="eht-impxml-icon">eht-impxml-icon:导入XML</a>
	<a icon="eht-impexcel-icon">eht-impexcel-icon：导入Excel</a>
	<a icon="eht-impimg-icon">eht-impimg-icon：导入 img</a>
	<a icon="eht-impfile-icon">eht-impfile-icon:导入File</a>
	<a icon="eht-exppdf-icon">eht-exppdf-icon:导出PDF</a>
	<a icon="eht-expxml-icon">eht-expxml-icon:导出XML</a>
	<a icon="eht-expexcel-icon">导出Excel</a>
	<a icon="eht-expfile-icon">导出File</a>
	<a icon="eht-busbtn-icon">eht-busbtn-icon</a>
	<a icon="eht-carbtn-icon">eht-carbtn-icon</a>
	<a icon="eht-camera-icon">eht-camera-icon</a>
	<a icon="eht-cardbtn-icon">eht-cardbtn-icon</a>
	<a icon="eht-lockbtn-icon">eht-lockbtn-icon</a>
	<a icon="eht-unlock-icon">eht-unlock-icon</a>
	<a icon="eht-markbtn-icon">eht-markbtn-icon</a>
	<a icon="eht-earthbtn-icon">eht-earthbtn-icon</a>
	<a icon="eht-cutbtn-icon">eht-cutbtn-icon</a>
	<a icon="eht-download-icon">eht-download-icon</a>
	<a icon="eht-download1-icon">eht-download1-icon</a>
	<a icon="eht-download2-icon">eht-download2-icon</a>
	<a icon="eht-download3-icon">eht-download3-icon</a>
	<a icon="eht-selectbtn-icon">eht-selectbtn-icon</a>
	<a icon="eht-warnbtn-icon">eht-warnbtn-icon</a>
	<a icon="eht-toolbtn-icon">eht-toolbtn-icon</a>
	<a icon="eht-telbtn-icon">eht-telbtn-icon</a>
	<a icon="eht-telbtn1-icon">eht-telbtn1-icon</a>
	<a id="import" icon="eht-impxml-icon">导入应用
				<input type="file" class="eht-toolbar-file"/>
	</a>
	<a icon="eht-refresh-icon"></a>
	<input id="aaaa" type="text" value="sss" style="width:20px;" disabled="disabled"/>
	<select><option>ssss</option></select>
</div>
</body>
</html>