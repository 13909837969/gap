	<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>基层法律服务工作基本信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JgxxcjbService.js"></script>
<style>
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	box-shadow: 0px 0px 10px #888888;
}
#siderightbar {
	cursor: pointer;
}
#siderightbar:hover {
	color: #00f;
}

</style>
<script type="text/javascript">
$(function(){
	var tableview = new Eht.TableView({selector:"#sqjz_listJgxxcjb #tableview"});

	var form = new Eht.Form({
		select:"#sqjz_listJgxxcjb"
	});
	
	//查询数据
	var service = new JgxxcjbService();
	tableview.loadData(function(page,res){
		service.find(form.getData(),page,res);
	}); 
	
	//查询按钮
	$("#sqjz_listJgxxcjb #querybtn").click(function(){
		console.log(form.getData());
		tableview.refresh();
	});
	
	
	
	//点击添加上报弹出模态框
	$('#addbtn').click(function(){
		$('#myModal').modal({backdrop:'static'});
				});
	
	//添加上报
	$("#sqjz_listJgxxcjb #addbtn").click(function(){
	   $("modal-body-div input").empty();
	   $("xmAndLxdh").val(json.xm+''+json.grlxdh);
	   $("modal-body").show(function(){
	   $("#sfssqsj").val('<fmt:formatDate value="${now}" pattern="yyyy年MM月dd日"/>');
	   })
	   
	   //保存
	   service.save(form.getData(),new Eht.Responder({
		   sussess:function(data){
			   tableview.refresh();
		       $("myModal").modal('hide');	   
		   }
	   }));
	   form.clear();
	   $("#myModal").modal({
		   backdrop:'static',
		   keyboard:false
	   })
	})
	
	
	
	//关闭面板
		$("#closebtn").click(function() {
		$('#right-panel').animate({
			width : 0
		}, function() {
			$(this).hide()
		});
		tableView.refresh();
	});
	
	//关闭按钮事件  清除未选择的数据
	$("#sqjz_listJgxxcjb #close").click(function(){
		   json={};
	       tableview.refresh();
	})
	
	});
	
</script>
</head>
<body>
<div id="sqjz_listJgxxcjb">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				服务所名称：<input class="btn btn-default" type="text" name="xm[like]" />	
				<input class="btn btn-default" type="button" id="querybtn"value="查询"> 
				<input id="addbtn" class="btn btn-default"type="button" value="新增">
			</fieldset>
		</div>
		<div class="panel-body">
			<div id="tableview" class="table-responsive">				
					<div field="jgmc" label="机构名称"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别"></div>
					<div field="xl" label="学历"></div>
					<div field="zyzh" label="执业证号"></div>
					<div field="bzsj" label="颁证时间"></div>
					<div field="zhnjsj" label="最后年检时间"></div>
			</div>	
		</div>	
	</div>
<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">新增法律事务所基本信息</h4>
					</div>
<!-- 模态框内容 -->					
			<form class="form-inline" role="form">
				<div class="form-group">
					机构名称：<input type="text" class="form-control" id="name"   placeholder="请输入机构名称">
					机构证号：<input type="text" class="form-control" id="name"  placeholder="请输入机构证号">
				</div>
				<br>
				<div class="form-group">
					颁发时间：<input type="text" class="form-control" id="name"   placeholder="请输入时间">
					组织形式：<input type="text" class="form-control" id="name"  placeholder="请输入组织形式">
				</div>
				<div class="form-group">
					负责人：<input type="text" class="form-control" id="name"   placeholder="请输入负责人">
					电话：<input type="text" class="form-control" id="name"  placeholder="请输入电话">
				</div>
				<div class="form-group">
					行政区：<input type="text" class="form-control" id="name"   placeholder="请输入行政区">
					地址：<input type="text" class="form-control" id="name"  placeholder="请输入地址">
				</div>
				<div class="form-group">
					<label for="name">机构简介</label>
					<textarea class="form-control" rows="3" style="width: 555"></textarea>
				</div>
			</form>
					
<!-- 保存按钮 -->					
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
	
	</div>
</div>
</body>
</html>