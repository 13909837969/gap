<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>司法所受表彰情况信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SfsSbzqkxxcjbService.js"></script>
<script type="text/javascript">
$(function(){
	//连接后台Service
	var Service = new SfsSbzqkxxcjbService();
	//TableView绘制主界面
	var tableView = new Eht.TableView({
		selector:'#list_SfsSbzqkxxcjb #list_SfsSbzqkxxcjb_Interface',
		autolayout:true
		});
	//定义查询表单
	var form_query = new Eht.Form({selector:"#querypanel"});
	
	//使用后台方法给TableView主界面带入数据信息
	tableView.loadData(function(page,res){
		Service.find(form_query.getData(),page,res);
	});
	//新增司法所受表彰情况表单布局
	var form = new Eht.Form({
		selector:'#list_SfsSbzqkxxcjb #form_myModal',
		autolayout:true,
		/* formCol:2, */
	});
	//修改司法所表彰情况表单布局
	var form_updata = new Eht.Form({
		selector:'#list_SfsSbzqkxxcjb #form_updata',
		autolayout:true,
		/* formCol:2, */
	});
	//模态框
	var form_check = new Eht.Form({
		selector:'#list_SfsSbzqkxxcjb #form_check',
		autolayout:true,
		});	
	//全局变量JSON
	var json ={}
	//新增司法所受表彰情况模态框
	$('#newly').click(function(){
		form.clear();
		Service.findSfs(new Eht.Responder({
			success:function(data){
				$("#sfsbm").val(data.jgbm);
				$("#s_id").val(data.id);
			}
		}))
		$('#myModal').modal('show');
	});
	//新增司法所受表彰情况模态框保存，并且隐藏
	$("#list_SfsSbzqkxxcjb #save").click(function(){
			Service.saveOne(form.getData(),new Eht.Responder({
				success:function(){new Eht.Tips().show();
					$('#myModal').modal('hide');
					tableView.refresh();
				}
			}))
	});
	//查询按钮
	$("#list_SfsSbzqkxxcjb #query").click(function(){
		tableView.refresh();
	});
	//警告提示框div初始状态为隐藏
	$('#list_SfsSbzqkxxcjb #hideDiv').hide();
	$('#list_SfsSbzqkxxcjb #hideScDiv').hide();
	//取消按钮
	$('#list_SfsSbzqkxxcjb #quxiaobtn').click(function(){
	$('#list_SfsSbzqkxxcjb #hideDiv').hide();
	tableView.refresh();
});
	$('#list_SfsSbzqkxxcjb #quxiaobtn1').click(function(){
	$("#list_SfsSbzqkxxcjb #hideScDiv").hide();
	tableView.refresh();
});
	//提示界面确定按钮事件deleteOne
	$('#list_SfsSbzqkxxcjb #shanchubtn').click(function(){
		Service.deleteOne({'id':json.id},new Eht.Responder({
			success:function(){
				tableView.refresh();
				$('#list_SfsSbzqkxxcjb #hideScDiv').hide();
			}
		}));
	});
	
	//单击一行获取数据
	tableView.clickRow(function(data){
		json = data;
		$("#update").attr("disabled", false);
		$("#remove").attr("disabled", false);
	});
	//update-修改按钮事件,并且把一行数据带进新增模态框
	$('#list_SfsSbzqkxxcjb #update').click(function(){
		if(json.id==null){
			$('#list_SfsSbzqkxxcjb #hideDiv').show();
		}else{
			Service.saveOne({'id':json.id},new Eht.Responder({
				success:function(){
					form_updata.fill(json);
					$('#list_SfsSbzqkxxcjb #myModal_updata').modal({backdrop:'static'});
				}
			}));
		}
	});
	//renewal-修改司法所受表彰情况模态框保存，并且隐藏
	$("#list_SfsSbzqkxxcjb #renewal").click(function(){
			Service.saveOne(form_updata.getData(),new Eht.Responder({
				success:function(){
					new Eht.Tips().show();
					$('#myModal_updata').modal('hide');
					tableView.refresh();
				}
			}))
	});
	//remove删除按钮事件
	$('#list_SfsSbzqkxxcjb #remove').click(function(){
		if(json.id==null){
			$('#list_SfsSbzqkxxcjb #hideDiv').show();
		}else{
			$('#list_SfsSbzqkxxcjb #hideScDiv').show();
			$('#myModal_updata').modal('hide');
		}
	});

	
	//新增模态框计数
	form.charValid(function(name,min,max){
		if(name=="bznr"){
			$("#count").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count").css("color","#f00");
			}else{
				$("#count").css("color","#00f");
			}
		}
	});
	
	//修改模态框计数
	form_updata.charValid(function(name,min,max){
		if(name=="bznr"){
			$("#count_update").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count_update").css("color","#f00");
			}else{
				$("#count_update").css("color","#00f");
			}
		}
	});
	//查看模态框
	tableView.transColumn("ckxx",function(data) {
		var button = $('<button  class="btn btn-default btn-sm" style="border-color:#128ef6;color:#128ef6;"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
		button.unbind("click").bind("click",function() {
			$('#myModal_check').modal();
			form_check.fill(data);			
		});
		return button;
	});
	$("#bzjb").attr("disabled", true);
	
	
});
</script>
</head>
<body>
<div id="list_SfsSbzqkxxcjb">
<!-- 表头，增删改查 -->
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				负责人查询:<input class="btn btn-default" 	type="text" 	placeholder="请输入姓名"  name="fzr[like]"	style="margin-left: 10px;"/>
					<input class="btn btn-default" 	type="button" 	id="query" 		value="查询" 					style="margin-left: 10px;"/>
				 	<input class="btn btn-default" 	type="button" 	id="newly" 		value="新增"					style="margin-left: 10px;" />
				 	<input class="btn btn-default" 	type="button" 	id="update" 	value="修改"					style="margin-left: 10px;"  disabled/>
				 	<input class="btn btn-default" 	type="button" 	id="remove" 	value="删除"					style="margin-left: 10px;"  disabled/>
			</fieldset>
		</div>
<!-- 警告提示信息 -->		
		<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
		</div>
		<div class="alert alert-warning alert-dismissible" role="alert" id="hideScDiv" style="text-align:center;font-size:17px">
				 <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				 <strong>警告!</strong> 确定删除？
				 <input id="shanchubtn" class="btn btn-default" type="button" value="确定" >
				 <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消" >
		</div>
		<!-- 主界面展示数据 -->
		<div id="list_SfsSbzqkxxcjb_Interface">
			<div  field="xz"	label="选择" checkbox="true"></div>
			<div  field="jgmc"	label="机构名称"></div>
			<div  field="fzr"	label="负责人"></div>
			<div  field="bzmc"	label="表彰名称"></div>
			<div  field="bzjb" 	label="表彰级别" code="sys209"></div>
			<div  field="bzsj" 	label="表彰时间"></div>
			<div field="ckxx" label="查看详细"></div>
		</div>    
	</div>
<!-- 新增模态框（Modal） -->
<div class="modal fade" id="myModal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
<!-- 模态框标题 -->		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">新增司法所受表彰情况</h4>
			</div>
<!-- 模态框内容 -->			
			<div class="modal-body" id="form_myModal">
				<input type="hidden" name="s_id" id="s_id">
				<input type="text"  name="bzmc" label="表彰名称"  valid="{required:true}"/>
				<input type="text"  name="bzjb" label="表彰级别"  code="sys209" />
				<input type="text"  name="bzsj" label="表彰时间" class="form_date" data-date-format="yyyy-MM-dd" valid="{date:true,required:true}"/>
				<textarea   name="bznr" label="表彰内容"  maxlength="500" rows="5"  style="resize: none;" valid="{required:true}"></textarea>
				<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
			</div>
<!-- 保存，关闭按钮 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="save">保存</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>


<!-- 修改模态框（Modal） -->
<div class="modal fade" id="myModal_updata"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
<!-- 模态框标题 -->		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">新增司法所受表彰情况</h4>
			</div>
<!-- 模态框内容 -->			
			<div class="modal-body" id="form_updata">
				<input type="text"  name="bzmc"  label="表彰名称"   valid="{required:true}"/>
				<input type="text"  name="bzjb"  label="表彰级别"  code="sys209" />
				<input type="text"  name="bzsj"  label="表彰时间" class="form_date" data-date-format="yyyy-MM-dd"  valid="{required:true,date:true}"/>
				<textarea   name="bznr" label="表彰内容"  maxlength="500" rows="5"  style="resize: none;" valid="{required:true}"></textarea>
				<div class="text-right"><span id="count_update"  style="color: #3F51B5"></span></div>
			</div>
<!-- 保存，关闭按钮 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="renewal">更新</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<!-- 点击查看信息弹出模态框 -->
<div class="modal fade" id="myModal_check"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
<!-- 模态框标题 -->		
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">新增司法所受表彰情况</h4>
			</div>
<!-- 模态框内容 -->			
			<div class="modal-body" id="form_check">
				<input type="text"  name="bzmc"  label="表彰名称"  readonly="readonly"/>
				<input type="text"  id="bzjb"  name="bzjb"  label="表彰级别"  code="sys209" disabled/>
				<input type="text"  name="bzsj"  label="表彰时间" class="form_date" data-date-format="yyyy-MM-dd" readonly="readonly"/>
				<textarea   name="bznr" label="表彰内容"  maxlength="500" rows="5"  style="resize: none;" readonly="readonly"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
	
	
</div>
</body>
</html>