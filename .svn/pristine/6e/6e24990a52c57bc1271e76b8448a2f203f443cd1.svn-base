<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--陈崇 --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询未成年子女帮扶信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjWcnznbfxxcjbService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
    var commonService = new AzbjCommonService();
	var dataService = new AzbjWcnznbfxxcjbService();
	//判断是否多次加载数据
	var findFlag = false;
	//查询条件表单Form
 	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
 	//安置人员明细操作页面
 	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
 	//列表数据显示table
 	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
 	//展示页面信息
 	list_table.loadData(function(page,res){dataService.findAll(form_search.getData(),page,res);});
 	//判断是否选中的公用方法
	function checkSelected(){
		if($("#list_table :checkbox:checked").length==1){
			return true;
		}else{
			new Eht.Alert().showNotSelected();
			return false;
		}
	}
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
	//新增按钮操作
  	$("#btn_add").click(function(){		
	    findYxjry('-1'); 
	    form_add.clear();
	    form_add.enable();
  	   	$("#btn_save").show();
		$("#modal_pop").modal({backdrop:'static'});
  	});
  	//查询按钮操作
  	$("#btn_search").click(function(){list_table.refresh();});
  	//编辑按钮事件
  	$("#btn_edit").click(function(){
  	    if(checkSelected()){
  		    form_add.enable();
   			$("#btn_save").show();
   			$("#modal_pop").modal({backdrop:'static'});
   			form_add.fill($("#list_table :checkbox:checked").data());
   			findYxjry($("#list_table :checkbox:checked").data().aid);     			
		}
  	});
  	//查看按钮操作
  	$("#btn_view").click(function() {
		if(checkSelected()){
			$("#btn_save").hide();
			$("#modal_pop").modal({backdrop:'static'});
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
 	//删除事件
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
    //模态框查询以衔接人员信息
  	function findYxjry(ryid){
		if(!findFlag){
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
			$("#sel_azbjryid option[value="+ryid+"]").attr("selected", "selected");
		}
	}
});
</script>
</head>
<body>
<div class="toolbar">
   	<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
   	<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="请输入姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sfzh">身份证号</label>
			<input type="text" class="form-control" name="sfzh[like]" placeholder="请输入身份证号"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jzd">居住地</label>
			<input type="text" class="form-control" name="jzd[like]" placeholder="请输入居住地"/>
		</div>
		<button id="btn_search" type="button" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
   	</div>
</form>
<div id="list_table" class="table-responsive">
	<div field="xz" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="服刑人员"></div>
	<div field="sfrzetfly" label="是否入住儿童福利院" code="SYS232"></div>
	<div field="sfjtjy" label="是否家庭寄养" code="SYS233"></div>
	<div field="sfrzjzzhbhzx" label="是否入住救助站或保护中心" code="SYS234"></div>
	<div field="sflsdb" label="是否落实低保" code="SYS235"></div>
	<div field="sffx" label="是否复学" code="SYS236"></div>
	<div field="sffflsbt" label="是否发放临时补贴" code="SYS237"></div>
	<div field="sfjmxzf" label="是否减免学杂费" code="SYS238"></div>
	<div field="sfzh" label="身份证号"></div>
</div>
<!-- 新增未成年子女帮扶信息(Modal) -->
<div class="modal fade" id=modal_pop tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   	<div class="modal-dialog" style="width:600px;">
   		<div class="modal-content">
   			<div class="modal-header">
   				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
   				<h4 class="modal-title">未成年子女帮扶信息</h4>
   			</div>
   			<div class="modal-body" style="height:400px; overflow:auto">
   				<div class="modal-body-div">
   					<div id="form_add" >
   						<input type="hidden" name="id"/>
   						<select id="sel_azbjryid" name="azbjryid" label="服刑人员" style="max-width:none"></select>
						<input name="sfrzetfly" label="是否入住儿童福利院" code="SYS232" valid="{required:true}"/>
						<input name="sfjtjy" label="是否家庭寄养" code="SYS233" valid="{required:true}">
						<input name="sfrzjzzhbhzx" label="是否入住救助站或保护中心" code="SYS234" valid="{required:true}"/>
						<input name="sflsdb" label="是否落实低保" code="SYS235" valid="{required:true}"/>
						<input name="sffx" label="是否复学" code="SYS236" valid="{required:true}"/>
						<input name="sffflsbt" label="是否发放临时补贴" code="SYS237" valid="{required:true}"/>
						<input name="sfjmxzf" label="是否减免学杂费" code="SYS238" valid="{required:true}"/>
						<input name="bfhdkzcs" label="帮扶活动开展次数" placeholder="帮扶活动开展次数" valid="{required:true,int:true}"/></br>
						<input name="hjd" label="户籍地" placeholder="户籍地" valid="{required:true}"/></br>
						<input name="jzd" label="居住地" placeholder="居住地" valid="{required:true}"></br>
						<input name="sfzh" label="身份证号" placeholder="身份证号" valid="{required:true,cardNo:true}"/></br>
   					</div>
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