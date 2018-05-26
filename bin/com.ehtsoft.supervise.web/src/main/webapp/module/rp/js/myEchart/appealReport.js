var asqpmChart;
var asqpmOption;
$(function() {
	// 居民投诉社区排名
	 asqpmChart = echarts.init(document.getElementById('asqpmChart'));
	 asqpmOption =   {
			title : {
				text: '居民投诉社区排名',
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
		            name:'居民投诉占比',
		            type:'bar',
		            barWidth: '60%',
		            data:[]
		        }
		    ]
		};
	//asqpmChart.setOption(asqpmOption);
	findsqpm();
});
//居民投诉社区排名
function findsqpm()
{
	var lnr = new BAAALNRService();
	lnr.findxlpm({ "BAAA_LNR02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length&&i<30; i++) {
					asqpmOption.series[0].data[i]=data[i].sum;
					if(data[i].xq!=null)
						asqpmOption.xAxis[0].data[i]=data[i].xq;
					else
						asqpmOption.xAxis[0].data[i]="未知";	
				}
				asqpmChart.setOption(asqpmOption);
			}
		}
	}));
}
