<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>矫正方案信息采集表</title>
<script type="text/javascript">
$(function(){
	//矫正方案文本域字数限制
	var textareaName2 = "#fromJbxxjzfaxx_form #floor2";//备注输入框id
	var spanName2 = "#fromJbxxjzfaxx_form #count2";//计数span的id
	$(textareaName2).click(function(){
		countChar(textareaName2,spanName2);
	});
	$(textareaName2).keyup(function(){
		countChar(textareaName2,spanName2);
	});
	$(textareaName2).keydown(function(){
		countChar(textareaName2,spanName2);
	});
	var textareaName1 = "#fromJbxxjzfaxx_form #floor1";//备注输入框id
	var spanName1 = "#fromJbxxjzfaxx_form #count1";//计数span的id
	$(textareaName1).click(function(){
		countChar(textareaName1,spanName1);
	});
	$(textareaName1).keyup(function(){
		countChar(textareaName1,spanName1);
	});
	$(textareaName1).keydown(function(){
		countChar(textareaName1,spanName1);
	});
	function countChar(textareaName2,spanName2){ 
	   if($(textareaName2).val() != ""){
			$(spanName2).text("已输入:"+ $(textareaName2).val().length + "/1000");			
			if($(textareaName2).val().length>0){
					$(spanName2).css("color","#3F51B5");
			};
			if($(textareaName2).val().length>900){
					$(spanName2).css("color","#FF0000");
				};
		}else{
			$(spanName2).text("已输入：0/1000");
		}
	};
	$(".form_date_time").datetimepicker({
		format : 'yyyy-mm-dd hh:ii',
		language : 'zh-CN',
		autoclose : true,
		weekStart : 1,
		todayBtn : 1,
		autoclose : 1,
		//todayHighlight: 1,
		//startView: 2,
		minView : 0,
		forceParse : 0
	});
})
</script>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-body" id="fromJbxxjzfaxx_form">
			<input  type="text" label="记录人" name="jlr" disabled value="${CURRENT_USER_SESSION.name}"/>
			<input  type="text" label="记录时间" name="jlsj"  getdis="true" class="form_date_time"   />
			<textarea  rows="8" name="jzfanr" id="floor2" label="矫正方案内容" type="text" maxlength="1000"></textarea>
			<span style="display:inline-block">
			<span id="count2" style="margin-left:500px;color:#3F51B5;diaplay:inline-block"></span> 
			</span>
			<textarea  rows="8" name="dxqkfx" id="floor1" label="矫正对象情况分析" type="text" maxlength="1000"></textarea>
			<span id="count1" style="margin-left:500px;color:#3F51B5"></span>
		</div>
	</div>
</body>
</html>