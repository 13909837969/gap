<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人民调解工作室基本情况信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/RmtjTjgzsjbqkService.js"></script>
<script type="text/javascript">
$(function(){
	var gzsjbqk = new RmtjTjgzsjbqkService();
	var gzsjbqk_query = new Eht.Form({selector:"#gzsjbqkForm",autolayout:true});
	var form = new Eht.Form({selector:"#gzsjbqk_query_form ",codeEmpty:true,codeEmptyLabel:"全部"});
	var gzsjbqk_table = new Eht.TableView({selector:"#tableview",multable:true});
	v = null;
	
	//展示所有工作信息
 	gzsjbqk_table.loadData(function(page,res){
 		gzsjbqk.findAll(form.getData(), page, res);
 	});
	
	//查询按钮事件
 	$("#btn_gzsjbqk_query").click(function(){
 		gzsjbqk_table.refresh();
 	});
	//新增按钮事件
	$("#btn_add").click(function(){
		v = null;
		huixian();
		gzsjbqk_query.enable();
		gzsjbqk_query.clear();
		$("#btn_save").show();
 		$('#gzsjbqk_modal').modal({backdrop:'static'});
	});
	//查看按钮触发事件
	$("#btn_search").click(function(){
 		if($("#tableview :checkbox:checked").length==1){
 			v = $("#tableview :checkbox:checked").data().sstwhbm;
 			huixian();
 			$("#gzsjbqk_modal").modal({backdrop : 'static'});
 			$("#btn_save").hide();
 			gzsjbqk_query.disable();
 			gzsjbqk_query.fill($("#tableview :checkbox:checked").data());
 		}else{
 			var ale = new Eht.Alert();
 			ale.show("请选中一条数据进行操作!");
 		}
 	});
	//修改按钮事件
 	$("#btn_edit").click(function() {
		if($("#tableview :checkbox:checked").length==1){
			v = $('#tableview :checkbox:checked').data().sstwhbm;
			huixian();
			gzsjbqk_query.enable();
			$("#btn_save").show();
			$("#gzsjbqk_modal").modal({backdrop : 'static'});
			gzsjbqk_query.fill($("#tableview :checkbox:checked").data());
		}else{
 			var ale = new Eht.Alert();
 			ale.show("请选中一条数据进行操作!");
 		}
	});
 	//删除按钮事件
	$("#btn_delete").click(function() {
		if ($("#tableview :checkbox:checked").length == 1) {
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				gzsjbqk.removeOne($("#tableview :checkbox:checked").data().id,new Eht.Responder({
					success:function(){
						gzsjbqk_table.refresh();
						c.close();
						new Eht.Tips().show("删除成功");
					}
				}));
			});
		}else{
			var ale = new Eht.Alert();
		ale.show("请选中一条数据进行操作!");
	}
})
	//模态框保存并且隐藏
 	$('#btn_save').click(function(){
 		if(gzsjbqk_query.validate()){
 			gzsjbqk.saveOne(gzsjbqk_query.getData(),new Eht.Responder({
 				success:function(data){
 					$('#gzsjbqk_modal').modal('hide');
 					gzsjbqk_table.refresh();
 				}
 			}));
 		}else {
 			new Eht.Tips().show("保存失败");
 		} 
 	});
	//模态框查询所属委员会编码
	function huixian(){
		gzsjbqk.findWyhbm(new Eht.Responder({
 	     	success:function(data){
 	   			$("#sstwhbm").empty();
 	     		$("#sstwhbm").append('<option></option>');
 	     		for(var i=0;i<data.length;i++){
 	     			if(data[i].twhbm == v){
 	     				$("#sstwhbm").append("<option value="+data[i].twhbm+" selected>"+data[i].twhbm+"</option>");
 	     			}else{
 	     				$("#sstwhbm").append("<option value="+data[i].twhbm+">"+data[i].twhbm+"</option>");
 	     			}
 	     		}
 	     		$("#azbjryid").comboSelect();
 	     	}
 	  	}))
	}
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
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="submit" class="btn btn-default" style="margin-left:10px;">
		<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 条件查询部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="gzsjbqk_query_form">
		<div class="form-group">
			<label for="tjgzsmc">调解工作室名称</label>
			<input type="text" class="form-control" name="tjgzsmc[like]" id="tjgzsmc_query" placeholder="调解工作室名称">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="tjgzslx">调解工作室类型</label>
			<input type="text" class="form-control" name="tjgzslx[eq]" id="tjgzslx_query" placeholder="调解工作室类型" code="sys249">
		</div>
		<button id="btn_gzsjbqk_query" type="button" class="btn btn-primary" style="margin-left:10px;">
		<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!-- 页面表格展示 -->
<div id="tableview">
	<div field="xzk" label="选择" checkbox="true"></div>
	<div field="tjgzsmc" label="调解工作室名称"></div>
	<div field="hztjgzslx" label="行专调解工作室类型" code="SYS250"></div>
	<div field="zztjyrs" label="专职调解员人数"></div>
	<div field="jztjyrs" label="兼职调解员人数"></div>
	<div field="tjgzsslsj" label="调解工作室设立时间"></div>
	<div field="tjgzsdz" label="调解工作室地址"></div>
	<div field="tjgzsdh" label="调解工作室电话"></div>
</div>
<!-- 模态框 -->
<div class="modal fade" id="gzsjbqk_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document" style="width:800px">
		<div class="modal-content">
			<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        		<h4 class="modal-title" id="myModalLabel">人民调解工作室基本情况</h4>
      		</div>
      		<div class="modal-body" style="overflow: auto;height:400px;">
      			<div id="gzsjbqkForm">
<!--       				<input type="hidden" name="id"> -->
      				
      				<input id="tjgzsbm" type="text" name="tjgzsbm" label="调解工作室编码" placeholder="调解工作室编码" valid="{required:true}"/>
      				<!-- <input id="sstwhbm" type="text" name="sstwhbm" label="所属调委会编码" placeholder="所属调委会编码" valid="{required:true}"/> -->
      				<select id="sstwhbm" name="sstwhbm" label="所属调委会编码" style="max-width:none">
					</select>
      				<input id="tjgzsmc" type="text" name="tjgzsmc" label="调解工作室名称" placeholder="调解工作室名称" valid="{required:true}">
      				<!-- <input id="tjgzszp" type="text" name="tjgzszp" label="调解工作室照片" palceholder="调解工作室照片""> -->
      				<input id="tjgzslx" type="text" name="tjgzslx" label="调解工作室类型" placeholder="调解工作室类型" code="sys249" valid="{required:true}"/>
      				<input id="hztjgzslx" type="text" name="hztjgzslx" label="行专调解工作室类型" placeholder="行专调解工作室类型" code="sys250"/>
      				<input id="zztjyrs" type="text" name="zztjyrs" label="专职调解员人数" placeholder="专职调解员人数" valid="{required:true}"/>
      				<input id="jztjyrs" type="text" name="jztjyrs" label="兼职调解员人数" placeholder="兼职调解员人数" valid="{required:true}"/>
      				<input id="tjgzsslsj"  type="text" name="tjgzsslsj" label="调解工作室设立时间" placeholder="调解工作室设立时间" valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"/>
      				<input id="tjgzsdz" type="text" name="tjgzsdz" label="调解工作室地址" placeholder="调解工作室地址"/>
      				<input id="tjgzsdh" type="text" name="tjgzsdh" label="调解工作室电话" placeholder="调解工作室电话"/>
      				<!-- 图片上传 -->
      				<table border="1px" style="margin-left: 50px;">
      					<tr>
      						<td>
      						<label for="jbxxfile" style="width:120px;height:140px;">
											<img id="jzryjbxx_photo" 
												src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per" 
												osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per"
												 style="width:110px;height:140px; "/>
											<span id="photo_remark" style="font-size: 1px;">照片格式:JPG 格式，分辨率 295*413，大小不超 100KB</span>
											<form id="jzryjbxxuploadForm" action="${localCtx}/upload/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}" 
												method="post" enctype="multipart/form-data" 
												target="importFrame" style="margin:0px;padding:0px;">
													<!-- 文件上传成功或失败的回调方法 -->
												<input type="hidden" name="callback" fixedValue="true" value="callbackJzryjbxxImg" id="jzryjbxxhidden">
												<input type="file" name="fname" id="jbxxfile" style="display:none;" onchange="Javascript:validate_img(this);">
											</form>
											<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
										</label>
      						</td>
      					</tr>
      				</table>
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