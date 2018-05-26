var txbpChart,nlChart,txlChart;
var txbpOption,nlOption,txlOption;

$(function() {
	// 年龄性别分布情况
	 nlChart = echarts.init(document.getElementById('nlChart'));
	 nlOption =   {
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
		            data:[ ],
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
	//nlChart.setOption(nlOption);
	
	// 性别分布
	txbpChart = echarts.init(document.getElementById('txbpChart'));
	txbpOption =  {
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
		        data: ['男性','女性']
		    },
		    series : [
		        {
		        	name:'性别分布',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[ ],
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
	//txbpChart.setOption(txbpOption);
	//学历排名
	 txlChart = echarts.init(document.getElementById('txlChart'));
	 txlOption =   {
			title : {
				text: '学历排名',
				x:'center'
			},
		    color: ['#3398DB'],
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
		            name:'学历排名',
		            type:'bar',
		            barWidth: '60%',
		            data:[]
		        }
		    ]
		};
	//txlChart.setOption(txlOption);
	
	//获取男女比例统计信息
	findnvbl();
	//获取年龄分布情况
	findnld();
	//获取学历排名信息
	findxlpm();
});
//获取男女比例统计信息
function findnvbl()
{
	
	var rc = new BAAARCService();
	rc.findnvbl({ "BAAA_RC02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			txbpOption.series[0].data=[];
			txbpOption.legend.data=[];
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					txbpOption.series[0].data.push({value:data[i].sum,name:data[i].xb});
					txbpOption.legend.data[i]=data[i].xb;
				}
				txbpChart.setOption(txbpOption);
			}
		}
	}));
}
//按年龄段统计信息
function findnld()
{
	var rc = new BAAARCService();
	rc.findnld({ "BAAA_RC02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			nlOption.series[0].data=[];
			nlOption.legend.data=[];
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					nlOption.series[0].data.push({value:data[i].num,name:data[i].nld});
					nlOption.legend.data[i]=data[i].nld;
				}
				nlChart.setOption(nlOption);
			}
		}
	}));
}
//获取学历排名信息
function findxlpm()
{
	var rc = new BAAARCService();
	rc.findxlpm({ "BAAA_RC02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length&&i<10; i++) {
					txlOption.series[0].data[i]=data[i].sum;
					if(data[i].xl!=null)
						txlOption.xAxis[0].data[i]=data[i].xl;
					else
						txlOption.xAxis[0].data[i]="未知";	
				}
				txlChart.setOption(txlOption);
			}
		}
	}));
}
