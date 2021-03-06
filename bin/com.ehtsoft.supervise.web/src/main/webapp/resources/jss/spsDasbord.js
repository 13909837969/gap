$(function() {
	var city_code = "";
	var service_JZ = new RepJzryService();
	var rep = new RepJszlService();
	var res1 =  new Eht.Responder();
	res1.success=function(data){
	};
	//界面加载-决策总揽 【默认加载 全部的数据】
	var lat = "";
	var lng = "";
	rep_jczl(lat,lng);
	bzt(lat,lng);
	refresh(city_code);
	
	var query1 = {};
	//获取查询条件开始日期
	var now = new Date();
	query1.ksrq = getCurrentMonthFirst();
	query1.jsrq = now.format("yyyy-MM-dd");
	function getCurrentMonthFirst(){
		 var date=new Date();
		 date.setDate(1);
		 return date.format("yyyy-MM-dd");
	}
	//将当月的第一天和当前日期显示在页面
	$("#formDasbord-kssj").val(query1.ksrq);
	$("#formDasbord-jssj").val(query1.jsrq);
	//默认状态新增矫正人员数量按当月第一天开始
	service_JZ.findCount(query1,res1);
	
	//按条件统计有多少新增矫正人员
	$("#searchbtn").click(function(){
		query1.ksrq = $("#formDasbord-kssj").val();
		query1.jsrq = $("#formDasbord-jssj").val();
		service_JZ.findCount(query1,res1);
	});
	//弹出框查询日历信息
	$(".form_datetime_aa").val(query1.ksrq);
	$(".form_datetime_aa").datetimepicker({
        format: "yyyy-mm-dd",
        language:  'zh-CN',
        autoclose: true,
        todayBtn: true,
		minView: 2,
        pickerPosition: "bottom-right"
    });
	$(".form_datetime_bb").datetimepicker({
        format: "yyyy-mm-dd",
        language:  'zh-CN',
        autoclose: true,
        todayBtn: true,
		minView: 2,
        pickerPosition: "bottom-right"
    });
	
	//决策首页查询日历js
	 $(".form_datetime").datetimepicker({
	        format: "yyyy-mm-dd",
	        language:  'zh-CN',
	        autoclose: true,
	        todayBtn: true,
			minView: 2,
	        pickerPosition: "top-left"
	    });

	
});
//刷新界面
function refresh(city_code) {
	var lvl=2;
	var rep = new RepJszlService();
		var myChart = echarts.init(document.getElementById('das_mapID'));
		//地图经纬度数据【未对接】
		//TODO
		rep.findAllCount_TD(city_code,new Eht.Responder({success:function(data){
			//设置地图的显示级别[省1、市2、区3]
			var lvl = data[0].lvl;
			//对接 矫正人员总数
			var max = 5000, min = 100;//9; // 根据返回值计算最大最小值
			var maxSize4Pin = 80, minSize4Pin = 40;
			function convertData(data) {
				res = data;
				// 有数据的地区的名称和value值
				return res;
			};
		var z = 0; 
		if (city_code != "") {
			z= 9;
		}else{
			z=6;
		}	

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
					center : [ data[0].lng, data[0].lat ],
					// 百度地图缩放
					zoom : z,
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
					//zlevel : 6,
					data : convertData(data),
				}, 
				{
					name : '',
					type : 'effectScatter',
					coordinateSystem : 'bmap',
					data : convertData(data.sort(function(a, b) {
						return b.value - a.value;
					}).slice(0, 5)),
					symbolSize : function(val) {
						var r = val[2]*maxSize4Pin/max/2;
						if(r<minSize4Pin/2){
							r = minSize4Pin/2;
						}
						return r;
					},
					showEffectOn : 'render',
					rippleEffect : {
						brushType : 'stroke'
					},
					hoverAnimation : true,
					label : {
						normal : {
							formatter : '{b}',
							position : 'right',
							show : true
						}
					},
					itemStyle : {//控制蓝颜色点颜色
						normal : {
							color : '#05C3F9',
							shadowBlur : 10,
							shadowColor : '#05C3F9'
						}
					},
					zlevel : 1
				}
				]
			};
	
	myChart.setOption(option);
	//气球单击事件选择 【弹框】
	myChart.on('click', function (params) {
		 lng = params.data.value[0];
		 lat = params.data.value[1];
		var point = new BMap.Point(lng, lat);
		var opts = { 
			    width : 300,     // 信息窗口宽度    
			    height: 170,     // 信息窗口高度    
			    title : ""  // 信息窗口标题   
			}   
		
		//分区域检索
		var rep_jgzs;
		var rep_gzryzs;
		var rep_jzryzs;
		var rep_rmtjzs;
		var rep_azbjzs;
		rep.findAllCount_TDFQ(lat,lng,new Eht.Responder({success:function(data){
			rep_azbjzs = data.rep_azbj.rep_azbj[0].bjsl; //安置帮教
			rep_jzryzs = data.rep_jzry.rep_jzry[0].jzrys; //矫正人员总数
			rep_rmtjzs = data.rep_rmtj.rep_rmtj[0].tjsl; //人民调解总数
			rep_jgzs = data.rep_jg_gzru.rep_jg_gzru[0].jgsl;   //机构总数
			rep_gzryzs = data.rep_jg_gzru.rep_jg_gzru[0].gzrys; //工作人员总数
		
			var str = "<div id='jczl-xxsj-box' style='width:300px; height:150px; border-radius:5px;margin-top: -12px;' >"+
						  "<div id='jczl-xxsj' style = 'color:#128ef6;font-size:20px;text-align:center;padding-top:10px;'>"+
						    "<span>详细数据</span>"+
						  "</div>"+
						  "<div id='jczl-jigzs' style='color:#333;padding-left:65px;margin-top:10px'>"+
						    "<span style='font-size:18px;'>机构总数：</span>"+
						   "<span style ='font-size:18px;color:#3273f5;'>"+rep_jgzs+"家</span>" +
						 "</div>"+
						  "<div id='jczl-gzryzs' style='font-size:16px; margin-top:5px; text-align:center;'>"+
						  "<span style='color:#686868;'>工作人员总数：</span>"+
						  "<span style='color:#3273f5;'>"+rep_gzryzs+"件</span>" +
						  "</div>"+
						  "<div id='jczl-jzryzs' style=' font-size:16px; margin-top:5px; text-align:center;'>"+
						    "<span style='color:#686868;'>矫正人员总数：</span>"+
						    "<span style='color:#3273f5;'>"+rep_jzryzs+"件</span>"+
						  "</div>"+
						  "<div id='jczl-rmtjzs' style='font-size:16px; margin-top:5px; text-align:center;'>"+
						    "<span style='color:#686868;'>人民调解总数：</span>"+
						    "<span style='color:#3273f5;'>"+rep_rmtjzs+"件</span>"+
						  "</div>"+
						  "<div id='jczl-rmtjzs' style='font-size:16px; margin-top:5px; text-align:center;'>"+
						    "<span style='color:#686868;'>安置帮教总数：</span>"+
						    "<span style='color:#3273f5;'>"+rep_azbjzs+"件</span>"+
						  "</div>"+
						"</div>";
			var infoWindow = new BMap.InfoWindow(str, opts);  // 创建信息窗口对象    
			map.openInfoWindow(infoWindow, point);      // 打开信息窗口
			infoWindow.addEventListener('open',function(type, target, point){ //窗口打开是，隐藏自带的关闭按钮
			    $('.BMap_pop>img').click(function() {
			    	debugger;
			    	/*refresh();*/
			    	if (city_code == "") {
			    		var lat = "";
						var lng = "";
						rep_jczl(lat,lng);
						bzt(lat,lng);
					}else{
						rep_jczl(lat,lng);	
						bzt(lat,lng);
					}
			    	
				});
			});
		//点击地图联动处理 【传经纬度或省、市、区、的id】
			rep_jczl(lat,lng);	
			bzt(lat,lng);
		}}));
	});
		
	// console.log(myChart.getModel().getComponent('bmap'));
	// 获取百度地图实例，使用百度地图自带的控件
	var map = myChart.getModel().getComponent('bmap').getBMap();
	//map.addControl(new BMap.MapTypeControl());
	var mapStyle = {
		features : [ "road", "building", "water", "land" ],//隐藏地图上的poi
		style : "water" //设置地图风格为高端黑  midnight
	};
	map.setMapStyle(mapStyle);
	
	//设置地图的铺色
	var strokeColor;
	var fillColor;
	if (lvl == 2) {
		 fillColor = "#292557";
	}else{
		 fillColor = "";
	}
	
	var opts = {type: BMAP_NAVIGATION_CONTROL_ZOOM} //显示缩放部分功能 
	map.addControl(new BMap.NavigationControl(opts)); 
	var bs = new BoundaryService();
	bs.findBoundary(lvl, new Eht.Responder({
		success : function(data) {
			var pointArray = [];
			for (var i = 0; i < data.length; i++) {
				var bounds = data[i].boundary;
				for (var j = 0; j < bounds.length; j++) {
					var ply = new BMap.Polygon(bounds[j], {
						strokeWeight : 2,
						strokeColor : "#212121",
						fillColor : fillColor
					}); //建立多边形覆盖物 81bbec
					map.addOverlay(ply);
					pointArray = pointArray.concat(ply.getPath());
				}
			}
		}
	})); 
		
		}
		}));
		//矫正人员软件
    	var  jzChart = echarts.init(document.getElementById('dasbord-jz-chart'));
    	var  azChart = echarts.init(document.getElementById('dasbord_az_chart'));
    	var  rmChart = echarts.init(document.getElementById('dasbord_rm_chart'));
    	var  fxChart = echarts.init(document.getElementById('dasbord_fx_chart'));
        var option_aa = {
        	title:{
        		textStyle: {
        			fontSize:8
        		},
        		padding:2,
        		left:20
        	},
        	legend: {
            	x:230,
                data: ['1','2','3']
            },
        	 grid: {
        	        left: '3%',
        	        right: '4%',
        	        bottom: '13%',
        	        containLabel: true
        	  },
        	center: ['50%', '50%'],
            tooltip : {
                formatter: "{a} <br/>{b} : {c}%"
            },
            textStyle:{
            	fontSize:8,
            	height:10,
            	fontWeight:'bold'
            },
            series: [
                { 
                	 radius: '100%',
                	axisLine: {            // 坐标轴线
                        lineStyle: {       // 属性lineStyle控制线条样式
                        width: 12,
                    color: [[0.2, '#AD1457'], [0.8, '#7B1FA2'], [1, '#388E3C']],
                    },
                    splitLine: {           // 分隔线
                        length: 8,         // 属性length控制线长
                        lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
                            color: 'auto'
                        }
                    },
                },
                    name: '业务指标',
                    type: 'gauge',
                    detail: {formatter:'{value}%'},
                    data: [{value: 90}]
                }
            ]
        };
        jzChart.setOption(option_aa);
        azChart.setOption(option_aa);
        rmChart.setOption(option_aa);
        fxChart.setOption(option_aa);
      //默认隐藏的区域选择
    	//区域选择div
    	
    	$('#spsSqjz-hidenDiv').hide();
    	var service = new RegionService();
    	service.find({},new Eht.Responder({success:function(data){
			for(var i=0;i<data[0].nodes.length;i++){
				var n = data[0].nodes[i];
				var city = $('<ul class="hidden-div-ul"></ul>');
				var root = $('<li><div><input type="checkbox" style="margin-left:10px; margin-right:3px;color:#686868;" name="region_code" id="'+n.region_code+'" value="'+n.region_code+'"><label style="color:#f00;font-size:16px;" for="'+n.region_code+'">'+n.region_name+'</label></div></li>')
				city.append(root);
				$('#spsSqjz-hidenDivSS').append(city);
				root.addClass("hidden-div-ul");
				var child = $('<ul style="margin-top:10px;" ></ul>');;
				for(var j=0;j<n.nodes.length;j++){
					var li = $('<li class="hidden-div-li"><input type="checkbox" style="margin-left:10px; margin-right:3px;color:#686868;" name="region_code"  id="'+n.nodes[j].region_code+'" value="'+n.nodes[j].region_code+'"><label for="'+n.nodes[j].region_code+'">'+n.nodes[j].region_name+'</label></li>');
					child.append(li);
					li.addClass("hidden-div-li");
				}
				root.append(child);
			}
		}
    	}));
    	//显示隐藏的区域选择
    	$("#inputQyDiv").click(function(){
    			$("#spssjfx-hidenDiv").css("height","0").show().animate({height:400});
    			$("[type='checkbox']").prop("checked",false); //
    		return false;
    	});
    	//点击其他地方区域隐藏
    	$(window).click(function(){
    		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
    	});
    	
    	$("#spssjfx-hidenDiv").click(function(){return false;});
    	
    	//点击确定按钮的时候关闭区域并且提交选择的数据
    	$("#spsSqjz-hidenDiv-qd").click(function(){
    		$("#spssjfx-hidenDiv").animate({height:0},function(){
    			//获取chekcbox的选中的value
				var regionid = new Array();
				 obj = document.getElementsByName("region_code");
				    check_val = [];
				    for(k in obj){
				        if(obj[k].checked){
				        	check_val.push(obj[k].value);
				        	}
				    	}
			regionid =check_val;
			//判断是否选择
			if (regionid.length > 0) {
				
				if (regionid.length < 2) {
					//界面的联动处理
					var cityid = "";
					var areaid = "";
					city_code = regionid[0];
					 cityid = regionid[0];
					 areaid = regionid[1];
					 if (areaid == undefined ) {
						 areaid = ""
						}
					//通过返回的 省 市 区 的级别进行限制区域的分类
					rep.findRegionLvl(cityid,areaid,new Eht.Responder({success:function(data){
						if (data.data.length > 0) {
							$("#inputQyDiv").val(data.data[0].region_name);
							var lat1 = data.data[0].lat;
							var lng1 = data.data[0].lng;
							var lat = lat1+"";
							var lng = lng1+"";
							refresh(city_code);
							rep_jczl(lat,lng);
							bzt(lat,lng);
						}else{
							alert("请选择一个区域进行检索！");
						}
						
					}}));
				}else{
					alert("请选择一个区域进行检索！");
				}
				
			}else{
				alert("未选择要查询的区域！");
				refresh(city_code);
			}
				$(this).hide();
			});
    	});
    	//关闭按钮
    	$("#spsSqjz-hidenDivBtn").click(function(){
    		$("#spssjfx-hidenDiv").animate({height:0},function(){$(this).hide()});
    	});
       
		
		//点击机构分类的时候展示机构分类  二级页面
		/*$("#ltrhao-body-left5-div11").unbind("click").bind("click",function(){
			//加载数据
			var rep = new RepJszlService();
			//合计 
			rep.findBuilDing(new Eht.Responder({success:function(data){
				$(".panel-body").html("");
				for(var i=0;i<data.length;i++){
					var h =i+1;
					var j="";
					if (i < 9) {
						j = "0" + h;
					}else{
						j = h;
					}
					var city = $('<ul style="list-style: none;"></ul>');
					var root = $('<li><div class="cityContent " smark="'+data[i].regionid+'"><p class="col-xs-2 pLeftAndRghit">'+j+'</p><p class="col-xs-6 pLeftAndRghit"  id="city-name">'+data[i].region_name+'</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">'+data[i].jzrys+'</p></div></li>');
					city.append(root);
					$('#panel-body_jz').append(city);
					
					var city1 = $('<ul style="list-style: none;"></ul>');
					var root1 = $('<li><div class="cityContent " smark="'+data[i].regionid+'"><p class="col-xs-2 pLeftAndRghit">'+j+'</p><p class="col-xs-6 pLeftAndRghit"  id="city-name">'+data[i].region_name+'</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">'+data[i].bjsl+'</p></div></li>');
					city1.append(root1);
					$('#panel-body_rm').append(city1);
					
					var city2 = $('<ul style="list-style: none;"></ul>');
					var root2 = $('<li><div class="cityContent " smark="'+data[i].regionid+'"><p class="col-xs-2 pLeftAndRghit">'+j+'</p><p class="col-xs-6 pLeftAndRghit"  id="city-name">'+data[i].region_name+'</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">'+data[i].tjsl+'</p></div></li>');
					city2.append(root2);
					$('#panel-body_az').append(city2);
					
					var city2 = $('<ul style="list-style: none;"></ul>');
					var root2 = $('<li><div class="cityContent " smark="'+data[i].regionid+'"><p class="col-xs-2 pLeftAndRghit">'+j+'</p><p class="col-xs-6 pLeftAndRghit"  id="city-name">'+data[i].region_name+'</p><p class="col-xs-4 pLeftAndRghit panel-zhcount">'+data[i].hj+'</p></div></li>');
					city2.append(root2);
					$('#panel-body_hj').append(city2);
				}
			}}));
			
			
			$("#rangCity").css("right",$(window).outerWidth(true)).show().animate({right:0});
			$("#ltrhao-body-left1").css("left","360px").hide().animate({left:-100});
			$("#ltrhao-body-left2").hide();
			$("#ltrhao-body-left3").hide();
			$("#ltrhao-body-left4").hide();
			$("#ltrhao-body-left5").hide();
			$("#ltrhao-body-right1").hide();
			$("#ltrhao-body-right2").hide();
			$("#ltrhao-body-right3").hide();
			$("#container-right4").hide();
		});*/
		//rangCity的关闭按钮
		$("#rangCity-close").unbind("click").bind("click",function(){
			$("#rangCity").css("right","2px").hide().animate({right:0});
			$("#rangDitail").hide();//隐藏详细情况分析
			$("#ltrhao-body-left1").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left2").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left3").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left4").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-left5").css("left","-300px").show().animate({left:10});
			$("#ltrhao-body-right1").css("top","-300px").show().animate({top:20});
			$("#ltrhao-body-right2").css("right","-300px").show().animate({right:10});
			$("#ltrhao-body-right3").css("right","-300px").show().animate({right:172});
			$("#container-right4").show();
		})
		//点击相关城市的时候显示详细情况分析
		$("#city-name").unbind("click").bind("click",function(){
			$("#rangDitail").css("right",$(window).outerWidth(true)).show().animate({right:685});
		})
		$("#city-name").hover(function(){
			$("#city-name").css("color","#ff0");
		},function(){
			$("#city-name").css("color","#fff");
		});
	}
//界面的联动处理
function rep_jczl(lat,lng){
	var rep = new RepJszlService();
	//矫正人员总数
	rep.findAllCount_JZ(lat,lng,new Eht.Responder({success:function(data){
	$("#ltrhao-body-left1 #ltrhao-body-left1-div11").html(data.total[0].jzrys);
	}}));
	//机构建设  及 工作人员
	rep.findAllCount_JG(lat,lng,new Eht.Responder({success:function(data){
		$('#ltrhao-body-right3-div2').empty();
		$('#ltrhao-body-left5-div2').empty();
		var child = $('<ul style="width:100%;"></ul>');
		var child1 = $('<ul style="width:100%;"></ul>');
		if (data.jg_xx.length>0) {
			for (var i = 0; i < data.jg_xx.length; i++) {
				//机构
				var li = $('<li style="float:left;width:128px;line-height:40px;padding-right:5px;"><div style="color:#fff;">'+data.jg_xx[i].jglxmc+"</div><span style='color: #FFC107;font-size: 16px;'>"+data.jg_xx[i].jgsl+'</span></li>');
				child.append(li);
				li.addClass("hidden-div-li");
				
				//工作人员
				var li = $('<li style="float:left;width:128px;line-height:40px;padding-right:5px;"><div style="color:#fff;">'+data.jg_xx[i].gzrylxmc+"</div><span style='color: #FFC107;font-size: 16px;'>"+data.jg_xx[i].gzrys+'</span></li>');
				child1.append(li);
				li.addClass("hidden-div-li");
			}
			$('#ltrhao-body-right3-div2').append(child1);
			$('#ltrhao-body-left5-div2').append(child);
		} 
	}}));
	
	//人民调解
	rep.findAllCount_RMTJ(lat,lng,new Eht.Responder({success:function(data){
		//接数据人民调解总数【基础数据】
		$("#ltrhao-body-right2-div1 #ltrhao-body-right2-div13").html(data.jg_xx[0].tjsl);
		$("#ltrhao-body-right2-div1 #ltrhao-body-right2-div15").html(data.jg_xx[0].tjcgs);
		
	}}));
	
	//安置帮教【基础数据】
	rep.findAllCount_AZBJ(lat,lng,new Eht.Responder({success:function(data){
		//接数据人民调解【基础数据】
		$("#ltrhao-body-right1-div1 #ltrhao-body-right1-div13").html(data.jg_xx[0].bjsl);
	}}));
}
//饼状图
function bzt(lat,lng) {
	var rep = new RepJszlService();
	//right1【安置帮教 饼状图】
	var fxtChart1= echarts.init(document.getElementById('ltrhao-body-right1-div2'));
	//获取数据
	var jyxmsf=""; //监狱刑满释放
	var kssxmsf=""; //看守所刑满释放
	var jssqjz="";//解除社区矫正
	var gajg="";//公安机关落实管控
	rep.findAllCount_AZBJ_B(lat,lng,new Eht.Responder({success:function(data){
		//接数据人民调解【基础数据】
		if (data.jg_xx.length>0) {
			//普通绘表			
		 	for (var i = 0; i < data.jg_xx.length; i++) {
		 		if (data.jg_xx[i].lymc == '监狱刑满释放') {
		 			jyxmsf = data.jg_xx[i].bjsl;
					}
		 		if (data.jg_xx[i].lymc == '看守所刑满释放') {
		 			kssxmsf = data.jg_xx[i].bjsl;
					}
		 		if (data.jg_xx[i].lymc == '解除社区矫正') {
		 			jssqjz = data.jg_xx[i].bjsl;
					}
		 		if (data.jg_xx[i].lymc == '公安机关落实管控') {
		 			gajg = data.jg_xx[i].bjsl;
					}
		 	}
		 }
	
	var optionFxt1 = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    series : [
		        {
		            name: '实时数据',
		            type: 'pie',
		            radius : '65%',
		            center: ['50%', '50%'],
		            data:[
		                {value:jyxmsf, name:'监狱刑满释放'},
		                {value:kssxmsf, name:'看守所刑满释放'},
		                {value:jssqjz, name:'解除社区矫正'},
		                {value:gajg, name:'公安机关落实管控'},
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
	
	//right2【人民调解 饼状图】
	fxtChart1.setOption(optionFxt1);
	}}));
	
	//获取数据
	var zdjf=""; //重大纠纷
	var jdjf=""; //简单纠纷
	var ybjf="";//一般纠纷
	rep.findAllCount_RMTJ_B(lat,lng,new Eht.Responder({success:function(data){
		//接数据人民调解【基础数据】
		if (data.jg_xx.length>0) {
			//普通绘表			
		 	for (var i = 0; i < data.jg_xx.length; i++) {
		 		if (data.jg_xx[i].lxmc == '重大纠纷') {
		 			zdjf = data.jg_xx[i].tjsl;
					}
		 		if (data.jg_xx[i].lxmc == '简单纠纷') {
		 			jdjf = data.jg_xx[i].tjsl;
					}
		 		if (data.jg_xx[i].lxmc == '一般纠纷') {
		 			ybjf = data.jg_xx[i].tjsl;
					}
		 	}
		 }
	
	var fxtChart2 = echarts.init(document.getElementById('ltrhao-body-right2-div2'));
	var optionFxt2 = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    series : [
		        {
		            name:'面积模式',
		            type:'pie',
		            radius : [30, 70],
		            center : ['50%', '50%'],
		            roseType : 'area',
		            data:[
		                {value:zdjf, name:'重大纠纷'},
		                {value:jdjf, name:'简单纠纷'},
		                {value:ybjf, name:'一般纠纷'}
		            ]
		        }
		    ]
		};
	fxtChart2.setOption(optionFxt2);
	}}));
}