/*
 * pad综合统计分析-按月
 */

//option 定义
var /*jzryMonthOption,*//*rmtjMonthOption,*/azbjMonthOption/*,flyzMonthOption*/,jzlbMonthOption,nlfbMonthOption;
	/*// 矫正人员
	jzryMonthOption = {
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
		} ]
	};*/
	
	// 添加点击事件
	/*jzry_month.on('click', function(params) {
		showJzryDetail(params.name)
	});*/
	// 人民调解
	/*rmtjMonthOption = {
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
			data : [ '17年10月', '17年11月', '17年12月', '18年1月', '18年2月', '18年3月' ],
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
		} ]
	};*/
	
	// 添加点击事件
//	jzry_month.on('click', function(params) {
//		showRmtjDetail(params.name)
//	});
	// 安装帮教
	azbjMonthOption = {
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
			data : [ '17年10月', '17年11月', '17年12月', '18年1月', '18年2月', '18年3月' ],
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
		} ]
	};
	
	// 法律援助
	/*flyzMonthOption = {
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
			data : [ '17年10月', '17年11月', '17年12月', '18年1月', '18年2月', '18年3月' ],
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
		} ]
	};*/
	
	// 添加点击事件
	/*flyz_month.on('click', function(params) {
		alert(params.name);
	});*/
	
	jzlbMonthOption={
	        series: [{
	            type: 'pie',
	            radius : '45%',
	            center: ['50%', '50%'],
	            selectedMode:'single',
	            data: [{
	                value: 100,
	                name: '宽松'
	            }, {
	                value: 200,
	                name: '严格'
	            }, {
	                value: 300,
	                name: '一般'
	            }, {
	                value: 400,
	                name: '其他'
	            }]
	        }]
	   };
	
	nlfbMonthOption={
	        series: [{
	            type: 'pie',
	            radius : '45%',
	            center: ['50%', '50%'],
	            selectedMode:'single',
	            data: [{
	                value: 5,
	                name: '0-20岁'
	            }, {
	                value: 30,
	                name: '20-50岁'
	            }, {
	                value: 10,
	                name: '50-80岁'
	            }, {
	                value: 3,
	                name: '80岁以上'
	            }],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur:0,
	                    shadowOffsetX:0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }]
	   };

/**
 * 按月统计数据
 */
function selectMonth(){
	$("#panel-1").removeClass("active");
	$("#panel-2").addClass("active");
	$("#panel-3").removeClass("active");
	// 人民调解
	//var rmtj_month = echarts.init(document.getElementById('rmtj_month'));
	// 安装帮教
	var azbj_month = echarts.init(document.getElementById('azbj_month'));
	// 法律援助
	var flyz_month = echarts.init(document.getElementById('flyz_month'));
	//矫正人员
	var jzry_month = echarts.init(document.getElementById('jzry_month'));
	//矫正类别
	var jzlb_month = echarts.init(document.getElementById('jzlb_month'));
	//年龄分布
	var nlfb_month = echarts.init(document.getElementById('nlfb_month'));
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

	//$("#panel-2").attr("class","tab-pane active");
	//jzry_month.setOption(jzryMonthOption);
	rmtj_month.setOption(rmtjMonthOption);
	azbj_month.setOption(azbjMonthOption);
	//flyz_month.setOption(flyzMonthOption);
	jzlb_month.setOption(jzlbMonthOption);
	nlfb_month.setOption(nlfbMonthOption);
}