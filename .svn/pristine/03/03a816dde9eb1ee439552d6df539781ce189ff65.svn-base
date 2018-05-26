<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所工作经费来源信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SfsgzjflyService.js"></script>

<script type="text/javascript">
$(function(){
	//连接service
	var gzjflyService = new SfsgzjflyService();
	var formtj = new Eht.Form({
		selector:'#gzjf-Form',
		autolayout:true
	});
	var formxg = new Eht.Form({
		selector:"#gzjfxg-Form",
		autolayout:true
	});
	
	var tableview = new Eht.TableView({
		selector:'#tableview'
	});
	
	var query = {};
	//页面加载时
	tableview.loadData(function(page,res){
		gzjflyService.find(query,page,res);
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
	$("#add").click(function(){
			//动态添加审批历史记录信息
   			gzjflyService.findSfs({},new Eht.Responder({
				success:function(data){
				$("#gzjfform_sfsbmAndsfsmc").empty();
				$("#gzjfform_sfsbmAndsfsmc").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#gzjfform_sfsbmAndsfsmc").append("<option value="+data[i].id+">"+data[i].jgbm + "     " + data[i].jgmc +"</option>");
				}
				$("#gzjfform_sfsbmAndsfsmc").comboSelect();
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
		gzjflyService.deleteOne(json_data.id,new Eht.Responder({
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
			gzjflyService.save(formtj.getData(),new Eht.Responder({
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
			gzjflyService.save(formxg.getData(),new Eht.Responder({
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
				<strong>提示</strdong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="jgbm" label="司法所编号"></div>
					<div field="lrysqk" label="列入预算情况" code="SYS001"></div>
					<div field="lrysjb" label="列入预算级别"></div>
					<div field="zyzfzyzfzj" label="中央政法转移支付资金" code="SYS001" ></div>
					<div field="qtzjly" label="其他资金来源"></div>
					<div field="nf" label="年份"></div>
					<div field="jfse" label="经费数额"></div>
				</div>
			</div>
		</div>
		<!-- 新增工作经费来源信息-->
		<div class="modal fade" id="add_myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增工作经费来源信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div id="gzjf-Form">
							<select id="gzjfform_sfsbmAndsfsmc" name="s_id" label="司法所编码" ></select>
 							<!-- <input type="text" id="sfsbm"  name="sfsbm" label="司法所编码" autoComplete="off" valid="{required:true}"/> -->	
							<input type="text" id="lrysqk" name="lrysqk"  label="列入预算情况" getdis="true" valid="{number:true}" code="SYS001" />
							<input type="text" id="lrysjb" name="ltysjb"  label="列入预算级别" getdis="true" valid="{number:true}" code="SYS208" />
							<input type="text" id="zyzfzyzfzj" name="zyzfzyzfzj"  label="中央政法转移支付资金" getdis="true" valid="{number:true}" code="SYS001" />
							<input type="text" id="qtzjly" name="qtzjly"  label="其他资金来源" getdis="true" />
							<input type="text" id="nf"  name="nf" label="年份" getdis="true" class="form_date" />
							<input type="text" id="zfjlysl" name="jfse"  label="经费数额" getdis="true" valid="{number:true}" />
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="submit" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 修改工作经费来源信息模态框 -->
			<div class="modal fade" id="update_myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">修改工作经费来源信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div id="gzjfxg-Form">
							<input type="text" id="jgbm" name="jgbm"  label="司法所编码" getdis="true"  valid="{required:true}" disabled="disabled" />
							<input type="text"  name="lrysqk"  label="列入预算情况" getdis="true" valid="{number:true}" />
							<input type="text"  name="ltysjb"  label="列入预算级别" getdis="true" valid="{number:true}" code="SYS208" />
							<input type="text"  name="zyzfzyzfzj"  label="中央政法转移支付资金" getdis="true" valid="{number:true}" />
							<input type="text"  name="qtzjly"  label="其他资金来源" getdis="true"  />
							<input type="text"  name="nf" label="年份"  class="form-control form_date"  getdis="true" />
							<input type="text"  name="jfse"  label="经费数额" getdis="true" valid="{number:true}" />
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