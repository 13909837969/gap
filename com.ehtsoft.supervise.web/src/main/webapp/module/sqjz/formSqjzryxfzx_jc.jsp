<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>奖惩情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
<%}%>
<script type="text/javascript">
var jcqk = new Eht.Form({
	selector :'#sqjzryxfzx_form_jcqk',
	autolayout:true,
	formCol:2
});
var sqjzry_jcqkForm = $(function(){
		var jcqks = [];
		var jcqkobj = $("#sqjzjbxx-jcqk").remove();//个人基本信息
		/* 个人简历页面-增加按钮 */
		$('#form_jzry_jcqk #btnAdd').click(function(){
			addOne();
		});
		var initIdIndex = 0;
		function addOne(data){
			var c = jcqkobj.clone();
			var gf = new Eht.Form({selector:c,autolayout:true,initIdIndex:initIdIndex});
			
			gf.change(function(data,name){
				if(name=='01'){
					$("#jcyy option").each(function(){
						$(this).show();
						if($(this).val()=='07'||$(this).val()=='08'||$(this).val()=='09'||$(this).val()=='10'||$(this).val()=='11'){
							$(this).hide();
						}
					})
				}else if(name=='03'){
					$("#jcyy option").each(function(){
						$(this).show();
						
						if($(this).val()!='09' && $(this).val()!='10' && $(this).val()!='11'){
							$(this).hide();
						}
					})
				}else {
					$("#jcyy option").each(function(){
						$(this).show();
						if($(this).val()!='07' && $(this).val()!='08'){
							$(this).hide();
						}
					})
				}
			});
			initIdIndex++;
			if(data != null){
				gf.fill(data);
			}
			jcqks.push(gf);
			$("#form_jzry_jcqk").append(gf.selector);
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
		$('#form_jzry_jcqk #btnDel').click(function(){
			if(jcqks.length > 0){
				var p = jcqks.pop();
				p.selector.remove();
			}
		});
		
		$.fn.getJcqkData=function(){
			var rs = [];
			if(jcqks.length > 0){
				for(var i=0;i<jcqks.length;i++){
					rs.push(jcqks[i].getData());
				}
			}
			return rs;
		}
		var service = new XfzxService();
		var json = [];
		if($("#form_jzry_jcqk #hiddenId").val() != ""){
			service.findjcxx($("#hiddenId").val(),new Eht.Responder({
				success:function(data){
					json = data;
					for(var i=0;i<json.length;i++){
						addOne(json[i]);
					}
				}
			}));
		}
		//----------------------------------------逻辑填写-------------------------------------------
		
		if($("#jcqk option[name='jcqk']").val()=='1'){
				$(this).attr("checked",true);
		}
		
		$("#sqjzryxfzx_form_jcqk #jcqk").click(function(){
			if($("#sqjzryxfzx_form_jcqk #jcqk").val()=='0'){
				$("#sqjzjbxx-jcqk").hide();
				$("#jcxx").hide();
			}else{
				$("#sqjzjbxx-jcqk").show();
				$("#jcxx").show();
				
			}
		})
		

})
</script>
</head>
<body>
	<%
		String id = request.getParameter("id");
	%>
	<div class="tab-pane" id="form_jzry_jcqk">
		<input id="hiddenId" type="hidden" name="id" value="<%=id%>"/>
		<div id="sqjzryxfzx_form_jcqk" style="margin-top: 18px;">
		
			<input col="4" labelCol="3" id="jcqk" type="text" label="奖惩情况" name="jcqk"  getdis="true" code="sys001"/>
			<div class="form-group col-sm-6 col-xs-12"  id="jcxx">
				<h4 style="font-size: 14px;font-weight: bold;margin-top: 4px;" >奖惩信息：
						<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
						<input id="btnDel" type="button" class="btn btn-default btn-sm" value="删除">
				</h4>
			</div>
			<hr style="width: 95%;clear: both;border-color: #aaa;border-width: 1px;border-style: solid;"/>
		
			
				<div id="sqjzjbxx-jcqk" class="grjl-border" >
					<input id="jclb" name="jclb" type="text" label="奖惩类别" code="sys082" valid="{required:true}"/>
					<input  name="jcsj" type="text" label="奖惩时间" class="form_date" data-date-format="yyyy-MM" valid="{required:true}" >
					<input id="jcyy" name="jcyy" type="text" label="奖惩原因" code="sys083" valid="{required:true}"/>
					<input  name="remark" type="text" label="备注"  >
					<hr style="width: 95%;clear: both;border-color: #aaa;border-width: 1px;border-style: dashed;"/>
				</div>
				
		</div>	
		<div style="height:10px"></div>	
	</div>
</body>
</html>