<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>报警管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"  src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<script type="text/javascript" src="${localCtx}/json/AlarmService.js"></script>
<script type="text/javascript" src="${localCtx}/json/FootprintService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AlarmService.js"></script>
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
	height: 100%;
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
</style>
<script type="text/javascript">
	var map, mun=0,markers = [],markersClussterer;
	var index = 0; //记录播放到第几个point
	var points = [];//获取所有点的坐标
	var car; //汽车图标
	var label;//标签
	$(function(){
		var service = new AlarmService();
		var form = new Eht.Form({
			selector : "#listBjgl_div #querypanel"
		});
		var eht = new Eht.TableView({
			selector : "#listBjgl_div #tableview",
			valueCodeField : "f_code",
			labelCodeField : "f_name"
		});
		eht.loadData(function(page, res) {
			service.findAlarmList(form.getData(), page, res);
		});
		//单击行获取该行的数据
		var json;
		var jsonArray = [];
		eht.clickRow(function(data) {
			json = data;
			jsonArray.push(data);
			$("#xm").html(data.xm);
			$("#xb").html(data.xb);
			$("#mz").html(mz);
			$("#sfzh").html(data.sfzh);
			$("#f_type").html(data.f_type);
			$("#f_address").html(data.f_address);
			//创建map实例地图
			map = new BMap.Map("map_listBjgl");
			map.centerAndZoom(new BMap.Point(111.712329, 40.832096999999997), 15);
			map.centerAndZoom();//初始化地图,设置中心点坐标和地图位置
			map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL}));//添加平移放缩空间
			
			map.addControl(new BMap.ScaleControl());//添加比例尺空间
			map.addControl(new BMap.OverviewMapControl());//添加地图缩略控件
			map.enableScrollWheelZoom();//启用滚轮放缩大小
			map.addControl(new BMap.MapTypeControl());//添加地图类控件
			var mapStyle = {
					features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
					style : "road" //设置地图风格为高端黑
				}
			map.setMapStyle(mapStyle);
			
			//获取报警人的位置信息
			loadry();
			//显示获取的信息			
			$('#listBjgl_div #right-panel').show().animate({
				width : 555
			});
		});
		//显示所有人员
		function loadry() {
			//清空当前地图信息
			var fp = new FootprintService();
			//获取所有的人员信息
			fp.getLastLocations(new Eht.Responder({
				success : function(jsonArray) {
					//从后台返回的数据 rows
					if (jsonArray != null) {
						for (var i = 0; i < jsonArray.length; i++) {
							addRyMarker(jsonArray[i]);
						}
					}
				}
			}));
		}
		//增加人员位置
		function addRyMarker(json) {
			var point = new BMap.Point(json.lng,json.lat)
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			var aid=json.aid;
			
			var sContent = "服刑人员当前位置信息:<br>"+$("#f_address").html();
			var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
			map.openInfoWindow(infoWindow,point); //开启信息窗口
			
			
			
			marker.addEventListener("mouseover", function() {
				marker.setAnimation(BMAP_ANIMATION_BOUNCE);
			});
			
			marker.addEventListener("mouseout", function() {
				marker.setAnimation("");
			});
		};
		//关闭右侧面板
		$("#closebtn").click(function() {
			$('#right-panel').animate({
				width : 0
			}, function() {
				$(this).hide()
			});
			eht.refresh();
		});
		//查询
		$("#listBjgl_div #querybtn").click(function() {
			eht.refresh();
		})
		//获取个人信息数据
		function getDaxxData() {
			var rtn = new Array();
			$("#listBjgl_div").find("tbody tr").each(function() {
				var obj = {};
				$(this).find("input").each(function() {
					var n = $(this).attr("name");
					obj[n] = $(this).val();
				});
				rtn.push(obj);
			});
			return rtn;
		}
		function touppcase() {
			$("#listBjgl_div input[name]").unbind("change").bind(
					"change", function() {
						$(this).val($(this).val().toUpperCase());
					});
		}
	});
</script>
</head>
<body>
	<div class="container-fluid" id="listBjgl_div">
		<div class="row-fluid">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="querypanel">
					姓名：<input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/>
					 身份证号：<input type="text" name="sfzh[like]" class="btn btn-default" placeholder="请输入身份证号"/>
					 <input id="querybtn" class="btn btn-default" type="button" value="查询">
				</fieldset>
			</div>
			<div class="panel-body" style="padding:3px;">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别"></div>
					<div field="mz" label="民族" code="sys003" class="mz_div"></div>
					<div field="sfzh" label="身份证号"></div>
					<div field="f_type" label="报警类型" code="sys014"></div>
					<div field="f_address" label="报警地址"></div>
				</div>
			</div>
		</div>
	
	<!-- 右侧弹出表单 -->
	<div class="right-panel" id="right-panel">
		<div class="panel panel-default">
			<div class="panel-heading">
				<span id="siderightbar" class="glyphicon glyphicon-indent-center"></span>&nbsp;&nbsp;服刑人员当前信息位置
			</div>
			<div class="panel-body" id="form-panel">
				<!-- 矯正人員基本信息 -->
				<div class="container-fluid">
					<div class="row-fluid">
						<table width="80px;">
							<tr height="80px;">
								<td rowspan="2"><img src="../rp/img/user2.jpg"
									style="width: 60px; height: 80px; margin-bottom: 10px;"
									class="img-rounded"></td>
								<td valign="top">
									<table
										style="width: 300px; margin-left: 20px; font-size: 16px;">
										<tr height="50px;">
											<td id="xm" name="xm">张一山</td>
											<td id="xb" name="xb">男</td>
											<td id="mz" name="mz">汉族</td>
										</tr>
										<tr>
											<td name="sfzh" id="sfzh">15903822378</td>
											<td name="f_pf" id="f_pf">继续教育</td>
										</tr>
									</table>
								</td>
								<td width="100px;">
									<button name="f_pf" id="f_pf" class="btn btn-default">矫正档案</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
					<div>
						<label class="control-label">报警位置信息:</label>
						<div name="f_address" id="f_address"></div>
					</div>
					<div id="map_listBjgl"  style="width:540px;height:370px;">
					</div>
			</div>
		</div>
		<div class="panel-footer ">
			<button id="closebtn" class="btn btn-success" style="position:absolute;right:20px;bottom:20px;">关闭</button>
		</div>
	</div>
</div>
</body>
</html>