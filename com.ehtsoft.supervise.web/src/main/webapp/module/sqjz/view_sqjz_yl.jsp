<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>在册矫正总数</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqylService.js"></script>
<script type="text/javascript">
$(function(){
	var service = new SqylService();
	var data_lxname = new Array(); //数组对象
	var data_lx_y = new Array(); //数组对象
	var data_lx_k = new Array(); //数组对象
	var data_lx_p = new Array(); //数组对象
	service.finddataToecharts(new Eht.Responder({success:function(data){
			for (var i = 0; i < data.length; i++) {
			data_lxname.push(data[i].city_name);
					data_lx_k.push({value: data[i].jzrys == ''? 0 : data[i].jzrys1});
					data_lx_p.push({value: data[i].jzrys == ''? 0 : data[i].jzrys2});
					data_lx_y.push({value: data[i].jzrys == ''? 0 : data[i].jzrys3});
			}
			//对接图表
			var dom = document.getElementById("zctb");
			var myChart = echarts.init(dom);
			option = {
			    tooltip : {
			        trigger: 'axis',
			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
			        }
			    },
			    legend: {
			        data: ['宽管', '严管','普管']
			    },
			    grid: {
			        left: '3%',
			        right: '4%',
			        bottom: '3%',
			        containLabel: true
			    },
			    xAxis:  {
			        type: 'value'
			    },
			    yAxis: {
			        type: 'category',
			        data: data_lxname
			    },
			    series: [
			        {
			            name:'宽管',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            data: data_lx_k
			        },
			        {
			        	 name:'普管',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            data: data_lx_p
			        },
			        {
			        	 name:'严管',
			            type: 'bar',
			            stack: '总量',
			            label: {
			                normal: {
			                    show: true,
			                    position: 'insideRight'
			                }
			            },
			            data: data_lx_y
			        }
			    ]
			};
			    myChart.setOption(option, true);
	}}));
});
	
</script>
</head>
<body>
	<div>
		<div id="zctb" style=" height:400px;background-color: #a1a1de;">
		</div>
		<div></div>
	</div>
</body>
</html>