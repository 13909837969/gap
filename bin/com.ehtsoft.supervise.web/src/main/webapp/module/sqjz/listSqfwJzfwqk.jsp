<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>集中服务情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqfwService.js"></script>
<script type="text/javascript">
$(function() {
	var service = new SqfwService();
	var form = new Eht.Form({
		selector : "#sqjz_listSqfwJzfwqk"
	});
	var tableView = new Eht.TableView({
		selector : "#sqjz_listSqfwJzfwqk #tableview",
	});
	
	var querySearch={}
	//查询按钮事件
	$("#sqjz_listSqfwJzfwqk #querybtn").click(function() {
		querySearch["jlr[like]"] = $("#sqjz_listSqfwJzfwqk #jl").val();
		querySearch["fwbt[like]"] = $("#sqjz_listSqfwJzfwqk #title").val();
		tableView.refresh();
	});
	tableView.loadData(function(page,res) {
		service.findFocusService(querySearch,page,res);
	});
	//单击一行获取该行信息
	var json = {};
	tableView.clickRow(function(data) {
		json = data;
		debugger;
	});
	
	//模态框里面的Form表单
	 var form  =  new Eht.Form({
		 selector:'#sqjz_listSqfwJzfwqk #modal-body-div',
		 autolayout:true
		 
	 });
	
	
	
	//提示框div初始状态为隐藏
	$('#sqjz_listSqfwJzfwqk #hideDiv').hide();
	$('#sqjz_listSqfwJzfwqk #hideScDiv').hide();
	//关闭按钮
	$('#sqjz_listSqfwJzfwqk #guanbibtn').click(function(){
		$('#sqjz_listSqfwJzfwqk #hideDiv').hide();
	});
	
	//取消按钮
	$('#sqjz_listSqfwJzfwqk #quxiaobtn').click(function(){
		$('#sqjz_listSqfwJzfwqk #hideDiv').hide();
		tableView.refresh();
	})
	$('#sqjz_listSqfwJzfwqk #quxiaobtn1').click(function(){
		$("#sqjz_listSqfwJzfwqk #hideScDiv").hide();
		tableView.refresh();
	})
	//关闭按钮事件 清除未选择的数据
	$('#sqjz_listSqfwJzfwqk #close').click(function(){
		json={};
		tableView.refresh();
	});
	//关闭按钮事件 清除未选择的数据
	$('#sqjz_listSqfwJzfwqk #xxx').click(function(){
		json={};
		tableView.refresh();
	});
	/*新增按钮  */
	$("#sqjz_listSqfwJzfwqk #addbtn").click(function(){
		$("#modal-body").show(function(){
		})
		$("#myModal").modal({backdrop : 'static',keyboard : false}); 
		form.clear();
	});
	
	//新增按钮
 	$('#sqjz_listSqfwJzfwqk #btn-primary').unbind('click').bind('click',function(){
		if(form.validate()){
		service.saveFocusService(form.getData(),new Eht.Responder({
			success:function(data){
				$('#sqjz_listSqfwJzfwqk #myModal').modal('hide');
				tableView.refresh();
			}
		}));
		}
	}) 
	

	/*修改一条信息  */
 	$("#sqjz_listSqfwJzfwqk #updatebtn").click(function() {
		if(json.id==null){
			$('#sqjz_listSqfwJzfwqk #hideDiv').show();
		}else{
			$('#sqjz_listSqfwJzfwqk #hideDiv').hide();
			form.fill(json);
			debugger;
			$("#myModal").modal({backdrop : 'static',keyboard : false});
		};
	}); 
	
	/* 删除信息 */
	$("#sqjz_listSqfwJzfwqk #deletebtn").click(function() {
		var array = tableView.getSelectedData();
		if(array.length==0){
			$('#sqjz_listSqfwJzfwqk #hideDiv').show();
		}else{
			$('#sqjz_listSqfwJzfwqk #hideScDiv').show();
			$('#sqjz_listSqfwJzfwqk #hideDiv').hide();
				//确定按钮
			$('#sqjz_listSqfwJzfwqk #shanchubtn').unbind('click').bind('click',function(){
				$('#sqjz_listSqfwJzfwqk #hideScDiv').hide();
					var id = json.id;
					service.deleteFocusService(id,new Eht.Responder({
						success:function(){
							tableView.refresh();
							
						}
					}));
				})
		}
	});
	//新增模态框计数----备注
	form.charValid(function(name,min,max){
		if(name=="sqfwnr"){
			$("#count").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count").css("color","#f00");
			}else{
				$("#count").css("color","#00f");
			}
		}
		if(name=="sqfwhdzj"){
			$("#count_fwzj").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count_fwzj").css("color","#f00");
			}else{
				$("#count_fwzj").css("color","#00f");
			}
		}
	});




});

</script>
</head>
<body>
<div id="sqjz_listSqfwJzfwqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					记录人: <input id="jl" type="text" name="jlr" placeholder="请输入记录人" class="btn btn-default"/> 
					服务标题: <input id="title" type="text" name="fwbt" placeholder="请输入服务标题" class="btn btn-default"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input id="addbtn" class="btn btn-default" type="button" value="新增">
					<input id="updatebtn" class="btn btn-default" type="button" value="修改"> 
					<input id="deletebtn" class="btn btn-default" type="button" value="删除">
				</fieldset>
			</div>
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
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="fwbt" label="服务标题"></div>
					<div field="sqfwkssj" label="社区服务开始时间"></div>
					<div field="sqfwjssj" label="社区服务结束时间"></div>
					<div field="ydrs" label="应到人数"></div>
					<div field="sdrs" label="实到人数"></div>
					<div field="sqfwsc" label="社区服务时长"></div>
					<div field="jlr" label="记录人"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog  modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">集中服务情况</h4>
					</div>
					<div class="modal-body" style="height: 400px; overflow: auto">
						<div id="modal-body-div" class="modal-body">
								<input 	type="hidden" name="id" >
								<input 	type="text" 	name="fwbt"		label="服务标题"	valid="{required:true}"/>
								<input 	type="text" 	name="sqfwkssj" label="社区服务开始时间"   class="form_date" data-date-formate="yyyy-MM-dd" valid="{date:true,required:true}"  />
								<input 	type="text" 	name="sqfwjssj" label="社区服务结束时间"   class="form_date" data-date-formate="yyyy-MM-dd" valid="{date:true,required:true}"  />
								<input 	type="text" 	name="ydrs" 	label="应到人数"   valid="{required:true,int:true}"/>
								<input 	type="text" 	name="sdrs" 	label="实到人数"   valid="{required:true,int:true}"/>
								<input 	type="text" 	name="sqfwsc" 	label="社区服务时长" valid="{required:true,int:true}"  />
								<input 	type="text" 	name="jlr" 		label="记录人"   valid="{required:true,onlyChinese:true}" />
								<textarea   name="sqfwnr" label="社区服务内容"  maxlength="300" rows="3"  style="resize: none;" valid="{required:true}"></textarea>
									<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
								<textarea    name="sqfwhdzj" label="社区服务活动总结"  maxlength="300" rows="3"  style="resize: none;" valid="{required:true}"></textarea>
									<div class="text-right"><span id="count_fwzj"  style="color: #3F51B5"></span></div>
						</div>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn-primary">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>
</body>
</html>