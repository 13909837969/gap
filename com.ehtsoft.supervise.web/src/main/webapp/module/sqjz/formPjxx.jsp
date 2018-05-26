<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>判决信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzryPjxxService.js"></script>
<%}%>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">
	$(function(){
		var form = new Eht.Form({
			selector:"#formPjxx-border",
			autolayout:true
			//formCol:2
		});
		//获取传进来的f_aid
		var f_aid = "${param.f_aid}";
		/****** 矫正人员信息div初始化隐藏 ******/
		$("#formPjxx #tableaaa").hide(); 
		var query ={};
		query.id = f_aid;
		var serviceJZ = new JzJzryjbxxService();
		var tableViewDiv = new Eht.TableView({selector:"#formPjxx #tableaaa",
			valueCodeField:"f_code",labelCodeField:"f_name",paginate:null});
		tableViewDiv.loadData(function(page,res){serviceJZ.find(query,page,res);});
		
		/* 单击矫正人员输入框，弹出div框及所有矫正人员信息，选择人员进行新增 */
		$("#formPjxx #xuanze").bind("onchange",function(){
			if($("#formPjxx #xuanze").val() !=""){
				query["xm[like]"]=$("#formPjxx #xuanze").val();
				tableViewDiv.refresh();
				$("#formPjxx #tableaaa").show();//矫正人员基本信息div弹出
			}else{
				$("#formPjxx #tableaaa").hide();//矫正人员基本信息div隐藏 
			}
		})
		
		/* 当矫正人员输入框内输入内容时，触发查询 */
		$("#formPjxx #xuanze").keyup(function(){
			if($("#formPjxx #xuanze").val() !=""){
				query["xm[like]"]=$("#formPjxx #xuanze").val();
				tableViewDiv.refresh();
				$("#formPjxx #tableaaa").show(); //矫正人员基本信息div弹出
			}else{
				$("#formPjxx #tableaaa").hide(); //矫正人员基本信息div隐藏 
			}
		});
		/* 单击某条数据隐藏人员信息表 */
		tableViewDiv.clickRow(function(data){
			/* 数据输入 */
			form.fill(data);
			/* 人员信息表隐藏 */
			$("#formPjxx #tableaaa").hide(); 
		});
		//标识判断编辑和提交按钮是隐藏还是显示 
		if($("#form-edit-flag").val() == 1){
			$("#formPjxx-bj").show();
			$("#formPjxx-tj").show();
		}else{
			$("#formPjxx-bj").hide();
			$("#formPjxx-tj").hide();
		};
		//单击编辑按钮触发事件
		$("#formPjxx-bj").click(function(){
			changedisable(false);
		});
		//判断input的状态
		function changedisable(ifboolean){
			$("#formPjxx").find("input[select='sfbxgjzl'],input[select='fjx'],input[select='yqtxqx'],input[name='sqjzqx'],input[name='ypxqjsrq'],input[name='ypxqksrq'],input[select='ypxf'],input[name='ypxq'],input[name='zyfzss'],input[name='wssxrq'],input[name='sqjzjdjgmc'],input[name='yjzfjgmc'],input[name='pjsbh'],input[name='pjrq'],input[name='wsbh'],input[name='wslx'],input[name='zxtzswh'],input[name='zxtzsrq'],input[select='sqjzjdjg'],input[select='yjzfjg'],input[select='sfcydzdwgl'],input[select='sqjzryjsfs'],input[select='bdqk'],").each(function(){
				$(this).attr("disable",ifboolean);
			})
		};
		//平板单击提交按钮触发的事件
		$("#formPjxx-tj").click(function(){
			service.insert(form.getData(),new Eht.Responder({
				success:function(data){
					changedisable(true);
				}
			}))
		});
		//模态框提交按钮触发事件
		var service = new JzryPjxxService();
		$("#listPjxx #btn-primary").click(function(){
			service.insert(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listPjxx #myModal').modal('hide');
					$("#listPjxx_table").refreshTable();
					form.clear();
				}
			}))
		});
	})
</script>
<style>
#formPjxx #tableaaa {
	z-index: 999;
	width: 80%;
	height: 300px;
	background-color: #FFFFFF;
	margin: auto;
	position: absolute;
	top: 0;
	left: 140px;
	bottom: 0;
	right: 0;
	overflow-y: auto;
	overflow-x: auto;
}
#formPjxx-bj{
	position: absolute;
    left: 0px;
    top: 10px;
}
#formPjxx-tj{
	position: absolute;
    left: 50px;
    top: 10px;
}
#formPjxx-border{
	margin-top: 20px;
}
</style>
</head>
<body>
	<%out.print("<input type='hidden' value='1' id='form-edit-flag'>"); %>
	<div id="formPjxx">
		<input type="button" value="编辑" id="formPjxx-bj">
		<input type="button" value="提交" id="formPjxx-tj">
		<div id="formPjxx-border">
			<div id="tableaaa">
				<div field="xm" name="xm" label="姓名"  style="color:#fff"></div>
				<div field="sfzh" name="shzh" label="身份证号" id="table" style="color:#fff"></div>
			</div>
			<input name="id" type="hidden">
			<input name="xm" type="text" label="姓名" id="xuanze" valid="{required:true}">
			<input name="sqjzjdjg" type="text" label="社区矫正决定机关" getdis="true" valid="{required:true}" code="sys055">
			<input name="sqjzjdjgmc" type="text" label="社区矫正决定机关名称" getdis="true" valid="{required:true}">
			<input name="yjzfjg" type="text" label="移交罪犯机关" getdis="true" valid="{required:true}" code="sys056">
			<input name="yjzfjgmc" type="text" label="移交罪犯机关名称" getdis="true" valid="{required:true}">
			<input name="pjsbh" type="text" label="判决书编号" getdis="true"valid="{required:true}">
			<input name="pjrq" type="text" label="判决日期" getdis="true" valid="{required:true}" class="form_date" 
				data-date-format="yyyy-MM-dd">
			<input name="zxtzsrq" type="text" label="执行通知书日期" getdis="true" valid="{required:true}" class="form_date" 
				data-date-format="yyyy-MM-dd">
			<input name="zxtzswh" type="text" label="执行通书文号" getdis="true" valid="{required:true}">
			<input name="wslx" type="text"  label="文书类型" getdis="true" valid="{required:true}">
			<input name="wsbh" type="text"  label="文书编号" getdis="true" valid="{required:true}">
			<input name="wssxrq" type="text"  label="文书生效日期" getdis="true" valid="{required:true}"class="form_date" 
				data-date-format="yyyy-MM-dd">
			<input name="zyfzss" type="text" label="主要犯罪事实" getdis="true" valid="{required:true}">
			<input name="ypxf" type="text" label="原判刑罚" getdis="true" valid="{required:true}" code="sys012">
			<input name="ypxq" type="text" label="原判刑期" getdis="true" valid="{required:true}">
			<input name="ypxqksrq" type="text" label="原判刑期开始日期" getdis="true" valid="{required:true}"class="form_date" 
				data-date-format="yyyy-MM-dd">
			<input name="ypxqjsrq" type="text" label="原判刑期结束日期" getdis="true" valid="{required:true}"class="form_date" 
				data-date-format="yyyy-MM-dd">
			<input name="fjx" type="text" label="附加刑" getdis="true" valid="{required:true}" code="sys013">
			<input name="sfbxgjzl" type="text" label="是否被宣告禁止令" getdis="true" valid="{required:true}" code="sys001">
			<input name="sqjzqx" type="text" label="社区矫正期限" getdis="true" valid="{required:true}">
			<input name="yqtxqx" type="text"  label="有期徒刑期限" code="sys032" getdis="true" valid="{required:true}">
		</div>
	</div>
</body>
</html>