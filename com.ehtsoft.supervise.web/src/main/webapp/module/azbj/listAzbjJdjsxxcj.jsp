<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--李世伟  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjJdjsxxcjService.js"></script>
<title>安置帮教基地建设信息管理</title>
<script type="text/javascript">
$(function(){
	var service = new AzbjJdjsxxcjService();
	var form = new Eht.Form({selector:'#azbjjdjsxxc_form',autolayout:true});
	var tableview = new Eht.TableView({selector:'#tableview'});
	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(qf.getData(), page, res);
	});
	//获取当前选中行的数据
	form.fill($("#tableview :checkbox:checked").data());
	//新增按钮事件
	$('#btn_add').click(function(){
		form.clear();
		$('#myModal').modal({backdrop:'static'});
		form.enable();
	});	
	//点击查询时查模糊查询
	$("#btn_search").click(function(){
		tableview.refresh();
	});	
	//修改按钮事件
	$("#btn_edit").click(function(){
		if($("#tableview :checkbox:checked").length==1){
			form.enable();
			form.clear();
			$("#btn_submit").show();
			$("#myModal").modal();
			form.fill($("#tableview :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");	
			tableview.refresh();
		}
		});
	//删除按钮事件
	$("#btn_delete").click(function() {
		if($("#tableview :checkbox:checked").length == 1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				service.removeOne($("#tableview :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						tableview.refresh();
						c.close();
						new Eht.Tips().show("删除成功");
					}
				}));
			});
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//查看按钮触发事件
	$("#btn_view").click(function(){
		if($("#tableview :checkbox:checked").length==1){
			v = $('#tableview :checkbox:checked').data().id;
			$("#myModal").modal({backdrop : 'static'});
			$("#btn_submit").hide();
			form.disable();	
			form.fill($("#tableview :checkbox:checked").data());	
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			tableview.refresh();
		}
	});
	//模态框保存并且隐藏
	$('#btn_submit').click(function(){
		  if (form.validate()) { 
				service.saveOne(form.getData(), new Eht.Responder({
					success : function(data) {
						$('#myModal').modal('hide');
						new Eht.Tips().show("保存成功");
						tableview.refresh();
					}
				}));
		}else{
		new Eht.Tips().show("保存失败");
		}  
	});
}); 
</script>
</head>
<body>		
<div class="toolbar">
	<button type="submit"  id="btn_add" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="submit"  id="btn_view" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="submit" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="submit"  id="btn_delete" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>		
</div>
<form class="form-inline" style="margin:10px;">
	<div id="query_form">
	   <div class="form-group" style="margin-left: 10px">
			<label for="jdmc">基地名称</label>
			<input type="text" class="form-control" name="jdmc[like]" id="jdmc" placeholder="请输入基地名称" >
		</div>	
		<div class="form-group" style="margin-left: 10px">
			<label for="jdlx">基地类型</label>
			<input type="text" class="form-control" name="jdlx[eq]" id="jdlx" code="sys194">	
		</div>
			<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="tableview" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true"></div>
	<div field="jdmc"  label="基地名称"></div>
	<div field="jdlx" label="基地类型" code="sys194"></div>
	<div field="azxmsfrysl" label="安置刑满释放人员数量" ></div>
	<div field="lsazzrs" label="历史安置总人数" ></div>
	<div field="jdjzmj" label="基地建筑面积" ></div>
	<div field="jdfjs" label="基地房间数" ></div>
	<div field="lsjmszcrs" label="落实减免税政策人数" ></div>
</div>
<!-- 新增基地信息(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">基地建设管理信息</h4>
				</div>
			<div class="modal-body" style="overflow: auto; height: 600px;">
				<div class="modal-body-div">	
					<div id="azbjjdjsxxc_form">
						<input type="hidden" name="id"> 
			        	<input type="text"  name="jdmc"   label="基地名称" placeholder="基地名称"  valid="{required:true}" >	
			        	<input type="text"  name="jdlx"   label="基地类型" placeholder="基地类型" code="sys194" valid="{required:true}" >	
			        	<input type="text"  name="jdxxdz"   label="基地详细地址" placeholder="基地详细地址" valid="{required:true}" >	
			        	<input type="text"  name="jdyb"   label="基地邮编" placeholder="基地邮编" valid="{required:true}" >	
	                	<input type="text" name="azxmsfrysl" label="安置刑满释放人员数量" placeholder="安置刑满释放人员数量" valid="{required:true}">
						<input type="text"  name="lsazzrs"   label="历史安置总人数" placeholder="历史安置总人数" valid="{required:true}" /> 
						<input type="text"  name="jdjzmj" label="基地建筑面积" placeholder="基地建筑面积" />
						<input type="text"  name="jdfjs" label="基地房间数" placeholder="基地房间数" />
						<input type="text"  name="lsjmszcrs" label="落实减免税政策人数" placeholder="落实减免税政策人数" />
	            	</div>  
		   	  	</div>
				<div class="modal-footer">
					<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
					<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>