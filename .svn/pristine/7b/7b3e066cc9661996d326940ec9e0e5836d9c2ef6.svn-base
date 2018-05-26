<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>边界设置</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<!-- \\ -->
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/DictionaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/ProhibitService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<style type="text/css">
#listboundary .nav-tab-content {
	position: absolute;
	width: 100%;
	padding: 5px;
	bottom:0px;
	top:45px;
}
#listboundary #form-jzqy>div{
	margin:5px 0px;
}
.anchorBL img{
	display: none;
}
</style>

<script type="text/javascript">
	$(function(){
		var bs = new BoundaryService();
		var ds = new DictionaryService();
		var ps = new ProhibitService();
		var rs = new RegionService();
		
		var rightbutton1 = new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL});
		var rightbutton2 = new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL});
		var mapType1 = new BMap.MapTypeControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT,mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
		var mapType2 = new BMap.MapTypeControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT,mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
		//电子围栏地图
		var map1 = new BMap.Map("listboundary_map1");
		map1.addControl(rightbutton1);
		map1.addControl(mapType1);
		var point = new BMap.Point(116.331398,39.897445);
		map1.centerAndZoom(point,8);
		map1.enableScrollWheelZoom(true); 
		
		//禁止区域地图
		var map2 = new BMap.Map("listboundary_map2");
		map2.addControl(rightbutton2);
		map2.addControl(mapType2);
		map2.centerAndZoom(point,18);
		map2.enableScrollWheelZoom(true); 
		//电子围栏数据
		var polygons = [];
		var  polygonOverlays = {};
		var tree1Data = null;
		var lvl = 0;
		
		var opts = {
				  width : 200,     // 信息窗口宽度
				  height: 100,     // 信息窗口高度
				  enableMessage:false,
				}
	    var infoWindow = new BMap.InfoWindow("", opts);  // 创建信息窗口对象 
	    
		//行政区划
		var tree1 = new Eht.BootTree({
					selector:"#listboundary #tree1",
					labelField:"region_name",
					pidField:"parentid",
					pkField:"regionid"});
		tree1.clickItem(function(data,selected){
			if(selected){
				var pd = this.getParentData(data);
				tree1Data = data;
				lvl = data.lvl;
				var searchtxt = pd!=null?pd.text+tree1Data.text : tree1Data.text;
				var pos = polygonOverlays[data.parentid];
				console.log(data.regionid);
				if("150628" == data.regionid){
					searchtxt = "内蒙古自治区鄂尔多斯康巴什";
				}
				if("152528" == data.regionid){
					searchtxt = "内蒙古自治区镶黄旗";
				}
				bs.findBoundary(data.regionid,null,new Eht.Responder({
					success:function(data){
						if(data.length>0){
							polygons = data[0].boundary;
							getBoundary(searchtxt,tree1Data.regionid,pos,polygons);
						}else{
							getBoundary(searchtxt,tree1Data.regionid,pos,null);
						}
					}
				}));
			}
		});
		tree1.loadData(function(res){
			rs.find({},res);
		});
		//禁入区域类型
		var tree2 = new Eht.BootTree({selector:"#listboundary #tree2",labelField:"name",showBorder:false});
		var polygonMap = {};
		tree2.clickItem(function(data,selected){
			if(selected){
				jzqyData.enable = "1";
				if(polygonMap[data.code]==null){
					ps.find(data.code,new Eht.Responder({
						success:function(data){
						var vs = [];
						var type = null;
						for(var i=0;i<data.length;i++){
							var sColor = "#ff0000";
							var fColor = "#ff0000";
							if(data[i].enable=="0"){
								sColor = "#0000ff";
								fColor = "#0000ff";
							}
							//绘制多边形
							var overlay = new BMap.Polygon(data[i].polygon,
								{strokeWeight: 3, 
								 strokeColor:sColor,
								 fillColor:fColor,
								 fillOpacity: 0.16, strokeOpacity: 0.8
								 }); 
							
							overlay.myData = data[i];
							type = overlay.myData.type;
							map2.addOverlay(overlay);  //添加覆盖物
							
							addOverlayClick(overlay);
							vs.push(getCenterPoint(data[i].polygon));
						}
						if(vs.length>0){
							polygonMap[type] = vs;
							map2.setViewport(vs);
						}
					}}));
				}else{
					map2.setViewport(polygonMap[data.code]);
				}
			}
		});
		tree2.loadData(function(res){
			ds.findDictionarys("SYS101",res);
		});
		
		//当前位置定位
		var geolocation = new BMap.Geolocation();
		//根据坐标获取地址信息
		var geoc = new BMap.Geocoder();
		/***************
		* 禁止区域
		****************/
		var form2 = new Eht.Form({selector:"#listboundary #form-jzqy"});
		var overlays = []; //禁止区域块
	
		
		geolocation.getCurrentPosition(function(r){
			if(this.getStatus() == BMAP_STATUS_SUCCESS){
				var mk1 = new BMap.Marker(r.point);
				var mk2 = new BMap.Marker(r.point);
				map1.addOverlay(mk1);
				map1.panTo(r.point);
				map2.addOverlay(mk2);
				map2.panTo(r.point);
				
			}else{
				alert('failed'+this.getStatus());
			}        
		},{enableHighAccuracy: true});
		
	    var styleOptions = {
		        strokeColor:"red",    //边线颜色。
		        fillColor:"red",      //填充颜色。当参数为空时，圆形将没有填充效果。
		        strokeWeight: 3,       //边线的宽度，以像素为单位。
		        strokeOpacity: 0.8,	   //边线透明度，取值范围0 - 1。
		        fillOpacity: 0.16,      //填充的透明度，取值范围0 - 1。
		        strokeStyle: 'solid' //边线的样式，solid或dashed。
		    }
		//实例化鼠标绘制工具
	    var drawingManager = new BMapLib.DrawingManager(map2, {
	        isOpen:false, //是否开启绘制模式
	        enableDrawingTool: true, //是否显示工具栏
	        drawingToolOptions: {
	            anchor: BMAP_ANCHOR_TOP_RIGHT, //位置
	            offset: new BMap.Size(5, 5), //偏离值
	            drawingModes: [
					BMAP_DRAWING_CIRCLE,
					BMAP_DRAWING_POLYGON,
					BMAP_DRAWING_RECTANGLE
				]
	        },
	        circleOptions: styleOptions, //圆的样式
	        polylineOptions: styleOptions, //线的样式
	        polygonOptions: styleOptions, //多边形的样式
	        rectangleOptions: styleOptions //矩形的样式
	    }); 
	    //禁入区域数据
	    var jzqyData = {};
	    //绘制工具
	    drawingManager.addEventListener('overlaycomplete', function(e){
	    	overlays.push(e.overlay);
	    	$("#listboundary #jzqy-save-btn").enable();
	    	e.overlay.myData = jzqyData;
	    	var pts = e.overlay.getPath();
	    	jzqyData._id = Eht.Utils.createUuid();
	    	jzqyData.polygon = pts;
	    	
	    	var pt = pts[0];
	    	//获取画图位置的地址信息
	    	geoc.getLocation(pt, function(rs){
		    	if(rs!=null){
		    		jzqyData.address = rs.address;
		    		form2.fill(jzqyData);
	    		}
    		});  
	    	drawingManager.close();
		    addOverlayClick(e.overlay);
		    $("#form-jzqy-name").val("");
	    	$("#form-jzqy-name").focus();
	    });
	    //切换 tab
		$("#listboundary .nav>li").click(function(){
			$("#listboundary .nav>li").removeClass("active");
			$(this).addClass("active");
			$("#listboundary .nav-tab-content").hide();
			$($(this).attr("href")).show();
		});
		var localSearch = new BMap.LocalSearch(map2,  {
			renderOptions:{map: map2,autoViewport:true}
		});
	    //位置搜索
	    $("#listboundary #map-search").keyup(function(e){
	    	if(e.keyCode == 13){
	    		map2.centerAndZoom(map2.getCenter());
	    		localSearch.searchInBounds($(this).val(),map2.getBounds());
	    		//localSearch.search($(this).val());
	    	}
	    });
	    $("#map-search-spanon").click(function(){
	    	map2.centerAndZoom(map2.getCenter());
    		localSearch.searchInBounds($("#listboundary #map-search").val(),map2.getBounds());
	    	//localSearch.search($("#listboundary #map-search").val());
	    });
		//保存边界数据
		$("#listboundary #savebtn").click(function(){
			var dd = {};
			dd.regionid = tree1Data.regionid;
			dd.region_name = tree1Data.region_name;
			dd.lvl = lvl;
			dd.parentid = tree1Data.parentid;
			bs.saveBoundary(polygons,dd,new Eht.Responder({success:function(){
				new Eht.Tips().show("边界设置成功");
			}}))
		});
		//保存禁入区域
		$("#listboundary #jzqy-save-btn").click(function(){
			var sdata = tree2.getSelectedData();
			if(sdata.length>0){
				var jdata = form2.getData();
				jdata.type = sdata[0].code;
				ps.save(jdata,new Eht.Responder({
					success:function(){
						new Eht.Tips().show("禁入区域设置成功");
					}
				}));
			}else{
				alert("请选择进入区域类型");
			}
		});
		function addOverlayClick(overlay){
				//右键删除
		    	rightClickHanlder(overlay);
				overlay.addEventListener("click",function(obj){
					var mdata = obj.target.myData;
					form2.fill(obj.target.myData);
		    		overlays.forEach(function(o){
			    		o.setFillColor("red");
			    	});
		    		obj.target.setFillColor("#00f");
		    		var p = getCenterPoint(obj.target.getPath());
		    		infoWindow.setTitle(mdata.name);
		    		infoWindow.setContent(
		    				"地址:"+ mdata.address +
		    				"<br>说明：" + mdata.remark +
		    				"<br>状态：" + (mdata.enable=="1"?"<span style='color:#f00;'>启用</span>":"<span style='color:#00f;'>关闭</span>"));
		    		map2.openInfoWindow(infoWindow,p); //开启信息窗口
		    		$("#listboundary #jzqy-save-btn").enable();
	    	});
		}
		function getBoundary(text,code,parentOverlay,plyss){   
			if(boundaryOverlays(code,parentOverlay)==false){
				var bdary = new BMap.Boundary();
				if(plyss==null){
					bdary.get(text, function(rs){       //获取行政区域
						//边界数据 lng,lat; 
						polygons = rs.boundaries;
						//map1.clearOverlays();        //清除地图覆盖物       
						drawbun(parentOverlay,polygons,code);
					});
				}else{
					drawbun(parentOverlay,plyss,code);
				}
			}
		}
		
		function drawbun(parentOverlay,plyss,code){
			$("#listboundary #savebtn").enable();
			var parray = []
			if(parentOverlay!=null){
				for(var i=0;i<parentOverlay.length;i++){
					parray = parray.concat(parentOverlay[i].getPath());
				}
			}
			var pointArray = [];
			var count = plyss.length; //行政区域的点有多少个
			if (count === 0) {
				alert('未能获取当前输入行政区域');
				return;
			}
			for (var i = 0; i < count; i++) {
				var ply = new BMap.Polygon(plyss[i], {strokeWeight: 2, strokeColor: "#ff0000"}); //建立多边形覆盖物 81bbec
				map1.addOverlay(ply);  //添加覆盖物
				ply.id = code;
				if(polygonOverlays[code]==null){
					polygonOverlays[code] = [ply];
				}else{
					polygonOverlays[code].push(ply);
				}
				if(parray.length==0){
					pointArray = pointArray.concat(ply.getPath());
				}
				ply.setFillColor("#ff0000");
				ply.setFillOpacity(0.27);
			}    
			if(parray.length==0){
				map1.setViewport(pointArray);    //调整视野  
			}else{
				map1.setViewport(parray);
			}
		}
		
		function boundaryOverlays(code,parentOverlay){
			var parray = []
			if(parentOverlay!=null){
				for(var i=0;i<parentOverlay.length;i++){
					parray = parray.concat(parentOverlay[i].getPath());
				}
			}
			var rtn = false;
			//var pas = [];
			for(var k in polygonOverlays){
				var polys = polygonOverlays[k];
				for(var i=0;i<polys.length;i++){
					o = polys[i];
					if(o.id == code){
						rtn = true;
						o.setFillColor("#ff0000");
						o.setFillOpacity(0.27);
						//pas = pas.concat(o.getPath());
					}else{
						o.setStrokeWeight(1);
						o.setStrokeColor("#0000ff");
						o.setFillColor("#81bbec");
						o.setFillOpacity(0.27);
					}
				}
			}
			if(parentOverlay!=null){
				for(var i=0;i<parentOverlay.length;i++){
					var po = parentOverlay[i];
					po.setFillColor("#ff5555");
					po.setStrokeColor("#fd0000");
					po.setFillOpacity(0.27);
				}
			}
			if(rtn==true){
				map1.setViewport(parray);    //调整视野  
			}
			return rtn;
		}
		function rightClickHanlder(marker){
			var menu = new BMap.ContextMenu();
			 var markerMenu=new BMap.ContextMenu();
			 markerMenu.addItem(new BMap.MenuItem('删除',function(e,e2,marker){
				marker.remove();
			 }));
			 marker.addContextMenu(markerMenu);//给标记添加右键菜单
		}
		function getCenterPoint(path){
			var x = 0.0;
			var y = 0.0;
	        for(var i=0;i<path.length;i++){
	             x=x+ parseFloat(path[i].lng);
	             y=y+ parseFloat(path[i].lat);
	        }
			x=x/path.length;
			y=y/path.length;
			return new BMap.Point(x,y);
		}
	});
</script>
</head>
<body>
<div id="listboundary">
	<ul class="nav nav-tabs">
		<li href="#listboundary_dzwl" index="0" class="active"><a>电子围栏设置</a></li>
		<li href="#listboundary_jzqy" index="1"><a>禁止区域设置</a></li>
	</ul>
	<div class="nav-tab-content" id="listboundary_dzwl">
		<div class="panel panel-default" style="position:absolute;bottom:2px;top:0px;width:240px;">
			<div class="panel-heading ltrhao-toolbar">
				<div class="control-group">
					<div class="btn-group">
						<input class="btn btn-default btn-sm" type="button" id="savebtn" disabled="disabled"
								value="保存">
					</div>
				</div>
			</div>
			<div class="panel-body" style="bottom: 0px;position: absolute;top:38px;overflow: auto;right:0px;left:0px;">
				<div class="row clearfix">
					<div id="tree1"></div>
				</div>
			</div>
		</div>
		<div class="panel panel-default" id="listboundary_map1" style="position:absolute;bottom:2px;left:248px;top:0px;right:3px;">
			
		</div>
	</div>
	<div class="nav-tab-content" id="listboundary_jzqy" style="display:none;">
		<div class="panel panel-default" style="position:absolute;bottom:2px;top:0px;width:240px;">
			<div class="panel-heading ltrhao-toolbar">
				<div><label>禁入区域类型</label></div>
			</div>
			<div class="panel-body">
				<div class="row clearfix">
					<div id="tree2"></div>
				</div>
			</div>
		</div>
		 <div class="input-group input-group-sm" style="width:200px;left:248px;z-index:2">
		  <input type="text" class="form-control" id="map-search" placeholder="禁入类型，地址等搜索">
		  <span class="input-group-addon" id="map-search-spanon"><i class="glyphicon glyphicon-search"></i></span>
		</div>
		<div class="panel panel-default" id="listboundary_map2" style="position:absolute;bottom:2px;left:248px;top:0px;right:336px;">
			
		</div>
		<div class="panel panel-default" style="position:absolute;bottom:2px;width:330px;top:0px;right:3px;">
			<div class="panel-heading ltrhao-toolbar">
				<div><label>禁入区域描述</label></div>
			</div>
			<div class="panel-body">
				<div id="form-jzqy">
					<div class="form-group">
						<span>禁区名称</span>
						<input type="text" name="name" class="form-control" id="form-jzqy-name">
					</div>
					<div class="form-group">
						<span>禁区地址</span>
						<input type="text" name="address" class="form-control"/>
					</div>
					<div class="form-group">
						<span>禁区说明</span>
						<textarea name="remark" style="width:100%;height:100px;resize:none;" class="form-control"></textarea>
					</div>
					<div class="input-group">
						<input type="checkbox" name="enable" value="1" else="0" id="jrqy_enable">
						<label style="font-style: normal;margin-left:10px;" for="jrqy_enable">启用</label>
					</div>
					<div class="text-center"><button id="jzqy-save-btn" class="btn btn-primary" disabled="disabled">保存</button></div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>