$(function() {
	//新版社区矫正首页
	var jzsy = new SyJzzlSerivce();
	var data_zc = new Array();//在册数据
	jzsy.findZcrs(new Eht.Responder({
		success:function(datas){
			
			for (var i = 0; i < datas.length; i++) {
				data_zc.push(
						{
						name: datas[i].name,
		                value: datas[i].value
		                } 
						);
			}
			var dom = document.getElementById("viewSqjzSy_style_bar1");
			var myChart = echarts.init(dom);
			var app = {};
			app.title = '环形图';
			option = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        x: 'right',
			        data:['假释','缓刑','管制','其他']
			    },
			    series: [
			        {
			            name:'在册人数',
			            type:'pie',
			            radius: ['50%', '70%'],
			            avoidLabelOverlap: false,
			            color: ['#1ec3c8','#ff604f','#2dcb73','#20aae5'],
			            label: {
			                normal: {
			                    show: true,
			                    position: 'center',
			                    formatter: '在册人数',
			                    color:'#333',
			                    fontSize: 20,
			                    
			                },
			                emphasis: {
			                    show: false,
			                    textStyle: {
			                        fontSize: '30',
			                        fontWeight: 'bold'
			                    }
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:data_zc
			        }
			    ]
			};
			if (option && typeof option === "object") {
			    myChart.setOption(option, true);
			};
				
			
		}}));
	
	//管理等级
	var data_gl = new Array();
	jzsy.findJzlx(new Eht.Responder({
		success:function(datas){
			for (var i = 0; i < datas.length; i++) {
				data_gl.push(
						{
						name: datas[i].name,
		                value: datas[i].value
		                } 
						);
			}
			var dom = document.getElementById("viewSqjzSy_style_bar2");
			var myChartb = echarts.init(dom);
			var app = {};
			app.title = '环形图';

			option = {
			    tooltip: {
			        trigger: 'item',
			        formatter: "{a} <br/>{b}: {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        data:['严管','宽管','普管'],
			        x: 'right'
			    },
			    series: [
			        {
			            name:'管理等级',
			            type:'pie',
			            radius: ['50%', '70%'],
			            avoidLabelOverlap: false,
			            color: ['#e72325', '#98e002', '#2ca3fd'],
			            label: {
			                normal: {
			                    show: true,
			                    position: 'center',
			                    formatter: '管理等级',
			                    color:'#333',
			                    fontSize: 20,
			                    
			                },
			                emphasis: {
			                    show: false,
			                    textStyle: {
			                        fontSize: '30',
			                        fontWeight: 'bold'
			                    }
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:data_gl
			        }
			    ]
			};
			if (option && typeof option === "object") {
			    myChartb.setOption(option, true);
			};
		}}));
	
	//矫正人员3
	jzsy.findDblb(new Eht.Responder({
		success:function(data){
		$("#jx").html(data[0].jx);
		$("#wcn").html(data[1].wcn);
		$("#qj").html(data[2].qj);
		$("#tg").html(data[3].tg);
		$("#jzl").html(data[4].jzl);
		$("#wbd").html(data[5].wbd);
		}}));
	
	
	
	
	
	//第三部分 
	//对月份 及 季度 进行  js的判断 是否可选  month_sel jidu_sel

	jzsy.findJzry({"year":$("#year_sel").val(),"jidu":$("#jidu_sel").val(),"month": $("#month_sel").val()},new Eht.Responder({
		success:function(data){
			$("#yz").html(data[0].yz);
			$("#xj").html(data[1].xj);
			$("#wj").html(data[2].wj);
			$("#jc").html(data[3].jc);
			$("#sx").html(data[4].sx);
			$("#zz").html(data[5].zz);
			$("#fa").html(data[6].fa);
			$("#wc").html(data[7].wc);
		}}));
});