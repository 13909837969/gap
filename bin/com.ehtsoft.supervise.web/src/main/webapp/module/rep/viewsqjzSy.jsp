<%@page import="com.ehtsoft.fw.utils.NumberUtil"%>
<%@page import="com.ehtsoft.supervise.utils.DateUtils"%>
<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8" import="java.util.*" %>
<%  
	int year0 = NumberUtil.toInt(DateUtils.getYear());
	int year1 = NumberUtil.toInt(DateUtils.getYear())-1;
	int year2 = NumberUtil.toInt(DateUtils.getYear())-2;
	int year3 = NumberUtil.toInt(DateUtils.getYear())-3;
	int year4 = NumberUtil.toInt(DateUtils.getYear())-4;
%>
<html>
<head>
<title>社区矫正首页</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/viewRepSqjz.css?<%=Math.random()%>" rel="stylesheet">
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<!--插入 饼图js结束 -->
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RepJzryService.js"></script>
<!-- 新版社区矫正首页  -->
<script type="text/javascript" src="${localCtx}/json/SyJzzlSerivce.js"></script>
<script type="text/javascript" src="js/viewSqjzSy.js"></script>

<script type="text/javascript">
var jzsy = new SyJzzlSerivce();
/* 月份的选择 */
function show_sub(v){     
      if (v != "") {
  			$("#jidu_sel").attr("disabled","disabled");
  		}
      if (v == "") {
			document.getElementById("jidu_sel").removeAttribute("disabled");
		} 
  }
/* 季度的选择 */
function show_sub1(v1){     
	 if (v1 != "") {
	  		$("#month_sel").attr("disabled","disabled");
	  } 
	 if (v1 == "") {
		 document.getElementById("month_sel").removeAttribute("disabled");
	  } 
} 

//点击查询
function sjjs() {
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
};
</script>

<style type="text/css">

body{
	width:100%;
	height:100%;
	min-width:1280px;
	background:#f1f1f1;
	font-family:Verdana, Geneva, sans-serif, "汉仪中黑简", "华文细黑";
}
ul li {
	list-style:none;
}
#viewSqjzSy_style{
	height:485px;
	margin-top:20px;
	margin-bottom:20px;
	
}
#viewSqjzSy_style1_jl{
	height:485px;
}
#viewSqjzSy_style_cent{
	border:1px solid #ccc;
	border-radius:4px;
	background:#fff;
	box-shadow:0px 0px 3px #ccc; 
}
#viewSqjzSy_style_title{
	font-size:20px;
	height:30px;
	font-weight:bold;
}
#viewSqjzSy_style_bar{
	min-height:300px;
}
#viewSqjzSy_style_bar1{
	height:370px;
	
	border-right:1px solid #ccc;
}
#viewSqjzSy_style_bar2{
	height:370px;
}
#viewSqjzSy_cent_ulli ul li {
	text-align:center;
}
#viewSqjzSy_cent_ulli22{
	font-weight:bold;
	font-size:18px;
}
#viewSqjzSy_style2{
	height:486px;
	border-radius:4px;	
	border:1px solid #ccc;
	background:#fff;
	box-shadow:0px 0px 3px #ccc; 
}
#viewSqjzSy_style2_title2{
	font-size:20px;
	height:30px;
	font-weight:bold;
}
#viewSqjzSy_style2_qb{
	font-size:20px;
	font-weight:bold;
}
#viewSqjzSy_style2_text{
	margin-top:5px;
}
#viewSqjzSy_style2_text ul li span{
	font-weight:bold;
	font-size:18px;
}
#viewSqjzSy_style2_text ul a li span{
	font-size:18px;
	font-weight:normal;
}
#viewSqjzSy_style2_text ul{
	margin-bottom:5px;
	height:40px;
	text-align:center;
}

#viewSqjzSy_style2_text ul li{
	font-size:20px;
}
#viewSqjzSy_style2_text ul li img{
	width:40px;
}
.viewSqjzSy_style2_jtzq{
	background:#337ab7;
	text-align:center;
	color:#fff;
	line-height:30px;
	border-radius:4px;
}
.viewSqjzSy_style2_jtzq:hover{
	background:#286090;
}
.viewSqjzSy_style2_jtzq span{
	text-align:center;
	font-weight:normal;
}
/**/
#viewSqjzSy_style3{
	height:300px;
	padding-top:20px;
	padding-left:30px;	
}
#viewSqjzSy_style3_title3{
	font-size:20px;
	font-weight:bold;
}
#viewSqjzSy_style3_cent3{
	border:1px solid #ccc;
	border-radius:4px;
	background:#fff;
	box-shadow:0px 0px 3px #ccc; 
	height:350px;
}
#viewSqjzSy_style3_input3{
	text-align:center;
}
#viewSqjzSy_style3_input3 ul li span{
	font-size:18px;
}
#viewSqjzSy_style3_neir3{
	text-align:center;
}
#viewSqjzSy_style3_nier_ulli{
	height:150px;
	line-height:150px;
}
#viewSqjzSy_style3_nier_ulli2 li{
	line-height:50px;
	font-size:18px;
	font-weight:bold;
}
#viewSqjzSy_style3_nier_ulli3 li{
	font-size:18px;
}
#viewSqjzSy_style3_nier_ulli2 li{
	font-weight:bold;
}
#viewSqjzSy_style3_nier_ulli li img{
	width:100px;
}
.viewSqjzSy_style3_select3{
	height:30px;
	border-radius:4px;
	max-width:150px;
	min-width:93px;
	margin-top:10px;
}
#viewSqjzSy_style3_chaxun3{
	width:100px;
	height:34px;
	background:#337ab7;
	margin-top:8px;
	line-height:30px;
	text-align:center;
	border-radius:4px;
	border:1px solid #ccc;
	color:#fff;
}
#viewSqjzSy_style3_chaxun3:hover{
	background:#286090;/*286090*/
}
/*閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿燂拷********閿熸枻鎷峰紡*/
#viewSqjzSy_style2{
    overflow-x: hidden;
    overflow-y: auto;
    }
    /*閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹寮�*/
#viewSqjzSy_style2::-webkit-scrollbar {/*閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹寮�*/
	width: 7px;     /*閿熺鍖℃嫹鐩撮敓鏂ゆ嫹搴旈敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熶茎灏鸿揪鎷�*/
    height: 4px;
    opacity:0.5;
}
#viewSqjzSy_style2::-webkit-scrollbar-thumb {/*閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷峰皬閿熸枻鎷烽敓鏂ゆ嫹*/
	border-radius: 10px;
	/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
    background:#a4cde5;
    margin-right:2px;
    
}
/* #viewSqjzSy_style2::-webkit-scrollbar-track {閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹閿熸枻鎷烽敓鏂ゆ嫹 
	-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
    border-radius:10px;
    background:#999;
    margin-right:2px;
} */
.viewSqjzSy_style3_nier_style22{
	padding-left:0px;
	padding-right:0px;
}
</style>
</head>
<body>
<div class="col-md-12 col-sm-12" id="viewSqjzSy_style">
	<div class="col-md-7 col-sm-7" id="viewSqjzSy_style1_jl">
		<div class="col-md-12 col-sm-12" id="viewSqjzSy_style_cent">
			<div class="row" id="viewSqjzSy_style_title" style="border-bottom:1px solid #ccc;height:50px;line-height:50px;padding-left:15px;">矫正人员情况</div>
			<div class="col-md-12 col-sm-12" id="viewSqjzSy_style_bar">
				<div class="col-md-6 col-sm-6" id="viewSqjzSy_style_bar1">
					
				</div>
				<div class="col-md-6 col-sm-6" id="viewSqjzSy_style_bar2">
					
				</div>
			</div>
			<div class="col-md-12 col-sm-12" id="viewSqjzSy_cent_ulli">
				<ul class="col-md-12 col-sm-12" id="viewSqjzSy_cent_ulli22">
					<li class="col-md-2 col-sm-2">在校学生</li>
					<li class="col-md-2 col-sm-2">未成年</li>
					<li class="col-md-2 col-sm-2">准假外出</li>
					<li class="col-md-2 col-sm-2">托管</li>
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">附加禁止令</li>
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">未按时报到</li>
				</ul>
				<ul class="col-md-12 col-sm-12">
					<li class="col-md-2 col-sm-2" id ="jx"></li>
					<li class="col-md-2 col-sm-2" id ="wcn"></li>
					<li class="col-md-2 col-sm-2" id ="qj"></li>
					<li class="col-md-2 col-sm-2" id ="tg"></li>
					<li class="col-md-2 col-sm-2" id ="jzl"></li>
					<li class="col-md-2 col-sm-2" id ="wbd"></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="col-md-5 col-sm-5" id="viewSqjzSy_style2">
		<div class="row" style="border-bottom:1px solid #ccc;height:50px;line-height:50px;padding-left:15px;">
			<div class="col-md-10 col-sm-10" id="viewSqjzSy_style2_title2">待办任务列表</div>
			<div class="col-md-2 col-sm-2" id="viewSqjzSy_style2_qb">全部</div>
		</div>
		<div class="col-md-12 col-sm-12" id="viewSqjzSy_style2_text">
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>需要</span><span>[社区矫正调查评估]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>4天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>需要</span><span>[矫正接收]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>1天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>报警提示</span><span>[越界报警]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>4天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>需要</span><span>[矫正接收]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>5天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>报警提示</span><span>[越界报警]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>2天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>报警提示</span><span>[低电量报警]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>3天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>需要</span><span>[矫正接收]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>1天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>需要</span><span>[社区矫正调查评估]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>2天之前</span></li></a>
			</ul>
			<ul class="col-md-12 col-sm-12" style="border-bottom:1px solid #ccc;">
				<li class="col-md-1 col-sm-1"><img src="images/sxhbbdb.png"/></li>
				<li class="col-md-8 col-sm-8"><span>[张天山]</span><span>报警提醒</span><span>[人机分离报警]</span></li>
				<a href="#"><li class="col-md-3 col-sm-3 viewSqjzSy_style2_jtzq"><span>3天之前</span></li></a>
			</ul>
		</div>
	</div>
</div>
<div class="col-md-12 col-sm-12" id="viewSqjzSy_style3">
	<div class="col-md-12 col-sm-12" id="viewSqjzSy_style3_cent3">
		<div class="row" style="border-bottom:1px solid #ccc;height:50px;line-height:50px;padding-left:15px;">
			<div class="col-md-2 col-sm-2" id="viewSqjzSy_style3_title3">矫正人员情况</div>
			<div class="col-md-10 col-sm-10" id="viewSqjzSy_style3_input3">
				<ul class="col-md-12 col-sm-12">
					<li class="col-md-1 col-sm-1"></li>
					<li class="col-md-3 col-sm-3">
						<span class="col-md-5 col-sm-5">年度：</span>
						<select class="form-control"  style="width:58%;margin-top:8px;" id="year_sel">
							<option value="<%=year0 %>"><%=year0 %>年</option>
  							<option value="<%=year1 %>"><%=year1 %>年</option>
  							<option value="<%=year2 %>"><%=year2 %>年</option>
  							<option value="<%=year3 %>"><%=year3 %>年</option>
  							<option value="<%=year4 %>"><%=year4 %>年</option>
						</select>
					</li>
					<li class="col-md-3 col-sm-3">
						<span class="col-md-5 col-sm-5">季度：</span>
						<select class="form-control" onchange="show_sub1(this.options[this.options.selectedIndex].value)" style="width:58%;margin-top:8px;" id="jidu_sel">
							<option value="">请选择</option>
							<option value="1">第一季度</option>
							<option value="2">第二季度</option>
							<option value="3">第三季度</option>
							<option value="4">第四季度</option>
						</select>
					</li>
					<li class="col-md-3 col-sm-3">
						<span class="col-md-5 col-sm-5">月份</span>
						<select class="form-control"  onchange="show_sub(this.options[this.options.selectedIndex].value)" style="width:58%;margin-top:8px;" id="month_sel">
							<option value="">请选择</option>
							<option value="1">1月</option>
  							<option value="2">2月</option>
  							<option value="3">3月</option>
  							<option value="4">4月</option>
  							<option value="5">5月</option>
  							<option value="6">6月</option>
  							<option value="7">7月</option>
  							<option value="8">8月</option>
  							<option value="9">9月</option>
  							<option value="10">10月</option>
  							<option value="11">11月</option>
  							<option value="12">12月</option>
						</select>
					</li>
					<a href="javascript:void(0)">
						<li class="col-md-2 col-sm-2" id="viewSqjzSy_style3_chaxun3"  onclick="sjjs()">查询</li>
					</a>
				</ul>
			</div>
		</div>
		<div>
			<div class="col-md-12 col-sm-12" id="viewSqjzSy_style3_neir3">
				<ul class="col-md-12 col-sm-12" id="viewSqjzSy_style3_nier_ulli">
					<li class="col-md-2 col-sm-2"><img src="images/yzhzzfzry.png"/></li>
					<li class="col-md-1 col-sm-1"><img src="images/xjjz.png"/></li>
					<li class="col-md-2 col-sm-2"><img src="images/xzry.png"/></li>
					<li class="col-md-1 col-sm-1"><img src="images/jcjz.png"/></li>
					<li class="col-md-2 col-sm-2"><img src="images/sxhbbdb.png"/></li>
					<li class="col-md-1 col-sm-1"><img src="images/jzdbg.png"/></li>
					<li class="col-md-2 col-sm-2"><img src="images/jzfawzdry.png"/></li>
					<li class="col-md-1 col-sm-1"><img src="images/wcjh.png"/></li>
				</ul>
				<ul class="col-md-12 col-sm-12" id="viewSqjzSy_style3_nier_ulli2">
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">余罪和再次犯罪人员</li>
					<li class="col-md-1 col-sm-1 viewSqjzSy_style3_nier_style22">衔接矫正</li>
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">未建立小组人员</li>
					<li class="col-md-1 col-sm-1 viewSqjzSy_style3_nier_style22">解除矫正</li>
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">思想汇报不达标</li>
					<li class="col-md-1 col-sm-1 viewSqjzSy_style3_nier_style22">居住地变更</li>
					<li class="col-md-2 col-sm-2 viewSqjzSy_style3_nier_style22">矫正方案未制定人员</li>
					<li class="col-md-1 col-sm-1 viewSqjzSy_style3_nier_style22">外出申请</li>
				</ul>
				<ul class="col-md-12 col-sm-12" id="viewSqjzSy_style3_nier_ulli3">
					<li class="col-md-2 col-sm-2" id="yz"></li>
					<li class="col-md-1 col-sm-1" id="xj"></li>
					<li class="col-md-2 col-sm-2" id="wj"></li>
					<li class="col-md-1 col-sm-1" id="jc"></li>
					<li class="col-md-2 col-sm-2" id="sx"></li>
					<li class="col-md-1 col-sm-1" id="zz"></li>
					<li class="col-md-2 col-sm-2" id="fa"></li>
					<li class="col-md-1 col-sm-1" id="wc"></li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
</html>