<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--王世凯  -->
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjRyqjxxService.js"></script>
<script type="text/javascript" src="${localCtx }/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<title>人员迁居信息管理</title>
<script type="text/javascript">
$(function() {
	var region = new RegionService();//省市区后台
	var dataService = new AzbjRyqjxxService();
	var commonService = new AzbjCommonService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table"});
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//模糊查询列表数据刷新
	$("#btn_search").click(function(){list_table.refresh();});
	//展示页面信息
	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
	//获取省市县的id值
	function findId(){
		shengs = $('#list_table :checkbox:checked').data().qrds;
		shis = $('#list_table :checkbox:checked').data().qrdsq;
		xians = $('#list_table :checkbox:checked').data().qrdx;
	}
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//已衔接人员姓名检索框
	function findYxjry(ryid){
		if (!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#sel_id").empty();
					$("#sel_id").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_id").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_id").comboSelect();
					findFlag = true;
				}
			}));
		}else{
			if(ryid!='-1'){
				$("#sel_id option[value="+ryid+"]").attr("selected","selected");
			}
		}
	}
	//新增按钮触发事件
	$("#btn_add").click(function(){
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_ryqj").modal({backdrop:'static'})
	});
	//点击显示省菜单
	$("#sel_shengji").click(sheng());
	//点击查看时显示代码只读
	$("#btn_view").click(function(){
		if(checkSelected()){
			form_add.clear();
			findId();
			sheng();
			$("#modal_ryqj").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			findYxjry($("#list_table :checkbox:checked").data().aid);
			form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//编辑按钮事件
	$("#btn_edit").click(function(){
		form_add.clear();
		if(checkSelected()){
		form_add.enable();
		$("#btn_save").show();
		findYxjry($("#list_table :checkbox:checked").data().aid);
		findId();
		sheng();
		$("#modal_ryqj").modal({backdrop:'static'});
		form_add.fill($("#list_table :checkbox:checked").data());
		}
	});
	//删除按钮事件
	$("#btn_delete").click(function(){
		if(checkSelected()){
			var confirm = new Eht.Confirm();
			$("#btn_save").show();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeRyqj($("#list_table :checkbox:checked").data().id,new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	});
	//模态框保存并且隐藏
	$('#btn_save').click(function(){
		if(form_add.validate()){
    		dataService.saveRyqj(form_add.getData(),new Eht.Responder({
    			success:function(){
    				$("#modal_ryqj").modal("hide");
    				new Eht.Tips().show();
    				list_table.refresh();
    			}
    		}));
		}
	});
	/* 省区联动  */
 	function sheng(){
 		form_add.clear();
		region.find(1,null,new Eht.Responder({	//省份初始化
			success:function(data){
				$("#sel_shengji").empty();
				for (var i = 0; i < data.length; i++) {
					if($("#list_table :checkbox:checked").length == 1){
						if(data[i].regionid == shengs){
							$("#sel_shengji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
						}else{$("#sel_shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
								}
					}else{$("#sel_shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					$("#sel_shengji").change();
					}
				}
			}))
		}
 	function shi(){
		region.find(2,$("#sel_shengji").val(),new Eht.Responder({ //市初始化
			success:function(data){
				$("#sel_shiji").empty();
				for (var i = 0; i < data.length; i++) {
					if($("#list_table :checkbox:checked").length == 1){
						if(data[i].regionid == shis){
							$("#sel_shiji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
						}else{
							$("#sel_shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}else{
						$("#sel_shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					$("#sel_shiji").change();
				}
				}
			}))
		}
 	function xian(){
		region.find(3,$("#sel_shiji").val(),new Eht.Responder({ //县初始化
			success:function(data){
				$("#sel_xianji").empty();
				for (var i = 0; i < data.length; i++) {
					if($("#list_table :checkbox:checked").length == 1){
						if(data[i].regionid == xians){
							$("#sel_xianji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
						}else{
							$("#sel_xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}else{
						$("#sel_xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}
				}
			}))
		}
	$("#sel_shengji").change(function(){  //市初始化
		shi();
	})
	$("#sel_shiji").change(function(){	//县初始化
		xian();
	})
});
</script>
</head>
<body>
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
	</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>
</div>
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sj">时间</label>
			<input type="text"  class="form_date btn btn-default" name="sj[like]" data-date-formate="yyyy-MM-dd" data-date-formate="yyyy-MM-dd" placeholder="时间">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="yy">原因</label>
			<input type="text" class="form-control" name="yy[like]" placeholder="原因">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="zt">状态</label>
			<input type="text" class="form-control" name="zt[like]" code="SYS153" placeholder="状态">
		</div>
			<button type="button" class="btn btn-primary" id="btn_search" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>		
	</div>
</form>
<div id="list_table" class="table-responsive">
	<div field="xzk" label="选择" checkbox=true width="60px;"></div>
	<div field="xm" label="姓名"></div>
	<div field="sj" label="时间"></div>
	<div field="yy" label="原因"></div>
	<div field="zt" label="状态"></div>
	<div field="shyj" label="审核意见"></div>
</div>
<!-- 新增迁居人员信息(Modal) -->
<div class="modal fade" id="modal_ryqj" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="ModalLabel">人员迁居信息</h4>
			</div>
			<div class="modal-body" style="overflow:auto;height:450px;">
				<div id="form_add">
					<input type="hidden" name="id"/>
					<select id="sel_id" name="azbjryid" label="迁居人员" style="max-width:none" valid="{required:true}"></select>
					<select name="qrds" type="text" id="sel_shengji" getdis="true" label="选择省份" valid="{required:true}">
						<option value="" selected="selected"></option>
					</select>
					<select name="qrdsq" type="text" id="sel_shiji" getdis="true" label="选择盟市" valid="{required:true}">
						<option value="" selected="selected"></option>
					</select>
					<select name="qrdx" type="text" id="sel_xianji" getdis="true" label="选择旗县" valid="{required:true}">
						<option value="" selected="selected"></option>
					</select>
					<input type="text" id="qrdxz" name="qrdxz" label="乡镇" placeholder="请填写乡镇" valid="{required:true}"/>
					<input type="text" id="qrdxxmph" name="qrdxxmph"  label="详细地址" placeholder="请填写详细地址" valid="{required:true}"/>
					<input type="text" label="时间" name="sj" class="form_date" data-date-formate="yyyy-MM-dd" valid="{required:true}" data-date-formate="yyyy-MM-dd" placeholder="时间">
					<input type="text" name="yy" label="原因" placeholder="原因" valid="{required:true}"/> 
					<input type="text" name="zt" label="状态" placeholder="状态" code="SYS153"/>
					<input type="text" name="shyj" label="审核意见" placeholder ="审核意见"/>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_save" class="btn btn-primary" type="button">保存</button>
				<button  class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>