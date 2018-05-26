<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<html>
	<head>
		<title>签到信息分析</title>
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<%if(!"load".equals(request.getParameter("load"))){ %>
		<script type="text/javascript" src="${localCtx}/json/SigninService.js"></script>
		<%}%>
		<script type="text/javascript">
		$(function(){
			var service = new SigninService();
			var ca = new Eht.Calendar({
				selector : "#listQdgl_modal_body"
			});
			debugger;
			service.findOne("${param.aid}", new Eht.Responder({
				success : function(data){
					var countRlqd = 0;
					var countZwqd = 0;
					var countSyqd = 0;
					ca.eachDay(function(date,td) {
						var v = data[date];//data是2017-11-11:{key:value,key:value}
						if (v != null && v.qdlx=="人脸签到") {
							countRlqd++;
							td.css("background","#82B1FF");
							var d = date.split("-");
							return '<div><div>' + parseInt(d[2])
									+ '</div><div>' + v.qdlx + '</div></div>';
						}else if(v != null && v.qdlx=="声纹签到"){
							countSyqd++;
							td.css("background","#B388FF");
							var d = date.split("-");
							return '<div><div>' + parseInt(d[2])
									+ '</div><div>' + v.qdlx + '</div></div>';
						}else if(v != null && v.qdlx=="指纹签到"){
							countZwqd++;
							td.css("background","#8C9EFF");
							var d = date.split("-");
							return '<div><div>' + parseInt(d[2])
									+ '</div><div>' + v.qdlx + '</div></div>';
						}
					});
					ca.show();
					var myChart = echarts.init(document.getElementById("main_div2"));
					var	option = {
							    title : {
							        text: '签到数据统计分析',
							        subtext: '实时统计',
							        x:'center'
							    },
							    tooltip : {
							        trigger: 'item',
							        formatter: "{a} <br/>{b} : {c} ({d}%)"
							    },
							    legend: {
							        orient: 'vertical',
							        left: 'left',
							        data: ['指纹签到','声音签到','人脸签到']
							    },
							    series : [
							        {
							            name: '签到数据',
							            type: 'pie',
							            radius : '45%',
							            center: ['50%', '50%'],
							            data:[
							                
							                {value:countZwqd, name:'指纹签到'},
							                {value:countSyqd, name:'声音签到'},
							                {value:countRlqd, name:'人脸签到'}
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
					myChart.setOption(option);
				}
			}));
		});
		</script>
	</head>
	<body>
	<div>
		<div id="listQdgl_modal_body">
		</div>
		<div id="main_div2" style="width: 500px;height:400px;">
		</div>
	</div>
	</body>
</html>