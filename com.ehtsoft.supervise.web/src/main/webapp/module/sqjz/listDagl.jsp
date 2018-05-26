<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>档案管理</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/DaglService.js"></script>
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
			var service = new DaglService();
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
				service.findJZAll(form.getData(),page,res);
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
				$("#sqjz_listDagl_all #iframe").attr("src","${localCtx}/module/sqjz/viewGrdagl.jsp?id=" + data.id);//向子页传输id
			});
			/* 单击新增按钮触发事件 */
			$("#sqjz_listDagl_all #btnAdd").click(function(data){
				$("#sqjz_listDagl_all #myModalAdd").modal({backdrop: 'static', keyboard: false});//弹出模态框
				$("#sqjz_listDagl_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formSqjzryjbxx.jsp?load=load");
			});
			
			/* 单击修改按钮，修改选中信息 */
	   		var array = {};
		   	$("#sqjz_listDagl_all #btnUp").click(function(){
		   		if(json.id==null){
		   			$("#sqjz_listDagl_all #hideDiv").show();
		   		}else{
				  	$("#sqjz_listDagl_all #modal-bodyAdd").load("${localCtx}/module/sqjz/formSqjzryjbxx.jsp?load=load&id="+json.id);
					$("#sqjz_listDagl_all #myModalAdd").modal({backdrop : 'static',keyboard : false}); 
		   		}
		  	});
		   	//点击虚拟身份按钮时间  完成
		   	$("#btnAddXnsf").click(function(){
		   		$("#sqjz_listDagl_all #myModalLabel").html("虚拟身份信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/sqjzryjbxx_formXnsfxxcj.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
		   	})
		   	//点击罪犯押送按钮事件  完成
		   	$("#btnAddZfys").click(function(){
		   		$("#sqjz_listDagl_all #myModalLabel").html("罪犯押送信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/sqjzryjbxx_formYsxx.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
			});
		   	//点击同案犯事件  完成
		   	$("#btnAddTaf").click(function(){
		   		$("#sqjz_listDagl_all #myModalLabel").html("同案犯信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/sqjzryjbxx_fromTaf.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
			});
		   	//点击管理级别按钮事件
		    $("#btnAddGljb").click(function(){
		    	$("#sqjz_listDagl_all #myModalLabel").html("管理级别信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/xxsb/listGljbxx.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
			}); 
		   	//点击进入特定区域按钮事件
		   /* 	$("#btnAddJrtdqy").click(function(){
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/formSqjzryjbxx.jsp?load=load&id="+json.id);
			}); */
		   	//点击矫正小组按钮事件    完成
		   	$("#btnAddJzxz").click(function(){
		   		$("#sqjz_listDagl_all #myModalLabel").html("矫正小组信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/sqjzryjbxx_formJzxz.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
			});
		   	//点击禁止令按钮事件  完成
		   	$("#btnAddJzl").click(function(){
		   		$("#sqjz_listDagl_all #myModalLabel").html("禁止令信息");
		   		$("#sqjz_listDagl_all #selectMyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		   		$("#sqjz_listDagl_all #select-modal-body").load("${localCtx}/module/sqjz/sqjzryjbxx_formJzlxx.jsp?load=load&id="+json.id,function(){
		   			$().initDatetimepicker();
		   		});
			});
		   /* 转派相关功能开始 */
		   	var tableViewGzfp = new Eht.TableView({selector:"#listDcpg_gzfpZsRight"});
		   	var zpjson = {};
		   	var Zpdata = {};
		   	
			
			/* 行点击事件 */
			tableViewGzfp.clickRow(function(data){
				/* 转派去司法所ID */
				Zpdata.sfsid = data.id;
			});
		   	//点击转派按钮事件
		  	$("#sqjz_listDagl_all #btnAddZp").click(function(){
		  		if(json.sfcj==1){
		  			Zpdata.sfjid = json.sfjid;
			  		Zpdata.aid = json.id;
			  		$('#myModal_gzfp').modal({backdrop:'static'});
			  		tableViewGzfp.loadData(function(page,res){
						service.findOrgid(zpjson,page,res);
			  		});
		  		}else{
		  			$("#sqjz_listDagl_all #hideDivCj").show();
		  			$("#sqjz_listDagl_all #yes").unbind("click").bind("click",function(){
				  		Zpdata.sfjid = json.sfjid;
				  		Zpdata.aid = json.id;
				  		$('#myModal_gzfp').modal({backdrop:'static'});
				  		tableViewGzfp.loadData(function(page,res){
							service.findOrgid(zpjson,page,res);
						});
				  		$("#sqjz_listDagl_all #hideDivCj").hide();
		  			})
		  		}
			}); 
		  	$("#sqjz_listDagl_all #quxiaobtnCj").click(function(){//单击取消按钮
				$("#sqjz_listDagl_all #hideDivCj").hide();
			});
			//转派查询按钮事件
			$("#listDcpg_gzfpLeft #btnQuery").click(function(){
				zpjson["jgmc[like]"] = $("#orgnameID").val();
				tableViewGzfp.refresh();
			})

		  //转派保存按钮事件
			$("#ZpSave").click(function(){
				
				//转派日期
				Zpdata.zprq= $("#listDcpg_gzfpLeft #zprq").val();
				//转派说明
				Zpdata.gzsm = $("#listDcpg_gzfpLeft #zpsm").val();
				service.saveZp(Zpdata,new Eht.Responder({
					success:function(){
						$('#myModal_gzfp').modal('hide');
						table.refresh();
					}
				}))
				
			});
			/* 转派相关功能结束 */
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
					<label> 是否转派：<select name="sfzp[eq]" style="width:70px;height:28px;text-align:center;" placeholder="请输入服刑人员编号"><option value=""></option><option value="0">否</option><option value="1">是</option></select></label>
					<input  id="btn" type="button" class="btn btn-default btn-sm" value="查询">
					<input  id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
					<input  id="btnUp" type="button" class="btn btn-default btn-sm" value="修改">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</fieldset>
				<div id="sqjzdagl_jbxxZj" style="position: absolute; right: 50px;top: 15px;font-size: 25px;">
					<input  id="btnAddXnsf" type="button" name="xnsf" class="btn btn-default btn-sm" value="虚拟身份" getdis="true" >
					<input  id="btnAddJzl" type="button" name="jzl" class="btn btn-default btn-sm" value="禁止令" getdis="true" >
					<input  id="btnAddZfys" type="button" name="zfys" class="btn btn-default btn-sm" value="罪犯押送" getdis="true" >
					<input  id="btnAddTaf" type="button" name="taf" class="btn btn-default btn-sm" value="同案犯" getdis="true" >
					<input  id="btnAddGljb" type="button" name="tg" class="btn btn-default btn-sm" value="管理级别" getdis="true" > 
					<!-- <input  id="btnAddJrtdqy" type="button" name="jrtdqy" class="btn btn-default btn-sm" value="进入特定区域" getdis="true" > -->
					<input  id="btnAddJzxz" type="button" name="jzxz" class="btn btn-default btn-sm" value="矫正小组" getdis="true" >
				    <input  id="btnAddZp" type="button" name="Zp" class="btn btn-default btn-sm" value="转派" getdis="true" > 
				</div>
				<%-- 	<a href="${localCtx}/module/sqjz/formSimple.jsp" target="_blank">基本信息录入</a> --%>
					
			</div>	
			<!-- 弹出警告框 -->
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="alert alert-info alert-dissmissible" id="hideDivCj" role="alert" style="text-align:center;font-size:17px;display:none;">
				<strong>提示</strong> 该人员未采集完成！确定转派？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
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
				<!-- <div field="bdqk" label="报道情况" code="SYS016"></div> -->
				<div field="jglx" label="矫管类别" code="SYS114"></div>
				<div field="sfcj" label="是否采集"></div>
				<div field="sfzp" label="是否转派" code="SYS001"></div>
				<div field="jgmc" label="转派机构"></div>
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
							<h4 class="modal-title" id="myModalLabel">个人档案详情</h4>
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
							<h4 class="modal-title" id="myModalLabel">个人档案管理</h4>
						</div>
						<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button id="dagl_list_btn_primary" type="button" class="btn btn-primary">提交</button>
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
									<!-- <span id="text-count" value="">0</span>/300 -->
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