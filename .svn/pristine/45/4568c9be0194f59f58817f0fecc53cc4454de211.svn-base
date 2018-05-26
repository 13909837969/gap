<%@page import="java.util.Date"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>服刑人员验证信息采集</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"src="${localCtx}/json/SqjzRyyzxxcjService.js"></script>
<style>
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
	height: 300px;
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
</style>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzRyyzxxcjService.js"></script>
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
				selector:'#listRyYzxxcj #jzjzlxx-form',
				autolayout:true
				});
			var tableview = new Eht.TableView({
				selector:"#listRyYzxxcj_table",
				multable:true,
			});
			tableview.loadData(function(page, res) {
				service.findcj(query,page,res);
			});
			
			//重置采集
			$("#listRyYzxxcj #czcj").click(function() {
				var aid=json.id;
				if(aid != null){
					$("#listRyYzxxcj #resetting_alert_div").show();
					$("#listRyYzxxcj #yes").unbind("click").bind("click",function(){
						$("#listRyYzxxcj #resetting_alert_div").hide();
						service.resetCorrect(aid);
						tableview.refresh();
						$('#list_ryyzxxcj_right-panel').hide();
					});
					$("#listRyYzxxcj #no").unbind("click").bind("click",function(){
						$("#listRyYzxxcj #resetting_alert_div").hide();
					});
				}else{
					$('#listRyYzxxcj #close_alert_div').show();
				}
			});
			//修改
			tableview.transColumn("xgxx",function(data){
				var btn = $("<input type='button' field='xgxx' value='修改' />");
				btn.unbind("click").bind('click',function(){
					json = data;
					$('#listRyYzxxcj #myModalLabel').html('修改社区矫正人员信息');
					$('#listRyYzxxcj #myModal').modal({backdrop:'static'});
					form1.fill(data);
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
					return false;
				});
				return btn;
			});
			
			//采集状态
			tableview.transColumn("f_status",function(data){
			  	var rtn = "";
				if(data.f_face==1 || data.f_finger==1 || data.f_voice==1){
					rtn="已经采集";
				}else{
					rtn="未采集";
				}
		    	return rtn;
			})
			
			//指纹采集状态
			tableview.transColumn("f_finger",function(data){
				if(data.f_finger!=null){
					var xx = data.f_finger==0?'未采集':'采集完成';
					var btn = $('<div field="f_finger" label="指纹采集状态">'+
							xx
							+'</div>');
					return btn;
				}else{
					return "未采集";
				}
			});
			
			//声纹采集状态
			tableview.transColumn("f_voice",function(data){
				if(data.f_voice != null){
					var xx = data.f_voice==0?'未采集':'采集完成';
					var btn = $('<div field="f_voice" label="声纹采集状态">'+
							xx
							+'</div>');
					return btn;
				}else{
					return "未采集";
				}
			});
			//人脸采集状态
			tableview.transColumn("f_face",function(data){
				if(data.f_face != null){
					var xx = data.f_face==0?'未采集':'采集完成';
					var btn = $('<div field="f_face" label="人脸采集状态">'+
							xx
							+'</div>');
					return btn;
				}else{
					return "未采集";
				}
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
		$('#listRyYzxxcj #listTjdaxx_send').click(function(){
			//默认添加初始界面在最上面输入姓名
			setTimeout(function(){
				$("#listRyYzxxcj #xm").focus();
			},200);
			$("#listRyYzxxcj #csrq").attr("disabled",true);
			form1.clear();
			$('#listRyYzxxcj #myModal').modal({backdrop:'static'});
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
</head>
<body id="listRyYzxxcj">
	<div class="alert alert-warning alert_dismissible" id="close_alert_div"  hidden role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
			<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
	</div>
	<div class="alert alert-info alert-dissmissible" id="Success_alert_div" hidden role="alert" style="text-align:center;font-size:17px">
		<strong>提示</strong> 发送成功！
	</div>	
	<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
		<strong>提示</strong> 确定发送？
		<input id="yes" class="btn btn-default" type="button" value="确定" >
		<input id="no" class="btn btn-default" type="button" value="取消" >
	</div>
	<div id="listRyYzxxcj" class="panel panel-default">
		<div id="head" class="panel-heading" style="padding-left: 10px">
			<fieldset id="input-group">
				姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="search-xm"/> 
				<label>采集状态:</label> 
				<select type="text"  id="cjzt"  style="width: 120px;background-color: #fff;" class="input-group-addon">
					<option value="">全部</option>
					<option value="0">未采集</option>
					<option value="1">采集完成</option>
				</select> 
				<label>所属司法所:</label>
				<select type="text"  id="listRyYzxxcj_xmAndLxdh"  style="width: 150px;background-color: #fff;" class="input-group-addon">
				</select> 
				<input class="btn btn-default" type="button" id="listJzsf_find"	value="查询"> 
				<input class="btn btn-default" type="button" id="listTjdaxx_send" value="添加档案数据"> 
				<input class="btn btn-default" type="button" id="listPlFsXx_send" value="批量发送信息">
			</fieldset>
		</div>
		<div class="container-fluid">
			<div id="listRyYzxxcj_table" style="margin-top: 10px">
				<div field='op' label="<input type='checkbox'>" checkbox="true" id="selectAll"></div>
				<div field="xm" label="姓名"></div>
				<div field="orgname" label="所属司法所"></div>
				<div field="f_status" label="总采集状态"></div>
				<div field="grlxdh" label="联系电话"></div>
				<div field="f_face" label="人脸采集状态"></div>
				<div field="f_finger" label="指纹采集状态"></div>
				<div field="f_voice" label="声纹采集状态"></div>
				
				<div field="xgxx" label="修改"></div>
			</div>
		</div>

		<!-- 添加档案数据模态框 -->
		<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal"
							aria-hidden="true">&times;</Button>
						<h4 class="modal-title" id="myModalLabel">新增社区矫正人员</h4>
					</div>
					<div class="modal-body pre-scrollable ">
						<div id="jzjzlxx-form">
							<input type="text" id="xm" autoComplete="off" name="xm" label="姓名" valid="{required:true}" />
							<input type="text" name="cym" id="cym" label="曾用名" getdis="true" />
							<input type="text" name="xb" id="xb" label="性别" getdis="true" valid="{required:true}" code="sys000" />
							<input type="text" name="mz" id="mz" label="民族" getdis="true" valid="{required:true}" code="sys003" /> 
							<input type="text" name="sfzh" id="sfzh" label="身份证号" getdis="true" valid="{required:true,cardNo:true}"/> 
							<input type="text" name="csrq" id="csrq"  label="出生日期"   placeholder="出生日期"  valid="{required:true}"  class="form_date" data-date-format="yyyy-MM-dd" />
							<input type="text" label="手机号" id="grlxdhsjh" name="grlxdh"   getdis="true" valid="{mobile:true}"/> 
							<input type="text" name="sfcn" id="sfcn" label="是否成年" getdis="true" code="sys001" /> 
							<input type="text" name="wcn" id="wcn" label="未成年" getdis="true" code="sys035" /> 
							<input type="text" label="婚姻状况" name="hyzk"  getdis="true"  code="sys030" /> 
							<input type="text" label="原政治面貌" name="yzzmm" id="yzzmm" getdis="true" code="sys091" /> 
							<input type="text" label="现政治面貌" name="xzzmm" id="xzzmm" getdis="true" code="sys091" /> 
							<input type="text" name="jglx" id="jglx" label="矫管类型" getdis="true" valid="{required:true}" code="sys114" />
							<input type="text" label="捕前职业" name="pqzy" id="pqzy" getdis="true" code="sys098" />
							<input type="text" label="文化程度" name="whcd" id="whcd" getdis="true" code="sys028" /> 
							<input type="text" label="现工作单位" name="xgzdw" id="xgzdw" getdis="true"valid="{hasChinese:true}"/> 
							<input type="text" label="原工作单位" name="ygzdw" id="ygzdw" getdis="true" />
							<input type="text" name="dwlxdh" label="单位联系电话" id="dwlxdh" getdis="true"valid="{number:true}"/>
							<input type="text" name="qtlxfs" label="其他联系方式" id="qtlxfs" getdis="true" valid="{number:true}"/> 
							<input id="sfswry" type="text" label="是否三无人员" name="sfswry" getdis="true" code="sys001" />
							<input id ="jyjxqk" type="text" label="就业就学情况" name="jyjxqk" getdis="true" code="sys031" />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="modelGb">关闭</button>
						<button type="button" class="btn btn-primary" id="submit">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 右侧弹出表单 -->
	<div class="right-panel" id="list_ryyzxxcj_right-panel">
		<div class="alert alert-info alert-dissmissible" id="resetting_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> <span id="cixxBt">确定重置采集？</span>
			<input id="yes" class="btn btn-default" type="button" value="确定" >
			<input id="no" class="btn btn-default" type="button" value="取消" >
		</div>
		<div class="panel panel-default" style="border:0px; margin-bottom:20px;">
			<div class="panel-heading" style="background:#e5e5e5;border-bottom:0px;height:40px;">
				<span id="siderightbar" class="glyphicon glyphicon-chevron-right"></span>
				<span>人员信息</span>
			</div>
			<div class="panel-body" id="form-panel" style="padding:15px 0px 15px 0px;">
				<!-- 人員信息 -->
				<div class="container-fluid">
					<div class="row-fluid">
						<table width="80px;" id="right-view">
							<tr height="80px;">
								<td valign="top">
								<div class="asfsdgdfg" id="yctc">
									<table style="width: 400px;margin-left: 20px; font-size: 16px;">
										<tr height="50px">
											<td class="text-left" id="xm" name="xm">姓名</td>
										</tr>
										<tr>
											<td style="width: 100px" id="xb" name="xb" getdis="true" lable="性别"></td>
										</tr>
										<tr height="50px;">
											<td>联系电话：&nbsp;&nbsp;<input type="text"class="text-left" id="grlxdh" name="grlxdh" style="width: 110px ; height:30px; border-radius: 5px; border:0px;" /></td>
											<td width="70px" id="sendonebtn_td">
											</td>
											<td  valign="middle" align="center">
												<div style="margin-left:0px;font-size:16px;" id="djs"></div>
											</td>
										</tr>
										<tr hright="1px" width="400px" bgcolor="#ccc"></tr>
									</table>
								</div>
									<table style="width:450px; font-size:16px;">
										<tr height="50px;" class="text-left" style="background:#f2f2f2;"> 
											<td style="padding-left:30px;" id="rlxx">人脸采集信息</td>
											<td id="f_face" style="font-size:14px;padding-left:55px;"></td>
										</tr>
										<tr class="text-left" style="background:#f2f2f2;">
											<td colspan="3"style="padding-left:30px;">
												<img id="IMGID" style="width:120px; height:160px; margin-bottom:10px;border-radius:5px;"/> 
											</td>
										</tr>
										<tr height="50px;" class="text-left" style="background:#f0f0f0;">
											<td width="310px;" style="padding-left:30px;" id="zwxx">指纹采集信息</td>
											<td style="padding-left:66px; font-size:14px;" id="f_finger"></td>
										</tr>
										<tr height="50px;" class="text-left" style="background: #f5f5f5;">
											<td width="310px;" style="padding-left:30px;" id="swxx">声纹采集信息</td>
											<td style="padding-left:66px; font-size:14px;" id="f_voice"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="row" style="position:absolute; bottom:10px;">
				<div class="col-md-12" style="padding-left:300px;height:50px;">
					<div  >
						<button id="completeRefresh" class="btn btn-success" style="padding:7px 14px; border-color:transparent;position:absolute;bottom:-7px;left:50px;">刷新</button>
					</div>
					<div class="col-md-6 col-sm-6">
						<button class="btn btn-success" id="czcj" style="padding:7px 14px; border-color:transparent;position:absolute;bottom:-55px;left:-20px;">重置采集</button>
					</div>
					<div class="col-md-6 col-sm-6" >
						<button id="completeBtn" class="btn btn-success" style="padding:7px 14px; border-color:transparent;position:absolute;bottom:-55px;left:50px;">完成</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>