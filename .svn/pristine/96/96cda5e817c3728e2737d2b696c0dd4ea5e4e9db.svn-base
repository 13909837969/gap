<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>刑罚执行</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>
			.dagl_extend_func{
				padding:0px 2px;
			}
			.dagl_extend_func .panel-body{
				padding-top:8px;
				padding-bottom:0px;
			}
			.dagl_extend_func .panel-heading{
				padding:2px 2px;
			}
			.dagl_extend_func>.panel{
			    bottom: 3px;
			    position: absolute;
			    top: 3px;
			    left: 3px;
			    right: 3px;
			    overflow: auto;
			}
			.dagl_extend_func .form-group{  margin-bottom: 0px;}
	</style>	
	<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
	<script type="text/javascript">
		$(function(){
			var service = new XfzxService();
			var table = new Eht.TableView({
				selector:"#dagl_listtable"
			});
			var json = {};
			var form = new Eht.Form({selector:"#sqjzdagl-field"});
			var formAdd = new Eht.Form({selector:"#sqjzdagl_jbxxZj"});
			changeInput(true);
			$("#sqjz_listDagl_all #tsk").hide();
			
			//选择input事件的状态  disable
			function changeInput(ifBoolean){
				if(ifBoolean){
					formAdd.disable();
				}else{
					formAdd.enable();
				}
			};
			//
			table.transColumn("sfcj",function(data){
				if(data.sfcj == 0){
					return "否";
				}
				if(data.sfcj == 1){
					return "是";
				}
			})  
			/* 初始化加载数据 */
			table.loadData(function(page,res){
				service.findXfAll(form.getData(),page,res);
			});
			/* ******************当单击某条数据时，将数据放入json内，以备点击【修改】按钮时调取数据*************************** */
			table.clickRow(function(data){
				json=data;
				changeInput(false);
			});
			//隐藏的警告框触发事件
			$("#sqjz_listDagl_all #quxiaobtn").click(function(){//单击取消按钮
				$("#sqjz_listDagl_all #hideDiv").hide();
			});
			/* 单击查询按钮触发事件 */
			$("#sqjz_listDagl_all #btn").click(function(){
				table.refresh();//再执行上次方法
			});
			/* **双击某条数据，弹出人员详情页********* */
			table.dblclickRow(function(data){
				$("#sqjz_listDagl_all #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
				$("#sqjz_listDagl_all #iframe").attr("src","${localCtx}/module/sqjz/formXfzx.jsp?id=" + data.id);//向子页传输id
			}); 
			/* 单击新增按钮触发事件 */
			$("#sqjz_listDagl_all #btnAdd").click(function(data){
				$("#sqjz_listDagl_all #myModalAdd").modal({backdrop: 'static', keyboard: false});//弹出模态框
				$("#sqjz_listDagl_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formSqjzryxfzx.jsp?load=load&id="+json.id);
			});
			
			/* 单击修改按钮，修改选中信息 */
	   		var array = {};
		   	$("#sqjz_listDagl_all #btnUp").click(function(){
		   		if(json.id==null){
		   			$("#sqjz_listDagl_all #hideDiv").show();
		   		}else{
				  	$("#sqjz_listDagl_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formSqjzryxfzx.jsp?load=load&id="+json.id);
					$("#sqjz_listDagl_all #myModalAdd").modal({backdrop : 'static',keyboard : false}); 
		   		}
		  	});
		   	
			
			
		   
		  	$("#sqjz_listDagl_all #quxiaobtnCj").click(function(){//单击取消按钮
				$("#sqjz_listDagl_all #hideDivCj").hide();
			});
		});
	</script>
</head>
<body>
	<div id="sqjz_listDagl_all" class="panel panel-default">
			<div id="head" class="panel-heading" style="padding-left:20px;">
				<fieldset id="sqjzdagl-field" style="margin-top:10px;">
					<!-- <legend>档案管理</legend> -->
					<label> 姓名：<input type="text" name="xm[like]" style="width:170px;height:28px;text-align:center;" placeholder="请输入姓名"/></label>
					<label> 身份证号：<input type="text" name="sfzh[like]" style="width:170px;height:28px;text-align:center;" placeholder="请输入服刑人员编号"/></label>
					
					<input  id="btn" type="button" class="btn btn-default btn-sm" value="查询">
					<input  id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
 					<input  id="btnUp" type="button" class="btn btn-default btn-sm" value="修改">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</fieldset>
				
				<%-- 	<a href="${localCtx}/module/sqjz/formSimple.jsp" target="_blank">基本信息录入</a> --%>
					
			</div>	
			<!-- 弹出警告框 -->
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDivCj" style="text-align:center;font-size:17px;display:none;">
				    <strong>警告!</strong> 该人员未采集完成！
				    <input id="quxiaobtnCj" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div id="dagl_listtable" class="panel-body" >
				<div field="op" checkbox=true label="选择"></div>
				<div field="sqjzrybh" label="社区服刑人员编号"></div>
				<div field="xm" label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="mz" label="民族" code="SYS003"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="grlxdh" label="个人联系电话"></div>
				<div field="bdqk" label="报道情况" code="SYS016"></div>
				<div field="jglx" label="矫管类别" code="SYS114"></div>
				<div field="sfcj" label="是否采集"></div>
			</div>	
			
			<!-- 查看模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-lg" style="height:680px;">
					<div class="modal-content" style="height:100%">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="myModalLabel">刑罚执行信息详情</h4>
						</div>
						<div class="modal-body" id="modal-body">
							<iframe id="iframe" width="100%" height="600px" scrolling="no" frameborder="0">
								
							</iframe>
						</div>
					</div>
				</div>
			</div>
			<!-- 000000000000000000000000000000000000000000000000000000 -->
			<!-- 新增/修改模态框（Modal） -->
			<div class="modal fade" id="myModalAdd">
				<div class="modal-dialog modal-lg" >
					<div class="modal-content" >
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" 
									aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="myModalLabel">刑罚执行个人信息</h4>
						</div>
						<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button id="Xfzx_btn" type="button" class="btn btn-primary">提交</button>
						</div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div>
		</div>
</body>
</html>