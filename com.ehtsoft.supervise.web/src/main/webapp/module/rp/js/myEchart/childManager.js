var cxbChart,chkxjChart,cjzxzChart;
var cxbOption,chkxjOption,cjzxzOption;
$(function() {
	// 性别分布
	 cxbChart = echarts.init(document.getElementById('cxbChart'));
	 cxbOption =  {
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
		        data: [ ]
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
	//cxbChart.setOption(cxbOption);
	 
	// 户口性质
	 chkxjChart = echarts.init(document.getElementById('chkxjChart'));
	 chkxjOption =    {
		    title : {
		        text: '户口性质占比',
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
		        	 name: '户口性质分布',
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
	//chkxjChart.setOption(chkxjOption);
	 
	// 居住性质
	 cjzxzChart = echarts.init(document.getElementById('cjzxzChart'));
	 cjzxzOption =    {
			title : {
				text: '居住性质占比',
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
			        	  name: '居住性质分布',
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
	//cjzxzChart.setOption(cjzxzOption);
	
	//获取男女比例统计信息
	findnvbl();
	//获取户口性质分布情况
	findhkxz();
	//获取居住性质分布情况
	findjzxz();
});

//获取男女比例统计信息
function findnvbl()
{
	var et = new BAAAETService();
	et.findnvbl({ "BAAA_ET05[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			debugger;
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					cxbOption.series[0].data.push({value:data[i].sum,name:data[i].xb});
					cxbOption.legend.data[i]=data[i].xb;
				}
				cxbChart.setOption(cxbOption);
			}
		}
	}));
}
//获取户口性质分布情况
function findhkxz()
{
	var et = new BAAAETService();
	et.findhkxz({ "BAAA_ET05[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					chkxjOption.series[0].data.push({value:data[i].sum,name:data[i].hkxz});
					chkxjOption.legend.data[i]=data[i].hkxz;
				}
				chkxjChart.setOption(chkxjOption);
			}
		}
	}));
}
//获取居住性质分布情况
function findjzxz()
{
	var et = new BAAAETService();
	et.findjzxz({ "BAAA_ET05[like]" :$("#txtName").val().trim()},new Eht.Responder({
		success : function(data) {
			//从后台返回的数据 data
			if (data!= null&&data.length>0) {
				for (var i = 0; i < data.length; i++) {
					cjzxzOption.series[0].data.push({value:data[i].sum,name:data[i].jzxz});
					cjzxzOption.legend.data[i]=data[i].jzxz;
				}
				cjzxzChart.setOption(cjzxzOption);
			}
		}
	}));
}
