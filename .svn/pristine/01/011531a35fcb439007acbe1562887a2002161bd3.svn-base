<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>人员定位数据</title>
<link href="css/layout.css" type="text/css" rel="stylesheet">
<!--新加引用start-->
<jsp:include page="../module/ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=eBcmZoBfRi9MGENgw2tmmLMI8tYr7rYS"></script>
<script type="text/javascript"  src="${localCtx}/json/FootprintService.js"></script>
<style type="text/css">
.mapContainer{
width:100%;
height:100%;
}
.search_input{
background:url(../module/sqjz/mapimg/query.png);
width:68px;
height:36px;
cursor:pointer;
margin-top:0px;
border:none;
}
</style>
</head>
<style type="text/css">
</style>
<body class="mapContainer">
	<div id="main"  class="mapContainer">
		<div id="map"   class="mapContainer"></div>
			<div id="queryId"   style="position:absolute;top:5px;width:0px;background:#ffffff;">
				<div class="container"  style="width:500px;'">
					<form class="navbar-form navbar-left">
						<div class="col-lg-6">
							<div class="input-group">
								<input type="text" class="form-control"   value="47e8c66e-ccb0-493d-984a-d4bebc3c117b"  id="aid"  style="width:400px;height:40px;border:0;"    placeholder="输入aid进行搜索">
								<span class="input-group-btn">
									<button class="search_input"  style="width:53px;height:40px;border:0;"   type="button"
										onclick="queryPeople()"></button>
								</span>
							</div>
						</div>
					</form>
				   </div>
		   </div>
		   
		   <div id="locationId"   style="position:absolute;top:60px;left:30px;width:0px;background:#ffffff;">
				<div class="container"  style="width:300px;height:600px;overflow:auto;border:1px solid #f00;background:#fff;">
					<div id="tableview">
						<div field="jgmc" label="机构名称"></div>
						<div field="xm" label="姓名"></div>
					</div>
				</div>
		   </div>
		   <textarea rows="10"  style="width:400px;position:fixed;bottom:40px;right:40px;"  id="locJson" ></textarea>
	</div>
</body>
</html>
<script type="text/javascript">
	var map,num=0;
	$(function() {
		//添加百度地图
		map = new BMap.Map("map"); // 创建地图实例  
		//map.centerAndZoom(new BMap.Point(118.998103, 42.286232), 16);
		map.centerAndZoom("呼和浩特市", 15);                 // 初始化地图，设置中心点坐标和地图级别  
		map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		map.enableScrollWheelZoom(); //启用滚轮放大缩小
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "road" //设置地图风格为高端黑
		}
		map.setMapStyle(mapStyle);
		
		var footprintService = new FootprintService();
		
		var tabview = new Eht.TableView({selector:"#tableview",paginate:null});
		tabview.clickRow(function(data){
			//获取居民位置信息
			footprintService.getFootprintByAid(data.id,new Eht.Responder({
				success : function(items) {
					//从后台返回的数据 data
					if (items != null) {
						map.centerAndZoom(new BMap.Point(items[0].lng,items[0].lat), 18);
						for (var i = 0; i < items.length; i++) {
							addMarker(items[i]);
						}
					}
				}
			}));
		});
		tabview.loadData(function(page,res){
			footprintService.getJzryxx(res);
		});
	});

	function queryPeople() {
		var aid=$("#aid").val();
		if(aid==""){
			alert("请输入aid");
			return;
		}
		//清空当前地图信息
		map.clearOverlays();
		var footprintService = new FootprintService();
		//获取居民位置信息
		footprintService.getFootprintByAid(aid,new Eht.Responder({
			success : function(items) {
				//从后台返回的数据 data
				if (items != null) {
					map.centerAndZoom(new BMap.Point(items[0].lng,items[0].lat), 18);
					for (var i = 0; i < items.length; i++) {
						addMarker(items[i]);
					}
				}
			}
		}));
	}
	
	function addMarker(item) {
		var point = new BMap.Point( item.lng,item.lat);
		var icon = new BMap.Icon("../module/sqjz/mapimg/iocn_red.png",new BMap.Size(29, 36));
		var marker = new BMap.Marker(point, {
			icon : icon
		});
		map.addOverlay(marker);
		marker.data = item;
		rightClickHanlder(marker);
		marker.addEventListener("click", function() {
			$("#locJson").val(JSON.stringify(item));
		});
	}

	function rightClickHanlder(marker){
		var menu = new BMap.ContextMenu();
		 var markerMenu=new BMap.ContextMenu();
		 var mi = new BMap.MenuItem('删除',function(e,e2,marker){
				console.log(this.data);
				 var fs = new FootprintService();
				 fs.removePosition(this.data._id,new Eht.Responder({success:function(){
					 marker.remove();
				 }}));
			 });
		 mi.data = marker.data;
		 markerMenu.addItem(mi);
		 marker.addContextMenu(markerMenu);//给标记添加右键菜单
	}
</script>