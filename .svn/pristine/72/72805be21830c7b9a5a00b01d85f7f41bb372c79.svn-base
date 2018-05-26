/*
 * pad综合统计分析-按季度
 */
var /*jzryQuarterption,*//*rmtjQuarterption,*/azbjQuarterption,/*flyzQuarterption,*/jzlbQuarterption,nlfbQuarterption;
/*// 矫正人员
jzryQuarterption = {
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
	data : ['17年4季度', '18年1季度' ],
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
		data : [  112,76,]
	} ]
};*/

// 人民调解
/*rmtjQuarterption = {
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
	data : ['17年4季度', '18年1季度' ],
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
		data : [34, 34,]
	} ]
};*/

// 安装帮教
azbjQuarterption = {
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
	data  : ['17年4季度', '18年1季度' ],
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
		data : [128,123]
	} ]
};

// 法律援助
/*flyzQuarterption = {
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
	data : ['17年4季度','18年1季度'],
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
		data : [13, 5]
	} ]
};

jzlbQuarterption={
        series: [{
            type: 'pie',
        radius : '45%',
        center: ['50%', '50%'],
        selectedMode:'single',
        data: [{
            value: 5,
            name: '宽松'
        }, {
            value: 1,
            name: '严格'
        }, {
            value: 3,
            name: '一般'
        }, {
            value: 4,
            name: '其他'
            }]
        }]
   };

nlfbQuarterption={
        series: [{
            type: 'pie',
        radius : '45%',
        center: ['50%', '50%'],
        selectedMode:'single',
        data: [{
            value: 5,
            name: '0-20岁'
        }, {
            value: 20,
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
  };*/
	
/**
 * 按季度统计数据
 */
function selectQuarter(){
	$("#panel-1").removeClass("active");
	$("#panel-2").removeClass("active");
	$("#panel-3").addClass("active");
	// 人民调解
	//var rmtj_quarter = echarts.init(document.getElementById('rmtj_quarter'));
	// 安装帮教
	var azbj_quarter = echarts.init(document.getElementById('azbj_quarter'));
	// 法律援助
	var flyz_quarter = echarts.init(document.getElementById('flyz_quarter'));
	// 矫正人员
	var jzry_quarter = echarts.init(document.getElementById('jzry_quarter'));
	// 矫正类别
	var jzlb_quarter = echarts.init(document.getElementById('jzlb_quarter'));
	// 年龄分布
	var nlfb_quarter = echarts.init(document.getElementById('nlfb_quarter'));
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
	//jzry_quarter.setOption(jzryQuarterption);
	// 添加点击事件
	jzry_quarter.on('click', function(params) {
		showJzryDetail(params.name)
	});
	
	rmtj_quarter.setOption(rmtjQuarterption);
	// 添加点击事件
	jzry_quarter.on('click', function(params) {
		showRmtjDetail(params.name)
	});
	
	azbj_quarter.setOption(azbjQuarterption);
	
	//flyz_quarter.setOption(flyzQuarterption);
	// 添加点击事件
	flyz_quarter.on('click', function(params) {
		alert(params.name);
	});
	
	jzlb_quarter.setOption(jzlbQuarterption);
	nlfb_quarter.setOption(nlfbQuarterption);
}