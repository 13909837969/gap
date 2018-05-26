<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>安置信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjAzxxglService.js"></script>
<script type="text/javascript">
//未选中提示
function wxzts(){
	var ale = new Eht.Alert();
	ale.show("请选中一条数据进行操作!");
}
$(function(){
	var azxxgl=new AzbjAzxxglService();
	var query_ry = new Eht.Form({selector:"#azxx_query",codeEmpty:true,codeEmptyLabel:"全部"});//人员信息查询条件
	var table_ry = new Eht.TableView({selector:"#azxx_table_ry",multable:false});//人员信息显示表格
	var azbj_form = new Eht.Form({selector:"#azbj_form",autolayout:true});//安置人员模态框
	//加载页面信息
	table_ry.loadData(function(page,res){	
		azxxgl.find_ry(query_ry.getData(),page,res);	
	});
	//条件查询刷新
	$("#btn_query").click(function() {
		table_ry.refresh();
	}); 
	//增加按钮触发事件
	$("#btn_add").click(function() {
		azbj_form.clear();
		$('#azbj_azxx').modal({backdrop:'static'});
		azbj_form.enable();
	});
	//查看按钮触发事件
	$("#btn_search").click(function(){
		if($(":checkbox:checked").length==1){
			$("#azbj_azxx").modal({backdrop:'static'});
			$("#btn_save").hide();
			azbj_form.disable();
			azbj_form.fill($(":checkbox:checked").data());
		}else{
			wxzts();
		}
	});
	//编辑按钮触发事件
	$("#btn_edit").click(function(){
		if($(":checkbox:checked").length==1){
			azbj_form.enable();
			azbj_form.clear();
			$("#azbj_azxx").modal({backdrop:'static'});
			azbj_form.fill($(":checkbox:checked").data());
		}else{
			wxzts();
		}
	});
	//删除按钮触发事件
	$('#btn_delete').click(function(){
		if(table_ry.getSelectedData().length==1){
			if (confirm("此操作不可恢复，确定要删除选中记录吗！")) {
				azxxgl.removeOne($(":checkbox:checked").data().id);
				new Eht.Tips().show("删除成功");
				table_ry.refresh();
			} 
		}else{
			wxzts();
			table_ry.refresh();
		}
	}); 
	//模态框安置人员姓名
	azxxgl.findAz(new Eht.Responder({
		success:function(data){
			$("#azbjryid").empty();
			$("#azbjryid").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
					$("#azbjryid").append("<option value="+data[i].id+"selected>"+data[i].xm +"   "+ data[i].grlxdh + "</option>");			
					$("#azbjryid").append("<option value="+data[i].id+">"+data[i].xm +"   "+ data[i].grlxdh + "</option>");		
			}
			$("#azbjryid").comboSelect();
		}
	}));
	//保存按钮
	$("#btn_submit").click(function(){
		if(azbj_form.validate()){
    		azxxgl.saveOne(azbj_form.getData(),new Eht.Responder({
    			success:function(data){
    				azbj_form.clear();
    				$("#azbj_azxx").modal("hide");
    				new Eht.Tips().show("保存成功");
    				table_ry.refresh();
    			}
    		}));
		}
	});
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
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
	<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="azxx_query">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="azfs">安置方式</label>
			<input type="text" class="form-control" name="azfs[eq]" id="azfs" placeholder="安置方式" code="SYS154">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="azsj">安置时间</label>
			<input type="text" class="form_date" name="azsj[eq]" id="azsj" placeholder="安置时间" data-date-formate="yyyy-MM-dd">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdshjzfs">获得社会救助方式</label>
			<input type="text" class="form-control" name="hdshjzfs[eq]" id="hdshjzfs" placeholder="获得社会救助方式" code="SYS160">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="hdjyfwfs">获得就业服务方式</label>
			<input type="text" class="form-control" name="hdjyfwfs[eq]" id="hdjyfwfs" placeholder="获得就业服务方式" code="SYS161">
		</div>
		<button type="button" id="btn_query" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
 <div id="azxx_table_ry" class="table_responsive">
	<div field="id" label="选择" checkbox="true" width="60"></div>
	<div field="xm" label="姓名" width="100"></div>
	<div field="azfs" label="安置方式" code="SYS154" ></div>
	<div field="azsj" label="安置时间" ></div>		
	<div field="hdshjzfs" label="获得社会救助方式" code="SYS160"></div>
	<div field="hdjyfwfs" label="获得就业服务方式" code="SYS161"></div>		
</div> 
<!-- 模态安置人员信息 -->
<div class="modal fade" id="azbj_azxx" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="width:800px">
		<div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
 			  <h4 class="modal-title" id="myModalLabel">安置人员信息</h4>
			</div>
            <div class="modal-body" style="overflow: auto;height:400px;">
		      	<div id="azbj_form">
		      		<input type="hidden" name="id"> 
					<select id="azbjryid" name="azbjryid" label="安置人员" valid="{required:true}" style="max-width:none"></select> 		
		         	<input type="text" name="azfs" label="安置方式" code="SYS154" valid="{required:true}"/>
		         	<input type="date" name="azsj" label="安置时间" class="class_form" data-date-formate="yyyy-MM-dd" valid="{required:true}"/>
		         	<input type="text" name="hdshjzfs" label="获得社会救助方式" code="SYS160" />
		         	<input type="text" name="hdjyfwfs" label="获得就业服务方式" code="SYS161" />  	
		         	<input type="text" name="sfxzblshbx" label="是否协助办理社会保险 " code="SYS001" />     	
		         	<input type="text" name="zzcysflsjmszc" label="自主创业是否落实减免税政策" code="SYS001" />     	
		         	<input type="text" name="csgtjysflsjmszc" label="从事个体经营是否落实减免税政策" code="SYS001" />     	
		         	<input type="text" name="qyhjjsflsjmszc" label="企业和经济是否落实减免税政策" code="SYS001" />     	
		         	<textarea name="remark" id="floor" type="text"  label="备注" maxlength="500"  rows="4"></textarea>
     	    	
		         </div>	     			
		  	</div>
		  <div class="modal-footer">
       		 <button type="button" id="btn_submit" class="btn btn-primary">保存</button>
       		 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button> 
		  </div>
	  </div>
	</div>	
</div>
</body>
</html>