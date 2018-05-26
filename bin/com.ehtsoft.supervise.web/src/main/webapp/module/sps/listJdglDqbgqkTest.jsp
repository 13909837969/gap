<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>定期报告情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JdglService.js"></script>
<script type="text/javascript">
	$(function() {
		//连接后台Service
		var service  = new JdglService();
		//调用tableview方法展示主界面
		var tableview = new Eht.TableView({
			selector:"#list_jdglDqbgqk_Interface"
		});
		//查询
		var form = new Eht.Form({selector:"#querypanel"});
		//思想汇报里面的FROM表单
		var form_sxhb = new Eht.Form({
			selector:"#From_sxhb",
			autolayout:true,
			colLabel:"col-sm-3 col-xs-3",
			colCombo:"col-sm-9 col-xs-9"
			});
		//后台数据调用到主界面进行填充
		tableview.loadData(function(page, res) {
			 service.findPeriodicReport(form.getData(), page, res);
		});
	//查询按钮
	$("#list_jdglDqbgqk #query_cx").click(function(){
		tableview.refresh();
	});
	var json={}/*设置全局变量*/
	//点击主界面的一行信息解锁思想汇报按钮
	tableview.clickRow(function(data){
		json=data;
		$("#sxhbcxbtn").attr("disabled", false);
		$("#append").attr("disabled", false);
	});

	//思想汇报信息查询审查模态框
	$("#list_jdglDqbgqk #sxhbcxbtn").click(function(){
		debugger;
		form_sxhb.fill(json);/*填充数据到模态框*/
		$('#myModal_sxhbcxbtn').modal({backdrop:'static'});
		//思想汇报三个按钮----良好，进步，继续教育
	
		//评分良好按钮事件
		 $('#list_jdglDqbgqk #btn-lh').unbind('click').bind('click',function(){
			service.updateStatus(1,json.f_id, new Eht.Responder({
				success:function(data){
					$("#pf").val(1)
					new Eht.Tips().show();
					tableview.refresh();
				}
			}));
		});  
		//评分进步按钮事件
		$('#list_jdglDqbgqk #btn-jb').unbind('click').bind('click',function(){
			service.updateStatus(2,json.f_id, new Eht.Responder({
				success:function(data){
					$("#pf").val(2)
					new Eht.Tips().show();
					tableview.refresh();
				}
			}));
		});
		//评分继续教育按钮事件
		$('#list_jdglDqbgqk #btn-jxjy').unbind('click').bind('click',function(){
			service.updateStatus(3,json.f_id, new Eht.Responder({
				success:function(data){
					$("#pf").val(3)
					new Eht.Tips().show();
					tableview.refresh();
				}
			}));
			
		});
	});
	//保存
	$("#list_jdglDqbgqk #submit").click(function(){
		if(form.validate()){
			service.saveOne(From_Rcbd.getData(),new Eht.Responder({
				success:function(){
					new Eht.Tips().show();
					$('#myModal_append').modal('hide');
					tableview.refresh();
				}
			}))
			
		}
	});
	
});
</script>
</head>
<body>
	<div id="list_jdglDqbgqk">
	 <div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				姓名:<input class="btn btn-default" 	type="text" 	placeholder="请输入姓名"  name="xm[like]"			style="margin-left: 10px;"/>
					<input class="btn btn-default" 	type="button" 	id="query_cx" 		value="查询" 					style="margin-left: 10px;"/>
				 	<input class="btn btn-default" 	type="button" 	id="sxhbcxbtn" 		value="思想汇报信息查询审查"		style="margin-left: 10px;" disabled/>
			</fieldset>
		</div>
		<div id="list_jdglDqbgqk_Interface">
			<div field="op" 	label="选择" checkbox="true"></div>
			<div field="xm" 	label="姓名"></div>
			<div field="cts" 	label="创建时间"></div>
			<div field="f_pf" 	label="评分(已审核)"></div>
		</div>
	</div>
<!--思想汇报信息查询审查模态框，只是查看，内容不可编辑状态  -->
	<div class="modal fade" id="myModal_sxhbcxbtn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">定期报告情况</h4>
				</div>
				<div class="modal-body" id="From_sxhb">
					<input 	type="text" 	name="xm" 	label="社区矫正人员姓名" readonly="readonly" />
					<input 	type="text" 	name="cts" 	label="创建时间" 		readonly="readonly" />
					<input 	type="text" 	name="f_pf" id="pf"	label="评分" 	readonly="readonly" />
					<textarea type="text" 	name="f_hbnr" 	label="汇报内容" 	readonly="readonly"  rows="5" style="resize: none;"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btn-lh">良好</button>
					<button type="button" class="btn btn-success" id="btn-jb">进步</button>
					<button type="button" class="btn btn-success" id="btn-jxjy">继续教育</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>

</div>	
</body>
</html>