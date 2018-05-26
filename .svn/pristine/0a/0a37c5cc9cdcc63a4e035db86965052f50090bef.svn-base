var oxbChart,ohyzkChart,onlChart,oxqpmChart;
var oxbOption,ohyzkOption,onlOption,oxqpmOption;
$(function() {
	// 性别分布
	oxbChart = echarts.init(document.getElementById('oxbChart'));
	oxbOption =  {
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
		        	name:'性别分布',
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

	//oxbChart.setOption(oxbOption);
	// 婚姻状况
	 ohyzkChart = echarts.init(document.getElementById('ohkxjChart'));
	 ohyzkOption =    {
		    title : {
		        text: '婚姻状况',
		        x:'center'
		    }, 
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: [
		               ]
		    },
		    series : [
		        {
		        	name:'婚姻状况分布',
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
	//ohkxjChart.setOption(ohkxjOption);
	// 年龄分布情况
	 onlChart = echarts.init(document.getElementById('ojzxzChart'));
	 onlOption =    {
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
			        	  name:'年龄分布情况',
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
	//ojzxzChart.setOption(ojzxzOption);
	// 老年化小区排名
	 oxqpmChart = echarts.init(document.getElementById('oxqpmChart'));
	 oxqpmOption =   {
			title : {
				text: '-----------------老年化小区排名-----------------',
				x:'center'
			},
		    tooltip : {
		        trigger: 'axis',
		        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
		            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            data : [],
		            axisTick: {
		                alignWithLabel: true
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'老年人分布情况',
		            type:'bar',
		            barWidth: '60%',
		            data:[]
		        }
		    ]
		};
	//oxqpmChart.setOption(oxqpmOption);
	findnvbl();
	findhyzk();
	findnld();
	findxlpm();
});

//获取男女比例统计信息
function findnvbl()
{
	var lnr = new BAAALNRService();
	lnr.findnvbl({ "BAAA_LNR02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					oxbOption.series[0].data.push({value:data[i].sum,name:data[i].xb});
					oxbOption.legend.data[i]=data[i].xb;
				}
				oxbChart.setOption(oxbOption);
			}
		}
	}));
}
//获取婚姻状况统计信息
function findhyzk()
{
	var lnr = new BAAALNRService();
	lnr.findhyzk({ "BAAA_LNR02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					ohyzkOption.series[0].data.push({value:data[i].sum,name:data[i].hyzk});
					ohyzkOption	.legend.data[i]=data[i].hyzk;
				}
				ohyzkChart.setOption(ohyzkOption);
			}
		}
	}));
}
//按年龄段统计信息
function findnld()
{
	var lnr = new BAAALNRService();
	lnr.findnld({ "BAAA_LNR02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					onlOption.series[0].data.push({value:data[i].num,name:data[i].nld});
					onlOption.legend.data[i]=data[i].nld;
				}
				onlChart.setOption(onlOption);
			}
		}
	}));
}
//获取小区老年人排名统计信息
function findxlpm()
{
	var lnr = new BAAALNRService();
	lnr.findxlpm({ "BAAA_LNR02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length&&i<30; i++) {
					oxqpmOption.series[0].data[i]=data[i].sum;
					if(data[i].xq!=null)
						oxqpmOption.xAxis[0].data[i]=data[i].xq;
					else
						oxqpmOption.xAxis[0].data[i]="未知";	
				}
				oxqpmChart.setOption(oxqpmOption);
			}
		}
	}));
}
