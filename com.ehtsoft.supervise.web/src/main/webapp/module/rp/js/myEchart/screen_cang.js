var dcjdjChart,ohyzkChart,snlChart,cxbChart,unlChart,rcnlChart;
var dcjdjOption,ohyzkOption,snlOption,cxbOption,unlOption,rcnlOption;
$(function() {
	// 管理等级
	dcjdjChart = echarts.init(document.getElementById('cjChart'));
	dcjdjOption =    {
			title : {
				textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
				text: '管理等级',
				x:'right'
			},
			tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
			legend: {
				orient: 'vertical',
				left: 'left',
				textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
				data: []
			},
			series : [
			          {
			        	  name:'管理等级',
			        	  type: 'pie',
			        	  radius : '50%',
			        	  center: ['65%', '60%'],
			        	  label: {
			                  normal: {
			                      textStyle: {
			                          color: '#fff'
			                      }
			                  }
			              },
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
    //教育矫正
	 ohyzkChart = echarts.init(document.getElementById('lxChart'));
	 ohyzkOption =    {
		    title : {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
		        text: '教育矫正',
		        x:'right'
		    }, 
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
		        orient: 'vertical',
		        left: 'left',
		        data: [
		               ]
		    },
		    series : [
		        {
		        	name:'教育矫正',
		            type: 'pie',
		            radius : '55%',
		            center: ['62%', '60%'],
		            label: {
		                  normal: {
		                      textStyle: {
		                          color: '#fff'
		                      }
		                  }
		              },
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
	//帮困扶贫
	 snlChart = echarts.init(document.getElementById('dbChart'));
	 snlOption =   {
		    title : {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
		        text: '帮困扶贫',
		        x:'right'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		            name: '帮困扶贫',
		            type: 'pie',
		            radius : '55%',
		            center: ['66%', '60%'],
		            label: {
		                  normal: {
		                      textStyle: {
		                          color: '#fff'
		                      }
		                  }
		              },
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
	 // 惩戒情况
	 cxbChart = echarts.init(document.getElementById('etChart'));
	 cxbOption =  {
		    title : {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
		        text: '惩戒情况',
		        x:'right'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		        	 name: '惩戒情况',
		            type: 'pie',
		            radius : '55%',
		            center: ['60%', '60%'],
		            label: {
		                  normal: {
		                      textStyle: {
		                          color: '#fff'
		                      }
		                  }
		              },
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
	//队伍建设
	 rcnlChart = echarts.init(document.getElementById('etnbChart'));
	 rcnlOption =   {
		    title : {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
		        text: '队伍建设',
		        x:'right'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		            name: '队伍建设',
		            type: 'pie',
		            radius : '55%',
		            center: ['53%', '60%'],
		            label: {
		                  normal: {
		                      textStyle: {
		                          color: '#fff'
		                      }
		                  }
		              },
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
	// 基地工作建设
	 unlChart = echarts.init(document.getElementById('syrChart'));
	 unlOption =   {
		    title : {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '18',
				},
		        text: '基地工作建设',
		        x:'right'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		    	textStyle:{
					color: '#fff',
		   			fontSize: '12',
				},
		        orient: 'vertical',
		        left: 'left',
		        data: []
		    },
		    series : [
		        {
		            name: '基地工作建设',
		            type: 'pie',
		            radius : '55%',
		            center: ['62%', '60%'],
		            label: {
		                  normal: {
		                      textStyle: {
		                          color: '#fff'
		                      }
		                  }
		              },
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
	findcjdj();
	findhyzk();
	findnvbl();
	findsynld();
	findrcnld();
	finddbnld();
});

//管理等级
function findcjdj()
{
	dcjdjOption.series[0].data=[
	                            {value:546, name:'初期矫正'},
	                            {value:899, name:'宽松管理'},
	                            {value:75, name:'普通管理'},
	                            {value:24, name:'严格管理'}
	                        ];
	dcjdjOption.legend.data= ['初期矫正','宽松管理','普通管理','严格管理'];
	dcjdjChart.setOption(dcjdjOption);
}
//教育矫正
function findhyzk()
{
	ohyzkOption.series[0].data=[
	                            {value:20, name:'集中教育'},
	                            {value:35, name:'个别谈话教育'},
	                            {value:18, name:'进行心理辅导'},
	                            {value:0, name:'社区服务'}
	                        ];
	ohyzkOption.legend.data= ['集中教育','个别谈话教育','进行心理辅导','社区服务'];
	ohyzkChart.setOption(ohyzkOption);
}

//帮困扶贫
function finddbnld()
{
	snlOption.series[0].data=[
	                            {value:20, name:'落实低保'},
	                            {value:310, name:'指导就业或就学'},
	                            {value:234, name:'技能培训'},
	                            {value:135, name:'落实承包田'},
	                            {value:135, name:'其他'}
	                        ];
	snlOption.legend.data= ['落实低保','指导就业或就学','技能培训','落实承包田','其他'];
	snlChart.setOption(snlOption);
}

//惩戒情况
function findnvbl()
{
	
	cxbOption.series[0].data=[
	                            {value:335, name:'减刑'},
	                            {value:310, name:'警告'},
	                            {value:234, name:'治安处罚'},
	                            {value:234, name:'再犯罪'},
	                            {value:135, name:'收监执行'}
	                        ];
	cxbOption.legend.data= ['减刑','警告','治安处罚','收监执行','再犯罪'];
	cxbChart.setOption(cxbOption);
}
//队伍建设
function findsynld()
{
	unlOption.series[0].data=[
	                            {value:212, name:'专职工作人员'},
	                            {value:8, name:'专职社会工作者'},
	                            {value:35, name:'社会志愿者'}
	                        ];
	unlOption.legend.data= ['专职工作人员','专职社会工作者','社会志愿者'];
	unlChart.setOption(unlOption);
}
//基地工作建设
function findrcnld()
{
	rcnlOption.series[0].data=[
	                            {value:2, name:'已建立就业基地'},
	                            {value:2, name:'已建立教育基地'},
	                            {value:5, name:'已建立社区服务基地'},
	                            {value:6, name:'已建立社区矫正中心'}
	                        ];
	//rcnlOption.legend.data= ['已建立就业基地','已建立教育基地','已建立社区服务基地','已建立社区矫正中心'];
	rcnlChart.setOption(rcnlOption);
	
}