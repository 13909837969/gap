var dcjlbChart,dcjdjChart,dhyChart;
var dcjlbOption,dcjdjOption,dhyOption;
$(function() {
	// 残疾类别
	 dcjlbChart = echarts.init(document.getElementById('dcjlbChart'));
	 dcjlbOption =    {
		    title : {
		        text: '残疾类别占比',
		        x:'right'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a}<br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		        	name:'残疾类别',
		            type: 'pie',
		            radius : '55%',
		            center: ['70%', '60%'],
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
	dcjlbChart.setOption(dcjlbOption);
	// 残疾等级
	dcjdjChart = echarts.init(document.getElementById('dcjdjChart'));
	dcjdjOption =    {
			title : {
				text: '残疾等级占比',
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
			        	  name:'残疾等级',
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
	dcjdjChart.setOption(dcjdjOption);
	// 婚姻状态
	 dhyChart = echarts.init(document.getElementById('dhyChart'));
	 dhyOption =    {
			title : {
				text: '婚姻状态分析',
				x:'right'
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
			        	  name:'婚姻状态',
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
	dhyChart.setOption(dhyOption);
	findcjlb();
	findcjdj();
	findhy();
});
//按照残疾类别统计信息
function findcjlb()
{
	var rc = new BAAACJService();
	rc.findcjlb({ "BAAA_CJ02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					dcjlbOption.series[0].data.push({value:data[i].num,name:data[i].cjlb});
					dcjlbOption.legend.data[i]=data[i].cjlb;
				}
				dcjlbChart.setOption(dcjlbOption);
			}
		}
	}));
}
//按残疾等级统计
function findcjdj()
{
	var rc = new BAAACJService();
	rc.findcjdj({ "BAAA_CJ02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					dcjdjOption.series[0].data.push({value:data[i].num,name:data[i].cjdj});
					dcjdjOption.legend.data[i]=data[i].cjdj;
				}
				dcjdjChart.setOption(dcjdjOption);
			}
		}
	}));
}
//按婚姻统计
function findhy()
{
	var rc = new BAAACJService();
	rc.findhy({ "BAAA_CJ02[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length&&i<10; i++) {
					dhyOption.series[0].data.push({value:data[i].num,name:data[i].hy});
					dhyOption.legend.data[i]=data[i].hy;
				}
				dhyChart.setOption(dhyOption);
			}
		}
	}));
}