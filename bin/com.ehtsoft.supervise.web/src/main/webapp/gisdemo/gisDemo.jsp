<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>矫正人员监管平台</title>
<link href="css/layout.css" type="text/css" rel="stylesheet">
<!--新加引用start-->
<link   href="./other/images/index.css" rel="stylesheet" type="text/css"/>
<jsp:include page="../module/comm-script.jsp"></jsp:include>
<%--
<script type="text/javascript" src="./other/js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="jquery/eht.rmi.json.js"></script>
<script type="text/javascript" src="jquery/jquery-myplugin.js"></script>
<script type="text/javascript" src="jquery/eht.ui.utils.js"></script>
<script type="text/javascript" src="jquery/eht.ui.alert.js"></script>
<script type="text/javascript" src="jquery/eht.rmi.responder.js"></script>
--%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=eBcmZoBfRi9MGENgw2tmmLMI8tYr7rYS"></script>
<script type="text/javascript" src="../json/BoundaryService.js"></script>
</head>
<body>
<div id="hd">
    <input type="hidden" id="IsHidden" value="0" />
	  <div class="topic_header">
     <div class="topic_logo">
     </div>
     <div class="icon_group_topic">
             <ul>
                <li class="user_icon_topic"><a href="">刘志红</a></li>
                <li class="logout_icon_topic"><a href="">退出</a></li>
             </ul>
     </div>
     <div class="topic_top_list">
             <ul>
                 <li class="active"><a href="">矫正人员监管平台</a></li>                 
             </ul>
     </div>
  </div>
    <div id="menuLeft" class="left_menu_active"><h3>地图导航</h3></div>
    <div id="menuRight" class="navbar">
	    <span class="fl"></span>
        <ul class="fl">
            <li><a href="#">矫正人员监管平台</a></li>
        </ul>
    </div>
</div>
<div id="bd">
    <div id="boxLeft" class="leftbox">
        <div class="explain">
    	    <ul class="black"><li class="current">矫正人员监管平台</li></ul>
            <div class="pd">
            </div>
        </div>
        <div class="check fl">
    	    <p class="tit mt10 fb">呼和浩特市</p>
            <div class="mt10 name">
                <a href="#">赛罕区</a>
            </div>
        </div>		
    </div>
	<div id="main">
	    <div id="slidbtn" class="slidLeftBtn" onclick="SlidLeft();"></div>
		<div id="map" class="mapContainer"></div>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
	$(function() {
		//添加百度地图
		map = new BMap.Map("map"); // 创建地图实例  
		map.centerAndZoom(new BMap.Point(107.484018, 38.188197), 16);
		//map.centerAndZoom("赤峰市红山区", 15);                 // 初始化地图，设置中心点坐标和地图级别  
		map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
		map.enableScrollWheelZoom(); //启用滚轮放大缩小
		map.addControl(new BMap.MapTypeControl()); //添加地图类型控件
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "road" //设置地图风格为高端黑
		}
		map.setMapStyle(mapStyle);
		var name="内蒙古自治区呼和浩特市新城区";
		getBoundary(name);
		/*var items1 = '107.484018,38.188197;107.487265,38.189289;107.48665,38.190494;107.48435,38.190406;107.482616,38.190129;107.482329,38.189058';
		var pointArray = [];
			for (var i = 0; i < 1; i++) {
				var ply = new BMap.Polygon(items1, {strokeWeight:0.5, strokeColor: "#ff0000"}); //建立多边形覆盖物
				map.addOverlay(ply);  //添加覆盖物
				pointArray = pointArray.concat(ply.getPath());
			}    
		map.setViewport(pointArray);    //调整视野  */
	});
	
	function getBoundary(name){       
		var bdary = new BMap.Boundary();
		bdary.get(name, function(rs){       //获取行政区域
			var count = rs.boundaries.length;   //行政区域的点有多少个
			if (count === 0) {
				alert('未能获取当前输入行政区域');
				return ;
			}
			var boundaryService = new BoundaryService();
          	var pointArray = [];
          	var orgid='150101';
          	var aid='2007181111';
			for (var i = 0; i < count; i++) {
				debugger;
				boundaryService.saveFence(rs.boundaries[i],name,orgid,aid);
				var ply = new BMap.Polygon(rs.boundaries[i], {strokeWeight: 2, strokeColor: "#ff0000"}); //建立多边形覆盖物
				map.addOverlay(ply);  //添加覆盖物
				pointArray = pointArray.concat(ply.getPath());
			}    
			map.setViewport(pointArray);    //调整视野  
		});   
	}
</script>