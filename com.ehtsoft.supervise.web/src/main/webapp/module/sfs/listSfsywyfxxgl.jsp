<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所业务用房信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SfsywyfService.js"></script>

<script type="text/javascript">
$(function(){
	//连接service
	var ywyfService = new SfsywyfService();
	var formtj = new Eht.Form({
		selector:'#Ywyf-Form',
		autolayout:true
	});
	var formxg = new Eht.Form({
		selector:"#Ywyfxg-Form",
		autolayout:true
	});
	
	var tableview = new Eht.TableView({
		selector:'#tableview'
	});
	
	var query = {};
	//页面加载时
	tableview.loadData(function(page,res){
		ywyfService.find(query,page,res);
	});
	//将一行数据放入json_data
	var json_data = {};
	tableview.clickRow(function(data){
		json_data = data;
	});
	
	//点击查询按钮
	$('#search').click(function(){
		query["jgbm[like]"] = $("#search-bm").val();
		tableview.refresh();
	});	
	//点击添加按钮
	$('#add').click(function(){
		//添加司法所bm
	ywyfService.findSfs({},new Eht.Responder({
			success:function(data){
			$("#ywyfform_sfsbmAndsfsmc").empty();
			$("#ywyfform_sfsbmAndsfsmc").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				$("#ywyfform_sfsbmAndsfsmc").append("<option value="+data[i].id+">"+data[i].jgbm + "     " + data[i].jgmc +"</option>");
			}
			$("#ywyfform_sfsbmAndsfsmc").comboSelect();
			}
		})); 
		$('#add_myModal').modal({backdrop:'static'});
	});
	
	//点击修改按钮
	$("#edit").click(function(){
		formxg.fill(json_data);
		if(json_data.id==null){
			$("#close_alert_div").show();
		}else{
			$("#update_myModal").modal({backdrop:'static'});		
		}
	});
	
	//点击删除按钮
	$("#delete").click(function(){
		if(json_data.id==null){
			$("#close_alert_div").show();
		}else{
			$("#delete_alert_div").show();
		}
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	
	$('#yes').click(function(){
		debugger;
		ywyfService.deleteOne(json_data.id,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	
	$('#close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#no').click(function(){
		$('#delete_alert_div').hide();
	});
	
	//保存添加信息
	$('#submit').click(function(){
		if(formtj.validate()){
			ywyfService.save(formtj.getData(),new Eht.Responder({
				success:function(data){
					$('#add_myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
		formtj.clear();
	});
	//保存修改
	$("#bcxg").click(function(){
		if(formxg.validate()){
			ywyfService.save(formxg.getData(),new Eht.Responder({
				success:function(){
					tableview.refresh();
					$("#update_myModal").modal("hide");
				}
			}));
			formxg.clear();
			json_data.id=null;
		}
		
	});
	
});
</script>
<style type="text/css">
#tableview th{
	vertical-align: middle;
	text-align: center;
}
</style>
</head>
<body>
	<div id="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-bm" class="btn btn-default" placeholder="请输入司法所编码"/>
					<input type="button" id="search" class="btn btn-default" value="查询"/>
					<input type="button" id="add" class="btn btn-default" value="新增"/>
					<input type="button" id="edit" class="btn btn-default" value="修改"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="jgbm" label="司法所编号"></div>
					<div field="jgmc" label="司法所名称"></div>
					<div field="dlywyf" label="独立业务用房" code="sys001"></div>
					<div field="bgcssj" label="办公场所实景" ></div>
					<div field="ywyfcqgs" label="业务用房产权归属"></div>
					<div field="ywyftzf" label="业务用房投资方"></div>
					<div field="ywyfxz" label="业务用房性质" code="SYS207"></div>
					<div field="ywyfmj" label="业务用房面积"></div>
					<div field="ywyftzje" label="业务用房投资金额"></div>
					<div field="jcsj" label="建成时间"></div>
				</div>
			</div>
		</div>
		<!-- 新增业务用房信息-->
		<div class="modal fade" id="add_myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增业务用房信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div id="Ywyf-Form">
							<select id="ywyfform_sfsbmAndsfsmc" name="s_id" label="司法所编码" ></select>
 							<!-- <input type="text" id="sfsbm"  name="sfsbm" label="司法所编码" autoComplete="off" valid="{required:true}"/> -->
							<input type="text" id="dlywyf" name="dlywyf"  label="独立业务用房" getdis="true"  valid="{required:true}" code="sys001" />
							<!-- <input type="text" id="bgcssj" name="bgcssj" label="办公场所实景" > -->
							<input id="jcsj" type="text" name="jcsj" label="建成时间" getdis="true" class="form_date" data-date-formate="yyyy-MM-dd" />
							<select name="bgcssj"  label="办公场所实景"> 
								<option value=""></option> 
								<option value="01">司法所照片</option>
								<option value="02">办公场所实景</option>
								<option value="03">制度文件</option>
							</select>
							<select name="ywyfcqgs"  label="业务用房产权归属"> 
								<option value=""></option> 
								<option value="01">县（市、区）司法局</option>
								<option value="02">乡镇（街道）政府</option>
								<option value="03">司法所</option>
								<option value="99">其他</option>
							</select>
							<select name="ywyftzf"  label="业务用房投资方"> 
								<option value=""></option> 
								<option value="01">中央投资</option>
								<option value="02">地方投资</option>
								<option value="03">中央和地方共同投资</option>
								<option value="99">其他</option>
							</select>
							<input id="ywyfxz" type="text" name="ywyfxz" label="业务用房性质" code="SYS207"> 
							<input id="ywyfmj" type="text" name="ywyfmj" label="业务用房面积" getdis="true"valid="{number:true}"/>
							<input id="ywyftzje" type="text" name="ywyftzje" label="业务用房投资金额" getdis="true" valid="{number:true}"/>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="submit" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 修改业务用房信息模态框 -->
			<div class="modal fade" id="update_myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">修改业务用房信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div id="Ywyfxg-Form">
							<input type="text" id="jgbm" name="jgbm"  label="司法所编码" getdis="true"  valid="{required:true}" disabled="disabled" />
							<input type="text" id="dlywyf1" name="dlywyf"  label="独立业务用房" getdis="true"  valid="{required:true}" code="sys001" />
							<input type="text" id="bgcssj1" name="bgcssj" label="办公场所实景" >
							<input id="jcsj1" type="text" name="jcsj" label="建成时间" getdis="true" class="form_date" data-date-formate="yyyy-MM-dd" />
							<input id="bgcssj1" name="bgcssj" label="办公场所实景" code="SYS218">
							<input id="ywyfcqgs1" name="ywyfcqgs" label="业务用房产权归属" code="SYS219">
							<input id="ywyftzf1" name="ywyftzf" label="业务用房投资方" code="SYS220">
							<input id="ywyfxz1" type="text" name="ywyfxz" label="业务用房性质" code="SYS207"> 
							<input id="ywyfmj1" type="text" name="ywyfmj" label="业务用房面积" getdis="true"valid="{number:true}"/>
							<input id="ywyftzje1" type="text" name="ywyftzje" label="业务用房投资金额" getdis="true" valid="{number:true}"/>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="bcxg" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>