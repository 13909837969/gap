<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>公共法律服务平台定位监控系统</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<style type="text/css">
html, body {
	height: 100%;
}
.anchorBL{display:none}
.cle {
	clear: both;
}
a:link {
 text-decoration: none;
}
a:visited {
 text-decoration: none;
}
a:hover {
 text-decoration: none;
}
a:active {
 text-decoration: none;
}
ul li {
	list-style: none;
}

.activity-zhuangt {
	width: 100%;
	height: 100%;
}

.activity-description {
	width: 431px;
	height: 176px;
	background: #f1f1f1;
	border-radius: 5px;
	margin-top: 15px;
}

.activity-description-cent {
	height: 100%;
	position: relative;
}

.activity-description-img {
	width: 6px;
	height: 6px;
	border-radius: 50%;
	background: #f51414;
	position: absolute;
	top: 13px;
	left: 17px;
}

.activity-description-img2 {
	width: 6px;
	height: 6px;
	background: #cf982b;
	border-radius: 50%;
	position: absolute;
	top: 13px;
	left: 17px;
}

.activity-description-time {
	line-height: 32px;
	padding-left: 34px;
	color: #666;
	float: left;
}

.current-state {
	line-height: 32px;
	padding-left: 280px;
	color: #166ced;
}

.activity-description-name {
	height: 34px;
	line-height: 34px;
	font-size: 16px;
	color: #333;
	padding-left: 34px;
}

.active-section {
	width: 320px;
	height: 50px;
	margin-left: 34px;
	margin-top: 10px;
	color: #666;
}

.active-state {
	height: 30px;
	line-height: 30px;
	padding-left: 34px;
	color: #666;
}

.list-group-item {
	height: 49px;
	box-shadow: 1px 0px 3px #999;
}

.list-group-item ul {
	float: left;
	padding: 0px;
}

.list-group-item ul li {
	width: 80px;
	float: left;
	margin: 0px;
	color: #666;
}

.list-group-item ul li span {
	padding-left: 10px;
	color: #666;
}

.nav-tabs1 {
	background: #e9ebee;
	border-radius: 5px;
	height: 40px;
	text-align: center;
	line-height: 32px;
}

.active_card {
	background: #e9ebee;
}

/* 鼠标点击样式 */
.selected {
	text-decoration: none;
	text-align: center;
	width: 107px;
	height: 32px;
	border-radius: 5px 0px 0px 5px;
	line-right: 32px;
	background: #166ced;
	color: #fff;
	font-color: white;
}

.active_li {
	text-decoration: none;
	text-align: center;
	width: 107px;
	height: 32px;
	border-radius: 5px 0px 0px 5px;
	line-right: 32px;
}

.search_input {
	background: #166ced;
	width: 68px;
	height: 47px;
	cursor: pointer;
	margin-top: 0px;
	border-radius: 0px 5px 5px 0px;
}

.modal-backdrop {
	opacity: 0 !important;
	filter: alpha(opacity = 0) !important;
}

#fzlx {
	width: 180px;
	height: 30px;
	position: absolute;
	top: 80px;
	left: 125px;
}

#nav-tabs-style {
	float: left;
	height: 49px;
	margin-left: 1px;
	text-align: center;
	line-height: 22px;
	color: #666;
}

#jtqk_button {
	width: 431px;
	height: 32px;
	border-radius: 5px;
	margin-top: 20px;
	margin-left: 15px;
	margin-bottom: 15px;
	background: #e9ebee;
	padding-left: 0px;
	line-hight: 32px;
	text-align: center;
	line-height: 32px;
}

#jtqk_button li {
	width: 107px;
	height: 32px;
	float: left;
	margin-right: 1px;
	display: block;
	text-align: center;
	line-height: 32px;
}

#jtqk_button li a {
	float: left;
	color: #666;
	text-align: center;
	line-height: 32px;
}

#jtqk_button li:hover {
	background: #166ced;
	text-align: center;
	display: block;
	line-height: 32px;
	transition: all 1s;
}

#jtqk_button li a:hover {
	background: #166ced;
	color: #fff;
	transition: all 0.5s linear;
}

.scroll-bar {
	width: 10px;
	height: 382px;
	border-radius: 5px;
	background: #e5e5e5;
	position: absolute;
	top: 0px;
	right: 0px;
}

.scroll-bar1 {
	width: 6px;
	height: 120px;
	border-radius: 5px;
	background: #999;
	position: absolute;
	top: 50px;
	right: 2px;
}

.scroll-bar1:hover {
	background: #686868;
}

#fzlx_gl {
	width: 80px;
	color: #fff;
	background: #ef5350; /*严管      的颜色   偏红色         */
	/*background:#43a047 ;宽松管理      的颜色    */
	/*background:#fb8c00 ;普通管理的颜色     */
	text-align: center;
	line-height: 30px;
	border-radius: 5px;
	position: absolute;
	top: 40px;
	left: 250px;
}

#close_view {
	float: right;
	font-size: 23px;
	color: gray;
	padding-right: 16px;
	margin-top: 13px;
}
/* 滚动条样式 */
.test{
    width: 95%;
    height: 560px;
    float: left;
    border: none;
    overflow :yes
}
.activity-description{
    width: 100%;
    height: 200px;
    margin: 0 auto;
 
}
.test-1::-webkit-scrollbar {/*滚动条整体样式*/
        width: 10px;     /*高宽分别对应横竖滚动条的尺寸*/
        height: 1px;
    }
.test-1::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
        border-radius: 10px;
         -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        background: #535353;
    }
.test-1::-webkit-scrollbar-track {/*滚动条里面轨道*/
        -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        border-radius: 10px;
        background: #EDEDED;
    }
</style>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<script type="text/javascript"
	src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzQdxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AlarmService.js"></script>
<script type="text/javascript"
	src="${localCtx}/json/FootprintService.js"></script>
<script type="text/javascript"
	src="${localCtx}/resources/bootstrap/js/bootstrap-typeahead.js"></script>
<script type="text/javascript" src="${localCtx}/module/sqjz/rpDwjk.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/RichMarker/1.2/src/RichMarker_min.js"></script>
<script type="text/javascript">
	var map;
	var aid;
	//获取所有点的坐标  
	var points = [];
	var moveType = [];
	var typeLx = ""; //检索条件

	//地图中心左边
	var points_center;
	
	/* li点击事件 */
	$(function() {
		$(".jtqk_button_li li").click(function() {
			$(this).siblings('li').removeClass('selected'); // 删除其他兄弟元素的样式
			$(this).addClass('selected'); // 添加当前元素的样式
		});
		Map_init(); //地图
	});
	//地图
	function Map_init() {
		map = new BMap.Map("map_rqdwjk"); // 创建地图实例  
		//  111.712329, 40.832096999999997
		//map.centerAndZoom(new BMap.Point(111.66035052, 40.82831887),11);
		map.centerAndZoom(new BMap.Point(111.66035052, 40.82831887),13);
		//map.centerAndZoom(points[0], 15); // 初始化地图，设置中心点坐标和地图级别  
		//map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
		map.enableScrollWheelZoom(); //启用滚轮放大缩小
		map.addControl(new BMap.MapTypeControl()); //添加地图类型控件
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "water" //设置地图风格为高端黑
		}
		map.setMapStyle(mapStyle);
		//获取所有矫正人员信息
		loadry();
		var today = new Date();
		var day = today.getDate();
		//设置默认查询时间
		if (today.getDate() < 10) {
			day = "0" + today.getDate();
		}
		var todayValue = today.getMonth() + 1;
		if (todayValue < 10) {
			todayValue = "0" + todayValue;
		}
		var currentDate = today.getFullYear() + "-" + todayValue + "-" + day;
		$("#datestr").val(currentDate);
		//自动搜索人员
		autoComplete();
		queryPeople();//默认进入检索一次
	};

	//个人详细列表的点击事件
	//点击活动情况
	function selectHdqk(aid) {
		$(".activity-zhuangt").empty();
		var nodaata = "<div style = 'padding-top: 16%;margin-left: 33%;font-size: 37px;color: #999;'>暂无数据！</div>";
		$(".activity-zhuangt").append(nodaata);
		if (aid == undefined) {
			aid = $("#id").text();
		}
		typeLx = "HD";
		var foot = new FootprintService();
		var id = $("#id").text();
		foot.getFootprintByAid(aid, new Eht.Responder({
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						points.push(new BMap.Point(data[i].lng, data[i].lat));
					}
				}
				drawLine(points);
			}
		}));
	};

	//点击签到情况
	function selectJdqk(aid) {
		$("#jdxxId").empty();
		$("#nodata_view").show();
		typeLx = "QD";
		if (aid == undefined) {
			aid = $("#id").text();
		}
		//初始化默认时间；
		var datestr = $("#datestr").val();
		var signin = new JzQdxxService();
		//以日期作为检索条件
		signin.findQdList({
			"aid" : aid,
			"datestr" : datestr
		}, new Eht.Responder({
			success : function(data) {
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						points.push(new BMap.Point(data[i].lng, data[i].lat));
					}
				}
			}
		}));
		drawLine(points);
	};

	//点击签到情况
	function selectSmqk() {
		typeLx = "SM";
		drawLine();
	};

	//点击心跳情况
	function selectXtqk() {
		typeLx = "XT";
		drawLine();
	};

	//画路线 -- map地图使用
	function drawLine(points) {
		//线路点
		if (points == null || points.length < 1) {
			return;
		}
		map.clearOverlays();
		var datestr = $("#datestr").val();
		if (aid == undefined) {
			aid = $("#id").text();
		}
		var iconQd = new BMap.Icon("mapimg/start.png", new BMap.Size(48, 61));
		var iconZd = new BMap.Icon("mapimg/end.png", new BMap.Size(48, 61));
		//地图中心点移动到起点和终点的中间  
		centerPoint = new BMap.Point(
				(points[0].lng + points[points.length - 1].lng) / 2,
				(points[0].lat + points[points.length - 1].lat) / 2);
		map.panTo(centerPoint);
		map.centerAndZoom(centerPoint, 9);
		//连接所有点显示轨迹
		map.addOverlay(new BMap.Polyline(points, {
			strokeColor : "#005cb5",
			strokeWeight : 3,
			strokeOpacity : 0.8
		}));

		//设置运动头像
		var paths = points.length;
		var peopleIcon = new BMap.Icon(
				"${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&round=true&width=30&height=30&IMGID="
						+ aid, new BMap.Size(30, 30), {
					imageSize : new BMap.Size(30, 30),
					imageOffset : new BMap.Size(0, 0)
				});
		var peopleMarker = new BMap.Marker(points[0], {
			icon : peopleIcon
		});
		map.addOverlay(peopleMarker);
		i = 0;
		function resetMkPoint(i) {
			peopleMarker.setPosition(points[i]);
			if (i < paths) {
				setTimeout(function() {
					i++;
					resetMkPoint(i);
				}, 500);
			}
		}
		setTimeout(function() {
			resetMkPoint(0);
		}, 500)

		//起点
		var pointQd = points[0];
		var markerQd = new BMap.Marker(pointQd, {
			icon : iconQd
		});
		markerQd.setOffset(new BMap.Size(5, -24));
		map.addOverlay(markerQd);
		//终点
		var pointZd = points[points.length - 1];
		var markerZd = new BMap.Marker(pointZd, {
			icon : iconZd
		});
		markerZd.setOffset(new BMap.Size(5, -24));
		map.addOverlay(markerZd);

		//添加运动方式标注
		var sprot_type = "步行";
		for (var i = 0; i < moveType.length; i++) {
			if (moveType[i].type == "car") {
				addCar(moveType[i].point);
				sprot_type= "驾车";
			} else {
				addWalk(moveType[i].point);
				sprot_type= "步行";
			}
		}
		//查询矫正人员重要活动情况
		if (typeLx == "HD" || 1 == 1) {
			var people = new JzJzryjbxxService();
			people.findActivity({"aid" : aid,"datestr" : datestr},
							new Eht.Responder({success : function(ds) {
								if (ds.length > 0) {
									var str = "", j;
				    				var child = $('.activity-zhuangt');
									for (var i = 0; i < ds.length; i++) {
										j = i + 1;
										str += "<div class='activity-description'>";
										str += "<div class='activity-description-cent'>";
										str += "<div class='activity-description-img'></div>";
										str += "<div class='activity-description-time'>";
										str += "<span>"+ds[i].cts+"</span></div>";
										str += "<div class='current-state'>当前状态："+sprot_type+"</div><div class='cle'></div>";
									  	str += "<div class='activity-description-name'>活动描述</div>";
										str += "<div>";
										str += "<div class='active-section'>活动路段：在3.4Km~4.3Km路段测试心跳呼吸频率为骑行状态。</div>";
										str += "<div class='active-state'>活动状态：正常</div>";
										str += "</div></div>";  
										var li = str;
										$(".activity-zhuangt").empty();
				    					child.append(li);
				    					
										var tempp = new BMap.Point(
												ds[i].lng, ds[i].lat);
										addHdMarker(j, tempp,
												ds[i].atype, ds[i]);
									}
								}
									
							}
					}));
		}
		//查询签到信息
		if (typeLx == "QD" || 1 == 1) {
			var signin = new JzQdxxService();
			signin.findQdList({
								"aid" : aid,
								"datestr" : datestr},new Eht.Responder({success : function(ds) {
											if (ds.length > 0) {
												$("#jdxxId").empty();
												var str = "", j;
												for (var i = 0; i < ds.length; i++) {
													j = i + 1;
													var imgurl;
													if (ds[i].qdlx == "1") {
														imgurl = "mapimg/finger.png";
													} else if (ds[i].qdlx == "2") {
														imgurl = "mapimg/voice.png";
													} else if (ds[i].qdlx == "3") {
														imgurl = "mapimg/face.png";
													}
													str = "<div class='list-group-item'><img style='width: 32px; height: 32px; margin-right: 5px;' src='"+imgurl+"'></img>"
															+ ds[i].cts+ "&nbsp;&nbsp;&nbsp; "+ ds[i].jdlxm+"</div>";
													var tempp = new BMap.Point(ds[i].lng,ds[i].lat);
													addQdMarker(j, tempp, ds[i]);
												}
												$("#nodata_view").hide();
												$("#jdxxId").append(str);
											}else{
												$("#jdxxId").empty();
												$("#nodata_view").show();
											}
										}
									}));
			
		}
	};

	//添加car图标marker
	function addCar(point) {
		var carIcon = new BMap.Icon("mapimg/car.png", new BMap.Size(48, 48));
		var carMarker = new BMap.Marker(point, {
			icon : carIcon
		});
		map.addOverlay(carMarker);
	};

	//添加步行图标marker
	function addWalk(point) {
		var walkIcon = new BMap.Icon("mapimg/walk.png", new BMap.Size(48, 48));
		var walkMarker = new BMap.Marker(point, {
			icon : walkIcon
		});
		map.addOverlay(walkMarker);
	};

	//添加签到marker
	function addQdMarker(i, point, item) {
		var qdIcon;
		if (item.qdlx == "1") {
			qdIcon = new BMap.Icon("mapimg/finger_sign.png", new BMap.Size(48,
					70));
		} else if (item.qdlx == "2") {
			qdIcon = new BMap.Icon("mapimg/voice_sign.png", new BMap.Size(48,
					70));
		} else if (item.qdlx == "3") {
			qdIcon = new BMap.Icon("mapimg/face_sign.png",
					new BMap.Size(48, 70));
		}
		var qdMarker = new BMap.Marker(point, {
			icon : qdIcon
		});
		var message = item.jdlxm + "  </br>位置：" + item.qdwz + "</br>时间："
				+ item.cts;
		message = "<span  style='font-size:16px;color:blue;'>" + message
				+ "</span>"
		var infoWindow = new BMap.InfoWindow(message);
		qdMarker.addEventListener("click", function() {
			map.openInfoWindow(infoWindow, point); //开启信息窗口
		});
		map.addOverlay(qdMarker);
	};

	//添加活动情况marker
	function addHdMarker(i, point, atype, item) {
		var hdIcon;
		var message;
		if (atype == "1") {
			hdIcon = new BMap.Icon("mapimg/warn.png", new BMap.Size(48, 48));
			message = item.f_content + "</br>位置：" + item.address + "</br>时间："
					+ item.cts;
			message = "<span  style='font-size:16px;color:red;;'>" + message
					+ "</span>"
		} else {
			if (item.qdlx == "1") {
				hdIcon = new BMap.Icon("mapimg/finger_sign.png", new BMap.Size(
						48, 70));
			} else if (item.qdlx == "2") {
				hdIcon = new BMap.Icon("mapimg/voice_sign.png", new BMap.Size(
						48, 70));
			} else if (item.qdlx == "3") {
				hdIcon = new BMap.Icon("mapimg/face_sign.png", new BMap.Size(
						48, 70));
			}

			message = item.jdlxm + "  </br>位置：" + item.address + "</br>时间："
					+ item.cts;
			message = "<span  style='font-size:16px;color:blue'>" + message
					+ "</span>"
		}
		var hdMarker = new BMap.Marker(point, {
			icon : hdIcon
		});
		var infoWindow = new BMap.InfoWindow(message);
		hdMarker.addEventListener("click", function() {
			map.openInfoWindow(infoWindow, point); //开启信息窗口
		});
		map.addOverlay(hdMarker);
	};

	//显示所有人员
	function loadry() {
		//清空当前地图信息
		var fp = new FootprintService();
		//获取所有的人员信息
		fp.getLastLocations(new Eht.Responder({
			success : function(items) {
				//从后台返回的数据 rows
				if (items != null) {
					for (var i = 0; i < items.length; i++) {
						addRyMarker(items[i]);
					}
				}
			}
		}));
	};

	//根据姓名查询人员
	function queryPeople() {
		map.clearOverlays();
		//清空当前地图信息
		var fp = new FootprintService();
		var pName = $("#searchWords").val();

		if (pName != null && pName.trim() != "") {
			var arr = pName.split(' ');
			pName = arr[0];
		}
		//获取所有的人员信息
		fp.getAllPeopleLocations({
			"name[like]" : pName,
			"flag[eq]" : 1
		}, new Eht.Responder({
			success : function(items) {
				//从后台返回的数据 rows
				console.log("Get data:" + items.length);
				if (items != null) {
					for (var i = 0; i < items.length; i++) {
						addRyMarker(items[i]);
					}
				}
			}
		}));
	};

	//增加人员位置
	function addRyMarker(item) {
		aid = item.aid;
		var point = new BMap.Point(item.lng, item.lat)
		var marker = new BMap.Marker(point);
		var myIcon;
		var url = "mapimg/man11.png";
		var gender = "男";
		if (item.gender != null && item.gender == '2') {
			url = "mapimg/woman11.png";
			gender = "女";
		}

		myIcon = new BMap.Icon(url, new BMap.Size(35, 55), {
			imageSize : new BMap.Size(35, 55)
		});
		/* myIcon = new BMap.Icon(
				"${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&round=true&width=58&height=58&IMGID="
						+ aid, new BMap.Size(58, 58), {
					imageSize : new BMap.Size(58, 58)
		}); */

		var marker = new BMap.Marker(point, {
			icon : myIcon
		});

		map.addOverlay(marker);

		var sContent = "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"
				+ item.name
				+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ gender
				+ "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>"
				+ item.address + "</p>"
				+ "<p><input type='hidden' value='"+item.aid+"'/></p>";
		var opts = {
			offset : new BMap.Size(0, -30)
		};
		var infoWindow = new BMap.InfoWindow(sContent, opts);
		marker.addEventListener("mouseover", function() {
			map.openInfoWindow(infoWindow, point); //开启信息窗口
		});

		marker.addEventListener("mouseout", function() {
			map.closeInfoWindow(infoWindow, point); //开启信息窗口
		});

		//点击查询【修改处】
		marker.addEventListener("click", function() {
			clickPeople(item.aid);
		});

	};

	//检索事件处理【个人】
	function clickPeople(aid) {
		//默认记载活动情况
		selectHdqk(aid);
		selectJdqk(aid);
		
		//设置
		$("#selectHdqk").addClass('selected');
		$("#selectJdqk").removeClass('selected');
		$("#selectSmqk").removeClass('selected');
		$("#selectXtqk").removeClass('selected');
		if (aid == undefined) {
			aid = $("#id").text();
		}
		points = [];
		//加载活动情况
		//map.clearOverlays();
		//初始化默认时间；
		var datestr = $("#datestr").val();
		//查询矫正人员详细信息；
		var people = new JzJzryjbxxService();
		var view = new Eht.View({
			selector : "#dwjk_jbxxview"
		});
		people.findDetail(aid, new Eht.Responder({
			success : function(ds) {
				view.fill(ds);
				//头像处理
				$("#imgId").attr(
						"src",
						"${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&IMGID="
								+ ds.id);
			}
		}));
		//查询人员轨迹；
		var hdsc = 0; //活动时长
		var ydcd = 0; //总运动时长
		var ydbs = 0; //总运动步数
		var floor = 0; //已爬楼层
		var speed = 0;
		var preSpeed;
		var tempMove = {};
		var foot = new FootprintService();
		var temp;
		foot.getFootprintList({
							"aid" : aid,
							"datestr" : datestr
						},new Eht.Responder({
									success : function(ds) {
										$("#floorId").html("");
										for (var i = 0; i < ds.length - 1; i++) {
											temp = new BMap.Point(ds[i].lng,
													ds[i].lat);
											ydcd = ydcd + ds[i].distance;
											ydbs = ydbs + ds[i].step;
											if (ds[i].floor > 0) {
												var str = "<div class='list-group-item'>";
												str += "<img style='width: 32px; height: 32px; margin-right: 5px;' ";
	                    str += " src='mapimg/height.png'></img>"
														+ ds[i].address
														+ "&nbsp;&nbsp;&nbsp; 楼层："
														+ ds[i].floor + "层。";
												str += "</div>";
												$("#floorId").append(str);
											}

											floor = floor + ds[i].floor;
											speed = ds[i].speed;
											tempMove = {};
											if (speed > 1 && preSpeed != "car") {
												preSpeed = "car";
												tempMove.type = "car";
												tempMove.point = temp;
												moveType.push(tempMove);
											} else if (speed < 1
													&& preSpeed != "walk") {
												preSpeed = "walk";
												tempMove.type = "walk";
												tempMove.point = temp;
												moveType.push(tempMove);
											} else if (i == 0 && speed > 1) {
												preSpeed = "car";
												tempMove.type = "car";
												tempMove.point = temp;
												moveType.push(tempMove);
											} else if (i == 0 && speed < 1) {
												preSpeed = "walk";
												tempMove.type = "walk";
												tempMove.point = temp;
												moveType.push(tempMove);
											}
											points.push(temp);
										}
										//设置总运动时长
										$("#zydcd").html(ydcd.toFixed(2));
										$("#zydbs").html(ydbs);
										$("#floor").html(floor);
									}
								}));
										drawLine(points);
		//显示右边弹出div
		$('#jzrydetailid').show().animate({
			width : 510
		});

	};

	//隐藏DIV
	function hidenDiv() {
		//显示右边弹出div
		$('#jzrydetailid').hide().animate({
			width : 0
		});
	};

	//矫正档案
	function jzrydetail() {
		$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		});
		//传值aid
		var id = $("#id").text();
		$("#modal-body #iframe").attr("src",
				"${localCtx}/module/sqjz/viewGrdagl.jsp?id=" + id);
	};

	//获取所有的人员信息
	function autoComplete() {
		jQuery('#searchWords').typeahead({
			source : function(query, process) {
				var names = [];
				if (query == "") {
					return;
				}
				query = query.trim();
				var fp = new FootprintService();
				fp.getAllPeopleLocations({
					"name[like]" : query,
					"flag[eq]" : 1
				}, new Eht.Responder({
					success : function(items) {
						if (items != null) {
							for (var i = 0; i < items.length; i++) {
								names.push(items[i].name);
							}
							process(items);//调用处理函数，格式化
						}
					}
				}));
			},
			updater : function(item) {
				return item;
			},
			displayText : function(item) {
				return item.name + '   位置：' + item.address;
			},
			matcher : function(item) {
				return item.name;
			},
			afterSelect : function(item) {
				map.centerAndZoom(new BMap.Point(item.lng, item.lat), 19);
				map.clearOverlays();
				addRyMarker(item);
				return item.name;
			},
			items : 10, //显示10条
			delay : 500
		//延迟时间
		});
	};

	//爬楼详情
	function floorDetail() {
		$("#floorModal").modal({
			backdrop : 'false',
			keyboard : false
		});
	};
	//关闭右侧的视图
	function close_view_ringht() {
		queryPeople();
		hidenDiv();
		Map_init(); //地图
	};
</script>
</head>
<body>
	<div id="map_rqdwjk" style="width: 100%; height: 100%;"></div>
	<div id="jzrydetailid" class="panel"
		style="position: absolute; top: 0px; right: 0px; bottom: 5px; width: 0px; height: 100%; background: #fff; border-radius: 0px; display: none;">
		<div id="close_view">
			<a href="#" title="关闭"><img style="height: 32px; width: 32px;"
				onclick="close_view_ringht()" src="mapimg/close.png"></img></a>
		</div>
		<div class="container" style="width: 505px;">
			<form class="navbar-form navbar-left">
				<div class="form-group">
					<!-- <a ><img   style="height:32px;width:32px;"  onclick="hidenDiv()" src="mapimg/hide.png"></img></a> -->
					<div class="input-group input-group-sm">
						<input type="text" id="datestr" class="form-control form_date">
					</div>
					<a href="#panel-1" data-toggle="tab" onclick="clickPeople()"
						class="btn btn-default  btn-sm"
						style="width: 64px; margin-left: 10px; background: #166ced; color: #fff; border: none;">查询</a>
				</div>
			</form>
			<div class="row clearfix">
				<div class="col-md-12 column">
					<table width="80px;">
						<tr height="100px;">
							<td rowspan="2"><img id="imgId" src="mapimg/user.jpg"
								style="width: 70px; height: 90px; margin: 10px 10px 10px 14px; border-radius: 5px;"
								class="img-rounded"></td>
							<td valign="top">
								<table id="dwjk_jbxxview"
									style="width: 300px; margin-left: 20px; font-size: 14px;">
									<tr height="48px;">
										<td style="display: none;" id="id" field="id" width="84px">id:</td>
										<td id="xm" field="xm" width="84px">姓名：</td>
										<td id="xb" field="xb" code="SYS000" width="80px">性别：</td>
										<td id="mz" field="mz" code="SYS003"></td>
										<div id="fzlx" field="fzlx">犯罪类型：</div>
									</tr>
									<tr>
										<td>电话：</td><td id="grlxdh" field="grlxdh"></td>
										<td id="fzlx" field="fzlx" code="SYS014"></td>
										<div id="fzlx_gl" field="fzlx_gl"></div>
										<!-- 这条属性从后台传输进来严管宽松严管 -->
									</tr>
								</table>
							</td>
							<td style="marging-top: 50px;">
								<button id="fat-btn" class="btn btn-default"
									onclick="jzrydetail()"
									style="background: #166ced; color: #fff; border: none; position: absolute; left: 380px; margin-top: 15px;">矫正档案</button>
							</td>
						</tr>
					</table>
					<div class="tabbable1" id="1tabs-139389">
						<ul id="jtqk_button" class="jtqk_button_li">
							<li class="selected" id="selectHdqk" style="margin-left: 0px; border-radius: 5px 0px 0px 5px; color: #fff;">
								<a href="#panel-1" data-toggle="tab" onclick="selectHdqk()"  class="active_li">活动情况</a>
							</li>
							<li id="selectJdqk" >
								<a href="#panel-2" data-toggle="tab" onclick="selectJdqk()" class="active_li">签到情况</a></li>
							<li id="selectSmqk">
								<a href="#panel-3" data-toggle="tab" onclick="selectSmqk()" class="active_li">睡眠监控</a></li>
							<li id="selectXtqk" style="border-radius: 0px 5px 5px 0px; margin-right: 0px;">
								<a href="#panel-4" data-toggle="tab" class="active_li" onclick="selectXtqk()">心跳检测</a>
							</li>
						</ul>
						<div class="tab-content" style="height: 98%;">
							<!-- 活动情况 S -->
							<div class="tab-pane  active" id="panel-1">
								<div class="col-md-12 column"
									style="padding-left: 15px; padding-right: 1px; height: 50px; margin-bottom: 20px;">
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总时长</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总长度</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总步数</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="vertical-align: middle; width: 105px; height: 50px; border: none; background: #e9ebee; color: #666; margin: 0;">
										<span style="color: #166ced;">提升高度</span> <br> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div class="list-group" id="actId" style="margin-left: -14px;"></div>
									<!-- 活动情况 2 S -->
									<div class="test test-1">
										<div class="activity-zhuangt">
										       <div class="activity-description" ></div>
										</div>
									</div>
									<!-- 活动情况 2 E -->
									<!-- 活动描述结束 -->
								</div>
							</div>
							<!-- 活动情况 E -->
							<!-- 签到情况 S -->
							<div class="tab-pane" id="panel-2">
								<div class="list-group" id="jdxxId" style="margin-top: 8px;">
								</div>
									<div id="nodata_view">
										<img alt="" src="mapimg/no_data.png" style="width: 100%">
									</div>
							</div>
							<!-- 签到情况 E -->
							<!-- 睡眠情况 S -->
							<div class="tab-pane" id="panel-3">
								<div class="col-md-12 column">
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px; height: 60px;">
										浅睡眠时长<br>4h
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px; height: 60px;">
										睡眠时长<br>5h
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px;; height: 60px;">
										深睡眠时长<br>6h
									</div>
									<div class="list-group"
										style="margin-left: -14px; overflow: hidden; height: 100%;">
										<div id="smsdChar"
											style="width: 460px; height: 135px; background: #f00;"></div>
									</div>
									<div class="list-group" style="margin-left: -14px;">
										<div id="smsyChar" style="width: 460px; height: 135px;"></div>
									</div>
								</div>
							</div>
							<!-- 睡眠情况 E -->
							<!-- 心跳情况 S -->
							<div class="tab-pane" id="panel-4">
								<div class="col-md-12 column">
									<div style = 'padding-top: 16%;margin-left: 33%;font-size: 37px;color: #999;'>暂无数据！</div>
								</div>
							</div>
							<!-- 心跳情况 E -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="queryId"
		style="position: absolute; top: 5px; width: 0px; background: #fff;">
		<div class="container" style="width: 500px;'">
			<form class="navbar-form navbar-left">
				<div class="col-lg-6">
					<div class="input-group">
						<input type="text" class="form-control" autocomplete="off"
							id="searchWords" name="searchWords" data-provide="typeahead"
							data-items="10"
							style="color: #e0e0e0; width: 322px; height: 47px; box-shadow: 1px 0px 3px #999; border: none; border-radius: 5px 0px 0px 5px;"
							placeholder="请输入姓名/手机号/身份证号进行搜索"> <span
							class="input-group-btn">
							<button class="search_input"
								style="width: 53px; height: 47px; border: 0; box-shadow: 1px 0px 3px #999;"
								type="button" onclick="queryPeople()">
								<img src="../rep/images/search.png" />
							</button>
						</span>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div id="marker"
		style="position: absolute; bottom: 20px; width: 0px; background: #fff;">
		<div
			style="margin: 2px; width: 100px; height: 208px; width: 530px; height: 43px; float: left;">
			<div class="list-group-item">
				<ul>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;" src="../rep/images/bus.png" />
							<span>公交车</span>
					</a></li>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;" src="../rep/images/riding.png" />
							<span>骑行</span>
					</a></li>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;" src="../rep/images/walk.png" />
							<span>步行</span>
					</a></li>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;"
							src="../rep/images/starting_point.png" /> <span>起点</span>
					</a></li>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;" src="../rep/images/end.png" />
							<span>终点</span>
					</a></li>
					<li><a href="#" style="text-decoration: none;"> <img
							style="width: 15px; height: 14px;"
							src="../rep/images/residence.png" /> <span>住所</span>
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- 矫正档案 S -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="height: 92%; width: 660px;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">服刑人员档案</h4>
				</div>
				<div class="modal-body" id="modal-body" style="height: 100%;">
					<iframe id="iframe" width="640px" height="418px;" scrolling="no"
						frameborder="0"> </iframe>
				</div>
			</div>
		</div>
	</div>
	<!-- 矫正档案 E -->
	<div class="modal fade" id="floorModal">
		<div class="modal-dialog"
			style="height: 30%; width: 480px; position: absolute; top: 216px; right: 20px;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">爬升楼层详细列表</h4>
				</div>
				<div class="modal-body" id="modal-body-8">
					<div class="tab-pane" id="panel-8" style="height: 719px;">
						<div class="list-group" id="floorId" style="margin-top: 8px;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
