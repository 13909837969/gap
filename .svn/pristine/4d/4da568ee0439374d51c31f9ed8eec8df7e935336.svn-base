<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--马妍  -->
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>安置帮教未成年人信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx }/json/AzbjWcnznxxcjbService.js"></script>
<script type="text/javascript"src="${localCtx }/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function() {
	var dataService = new AzbjWcnznxxcjbService();
	var commonService = new AzbjCommonService();
	//安置人员明细操作页面
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});		
	//查询条件表单form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//判断是否多次加载数据
	var findFlag = false;
	//展示页面信息
	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
	//查询按钮事件
	$("#btn_search").click(function(){list_table.refresh();});
	//新增按钮触发事件
	$("#btn_add").click(function() {
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_wcnxx").modal({backdrop :'static'});
	});
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1)
			return true;
		else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//编辑按钮事件
	$("#btn_edit").click(function() {
		if (checkSelected()) {
			form_add.enable();
			$("#btn_save").show();
			$("#modal_wcnxx").modal({backdrop:'static'});	
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);							
		}
	});
	//删除按钮事件
	$("#btn_delete").click(function(){
		if(checkSelected()){
			var confirm = new Eht.Confirm();
			$("#btn_save").show();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeWcnxx($("#list_table :checkbox:checked").data().id,new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	}); 
	//查看
	$("#btn_view").click(function() {
		if (checkSelected()) {
			$("#modal_wcnxx").modal({backdrop:'static'});	
				$("#btn_save").hide();
				form_add.disable();
				form_add.fill($("#list_table :checkbox:checked").data());
				findYxjry($("#list_table :checkbox:checked").data().aid);
		} 
	});
	//保存
	$("#btn_save").click(function() {
		if(form_add.validate()){
	    	dataService.saveWcnxx(form_add.getData(),new Eht.Responder({
	    		success:function(){
	    			$("#modal_wcnxx").modal("hide");
	    			new Eht.Tips().show();
	    			list_table.refresh();
	    		}
	    	}));
		}
	});
	//模态框查询矫正人员信息事件
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
		}
		if(ryid!='-1'){
			$("#sel_id option[value="+ryid+"]").attr("selected","selected");
			}
		}	
});
</script>
</head>
<body>
<div class="panel-heading">		
	<button id="btn_add" class="btn btn-default">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
	</button>
	<button id="btn_view" class="btn btn-default">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button id="btn_edit" class="btn btn-default">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
	</button>
	<button id="btn_delete" class="btn btn-default">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>	
</div>
<!-- 查询 -->
<form class="form-inline" style="margin: 10px;">
	<div id="form_search">
		<div class="form-group" style="margin-left: 10px;">
			<label for="jhrqk">监护人情况</label> 
			<input type="text" class="form-control" name="jhrqk[eq]" placeholder="监护人情况" code="sys156"/>
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="shkncd">生活困难程度</label> 
			<input type="text" class="form-control" name="shkncd[eq]" placeholder="生活困难程度" code="sys157"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sfsx">是否失学</label>
			<input type="text" class="form-control" name="sfsx[eq]"  placeholder="生活困难程度"code="sys229"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sfllsh">是否流浪社会</label>
			<input type="text"class="form-control" name="sfllsh[eq]" placeholder="是否流浪社会" code="sys230"/>
		</div>
		<div class="form-group" style="margin-left: 10px;">
			<label for="ywwffzxw">有无违法犯罪行为</label> 
			<input type="text"class="form-control" name="ywwffzxw[eq]" placeholder="有无违法犯罪行为" code="sys231"/>
		</div>
		<button type="button" id="btn_search" class="btn btn-primary"style="margin-left: 10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
		</button>
	</div>
</form>
<!-- 页面显示 -->
<div id="list_table" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true" width="60px"></div>
	<div field="wcnznxm" label="未成年子女姓名"></div>
	<div field="xb" label="性别" code="sys000"></div>
	<div field="jhrqk" label="监护人情况" code="sys156"></div>
	<div field="shkncd" label="生活困难程度" code="sys157"></div>
	<div field="sfsx" label="是否失学" code="sys229"></div>
	<div field="sfllsh" label="是否流浪社会" code="sys230"></div>
	<div field="ywwffzxw" label="有无违法犯罪行为" code="sys231"></div>
	<div field="csny" label="出生年月"></div>
</div>
<!-- 新增服刑人员未成年子女信息状态信息(Modal) -->
<div class="modal fade" id="modal_wcnxx" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">未成年子女信息采集表</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<div id="form_add">
					<input type="hidden" name="id"> 
					<select id="sel_id" name="azbjryid" label="服刑人员" style="max-width:none"></select> 
					<input type="text" name="wcnznxm" label="未成年子女姓名" valid="{required:true}"/>
					<input type="text" name="xb" label="性别" code="sys000" valid="{required:true}"/>
					<input type="text" name="jhrqk" code="sys156" label="监护人情况" valid="{required:true}"/> 
					<input type="text" name="shkncd" code="sys157" label="生活困难程度" valid="{required:true}"/>
					<input type="text" name="sfsx" code="sys229" label="是否失学"/> 
					<input type="text" name="sfllsh" code="sys230" label="是否流浪社会"/> 
					<input type="text" name="ywwffzxw"  code="sys231" label="有无违法犯罪行为"/> 
					<input type="text" name="csny" class="form_date" data-date-formate="yyyy-MM-dd"label="出生年月" valid="{required:true}"/>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_save" class="btn btn-primary" type="button">保存</button>
				<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>