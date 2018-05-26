<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>矫正人员进入禁区设置</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<!-- \\ -->
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/ProhibitService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SysJzryJrqyService.js"></script>s
<style type="text/css">
#listboundary .nav-tab-content {
	position: absolute;
	width: 100%;
	padding: 5px;
	bottom:0px;
	top:5px;
}
#listboundary #form-jzqy>div{
	margin:5px 0px;
}
.anchorBL img{
	display: none;
}
#jzqy-save-btn{
    position: absolute;
    left: 400px;
    top: 0px;
    height: 30px;
    padding: 5px;
}
.panel-body{
	padding: 0px;
}
</style>
<script type="text/javascript">
$(function(){
	var jz = new JzJzryjbxxService();
	var rs = new RegionService(); 
	var ps = new ProhibitService();
	var sysps = new SysJzryJrqyService();
	var _aid = "";
	var tableView = new Eht.TableView({
		selector:"#form-jzqy"
	});
	//根据人员id查找禁区类型,并将禁区类型给与选中状态
	 tableView.clickRow(function(data){
		_aid = data.id;
		tree2.refresh();
	});
	
	var form = new Eht.Form({selector:"#listJzryjqszForm"});
	
	//初始默认查询矫正人员
	tableView.loadData(function(page,res){
		jz.find(form.getData(),page,res);
	});
	
	//查询按钮查询事件
	$("#selectbtn").click(function(){
		tableView.refresh();
	});
	
	var rightbutton2 = new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_SMALL});
	var mapType2 = new BMap.MapTypeControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT,mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]});
	
	//禁止区域地图
	var point = new BMap.Point(116.331398,39.897445);
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
    
	//禁入区域类型
	var tree2 = new Eht.BootTree({selector:"#listboundary #tree2",labelField:"name",showBorder:false,showCheckbox:true});
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
		sysps.findJzqyls(_aid,res);
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
    
    //禁入区域数据
    var jzqyData = {};
    
    //位置搜索
    $("#listboundary #map-search").keyup(function(e){
    	if(e.keyCode == 13){
    		map2.centerAndZoom(map2.getCenter());
    		localSearch.searchInBounds($(this).val(),map2.getBounds());
    	}
    });
    $("#map-search-spanon").click(function(){
    	map2.centerAndZoom(map2.getCenter());
		localSearch.searchInBounds($("#listboundary #map-search").val(),map2.getBounds());
    });
    
  //保存禁入区域
	$("#listboundary #jzqy-save-btn").click(function(){
		var sdata = tree2.getCheckedData();//获取类型
		var sds = tableView.getSelectedData();//获取人员信息
		if(sds.length==0){
			alert("请选择人员");
		}
		
		if(sdata.length>0){
			sysps.saveJzqy( sds[0].id,sdata,new Eht.Responder({
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
    		//$("#listboundary #jzqy-save-btn").enable();
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
})
//点击人员列表事件
/*  $("#form-jzqy").click(
		function(){
			debugger;
			var aid = tableView.getSelectedData();//获取人员信息
			sysps.findJzqy(aid,	new Eht.Responder({
				success:function(){
					new Eht.Tips().show("aaa");
				}
			}))
		}
		
		)  */


</script>

</head>
<body>
<div id="listboundary">
	<div class="nav-tab-content" id="listboundary_jzqy">
		<div class="panel panel-default" style="position:absolute;bottom:2px;top:0px;width:240px;left: 587px;">
			<div class="panel-heading ltrhao-toolbar">
				<div><label>禁入区域类型</label></div>
			</div>
			<div class="panel-body">
				<div class="row clearfix">
					<div id="tree2"></div>
				</div>
			</div>
		</div>
		 <div class="input-group input-group-sm" style="width:200px;left:838px;z-index:2">
		  <input type="text" class="form-control" id="map-search" placeholder="禁入类型，地址等搜索">
		  <span class="input-group-addon" id="map-search-spanon"><i class="glyphicon glyphicon-search"></i></span>
		</div>
		<div class="panel panel-default" id="listboundary_map2" style="position:absolute;bottom:2px;left:828px;top:0px;right:0px;">
			                                                                 
		</div>
		<div class="panel panel-default" style="position:absolute;bottom:2px;width:583px;top:0px;left:3px;">
			<div class="panel-heading ltrhao-toolbar" id="listJzryjqszForm">
				<input type="text" placeholder="请输入姓名" style="text-align:center;">
				<input type="button" value="查询" id="selectbtn">
				<div class="text-right"><button id="jzqy-save-btn" class="btn btn-primary" >保存</button></div>
			</div>
			<div class="panel-body">
				<div id="form-jzqy">
					<div field="xm" label="姓名" name="xm[like]"></div>
					<div field="xb" label="性别" code="SYS000" name="xb"></div>
					<div field="grlxdh" label="联系电话" name="grlxdh"></div>
					<div field="fzlx" label="犯罪类型" name="fzlx"></div>
					<div field="jtzm" label="具体罪名" code="SYS003" name="jtzm"></div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>