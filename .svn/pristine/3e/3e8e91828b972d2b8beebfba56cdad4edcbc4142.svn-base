<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基层法律服务所管理</title>
<style type="text/css">
#form_table{
	 margin: auto;
	 margin-top: 2%;
}
#form_table tr td{
	padding-right: 10px;
	padding-bottom: 10px;
}
</style>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqJzJcflfwService.js"></script>
<script type="text/javascript">
var jcfw = new SqJzJcflfwService();
/* 设置默认选中 */
/* 获取行政区划ID */
$(function () {
var code = $("#regioncode_id").val();
		jcfw.findRegion({"regionid":$("#regionid_code").val()},new Eht.Responder({success:function(data){
			if (data.length > 0) {
				debugger;
				if (data[0].lvl == 1 || data[0].lvl == 2) {
					for (var i = 1; i < data.length; i++) {
						var code1 = "'"+data[i].regionid+"'";
						if (code1 == code) {
							$("#regionid").append('<option selected="selected" value="'+ data[i].regionid+'">' + data[i].region_name +'</option>');
						}else{
							$("#regionid").append('<option  value="'+ data[i].regionid+'">' + data[i].region_name +'</option>');
						}
						
				}
				}else{
					for (var i = 0; i < data.length; i++) {
						var code1 = "'"+data[i].regionid+"'";
						if (code1 == code) {
							$("#regionid").append('<option selected="selected" value="'+ data[i].regionid+'">' + data[i].region_name +'</option>');
						}else{
							$("#regionid").append('<option  value="'+ data[i].regionid+'">' + data[i].region_name +'</option>');
						}}}}
		}}));
		
		//textarea
		var textareaName = "#jgjj";//备注输入框id
		var spanName = "#count2";//计数span的id
		$(textareaName).click(function() {
			countChar(textareaName, spanName);
		});
		$(textareaName).keyup(function(){
			countChar(textareaName, spanName);
		});
		$(textareaName).keydown(function() {
			countChar(textareaName, spanName);
		});
		function countChar(textareaName, spanName) {
			if ($(textareaName).val() != "") {
				$(spanName)
						.text("" + $(textareaName).val().length + "/500");
				if ($(textareaName).val().length > 0) {
					$(spanName).css("color", "#3F51B5");
				}
				;
				if ($(textareaName).val().length > 240) {
					$(spanName).css("color", "#FF0000");
				}
				;
			} else {
				$(spanName).text("0/500");
			}
		};
		
		
	});
	function formsave() {
		var data = {
				"id":$("#id").val(),
				"jgmc":$("#jgmc").val(),
				"jgzh":$("#jgzh").val(),
				"bzsj":$("#bzsj").val(),
				"fzr":$("#fzr").val(),
				"dh":$("#dh").val(),
				"dz":$("#dz").val(),
				"regionid":$("#regionid").val(),
				"zzxs":$("#zzxs").val(),
				"jgjj":$("#jgjj").val()
				
		}
		jcfw.save(data, new Eht.Responder({
			success : function(data) {
				window.parent.location.reload();//关闭iframe
				 self.window.opener.locaction.reload();//刷新父级窗口
			}}));
	}

</script>
</head>
<body>
<input type="hidden" id="regionid_code" value="${param.regionid}"> <!-- 父级id -->
<input type="hidden" id="regioncode_id" value="${param.region_code}"> <!-- 本级id -->
<input type="hidden" id= "id" value="${param.id}">
	<table id="form_table">
		<tr>
			<td>机构名称</td>
			<td><input type="text" id="jgmc" value="${param.jgmc}"  placeholder="请输入机构名称"></td>
			<td>机构证号</td>
			<td><input type="text" id="jgzh" value="${param.jgzh}"  placeholder="请输入机构证号"></td>
		</tr>
		<tr>
			<td>颁证日期</td>
			<td><input type="text" id="bzsj" class="form_date" value="${param.bzsj}"  placeholder="请选择颁证日期"></td>
			<td>组织形式</td>
			<td>
				<select id="zzxs" name="" style="width: 98%"> 
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
				</select>
			</td>
			
		</tr>
		<tr>
		<td>负责人</td>
			<td><input type="text" id="fzr" value="${param.fzr}"  placeholder="请输入负责人"></td>
			<td>电话</td>
			<td><input type="text" id="dh" value="${param.dh}"  placeholder="请输入电话"></td>
			
		</tr>
		<tr>
		<td>行政区</td>
			<td>
				<select style="width: 98%" id="regionid" value="${param.region_name}">
				</select>
			</td>
			<td>地址</td>
			<td><input type="text" id="dz" value="${param.dz}"  placeholder="请输入机构地址"></td>
			
		</tr>
		<tr >
			<td colspan="4">机构简介</td>
		</tr>
		<tr >
			<td colspan="4">
				<textarea id="jgjj" style="width: 100%;height: 100px;"  maxlength="500" placeholder="请输入机构简介">${param.jgjj}</textarea>
				<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 0px;"></span></div>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<div style="margin: 7px 45%;">
					<button style="width: 50px;" onclick="formsave()">保存</button> 
				</div>
			</td>
		</tr>
	</table>
</body>
</html>