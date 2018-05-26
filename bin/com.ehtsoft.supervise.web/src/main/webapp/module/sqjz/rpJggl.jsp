<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>机构分布综合管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript"
	src="${localCtx}/json/DictionaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/ProhibitService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzSfxzjgService.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer.js"></script>
<style type="text/css">
#rp_jggl .nav-tab-content {
	position: absolute;
	width: 100%;
	padding: 5px;
	bottom: 0px;
	top: 0px;
}
#rp_jggl #form-jzqy>div {
	margin: 5px 0px;
}
</style>

<script type="text/javascript">
	var map1,markers = [],markerClusterer;
	$(function() {
		var bs = new BoundaryService();
		var xzjg = new JzSfxzjgService();

		var rightbutton1 = new BMap.NavigationControl({
			anchor : BMAP_ANCHOR_BOTTOM_LEFT,
			type : BMAP_NAVIGATION_CONTROL_SMALL
		});
		var mapType1 = new BMap.MapTypeControl({
			anchor : BMAP_ANCHOR_BOTTOM_RIGHT,
			mapTypes : [ BMAP_NORMAL_MAP, BMAP_HYBRID_MAP ]
		});
		//区划设置
	    map1 = new BMap.Map("rp_jggl_map1");
		map1.addControl(rightbutton1);
		map1.addControl(mapType1);
		map1.centerAndZoom(new BMap.Point(111.712329, 40.832096999999997),6);
		map1.enableScrollWheelZoom(true);
		getBoundary("150000");

		//查询区划边界数据
		var polygons = [];
		var byOverlays = [];
		var id = null;
		var jgmc = null;
		var lvl = 0;

		//行政区划
		var tree1 = new Eht.BootTree({
			selector : "#rp_jggl #tree1",
			labelField : "jgmc",
			pidField : "parentid",
			pkField : "id"
		});
		tree1.clickItem(function(data, selected) {
			if (selected) {
				var pd = this.getParentData(data);
				debugger;
				id = data.id;
				jgmc = data.jgmc;
				var searchtxt = pd != null ? pd.text + jgmc : jgmc;
				getBoundary(data.regionid);
				getOrgListByParentId(data.id);
			}
		});
		tree1.loadData(function(res) {
			xzjg.find({}, res);
		});

		function getBoundary(code) {
			bs.findBoundary(code, null, new Eht.Responder({
				success : function(data) {
					var pointArray = [];
					for (var i = 0; i < data.length; i++) {
						var bounds = data[i].boundary;
						for (var j = 0; j < bounds.length; j++) {
							var ply = new BMap.Polygon(bounds[j], {
								strokeWeight : 4,
								strokeColor : "#ff00ff"
							}); //建立多边形覆盖物 81bbec
							map1.addOverlay(ply);
							pointArray = pointArray.concat(ply.getPath());
						}
					}
					map1.setViewport(pointArray); //调整视野  
				}
			}));
		}
		
		
		//根据id获取所有的下级司法机构
		function getOrgListByParentId(parentid){
			xzjg.findByParentId(parentid,new Eht.Responder({
				success : function(data) {
					debugger;
					markers = [];
					//从后台返回的数据 data
					if (data!= null) {
						var items = data;
						for (var i = 0; i < items.length; i++) {
							addMarker(items[i]);
						}
						 markerClusterer = new BMapLib.MarkerClusterer(map1, {markers:markers});
					}
				}
			}));
			
		}
		
		//添司法机构位置
		function addMarker(item) {
			var point = new BMap.Point(item.lat, item.lng)
			var myIcon = new BMap.Icon("mapimg/sfj.png", new BMap.Size(48,48));  
			var marker = new BMap.Marker(point, {icon: myIcon});  
			//map.addOverlay(marker);
			markers.push(marker);
			var opts = {
					width : 380, // 信息窗口宽度
					height :160, // 信息窗口高度
					title : "<span  style='font-size:16px;color:#ffa000'>"+item.jgmc+"</span>", // 信息窗口标题
					enableMessage : true
					//设置允许信息窗发送短息
				}
				var infoWindow = new BMap.InfoWindow(
						 "<div  ><table width='380px;margin-top:10px;'><tr style='font-size:15px;'><td  width='70%' align='left'>"+item.jgmc+"简介</td><td align='right'><a onclick=\"jgdetail('"+item.id+"')\">查看</a></td></tr>"+
						 "<tr style='font-size:15px;'><td  width='70%' align='left'>工作情况查看</td><td align='right'><a onClick=\"viewMzxz('"+item.jgmc+"')\">查看</a></td></tr>"+
					     "<tr  style='font-size:15px;'><td  width='70%' align='left'>服刑人员数量(人)："+item.regionid+"</td><td align='right'><a onclick='viewJzgry("+item.jgmc+")'>查看</a></td></tr>"+
						 "<tr style='font-size:15px;'><td  width='70%' align='left'>工作人员数量(人)："+item.regionid+"</td><td align='right'><a onClick=\"viewMzxz('"+item.jgmc+"')\">查看</a></td></tr>"+
						 "<tr style='font-size:15px;'><td  width='70%' align='left'>位置："+item.dz+"<a></td><td align='left'></a></td></tr></table></div>",opts); 
				marker.addEventListener("click", function() {
					map1.openInfoWindow(infoWindow, point); //开启信息窗口
				});
		}
	});
	
	function  jgdetail(data){
		$("#rp_jggl #myModal").modal({backdrop: 'static', keyboard: false,height:300});
		$("#modal-body #iframe").attr("src","${localCtx}/module/sqjz/detailJggl.jsp");
	}
</script>
</head>
<body>
	<div id="rp_jggl">
		<div class="nav-tab-content" id="jggl">
			<div class="panel panel-default"
				style="position: absolute; bottom: 2px; top: 0px; width: 240px;z-index:10;filter:alpha(Opacity=80);-moz-opacity:0.5;opacity: 0.9;">
				<div class="panel-body"
					style="bottom: 0px; position: absolute; top: 0px; overflow: auto; right: 0px; left: 0px;">
					<div class="row clearfix">
						<div id="tree1"></div>
					</div>
				</div>
			</div>
			<div class="panel panel-default" id="rp_jggl_map1"
				style="position: absolute; bottom: 2px; left: 0px; top: 0px; right: 3px;">
			</div>
		</div>
		
		<div class="modal fade" id="myModal">
					<div class="modal-dialog" style="height:100%">
						<div class="modal-content" style="height:100%">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"   aria-hidden="false">x
								</button>
								<h4 class="modal-title" id="myModalLabel">司法机构简介</h4>
							</div>
							<div class="modal-body" id="modal-body">
								<iframe id="iframe"    width="100%"    height="400px;"  scrolling="no"    frameborder="0">
								</iframe>
							</div>
						</div>
					</div>
		   </div>
	</div>
</body>
</html>