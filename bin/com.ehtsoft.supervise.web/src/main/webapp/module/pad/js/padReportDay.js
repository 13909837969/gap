/*
 * pad综合统计分析-按天
 */
// 人民调解
var rmtj_day = echarts.init(document.getElementById('rmtj_day'));
// 安装帮教
var azbj_day = echarts.init(document.getElementById('azbj_day'));
// 法律援助
var flyz_day = echarts.init(document.getElementById('flyz_day'));
//矫正人员
//var jzry_day = echarts.init(document.getElementById('jzry_day'));
//矫正类别
var jzlb_day = echarts.init(document.getElementById('jzlb_day'));
//年龄分布
var nlfb_day = echarts.init(document.getElementById('nlfb_day'));
//option定义
var jzryDayOption,/*rmtjDayOption,*/azbjDayOption,/*flyzDayOption*/jzlbDayOption,nlfbDayOption;

//定义Service 
var pad = new PadZhtjService();

/*//矫正人员
jzryDayOption = {
	color : [ '#e6b600' ],
	tooltip : {
		trigger : 'axis',
		axisPointer : { // 坐标轴指示器，坐标轴触发有效
			type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
		}
	},
	toolbox: {
        top:-5,
        feature: {
            magicType: {
                type: [ 'bar','line']
            },
            restore: {}
        }
    },
	grid : {
		left : '3%',
		right : '4%',
		bottom : '5%',
		top : '10%',
		containLabel : true
	},
	xAxis : [ {
		type : 'category',
		data : [ '17年8月', '17年9月', '17年10月', '17年11月', '17年12月', '18年1月' ],
		//data : [ '1月3日', '1月4日', '1月5日', '1月6日', '1月7日', '1月8日','1月9日' ],
		axisTick : {
			alignWithLabel : true
		}
	} ],
	yAxis : [ {
		type : 'value'
	} ],
	series : [ {
		name : '矫正人数',
		type : 'bar',
		barWidth : '60%',
		data : [ 9, 15, 10, 13, 9, 12 ]
		//data : [ 200, 102, 334, 200, 200, 200 ,199]
	} ]
};*/

// 人民调解
/*rmtjDayOption = {
	color : [ '#3398DB' ],
	tooltip : {
		trigger : 'axis',
		axisPointer : { // 坐标轴指示器，坐标轴触发有效
			type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
		}
	},
	toolbox: {
        top:-5,
        feature: {
            magicType: {
                type: [ 'line','bar']
            },
            restore: {}
        }
    },
	grid : {
		left : '3%',
		right : '4%',
		bottom : '5%',
		top : '10%',
		containLabel : true
	},
	xAxis : [ {
		type : 'category',
		data : [ '17年8月', '17年9月', '17年10月', '17年11月', '17年12月', '18年1月' ],
		//data : [ '1月3日', '1月4日', '1月5日', '1月6日', '1月7日', '1月8日','1月9日' ],
		axisTick : {
			alignWithLabel : true
		}
	} ],
	yAxis : [ {
		type : 'value'
	} ],
	series : [ {
		name : '案件数量',
		type : 'line',
		barWidth : '60%',
		data : [ 52, 200, 334, 390, 330, 220 ]
		//data : [ 52, 200, 334, 390, 330, 220 ,200]
	} ]
};*/
// 安置帮教
azbjDayOption = {
	color : [ '#2b821d' ],
	tooltip : {
		trigger : 'axis',
		axisPointer : { // 坐标轴指示器，坐标轴触发有效
			type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
		}
	},
	grid : {
		left : '3%',
		right : '4%',
		bottom : '5%',
		top : '10%',
		containLabel : true
	},
	toolbox: {
        top:-5,
        feature: {
            magicType: {
                type: [ 'bar','line']
            },
            restore: {}
        }
    },
	xAxis : [ {
		type : 'category',
		data : [ '17年8月', '17年9月', '17年10月', '17年11月', '17年12月', '18年1月' ],
		//data : [ '1月3日', '1月4日', '1月5日', '1月6日', '1月7日', '1月8日' ,'1月9日' ],
		axisTick : {
			alignWithLabel : true
		}
	} ],
	yAxis : [ {
		type : 'value'
	} ],
	series : [ {
		name : '安置帮教数量',
		type : 'bar',
		barWidth : '60%',
		data : [ 38, 41, 49, 37, 40, 46 ]
		//data : [ 10, 52, 100, 134, 21, 34 ,35]
	} ]
};

// 法律援助
/*flyzDayOption = {
	color : [ '#c23531' ],
	tooltip : {
		trigger : 'axis',
		axisPointer : { // 坐标轴指示器，坐标轴触发有效
			type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
		}
	},
	grid : {
		left : '3%',
		right : '4%',
		bottom : '5%',
		top : '10%',
		containLabel : true
	},
	toolbox: {
        top:-5,
        feature: {
            magicType: {
                type: [ 'line','bar']
            },
            restore: {}
        }
    },
	xAxis : [ {
		type : 'category',
		data : [ '17年8月', '17年9月', '17年10月', '17年11月', '17年12月', '18年1月' ],
		//data :  [ '1月3日', '1月4日', '1月5日', '1月6日', '1月7日', '1月8日','1月9日' ],
		axisTick : {
			alignWithLabel : true
		}
	} ],
	yAxis : [ {
		type : 'value'
	} ],
	series : [ {
		name : '法律援助次数',
		type : 'line',
		barWidth : '60%',
		data : [ 10, 15, 21, 12, 13, 11]
		//data : [ 10, 52, 100, 134, 21, 34,37 ]
	} ]
};*/
//
jzlbDayOption={
        series: [{
            type: 'pie',
            radius : '45%',
            center: ['50%', '50%'],
            selectedMode:'single',
            data:''
        }]
   };



nlfbDayOption={
        series: [{
            type: 'pie',
            radius : '45%',
            center: ['50%', '50%'],
            selectedMode:'single',
            data:'',
            itemStyle: {
                emphasis: {
                    shadowBlur:0,
                    shadowOffsetX:0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }]
 };

$(function() {
	selectDay();
	//获取8个方块的统计数据
	findZhtjCount();
});

/**
 * 获取8个方块的统计数据
 */
function findZhtjCount(){
	var zhtjService = new PadZhtjService();
	zhtjService.findZhtjCount({},new Eht.Responder({
		success:function(data){
			$("#jzryCount").html(data.jzrycount);
			$("#zwqdCount").html(data.zwqdcount);
			$("#swqdCount").html(data.swqdcount);
			$("#rlqdCount").html(data.rlqdcount);
			$("#caseNum").html(data.casenum);
			$("#xtjcCount").html(data.xtjccount);
			$("#hmCount").html(data.hmcount);
			$("#alarmCount").html(data.alarmcount);
		}
	}));
}
/**
 * 显示矫正人员列表
 */
function showJzryDetail(month) {
	//window.SuperviseClient.startIntent('activity.ArchivesManageActivity', '');
}

/**
 * 显示人民调解列表
 */
function showRmtjDetail(month) {
	//window.SuperviseClient.startIntent('activity.CaseHandingActivity', '')
}

/**
 * 报警数量明细列表
 */
function showAlarmlList() {
	$("#alarmId").html("");
	var zhtjService = new PadZhtjService();
	zhtjService.findAlarmList({},
	new Eht.Responder(
			{
				success : function(ds) {
					var str = "", j;
					for (var i = 0; i < ds.length; i++) {
						j = i + 1;
						str += "<div class='list-group-item'>";
						str += "<img style='width: 32px; height: 32px; margin-right: 5px;'";
						str += " src='../../module/sqjz/mapimg/warn.png'></img>"+ ds[i].cts+ "&nbsp;&nbsp;&nbsp; "+ ds[i].f_content;
						str += "</div>";
					}
					$("#alarmId").append(str);
				}
	}));
	$("#alarmModal").modal({
		backdrop : 'false',
		keyboard : false
	});
}

/**
 * 签到列表(1指纹签到  2声纹签到  3人脸签到)
 */
function showQdList(qdType){
	$("#qdId").html("");
	var zhtjService = new PadZhtjService();
	zhtjService.findQdList({"qdlx":qdType},
		  new Eht.Responder({
			success : function(ds) {
				var str = "", j;
				for (var i = 0; i < ds.length; i++) {
					j = i + 1;
					var imgurl;
					if(ds[i].qdlx=="1"){
						imgurl ="../../module/sqjz/mapimg/finger.png";
					}else if(ds[i].qdlx=="2"){
						imgurl="../../module/sqjz/mapimg/voice.png";
					}else if(ds[i].qdlx=="3"){
						imgurl ="../../module/sqjz/mapimg/face.png";
					}
					str += "<div class='list-group-item'>";
					str += "<img style='width: 32px; height: 32px; margin-right: 5px;' ";
					str += " src='"+imgurl+"'></img>"+ ds[i].xm+"&nbsp;&nbsp;&nbsp;"+ds[i].jdlxm+ "&nbsp;&nbsp;&nbsp; "+ds[i].cts ;
					str += "</div>";
				}
				$("#qdId").append(str);
			}
	 }));
	$("#qdModal").modal({
		backdrop : 'false',
		keyboard : false
	});
}


/**
 * 心跳检查列表
 */
function showXtjcList() {
	$("#xtjcId").html("");
	var zhtjService = new PadZhtjService();
	zhtjService.findXtjcList({},
	new Eht.Responder(
			{
				success : function(ds) {
					var str = "", j;
					for (var i = 0; i < ds.length; i++) {
						j = i + 1;
						str += "<div class='list-group-item'>";
						str += "<img style='width: 32px; height: 32px; margin-right: 5px;'";
						str += " src='../../module/sqjz/mapimg/xt.png'></img>"+ds[i].xm+"&nbsp;&nbsp;&nbsp;"+ ds[i].cts+ "&nbsp;&nbsp;&nbsp;心率检查值：  "+ ds[i].xlz+"次/分&nbsp;&nbsp;&nbsp;与数据分析结果吻合";
						str += "</div>";
					}
					$("#xtjcId").append(str);
				}
	}));
	$("#xtjcModal").modal({
		backdrop : 'false',
		keyboard : false
	});
}

/**
 * 会面列表
 */
function showHmList() {
	$("#hmId").html("");
	var zhtjService = new PadZhtjService();
	zhtjService.findHmqkList({},
	new Eht.Responder(
			{
				success : function(ds) {
					var str = "", j;
					for (var i = 0; i < ds.length; i++) {
						j = i + 1;
						str += "<div class='list-group-item'>";
						str += "<img style='width: 32px; height: 32px; margin-right: 5px;'";
						str += " src='../../module/sqjz/mapimg/hm.png'></img>"+ds[i].xm+"&nbsp;&nbsp;&nbsp;"+ ds[i].hmsj+ "&nbsp;&nbsp;&nbsp;" + ds[i].hmwz+ "&nbsp;&nbsp;&nbsp;会面人员：  "+ ds[i].hmrymc;
						str += "</div>";
					}
					$("#hmId").append(str);
				}
	}));
	$("#hmModal").modal({
		backdrop : 'false',
		keyboard : false
	});
}

/**
 * 按天统计数据
 */
function selectDay(){
	$("#panel-1").addClass("active");
	$("#panel-2").removeClass("active");
	$("#panel-3").removeClass("active");
	/**
	 * 获取矫正人员分析图标数据
	 */

	/**
	 * 获取人民调解分析图标数据
	 */

	/**
	 * 获取安装帮教分析图标数据
	 */

	/**
	 * 获取法律援助分析图标数据
	 */
	//jzry_day.setOption(jzryDayOption);
	// 添加点击事件
	/*jzry_day.on('click', function(params) {
		showJzryDetail(params.name)
	});
	*/
	azbj_day.setOption(azbjDayOption);
	
	//rmtj_day.setOption(rmtjDayOption);
	// 添加点击事件
	rmtj_day.on('click', function(params) {
		showRmtjDetail(params.name)
	});
	
	//flyz_day.setOption(flyzDayOption);
	// 添加点击事件
	flyz_day.on('click', function(params) {
		alert(params.name);
	});
	
	jzlb_day.setOption(jzlbDayOption);
	nlfb_day.setOption(nlfbDayOption);
}