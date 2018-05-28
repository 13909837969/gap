<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--王世凯  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjJyzfxxService.js"></script>
<title>教育走访信息管理</title>
<script type="text/javascript">
$(function() {
	var jyzf = new AzbjJyzfxxService();
	var form = new Eht.Form({selector : "#jyzfForm",autolayout : true});
	var tableview = new Eht.TableView({selector : "#tableview"});
	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
	var v = null;
	//展示页面信息
	tableview.loadData(function(page, res) {
		jyzf.findAll(qf.getData(), page, res);
	});
	//模态框新增人员信息事件
	function findRy(){
		jyzf.findJz(new Eht.Responder({
			success:function(data){
			console.log(data);
			$("#aid").empty();
			for(var i=0;i<data.length;i++){
				if(data[i].id == v){
					$("#aid").append("<option value=" + data[i].id + " selected>" + data[i].xm + data[i].grlxdh + "</option>");
				}else{
					$("#aid").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
			$("#aid").comboSelect();
			}
		}))
	}
	//模糊查询
	$("#btn_cha").click(function() {
		tableview.refresh();
	});
	//使保存与关闭按钮显示
	function showbtn(){
		$("#btn_close").show();
		$("#btn_submit").show();
	}
	//新增按钮触发事件
	$("#btn_add").click(function() {
			form.clear();
			v = null;
			findRy();
			form.enable();
			$("#myModal").modal({
			backdrop : 'static'
		})
		showbtn();
	});
	//点击查看时显示代码只读
	$("#btn_search").click(function(){
		if($("#tableview :checkbox:checked").length==1){
			form.clear();
			v = $("#tableview :checkbox:checked").data().jid;
			findRy();
			$("#myModal").modal({backdrop : 'static'});
			$("#btn_submit").hide();
			form.disable();
			form.fill($("#tableview :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
		});
		//修改按钮事件
		$("#btn_edit").click(function() {
			form.clear();
			if($("#tableview :checkbox:checked").length==1){
			v = $("#tableview :checkbox:checked").data().jid;
			findRy();
			showbtn();
			form.enable();
			$("#myModal").modal({backdrop : 'static'});
			form.fill($("#tableview :checkbox:checked").data());
			}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			}
		});
		//删除按钮事件
		$("#btn_delete").click(function(){
			showbtn();
			if($("#tableview :checkbox:checked").length == 1){
				var c = new Eht.Confirm();
				c.show("此操作不可恢复，确定要删除选中记录吗！");
				c.onOk(function(){
				jyzf.removeOne($("#tableview :checkbox:checked").data().id,new Eht.Responder({
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
		//模态框保存并且隐藏
		$('#btn_submit').click(function() {
			console.log(form.getData());
		if (form.validate()) {
				jyzf.saveOne(form.getData(), new Eht.Responder({
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
		<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
		<button type="button" id="btn_search" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
		<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
		<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
	</div>
	<form class="form-inline" style="margin: 10px;">
		<div id="query_form">
			<div class="form-group" style="margin-left: 10px">
				<label for="xm">姓名</label>
				<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="请输入姓名">
			</div>

			<div class="form-group" style="margin-left: 10px">
				<label for="zfrq">走访日期</label> 
				<input type="text" name="zfrq[eq]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd"  id="zfrq" data-date-formate="yyyy-MM-dd" placeholder="走访日期">
			</div>
			<button type="button" id="btn_cha" class="btn btn-primary" style="margin-left: 10px;">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
			</button>
		</div>
	</form>
	<div id="tableview" class="table-responsive">
		<div field="xzk" label="选择" checkbox="true"></div>
		<div field="xm" label="姓名"></div>
		<div field="zfrq" label="走访日期"></div>
		<div field="zfdd" label="走访地点"></div>
		<div field="thnr" label="谈话内容"></div>
		<div field="zfxg" label="走访效果"></div>
	</div>
	<!-- 新增帮教人员信息(Modal) -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">教育走访信息</h4>
				</div>
				<div class="modal-body" style="overflow: auto; height: 600px;">
					<div class="modal-body-div">
						<div id="jyzfForm">
							<input type="hidden" name="id"> 
							<select id="aid" name="aid" label="人员姓名" style="max-width: none" placeholder="姓名" ></select> 
							<input type="text" name="zfrq" class="form_date" data-date-formate="yyyy-MM-dd" label="走访日期" placeholder="走访日期" valid="{required:true}"> 
							<input type="text" name="zfdd" label="走访地点" placeholder="走访地点" />
							<input type="text" name="thnr" label="谈话内容" placeholder="谈话内容" />
							<input type="text" name="zfxg" label="走访效果" placeholder="走访效果" />
							<%-- <table border="1" cellspacing="0" id="table_view" align="center">
							<tr>
							<td>
							<label for="jyzffile" style="width:120px;height:120px;">
							<img id="jyzf_photo" 
								src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per" 
								osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per"
								style="width:110px;height:140px; "/>
							<span id="photo_remark" style="font-size: 1px;">照片格式:JPG 格式，分辨率 295*413，大小不超 100KB</span>
							<form id="jyzfuploadForm" action="${localCtx}/upload/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}" 
								method="post" enctype="multipart/form-data" 
								target="importFrame" style="margin:0px;padding:0px;">
									<!-- 文件上传成功或失败的回调方法 -->
								<input type="hidden" name="callback" fixedValue="true" value="callbackJyzfImg" id="jyzfhidden">
								<input type="file" name="fname" id="jyzffile" style="display:none;" onchange="Javascript:validate_img(this);">
							</form>
							<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
							</label>
							</tr>
							</tr>
						</table> --%>
						</div>
					</div>
					<div class="modal-footer">
						<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
						<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>