<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>人民调解机构信息获取</title>
<style type="text/css">
div{
	text-align:center;
}
/*隐藏区域 div的样式*/
#spsflyz-hidenDiv{
	width: 350px;
    height: 360px;
    background-color: #fff;
    z-index:99999;
    position: absolute;
    top:84px;
    left:43px;
    box-shadow:1px 0px 3px #ccc; 
    margin-top: 55px; 
	}
#spsSqjz-hidenDiv-div1{
	height:35px;
	border-bottom:1px solid #E0E0E0;
	}
#spsSqjz-hidenDiv-div11{
	margin-left:10px;
	margin-top:16px;
	font-weight:bold;
	font-size:16px;
	}
#spsSqjz-hidenDivSS{
	height:300px;
	overflow:auto;
	font-size:12px;
	}
#spsSqjz-hidenDiv-div1{
	height:35px;
	border-bottom:1px solid #E0E0E0;
}
#spsSqjz-hidenDivSS{
	height:300px;
	overflow:auto;
}
.hidden-div-li{
	display:inline-block;
	font-size:14px;
	list-style: none;
	font-weight:normal;
	width:190px;
}
.hidden-div-ul{
	font-size:16px;
	font-weight:bold;
	list-style: none;
}
.btn-info{
	background:#0d9bff;
	border:0px;
	border-radius:5px;
	}
#spsSqjz-hidenDivBtn{
	position: absolute;
    right: 5px;
    top: 22px;
    font-size: 20px;
    z-index:99999;
}
#spsSqjz-hidenDiv-qc{
	font-size: 14px;
    color: #ffffff;
    background-color:#fb8c00;
    position: absolute;
    right: 85px;
    top: 358px;
}
#spsSqjz-hidenDiv-qd{
	font-size: 14px;
    color: #ffffff;
    background-color:#246af6;
    position: absolute;
    right: 20px;
    top: 358px;
}
.btn-info:hover{
	background:#3273f5;
	border:0px;
	border-radius:5px;
	}
.hidden-div-ul{
	font-size:16px;
	font-weight:bold;
	list-style: none;
	cursor:pointer;
	}
/*灏忎笁瑙掓牱寮�*/
.spssjfx-indicate{
	width:10px;
	height:10px;
	position:absolute;
	top:-20px;
	left:50px;
	border-style:solid;
	border-width:10px;
	border-color:transparent transparent #fff transparent;
}
/*滚动条样式*/
#spsSqjz-hidenDivSS{
    overflow-x: hidden;
    overflow-y: auto;
    }
#spsSqjz-hidenDivSS::-webkit-scrollbar {
	width: 7px;    
    height: 4px;
    opacity:0.5;
}
#spsSqjz-hidenDivSS::-webkit-scrollbar-thumb {
	border-radius: 10px;
	/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
    background:#a4cde5;
    margin-right:2px;
    
}

.ui-state-default{
	text-align:center;
}


</style>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RmtjjgxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript">
	$(function() {
		//链接Service
		var Service = new RmtjjgxxService();
		//左侧col-md-3内容排版
		var form = new Eht.Form({
			selector : '#listRmtjjgxx_list #form_lsxxhq',
			autolayout : true,
			colLabel:"col-sm-5 col-xs-5",
			colCombo:"col-sm-7 col-xs-7"
		});

		//右侧col-md-9内容排版
		var tableView = new Eht.TableView({
			selector : "#listRmtjjgxx_list  #list_lsxxhq",
			autolayout:true,		
			});
		
		//模态框
		var form_mtk = new Eht.Form({
			selector:'#listRmtjjgxx_list #jzjzlxx-form',
			autolayout:true,
			formCol:2,
			});	
		
	
		//文化程度
		var dom = document.getElementById("rofm-ZxfsMsQX-fl");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        textStyle:{
			        	 
			        },
			        data: ['村调委会','居（社区）调委会','乡镇调委会','街道调委会','企事业单位调委会','行业性专业性调委会','其他调委会']
			    },
			    series : [
			        {
			            name: '访问来源',
			            type: 'pie',
			            radius : '65%',
			            center: ['70%', '50%'],
			            data:[
			                {value:335, name:'村调委会'},
			                {value:310, name:'居（社区）调委会'},
			                {value:234, name:'乡镇调委会'},
			                {value:135, name:'街道调委会 '},
			                {value:400, name:'企事业单位调委会'},
			                {value:388, name:'行业性专业性调委会'},
			                {value:300, name:'其他调委会'}
			            ],
			        }
			    ],
			    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960','#00F5FF','#CD8500','#7FFF00'] 
			};
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//民族分布
		var dom = document.getElementById("rofm-ZxfsMsQX");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        textStyle:{
		        	 
		        },
		        data: ['赤峰','呼和浩特','通辽','巴盟']
		    },
		    series : [
		        {
		            type: 'pie',
		            radius : '65%',
		            center: ['50%', '50%'],
		            selectedMode: 'single',
		            data:[
		                {value:55193, name: '赤峰'},
		                {value:15243, name: '呼和浩特'},
		                {value:64614, name: '通辽'},
		                {value:8888, name: '巴盟'},
		            ],
		        }
		    ],
		    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960']
		    
		};
		;
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//隐藏的文化程度
		var dom = document.getElementById("rofm-lsxxhq-1");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        textStyle:{
			        	 
			        },
			        data: ['村调委会','居（社区）调委会','乡镇调委会','街道调委会','企事业单位调委会','行业性专业性调委会','其他调委会']
			    },
			    series : [
			        {
			            name: '访问来源',
			            type: 'pie',
			            radius : '65%',
			            center: ['70%', '50%'],
			            data:[
			                {value:335, name:'村调委会'},
			                {value:310, name:'居（社区）调委会'},
			                {value:234, name:'乡镇调委会'},
			                {value:135, name:'街道调委会 '},
			                {value:400, name:'企事业单位调委会'},
			                {value:388, name:'行业性专业性调委会'},
			                {value:300, name:'其他调委会'}
			            ],
			        }
			    ],
			    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960','#00F5FF','#CD8500','#7FFF00'] 
			};
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//民族分布
		var dom = document.getElementById("rofm-lsxxhq-2");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        textStyle:{
		        	 
		        },
		        data: ['赤峰','呼和浩特','通辽','巴盟']
		    },
		    series : [
		        {
		            type: 'pie',
		            radius : '65%',
		            center: ['50%', '50%'],
		            selectedMode: 'single',
		            data:[
		                {value:55193, name: '赤峰'},
		                {value:15243, name: '呼和浩特'},
		                {value:64614, name: '通辽'},
		                {value:8888, name: '巴盟'},
		            ],
		        }
		    ],
		    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960']
		    
		};
		;
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//隐藏的文化程度
		var dom = document.getElementById("rofm-lsxxhq-1_1");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        textStyle:{
			        	 
			        },
			        data: ['村调委会','居（社区）调委会','乡镇调委会','街道调委会','企事业单位调委会','行业性专业性调委会','其他调委会']
			    },
			    series : [
			        {
			            name: '访问来源',
			            type: 'pie',
			            radius : '65%',
			            center: ['70%', '50%'],
			            data:[
			                {value:335, name:'村调委会'},
			                {value:310, name:'居（社区）调委会'},
			                {value:234, name:'乡镇调委会'},
			                {value:135, name:'街道调委会 '},
			                {value:400, name:'企事业单位调委会'},
			                {value:388, name:'行业性专业性调委会'},
			                {value:300, name:'其他调委会'}
			            ],
			        }
			    ],
			    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960','#00F5FF','#CD8500','#7FFF00'] 
			};
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//民族分布
		var dom = document.getElementById("rofm-lsxxhq-2_2");
		var myCharta = echarts.init(dom);
		var app = {};
		option = null;
		var weatherIcons = {
		    'Sunny': './data/asset/img/weather/sunny_128.png',
		    'Cloudy': './data/asset/img/weather/cloudy_128.png',
		    'Showers': './data/asset/img/weather/showers_128.png'
		};
		option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        textStyle:{
		        	 
		        },
		        data: ['赤峰','呼和浩特','通辽','巴盟']
		    },
		    series : [
		        {
		            type: 'pie',
		            radius : '65%',
		            center: ['50%', '50%'],
		            selectedMode: 'single',
		            data:[
		                {value:55193, name: '赤峰'},
		                {value:15243, name: '呼和浩特'},
		                {value:64614, name: '通辽'},
		                {value:8888, name: '巴盟'},
		            ],
		        }
		    ],
		    color:['#f5ce0c','#a817ec','#0d9bff','#1ce960']
		    
		};
		;
		if (option && typeof option === "object") {
		    myCharta.setOption(option, true);
		};
		//获取当前时间成功
	 	Date.prototype.Format = function (fmt) {    
		    var o = {    
		        "M+": this.getMonth() + 1,
		        "d+": this.getDate(), 
		    };    
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
		    for (var k in o)    
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
		    return fmt;    
		}  
		var nowTime=new Date().Format("yyyy-MM-dd"); 
		var i=0;
		//定义一个query变量
		var query = {}
		//右侧col-md-9信息填充
		tableView.loadData(function(page, res) {
			Service.findAllRy(query, page, res);
		});
		//查询按钮
		$("#listRmtjjgxx_list #submit").click(function(){
			console.log();
			query["twhbm[like]"]= $("#zyjg1").val();
			query["twhmc[like]"] = $("#twhmc_id").val();
			query["twhlx[like]"] = $("#twhlx_id").val();
			query["hztwhlx[like]"] = $("#hztwh_id").val();
			query["fzr[like]"] = $("#fzr_id").val();
			query["lxdh[like]"] = $("#lxdh_id").val();
			query["suqy[like]"] = $("#suqy_id").val();
			tableView.refresh();
		});
		//重置按钮
		$("#form_lsxxhq #reset").click(function(){
			form.clear();
		});
		//查看按钮事件
		var json={}
		tableView.transColumn("ckxx",function(data) {
			var button = $('<button  class="btn btn-default btn-sm" style="border-color:#128ef6;color:#128ef6;"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
			button.unbind("click").bind("click",function() {
				$('#myModal_fjxx').modal();
				console.log(data);
				form_mtk.fill(data);			
			});
			return button;
		});
		tableView.transColumn("order",function(data) {
			
			var button = $('<span id="spanId" class="badge" style="width:35px; background:#009ACD;")>'+(i+1)+'</span>');
			i++;
		return button;
		});
		//点击新增弹出模态框
		$('#append').click(function () {
			$('#myModal_xzxx').modal('show');
		});
		//新增里面的保存按钮
		$("#lsxxhq_modal").click(function(data){
			service.save(form.getData(),
					new Eht.Responder({success:function(data){
						$('#myModal').modal('hide');
						alert("修改信息成功");
						tableView.refresh();
				},
			}));
		});
		//隐藏Echars里面的内容
		$('#listRmtjjgxx_list #table_view_hide').hide();
		$('#listRmtjjgxx_list #table_view_hide_1').hide();
		//点击更多按钮弹出Echars更多的视图
		$('#more').click(function () {
			console.log($("#more").html());
			if($("#more").html() == "更多"){
				 $("#table_view_hide").fadeIn("slow");
				 $("#table_view_hide_1").fadeIn(1000);
				 $("#more").attr("class","btn btn-default glyphicon glyphicon-menu-up");
				 $("#more").html("收起");
			}else if($("#more").html() == "收起"){
			  $("#table_view_hide").fadeOut(1000);
			  $("#table_view_hide_1").fadeOut("slow");
			  $("#more").attr("class","btn btn-default glyphicon glyphicon-menu-down");
			  $("#more").html("更多");
			}
			
		});
		//最下面点击收起，隐藏Echacs视图
	   $('#remain_lsxxhq_1').click(function () {
			  $("#table_view_hide").fadeOut("slow");
			   $("#table_view_hide_1").fadeOut(1000);
			   $("#more").html("更多");
			   $("#more").attr("class","btn btn-default glyphicon glyphicon-menu-down");
		}); 
		//把Code编码设置为下拉选
		/* $("#zgxl1").comboSelect();
		$("#zzmm1").comboSelect();
		$("#mz1").comboSelect(); */
		
		//把左侧form表单里面的值赋值为空
	   	$("#mz1").append('$(<option selected></option>)');
		$("#zgxl1").append('$(<option selected></option>)');
		$("#zzmm1").append('$(<option selected></option>)');
		$("#xb1").append('$(<option selected></option>)');
		//默认隐藏的区域选择
		//区域选择div
		$('#spsflyz-hidenDiv').hide();
		var service = new RegionService();
		service.find({},new Eht.Responder({
			success:function(data){
				for(var i=0;i<data[0].nodes.length;i++){
					var city = $('<ul></ul>');
					var root = $('<li><div><input type="checkbox" style="margin-left:10px; margin-right:3px;"><span>'+data[0].nodes[i].region_name+'</span></div></li>')
					city.append(root);
					$('#spsSqjz-hidenDivSS').append(city);
					city.addClass("hidden-div-ul");
					var child = $('<ul style="margin-top:10px;"></ul>');
					for(var j=0;j<data[0].nodes[i].nodes.length;j++){
						var li = $('<li><input type="checkbox" style="margin-left:10px; margin-right:3px;">'+data[0].nodes[i].nodes[j].region_name+'</li>');
						child.append(li);
						li.addClass("hidden-div-li");
					}
					root.append(child);
				}
			}
		}));
		//显示隐藏的区域选择
		$("#ViewZxfsQX_qyss").click(function(){
				$("#spsflyz-hidenDiv").css("height","0").show().animate({height:400});
			return false;
		});
		//点击其他地方区域隐藏
		$(window).click(function(){
			$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		
		$("#spsflyz-hidenDiv").click(function(){return false;});
		
		//点击确定按钮的时候关闭区域并且提交选择的数据
		$("#spsSqjz-hidenDiv-qd").click(function(){
			$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
		//关闭按钮
		$("#spsSqjz-hidenDivBtn").click(function(){
			$("#spsflyz-hidenDiv").animate({height:0},function(){$(this).hide()});
		});
	});
</script>
<style type="text/css">
.form-AjlxMs {
	color: #333;
	text-align: center;
	padding-top:10px;
}
#sjqk{
	color: #282828;
}
.list-form-style input{
	margin-bottom:0px;
}
.form-group{
	margin-bottom:0px;
}
</style>
</head>
<body>
<!-- 整体表 -->
	<div  id="listRmtjjgxx_list"  class="col-md-12" style="width:100%;height:100%;" >
<!-- 左侧查询信息 -->
	<!-- background-color: #333 -->
	<div  class="col-md-3" style="top:30px;height:100%;border: 1px solid #ccc;border-radius: 5px;position:fixed;"  >
		<div class="col-md-12 " style="text-align:center;">
			<p  class="glyphicon glyphicon-user"  style="font-size:18px;margin-top: 10px;padding-left:20px;">人民调解机构信息查询</p>
			<hr style=" height:1px;border:none;border-top:1px dashed #ccc"/>
		</div>
			<div class="col-md-12" style=" height: 1px;"></div>
			<div class="list-form-style col-md-12" style="padding-top:20px; ">
				<form id="form_lsxxhq" style="margin-bottom:0px; ">
					<!-- <input type="text"  id="ViewZxfsQX_qyss"	 name="qymc" 		label="区域名称" 	maxlength="30" /> -->
				<!-- 	<input type="text"  id="zyjg1"	 name="twhbm" 	label="机构编码" 	maxlength="30"  /> -->
					<input type="text"  id="twhmc_id"	 name="twhmc" 	label="机构名称"	 	maxlength="30"   />
					<input type="text"  id="twhlx_id"	 name="twhlx" 	label="机构类型"	 	maxlength="30"   />
					<input type="text"  id="hztwhlx_id"	 name="hztwhlx" 	label="行专机构类型"	 maxlength="30"  />
					<input type="text"  id="fzr_id"	 name="fzr" 	label="负责人"	 	maxlength="30"  />
					<input type="text" 	id="lxdh_id" 	 name="lxdh" 		label="联系电话" 		maxlength="30" 	/>
					<input type="text" 	id="suqy_id" 	 name="suqy" 		label="所属区域" 		maxlength="30" 	/>
					
					<div class="col-md-12" style="padding-top:190px;margin-bottom:20px;">
					<hr style=" height:1px;border:none;border-top:1px dashed #ccc"/>
						<div class="col-md-3"><button class="btn btn-primary" type="button" id="submit" style="margin-left: 20px;">查询</button></div>
						<div class="col-md-5"></div>
						<div class="col-md-3"><button class="btn btn-default" type="button" id="reset">重置</button></div>
					</div>
				</form>
			</div>
<!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spsflyz-hidenDiv" style="display:none;">
			<div class="spssjfx-indicate"></div>
			<div id="spsSqjz-hidenDiv-div1">
				<div id="spsSqjz-hidenDiv-div11">区域选择</div>
				<input type="button" class="btn btn-warning"   id="spsSqjz-hidenDiv-qc" value="清除" style="padding:4px 8px;">
				<input type="button" class="btn btn-info"  id="spsSqjz-hidenDiv-qd" value="确定" style="padding:4px 8px;">
				<div id="spsSqjz-hidenDivBtn" class="glyphicon glyphicon-remove-circle" style="opacity:0.7;"></div>
			</div>
			<div id="spsSqjz-hidenDivSS"></div>
		</div>
	</div>
<!-- 右侧表 -->
	<div class="col-md-9"  style="position:absolute;right:0px;">
<!-- 表头 -->
			<div class="col-md-12" style="border:1px solid #ccc;border-radius:4px;margin-top: 30px;">
				<div class="col-md-12" >
				<div class="row" style="height:40px;padding-top:5px;border-bottom:1px solid #ccc;">
					<div class="col-md-7 glyphicon glyphicon-tasks" id="sjqk"  style="font-size:18px;color:#333;" ><span style="color:#333;padding-left:10px;">人民调解机构信息分析情况</span></div>
					<div class="col-md-3"></div>
					<!-- <div class="col-md-2"><button class="btn btn-default glyphicon glyphicon-book" type="button" id="append" style="font-size:17px;">&nbsp;新增</button></div> -->
					<div class="col-md-2"><button  class="btn btn-default glyphicon glyphicon-menu-down" type="button" id="more" style="font-size:17px; background: transparent;outline:none;border:0px;color:#333;">更多</button></div>
				</div>
			</div>
<!-- Echars视图 -->
			<div class="col-md-12"  id="table_view" style="padding-left:15px; ">		
			<!-- 	<div class="col-md-4" style="height:230px;" >
					<div   class="form-AjlxMs-1 col-md-12">
						<div class="form-AjlxMs" style="font-size:16px;"></div>
						<div class="col-md-12"  style="margin-top:30px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">专职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#EEC900;border-radius:5px;" >1555</div>
							</div>
						</div>
						<div class="col-md-12"  style="margin-top:20px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">兼职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#66CD00;border-radius:5px;" >1333</div>
							</div>
						</div>
					</div>-->
					 
				<div class="col-md-7" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
							<div class="form-AjlxMs">机构类型</div>
								<div id="rofm-ZxfsMsQX-fl"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
				<div class="col-md-5" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
								<div class="form-AjlxMs">所属区域</div>
								<div id="rofm-ZxfsMsQX"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
			</div>
		
<!-- 隐藏的Echars视图 -->
		 <div class="col-md-12"  id="table_view_hide" style="padding-left:15px; ">		
			<!--	<div class="col-md-4" style="height:230px;" >
					<div   class="form-AjlxMs-1 col-md-12">
						<div class="form-AjlxMs" style="font-size:16px;">律师类别情况</div>
						<div class="col-md-12"  style="margin-top:30px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">专职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#EEC900;border-radius:5px;" >1555</div>
							</div>
						</div>
						<div class="col-md-12"  style="margin-top:20px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">兼职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#66CD00;border-radius:5px;" >1333</div>
							</div>
						</div>
					</div>-->
					 
				<div class="col-md-6" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
							<div class="form-AjlxMs">机构类型</div>
								<div id="rofm-lsxxhq-1"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
				<div class="col-md-6" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
							<div class="form-AjlxMs">所属区域</div>
								<div id="rofm-lsxxhq-2"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
			</div>
			
<!-- 隐藏Echars2 -->
					
			<div class="col-md-12"  id="table_view_hide_1" style="padding-left:15px; ">		
			<!--	<div class="col-md-4" style="height:230px;" >
					<div   class="form-AjlxMs-1 col-md-12">
						<div class="form-AjlxMs" style="font-size:16px;">律师类别情况</div>
						<div class="col-md-12"  style="margin-top:30px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">专职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#EEC900;border-radius:5px;" >1555</div>
							</div>
						</div>
						<div class="col-md-12"  style="margin-top:20px;height:30px;">
							<div class="col-md-6">
								<div class="form-AjlxMs" style="font-size:18px;padding-top:0px;line-height:30px;">兼职律师</div>
							</div>
							<div class="col-md-6">
								<div class="form-AjlxMsa" style="font-size:15px;height:30px;background:#66CD00;border-radius:5px;" >1333</div>
							</div>
						</div>
					</div>-->
				 
				<div class="col-md-6" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
								<div class="form-AjlxMs">机构类型</div>
								<div id="rofm-lsxxhq-1_1"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
				<div class="col-md-6" id="ZxfsMsQX-div2"   id="table_view">
							<div  class="rofm-ZxfsMsQX-1">
								<div class="form-AjlxMs">所属区域</div>
								<div id="rofm-lsxxhq-2_2"style="width: 100%; height: 200px; "></div>
							</div>
				</div>
				
					<div class="col-md-12" style="margin-top:10px;">
						<div class="col-md-10"></div>
						<div class="col-md-2"><button class="btn btn-default glyphicon glyphicon-menu-up" type="button" id="remain_lsxxhq_1"  style="font-size:17px; background: transparent;outline:none;border:0px;color:#333;">收起</button></div>
					</div>
				
			</div>
			</div>
			
	<!-- 收起 -->
	
<!-- 查询的内容 -->
			<div id="list_lsxxhq" style="margin-top: 10px">
					<!-- 	<div field="twhbm"  label="机构编码" ></div> -->
						<div field="twhmc" label="机构名称" ></div>
						<div field="twhlx" label="机构类型"></div>
						<div field="fzr" label="负责人"></div>
						<div field="lxdh" label="联系电话"></div>
						<div field="ckxx" label="查看详细"></div>
			</div>
	
	</div>
<!-- 点击查看信息弹出模态框 -->
	<div class="modal fade" id="myModal_fjxx" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content" style="position:absolute; height:650px; overflow:auto">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">
							&times;
						</Button>
						<h4 class="modal-title" id="myModalLabel">人民调解机构信息明细</h4>
					</div>
					<div class="modal-body">
						<div id="jzjzlxx-form" >
							<input type="text" name="twhbm"	label="机构编码"   disabled/>
							<input type="text" name="twhmc"	label="机构名称" 	 disabled/>
							<input type="text" name="twhlx"	label="机构类型" 	  disabled/>
							<input type="text" name="fzr"	label="负责人"  disabled/>
							<input type="text" name="clrq"	label="成立日期" 	  disabled/>
							<input type="text" name="lxdh"	label="联系电话" 	  disabled/>
							<input type="text" name="lxdz"	label="联系地址" 	  disabled/>
							<input type="text" name="dzyx"	label="电子邮箱" 	  disabled/>
							<input type="text" name="czhm"	label="传真号码" 	  disabled/>
							<input type="text" name="yzbm"	label="邮政编码" 	  disabled/>
							<input type="text" name="hztwhlx"	label="行专机构类型" 	  disabled/>
							<input type="text" name="zztjyrs"	label="专职调解员人数" 	  disabled/>
							<input type="text" name="jztjyrs"	label="兼职调解员人数" 	  disabled/>
							<input type="text" name="xxcjrq"	label="信息采集日期" 	  disabled/>
							<input type="text" name="suqy"	label="所属区域" 	  disabled/>
							<!-- <input type="text" name="lat"	label="纬度" 	  disabled/>
							<input type="text" name="lng"	label="经度" 	  disabled/> -->
								
							
						</div>
					</div>
					<div class="modal-footer" >
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
<!-- 新增模态框 -->		
	<!-- 	<div class="modal fade" id="myModal_xzxx" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content" style="position:absolute; height:650px; overflow:auto">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">
							&times;
						</Button>
						<h4 class="modal-title" id="myModalLabel">律师信息明细</h4>
					</div>
					<div class="modal-body">
						<div id="lsxxhq-form" >
							<input type="text" name="xm"	label="姓名" 	 />
							<input type="text" name="cym"	label="曾用名" />
							<input type="text" name="csrq"	label="出生日期" 	/>
							<input type="text" name="mz"	label="民族" 	  />
							<input type="text" name="jg"	label="籍贯" 	 />
							<input type="text" name="zyjg"	label="执业机构" 	 />
							<input type="text" name="zylb"	label="执业类别" 	  />
							<input type="text" name="zyzh"	label="执业证号" 	 />
							<input type="text" name="snsf"	label="所内身份" 	 />
							<input type="text" name="zyzt"	label="执业状态" 	  />
							<input type="text" name="pzzt"	label="派驻状态" 	  />
							<input type="text" name="zgzlb"	label="资格证类别" 	  />
							<input type="text" name="qdfs"	label="取得方式" 	  />
							<input type="text" name="zgzh"	label="资格证号" 	 />
							<input type="text" name="zgzqdsj"	label="资格证取得时间" 	  />
							<input type="text" name="zgzqdd"	label="资格证取得地" 	  />
							<input type="text" name="zzmm"	label="政治面貌" 	  />
							<input type="text" name="hjszd"	label="户籍所在地" 	  />
							<input type="text" name="byyx"	label="毕业院校" 	  />
							<input type="text" name="zgxl"	label="最高学历" 	 />
							<input type="text" name="zgxw"	label="最高学位" 	  />
							<input type="text" name="zjlb"	label="证件类别" 	  />
							<input type="text" name="zjbh"	label="证件编号" 	 />
							<input type="text" name="lxdz"	label="联系地址" 	  />		
							<input type="text" name="lxdzyb"	label="联系地址邮编" 	  />
							<input type="text" name="lxdh"	label="联系电话" 	  />
							<input type="text" name="dzyx"	label="电子邮箱" 	 />
							<input type="text" name="sczyrq"	label="首次执业日期" 	  />
							<input type="text" name="sczyd"	label="首次执业地" 	  />
							<input type="text" name="khnf"	label="考核年份" 	  />
							<input type="text" name="khzt"	label="考核状态" 	  />
							<input type="text" name="rsdacfd"	label="人事档案存放地" 	  />
							<input type="text" name="rsdacfjg"	label="人事档案存放机构" 	  />
							<input type="text" name="rsdabh"	label="人事档案编号" 	  />
							<input type="text" name="rsdacfjg"	label="兼职单位" 	  />
							<input type="text" name="zyfw"	label="执业范围" 	  />
							<input type="text" name="zydaqk"	label="执业档案情况" 	  />
							<input type="text" name="律师类型"	label="律师类型"   />
						</div>
					</div>
					<div class="modal-footer" >
						<button type="button" class="btn btn-default" data-dismiss="lsxxhq_modal">保存</button>
					</div>
				</div>
			</div>
		</div>
</div> -->
<!-- 最底部 -->
</body>
</html>