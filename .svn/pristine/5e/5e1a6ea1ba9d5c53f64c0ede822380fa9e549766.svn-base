<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 牛新宇 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>安置信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjAzxxglService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjAzxxglService();
	var commonService = new AzbjCommonService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//列表数据显示table
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//安置人员明细操作页面
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//加载页面信息
	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
	//条件查询刷新
	$("#btn_search").click(function(){list_table.refresh();});	
	//增加按钮操作
	$("#btn_add").click(function() {
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_pop").modal({backdrop:'static'});
	});
	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
	//查看按钮操作
	$("#btn_view").click(function(){
		if(checkSelected()){
			$("#modal_pop").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//编辑按钮操作
	$("#btn_edit").click(function(){
		if(checkSelected()){	
			form_add.enable();
			$("#btn_save").show();
			$("#modal_pop").modal({backdrop:'static'});
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//删除按钮操作
	$("#btn_delete").click(function(){
		if(checkSelected()){
			var confirm = new Eht.Confirm();
			confirm.showDelete();
			confirm.onOk(function(){
				dataService.removeOne($("#list_table :checkbox:checked").data(),new Eht.Responder({
					success:function(){
						list_table.refresh();
						confirm.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	}); 
	//保存按钮操作
	$("#btn_save").click(function(){
		if(form_add.validate()){
    		dataService.saveOne(form_add.getData(),new Eht.Responder({
    			success:function(){
    				$("#modal_pop").modal("hide");
    				new Eht.Tips().show();
    				list_table.refresh();
    			}
    		}));
		}
	});
	//已衔接人员姓名检索框
	function findYxjry(ryid){
		if (!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#sel_azbjryid").empty();
					$("#sel_azbjryid").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					$("#sel_azbjryid").comboSelect();
					findFlag = true;
				}
			}));
		}
		if(ryid!='-1'){
			$("#sel_azbjryid option[value="+ryid+"]").attr("selected","selected");
		}
	}	
});
</script> 
</head>
<body>
<!-- 操作工具条 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="azfs">安置方式</label>
			<input type="text" class="form-control" name="azfs[eq]" placeholder="安置方式" code="SYS154"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="azsj">安置时间</label>
			<input type="text" class="form_date form-control" name="azsj[eq]" placeholder="安置时间" data-date-formate="yyyy-MM-dd"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdshjzfs">获得社会救助方式</label>
			<input type="text" class="form-control" name="hdshjzfs[eq]" placeholder="获得社会救助方式" code="SYS160"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdjyfwfs">获得就业服务方式</label>
			<input type="text" class="form-control" name="hdjyfwfs[eq]" placeholder="获得就业服务方式" code="SYS161"/>
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 列表数据 -->
<div id="list_table" class="table_responsive">
	<div field="id" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="姓名"></div>
	<div field="azfs" label="安置方式" code="SYS154"></div>
	<div field="azsj" label="安置时间"></div>
	<div field="hdshjzfs" label="获得社会救助方式" code="SYS160"></div>
	<div field="hdjyfwfs" label="获得就业服务方式" code="SYS161"></div>		
</div>
<!-- 安置人员信息 -->
<div class="modal fade" id="modal_pop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="width:600px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">安置人员信息</h4>
			</div>
            <div class="modal-body" style="overflow:auto;height:400px;">
		      	<div id="form_add">
		      		<input type="hidden" name="id"/>
		      		<select id="sel_azbjryid" name="azbjryid" label="安置人员" style="max-width:none" valid="{required:true}"></select> 		
		         	<input type="text" name="azfs" label="安置方式" code="SYS154" valid="{required:true}"/>
		         	<input type="text" name="azsj" label="安置时间" class="form_date" data-date-formate="yyyy-MM-dd" valid="{required:true}"/> 
		         	<input type="text" name="hdshjzfs" label="获得社会救助方式" code="SYS160"/>
		         	<input type="text" name="hdjyfwfs" label="获得就业服务方式" code="SYS161"/>  	
		         	<input type="text" name="sfxzblshbx" label="是否协助办理社会保险 " code="SYS001"/>     	
		         	<input type="text" name="zzcysflsjmszc" label="自主创业是否落实减免税政策" code="SYS001"/>     	
		         	<input type="text" name="csgtjysflsjmszc" label="从事个体经营是否落实减免税政策" code="SYS001"/>     	
		         	<input type="text" name="qyhjjsflsjmszc" label="企业和经济是否落实减免税政策" code="SYS001"/>     	
		         	<textarea name="remark" id="floor" type="text" label="备注" maxlength="500" rows="4"></textarea>
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