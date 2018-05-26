var map;
var points = [];
var tv_table_ltrhao;
$(function(){
	 tv_table_ltrhao = new Eht.TableView({selector:"#jzryhdxxlist",paginate:null});
	var cacheData = {};
	var jzryjbxxId;
	var repjzry = new RepJzryService();
	var res1 =  new Eht.Responder();
	res1.success=function(data){
		var total = data.total;
		total = 14302;
		var pgs = data.pgs;
		pgs = total - data.kgs - data.ygs;
		
		$("#ltrhao-jzryzs-val").html(total);
		$("#ltrhao-rysl-kg-val").html(data.kgs);
		$("#ltrhao-rysl-pg-val").html(pgs);
		$("#ltrhao-rysl-yg-val").html(data.ygs);
		var dd = {};
		dd.jzrys = total;
        dd.kgs = data.kgs;
        dd.pgs = pgs;
        dd.ygs = data.ygs;
		cacheData["#ltrhao-city-panel"] = dd;
	};
	
	//闫宇波修改  关闭右侧窗口
	$("#close_view").click(function(){
		$("#jzrydetailid_a").animate({width:0},function(){$(this).hide()});
	});
	
	//默认状态新增矫正人员数量按当月第一天开始
	repjzry.findCount({},res1);
	
	//饼图.....................................................................
	var dom = document.getElementById("container");
	var myChart = echarts.init(dom);
	var app = {};
	var weatherIcons = {
	    'Sunny': './data/asset/img/weather/sunny_128.png',
	    'Cloudy': './data/asset/img/weather/cloudy_128.png',
	    'Showers': './data/asset/img/weather/showers_128.png'
	};
	var option = {
	    title: {
	        left: 'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        // orient: 'vertical',
	        // top: 'middle',
	        bottom: 10,
	        left: 'center',
	        data: ['假释', '缓刑','管制','监外']
	    },
	    series : [
	        {
	            type: 'pie',
	            radius : '65%',
	            center: ['50%', '50%'],
	            selectedMode: 'single',
	            data:[
	                {value:4, name: '假释'},
	                {value:3, name: '缓刑'},
	                {value:4, name: '管制'},
	                {value:15, name: '监外'}
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ],
	    color: ['#0d96ff','#fd8e26','#43a047','#cfe03e'] 
	};
	if (option && typeof option === "object") {
	    myChart.setOption(option, true);
	};
	
	//饼图*******************************结束
	var myChart = echarts.init(document.getElementById('das_mapID'));
	var geoCoordMap = {
		'呼和浩特' : [ 111.66035052, 40.82831887 ],
		'包头' : [ 109.844819, 40.661834 ],
		'乌海' : [ 106.797229, 39.663228 ],
		'赤峰' : [ 118.889196, 42.264889 ],
		'通辽' : [ 122.244198, 43.660276 ],
		'鄂尔多斯' : [ 109.781694, 39.614704 ],
		'呼伦贝尔' : [ 119.766046, 49.219764 ],
		'巴彦淖尔' : [ 107.390374, 40.748703 ],
		'乌兰察布' : [ 113.134294, 41.000966 ],
		'兴安盟' : [ 122.040915, 46.089263 ],
		'锡林郭勒盟' : [ 116.051804, 43.940046 ],
		'阿拉善盟' : [ 105.735018, 38.858529 ]
	};
	var queryqy = "";
	// 每个盟市机构总数和报警总数
	repjzry.findProvince(new Eht.Responder({
		success:function(datas){
			var max = 5000, min = 100;//9; // 根据返回值计算最大最小值
			var maxSize4Pin = 80, minSize4Pin = 40;
			/*
			 * var data = [];
			for(var ii=0;ii<datas.length;ii++){
				var d = {};
				for(var p in datas[ii]){
					d[p] = datas[ii][p];
				}
				d.name = datas[ii].city_name;
				d.value = datas[ii].jzrys;
				
			}
			*/
			var data = [ {
				name : '呼和浩特',
				value : datas[0].jzrys,
				pgs:datas[0].pgs,
				kgs:datas[0].kgs,
				ygs:datas[0].ygs
			}, {
				name : '包头',
				value : datas[1].jzrys,
				pgs:datas[1].pgs,
				kgs:datas[1].kgs,
				ygs:datas[1].ygs
			}, {
				name : '乌海',
				value : datas[2].jzrys,
				pgs:datas[2].pgs,
				kgs:datas[2].kgs,
				ygs:datas[2].ygs
			}, {
				name : '赤峰',
				value : datas[3].jzrys,
				pgs:datas[3].pgs,
				kgs:datas[3].kgs,
				ygs:datas[3].ygs
			}, {
				name : '通辽',
				value : datas[4].jzrys,
				pgs:datas[4].pgs,
				kgs:datas[4].kgs,
				ygs:datas[4].ygs
			}, {
				name : '鄂尔多斯',
				value : datas[5].jzrys,
				pgs:datas[5].pgs,
				kgs:datas[5].kgs,
				ygs:datas[5].ygs
			}, {
				name : '呼伦贝尔',
				value : datas[6].jzrys,
				pgs:datas[6].pgs,
				kgs:datas[6].kgs,
				ygs:datas[6].ygs
			}, {
				name : '乌兰察布',
				value : datas[7].jzrys,
				pgs:datas[7].pgs,
				kgs:datas[7].kgs,
				ygs:datas[7].ygs
			}, {
				name : '兴安盟',
				value : datas[8].jzrys,
				pgs:datas[8].pgs,
				kgs:datas[8].kgs,
				ygs:datas[8].ygs
			}, {
				name : '巴彦淖尔',
				value : datas[9].jzrys,
				pgs:datas[9].pgs,
				kgs:datas[9].kgs,
				ygs:datas[9].ygs
			}, {
				name : '锡林郭勒盟',
				value : datas[10].jzrys,
				pgs:datas[10].pgs,
				kgs:datas[10].kgs,
				ygs:datas[10].ygs
			}, {
				name : '阿拉善盟',
				value : datas[11].jzrys,
				pgs:datas[11].pgs,
				kgs:datas[11].kgs,
				ygs:datas[11].ygs
			} ];
			
			function convertData(data) {
				var res = [];
				for (var i = 0; i < data.length; i++) {
					var geoCoord = geoCoordMap[data[i].name];
					if (geoCoord) {
						res.push({
							name : data[i].name,
							value : geoCoord.concat(data[i].value),
						});
					}
				}
				//[{name:"锡林郭勒盟",value:[lng,lat,value,v2,v3],jgzs:23,jz:43}]
				// 有数据的地区的名称和value值
				return res;
			};
			var option = {
				tooltip : {
					trigger : 'item',
					formatter : function(params) {
						if (typeof (params.value)[2] == "undefined") {
							return params.name + ' : ' + params.value;
						} else {
							return params.name + ' : ' + params.value[2];
						}
					}
				},
				// 加载 bmap 组件
				bmap : {
					// 百度地图中心经纬度
					//闫宇波修改
					center : [105.356155,44.078343 ],
					// 百度地图缩放
					zoom : 6,
					// 是否开启拖拽缩放，可以只设置 'scale' 或者 'move'
					roam : true,
					// 百度地图的自定义样式，见 http://developer.baidu.com/map/jsdevelop-11.htm
					mapStyle : "midnight"
				},
				
				series : [ {
					name : '',
					type : 'scatter',
					coordinateSystem : 'bmap',
					data : convertData(data),
					symbolSize : function(val) {
						var r = val[2]*maxSize4Pin/max/2;
						if(r<minSize4Pin/2){
							r = minSize4Pin/2;
						}
						return r;
					},label : {
						normal : {
							formatter : '{b}',
							position : 'right',
							show : true
						},
						emphasis : {
							show : true
						}
					},
					itemStyle : {
						normal : {
							color : '#05C3F9'//盟市字体颜色
						}
					}
				},
				{
					name : '点',
					type : 'scatter',
					coordinateSystem : 'bmap',
					symbol : 'pin',
					symbolSize : function(val) {
						var a = (maxSize4Pin - minSize4Pin) / (max - min);
						var b = minSize4Pin - a * min;
						b = maxSize4Pin - a * max;
						//返回气球的大小
						return a * val[2] + b;
					},
					label : {//控制显示数量
						normal : {
							show : true,
							textStyle : {
								color : '#fff',
								fontSize : 9,
							}
						}
					},
					itemStyle : {
						normal : {
							color : '#F62157', //地图上红标识的颜色
						}
					},
					zlevel : 6,
					data : convertData(data),
				}		]
			};
		myChart.setOption(option);
		//气球单击事件选择
		myChart.on('click', function (params) {
			$("#viewRepSqjz-right").css("right","-300px").show().animate({right:0});
			 $("#viewRepSqjz-right-biaoti").html(params.name+"矫正人员类别比例");
		});
			
		// 获取百度地图实例，使用百度地图自带的控件
		 map = myChart.getModel().getComponent('bmap').getBMap();
		//map.addControl(new BMap.MapTypeControl());
		var mapStyle = {
			features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
			style : "water" //设置地图风格为高端黑  midnight
		};
		map.setMapStyle(mapStyle);
	
		var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM}    
		map.addControl(new BMap.NavigationControl(opts)); 
		var bs = new BoundaryService();
		bs.findBoundary(2, new Eht.Responder({
			success : function(data) {
				var pointArray = [];
				for (var i = 0; i < data.length; i++) {
					var bounds = data[i].boundary;
					for (var j = 0; j < bounds.length; j++) {
						var ply = new BMap.Polygon(bounds[j], {
							strokeWeight : 2,
							strokeColor : "#212121",
							fillColor : "#292557"
						}); //建立多边形覆盖物 81bbec
						map.addOverlay(ply);
						pointArray = pointArray.concat(ply.getPath());
					}
				}
			}
		})); 
		
		
		//默认隐藏的区域选择
		//区域选择div
		
		$('#spsSqjz-hidenDiv').hide();
		var region = new RegionService();
	
		//显示隐藏的区域选择
		$("#ltrhao-spsSqjz-body-div211").click(function(){
				$("#spssqjz-hidenDiv").css("height","0").show().animate({height:400});
			return false;
		});
		//点击其他地方区域隐藏
		$(window).click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		
		$("#spssqjz-hidenDiv").click(function(){return false;});
		
		//点击确定按钮的时候关闭区域并且提交选择的数据
		$("#spsSqjz-hidenDiv-qd").click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		//关闭按钮
		$("#spsSqjz-hidenDivBtn").click(function(){
			$("#spssqjz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		
		

	   /* 盟市菜单*/
		for(var i=0;i<datas.length;i++){
			var table = $("#ltrhao_city_table"); 
			var tr = $('<tr height="60px" id="'+i+'"class="city-hight" style="vertical-align:middle;">'
					+	'<td width="30px;" class="city-hight"><span id="spanId" class="badge" style="width:35px;height:26px;(i<=3 ? "background:#f00;" : "background:#333;")">'+(i+1)+'</span></td>'
		      		+	'<td align="center"  width="100px;" class="city-hight">'+datas[i].city_name+'</td>'
		      		+	'<td align="center"  width="100px;" class="city-hight">'+datas[i].jzrys+'</td>'
		      		//+	'<td width="50px;" style="padding-left:50px;" class="city-hight"><span class="badge">100%</span></td>'
		      		+	'</tr><hr/>');
			table.append(tr);
			tr.data(datas[i]);
			//设置当前坐标信息为当前也第一个地市坐标
			//map.centerAndZoom(new BMap.Point(111.74631,40.853771), 15);
			//单击盟市
			tr.unbind("click").bind("click",function(){
				var k = $(this).attr("id");
				$("#ltrhao_district_panel").show();
				$("#ltrhao-city-panel").hide();
				$("#ltrhao-jzryzs-val").html(datas[k].jzrys);
				$("#ltrhao-rysl-kg-val").html(datas[k].kgs);
				$("#ltrhao-rysl-pg-val").html(datas[k].pgs);
				$("#ltrhao-rysl-yg-val").html(datas[k].ygs);
				
				$("#spsSqjz-return-sj").show();
				$("#spsSqjz-return-sj").attr("pid","#ltrhao-city-panel");
				cacheData["#ltrhao_district_panel"] = datas[k];
				var table1 = $("#ltrhao_district_table");
				table1.empty();
				//获取旗县数据
				repjzry.findDistrict(datas[k].city_code,new Eht.Responder({
					success:function(data){
						for(var j=0;j<data.length;j++){
							var tr1 = $('<tr height="60px">'
								+	'<td width="30px;" class="city-hight"><span class="badge">'+(j+1)+'</span></td>'
					      		+	'<td align="center"  width="100px;" class="city-hight">'+data[j].district_name+'</td>'
					      		+	'<td align="center"  width="100px;" class="city-hight">'+data[j].qxjzrys+'</td>'
				      		    +	'</tr>');
							tr1.data(data[j]);
							table1.append(tr1);
							//获取旗县的司法所数据
							tr1.unbind("click").bind("click",function(){
								var d = $(this).data();
								$("#spsSqjz-return-sj").attr("pid","#ltrhao_district_panel");
								d.jzrys = d.qxjzrys;
								cacheData["#ltrhao_org_panel"] = d;
								
								$("#ltrhao_org_panel").show();
								$("#ltrhao_district_panel").hide();
								$("#spsSqjz-return-sj").show();
								/*写入矫正人员总数*/
								$("#ltrhao-jzryzs-val").html(d.qxjzrys);
								$("#ltrhao-rysl-kg-val").html(d.kgs);
								$("#ltrhao-rysl-pg-val").html(d.pgs);
								$("#ltrhao-rysl-yg-val").html(d.ygs);
								selectFws(d.district_code);
							});
						}
					}
				}));
			})	
		}
				
			//获取服务所
			function selectFws(district_code) {
				region.findOrgfwjg(district_code,new Eht.Responder({
					success:function(data){
						var table1 = $("#ltrhao_org_table");
						table1.empty();
						for(var j=0;j<data.length;j++){
							
							var tr1 = $('<tr height="50px">'
								+	'<td width="30px;" class="city-hight"><span class="badge">'+(j+1)+'</span></td>'
					      		+	'<td align="center"  width="100px;" class="city-hight">'+data[j].orgname+'</td>'
					      		+	'<td align="center"  width="100px;" class="city-hight">'+data[j].jzrysl+'</td>'
					      		//+	'<td width="50px;" style="padding-left:50px" class="city-hight"><span class="badge">100%</span></td>'
				      		+	'</tr>');
							tr1.data(data[j]);
							table1.append(tr1);
							//单击区县显示各区县的矫正人员数
							tr1.unbind("click").bind("click",function(){
								var d = $(this).data();
								$("#spsSqjz-return-sj").attr("pid","#ltrhao_org_panel");
								cacheData["#ltrhao-org_per-panel"] = d;
								d.jzrys = d.jzrysl;
								$("#ltrhao_org_panel").hide();
								$("#ltrhao-total-head").hide();
								$("#ltrhao_org_per_list").empty();
								$("#ltrhao-org_per-panel").show(function(){
									/*矫正人员总数*/
									$("#ltrhao-jzryzs-val").html(d.jzrysl);
									$("#ltrhao-rysl-kg-val").html(d.kgs);
									$("#ltrhao-rysl-pg-val").html(d.pgs);
									$("#ltrhao-rysl-yg-val").html(d.ygs);
									$("#jzry-ksgl_sl").html(d.kgs);
									$("#jzry-ptgl_sl").html(d.pgs);
									$("#jzry-yggl_sl").html(d.ygs);
								
									selectTj(d.orgid);
								});
							})
						}
					}
				}));
			}
			//根据条件获取区域矫正人员明细
			function selectTj(orgid){
				region.findCount(orgid,new Eht.Responder({
					success:function(data){
						var mycars=new Array();
						for(var i=0; i<data.length;i++){
	
						    var url = Burl+"/image/RMIImageService?_table_name=SYS_FACE_IMG&IMGID="+ data[i].id;
							var table = $('<table  width="70px;"style="margin-left:10px; cursor: pointer;">'+
											'<tr height="70px;">'+
												'<td rowspan="2" style="border-radius:5px;margin-bottom:1px sloid #f00;">'+
											'<img src="'+url+'" '+'style="width: 60px; height:60px;"'+'class="img-rounded" onerror="this.src=\'../rp/img/user.jpg\'"></td>'+
												'<td valign="top">'+
													'<table style="width: 300px; margin-left: 20px; font-size: 16px;color:#fff;">'+
														'<tr height="40px;">'+
															'<td style="width:100px;" id="xm" name="xm"><span>姓名：</span>'+data[i].xm+'</td>'+
															'<td style="width:100px" id="xb" name="xb"><span>性别：</span>'+data[i].xb+'</td>'+
														'</tr>'+
														'<tr>'+
															'<td colspan="2" name="grlxdh" id="grlxdh"><span>联系电话：</span>'+data[i].grlxdh+
															'<td  width="50px;" style="padding-left:50px" class="city-hight" id="dingwei"><a onclick="javascript:rydw(\''+data[i].id+'\');" class="badge" >定位</a></td>'+
														'</tr>'+
													'</table>'+
												'</td>'+
											'</tr>'+
										'</table>');
							$("#ltrhao_org_per_list").append(table);
							table.find(".img-rounded").data(data[i]);
							table.find(".img-rounded").click(function(){
								clickPeople($(this).data().id);
							});
							table.find("#dingwei").data(data[i]);
						}
					}
				}));
				$("#viewRepSqjz-right").show();
				$("#viewRepSqjz-right-biaoti").html(queryqy+"矫正人员类别比例");
			};
			
			
			//点击返回按钮时切换到矫正人员管理请况表切页面为当前页
			$("#spsSqjz-return-sj").unbind("click").bind("click",function(){
				var pid = $(this).attr("pid");
				if(pid=="#ltrhao_org_panel"){
					$(this).attr("pid","#ltrhao_district_panel")
					$("#viewRepSqjz-right").hide();
				}
				if(pid=="#ltrhao_district_panel"){
					$(this).attr("pid","#ltrhao-city-panel");
				}
				$("#ltrhao-city-panel").hide();
				$("#ltrhao_district_panel").hide();
				$("#ltrhao_org_panel").hide();
				$("#ltrhao-org_per-panel").hide();
				$(pid).show();
				$("#ltrhao-total-head").show();
				
				var d = cacheData[pid];
				$("#ltrhao-jzryzs-val").html(d.jzrys);
				$("#ltrhao-rysl-kg-val").html(d.kgs);
				$("#ltrhao-rysl-pg-val").html(d.pgs);
				$("#ltrhao-rysl-yg-val").html(d.ygs);
				
				if(pid=="#ltrhao-city-panel"){
					$("#spsSqjz-return-sj").hide();
				}else{
					$("#spsSqjz-return-sj").show();
				}
				//关闭右侧人员信息明细
				$('#jzrydetailid_a').animate({
					width : 0
				},function(){
					$(this).hide();
				});
			});
			}
		}));
	
	//////////// 以上代码整理过，没有问题，以下代码存在垃圾代码，慢慢整理
	
	
	
	
		$("#wangyidan").unbind("click").bind("click",function(){
			$("#gzryId").modal({
				backdrop : 'false',
				keyboard : false
			});
		});
		$("#img-hidendiv").unbind("click").bind("click",function(){
			$('#jzrydetailid').css("width","400px").hide().animate({
				width : 0,
				speed:3
			});
			$("#ltrhao-sqjz-left").css("top","-300px").show().animate({
				top:0
			});
		});
		$("#ltrhao-spsSqjz-body-div212").unbind("click").bind("click",function(){
			//日历
			$(".form_datetime").datetimepicker({
			       format: "yyyy-mm-dd",
			       language:  'zh-CN',
			       autoclose: true,
			       todayBtn: true,
			       minView: 2,
			       pickerPosition: "bottom-right"
			   });
		});
		
		$("#ltrhao-spsSqjz-body-div246").unbind("click").bind("click",function(){
			//日历
			$(".form_datetime").datetimepicker({
			       format: "yyyy-mm-dd",
			       language:  'zh-CN',
			       autoclose: true,
			       todayBtn: true,
			       minView: 2,
			       pickerPosition: "bottom-right"
			   });
		});
		//右边展示业务数据的div默认隐藏
		//闫宇波修改
		/*$("#viewRepSqjz-right").animate({width:0},function(){$(this).hide()});*/
		$("#viewRepSqjz-right").hide();
		$(".jzry-gban #spsSqjz-hidenDivBtn2").unbind("click").bind("click",function(){
			$("#viewRepSqjz-right").hide();
		});
		
		$("#btn_jzryjbxx_daxx_modal").click(function(){
			$("#jzryjbxx_daxx_modal").modal();
			var url = $("#frame_jzryjbxx_daxx_modal").attr("url");
			jzryjbxxId = $("#frame_jzryjbxx_daxx_modal").attr("jzid");
			$("#frame_jzryjbxx_daxx_modal").attr("src",url+"?id=" + jzryjbxxId);
		});
		
		$("#jtqk_button>li").unbind("click").bind("click",function(){
			$("#jtqk_button>li").css("background","");
			$("#jtqk_button>li a").each(function(){
				$(this).css("color","#555")
			});
			$(this).css({"background":"#166ced"});
			$(this).find("a").css("color","#fff");
		});
		//根据日期查下轨迹
		$("#rep_query_btn").click(function(){
			clickPeople(aid);
		});
});

//增加人员位置
function addRyMarker(item) {
	aid = item.aid;
	var point = new BMap.Point(item.lng, item.lat)
	var marker = new BMap.Marker(point);
	var myIcon;
	var url = "../sqjz/mapimg/man11.png";
	var gender = "男";
	if (item.gender != null && item.gender == '2') {
		url = "../sqjz/mapimg/woman11.png";
		gender = "女";
	}

	myIcon = new BMap.Icon(url, new BMap.Size(35, 55), {
		imageSize : new BMap.Size(35, 55)
	});

	var marker = new BMap.Marker(point, {
		icon : myIcon,
	});
	
	
	
	map.addOverlay(marker);
	 // 设置地图允许的最小/大级别
	map.centerAndZoom(point,16); 
	map.enableScrollWheelZoom(true);
    
	var sContent = "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"
			+ item.name
			+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			+ gender
			+ "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>当前位置："
			+ item.address + "</p>"
			+ "<p><input type='hidden' value='"+item.aid+"'/></p>";
	var opts = {
		offset : new BMap.Size(0, -30)
	};
	var infoWindow = new BMap.InfoWindow(sContent, opts);
	marker.addEventListener("mouseover", function() {
		map.openInfoWindow(infoWindow, point); //鼠标移上开启信息窗口
	});

	marker.addEventListener("mouseout", function() {
		map.closeInfoWindow(infoWindow, point); //鼠标移出关闭信息窗口
	});
	//点击查询【修改处】
	marker.addEventListener("click", function() {
		clickPeople(item.aid);
	});

};
//检索事件处理【个人】
function clickPeople(aid) {
	$("#frame_jzryjbxx_daxx_modal").attr("jzid",aid);
	$("#viewRepSqjz-right").hide();
	//默认记载活动情况
	selectHdqk(aid);
	selectJdqk(aid);
	getFootprintPoint(aid);
	//设置
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
					 Burl+"/image/RMIImageService?_table_name=SYS_FACE_IMG&IMGID="
							+ ds.id);
		}
	}));
	
	//显示右边弹出div
	$('#jzrydetailid_a').show().animate({
		width : 510
	});

};

function getFootprintPoint(aid){
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
	var day1 = $("#rep_day1").val();
	var day2 = $("#rep_day2").val();
	foot.getFootprint(aid, day1,day2,new Eht.Responder({
								success : function(ds) {
									debugger;
									$("#floorId").html("");
									var moveType = [];
									points = [];
									for (var i = 0; i < ds.length - 1; i++) {
										temp = new BMap.Point(ds[i].lng,
												ds[i].lat);
										ydcd = ydcd + ds[i].distance;
										ydbs = ydbs + ds[i].step;
										if (ds[i].floor > 0) {
											var str = "<div class='list-group-item'>";
											str += "<img style='width: 32px; height: 32px; margin-right: 5px;' ";
                    str += " src='../sqjz/mapimg/height.png'></img>"
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
										points[i]=temp;
									}
									//设置总运动时长
									$("#zydcd").html(ydcd.toFixed(2));
									$("#zydbs").html(ydbs);
									$("#floor").html(floor);
								     drawLine(points);
								}
							}));
}
//点击活动情况
function selectHdqk(aid) {
	var as = new AlarmService();
	var day1 = $("#rep_day1").val();
	var day2 = $("#rep_day2").val();
	tv_table_ltrhao.loadData(function(page,res){
		debugger;
		as.findPersonActiviteInfo({aid:aid,day1:day1,day2:day2},page,res);
	});
};
//点击签到情况
function selectJdqk(aid) {
	typeLx = "QD";
	if (aid == undefined) {
		aid = $("#id").text();
	}
	$("#qdxx_data_view").load("../sqjz/formQdxxfx.jsp?aid=" + aid + "&load=load",function(){
	});
};

var aid;
/*画图开始*/
//画路线 -- map地图使用
function drawLine(points) {
	var moveType = [];
	//线路点
	if (points == null || points.length < 1) {
		return;
	}
	map.clearOverlays();
	
	if (aid == undefined) {
		aid = $("#id").text();
	}
	var iconQd = new BMap.Icon("../sqjz/mapimg/start.png", new BMap.Size(48, 61));
	var iconZd = new BMap.Icon("../sqjz/mapimg/end.png", new BMap.Size(48, 61));
	//连接所有点显示轨迹
	map.addOverlay(new BMap.Polyline(points, {
		strokeColor : "#005cb5",
		strokeWeight : 3,
		strokeOpacity : 0.8
	}));
	map.setViewport(points);
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
};

/*画图结束*/
//当前位置
function rydw(id){
	aid = id;
	//显示右边弹出div
	$('#jzrydetailid_a').animate({
		width : 0
	},function(){
		$(this).hide();
	});
//	clickPeople(aid);
	var fs = new FootprintService();
	//清空当前地图信息
	map.clearOverlays();
	fs.getLastLocation(id, new Eht.Responder({
		success : function(item) {
		    addRyMarker(item);
		},
		error:function(){
			new Eht.Alert({title:"警告通知"}).show("该人员没有开启手机定位模式，没有当前定位信息");
		}
	}));
}
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


//添加car图标marker
function addCar(point) {
	var carIcon = new BMap.Icon("../sqjz/mapimg/car.png", new BMap.Size(48, 48));
	var carMarker = new BMap.Marker(point, {
		icon : carIcon
	});
	map.addOverlay(carMarker);
};

//添加步行图标marker
function addWalk(point) {
	var walkIcon = new BMap.Icon("../sqjz/mapimg/walk.png", new BMap.Size(48, 48));
	var walkMarker = new BMap.Marker(point, {
		icon : walkIcon
	});
	map.addOverlay(walkMarker);
};

//添加签到marker
function addQdMarker(i, point, item) {
	var qdIcon;
	/*
	if (item.qdlx == "1") {
		qdIcon = new BMap.Icon("../sqjz/mapimg/finger_sign.png", new BMap.Size(48,
				70));
	} else if (item.qdlx == "2") {
		qdIcon = new BMap.Icon("../sqjz/mapimg/voice_sign.png", new BMap.Size(48,
				70));
	} else if (item.qdlx == "3") {
		qdIcon = new BMap.Icon("../sqjz/mapimg/face_sign.png",
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
	*/
};

//添加活动情况marker
function addHdMarker(i, point, atype, item) {
	var hdIcon;
	var message;
	/*
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
	*/
};


$(function(){
	//心跳检测
	var colors = ['#5793f3', '#d14a61', '#675bba'];


	var optionXt = {
	    color: colors,

	    tooltip: {
	        trigger: 'none',
	        axisPointer: {
	            type: 'cross'
	        }
	    },
	    legend: {
	        data:['P', 'U']
	    },
	    grid: {
	        top: 70,
	        bottom: 20
	    },
	    xAxis: [
	        {
	            type: 'category',
	            axisTick: {
	                alignWithLabel: true
	            },
	            axisLine: {
	                onZero: false,
	                lineStyle: {
	                    color: colors[1]
	                }
	            },
	            axisPointer: {
	                label: {
	                    formatter: function (params) {
	                        return 'P  ' + params.value
	                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
	                    }
	                }
	            },
	            data: ["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"]
	        },
	        {
	            type: 'category',
	            axisTick: {
	                alignWithLabel: true
	            },
	            axisLine: {
	                onZero: false,
	                lineStyle: {
	                    color: colors[0]
	                }
	            },
	            axisPointer: {
	                label: {
	                    formatter: function (params) {
	                        return 'U  ' + params.value
	                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
	                    }
	                }
	            },
	            data: ["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1"]
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value'
	        }
	    ],
	    series: [
	        {
	            name:'P',
	            type:'line',
	            xAxisIndex: 1,
	            
	            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
	        },
	        {
	            name:'U',
	            type:'line',
	            
	            data: [3.9,150, 60, 200,30, 69.2, 231.6, 46.6, 55.4, 18.4, 10.3, 0.7]
	        }
	    ]
	};
	var xt = echarts.init(document.getElementById('xtsj'));
	xt.setOption(optionXt);
});