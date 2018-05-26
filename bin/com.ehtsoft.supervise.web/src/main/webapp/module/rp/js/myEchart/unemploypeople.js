var unlChart,uxbChart,udsChart;
var unlOption,uxbOption,udsOption;
$(function() {
	// 年龄性别分布情况
	 unlChart = echarts.init(document.getElementById('unlChart'));
	 unlOption =   {
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
		            name: '年龄分布',
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
	unlChart.setOption(unlOption);
	
	// 性别分布
	 uxbChart = echarts.init(document.getElementById('uxbChart'));
	 uxbOption =  {
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
		        	name: '性别分布',
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

	uxbChart.setOption(uxbOption);
	// 是否单身
	 udsChart = echarts.init(document.getElementById('udsChart'));
	 udsOption =   {
		    title : {
		        text: '是否单身分析',
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
		        	name:'是否单身',
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
	udsChart.setOption(udsOption);
	findnvbl();
	findnld();
	findhyzk();
});
//获取男女比例统计信息
function findnvbl()
{
	var sy = new BAAASYService();
	sy.findnvbl({ "BAAA_SY02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			debugger;
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					uxbOption.series[0].data.push({value:data[i].sum,name:data[i].xb});
					uxbOption.legend.data[i]=data[i].xb;
				}
				uxbChart.setOption(uxbOption);
			}
		}
	}));
}
//按年龄段统计信息
function findnld()
{
	var sy = new BAAASYService();
	sy.findnld({ "BAAA_SY02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					unlOption.series[0].data.push({value:data[i].num,name:data[i].nld});
					unlOption.legend.data[i]=data[i].nld;
				}
				unlChart.setOption(unlOption);
			}
		}
	}));
}
//获取婚姻状况分布情况
function findhyzk()
{
	var sy= new BAAASYService();
	sy.findhyzk({ "BAAA_SY02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					udsOption.series[0].data.push({value:data[i].sum,name:data[i].hyzk});
					udsOption.legend.data[i]=data[i].hyzk;
				}
				udsChart.setOption(udsOption);
			}
		}
	}));
}
