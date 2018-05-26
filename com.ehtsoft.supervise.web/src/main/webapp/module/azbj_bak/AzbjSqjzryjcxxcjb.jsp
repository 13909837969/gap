<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正人员奖惩信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjSqjzryjcxxcjbService.js"></script>
<style>
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	display: none;
	box-shadow: 0px 0px 10px #888888;
	width:0px;
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

.input {
	outline: none;
	border-bottom: 1px solid #dbdbdb;
	border-top: 0px;
	border-left: 0px;
	border-right: 0px;
	word-break: break-all;
	text-align: center;
}

.div_h {
	text-align: center;
}

.btn-success_tj {
	margin-left: 400px;
}
</style>

<script type="text/javascript">
		$(function(){
			var service = new AzbjSqjzryjcxxcjbService();
			var json={};
			var form = new Eht.Form({selector:"#listJzsf #querypanel"});
			//右侧弹出基本信息布局
			var from_jcxx = new Eht.Form({selector:"#listSqjz_jcxxb_from",autolayout:true});
			
			var from_jcxx1 = new Eht.Form({selector:"#listSqjz_jcxxb_from1",autolayout:true});
			
			var tableview = new Eht.TableView({
				selector:"#listJzsf_table"
			});
			var tableview_jcxxzs = new Eht.TableView({
				selector:"#listJcxxzs-table",
				paginate:null//翻页
			});
			
			//单击一行获取数据
			tableview.clickRow(function(data){
				json = data;
				json.f_aid=json.id;
			})
			//
			tableview.loadData(function(page,res){
				service.findAllRy(form.getData(),page,res);
			}); 
			//关闭右侧面板
			 $("#right-panel #siderightbar").click(function() {
				$('#right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
			}); 
			/* 查询信息 */
			$("#listJzsf #listJzsf_find").click(function(){
				tableview.refresh();
			});
			var form1 = new Eht.Form({selector:'#jzjzlxx-form',autolayout:true});	
			//保存
			$('#AzbjSqjzryjcxx-form #submit').click(function(){
				debugger;
				if(form.validate()){
					service.saveJzry(from_jcxx1.getData(),new Eht.Responder({
						success:function(data){
							tableview_jcxxzs.refresh();
						}
					}));
				}
			});
			//默认隐藏
			function changeInput(ifBoolean){
				if(ifBoolean){
					from_jcxx.disable();
				}else{
					from_jcxx.enable();
				}
			}
			//单击添加奖惩数据弹出模态框	
			$('#listTjdaxx_send').click(function(){
				form1.clear("jzllx");
				from_jcxx.fill(json);
				from_jcxx1.fill(json);
				changeInput(true);
				tableview_jcxxzs.loadData(function(page,res){
					service.findOne(json.f_aid,res);
				})
				$('#right-panel').show().animate({
					width : 555
				});
			});

		});
	</script>
</head>
<body>
<div id="listJzsf">
		<div class="container-fluid" s>
			<fieldset id="querypanel" >
			姓名:<input id="searchXm" class="btn btn-default" type="text" name="xm" placeholder="请输入姓名" /> 
			手机号:<input class="btn btn-default" type="text" name="grlxdh" placeholder="请输入手机号" />
				<input class="btn btn-default" type="button" id="listJzsf_find"
					value="查询">
				<input class="btn btn-default" type="button" id="listTjdaxx_send"
					value="添加奖惩"  >
				<!-- <input class="btn btn-default" type="button" id="listJzsf_selectbtn" value="查询详细信息"> -->
			</fieldset>
			<div id="listJzsf_table" style="margin-top: 10px">
 				<div field="xm" label="姓名"></div>
				<div field="xb" label="性别"></div>
				<div field="grlxdh" label="联系电话"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="jclb" label="居住地址"></div>
				<div field="jccs" label="奖惩次数"></div>
				<div field="gjlx" label="管教类型"></div>
			</div>
		</div>
		
	
	<!-- 右侧弹出表单 -->
	<div id="AzbjSqjzryjcxx-form"> 
		<div class="right-panel" id="right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;服刑人员奖惩记录基本信息
				</div>
				<div class="panel-body text-left" id = "listSqjz_jcxxb_from" >
				
					<input type="text" label="姓名" name="xm" getdis="true"/>
					<input type="text" label="联系电话" name="grlxdh" getdis="true"/>
					
				</div>
				<div id="listSqjz_jcxxb_from1">
					<input type="hidden" name="f_aid"/>
					<input type="text" label="奖惩类别" name="jclb"   code="sys082"/>
					<input type="text" label="奖惩时间" name="jcsj"   class="form_date" data-date-formate="yyyy-MM-dd"/>
					<input type="text" label="奖惩原因" name="jcyy"   code="sys083"/>
				</div> 
				<center>
					<button type="button" class="btn btn-baise" id="submit">保存</button>
				</center>
				
				<br>
			</div>
			<div id="listJcxxzs-table" style="position:absolute; height:280px;width:522px; overflow:auto" >
 				<div field="jclb" label="奖惩类别"></div>
				<div field="jcsj" label="奖惩时间"></div>
				<div field="jcyy" label="奖惩原因"></div>
			</div>
			</div>
		</div>
<!-- 右侧点击人物信息弹出 -->
		<!-- <div id="AzbjSqjzryjcxx-form_form"> 
		<div class="right-panel" id="right-panel">
			<div class="panel panel-default">
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;服刑人员奖惩记录基本信息
				</div>
				<div class="panel-body text-left" id = "listSqjz_jcxxb_from" >
				
					<input type="text" label="姓名" name="xm" getdis="true"/>
					<input type="text" label="联系电话" name="grlxdh" getdis="true"/>
					
				</div>
				
				<br>
			</div>
			<div id="listJcxxzs-table" style="position:absolute; height:280px;width:522px; overflow:auto" >
 				<div field="jclb" label="奖惩类别"></div>
				<div field="jcsj" label="奖惩时间"></div>
				<div field="jcyy" label="奖惩原因"></div>
			</div>
			</div>
		</div> -->
</body>
</html>