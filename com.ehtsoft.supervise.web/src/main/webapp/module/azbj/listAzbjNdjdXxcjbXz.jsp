<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 武文涛 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>年度鉴定信息采集表(乡镇)</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjNdjdXxcjbXzService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AzbjCommonService.js"></script>
<script type="text/javascript">
$(function(){
	var dataService = new AzbjNdjdXxcjbXzService();
	var commonService = new AzbjCommonService();
	//判断是否多次加载
	var findFlag = false;
	//查询条件表单Form 
	var form_search = new Eht.Form({selector:"#form_search",codeEmpty:true,codeEmptyLabel:"全部"});
	//列表数据显示table 
	var list_table = new Eht.TableView({selector:"#list_table",multable:false});
	//安置人员明细操作 
	var form_add = new Eht.Form({selector:"#form_add",autolayout:true});
	//加载页面信息
	list_table.loadData(function(page, res){dataService.findAll(form_search.getData(), page, res);});
	// 条件查询刷新 
	$("#btn_search").click(function(){list_table.refresh();});
	//增加按钮操作
	$("#btn_add").click(function(){
		form_add.clear();
		form_add.enable();
		findYxjry('-1');
		$("#btn_save").show();
		$("#modal_pop").modal({backdrop:"static"});
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
	//查看按钮事件
	$("#btn_view").click(function(){
		if(checkSelected()){
			$("#modal_pop").modal({backdrop:'static'});
			$("#btn_save").hide();
			form_add.disable();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//编辑按钮事件
	$("#btn_edit").click(function(){
		if(checkSelected()){	
			form_add.enable();
			form_add.clear();
			$("#btn_save").show();
			$("#modal_pop").modal();
			form_add.fill($("#list_table :checkbox:checked").data());
			findYxjry($("#list_table :checkbox:checked").data().aid);
		}
	});
	//删除按钮事件
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
				success:function(data){
					$("#modal_pop").modal("hide");
					new Eht.Tips().show();
					list_table.refresh();
				}
			}));
		}
	});
	//已衔接人员姓名检索
	function findYxjry(ryid){
		if (!findFlag){
			commonService.findYxjry(new Eht.Responder({
				success:function(data){
					$("#sel_azbjryid").empty();
					$("#sel_azbjryid").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#sel_azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");
					}
					/* $("#azbjryid").comboSelect(); */
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
<!-- 操作工具条件 -->
<div class="toolbar">
	<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
	</button>
	<button type="button" id="btn_view" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看
	</button>
	<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
	</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
	</button>					
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="form_search">
		<div class="form-group" style="max-width:none">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名"/>
		</div>
		<div class="form-group" style="margin-left:10px">
			<label for="khfzr">考核负责人</label>
			<input type="text" class="form-control" name="khfzr[like]" placeholder="考核负责人"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="nd">年度</label>
			<input type="text" class="form-control" name="nd[like]" placeholder="年度"/>
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="qzrq">签字日期</label>
			<input type="text" name="qzrq[like]" class="form-control form_date" data-date-formate="yyyy-MM-dd" placeholder="签字日期"/>
		</div>
		<button type="button" class="btn btn-primary" id="btn_search" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 列表数据 -->
<div id="list_table" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="姓名"></div>
	<div field="nd" label="年度"></div>
	<div field="khfzr" label="考核负责人"></div>
	<div field="qzrq" label="签字日期"></div>
</div>
<!-- 模态年度鉴定(乡镇)信息 -->
<div class="modal fade" id="modal_pop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">年度鉴定信息（乡镇）</h4>
			</div>
			<div class="modal-body" style="overflow:auto; height:450px;">
				<div class="modal-body-div">
					<div id="form_add">
					<!-- 添加信息-->
						<input type="hidden" name="id"/> 
						<select id="sel_azbjryid" name="azbjryid" label="安置帮教人员编号"></select>
						<input name="nd" type="text" label="年度" valid="{required:true}"/> 
						<input name="dqzfthqk" type="text" label="定期走访谈话情况" valid="{required:true}"/>
						<input name="bjxzcylsqk" type="text" label="帮教小组成员落实情况" valid="{required:true}"/> 
						<input name="jzjzqk" type="text" label="卷宗记载情况" valid="{required:true}"/>
						<input name="fzjyqk" type="text" label="法制教育情况" valid="{required:true}"/> 
						<input name="khfzr" type="text" label="考核负责人" valid="{required:true}"/>
						<input name="qzrq" type="text" class="form_date" data-date-formate="yyyy-MM-dd" label="签字日期" valid="{required:true}"/>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_save" class="btn btn-primary" type="button">保存</button>
				<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</body>
</html>