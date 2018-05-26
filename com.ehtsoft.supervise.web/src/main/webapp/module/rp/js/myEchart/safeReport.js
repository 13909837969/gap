var syhlxChart,scljgChart,ssblxChart;
var syhlxOption,chkxjOption,ssblxOption;
$(function() {
	// 安全隐患类型
	 syhlxChart = echarts.init(document.getElementById('syhlxChart'));
	 syhlxOption =  {
		    title : {
		        text: '安全隐患类型',
		        x:'right'
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
		        	 name: '安全隐患类型',
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
	//syhlxChart.setOption(syhlxOption);
	 
	// 处理结果
	 scljgChart = echarts.init(document.getElementById('scljgChart'));
	 chkxjOption =    {
		    title : {
		        text: '处理结果',
		        x:'right'
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
		        	 name: '处理结果',
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
	//scljgChart.setOption(chkxjOption);
	 
	// 上报类型
	 ssblxChart = echarts.init(document.getElementById('ssblxChart'));
	 ssblxOption =    {
			title : {
				text: '上报类型',
				x:'right'
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
			        	  name: '上报类型',
			        	  type: 'pie',
			        	  radius : '55%',
			        	  center: ['50%', '60%'],
			        	  data:[],
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
	//ssblxChart.setOption(ssblxOption);
	
	//获取安全隐患类型
	findaqyhlx();
	//获取是否处理
	findsfcl();
	//获取上报类型
	findsblx();
});

//获取安全隐患类型
function findaqyhlx()
{
	var et = new EAAAService();
	et.findaqyhlx({ "EAAA09[eq]" :$("#sfjj").val()},new Eht.Responder({
		success : function(data) {
			debugger;
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					syhlxOption.series[0].data.push({value:data[i].sum,name:data[i].yhlx});
					syhlxOption.legend.data[i]=data[i].yhlx;
				}
				syhlxChart.setOption(syhlxOption);
			}
		}
	}));
}
//获取处理结果
function findsfcl()
{
	var et = new EAAAService();
	et.findsfcl({ "BAAA_ET05[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					chkxjOption.series[0].data.push({value:data[i].sum,name:data[i].sfcl});
					chkxjOption.legend.data[i]=data[i].sfcl;
				}
				scljgChart.setOption(chkxjOption);
			}
		}
	}));
}
//获取上报类型
function findsblx()
{
	var et = new EAAAService();
	et.findsblx({ "BAAA_ET05[like]" :$("#txtName").val()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					ssblxOption.series[0].data.push({value:data[i].sum,name:data[i].sblx});
					ssblxOption.legend.data[i]=data[i].sblx;
				}
				ssblxChart.setOption(ssblxOption);
			}
		}
	}));
}
