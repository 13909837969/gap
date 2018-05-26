<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../resources/css/jzryDwjk.css"/>
<script type="text/javascript"  src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>

<title>服刑人员定位监控系统</title>
</head>
<script type="text/javascript">
$(function() {
	map = new BMap.Map("map_rqdwjk"); // 创建地图实例  
	map.centerAndZoom(new BMap.Point(111.712329, 40.832096999999997),13);
	//map.centerAndZoom(points[0], 15); // 初始化地图，设置中心点坐标和地图级别  
	//map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
});
</script>
<body>
<div  id="jzryDwjk">
<div id="map_rqdwjk" style="width: 100%; height: 100%;"></div>
  <div class="address-icon"><img src="../rep/images/address.png"/></div>
  <!--定位小图标-->
  <div class="searchbox">
    <div class="searchbox-text">
      <input style="width:315px;height:47px;border:none;border-radius:5px 0px 0px 5px;padding:0px;"placeholder="请输入姓名/手机号/身份证号进行搜索"/>
    </div>
    <div class="searchbox-button">
      <button><img src="../rep/images/search.png"/></button>
    </div>
  </div>
  <div class="cent">
    <div class="cent-searchbox">
      <div class="searchbox-start"><input style="height:18px;border:none;border-radius:5px 0px 0px 5px;padding:0px;"placeholder="查询开始日期"/></div>
      <div class="searchbox-line"></div>
      <div class="searchbox-end"><input style="border:none;"placeholder="查询结束日期"/></div>
      <div class="inquiry-button"><button>查询</button></div>
    </div>
    <!--日期查询结束-->
    <div class="jzry-information">
      <div class="information-img"><img src="../rep/images/search.png" title="头像"/></div>
      <div class="information">
        <div class="xinx_name">
          <span id="information-name">姓名：</span>
          <span id="information-xuxx">徐旭旭</span>
        </div>
        <div class="xinx_gender">
          <span id="information-gender">性别：</span>
          <span id="information-nan">男</span>
        </div>
        <div class="xinx_nation">
          <span id="information-nation">民族：</span>
          <span id="information-han">汉</span>
        </div>
        <div class="xinx_phone">
          <span id="information-phone">电话：</span>
          <span id="information-oft">15034444444</span>
        </div>
        <div class="xinxi_fzlx">
          <span id="information-fzlx">犯罪类型：</span>
          <span id="information-wcnfz">未成年犯罪</span>
        </div>
      </div>
      <div class="cle"></div>
      <div class="jz-button"><button>矫正档案</button></div>
    </div>
    <!--矫正档案结束-->
    <div class="jtqk"><!--jtqk表示具体情况-->
      <ul id="jtqk_button">
        <li style=" margin-left:0px; border-radius:5px 0px 0px 5px; background:#166ced; color:#fff;">活动情况</li>
        <li>签到情况</li>
        <li>心跳检测</li>
        <li style="border-radius:0px 5px 5px 0px;">睡眠监控</li>
      </ul>
      <ul id="jtqk_situation">
        <li style=" margin-left:0px; border-radius:5px 0px 0px 5px;">
          <span id="jtqk_situation_time">活动总时长</span>
          <span id="jtqk_situation_time2">3时15分</span>
        </li>
        <li>
          <span id="jtqk_situation_time">运动总长度</span>
          <span id="jtqk_situation_length">25.85km</span>
        </li>
        <li>
          <span id="jtqk_situation_time">运动总步数</span>
          <span id="jtqk_situation_steps">63043步</span>
        </li>
        <li style="border-radius:0px 5px 5px 0px;">
          <span id="jtqk_situation_time">提升高度</span>
          <span id="jtqk_situation_height">8米</span>
        </li>
      </ul>
    </div>
    <!--具体情况结束-->
    <div style="position:absolute ;overflow-y:auto;">
    <div class="activity-description">
      <div class="activity-description-cent">
        <div class="activity-description-img"></div>
        <div class="activity-description-time"><span>2017-08-28</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>18:28:23</span></div>
        <div class="current-state">当前状态：骑行</div>
        <div class="cle"></div>
      </div>
      <div class="activity-description-name">活动描述</div>
      <div>
      <div class="active-section">活动路段：在3.4Km~4.3Km路段测试心跳呼吸频率为骑行状态。</div>
      <div class="active-state">活动状态：正常</div>
    </div>
  </div>
  <div class="activity-description" style="background:#fff;">
    <div class="activity-description-cent">
      <div class="activity-description-img2"></div>
      <div class="activity-description-time"><span>2017-08-28</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>18:28:23</span></div>
      <div class="current-state">当前状态：出租车行驶</div>
      <div class="cle"></div>
    </div>
    <div class="activity-description-name">活动描述</div>
    <div>
      <div class="active-section">活动路段：在3.4Km~4.3Km路段测试心跳、呼吸频率等数据与现实路程有异常。</div>
      <div class="active-state">活动状态：异常</div>
    </div>
  </div>
  </div>
  <!--活动描述结束-->
  <!-- 
  <div class="scroll-bar">
    <div class="scroll-bar1"></div>
  </div>
  -->
  <!--滚动条结束-->
  <div class="segmenting-line"></div>
</div>
<!--右侧内容结束-->
<div class="tagging">
  <ul id="guidepost">
    <li><img src="../rep/images/bus.png"/><span>公交车</span></li>
    <li><img src="../rep/images/taxi.png"/><span>出租车</span></li>
    <li><img src="../rep/images/riding.png"/><span>骑行</span></li>
    <li><img src="../rep/images/walk.png"/><span>步行</span></li>
    <li><img src="../rep/images/starting_point.png"/><span>起点</span></li>
    <li><img src="../rep/images/end.png"/><span>终点</span></li>
    <li><img src="../rep/images/residence.png"/><span>住所</span></li>
  </ul>
</div>
<!--标注结束-->
</div>
</div>
</body>
</html>