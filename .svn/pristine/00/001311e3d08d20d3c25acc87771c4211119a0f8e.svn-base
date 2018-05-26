var  snlChart,sxbChart,sdsChart;
var  snlOption,sxbOption,sdsOption;
$(function() {
	// 年龄分布情况
	 snlChart = echarts.init(document.getElementById('snlChart'));
	 snlOption =   {
		    title : {
		        text: '年龄分布情况',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		            name: '年龄分布情况',
		            type: 'pie',
		            radius : '55%',
		            center: ['62%', '60%'],
		            data:[
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
	snlChart.setOption(snlOption);
	
	// 性别分布
	 sxbChart = echarts.init(document.getElementById('sxbChart'));
	 sxbOption =  {
		    title : {
		        text: '性别分布',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		        	name:"性别分布情况",
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		               
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

	sxbChart.setOption(sxbOption);
	// 是否单身
	sdsChart = echarts.init(document.getElementById('sdsChart'));
	sdsOption =   {
		    title : {
		        text: '婚姻状况分析',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: [ ]
		    },
		    series : [
		        {
		        	name:"婚姻状况分析",
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		              
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
	sdsChart.setOption(sdsOption);
	
	findnvbl();
	findnld();
	findhyzk();
});

//获取男女比例统计信息
function findnvbl()
{
	var db = new BAAADBService();
	db.findnvbl({ "BAAA_DB04[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					sxbOption.series[0].data.push({value:data[i].sum,name:data[i].xb});
					sxbOption	.legend.data[i]=data[i].xb;
				}
				sxbChart.setOption(sxbOption);
			}
		}
	}));
}
//按年龄段统计信息
function findnld()
{
	var db = new BAAADBService();
	db.findnld({ "BAAA_DB04[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					snlOption.series[0].data.push({value:data[i].num,name:data[i].nld});
					snlOption	.legend.data[i]=data[i].nld;
				}
				snlChart.setOption(snlOption);
			}
		}
	}));
}

//获取婚姻状况统计信息
function findhyzk()
{
	var db = new BAAADBService();
	db.findhyzk({ "BAAA_DB04[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					sdsOption.series[0].data.push({value:data[i].sum,name:data[i].hyzk});
					sdsOption	.legend.data[i]=data[i].hyzk;
				}
				sdsChart.setOption(sdsOption);
			}
		}
	}));
}