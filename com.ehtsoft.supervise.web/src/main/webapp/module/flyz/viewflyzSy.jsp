<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>Insert title here</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="css/viewflyzSy.css?<%=Math.random()%>"/>
<script type="text/javascript" src="http://echarts.baidu.com/gallery/vendors/simplex.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="js/viewflyzSy.js"></script>
</head>
<body>
<div id="flyz_sy_cent">
  <div id="flyz_sy_head">
    <div id="flyz_sy_input">
      <input id="flyz_sy_input_qyss" type="text" placeholder="区域搜索" style="margin-left:7%;">
      <input id="flyz_sy_input_kssj" class="input-append date form_datetime" type="text" placeholder="开始时间">
      <input id="flyz_sy_input_jssj" class="input-append date form_datetime" type="text" placeholder="结束日期">
      <a href="#">
        <button type="button">搜索</button>
      </a>
      <a href="#"><div id="flyz_button_dcbg">导出表格</div></a>
    </div>
  </div>
  <div class="col-md-12">
    <div id="flyz_home_kp" class="col-md-12">
	   <ul>
	     <li class="col-md-3" style="padding-left:0px;">
		     <a href="#"><div class="col-md-12">
		       <span>各类案件受援人总数：</span>
		       <span>33024件</span>
		     </div></a>
	     </li>
	     <li class="col-md-3">
		     <a href="#"><div class="col-md-12">
		       <span>刑事案件总数：</span>
		       <span>4652件</span>
		     </div></a>
	     </li>
	     <li class="col-md-3">
		     <a href="#"><div class="col-md-12">
		       <span>民事案件总数：</span>
		       <span>4512件</span>
		     </div></a>
	     </li>
	      <li class="col-md-3">
		      <a href="#"><div class="col-md-12">
		        <span>机构总数：</span>
		        <span>12546个</span>
		      </div></a>
	      </li>
          <li class="col-md-3" style="padding-left:0px;">
	          <a href="#"><div class="col-md-12">
	            <span>人员总数：</span>
	            <span>479人</span>
	          </div></a>
          </li>
         <!--  <li class="col-md-6"><a href="#"><div><span>法律援助工作站总数：</span><span>2547个</span></a></li> -->
          <li class="col-md-3">
	          <a href="#"><div class="col-md-12">
	            <span>投诉处理情况：</span>
	            <span>5424件</span>
	          </div></a>
          </li>
	     <li class="col-md-3">
		     <a href="#"><div class="col-md-12">  
		       <span>行政案件总数：</span>
		       <span>4856件</span>
		     </div></a>
	     </li>
	     <li class="col-md-3">
		     <a href="#"><div class="col-md-12">
		       <span>咨询总数：</span>
		       <span>6953件</span>
		     </div></a>
	     </li>
	   </ul>
    </div>
  </div>
  <div id="flyz_tb_cent">
    <div id="flyz_cent_row" class="col-md-12">
      <div id="flyz_cent_fyajqk" class="col-md-8" style="padding-right:0px;padding-left:0px;">
        <div id="flyz_fyajpzqk_box" class="col-md-12">
        	<div class="flyz_whssqdly_box_textYZ" class="col-md-12">法律援助案件批准情况</div>
	        <div id="flyz_fytb" class="col-md-12">
	       
	        </div>
        </div>
        <div id="flyz_whams_box">
          <div id="flyz_whssqdly_box" class="col-md-6">
          	  <div class="flyz_whssqdly_box_textWH">挽回损失或取得利益总数</div>
	          <div id="flyz_whssqdly">
	            
	          </div>
          </div>
           <div id="flyz_whdssqdly_box" class="col-md-6">
              <div id="flyz_whssqdly_box_textMS" class="col-md-12">各类人群法律援助案件量</div>
	          <div id="flyz_msflyz_tb" class="col-md-12">
	          
	          </div>
	       </div>
        </div>
      </div>
      <div id="flyz_zxfs_box" class="col-md-4">
        <div class="col-md-12">
        	<div id="flyz_whssqdly_box_textZX" class="col-md-12">咨询方式</div>
            <div class="col-md-12" id="flyz_zxfs_box_zxfsa">
		      <div id="flyz_zxfs_tb" class="col-md-12">
		        
		      </div>
	      </div>
	    </div>
	  </div>
    </div>
    
    <!-- 咨询类型一行开始 -->
    <div id="flyz_cent_tubiaoq" class="col-md-12">
      <div id="flyz_cent_tubiaoqa" class="col-md-4">
        <div id="flyz_zxlx_sty">
        	<div id="flyz_whsasqdly_box_textZX" class="col-md-12">已结案件人员办理情况</div>
	        <div id="flyz_zxlx_tb" class="col-md-12">
	          
	        </div>
	        <div id="flyz_jgry_text">
	          <ul style="padding-left:0px;">
		         
	          </ul>
	        </div>
	    </div>
      </div>
      <div id="flyz_cent_tubiaod" class="col-md-8" style="padding-left:0px;">
         <div id="flyz_xsfy_tb" class="col-md-12" style="padding-right:15px;">
           <div id="flyz_xsfy_tb_text" class="col-md-12">刑事法律援助</div>
           <div id="flyz_xsfy_tb_bar" class="col-md-12">
          		
           </div>
        </div>
        <!--  -->
        <div id="flyz_xzfy_tb" class="col-md-6" style="padding-right:5px;">
           <div id="flyz_xzfy_tb_text" class="col-md-12">行政法律援助</div>
           <div id="flyz_xzfy_tb_bar" class="col-md-12">
           
           </div>
        </div>
        <div id="flyz_yjaj_tb" class="col-md-6" style="padding-left:35px;">
           <div id="flyz_yjaj_tb_text" class="col-md-12">民事法律援助</div>
           <div id="flyz_yjaj_tb_bar" class="col-md-12">
          		
           </div>
        </div> 
      </div>
    </div>
    <div class="col-md-12">
    	<div id="flyz_zxzs_tb" class="col-md-6" style="padding-left:15px;">
           <div id="flyz_zxzs_tb_text" class="col-md-12">咨询总数</div>
           <div id="flyz_zxzs_tb_bar" class="col-md-12">
          
           </div>
        </div>
        <div id="flyz_yjajpz_tb" class="col-md-6" style="padding-left:20px;padding-right:30px;">
           <div id="flyz_yjajpz_tb_text" class="col-md-12">已结案件批准情况</div>
           <div id="flyz_yjzjpz_tb_bar" class="col-md-12">
          		
           </div>
        </div>
    </div>
    
    
  </div>
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

</body>
</html>