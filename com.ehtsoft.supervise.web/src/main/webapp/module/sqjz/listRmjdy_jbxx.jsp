<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>基本信息</title>
<link rel="stylesheet" type="text/css" href="css/RmjdyXx.css"/>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx}/json/SqjzRyyzxxcjService.js"></script>
<script type="text/javascript">
$(function() {
	var form = new Eht.Form({
		selector : "#rmjdxx_listKttjaj",
		autolayout:true
	});
	var tableView = new Eht.TableView({
		selector : "#rmjdxx_listKttjaj #tableview",
		//一次选择多个数据
		multable : true
	});
	$("#rmjdxx_listKttjaj #rmtj_id_djan").click(function(data){
		$("#rmjdxx_listKttjaj #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		
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
				selector:'#rmjdxx_listKttjaj #jzjzlxx-form',
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
		$('#rmjdxx_listKttjaj #RmjdyLb_button_ck').click(function(){
			$('#rmjdxx_listKttjaj #myModal').modal({backdrop:'static'});
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
	width:50px;
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
#jzjzlxx-form table tr td{
	text-align:right;
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
.Rmtjjdy_icon_div div div{
	text-align:center;
}
.Rmtjjdy_icon_div div div span{
	text-align:right;
}
</style>

</head>
<body>
	<div id="rmjdxx_listKttjaj">
		<div class="panel panel-default">
			<div>
				<fieldset  class="panel-body">
					<div id="querypanel">
						<div class="row" id="Rmtjjdy_icon"><span class="im-search3"></span><span class="Rmtjjdy_icon_span">人民监督员查询</span></div>
						<div class="row Rmtjjdy_icon_div" style="margin-bottom:10px;" >
							<div class="col-md-12 col-sm-12" style="margin-bottom:20px;">
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">姓名:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">工作区域:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-3 col-sm-3">
									<span style="font-weight:bold;">政治面貌:</span>
									<select style="height:30px;border:1px solid #ccc;border-radius:4px;">
										<option>中共党员</option>
										<option>中共预备党员</option>
										<option>共青团员</option>
										<option>民革党员</option>
										<option>民盟成员</option>
										<option>民建会员</option>
										<option>民进会员</option>
										<option>农工党员</option>
										<option>致公党员</option>
										<option>九三学社社员</option>
										<option>台盟成员</option>
										<option>无党派人士</option>
										<option>群众</option>
									</select>
								</div>
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">性别:</span>
									<select style="height:30px;border:1px solid #ccc;border-radius:4px;">
									
									</select>
								</div>
							</div>
							<div class="col-md-12 col-sm-12">
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">年龄:从</span>
									<input style="height:30px;border-radius:4px;border:1px solid #ccc;"/>
								</div>
								<div class="col-md-3 col-sm-3"><span style="font-weight:bold;">到:</span><input style="height:30px;border-radius:4px;border:1px solid #ccc;"/></div>
								<div class="col-md-3 col-sm-3">
									<span style="font-weight:bold;">文化程度:</span>
									<select style="height:30px;border:1px solid #ccc;border-radius:4px;">
										<option>博士后</option>
										<option>博士</option>
										<option>硕士</option>
										<option>本科</option>
										<option>专科</option>
										<option>高中</option>
										<option>初中</option>
										<option>其他</option>
									</select>
								</div>
								<div class="col-md-3 col-sm-3">
									<span style="font-weight:bold;">民族：</span>
									<select style="height:30px;border:1px solid #ccc;border-radius:4px;">
									
									</select>
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
					<div class="RmjdyLb_text " style="margin-bottom:10px;">人民监督员列表</div>
					<div class="RmjdyLb_button " style="margin-bottom:20px;">
						<button>增加</button>
						<button>修改</button>
						<button>删除</button>
						<button id="RmjdyLb_button_ck">查看</button>
						<button>导出</button>
					</div>
					<div class="panel-body" style="padding:0px;">
						<div id="tableview" class="table-responsive">
							<div field="XH" label=""></div>
							<div field='op' label="<input type='checkbox'>" checkbox="true" id=""></div>
							<div field="XM" label="姓名"></div>
							<div field="XB" label="性别"></div>
							<div field="CSRQ" label="出生日期"></div>
							<div field="MZ" label="民族"></div>
							<div field="WHCD" label="文化程度"></div>
							<div field="ZZMM" label="政治面貌"></div>
							<div field="RYLX" label="人员类型"></div>
							<div field="HJD" label="户籍地"></div>
							<div field="GZDW" label="工作单位/居住地"></div>
							<div field="ZW" label="职务/职称"></div>
							<div field="SHJZ" label="社会兼职"></div>
							<div field="TXDZ" label="通讯地址"></div>
							<div field="YB" label="邮编"></div>
							<div field="LXDH" label="联系电话"></div>
							<div field="tj" label="推荐/自荐"></div>
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
								<table style="width: 100%; height: 100%; table-layout: fixed;" class="nui-form-table" cellpadding="0" border="0">
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
													<!-- 照片ID要跟下面的json匹配 -->
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
												<!-- <div class="upload_photo" style="position:absolute;">
														<input type="file" id="up_pic"/>
													</div> -->
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
							</table>
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