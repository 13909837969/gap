<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>司法奖惩</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzrySfjcService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript">
		$(function(){
			var service = new JzrySfjcService();
			var table = new Eht.TableView({selector:"#tableaaa",valueCodeField:"f_code",labelCodeField:"f_name"});
			var name = $("#sqjz_listSfjc_all #name").val();
			var lbxz = $("#sqjz_listSfjc_all #jclbxz").val();
			var query = {"xm[like]":name,"jclb[eq]":lbxz};
			var json = {};
			$("#sqjz_listSfjc_all #tsk").hide();
			/* **页面启动之后加载数据** */
			table.loadData(function(page,res){
				service.findAll(query,page,res);
			});
			table.transColumn("jcyy",function(data){
				var jcyyBook = Eht.DataCode["sys083"];//获取奖惩原因字典-数组
				if(data.jcyy==""){
					return "";
				}else{
					var jcyyArry = data.jcyy.split(",");//截取从数据库获取到的字符串为数组
					var res = "";
					for(var i=0;i<jcyyArry.length;i++){
						for(var j=0;j<jcyyBook.length;j++){
							if(jcyyBook[j].f_code==jcyyArry[i]){
								res = res + jcyyBook[j].f_name;
							}
						}
						res = res + ";";
					}
					return res;
				}
			});
			/* 单击查询按钮触发事件 */
			$("#sqjz_listSfjc_all #btn").click(function(){
				query["xm[like]"] = $("#sqjz_listSfjc_all #name").val();
				query["jclb[eq]"] = $("#sqjz_listSfjc_all #jclbxz").val();
				table.refresh();//再执行上次方法
			})
			/*单击新增按钮，增加一条信息  */
			$("#sqjz_listSfjc_all #xz").click(function() {
				$("#sqjz_listSfjc_all #myModalLabel").text("司法奖惩新增");
				$("#sqjz_listSfjc_all #btn-primary").show();
				$("#sqjz_listSfjc_all #modal-body").load("${localCtx}/module/sqjz/formSfjc_add.jsp?load=load");
				/* 模态框弹出后,模态框之外的区域不可点 */
				$("#myModal").modal({backdrop : 'static',keyboard : false}); 
		  	});
			/* ******************当单击某条数据时，将数据放入json内，以备点击【修改】按钮时调取数据*************************** */
			table.clickRow(function(data){
				json=data;
				console.log(data);
			});
			/* **双击某条数据，弹出人员详情页********* */
			table.dblclickRow(function(data){
				$("#sqjz_listSfjc_all #ckxq").click();
			});
			/* 单击修改按钮，修改选中信息 */
		  	$("#sqjz_listSfjc_all #xg").click(function() {
		  		if(("jcyy" in json)&&("xm" in json)){
		  			$("#sqjz_listSfjc_all #myModalLabel").text("司法奖惩修改");
				  	$("#sqjz_listSfjc_all #btn-primary").show();
				  	$("#sqjz_listSfjc_all #modal-body").load("${localCtx}/module/sqjz/formSfjc_add.jsp?load=load&jcid="+json.jcid);
					$("#myModal").modal({backdrop : 'static',keyboard : false}); 
		  		}else{
		  			$("#sqjz_listSfjc_all  #tsk").append("<strong>Warning!</strong> 请先勾选要修改的对象.");
		  			$("#sqjz_listSfjc_all  #tsk").show();
		  		}
		  	});
		  	/* 单击查看详情按钮，load选中信息jcid到子页 */
		  	$("#sqjz_listSfjc_all #ckxq").click(function() {
		  		if(("jcyy" in json)&&("xm" in json)){
		  			$("#sqjz_listSfjc_all #myModalLabel").text("查看详细信息");
				  	$("#sqjz_listSfjc_all #btn-primary").hide();
				  	$("#sqjz_listSfjc_all #modal-body").load("${localCtx}/module/sqjz/formSfjc_Browse.jsp?load=load&jcid="+json.jcid);
					$("#sqjz_listSfjc_all #myModal").modal({backdrop : 'static',keyboard : false}); 
		  		}else{
		  			$("#sqjz_listSfjc_all #tsk").append("<strong>Warning!</strong> 请先勾选要查看的对象.");
		  			$("#sqjz_listSfjc_all #tsk").show();
		  		}
		  	});
		})
	</script>
	<style type="text/css">
		#sqjz_listSfjc_all{
			width:1300px;
		}
		#sqjz_listSfjc_all #head{
			padding-left:30px;
		}
		tr>th{
			text-align:center;
		}
		tr>td{
			text-align:center;
		}
	</style>
</head>
<body>
	<div id="sqjz_listSfjc_all"><!--  class="container" -->
		<div>		<!--  class="row" -->
			<div id="head">
				<fieldset>
					<!-- <legend>司法奖惩</legend> -->
					<label> 姓名：<input id="name" type="text" style="width:170px;height:28px"/></label>
					<label> 奖惩类别：
						  <select id="jclbxz" style="width:170px;height:28px;margin-top: 6px;">
			 				  <option value="" selected="selected">请选择</option>
							  <option value="01">警告</option>
							  <option value="0201">依社区矫正机构提请</option>
							  <option value="0202">公安机关依法给予</option>
							  <option value="03">减刑</option>
						  </select>
					</label>
					<input id="btn" type="button" class="btn btn-default btn-sm" value="查询">
					<input id="xz" type="button" class="btn btn-default btn-sm" value="新增">
					<input id="xg" type="button" class="btn btn-default btn-sm" value="修改">
					<input id="ckxq" type="button" class="btn btn-default btn-sm" value="查看详情">
				</fieldset>	
			</div>		
			<!-- 弹出警告框 -->
			<div class="alert alert-warning alert-dismissible" role="alert" id="tsk">
			    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>		
			<div id="tableaaa">
				<div field="op" checkbox=true></div>
				<div field="xm" label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="mz" label="民族" code="SYS003"></div>
				<div field="jtzm" label="具体罪名"></div>
				<div field="jzlb" label="矫正类别" code="SYS017"></div>
				<div field="jclb" label="奖惩类别" code="SYS082"></div>
				<div field="jcsj" label="奖惩时间"></div>
				<!-- <div id="jcyy" field="jcyy" label="奖惩原因"  width="200" code="SYS083"></div> -->
			</div>
			<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog " style="width:605px ;height:800px">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="btn-close">×</button>
							<h4 class="modal-title" id="myModalLabel">司法奖惩-新增</h4>
						</div>
						<div class="modal-body" id="modal-body" style="width:600px;height: 400px; overflow: auto;padding:5px 30px 5px 5px;">
						</div>
						<div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal" id="btn-close">关闭</button>
					        <button type="button" class="btn btn-primary" id="btn-primary">提交</button>
					    </div>
					</div>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>