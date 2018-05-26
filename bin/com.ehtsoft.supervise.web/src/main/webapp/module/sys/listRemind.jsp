<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>Regional audit table</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
        <script type="text/javascript" src="${localCtx}/json/RemindService.js"></script>
        <script type="text/javascript" src="${localCtx}/json/AuditApplyService.js"></script>
		<style type="text/css">
		#listremind_all{width:100%;margin:0px;min-height:100%;background:#f7f7f7;border-collapse:collapse;}
		#listremind_all td{vertical-align: top}
		#listremind_all #accordion li{
			list-style-image: url(../../resources/images/icon/icon_square_orange.png);
		}
		#listremind_all #accordion .li-active{
			list-style-image: url(../../resources/images/icon/icon_square_red.png);
		}
		#listremind_all .left-nav{
			width:20%;
		}
		#listremind_all .right-content{
			width:80%;
		}
		#listremind_all #accordion{
			min-height:100%;
		}
		#listremind_all .remind{
			display: none;
		}
		#listremind_all #text{min-height:100%;background-color:#f7f7f7;}
		#listremind_all #righttop{height:60px;background-color:#f7f7f7;margin: 10px;padding-left: 30px;}
		#listremind_all .Textinformation{height:120px;background-color:#ffffff;margin: 20px;}
		#listremind_all .remind-nav{width:100%;height:50px; margin-left:50px; font-size:120%;  line-height: 50px;color:#cf702c}
		</style>
<script type="text/javascript">
$(function(){
	var rs =  new RemindService();
	var query= {};
	var page = new Eht.Paginate();
	var aas  = new AuditApplyService();
	
	var table1 = new Eht.TableView({selector:"#remind-list1"});
	var table2 = new Eht.TableView({selector:"#remind-list2"});
	var table3 = new Eht.TableView({selector:"#remind-list3"});
	var table4 = new Eht.TableView({selector:"#remind-list4"});
	var table5 = new Eht.TableView({selector:"#remind-list5"});
	$("#righttop").click(function(){
		page.getNextPage();
		loadData();
	});
	$("#ul-warn").children().click(function(){
		$("#listremind_all .remind").hide();
		$("#listremind_all #warn-information").show();
		$("#ul-warn").children().removeClass("li-active");
		$(this).addClass("li-active");
		var v = parseInt($(this).attr("value"));
		query["F_TYPE[eq]"] = v;
		loadData(v);
	});
	$("#ul-correct").children().click(function(){
		$("#listremind_all .remind").hide();
		$("#listremind_all #warn-information").hide();
		$("#ul-correct").children().removeClass("li-active");
		$(this).addClass("li-active");
		var href = $(this).attr("href");
		$("#listremind_all #" + href).show();
		var v = parseInt($(this).attr("value"));
		query["F_TYPE[eq]"] = v;
		if(href=="remind-list1"){
			table1.loadData(function(page,res){
				rs.findWarn(query,page,res);
			});
		}
		if(href=="remind-list2"){
			table2.loadData(function(page,res){
				rs.findWarn(query,page,res);
			});
		}
		if(href=="remind-list3"){
			table3.loadData(function(page,res){
				rs.findWarn(query,page,res);
			});
		}
		if(href=="remind-list4"){
			table4.loadData(function(page,res){
				rs.findWarn(query,page,res);
			});
		}
		if(href=="remind-list5"){
			table5.loadData(function(page,res){
				aas.findUnApproveData( page,res);
			});
		}
	});
	function loadData(type){
		rs.findWarn(query,page,new Eht.Responder({
			success:function(data){
				console.log(data);
				var texttmp = $("#listremind_all #texttemp");
				$("#listremind_all #warn-information").empty();
				for(var i=0;i<data.rows.length;i++){
					var temp = texttmp.clone();
					temp.attr("id",i);
					if(type==1){
						temp.find("#warn-time").html("越界时间");
						temp.find("#last-local").html("逗留地点");
					}if (type==3){
						temp.find("#warn-time").html("关机时间");
						temp.find("#last-local").html("最后定位");
					}if(type==24){
						temp.find("#warn-time").html("卸载时间");
						temp.find("#last-local").html("最后显示位置");
					}if(type==4){
						temp.find("#warn-time").html("禁止区域报警时间");
						temp.find("#last-local").html("进入禁止区域地点");
					}if(type==5){
						temp.find("#warn-time").html("人机分离报警时间");
						temp.find("#last-local").html("逗留地点");
					}
					var view = new Eht.View({selector:temp});
					view.fill(data.rows[i]);
					$("#listremind_all #warn-information").append(temp);
					temp.show();
				}
			}
		}));
	}
});
    
</script>

	</head>
<body>
  <table id="listremind_all">
  	<tr>
  	<td class="left-nav">
	<div class="panel-group" id="accordion">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a id="biaoti" data-toggle="collapse" data-parent="#accordion" 
					   href="#collapseOne">
						<h1 style="font-size: 24px;position:relative;left:80px;">报警信息</h1>
					</a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in">
				<div class="panel-body">
					<ul type="disc" id="ul-warn">
					<li value="1" class="remind-nav"><a   href="#">越界报警</a></li>
		          	<li  value="3" class="remind-nav" style="list"><a  href="#">关机报警</a></li>
		           	<li value="24" class="remind-nav"><a  href="#">卸载报警</a></li>
		           	<li value="4"class="remind-nav"><a  href="#">禁止区域报警</a></li>
		           	<li value="5"class="remind-nav"><a  href="#">人机分离报警</a></li> 
					</ul>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a  id="biaoti" data-toggle="collapse" data-parent="#accordion" 
					   href="#collapseTwo">
						<h1 style="font-size: 24px;position:relative;left:80px;">提醒信息</h1>
					</a>
				</h4>
			</div>
			<div id="collapseTwo" class="panel-collapse collapse">
				<div class="panel-body">
					<ul id="ul-correct">
					<li value="" class="remind-nav" href="remind-list1"><a  href="#">矫正到期</a></li> 
		          	<li value="2" class="remind-nav" href="remind-list2"><a  href="#">电量提醒</a></li> 
		           	<li value="" class="remind-nav" href="remind-list3"><a  href="#">定位失败提醒</a></li>
		           	<li value="" class="remind-nav" href="remind-list4"><a  href="#">签到提醒</a></li> 
		           	<li value="" class="remind-nav" href="remind-list5"><a  href="#">审批处理</a></li> 
					</ul>
				</div>
			</div>
		</div>
	</div>
	</td>
	<td id="right-content">
	<div id="text">
		<div id="righttop">
			<input  type="button" value="查看全部  " style="width:100px;height:70px;font-size: 18px;color:#555555;background:#f7f7f7;border:none ;outline: none;"/>
			<input  type="button" value="已处理  " style="width:100px;height:70px;font-size: 18px;color:#555555;background:#f7f7f7;border:none ;outline: none;"/>
		</div>
		<div id="texttemp" class="Textinformation" style="display:none;">
		    <label style="margin-left: 20px;margin-top: 20px;top: 80px;"><img border="" alt="" src="data" width="40px;"  height="80px;"></label>
			<label style="margin-left: 150px;margin-top: 40px;">姓名</label><span field="xm">傅文庆</span>
			<label >电话</label><span field="grlxdh">18747611101</span>
			<label id="warn-time">越界时间</label><span field="cts">2018-01-10 20:25:37.621</span><br>
			<label id="last-local" style="margin-left: 150px;margin-top: 10px;">最后显示位置</label><span field="f_address">中国内蒙古自治区赤峰市敖汉旗百柳街</span>
			<input  type="button" value="查看详情"/>
		</div>
		<div id="warn-information">
			
		</div >
		<div id="remind-information">
			<div class="remind" id="remind-list1">
		      <div field="jgmc" label="矫正单位"></div>
			  <div  field="xm" label="姓名"></div>
			  <div  field="grlxdh" label="电话"></div>
			  <div   field="sfzh" label="证件号"></div>
			  <div   field="sqjzjsrq" label="矫正结束时间"></div>
			  <div field="sqjzqx" label="剩余到期时间"></div>
		   </div>
	   		<div class="remind" id="remind-list2">
			 	<div id="id-xm" field="xm" label="姓名"></div>
			  	<div id="id-grlxdh"  field="grlxdh" label="电话"></div>
			 	<div id="id-baaa_lnr05"   field="sfzh" label="证件号"></div>
			  	<div id="id-address"    field="f_address" label="当前位置"></div>
			   	<div id="id-dianliang"   field="" label="电量信息"></div>
	   		</div>
		   <div class="remind" id="remind-list3">
			  <div  field="xm" label="姓名"></div>
			  <div  field="grlxdh" label="电话"></div>
			  <div   field="sfzh" label="证件号"></div>
			  <div   field="f_address" label="当前位置"></div>
			  <div  label="详情"></div>
		   </div>
		   <div class="remind" id="remind-list4">
			  <div  field="xm" label="姓名"></div>
			  <div  field="grlxdh" label="电话"></div>
			  <div  field="sfzh" label="证件号"></div>
			  <div  field="f_address" label="当前位置"></div>
			  <div field="" label="签到状态"></div>
		   </div>
		   <div class="remind" id="remind-list5">
			  <div  field="xm" label="姓名"></div>
			  <div  field="grlxdh" label="电话"></div>
			  <div   field="sfzh" label="证件号"></div>
			  <div   field="f_address" label="当前位置"></div>
			  <div field="" label="审批类型"></div>
		   </div>
		</div>
	</div>
	</td>
	</tr>
  </table>
</body>
</html>