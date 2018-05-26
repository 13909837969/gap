<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>参加活动记录</title>
<link rel="stylesheet" type="text/css" href="css/RmjdyXx.css"/>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx}/json/SqjzRyyzxxcjService.js"></script>
<script type="text/javascript">
$(function() {
	var form = new Eht.Form({
		selector : "#rmjdjl_listKttjaj",
		autolayout:true
	});
	var tableView = new Eht.TableView({
		selector : "#rmjdjl_listKttjaj #tableview",
		//一次选择多个数据
		multable : true
	});
	$("#rmjdjl_listKttjaj #rmtj_id_djan").click(function(data){
		$("#rmjdjl_listKttjaj #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		
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
				selector:'#rmjdjl_listKttjaj #jzjzlxx-form',
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
		$('#rmjdjl_listKttjaj #RmjdyLb_button_ck').click(function(){
			$('#rmjdjl_listKttjaj #myModal').modal({backdrop:'static'});
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
.Rmtjjdy_button_style button{
	width:50px;
	height:30px;
	border:1px solid #ccc;
	border-radius:4px;
	background:transparent;
	margin-right:10px;
}
.RmjdyLb_button button{
	width:50px;
	height:30px;
	border:1px solid #ccc;
	border-radius:4px;
	background:transparent;
	margin-right:10px;
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
.table-responsive div{
}
</style>

</head>
<body>
	<div id="rmjdjl_listKttjaj">
		<div class="panel panel-default">
			<div>
				<fieldset  class="panel-body">
					<div id="querypanel">
						<div class="row" id="Rmtjjdy_icon"><span class="im-search3"></span><span class="Rmtjjdy_icon_span">参加活动记录查询</span></div>
						<div class="col-md-12" style="margin-bottom:10px;">
							<div class="col-md-12" style="margin-bottom:20px;">
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">监督员姓名:	</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-2 col-sm-2"><span style="font-weight:bold;">工作区域:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-2 col-sm-2"><span style="font-weight:bold;">培训名称:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-5 col-sm-5">
									<span style="font-weight:bold;">培训开始时间:从</span>
									<input style="height:30px;border-radius:4px;border:1px solid #ccc;"/>
									<span style="font-weight:bold;">到:</span>
									<input style="height:30px;border-radius:4px;border:1px solid #ccc;"/>
								</div>
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
					<div class="RmjdyLb_text " style="margin-bottom:10px;">参加活动记录列表</div>
					<div class="RmjdyLb_button " style="margin-bottom:20px;">
						<button id="RmjdyLb_button_ck">查看</button>
						<button>导出</button>
					</div>
					<div class="panel-body" style="padding:0px;">
						<div id="tableview" class="table-responsive" style="">
							<div field="XH" label="序号"></div>
							<div field='op' label="<input type='checkbox'>" checkbox="true" id=""></div>
							<div field="jdyxm" label="监督员姓名"></div>
							<div field="kqqk" label="考勤情况"></div>
							<div field="pxnr" label="培训内容"></div>
							<div field="pxkssj" label="培训开始时间"></div>
							<div field="pxjssj" label="培训结束时间"></div>
							<div field="pxts" label="培训天数"></div>
							<div field="pxdd" label="培训地点"></div>
							<div field="bxqk" label="表现情况"></div>
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
							<h4 class="modal-title" id="myModalLabel">基本信息</h4>
						</div>
						<div class="modal-body pre-scrollable ">
							<div id="jzjzlxx-form">
								<!-- <table style="width: 100%; height: 100%; table-layout: fixed;" class="nui-form-table" cellpadding="0" border="0">
									<tbody>
									<tr>
										<td class="form_label">推荐/自荐:</td>
										<td colspan="1">
											<div class="mini-radiobuttonlist mini-required mini-readonly asLabel" id="zttype" style="border-width: 0px;">
												<table cellpadding="0" border="0" cellspacing="0" style="display:table;">
													<tr>
														<td>
															<div class="mini-list-inner" style="text-align:left; padding-left:9px;">
																<div id="mini-9$0" index="0" class="mini-radiobuttonlist-item" style="float:left;margin-right:35px;">
																	<input onmousedown="this._checked = this.checked;" onclick="this.checked = this._checked" value="推荐" id="mini-9$ck$0" type="radio"/>
																	<label for="mini-9$ck$0" onclick="return false;">推荐</label>
																</div>
																<div id="mini-9$1" index="1" class="mini-radiobuttonlist-item  mini-radiobuttonlist-item-selected" style="float:left;">
																	<input onmousedown="this._checked = this.checked;" onclick="this.checked = this._checked" value="自荐" id="mini-9$ck$1" type="radio"/>
																	<label for="mini-9$ck$1" onclick="return false;">自荐</label>
																</div>
															</div>
															<div class="mini-errorIcon"></div>
															<input type="hidden" id="zttype$value" name="sffzgzjdy.tjzj" value="自荐"/>
														</td>
													</tr>
												</table>
											</div>
										</td>
										<td class="form_label">所属机构:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-treeselect mini-popupedit mini-required mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 120%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons"><span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.ssjgmc" type="hidden" value="呼和浩特市司法局"/>
											</span>
										</td>
										<td colspan="2" rowspan="5" style="padding: 5px 0px;">
											<div style="MARGIN-RIGHT: auto; MARGIN-LEFT: auto; width: 139px; height: 172px;">
												<div id="field_pic" class="upload_photo_context">
													照片ID要跟下面的json匹配
													<img style="width: 139px; height: 172px;">
													<div>
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].id" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].tableid" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].tabletype" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].columntype" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].yfilename" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].xfilename" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].absolutepath" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].relativepath" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].filetype" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].extname" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].filesize" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].type" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].upuserid" value="">
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].upusername" value=""> 
														<input type="hidden" class="mini-hidden mini-readonly asLabel" name="dbAccess.field_pic[0].upusertime" value="">
													</div>
												</div>
												<div class="upload_photo" style="position:absolute;">
														<input type="file" id="up_pic"/>
													</div>
											</div>
										</td>
									</tr>
									
									
									
									<tr>
										<td class="form_label">姓名:</td>
										<td colspan="1">
											<span class="mini-textbox mini-required mini-textbox-readOnly asLabel" id="nm" style="border-width: 0px; width: 90%; padding: 0px;">
												<input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" id="nm$text" name="sffzgzjdy.name" readonly=""/>
												<input type="hidden"/>
											</span>
										</td>
										<td class="form_label">性别:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-combobox mini-popupedit mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 120%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.sex" type="hidden" value="男"/>
											</span>
										</td>
									</tr>
									<tr>
										<td class="form_label">出生日期:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-datepicker mini-popupedit mini-buttonedit-readOnly asLabel" style="border-width: 0px; width: 90%; padding: 0px;">
												<span class="mini-buttonedit-border"><input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly="">
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.birthdate" type="hidden" value="1983-11-30"/>
											</span>
										</td>
										<td class="form_label">民族:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-dictcombobox mini-popupedit mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 120%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons"><span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.nationid" type="hidden" value="mgz"/>
											</span> 
											<input type="hidden" class="mini-hidden mini-readonly asLabel" name="sffzgzjdy.nation" value="蒙古族" style="width: 120%;"/>
										</td>
									</tr>
									<tr>
										<td class="form_label">文化程度:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-dictcombobox mini-popupedit mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 90%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.cultureid" type="hidden" value="bk"/>
											</span>
											<input type="hidden" class="mini-hidden mini-readonly asLabel" name="sffzgzjdy.culture" value="本科" style="width: 90%;">
										</td>
										<td class="form_label">政治面貌:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-dictcombobox mini-popupedit mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 120%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.politicsid" type="hidden" value="crowd"/>
											</span> 
											<input type="hidden" class="mini-hidden mini-readonly asLabel" name="sffzgzjdy.politics" value="群众" style="width: 120%;"/>
										</td>
									</tr>
									<tr>
										<td class="form_label">人员类型:</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-dictcombobox mini-popupedit mini-buttonedit-readOnly mini-buttonedit-noInput asLabel" style="border-width: 0px; width: 90%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.rytypeid" type="hidden" value="qyry"/>
											</span> 
											<input type="hidden" class="mini-hidden mini-readonly asLabel" name="sffzgzjdy.rytype" value="企业人员" style="width: 90%;"></td>
										<td class="form_label">职务/职称:</td>
										<td colspan="1">
											<span class="mini-textbox mini-textbox-readOnly asLabel" style="border-width: 0px; width: 120%; padding: 0px;">
												<span class="mini-textbox-border">
													<input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzjdy.dutyname" readonly=""/>
												</span>
												<input type="hidden"/>
											</span>
										</td>
									</tr>
									
									<tr>
										<td class="form_label" style="padding: 5px 0px;">邮编</td>
										<td colspan="1">
											<span class="mini-buttonedit mini-datepicker mini-popupedit mini-buttonedit-readOnly asLabel" style="border-width: 0px; width: 90%; padding: 0px;">
												<span class="mini-buttonedit-border">
													<input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" readonly=""/>
													<span class="mini-buttonedit-buttons">
														<span class="mini-buttonedit-close"></span>
														<span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');">
															<span class="mini-buttonedit-icon"></span>
														</span>
													</span>
												</span>
												<input name="sffzgzjdy.jrsj" type="hidden"/>
											</span>
										</td>
										<td class="form_label">联系电话:</td>
										<td colspan="1">
											<span class="mini-textbox mini-textbox-readOnly asLabel" id="jdynl" style="border-width: 0px; width: 90%; padding: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" id="jdynl$text" name="sffzgzjdy.nl" readonly=""></span><input type="hidden"></span>
										</td>
									</tr>
									<tr>
										<td class="form_label" style="padding: 5px 0px;">户籍地:</td>
										<td colspan="5" style="text-align:left; padding-left:9px;"><span class="mini-textbox mini-textbox-readOnly asLabel" style="border-width: 0px; width: 90%; padding: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzjdy.hjd" readonly=""></span><input type="hidden"></span></td>
									</tr>
									<tr>
										<td class="form_label" style="padding: 5px 0px;">工作单位/居住地:</td>
										<td colspan="5" style="text-align:left; padding-left:9px;"><span class="mini-textbox mini-textbox-readOnly asLabel" style="border-width: 0px; width: 90%; padding: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzjdy.gzdwjzd" readonly=""></span><input type="hidden"></span></td>
									</tr>
									<tr>
										<td class="form_label" style="padding: 5px 0px;">通讯地址:</td>
										<td colspan="3" style="text-align:left; padding-left:9px;"><span class="mini-textbox mini-textbox-readOnly asLabel" style="border-width: 0px; width: 97%; padding: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzjdy.txdz" readonly=""></span><input type="hidden"></span></td>
									</tr>
									<tr>
										<td class="form_label" style="padding: 5px 0px;">社会兼职:</td>
										<td colspan="5" style="text-align:left; padding-left:9px;">
											<span class="mini-textbox mini-textarea mini-textbox-readOnly asLabel" style="border-width: 0px; width: 90%; padding: 0px;border:0px;">
												<span class="mini-textbox-border" style="border:0px;">
													<textarea class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzjdy.shjz" readonly="" style="height: 48px;">
													</textarea>
												</span>
												<input type="hidden"/>
											</span>
										</td>
									</tr>
									
								</tbody>
							</table> -->
						<!-- 	
						<script type="text/javascript">
							var tabletype = "";//实体名称
							var webURL = "http:/10.16.158.196:80//sf_rmjdy";
							var webName =/*  "aaaa"; */ "/sf_rmjdy"; 
							var sessionid = /* "bbb"; */ "4F286238351012E543FA4DD284A94A06"; 
							var userOrgId = /* "ccccc"; */ ""; 
							var userOrgName = /* "dddd"; */"";
							var proUpload = {}, index = 0, pathData = {};
							var ext_img = ["gif","jpg","png","bmp","jpeg"];
							proUpload.__uploadify = function(_data){
								if(_data.queueID)
									$("#"+_data.queueID+" .mini-panel-border").css("border","0px");
								if(_data.formData)
									_data.formData.columntype = _data.queueID;
								$("#"+_data.objFile).uploadify({//初始化函数
									//指定swf文件
									swf: webName+'/uploadify/uploadify.swf',
									//后台处理的页面
									uploader: webName+'/uploadify/upload.jsp;jsessionid='+sessionid,
									//按钮显示的文字
									buttonText: _data.buttonText?_data.buttonText:"浏览",
									//按钮样式
									buttonClass: _data.buttonClass?_data.buttonClass:"uploadify-btn",
									//显示的高度和宽度，默认 height 30;width 120
									width: _data.width?_data.width:"40",
									height: _data.height?_data.height:"22",
									//鼠标的形状
									buttonCursor: 'hand',
									//设置上传队列DOM元素的ID
									queueID: _data.queueID,
									//设置为true将允许多文件上传
									multi: _data.multi,
									//设置上传文件的容量最大值
									fileSizeLimit: _data.fileSizeLimit?_data.fileSizeLimit:0,
									//可选择的文件类型的描述
									fileTypeDesc: _data.fileTypeDesc?_data.fileTypeDesc:'All Files',
									//定义允许上传的文件后缀
									fileTypeExts: _data.fileTypeExts?_data.fileTypeExts:'*.*',
									//定义在文件上传时需要一同提交的其他数据对象
									formData: {
										tabletype: _data.tabletype,//表名称
										objFile: _data.objFile,//上传控件ID
										queueID: _data.queueID,////存放标签的ID，并且是字段类型
										extsArr: ext_img,//图片格式
										isRahmen: _data.isRahmen?_data.isRahmen:false,//是否是相框
										resizeImage: _data.width+","+_data.height
									},
									//调用Uploadify初始化结束时触发该事件
									onInit: function(instance){
										//console.log('The queue ID is : '+ instance.settings.queueID);
									},
									//在开始上传之前的瞬间会触发该事件
									onUploadStart: function(file){
										//console.log('start update');
									},
									//每添加一个文件至上传队列时触发该事件
									onSelect: function(event,queueID,fileObj){
										//console.log("event: "+event.id+"\r\n"+"queueID: "+queueID+"\r\n"+"fileObj: "+fileObj);
									},
									//浏览器检测不到兼容版本的Flash时触发该事件
									onFallback: function(){
										alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
									},
									//队列中的所有文件被处理完成时触发该事件
									onQueueComplete: proUpload.__queueComplete,
									//每一个文件上传成功时触发该事件
									onUploadSuccess: proUpload.__uploadSuccess,
									//该项定义了一组默认脚本中你不想执行的事件名称
									overrideEvents: ['onSelectError', 'onDialogClose'],
									//选择文件返回错误时触发该事件。每一个文件返回错误都会触发该事件
									onSelectError: function(file, errorCode, errorMsg){
										switch(errorCode) {
											case -110:
												alert("文件 ["+file.name+"] 大小超出系统限制的"+this.settings.fileSizeLimit+"大小！");
												break;
											case -120:
												alert("文件 ["+file.name+"] 大小异常！");
												break;
											case -130:
												alert("文件 ["+file.name+"] 类型不正确！");
												break;
										}
									}
								});
								//$("#"+_data.objFile).uploadify("destroy");
							};
							//队列中的所有文件被处理完成时触发该事件
							proUpload.__queueComplete = function(queueData){
								console.log("上传成功个数: "+queueData.uploadsSuccessful+'\n'+
											"上传失败个数: "+queueData.uploadsErrored);
							};
							//每一个文件上传成功时触发该事件
							proUpload.__uploadSuccess = function(file,data,response){
								//判断是否有文件
								if(file.size == 0)
									return;
								var strData = removeSign(data,0,1);//清空里边的\r\n
								if(strData && strData.length>0){
									var jsonArr = eval("("+strData+")");//json字符串转json对象
									var json = jsonArr[0];//当前上传一个队列只上传一个，所以只有一个json
									//console.log(JSON.stringify(json));
									if(json && json!=null){
										var form = new nui.Form(json.columntype);//将普通form转为nui的form
										var formData = form.getData(false,true);//获得表单json
										//console.log(JSON.stringify(formData));
										var isRahmen = json.isRahmen;
										if(isRahmen && isRahmen=="true"){
											var fileId = formData.dbAccess[json.columntype][0].id;
											jsonArr[0].id = fileId;
											if(fileId && fileId!="null" && fileId!=""){
												jsonArr[0].tableid = formData.dbAccess[json.columntype][0].tableid;
											}
											var fileDate = {};
											fileDate[json.columntype] = jsonArr;
											form.setData({dbAccess:fileDate});
											$("#"+json.columntype).find("img").attr('src',webName+json.relativepath);
										}else{
											if(formData.dbAccess){//判断表单json是否有dbAccess
												index = formData.dbAccess[json.columntype].length;
											}
											var isDelBtn = true;
											file_label(json,index,isDelBtn);//添加附件标签
										}
									}else{
										alert("上传失败！");
									}
								}
							};
						</script> -->
						<div class="mini-menu mini-contextmenu" id="contextMenu" style="width: auto; height: auto; display: none;"><div class="mini-menu-border"><a class="mini-menu-topArrow" href="#" onclick="return false"></a><div class="mini-menu-inner"><div class="mini-menu-float"><div class="mini-menuitem"><div class="mini-menuitem-inner"><div class="mini-menuitem-icon icon-download" style="display: block;"></div><div class="mini-menuitem-text">下载</div><div class="mini-menuitem-allow"></div></div></div></div><div class="mini-menu-toolbar"></div><div style="clear:both;"></div></div><a class="mini-menu-bottomArrow" href="#" onclick="return false"></a></div></div>
						        <fieldset style="border:solid 1px #aaa;position:relative;margin:5px 2px 0px 2px;">
						            <legend>参加活动记录</legend>
						            <div id="dataform1" style="padding-top:5px;">
						                <!-- hidden域 -->
						                <input type="hidden" class="mini-hidden" id="sffzgzcjhdjl.sfFzgzCjhdjlJdys" name="sffzgzcjhdjl.sfFzgzCjhdjlJdys" value="[object Object],[object Object],[object Object],[object Object]">
						                <input type="hidden" class="mini-hidden" id="sffzgzcjhdjl.id" name="sffzgzcjhdjl.id" value="615">
						                <table style="table-layout:fixed;" class="nui-form-table">
						                    <tbody><tr>
						                        <td class="form_label">活动名称:</td>
						                        <td colspan="1">
						                            <span class="mini-textbox" style="border-width: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzcjhdjl.hdmc"></span><input type="hidden"></span>
						                        </td>
						                        <td class="form_label">活动地点:</td>
						                        <td colspan="1">
						                            <span class="mini-textbox" style="border-width: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" name="sffzgzcjhdjl.hddd"></span><input type="hidden"></span>
						                        </td>
						                    </tr>
						                    <tr>
						                        <td class="form_label">活动开始时间:</td>
						                        <td colspan="1">
						                            <span class="mini-buttonedit mini-datepicker mini-popupedit" id="startDate" style="border-width: 0px;"><span class="mini-buttonedit-border"><input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" id="startDate$text"><span class="mini-buttonedit-buttons"><span class="mini-buttonedit-close"></span><span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');"><span class="mini-buttonedit-icon"></span></span></span></span><input name="sffzgzcjhdjl.hddate" type="hidden" id="startDate$value" value="2017-09-21"></span>
						                        </td>
						                        <td class="form_label">活动结束时间:</td>
						                        <td colspan="1">
						                            <span class="mini-buttonedit mini-datepicker mini-popupedit" id="endDate" style="border-width: 0px;"><span class="mini-buttonedit-border"><input type="text" class="mini-buttonedit-input" autocomplete="off" placeholder="" id="endDate$text"><span class="mini-buttonedit-buttons"><span class="mini-buttonedit-close"></span><span class="mini-buttonedit-button" onmouseover="mini.addClass(this, 'mini-buttonedit-button-hover');" onmouseout="mini.removeClass(this, 'mini-buttonedit-button-hover');"><span class="mini-buttonedit-icon"></span></span></span></span><input name="sffzgzcjhdjl.hdenddate" type="hidden" id="endDate$value" value="2017-09-21"></span>
						                        </td>
						                    </tr>
						                    <tr>
							                    <td class="form_label">活动天数/天 :</td>
							                    <td colspan="1">
							                        <span class="mini-textbox" id="daySum" style="border-width: 0px;"><span class="mini-textbox-border"><input type="text" class="mini-textbox-input" autocomplete="off" placeholder="" id="daySum$text" name="sffzgzcjhdjl.daysum"></span><input type="hidden"></span>
							                    </td>
						                    </tr>
						                </tbody></table>
						            </div>
						        </fieldset>
						</div>
					</div>
					<div>
						<button id="RMjdy_divbuttonGB">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>