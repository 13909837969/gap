<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>家庭成员及主要社会关系</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<%}%>
<script type="text/javascript">
var Sqjzry_jtcyjShgxForm = $(function(){
		var shgxobj = $("#sqjzjbxx-shgx").remove();//社会关系
		//社会关系表单存放到shgxs 中
		var shgxs = [];
		/* 社会关系-增加按钮 */
		$('#jtcyjshgx #btnAdd').click(function(){
			addJtcyjshgx();
		});
		function addJtcyjshgx(){
			var num=shgxs.length;
			if(num == 0){
				var c = shgxobj.clone();
				var gf = new Eht.Form({selector:c,autolayout:true});
				shgxs.push(gf);
				$("#jtcyjshgx").append(gf.selector);
			}else{
				var obj=shgxs[num - 1];
				if(obj.validate()){
					var c = shgxobj.clone();
					var gf = new Eht.Form({selector:c,autolayout:true});
					shgxs.push(gf);
					$("#jtcyjshgx").append(gf.selector);
				}
			}
		}
		/* 社会关系-删除按钮 */
		$('#jtcyjshgx #btnDel').click(function(){
			if(shgxs.length > 0){
				var p = shgxs.pop();
				p.selector.remove();
			}
		});
		$.fn.getJtcyData=function(){
			var rs=[];
			if(shgxs.length>0){
				for(var i=0;i<shgxs.length;i++){
					rs.push(shgxs[i]);
				}
			}
			return rs;
		}
		var json = [];
		var service = new DaglService();
		var form = new Eht.Form({selector:"#sqjzjbxx-shgx"});
		service.findJtcyjshgx($("#hiddencyId").val(),new Eht.Responder({
			success:function(data){
				json = data;
				for(var i=0;i<json.length;i++){
					addJtcyjshgx();
					form.fill(json[i]);
				}
			}
		}))
	})
</script>
</head>
<body>
	<%
		String id = request.getParameter("id");
	%>
	<div class="tab-pane" id="jtcyjshgx">
	<input id="hiddencyId" type="hidden" name="id" value="<%=id%>"/>
		<h4 style="margin-left:80px;">家庭成员及主要社会关系：
			<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
			<input id="btnDel" type="button" class="btn btn-default btn-sm" value="删除">
		</h4>
		<div class="row" id="sqjzjbxx-panel-shgx">
			<div id="sqjzjbxx-shgx" class="grjl-border">
				<input type="text" label="关系:" name="gx" valid="{required:true}" code="sys103"/>
				<input  name="xm" type="text" label="姓名:" autocomplete="off"  valid="{required:true}" >
				<input  name="szdw" type="text" label="所在单位（所在地）:" autocomplete="off"  valid="{required:true,onlyChinese:true}" >
				<input  name="jtzz" type="text" label="家庭住址（所在地）:" autocomplete="off"  valid="{required:true,onlyChinese:true}" >
				<input name="lxdh" type="text" label="联系电话:" autocomplete="off"  valid="{required:true,number:true}" >
			</div>
		</div>
		<div style="height:10px"></div>
	</div>
</body>
</html>