<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人简历</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<%}%>
<script type="text/javascript">
var sqjzry_grjlForm = $(function($){
		var grjlobj = $("#sqjzjbxx-grjl").remove();//个人基本信息
		var grjls = [];
		/* 个人简历页面-增加按钮 */
		$('#jzrygrjl #btnAdd').click(function(){
			var num=grjls.length;
			if(num == 0){
				var c = grjlobj.clone();
				var gf = new Eht.Form({selector:c,autolayout:true});
				grjls.push(gf);
				$("#jzrygrjl").append(gf.selector);
				c.find(".form_date").datetimepicker({
					format: 'yyyy-mm-dd', 
					language:  'zh-CN',
					autoclose: true,
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					minView: 2,
					forceParse: 0,
					pickerPosition: 'top-right',
				});
			}else{
				var obj=grjls[num - 1];
				if(obj.validate()){
					var c = grjlobj.clone();
					var gf = new Eht.Form({selector:c,autolayout:true});
					grjls.push(gf);
					$("#jzrygrjl").append(gf.selector);
					c.find(".form_date").datetimepicker({
						format: 'yyyy-mm-dd', 
						language:  'zh-CN',
						autoclose: true,
				        weekStart: 1,
				        todayBtn:  1,
						autoclose: 1,
						minView: 2,
						forceParse: 0,
						pickerPosition: 'top-right',
					});
				}
			}
		});
		/* 个人简历页面-删除按钮 */
		$('#jzrygrjl #btnDel').click(function(){
			if(grjls.length > 0){
				var p = grjls.pop();
				p.selector.remove();
			}
		});
		
		$.fn.getGrjlData=function(){
			var rs = [];
			if(grjls.length > 0){
				for(var i=0;i<grjls.length;i++){
					rs.push(grjls[i].getData());
				}
			}
			return rs;
		}
	})
</script>
</head>
<body>
	<div class="tab-pane" id="jzrygrjl" style="width:750px;margin-left:70px;">
		<h4 style="margin-left:80px;">个 人 简 历：
			<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
			<input id="btnDel" type="button" class="btn btn-default btn-sm" value="删除">
		</h4>
		<div class="row" id="sqjzjbxx-panel-grjl">
			<div id="sqjzjbxx-grjl" class="grjl-border">
				<input id="qs" name="qs" type="text" label="起时:" class="form_date" data-date-format="yyyy-MM" autocomplete="off"  valid="{required:true,date:true}" readonly="readonly">
				<input id="zr" name="zr" type="text" label="止日:" class="form_date" data-date-format="yyyy-MM" autocomplete="off"  valid="{required:true,date:true}" readonly="readonly">
				<input id="szdw" name="szdw" type="text" label="所在单位（所在地）:" autocomplete="off"  valid="{required:true,onlyChinese:true}" >
				<input id="zw" name="zw" type="text" label="职务（职业）:"  autocomplete="off"  valid="{required:true}" >
			</div>
		</div>	
			
		<div style="height:10px"></div>	
	</div>
</body>
</html>