<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>工作信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjGzjlglService.js"></script>
<script type="text/javascript">
$(function(){
 		var gzjl = new AzbjGzjlglService();
 		var gzjl_query = new Eht.Form({selector:"#gzjlForm",autolayout:true});
 		var form = new Eht.Form({selector:"#gzjl_query_form",codeEmpty:true,codeEmptyLabel:"全部"});
 		var gzjl_table = new Eht.TableView({selector:"#tableview",multable:false});
 		
 		//展示所有工作信息
 		gzjl_table.loadData(function(page,res){
 			gzjl.findAll(form.getData(), page, res);
 		});
 		
 		//查询按钮事件
 		$("#btn_gzjl_query").click(function(){
 			gzjl_table.refresh();
 		});
 		
 		//新增按钮触发事件
 		$('#btn_add').click(function(){
 			gzjl_query.clear();
 			$('#gzjl_modal').modal({backdrop:'static'});
 			gzjl_query.enable();
 		});
 		
 		//查看按钮触发事件
 		$("#btn_search").click(function(){
 			if($(":checkbox:checked").length==1){
 				$("#gzjl_modal").modal();
 				gzjl_query.disable();
 				$("btn_submit").hide();
 				gzjl_query.fill($(":checkbox:checked").data());
 			}else{
 				var ale = new Eht.Alert();
 				ale.show("请选中一条数据进行操作!");
 				//table_ry.refresh();
 			}
 		});
 		
 		//修改按钮事件
 		$("#btn_edit").click(function() {
			if($(":checkbox:checked").length==1){
				gzjl_query.enable();
				gzjl_query.clear();
				$("#btn_save").show();
				$("#gzjl_modal").modal();
				gzjl_query.fill($(":checkbox:checked").data());
			}
		});

 		//删除按钮事件
 		$("#btn_delete").click(function(){
 			var sd_ry = gzjl_table.getSelectedData();
 			if(sd_ry.length==1){
 				var c = new Eht.Confirm();
 				c.show("此操作不可恢复！确定要删除选中记录吗？");
 				c.onOk(function(){
 					gzjl.removeOne($(":checkbox:checked").data().id,new Eht.Responder({
 						success:function(){
 							gzjl_table.refresh();
 							c.close();
 							new Eht.Tips().show("删除成功");
 						}
 					}));
 				});
 			}else{
 				var ale = new Eht.Alert();
 				ale.show("请选中一条数据进行操作!!!!!!!!");
 			}	
 		});
 	
 		//模态框保存并且隐藏
 		$('#btn_save').click(function(){
 			if(gzjl_query.validate()){
 				gzjl.saveOne(gzjl_query.getData(),new Eht.Responder({
 					success:function(data){
 						$('#gzjl_modal').modal('hide');
 						gzjl_table.refresh();
 					}
 				}));
 			}
 		});
 		
 		//模态框查询矫正人员信息事件
     	gzjl.findJz(new Eht.Responder({
     		success:function(data){
     			$("#jzryxx_xm").empty();
     			$("#jzryxx_xm").append('<option selected="selected"></option>');
     			var jzid = $(":checkbox:checked").data()
     			for(var i=0;i<data.length;i++){
     				if(i<0){
     					$("#jzryxx_xm").append("<option value="+data[i].id+"selected>"+data[i].xm+"		"+data[i].grlxdh+"</option>");
     				}else{
     					$("#jzryxx_xm").append("<option value="+data[i].id+">"+data[i].xm+"		"+data[i].grlxdh+"</option>");
     				}
     			}
     			$("#jzryxx_xm").comboSelect();
     		}
     	}));
});
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button id="btn_search" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
	<button id="btn_delete" type="submit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 条件查询部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="gzjl_query_form">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" id="xm_query" placeholder="姓名" style="width:100px">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="xsbx">现实表现</label>
			<input type="text" class="form-control" name="xsbx[eq]" id="xsbx_query" placeholder="现实表现" code="sys149">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="gzqk">工作情况</label>
			<input type="text" class="form-control" name="gzqk[eq]" id="gzqk_query" placeholder="工作情况" code="sys150">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jjzk">经济状况</label>
			<input type="text" class="form-control" name="jjzk[eq]" id="jjzk_query" placeholder="经济状况" code="sys240">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jtqk">家庭情况</label>
			<input type="text" class="form-control" name="jtqk[eq]" id="jtqk_query" placeholder="家庭情况" code="sys151">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdcs">活动场所</label>
			<input type="text" class="form-control" name="hdcs[eq]" id="hdcs_query" placeholder="活动场所" code="sys152">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="shjw">社会交往</label>
			<input type="text" class="form-control" name="shjw[eq]" id="shjw_query" placeholder="社会交往" code="sys153">
		</div>
		<button id="btn_gzjl_query" type="button" class="btn btn-primary" style="margin-left:10px;">
		<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 页面表格展示 -->
<div id="tableview">
	<div field="xz" label="选择" checkbox="true"></div>
	<div field="xm" label="姓名" code="SYS149"></div>
	<div field="xsbx" label="现实表现" code="SYS149"></div>
	<div field="gzqk" label="工作情况" code="SYS150"></div>
	<div field="jjzk" label="经济状况" code="SYS240"></div>
	<div field="jtqk" label="家庭情况" code="SYS151"></div>
	<div field="hdcs" label="活动场所" code="SYS152"></div>
	<div field="shjw" label="社会交往" code="SYS153"></div>
</div>
<!-- 模态框 -->
<div class="modal fade" id="gzjl_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:800px">
		<div class="modal-content">
			<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="myModalLabel">矫正人员工作信息</h4>
      		</div>
      		<div class="modal-body" style="overflow: auto;height:400px;">
      			<div id="gzjlForm">
     	      		<input type="hidden" name="id">
					<select id="jzryxx_xm" name="azbjryid" label="矫正人员" style="max-width:none">
					</select>
					<!-- <input id="xm" type="hidden" name="xm" label="姓名"> -->
					<input id="xsbx" type="text" name="xsbx" label="现实表现" placeholder="现实表现" code="sys149" valid="{required:true}"/>
					<input id="qzqk" type="text" name="gzqk" label="工作情况" placeholder="工作情况" code="sys150" valid="{required:true}"/>
					<input id="jjzk" type="text" name="jjzk" label="经济状况" placeholder="经济状况" code="sys240" valid="{required:true}"/>
					<input id="jtqk" type="text" name="jtqk" label="家庭情况" placeholder="家庭情况" code="sys151" valid="{required:true}"/>
					<input id="hdcs" type="text" name="hdcs" label="活动场所" placeholder="活动场所" code="sys152" valid="{required:true}"/>
					<input id="shjw" type="text" name="shjw" label="社会交往" placeholder="社会交往" code="sys153" valid="{required:true}"/>
					<textarea id="knhwt" name="knhwt" type="text"  label="困难和问题"  maxlength="500" placeholder="困难和问题" rows="8" valid="{required:true}"></textarea>
					<textarea id="remark" name="remark" type="text"  label="备注"  maxlength="500" placeholder="备注" rows="8"></textarea>
					<input id="zrqmj" type="text" name="zrqmj" label="责任区民警" valid="{required:true}">
					<input id="sj" type="date" name="sj" class="btn btn_defult" data-date-formate="yyyy-MM-dd" label="时间" placeholder="时间" valid="{required:true}"> 
					<input id="dd" type="text" name="dd" label="地点" valid="{required:true}">
        		</div>
        		<div class="modal-footer">
        			<button type="button" id="btn_save" class="btn btn-primary">保存</button>
        			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        		</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>

