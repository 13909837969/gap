<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>登记接收</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/DjjsService.js"></script>
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
			var service = new DjjsService();
			var table = new Eht.TableView({
				selector:"#dagl_listtable"
			});
			var json = {};
			var form = new Eht.Form({selector:"#sqjzdagl-field"});
			var formAdd = new Eht.Form({selector:"#sqjzdagl_jbxxZj"});
			changeInput(true);
			$("#sqjz_listDjjs_all #tsk").hide();
			
			//选择input事件的状态  disable
			function changeInput(ifBoolean){
				if(ifBoolean){
					formAdd.disable();
				}else{
					formAdd.enable();
				}
			};
			//旗县处理状态
			table.transColumn("sfzp",function(data){
				if(data.sfzp == "0"){
					return "待转派";
				}else{
					return "已转派";
				}
			})  
			//司法所处理状态
			table.transColumn("sfjs",function(data){
				if(data.sfjs == "0"){
					return "待接收";
				}else{
					return "已接收";
				}
			})  
			//报道情况
			table.transColumn("bdqk",function(data){
				if(data.bdqk != "01" && data.bdqk != "02" && data.bdqk != "03" ){
					return "待报到";
				}else if(data.bdqk == "03"){
					var span=$('<span style="color:red;">'+"未报到且下落不明"+'</span>')
					
					return span;
				}else if(data.bdqk == "02"){
					var span=$('<span style="color:blue;">'+"超出规定时限报到"+'</span>')
					
					return span;
				}
			})
			table.clickRow(function(data){
				json=data;
				changeInput(false);
			});
			//操作
			table.transColumn("cz",function(data){
				if(data.sfzp == "0"){
					var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-share"></span>&nbsp;转派</button>')
						button.click(function(){
							
								json=data;
								$("#sqjz_listDjjs_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formDjjs.jsp?load=load&id="+json.id);
								$("#sqjz_listDjjs_all #myModalAdd").modal({backdrop : 'static',keyboard : false}); 
						})
					return button;
				}else if(data.sfzp == "1" && data.sfjs!= "1"){
					var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-share-alt"></span>&nbsp;撤回</button>')
						button.click(function(){
							
								json=data;
							
							$("#sqjz_listDjjs_all #hideDivCj").show();
							
						})
					return button;
				}else if(data.sfzp == "1" && data.sfjs == "1"){
					var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>')
					button.click(function(){
						
							json=data;
						
							$("#sqjz_listDjjs_all #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
							$("#sqjz_listDjjs_all #iframe").attr("src","${localCtx}/module/sqjz/viewGrdagl.jsp?id=" + json.id);//向子页传输id
					})
					return button;
				}
			})
			
			/* 初始化加载数据 */
			table.loadData(function(page,res){
				service.findOwn(form.getData(),page,res);
			});
			
			//隐藏的警告框触发事件
			$("#sqjz_listDjjs_all #quxiaobtn").click(function(){//单击取消按钮
				$("#sqjz_listDjjs_all #hideDiv").hide();
			});
			/* 单击查询按钮触发事件 */
			$("#sqjz_listDjjs_all #search").click(function(){
				table.refresh();//再执行上次方法
			});
			
			/* 单击新增按钮触发事件 */
			$("#sqjz_listDjjs_all #djjs").click(function(data){
				$("#formSimple-body #photo_remark").show();
				$("#sqjz_listDjjs_all #myModalAdd").modal({backdrop: 'static', keyboard: false});//弹出模态框
				$("#sqjz_listDjjs_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formDjjs.jsp?load=load");
			});
		
			
			/* 单击修改按钮，修改选中信息 */
	   		
		   	$("#sqjz_listDjjs_all #btnUp").click(function(){
		   		if(json.id==null){
		   			$("#sqjz_listDjjs_all #hideDiv").show();
		   		}else{
				  	$("#sqjz_listDjjs_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formDjjs.jsp?load=load&id="+json.id);
					$("#sqjz_listDjjs_all #myModalAdd").modal({backdrop : 'static',keyboard : false}); 
		   		}
		  	});
			
			$("#yes").click(function(){
				
				service.removeZp(json.id,new Eht.Responder({
					success : function() {
						$("#sqjz_listDjjs_all #hideDivCj").hide();
						table.refresh();
						new Eht.Tips().show();
					}
				}))
			})
			
		  	$("#sqjz_listDjjs_all #quxiaobtnCj").click(function(){//单击取消按钮
				$("#sqjz_listDjjs_all #hideDivCj").hide();
			});
			

		  
		  $(".gb").click(function(){
			  $(".modal-backdrop").remove();
			  
		  })
		
			
			//日期
			$("#sqjzdjjs-field .form_date").datetimepicker({
			       format: "yyyy-mm",
			       autoclose: true,
			       todayBtn: true,
			       todayHighlight: true,
			       showMeridian: true,
			       pickerPosition: "bottom-left",
			       language: 'zh-CN',//中文，需要引用zh-CN.js包
			        startView: 2,//月视图
			        minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
			});
		  
		  
		  
		});
	</script>
</head>
<body>
	<div id="sqjz_listDjjs_all" class="panel panel-default">
			<div id="sqjzDjjs_head" class="panel-heading">
				<fieldset id="sqjzdagl-field" style="margin-top:10px;">
					<label>社区服刑人员:<input name="xm[like]" type="text" style="width:100px;text-align: center;" ></label>&nbsp;&nbsp;
					<label>旗县级处理状态:<select name="sfzp[eq]" type="text" style="width:100px; height:26px;text-align: center;" >
											<option selected="selected"></option>
											<option value="0">待转派</option>
											<option value="1">已转派</option>
										</select>
					</label>&nbsp;&nbsp;
					
					<button class="btn btn-default btn-sm" id="search">查询</button>&nbsp;&nbsp;
					<button class="btn btn-default btn-sm" id="djjs">新增</button>
					<input  id="btnUp" type="button" class="btn btn-default btn-sm" value="修改">
				</fieldset>
				
			</div>
			<!-- 弹出警告框 -->
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="alert alert-info alert-dissmissible" id="hideDivCj" role="alert" style="text-align:center;font-size:17px;display:none;">
				<strong>提示</strong> 材料即将撤回，确认操作吗？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="quxiaobtnCj" class="btn btn-default" type="button" value="取消" >
			</div>
			<div id="dagl_listtable" class="panel-body" >
				<div field="op" checkbox=true label="选择"></div>
				<div field="xm" label="姓名"></div>
				<div field="xb" label="性别" code="sys000"></div>
				<div field="sfzh" label="身份证号" ></div>
				<div field="sfzp" label="旗县级处理状态" code="sys001"></div>
				<div field="jgmc" label="接收司法所"></div>
				<div field="sfjs" label="司法所处理状态" code="sys001"></div>
				<div field="bdqk" label="报道情况" code="SYS016"></div>
				<div field="cz" label="操作"></div>
				
			</div>	
			<!-- 页面按钮查看模态框（Modal） -->
			<div class="modal fade" id="selectMyModal">
				<div class="modal-dialog modal-lg" >
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="myModalLabel">个人档案信息</h4>
						</div>
						<div class="modal-body dagl_extend_func" id="select-modal-body" style="height:500px;overflow:auto;">
						</div>
					</div>
				</div>
			</div>
			
			<!-- 查看模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog modal-lg" style="height:680px;">
					<div class="modal-content" style="height:100%">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="grda">个人档案详情</h4>
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
							<button type="button" class="close gb" data-dismiss="modal" 
									aria-hidden="false">×
							</button>
							<h4 class="modal-title" id="myModalAdd">新增个人档案</h4>
						</div>
						<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
						</div>
						<div class="modal-footer">
							<button id="dagl_list_btn_primary" type="button" class="btn btn-primary">提交</button>
							<button id="dagl_list_btn_close" type="button" class="btn btn-default gb"  data-dismiss="modal" >关闭</button>
							
						</div>
					</div><!-- /.modal-content -->
				</div><!-- /.modal-dialog -->
			</div>
			<!-- 转派(Modal) -->
		<div class="modal fade" id="myModal_gzfp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" >
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false">
							&times;
						</button>
						<h4 class="modal-title">转派</h4>
					</div>
					
					<div class="modal-body" style="overflow: hidden;">
						
						<!-- 收索框 -->
								
								
							<div id="listDcpg_gzfpLeft">
								<div class="col-md-4" style="margin-top: 16px;">
									<label style="margin-left:5px">转派日期:</label>
									<input type="text" id="zprq" name="zprq"  placeholder="请输入分配日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly/><br>
									<span style="font-size:20px;">工作说明</span><br>
									<textarea rows="15"  name="f_hbnr" id="zpsm" style="width:260px;" maxlength="300"
												onkeyup="this.value=this.value.substring(0, 300)" placeholder="最多可输入300字"></textarea>
									<span id="text-count" value="">0</span>/300
								</div>
							
								<div id="listDcpg_gzfpRight" class="col-md-8" style="overflow: auto;">
									<div class="panel-heading">
										<fieldset id="listDcpg_Jgselect">
											司法所名称：<label><input type="text" id="orgnameID" name="orgname[like]" placeholder="请输入司法所名称" /></label>
											<input  id="btnQuery" type="button" class="btn btn-default btn-sm" value="查询">
										</fieldset>
									</div>
									<div id="listDcpg_gzfpZsRight"  style="overflow: auto;height: 400px;">
										<div field='op' label="选择" checkbox="true"></div>
										<div id="sfsid" field="jgmc" label="司法所名称"></div>
										<div field="region_name" label="所在旗县" ></div>
										<div field="fzr" label="负责人"></div>
										<div field="lxdh" label="联系电话"></div>
									</div>
								</div>
						</div>
					</div>
					<div class="modal-footer">
						<button id="ZpSave" type="button" class="btn btn-default">保存</button>
					</div>
				</div>
			</div>
		</div>
						
		</div>
</body>
</html>
