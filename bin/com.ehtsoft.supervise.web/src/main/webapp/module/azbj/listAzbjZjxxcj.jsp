<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>转监信息采集</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjZjxxcjService.js"></script>
<script type="text/javascript">
$(function(){
	var zjxxcj = new AzbjZjxxcjService();
	//模糊查询数据
	var query_ry = new Eht.Form({
		selector:"#zjxx_query",
		codeEmpty:true,
		codeEmptyLabel:"全部"
	});
	//人员信息显示
	var table_ry = new Eht.TableView({
		selector:"#zjxx_table_ry",
		multable:false
	});	
	//转监人员模态框
	var zjxx_form = new Eht.Form({
		selector:"#zjxx_form",
		autolayout:true
	});
	//获取选中标签的主表ID
	var check_id=null;
	//加载页面信息
	table_ry.loadData(function(page,res){
		zjxxcj.find_ry(query_ry.getData(),page,res);
	});
	//条件查询刷新
	$("#btn_query").click(function(){
		table_ry.refresh();
	});
	//增加按钮触发事件
 	$("#btn_add").click(function(){
 		check_id=null;
		zjxx_form.clear();
		zjxx_form.enable();
		findRy();
		$("#btn_save").show();
		$("#myModal").modal({backdrop:'static'});
	});
	//查看按钮触发事件
	$("#btn_search").click(function(){
		if($("#zjxx_table_ry :checkbox:checked").length==1){
			check_id = $("#zjxx_table_ry :checkbox:checked").data().aid;
			findRy();
			$("#myModal").modal({backdrop:'static'});
			$("#btn_save").hide();
			zjxx_form.disable();
			zjxx_form.fill($("#zjxx_table_ry :checkbox:checked").data());
		}else{
			wxzts();
		}
	});
	//编辑按钮触发事件
	$("#btn_edit").click(function(){
		if($("#zjxx_table_ry :checkbox:checked").length==1){
			check_id = $("#zjxx_table_ry :checkbox:checked").data().aid;
			findRy();
			zjxx_form.enable();
			$("#btn_save").show();
			$("#myModal").modal({backdrop:'static'});
			zjxx_form.fill($("#zjxx_table_ry :checkbox:checked").data());
		}else{
			wxzts();
		}
	});
	//删除按钮触发事件
	$("#btn_delete").click(function(){
		if($("#zjxx_table_ry :checkbox:checked").length==1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				zjxxcj.removeOne($("#zjxx_table_ry :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						table_ry.refresh();
						c.close();
						new Eht.Tips().show("删除成功");
					}
				}));
			});
		}else{
			wxzts();
			table_ry.refresh();
		}
	});
	//保存按钮触发事件
	$("#btn_save").click(function(){
		if(zjxx_form.validate()){
			zjxxcj.saveOne(zjxx_form.getData(),new Eht.Responder({
				success:function(data){
					$("#myModal").modal("hide");
					new Eht.Tips().show("保存成功");
					table_ry.refresh();
				}
			}));
		}else{
			new Eht.Tips().show("保存失败");
		}
	}); 
	//未选中提示
	function wxzts(){
		var ale = new Eht.Alert();
		ale.show("请选中一条数据进行操作!");
	}
	//模态框人员姓名信息
	function findRy(){
		zjxxcj.findZj(new Eht.Responder({
			success:function(data){
				$("#azbjryid").empty();
				$("#azbjryid").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					if(data[i].id==check_id){
						$("#azbjryid").append("<option value="+data[i].id+" selected>"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}else{
						$("#azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}				
				}
				$("#azbjryid").comboSelect();
			}
		}));
	}	
});

</script>
</head>
<body>
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="button" id="btn_search" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="zjxx_query">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="zrjs">转入监所</label>
			<input type="text" class="form-control" name="zrjs[like]" id="zrjs" placeholder="转入监所" >
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="zcjs">转出监所</label>
			<input type="text" class="form-control" name="zcjs[like]" id="zcjs" placeholder="转出监所">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sqzt">申请状态</label>
			<input type="text" class="form-control" name="sqzt[eq]" id="sqzt" placeholder="申请状态" code="SYS155">
		</div>
		<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="zjxx_table_ry" class="table_responsive">
	<div field="id" label="选择" checkbox="true" width="60" ></div>
	<div field="xm" label="姓名" width="100" ></div>
	<div field="zrjs" label="转入监所" ></div>
	<div field="zcjs" label="转出监所" ></div>		
	<div field="sqzt" label="申请状态" code="SYS155" ></div>
</div> 
<!-- 模态转监人员信息 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="width:800px">
		<div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				  <h4 class="modal-title" id="myModalLabel">转监人员信息</h4>
			</div>
	        <div  class="modal-body" style="overflow: auto;height:400px;">
	      		<div id="zjxx_form">
		      		<input type="hidden" name="id"> 
					<select id="azbjryid" name="azbjryid" label="转监人员" valid="{required:true}" style="max-width:none"></select> 		
		         	<input type="text" name="zrjs" label="转入监所" valid="{required:true}"/>
		         	<input type="text" name="zcjs" label="转出监所" valid="{required:true}"/>  
		         	<input type="text" name="sqzt" label="申请状态" code="SYS155"/>
		         	<textarea name="remark" id="floor" type="text"  label="备注" maxlength="500"  rows="4"></textarea>
	      		</div>
		  	</div>
		    <div class="modal-footer">
       			<button type="button" id="btn_save" class="btn btn-primary">保存</button>
       			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button> 
		    </div>
	  </div>
	</div>	
</div>
</body>
</html>