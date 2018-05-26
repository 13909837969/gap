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
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=eBcmZoBfRi9MGENgw2tmmLMI8tYr7rYS"></script>
<script type="text/javascript"
	src="${localCtx}/json/FootprintService.js"></script>
<script type="text/javascript" src="footPrintTest.js"></script>
<style type="text/css">
.mapContainer {
	width: 100%;
	height: 100%;
}

.search_input {
	background: url(../module/sqjz/mapimg/query.png);
	width: 68px;
	height: 36px;
	cursor: pointer;
	margin-top: 0px;
	border: none;
}
</style>
</head>
<style type="text/css">
</style>
<body class="mapContainer">
	<div id="main" class="mapContainer">
		<div id="map" class="mapContainer"></div>
		<div id="queryId"
			style="position: absolute; top: 5px; width: 0px; background: #ffffff;">
			<div class="container" style="width: 500px;'">
				<form class="navbar-form navbar-left">
					<div class="col-lg-6">
						<div class="input-group">
							<input type="text" class="form-control"
								value="47e8c66e-ccb0-493d-984a-d4bebc3c117b" id="aid"
								style="width: 400px; height: 40px; border: 0;"
								placeholder="输入aid进行搜索"> <span class="input-group-btn">
								<button class="search_input"
									style="width: 53px; height: 40px; border: 0;" type="button"
									onclick="queryPeople()"></button>
							</span>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div id="locationId"
			style="position: absolute; top: 100px; left: 30px; width: 0px; background: #ffffff;">
			<div class="container" style="width: 500px;'">
				<textarea rows="10" style="width: 400px;" id="locJson"></textarea>
			</div>
		</div>

		<div class="modal fade" id="floorModal">
			<div class="modal-dialog" style="height: 400px; width: 1000px;">
				<div class="col-md-12 column" style="vertical-align: center;">
					<div class="list-group">
						<a rel="nofollow" href="#" class="list-group-item active">
							<table style="width: 100%; font-size: 20px;">
								<tr>
									<td  class="row"><span style="font-weight: bold; margin-right: 10px;">王晓丹</span>
										兴安南路司法所<span style="background: #1a93d0; margin-left: 10px;"><span
											style="font-weight: bold">5分钟</span> 平均响应时间</span> <span
										style="margin-right: 10px;"></span></td>
										<td  width="100px;">查询时间:</td>
										<td width="150px">
											<div class="input-group input-group-sm">
												<input type="text"  width="100px" id="datestr"
													class="form-control form_date"
													data-date-format="yyyy-MM-dd"> <span
													class="input-group-addon calendar"><span
													class="glyphicon glyphicon-calendar"></span></span>
											</div>
										</td>
										<td  width="150px">
											<div class="input-group input-group-sm" style="margin-left: 10px;">
												<input    type="text"  width="100px"  id="datestr"
													class="form-control form_date"
													data-date-format="yyyy-MM-dd"> <span
													class="input-group-addon calendar"><span
													class="glyphicon glyphicon-calendar"></span></span>
											</div>
										</td>
										<td   >
											<button style="margin-left: 10px;" type="button" onclick="clickPeople()"
												class="btn btn-default  btn-sm">查询</button>
									    </td>
									<td align="right">
										<button type="button" class="close" data-dismiss="modal"
											aria-hidden="false">x</button>
									</td>
								</tr>
							</table>
						</a>
						<div class="list-group-item" >
							<div id="workId" style="height: 400px;width:930px;"></div>
						</div>
					</div>
					<div class="row clearfix">
						<div class="col-md-12 column"></div>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>
<script type="text/javascript">
	var map, num = 0;
	$(function() {
		//添加百度地图
		map = new BMap.Map("map"); // 创建地图实例  
		//map.centerAndZoom(new BMap.Point(118.998103, 42.286232), 16);
		map.centerAndZoom("呼和浩特市", 15); // 初始化地图，设置中心点坐标和地图级别  
		map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		map.enableScrollWheelZoom(); //启用滚轮放大缩小
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "road" //设置地图风格为高端黑
		}
		map.setMapStyle(mapStyle);
	});

	function queryPeople() {
		var aid = $("#aid").val();
		if (aid == "") {
			alert("请输入aid");
			return;
		}
		//清空当前地图信息
		map.clearOverlays();
		var footprintService = new FootprintService();
		//获取居民位置信息
		footprintService.getFootprintByAid(aid, new Eht.Responder({
			success : function(items) {
				//从后台返回的数据 data
				if (items != null) {
					map.centerAndZoom(
							new BMap.Point(items[0].lng, items[0].lat), 18);
					for (var i = 0; i < items.length; i++) {
						addMarker(items[i]);
					}
				}
			}
		}));
	}

	function addMarker(item) {
		var point = new BMap.Point(item.lng, item.lat);
		var icon = new BMap.Icon("../module/sqjz/mapimg/iocn_red.png",
				new BMap.Size(29, 36));
		var marker = new BMap.Marker(point, {
			icon : icon
		});
		map.addOverlay(marker);

		marker.addEventListener("click", function() {
			$("#floorModal").modal({
				backdrop : 'false',
				keyboard : false
			});
			//map.openInfoWindow(infoWindow, point); //开启信息窗口
		});
	}
</script>