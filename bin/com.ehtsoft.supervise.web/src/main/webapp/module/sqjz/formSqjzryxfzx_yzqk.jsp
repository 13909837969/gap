	<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人简历</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
<%}%>
<script type="text/javascript">
var sqjzry_yzqkForm = $(function(){
		var grjls = [];
		var grjlobj = $("#sqjzjbxx-grjl").remove();//个人基本信息
		/* 个人简历页面-增加按钮 */
		$('#form_jzry_yzzz #btnAdd').click(function(){
			addOne();
		});
		var initIdIndex = 0;
		function addOne(data){
			var c = grjlobj.clone();
			var gf = new Eht.Form({selector:c,autolayout:true,initIdIndex:initIdIndex});
			initIdIndex++;
			if(data != null){
				gf.fill(data);
			}
			grjls.push(gf);
			$("#form_jzry_yzzz").append(gf.selector);
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
		/* 个人简历页面-删除按钮 */
		$('#form_jzry_yzzz #btnDel').click(function(){
			if(grjls.length > 0){
				var p = grjls.pop();
				p.selector.remove();
			}
		});
		
		$.fn.getYzqkData=function(){
			var rs = [];
			if(grjls.length > 0){
				for(var i=0;i<grjls.length;i++){
					rs.push(grjls[i].getData());
				}
			}
			return rs;
		}
		var service = new XfzxService();
		var json = [];
		if($("#form_jzry_yzzz #hiddenId").val() != ""){
			service.findyzqk($("#hiddenId").val(),new Eht.Responder({
				success:function(data){
					json = data;
					for(var i=0;i<json.length;i++){
						addOne(json[i]);
					}
				}
			}));
		}
	})
</script>
</head>
<body>
	<%
		String id = request.getParameter("id");
	%>
	<div class="tab-pane" id="form_jzry_yzzz">
		<input id="hiddenId" type="hidden" name="id" value="<%=id%>"/>
		<div class="row" id="sqjzjbxx-panel-grjl">
			<h4 style="margin-left:80px;">余罪或再罪情况
				<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
				<input id="btnDel" type="button" class="btn btn-default btn-sm" value="删除">
			</h4>
			<div id="sqjzjbxx-grjl" class="grjl-border">
				<hr style="width: 93%;clear: both;border-color: #aaa;border-width: 1px;border-style: solid;"/>
					<input id="sszm" name="sszm" type="text" label="所涉罪名" code="sys014" valid="{required:true}"/>
					<input  name="zcjg" type="text" label="侦查机关" valid="{required:true}" >
					<input id="bcqqzcssj" name="bcqqzcssj" type="text" label="被采取强制措施时间" class="form_date" data-date-format="yyyy-MM-dd"/>
					<input  name="spjg" type="text" label="审判机关" valid="{required:true}" >
					<input  name="zm" type="text" label="罪名" valid="{required:true}" >
					<input  name="xq" type="text" label="刑期" valid="{required:true}" >
					<input  name="remark" type="text" label="备注"  >
				<hr style="width: 93%;clear: both;border-color: #aaa;border-width: 1px;border-style: dashed;"/>
			</div>
		</div>	
			
		<div style="height:10px"></div>	
	</div>
</body>
</html>				
					
					
					
					