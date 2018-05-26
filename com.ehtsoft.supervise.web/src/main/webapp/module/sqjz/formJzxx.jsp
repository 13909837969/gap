<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>矫正信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzryJzxxService.js"></script>
<%}%>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">
	$(function(){
		var form = new Eht.Form({
			selector:"#formJzxx-border",
			autolayout:true
			//formCol:2
		});
		//获取传进来的f_aid
		var f_aid = "${param.f_aid}";
		/****** 矫正人员信息div初始化隐藏 ******/
		$("#formJzxx #tableaaa").hide(); 
		var query ={};
		query.id = f_aid;
		if(query.id != null){
			var service = new JzryJzxxService();
			service.findAll(query,null,new Eht.Responder({
					success:function(data){
						form.fill(data);
						changedisable(true);
					}			
			}));
		};
		var serviceJZ = new JzJzryjbxxService();
		var tableViewDiv = new Eht.TableView({selector:"#formJzxx #tableaaa",
			valueCodeField:"f_code",labelCodeField:"f_name",paginate:null});
		tableViewDiv.loadData(function(page,res){serviceJZ.find(query,page,res);});
		
		/* 单击矫正人员输入框，弹出div框及所有矫正人员信息，选择人员进行新增 */
		$("#formJzxx #xuanze").bind("onchange",function(){
			if($("#formJzxx #xuanze").val() !=""){
				query["xm[like]"]=$("#formJzxx #xuanze").val();
				tableViewDiv.refresh();
				$("#formJzxx #tableaaa").show();//矫正人员基本信息div弹出
			}else{
				$("#formJzxx #tableaaa").hide();//矫正人员基本信息div隐藏 
			}
		})
		
		/* 当矫正人员输入框内输入内容时，触发查询 */
		$("#formJzxx #xuanze").keyup(function(){
			if($("#formJzxx #xuanze").val() !=""){
				query["xm[like]"]=$("#formJzxx #xuanze").val();
				tableViewDiv.refresh();
				$("#formJzxx #tableaaa").show(); //矫正人员基本信息div弹出
			}else{
				$("#formJzxx #tableaaa").hide(); //矫正人员基本信息div隐藏 
			}
		});
		/* 单击某条数据隐藏人员信息表 */
		tableViewDiv.clickRow(function(data){
			/* 数据输入 */
			form.fill(data);
			/* 人员信息表隐藏 */
			$("#formJzxx #tableaaa").hide(); 
		});
		//标识判断编辑和提交按钮是隐藏还是显示 
		if($("#form-edit-flag").val() == 1){
			$("#formJzxx-bj").show();
			$("#formJzxx-tj").show();
		}else{
			$("#formJzxx-bj").hide();
			$("#formJzxx-tj").hide();
		};
		//单击编辑按钮触发事件
		$("#formJzxx-bj").click(function(){
			changedisable(false);
		});
		//判断input的状态
		function changedisable(ifboolean){
			$("#formJzxx").find("input[name='jzjg'],input[name='jzjgbm'],input[name='jzdxsssq'],input[name='wasbdqksm'],input[name='sqjzryjsrq'],input[name='jfzxrq'],input[name='dwhm'],input[name='dhhbjsh'],input[select='sfjljzxz'],input[select='dzdwfs'],input[select='sfcydzdwgl'],input[select='sqjzryjsfs'],input[select='bdqk'],").each(function(){
				$(this).attr("disable",ifboolean);
			})
		}; 
		//单击提交按钮触发的事件
		$("#formJzxx-tj").click(function(){
			service.insert(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listJzxx #myModal').modal('hide');
					form.clear();
				}
			}))
		});
		//提交按钮触发事件
		$("#listJzxx #btn-primary").click(function(){
			service.insert(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listJzxx #myModal').modal('hide');
					$("#listJzxx_table").refreshTable();
					form.clear();
				}
			}))
		});
	})
</script>
<style>
#formJzxx #tableaaa {
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
#formJzxx-bj{
	position: absolute;
    left: 0px;
    top: 10px;
}
#formJzxx-tj{
	position: absolute;
    left: 50px;
    top: 10px;
}
#formJzxx-border{
	margin-top: 20px;
}
</style>
</head>
<body>
	<!-- 标识判断编辑和提交按钮是隐藏还是显示 -->
	<%out.print("<input type='hidden' value='1' id='form-edit-flag'>"); %>
	<div id="formJzxx">
		<input type="button" value="编辑" id="formJzxx-bj">
		<input type="button" value="提交" id="formJzxx-tj">
		<div id="formJzxx-border">
		<div id="tableaaa">
			<div field="xm" name="xm" label="姓名"  style="color:#fff"></div>
			<div field="sfzh" name="shzh" label="身份证号" id="table" style="color:#fff"></div>
		</div>
		<input name="id" type="hidden">
		<input name="xm" type="text" label="姓名" id="xuanze" valid="{required:true}">
		<input name="jzjg" type="text" label="矫正机构"  getdis="true" valid="{required:true}">
		<input name="jzjgbm" type="text" label="矫正机构编码" getdis="true" valid="{required:true}">
		<input name="jzdxsssq" type="text" label="服刑对象所属社区" getdis="true" valid="{required:true}">
		<input name="bdqk" type="text" label="报到情况" getdis="true" valid="{required:true}" code="sys016">
		<input name="wasbdqksm" type="text" label="未按时报到情况说明" getdis="true" valid="{required:true}">
		<input name="jfzxrq" type="text" label="交付执行日期" getdis="true" valid="{required:true}"class="form_date" 
			data-date-format="yyyy-MM-dd">
		<input name="sqjzryjsfs" type="text" label="社区服刑人员接收方式" getdis="true" valid="{required:true}" code="sys015">
		<input name="sqjzryjsrq" type="text" label="社区服刑人员接受日期" getdis="true" valid="{required:true}"class="form_date" 
			data-date-format="yyyy-MM-dd">
		<input name="sfcydzdwgl" type="text" label="是否采用电子定位管理" getdis="true" valid="{required:true}" code="sys001">
		<input name="dzdwfs" type="text"  label="电子定位方式" getdis="true" valid="{required:true}" code="sys060">
		<input name="dwhm" type="text"  label="定位号码" getdis="true" valid="{required:true}">
		<input name="dhhbjsh" type="text" label="电话汇报接收号码" getdis="true" valid="{required:true}">
		<input name="sfjljzxz" type="text"  label="是否建立矫正小组" getdis="true" valid="{required:true}" code="sys001">
		</div>
	</div>
</body>
</html>