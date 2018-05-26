<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>人员抽选</title>
<link rel="stylesheet" type="text/css" href="css/RmjdyXx.css"/>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx}/json/SqjzRyyzxxcjService.js"></script>
<script type="text/javascript">
$(function() {
	var form = new Eht.Form({
		selector : "#rmjdcx_listKttjaj",
		autolayout:true
	});
	var tableView = new Eht.TableView({
		selector : "#rmjdcx_listKttjaj #tableview",
		//一次选择多个数据
		multable : true
	});
	$("#rmjdcx_listKttjaj #rmtj_id_djan").click(function(data){
		$("#rmjdcx_listKttjaj #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		
	});
	
})
</script>

<script type="text/javascript">
		$(function(){
			var json={};
			var jsonArray = [];
			var query={};
			var service = new SqjzRyyzxxcjService();
			var form = new Eht.Form({
				selector:"#listRyYzxxcj #querypanel"
				});
			var form1 = new Eht.Form({
				selector:'#rmjdcx_listKttjaj #jzjzlxx-form',
				autolayout:true
				});
			var tableview = new Eht.TableView({
				selector:"#listRyYzxxcj_table",
				multable:true,
			});
			tableview.loadData(function(page, res) {
				service.findcj(query,page,res);
			});
			//查询
			$("#listRyYzxxcj #listJzsf_find").click(function(){
				query.f_status = $("#listRyYzxxcj #cjzt").val();
				query["xm[like]"]=$("#listRyYzxxcj #search-xm").val();
				query["orgname[like]"]=$("#listRyYzxxcj_xmAndLxdh").val();
				tableview.refresh();
				$('#list_ryyzxxcj_right-panel').animate({width : 0}, function() {
					$(this).hide()
				});
			});
			//获取个人信息数据
			function getDaxxData() {
				var rtn = new Array();
				$("#sqjz_listSxhb").find("tbody tr").each(function() {
					var obj = {};
					$(this).find("input").each(function() {
						var n = $(this).attr("name");
						obj[n] = $(this).val();
					});
					rtn.push(obj);
				});
				return rtn;
			}
			//转化值为大写
			function touppcase() {
				$("#sqjz_listSxhb input[name]").unbind("change").bind("change",function(){
					$(this).val($(this).val().toUpperCase());
				});
			};
		var timeObj = {};
		var senders = {};
		//刷新按钮
		$("#completeRefresh").click(function(){
			service.findOne(json.id,new Eht.Responder({
				success:function(data){
					$("#xm","#list_ryyzxxcj_right-panel").html('姓名:'+data.xm);
					var xbb = data.xb==1?'男':'女';
					$("#xb","#list_ryyzxxcj_right-panel").html('性别:'+xbb);
					$("#grlxdh","#list_ryyzxxcj_right-panel").html('联系电话:'+data.grlxdh);
					$("#grlxdh","#list_ryyzxxcj_right-panel").val(data.grlxdh);
					if(data.f_face == 1){
						$("#list_ryyzxxcj_right-panel #IMGID").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&face=1&imgid=" + data.id);
					}else{
						$("#list_ryyzxxcj_right-panel #IMGID").attr("src","mapimg/face.png")
					}
					var f_face = data.f_face==1?'采集完成':'未采集';
					var f_voice = data.f_voice==1?'采集完成':'未采集';
					var f_finger = data.f_finger==1?'采集完成':'未采集';
					
					$('#f_face','#form-panel').html(f_face);
					$('#f_voice','#form-panel').html(f_voice);
					$('#f_finger','#form-panel').html(f_finger);
				}
			}));
		})
		//点击tableView 行获取数据填充到右侧弹出框
		tableview.clickRow(function(data) {
			$("#resetting_alert_div").hide();
			 $("#listRyYzxxcj #f_face").css("color","black"); 
			 $("#listRyYzxxcj #f_voice").css("color","black"); 
			 $("#listRyYzxxcj #f_finger").css("color","black"); 
			json = data;
			jsonArray.push(data);
			service.findOne(json.id,new Eht.Responder({
				success:function(data){
					$("#xm","#list_ryyzxxcj_right-panel").html('姓名:'+data.xm);
					var xbb = data.xb==1?'男':'女';
					$("#xb","#list_ryyzxxcj_right-panel").html('性别:'+xbb);
					$("#grlxdh","#list_ryyzxxcj_right-panel").html('联系电话:'+data.grlxdh);
					$("#grlxdh","#list_ryyzxxcj_right-panel").val(data.grlxdh);
					if(data.f_face == 1){
						$("#list_ryyzxxcj_right-panel #IMGID").attr("src","${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=" + data.id);
					}else{
						$("#list_ryyzxxcj_right-panel #IMGID").attr("src","mapimg/face.png")
					}
					var f_face = data.f_face==1?'采集完成':'未采集';
					var f_voice = data.f_voice==1?'采集完成':'未采集';
					var f_finger = data.f_finger==1?'采集完成':'未采集';
					
					$('#f_face','#form-panel').html(f_face);
					$('#f_voice','#form-panel').html(f_voice);
					$('#f_finger','#form-panel').html(f_finger);
				}
			}))
			
			$('#list_ryyzxxcj_right-panel').show().animate({width : 500});
			$("#sendonebtn_td").empty();
			if(timeObj[data.id]==null){
				timeObj.id = data.id;
				timeObj[data.id] = function(){
					var id = this.id;
					var s = new Settimeouts();
					s.id = id;
					s.exec();
				}
			}
			var btn =  $('<input type="button" class="btn btn-success" value="发送">');
			btn.attr("id",data.id);
			if(senders[data.id]!=null){
				btn = senders[data.id];
			}else{
				senders[data.id]=btn;
			}
			$("#listRyYzxxcj #sendonebtn_td").append(btn);
			btn.unbind("click").bind("click",function(){
				service.sendPassword(json.id, $('#grlxdh','#list_ryyzxxcj_right-panel').val(),new Eht.Responder({
						success : function(data){
							timeObj[json.id].call(timeObj);
							new Eht.Alert({title:"提示信息"}).show('已经发送!');
						}
				})); 
			});
 			return false;
		});
		//单击添加档案数据弹出模态框	
		$('#rmjdcx_listKttjaj #RmjdyLb_button_ck').click(function(){
			$('#rmjdcx_listKttjaj #myModal').modal({backdrop:'static'});
			//默认添加初始界面在最上面输入姓名
		setTimeout(function(){
				$("#listRyYzxxcj #xm").focus();
			},200);
			$("#listRyYzxxcj #csrq").attr("disabled",true);
			form1.clear();
			//自动获取身份证号
			$("#listRyYzxxcj #sfzh").keyup(function(){
				var csrq = $("#listRyYzxxcj #sfzh").val().substring(6,14);
				var csrqFirst = csrq.substring(0,4);
				var csrqSecond = csrq.substring(4,6);
				var csrqLast = csrq.substring(6);
				var csrqAnd = csrqFirst+"-"+csrqSecond+"-"+csrqLast;
				$("#listRyYzxxcj #csrq").val(csrqAnd);
			}) 
			//判断是否成年
			$("#listRyYzxxcj #sfcn").change(function(){
				//成年
				if($("#listRyYzxxcj #sfcn").val()== 1){
					$("#listRyYzxxcj #wcn").disable();
					if($("#listRyYzxxcj #wcn").val()!==null){
						$("#listRyYzxxcj #wcn").empty();
					}
				}else{
					$("#listRyYzxxcj #wcn").enable();
				}
			})
			//个人联系电话pdSjh
			$("#listRyYzxxcj #grlxdhsjh").keyup(function(){
				if($("#listRyYzxxcj #grlxdhsjh").val().length == 11){
					service.sendpdSjh($("#listRyYzxxcj #grlxdhsjh").val(),new Eht.Responder({
						success:function(data){
							new Eht.Alert({title:"提示信息"}).show(data.yzc);
						}
					}));
				}
			})
			$('#list_ryyzxxcj_right-panel').animate({width : 0}, function() {
				$(this).hide()
			});
		});
			
		//提交档案数据
		$('#listRyYzxxcj #submit').click(function() {
			if (form1.validate()) {
				service.saveJzry(form1.getData(), new Eht.Responder({
					success : function(data) {
						$('#listRyYzxxcj #myModal').modal('hide');
						tableview.refresh();
					}
				}));
			};
		});

		//关闭右侧面板
		$("#list_ryyzxxcj_right-panel #siderightbar").click(function() {
			x=document.getElementById("f_face"); 
			 x.style.color="black"; 
			 y=document.getElementById("f_voice"); 
			 y.style.color="black"; 
			 z=document.getElementById("f_finger"); 
			 z.style.color="black"; 
			$('#list_ryyzxxcj_right-panel').animate({width : 0}, function() {
				$(this).hide()
			});
		});
		/*单击批量发送按钮*/
		$('#listPlFsXx_send').click(function() {
			$('#list_ryyzxxcj_right-panel').animate({width : 0}, function() {
				$(this).hide()
			});
			var tdcheck = tableview.getSelectedData();
			if(tdcheck==null||tdcheck.length==0){
				$('#close_alert_div').show();
			}else{
				$("#delete_alert_div").show();
				$("#listRyYzxxcj #yes").unbind("click").bind("click",function(){
					$("#delete_alert_div").hide();
					var arr = new Array();
					for (var i = 0; i < tdcheck.length; i++) {
						arr[i] = {
							'aid' : tdcheck[i].id,
							'tel' : tdcheck[i].grlxdh
						};
					}
					service.sendPassword(arr, new Eht.Responder({
						success : function(data) {
							new Eht.Alert({title:"提示信息"}).show('信息已经发送!')
							tableview.refresh();
							$('#list_ryyzxxcj_right-panel').hide();
						}
					}));
				});
				$("#listRyYzxxcj #no").unbind("click").bind("click",function(){
					$("#delete_alert_div").hide();
				});
			}
		});
		
		//完成
		$("#completeBtn").click(function() {
			var aid=json.id;
			if(json.f_face==1 && json.f_voice==1 && json.f_finger==1){
				
			}else{
				$("#cixxBt").html("有未完成的信息,确定完成？")
				$("#resetting_alert_div").show();
				if(json.f_face==0){
					x=document.getElementById("f_face"); 
					 x.style.color="Red"; 
				}
				if(json.f_voice==0){
					x=document.getElementById("f_voice"); 
					 x.style.color="Red"; 
				}
				if(json.f_finger==0){
					x=document.getElementById("f_finger"); 
					 x.style.color="Red"; 
				}
			}
			$("#listRyYzxxcj #yes").unbind("click").bind("click",function(){
				$("#resetting_alert_div").hide();
				service.updateArrivalUser(aid,new Eht.Responder({
					success:function(data){
						
						//
						/* setTimeout(function(){
							$('#list_ryyzxxcj_right-panel').animate({width:0},function(){
								tableview.refresh();
								$(this).hide()
							});
						},2000); */
					}
				}));
			})
			$("#listRyYzxxcj #no").unbind("click").bind("click",function(){
				$("#resetting_alert_div").hide();
			})
		});
		
		$("#close_alert").click(function() {
			$('#close_alert_div').hide();
		});
		function Settimeouts(){
			var sf = this;
			this.p = 10;
			this.t = setInterval(function(){
				 var el = $("#"+sf.id);
				 el.disable();
				 sf.p = sf.p - 1;
				 el.val("发送("+sf.p+"秒)");
				 if(sf.p<=0){
					 clearInterval(sf.t);
					 el.enable();
				 }
			},1000);
			this.exec=function(){
			}
		}
		//全选
		
		//提示框默认隐藏
		$("#listRyYzxxcj #delete_alert_div").hide();
		$("#listRyYzxxcj #resetting_alert_div").hide();
		//动态添加司法所
	    service.findJg(new Eht.Responder({
			success:function(data){
				$("#listRyYzxxcj_xmAndLxdh").empty();
				$("#listRyYzxxcj_xmAndLxdh").append('<option ></option>');
				for(var i=0;i<data.length;i++){
					$("#listRyYzxxcj_xmAndLxdh").append("<option value="+data[i].jgmc+">"+data[i].jgmc +"</option>");
				}
			}
		}));  
		//添加人员信息模态框关闭按钮
		$("#modelGb").click(function(){
			$('#listRyYzxxcj #myModal').modal('hide');
			tableview.refresh();
		})
});
</script>
<style>
*{
	margin:0px;
	padding:0px;
	font-size:16px;
}
.row{
	margin-left:0px;
	margin-right:0px;
}
#Rmtjjdy_icon{
	margin-bottom:10px;
}
#Rmtjjdy_icon span:nth-child(1){
	width:50px;
	height:40px;
}
.Rmtjjdy_button{
	text-align:center;
}
.Rmtjjdy_button div{
	text-align:center;
}
.Rmtjjdy_icon_span{
	display:block;
	font-weight:bold;
	width:100%;
	font-size:18px;
	height:40px;
	line-height:40px;
	border-bottom:1px solid #ccc;
	padding-left:30px;
}
#querypanel{
	width:100%;
	height:200px;
	border-radius:4px;
	border:1px solid #ccc;
}
.Rmtjjdy_button_style button{
	width:50px;
	height:30px;
	border:1px solid #ccc;
	border-radius:4px;
	background:transparent;
	margin-right:10px;
}
.RmjdyLb_button button{
	width:100px;
	height:30px;
	border:1px solid #ccc;
	border-radius:4px;
	background:transparent;
	margin-right:10px;
}

.right-panel {
	background: #fff;
	position: absolute;
	top: 56px;
	right: 5px;
	bottom:5%;
	filter: alpha(Opacity = 97);
	/* -moz-opacity: 0.97;
	opacity: 0.97; */
	display: none;
	box-shadow: 0px 0px 5px #999;
}

#siderightbar {
	cursor: pointer;
}

#siderightbar:hover {
	color: #00f;
}

.control-group>label {
	margin-right: 10px;
}

.control-group div {
	width: 100%;
	height: 400px;
}

.row-fluid #right-panel_div3 {
	margin: 0 0 0 150px;
}

#right-panel_div2 #f_pf {
	display: block;
	float: right;
	font-size: 30px;
	margin: 0 10px 30px 0;
}
.input-group-addon{
	border-right:1px solid;
}

.btn-success_tj {
	margin-left: 400px;
}
.panel-heading{
	
}
.panel-heading span:nth-child(2){
	font-size:18px;
	position:absolute;
	left:45%;
}
.asfsdgdfg{
	width:100%;
	margin-bottom:10px;
	border-bottom:1px solid #ccc;
}
.combo-select{
	width: 200px;
    background-color: #fff;
    position: absolute;
    left: 690px;
    top: 5px;
}
.modal-content{
	height:500px;
}
#jzjzlxx-form table tr{
	height:50px;
}
#jzjzlxx-form table tr td{
	text-align:right;
	height:50px;
}
.pre-scrollable{
	max-height:85%;
}
.col-sm-2 .col-xs-2{
	padding-left:0px;
	padding-right:0px;
}
.panel-default{
	border:0px;
}
.RmjdyLb_text{
	font-size:18px;
	display:block;
	font-weight:bold;
	width:100%;
	height:40px;
	line-height:40px;
	padding-left:30px;
	border-bottom:1px solid #ccc;
}
.table-responsive{
	margin-top:20px;
	overflow:inherit;
}
.modal-footer{
	border-top:0px;
}
#RMjdy_divbuttonGB{
	border-radius:4px;
	border:1px solid #ccc;
	width:50px;
	height:30px;
	background:transparent;
	text-align:center;
	float:right;
	margin-right:72px;
}
#RMjdy_divbuttonDY{
	border-radius:4px;
	border:1px solid #ccc;
	width:50px;
	height:30px;
	background:transparent;
	text-align:center;
	float:right;
	margin-right:30px;
}
.table_context .con_right{
	background:transparent;
}
</style>

</head>
<body>
	<div id="rmjdcx_listKttjaj">
		<div class="panel panel-default">
			<div>
				<fieldset  class="panel-body">
					<div id="querypanel">
						<div class="row" id="Rmtjjdy_icon"><span class="im-search3"></span><span class="Rmtjjdy_icon_span">监督员申请查询</span></div>
						<div class="row" style="margin-bottom:10px;">
							<div class="col-md-12 col-sm-12" style="margin-bottom:20px;">
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">案件名称:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-3 col-sm-3" style="padding-left:0px;padding-right:0px;"><span style="font-weight:bold;">工作区域:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">申请状态:</span>
									<input style="height:30px;border-radius:4px;border:1px solid #ccc;"/>
								</div>
								<div class="col-md-3 col-sm-3" style="padding-left:0px;padding-right:0px;"><span style="font-weight:bold;">履职开始时间:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
							</div>
						</div>
						<div class="col-md-12 Rmtjjdy_button">
							<div class="Rmtjjdy_button_style col-md-1 col-md-offset-5">
								<button>查询</button>
							</div>
							<div class="Rmtjjdy_button_style col-md-1">
								<button>重置</button>
							</div>
						</div>
					</div>
				</fieldset>
			</div>
		</div>
			<div class="col-md-12">
				<div class="col-md-12"  style="border:1px solid #ccc;border-radius:4px;">
					<div class="RmjdyLb_text " style="margin-bottom:10px;">监督员申请列表</div>
					<div class="RmjdyLb_button " style="margin-bottom:20px;">
						<button id="RmjdyLb_button_ck">查看</button>
						<button>人员确认</button>
						<button>导出</button>
					</div>
					<div class="panel-body" style="padding:0px;">
						<div id="tableview" class="table-responsive">
							<div field="XH" label=""></div>
							<div field='op' label="<input type='checkbox'>" checkbox="true" id=""></div>
							<div field="sqzt" label="申请状态"></div>
							<div field="ajmc" label="案件名称"></div>
							<div field="jdysl" label="监督员数量"></div>
							<div field="kssj" label="履职开始时间"></div>
							<div field="jssj" label="履职结束时间"></div>
							<div field="lzts" label="履职天数"></div>
							<div field="sqjg" label="申请机构"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- 查看弹出框 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
				<div class="modal-dialog" style="width:1300px;">
					<div class="modal-content"  style="height:80%;">
						<div class="modal-header">
							<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</Button>
							<h4 class="modal-title" id="myModalLabel">案件信息查看</h4>
						</div>
						<div class="modal-body pre-scrollable ">
							<div id="jzjzlxx-form">
								
								
								<div class="table_context" style="height:200px;padding-top:5px;padding-bottom:20px;">
									<!-- hidden域 --> 
									<input type="hidden" class="mini-hidden" id="caseid">
									<table style="width:100%;height:100%;" class="nui-form-table">
										<tbody><tr>
											<th colspan="10" style="text-align: center;background-color: #FFF;">监督员抽选</th>
										</tr>
										<tr>
											<th class="con_right" width="15%">案件名称:</th>
											<td width="35%">
												<span id="casename"></span>
											</td>
											<th class="con_right" width="15%">监督员数量:</th>
											<td width="35%">
												<span id="jdyNum"></span>
											</td>
										</tr>
										<tr>
											<th class="con_right" width="15%">立案时间:</th>
											<td width="35%">
												<span id="registertime"></span>
											</td>
											<th class="con_right" width="15%">案件来源:</th>
											<td width="35%">
												<span id="ajlymsname"></span>
												<span id="ajlyqxname"></span>
											</td>
										</tr>
										<tr>
											<th class="con_right" width="15%">履职开始时间:</th>
											<td width="35%">
												<span id="jddate"></span>
											</td>
											<th class="con_right" width="15%">履职结束时间:</th>
											<td width="35%">
												<span id="jdjsdate"></span>
											</td>
										</tr>
										<tr>
											<th class="con_right" width="15%">监督类型:</th>
											<td width="35%">
												<span id="jdtypeName"></span>
											</td>
											<th class="con_right" width="15%">履职天数:</th>
											<td width="35%">
												<span id="daysum"></span>
											</td>
										</tr>
										<tr>
											<th colspan="1" class="con_right" width="15%">备注:</th>
											<td colspan="9" width="35%">
												<span id="bzxx"></span>
											</td>
										</tr>
									</tbody></table>
								</div>
								
								<!--  -->
								
								<div class="mini-grid-rows-view" style="margin-left:0px; width:100%;margin-top:120px;">
									<div class="mini-grid-rows-content" style="border:1px solid #ccc;">
										<table class="mini-grid-table mini-grid-rowstable" cellspacing="0" cellpadding="0" border="0" style="width: 100%;border-bottom:1px solid #ccc;">
											<tr style="height:0px;border-bottom:1px solid #ccc;">
												<td style="height:0px;width:0;"></td>
												<td id="1" style="padding:0;border:0;margin:0;height:0px;width:30px"></td>
												<td id="2" style="padding:0;border:0;margin:0;height:0px;width:100px"></td>
												<td id="3" style="padding:0;border:0;margin:0;height:0px;width:100px"></td>
												<td id="4" style="padding:0;border:0;margin:0;height:0px;width:100px"></td>
												<td id="5" style="padding:0;border:0;margin:0;height:0px;width:100px"></td>
												<td style="width:0px;"></td>
											</tr>
											<tr id="mini-4$emptytext2" style="display:none;border-bottom:1px solid #ccc;">
												<td style="width:0"></td><td class="mini-grid-emptyText" colspan="5">No data returned.</td>
											</tr>
											<tr class="mini-grid-row mini-grid-row-selected" style="border-bottom:1px solid #ccc; " id="mini-4$row2$1">
												<td style="width:0;"></td>
												<td id="1$cell$1" class="mini-grid-cell " style="text-align:center;">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">
														<div id="mini-4$number$1">1</div>
													</div>
												</td>
												<td id="1$cell$2" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">张  敏</div>
												</td>
												<td id="1$cell$3" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">新体路街道办事处副主任</div>
												</td>
												<td id="1$cell$4" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">13214745818</div>
													</td>
												<td id="1$cell$5" class="mini-grid-cell  mini-grid-rightCell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">3</div>
												</td>
											</tr>
											<tr class="mini-grid-row" style="border-bottom:1px solid #ccc; " id="mini-4$row2$2">
												<td style="width:0;"></td>
												<td id="2$cell$1" class="mini-grid-cell " style="text-align:center;">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">
														<div id="mini-4$number$2">2</div>
													</div>
												</td>
												<td id="2$cell$2" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">王瑞萍</div>
												</td>
												<td id="2$cell$3" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">中教高级</div>
												</td>
												<td id="2$cell$4" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">13948497773</div>
												</td>
												<td id="2$cell$5" class="mini-grid-cell  mini-grid-rightCell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">4</div>
												</td>
											</tr>
											<tr class="mini-grid-row" style="border-bottom:1px solid #ccc; " id="mini-4$row2$3">
												<td style="width:0;"></td>
												<td id="3$cell$1" class="mini-grid-cell " style="text-align:center;">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">
														<div id="mini-4$number$3">3</div>
													</div>
												</td>
												<td id="3$cell$2" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">马丽波</div>
												</td>
												<td id="3$cell$3" class="mini-grid-cell " style="" title="市产品质量计量检验所 /副高级工程师副主任">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">市产品质量计量检验所 /副高级工程师副主任</div>
												</td>
												<td id="3$cell$4" class="mini-grid-cell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">13904749666</div>
												</td>
												<td id="3$cell$5" class="mini-grid-cell  mini-grid-rightCell " style="" title="">
													<div class="mini-grid-cell-inner  mini-grid-cell-nowrap " style="">5</div>
												</td>
											</tr>
										</table>
									</div>
								</div>
								<!--  -->
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>