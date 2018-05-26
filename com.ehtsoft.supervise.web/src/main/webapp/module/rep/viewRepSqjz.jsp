<%@page import="java.util.Date"%>
<%@page import="com.ehtsoft.fw.utils.DateUtil"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link href="${localCtx}/resources/css/viewRepSqjz.css?<%=Math.random()%>" rel="stylesheet">
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<!--插入 饼图js结束 -->
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script>
<script type="text/javascript" src="${localCtx}/json/BoundaryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RepJzryService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SigninService.js"></script>
<!-- 查询人员坐标 -->
<script type="text/javascript" src="${localCtx}/json/FootprintService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzQdxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/AlarmService.js"></script>
<script type="text/javascript" src="js/viewRepSqjz2.js?<%=Math.random() %>"></script>
<script type="text/javascript" src="${localCtx}/module/sqjz/rpDwjk.js"></script>
<script type="text/javascript">
/* 处理司法所返回区域 */
function im() {
	/* $("#ltrhao-right-xx").hide();
	$("#ltrhao-spsSqjz-body-right-div3333").show();
	$("#ltrhao-spsSqjz-body-right-div5555").hide();
	$("#ltrhao-org-panel").hide(); */
}
var Burl = "${localCtx}"

</script>
<style type="text/css">
.anchorBL{display:none}
#ltrhao-spsSqjz-body-right-div28 img{
	position:absolute;
	top:-110px;
	left:-10px;
}
#ltrhao-spsSqjz-body-right-div281{
	font-size: 16px;
    font-weight: bold;
    position: absolute;
    top: 15px;
    left: 50px;
}
#ltrhao-spsSqjz-body-right-div282{
	font-size: 16px;
    font-weight: bold;
    position: absolute;
    top: 15px;
    left: 166px;
}
#ltrhao-spsSqjz-body-right-div283{
	font-size: 16px;
    font-weight: blo;
    font-weight: bold;
    position: absolute;
    top: 15px;
    left: 341px;
}
#ltrhao-spsSqjz-body-right-div284{
	font-size: 16px;
    font-weight: bold;
    position: absolute;
    top: 15px;
    right: 30px;
}
.ltrhaolefttable>tbody>tr>td{
	padding:4px;
  	color:#fff;
  	border-bottom:1px solid #5292bf;
  	border-top:0px ;
  	vertical-align: middle;
}
#ltrhao_org_per_list>table>tbody>tr>td{
border-bottom:1px solid #517d9c;
vertical-align: middle;
}
#ltrhao_org_per_list{
	margin-left:25px;
}
</style>
</head>
<body>
	<div id="ltrhao-spsSqjz-body-div">
		<div id="ltrhao-spsSqjz-body-div1">
			<!--全区矫正人员分布情况  -->
			<div>
				<div id="das_mapID"></div>
			</div>
		</div>
		<!-- 左侧列表 S -->
		<div id="ltrhao-sqjz-left" style="position: absolute;left:20px; width:460px;top: 10px;">
			<div class="ltrhao-sqjz-left-opacity"></div>
			<div>
				<div id="ltrhao-sqjz-rep-header"style="width:460px;border-radius:5px 5px 0px 0px; ">
					<span id="spsSqjz-return-sj" style="display:none" pid="#ltrhao-city-panel"><a href="#"><img src="images/sqjz-back-icon.png"/></a></span>
					<div id="ltrhao-jzryzs-val">2320</div>
					<div id="ltrhao-jzryzs-label">矫正人员总数</div>
					<div id="ltrhao-rysl-yg-label">严管</div>
					<div id="ltrhao-rysl-yg-val">55</div>
					<div id="ltrhao-rysl-pg-label">普通</div>
					<div id="ltrhao-rysl-pg-val" style="right: 150;">1085</div>
					<div id="ltrhao-rysl-kg-label">宽松</div>
					<div id="ltrhao-rysl-kg-val">2787</div>
					<!-- <div id="ltrhao-sqjz-rep-header20">1276</div>
					<div id="ltrhao-sqjz-rep-header21">工作人员总数</div>
					<div id="ltrhao-spsSqjz-body-right-div-line131"></div> -->
				</div>
				<!-- 省、市、区遍历 -->
				
				<div id="ltrhao-sqjz-body-right" style="width:460px;overflow:auto;">
					<div id="ltrhao-right-xx" style="width:460px;">
						<div id="ltrhao-total-head" style="width:460px;">
							<div id="ltrhao_sqjz_col1" >序号</div>
							<div id="ltrhao_sqjz_col2" style="left:150px;">区域</div>
							<div id="ltrhao_sqjz_col3" style="right: 50px;">矫正人员总数</div>
						</div>
						<!-- 盟市 -->
						<div id="ltrhao-city-panel" style="width:430px;">
						      <table  class="table table-hover ltrhaolefttable"   style="font-size:16px;cursor:pointer;height:98%;position:absolute;bottom:0px;top:0px;" id="ltrhao_city_table">
							  </table>
						</div>
						<!-- 旗县 -->
						<div id="ltrhao_district_panel" style="width:430px;display:none;">
						      <table class="table table-hover ltrhaolefttable" style="font-size:16px;cursor: pointer;position:absolute;bottom:0px;top:0px;" id="ltrhao_district_table">
							  </table>
					    </div>
					    <!-- 司法所 -->
					    <div id="ltrhao_org_panel" style="width:430px;display:none;">
						      <table class="table table-hover ltrhaolefttable" style="font-size:16px;cursor: pointer;position:absolute;bottom:0px;top:42px;margin-left: 20;" id="ltrhao_org_table">
							  </table>
						</div>
						<!-- 人员列表 -->
						<div id="ltrhao-org_per-panel" style="display:none;">
							<div style="text-align:center;">矫正人员明细列表</div>
							<div id="ltrhao_org_per_list"></div>
						</div>
				</div>
			</div>	
		</div>	
	</div>
<!-- 左侧列表 E -->
<div id="viewRepSqjz-right" class="jzry-bingt">
  <div class="jzry-bg-opacity"></div>
  <div> 	
  	<div class="jzry-biaoti" id="viewRepSqjz-right-biaoti">呼和浩特市矫正人员类别比例</div>
    <div class="jzry-gban">
    	<a href="#"><div id="spsSqjz-hidenDivBtn2" class="glyphicon glyphicon-remove-circle"></div></a>
    </div>
    <div class="jzry-xinx">
      <div id="container" style="height: 100%"></div>  
    </div>
    <div class="jzry-xinx-line"></div>
    <div class="jzry-icona"><img src="images/biandong.png"/></div>
    <div class="jzry-bdqk">变动情况</div>
    <div class="jzry-xzrsa"><span>本月新增人数</span><span>0</span></div>
    <div class="jzry-shouj"><span>本年收监</span><span>0</span></div>
    <div class="jzry-xzrsb"><span>本月新增人数</span><span>0</span></div>
    <div class="jzry-swang"><span>本年死亡</span><span>0</span></div>
    <div class="jzry-iconb"></div>
    <div class="jzry-iconb"><img src="images/dengji.png"/></div>
    <div class="jzry-jzdj">矫正等级</div>
    <div class="jzry-cjdj"><span>初级等级</span><span>0</span></div>
    <div class="jzry-ksgl"><span>宽松管理</span><span id="jzry-ksgl_sl">20</span></div>
    <div class="jzry-ptgl"><span>普通管理</span><span id="jzry-ptgl_sl">123</span></div>
    <div class="jzry-yggl"><span>严管管理</span><span id="jzry-yggl_sl">30</span></div>
  </div>
</div>
	<!-- 右侧开始 -->
	<div id="jzrydetailid_a" class="panel"
		style="position: absolute; top: 0px; right: 0px; bottom: 5px; width: 0px; height: 100%; background: #fff; border-radius: 0px; display: none;">
		<div id="close_view">
			<a href="#" title="关闭"><img style="height: 32px; width: 32px;"
				onclick="close_view_ringht()" src="../sqjz/mapimg/close.png"></img></a>
		</div>
		<div class="container" style="width: 525px;">
			<form class="navbar-form navbar-left">
				<div class="form-group">
					<label>日期</label>
					<div class="input-group input-group-sm">
						<input type="text" id="rep_day1" class="form-control form_date" value="<%=DateUtil.format(DateUtil.getDateBeforeOfDay(3), "yyyy-MM-dd")%>" style="width:100px;">
					</div>
					<div class="input-group input-group-sm">
						<input type="text" id="rep_day2" class="form-control form_date" value="<%=DateUtil.format(new Date(), "yyyy-MM-dd")%>" style="width:100px;">
					</div>
					
					<a href="#panel-1" data-toggle="tab" id="rep_query_btn"
						class="btn btn-default  btn-sm"
						style="width: 64px; margin-left: 10px; background: #166ced; color: #fff; border: none;">查询</a>
				</div>
			</form>
			<div class="row clearfix">
				<div class="col-md-12 column">
					<table width="80px;">
						<tr height="100px;">
							<td rowspan="2"><img id="imgId" src="../sqjz/mapimg/user.jpg"
								style="width: 70px; height: 90px; margin: 10px 10px 10px 14px; border-radius: 5px;"
								class="img-rounded"></td>
							<td valign="top">
								<table id="dwjk_jbxxview"
									style="width: 300px; margin-left: 20px; font-size: 14px;">
									<tr height="48px;">
										<td style="display: none;" id="id" field="id" width="84px"></td>
										<td id="xm" field="xm" width="84px">姓名：</td>
										<td id="xb" field="xb" code="SYS000" width="80px">性别：</td>
										<td id="mz" field="mz" code="SYS003"></td>
									</tr>
									<tr>
										<td ></td>
										<td id="fzlx" field="fzlx" code="SYS014" colspan="3"></td>
									</tr>
									<tr>
										<td>电话：</td><td id="grlxdh" field="grlxdh" colspan="3"></td>
										<!-- 这条属性从后台传输进来严管宽松严管 -->
									</tr>
								</table>
							</td>
							<td style="marging-top: 50px;">
								<button id="btn_jzryjbxx_daxx_modal" class="btn btn-default"
									style="background: #166ced; color: #fff; border: none; position: absolute; left: 380px; margin-top: 15px;">矫正档案</button>
							</td>
						</tr>
					</table>
					<div class="tabbable1" id="1tabs-139389">
						<ul id="jtqk_button" class="jtqk_button_li">
							<li  id="selectHdqk" style="margin-left: 0px; border-radius: 5px 0px 0px 5px; color: #fff;">
								<a href="#panel-1" data-toggle="tab"   class="active_li">活动情况</a>
							</li>
							<li id="selectJdqk" >
								<a href="#panel-2" data-toggle="tab"  class="active_li">签到情况</a></li>
							<li id="selectSmqk">
								<a href="#panel-3" data-toggle="tab" class="active_li">睡眠监控</a></li>
							<li id="selectXtqk" style="border-radius: 0px 5px 5px 0px; margin-right: 0px;">
								<a href="#panel-4" data-toggle="tab" class="active_li" >心跳检测</a>
							</li>
						</ul>
						<div class="tab-content" style="height: 98%;">
							<!-- 活动情况 S -->
							<div class="tab-pane  active" id="panel-1">
								<div class="col-md-12 column" style="padding-left: 15px; padding-right: 1px; height: 50px; margin-bottom: 20px;display:none;">
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总时长</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总长度</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="width: 105px; height: 50px; border: none; background: #e9ebee; color: #666;">
										<span style="color: #166ced;">运动总步数</span> <br /> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="vertical-align: middle; width: 105px; height: 50px; border: none; background: #e9ebee; color: #666; margin: 0;">
										<span style="color: #166ced;">提升高度</span> <br> <label
											id="zydbs" style="color: #666;"></label>
									</div>
									<div class="list-group" id="actId" style="margin-left: -14px;"></div>
									<!-- 活动情况 2 E
									活动描述结束 -->
								</div>
								<div id="jzryhdxxlist">
									<div field="f_hdlxms" label="活动类型"></div>
									<div field="f_hdjgms" label="活动描述"></div>
									<div field="f_addr" label="活动位置"></div>
								</div>
								<style>
								 #jzryhdxxlist th{
								 	font-size:14px;
								 	font-weight: normal;
								 	color:#888;
								 }
								</style>
							</div>
							<!-- 活动情况 E
							签到情况 S -->
							<div class="tab-pane" id="panel-2">
								<div id="qdxx_data_view" style="height:500px;overflow: auto;"></div>
							</div>
							<!-- 签到情况 E
							睡眠情况 S -->
							<div class="tab-pane" id="panel-3">
								<div class="col-md-12 column">
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px; height: 60px;">
										浅睡眠时长<br>4h
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px; height: 60px;">
										睡眠时长<br>5h
									</div>
									<div id="fat-btn" class="btn btn-primary"
										style="margin: 5px; width: 135px;; height: 60px;">
										深睡眠时长<br>6h
									</div>
									<div class="list-group"
										style="margin-left: -14px; overflow: hidden; height: 100%;">
										<div id="smsdChar"
											style="width: 460px; height: 135px; background: #f00;"></div>
									</div>
									<div class="list-group" style="margin-left: -14px;">
										<div id="smsyChar" style="width: 460px; height: 135px; margin-top: -470px;"></div>
									</div>
								</div>
							</div>
							<!-- 睡眠情况 E
							心跳情况 S -->
							<div class="tab-pane" id="panel-4">
								<div class="col-md-12 column">
									<div class="list-group"
										style="margin-left: -14px; overflow: hidden; height: 100%;">
										<div id="xtsj"
											style="width: 460px; height: 135px; background: #f00;"></div>
									</div>
								</div>
							</div>
							<!-- 心跳情况 E -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 右侧结束 -->
	<!-- 点击矫正人员总数，显示全区矫正人员管理情况表 -->
	<div id="jzrydetailid" class="panel" style="display:none;">
		    <div id="jzrydetailid-header">
		    	<img id="img-hidendiv" src="${localCtx}/resources/images/icon/return.png"></img>
		 	 	<span id="jzrydetailid-header-span">全区矫正人员管理情况表</span>
		    </div>
			<div style="font-size:16px;margin-left: 20px;margin-top:10px;">
			      <table><tr style="font-weight: bold;">
			      			<td width="50px;">排名</td>
			      			<td align="center"  width="100px;">姓名</td>
			      			<td align="center"  width="100px;">工作总量</td>
			      			<td width="120px;">平均响应时间</td>
			      <tr></table>
			</div>
			<div style="font-size: 18px;margin-top: 10px; margin-left:20px;">
			      <table  class="table table-hover">
				      <tr height="30px">
		      			<td width="50px;"><span class="badge"  style="background: red;">1</span></td>
		      			<td align="center"  width="100px;" id="wangyidan">王一旦</td>
		      			<td align="center"  width="100px;">2015件</td>
		      			<td width="50px;"><span class="badge" style="margin-left:20px;">5分钟</span></td>
				     <tr>
				     <tr height="30px">
		      			<td width="50px;"><span class="badge"  style="background: red;">2</span></td>
		      			<td align="center"  width="100px;">王李俊</td>
		      			<td align="center"  width="100px;">2015件</td>
		      			<td width="50px;"><span class="badge" style="margin-left:20px;">5分钟</span></td>
			      	 <tr>
			      	 <tr height="30px">
		      			<td width="50px;"><span class="badge"  style="background: red;">2</span></td>
		      			<td align="center"  width="100px;">王李俊</td>
		      			<td align="center"  width="100px;">2015件</td>
		      			<td width="50px;"><span class="badge" style="margin-left:20px;">5分钟</span></td>
			      	 <tr>
			      </table>
			</div>
		</div>
		<!--  区域显示隐藏的div  -->
 		<div type="hiden" id="spssqjz-hidenDiv" style="display:none;">
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
	
	
		<div class="modal fade" id="floorModal">
		<div class="modal-dialog"
			style="height: 30%; width: 480px; position: absolute; top: 216px; right: 20px;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">爬升楼层详细列表</h4>
				</div>
				<div class="modal-body" id="modal-body-8">
					<div class="tab-pane" id="panel-8" style="height: 719px;">
						<div class="list-group" id="floorId" style="margin-top: 8px;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	<div class="modal fade" id="jzryjbxx_daxx_modal">
		<div class="modal-dialog" style="width: 900px; top: 20px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">矫正人员详细信息</h4>
				</div>
				<div class="modal-body" style="height: 600px">
					<iframe id="frame_jzryjbxx_daxx_modal" url="${localCtx}/module/sqjz/viewGrdagl.jsp" style="width:100%;height:100%;margin:0px;" frameborder="0"></iframe>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>