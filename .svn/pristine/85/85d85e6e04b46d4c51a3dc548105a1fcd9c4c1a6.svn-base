<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/RepJszlService.js"></script>
<script type="text/javascript" src="js/viewZyqk.js"></script>
<title>资源情况</title>
<style type="text/css">
	html,body{
		min-width:1614px;
		width:100%;
		height:100%;
		background: url("images/zybackground.jpg");
		background-size: cover;
	}
	div{
		font-size:14px;
		color:#ffffff;
		height:30px;
	}
	
	/* 总表格 */
	#list{
		text-align: center;
		height:97%;
		}
	#lsgl-1{
		margin-bottom:10px;
	}
	/* 机构名字  */
	#lsgl-3,#lsgl-4,#gzzy-3,#gzzy-4,#rmtj-3,#rmtj-4,#sqjz-3,#sqjz-4,#sfjd-3,#sfjd-4{
		color:#00fbff;
	}
	.viewZyqk_jg{
		font-size:16px;
	}
	#fzzy-1,#rmtj-1,#lsgl-1,#sfjd-1,#gzzy-1,#sqjz-1{
	
		} 
	
	/* 机构数 */	
	#lsgl-5,#sfjd-5,#gzzy-5,#rmtj-5,#sqjz-5{
		color:#FFA500;
		}
	
	/* 人员数  */	
	#lsgl-6,#sfjd-6,#gzzy-6,#rmtj-6,#sqjz-6{
		color:#FFA500;
	}

	/* 序号  */
	.xuhao{
		border:1px solid #616e7f; 
		
	}
	.xuhaoq{
		border:1px solid #1888ff; 
	}
	
	/*标题*/
	.title{
		font-size: 20px;
		color:#fff;
		margin-top: 15px;
		margin-bottom:10px;
		border-color:#778899;
	}
	
	/*机构  */
	.jg{
		border:1px solid #194161;
		height: 65px; 
		color:#778899;
		font-size:20px;
	}
	.jg div{
		font-size: 16px;
	}
	/* 人数  */
	.ren{
	border:1px solid #3f493b;
	height: 65px;
	color:#CD853F;
	}
	
	.ren div{
		font-size: 16px;
	}
	/*全选  */
	.quanqu{
	font-size:18px;
	}

	.list_main{
	font-size: 18px;
	}
	.list_main_text{
		font-size:14px;
		vertical-align: middle;
	}
	/* .ltrhao-spsZyqk-body-div2-opacity{
		position: absolute;
	    top: 0px;
	    bottom: 0px;
	    left: 0px;
	    right: 0px;
	    background: #0b0d0f;
	    opacity: 0.9;
	} */
	#list_main_beirong{
	}
	.zyqk_panel li{
		margin:4px 0px;
		border: 2px solid transparent;
    	padding: 2px;
	}
	#list1::-webkit-scrollbar{
		width: 7px; 
	    height: 4px;
	    opacity:0.5;
	}
	#list1::-webkit-scrollbar-thumb {
		border-radius: 10px;
		/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
	    background:#a4cde5;
	    margin-right:2px;
	    
	}
	#list2::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
	    border-radius:10px;
	    background:#999;
	    margin-right:2px;
	}
	
	/**/
	#list2::-webkit-scrollbar{
		width: 7px; 
	    height: 4px;
	    opacity:0.5;
	}
	#list2::-webkit-scrollbar-thumb {
		border-radius: 10px;
		/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
	    background:#a4cde5;
	    margin-right:2px;
	    
	}
	#list2::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
	    border-radius:10px;
	    background:#999;
	    margin-right:2px;
	}
	/**/
	#list3::-webkit-scrollbar{
		width: 7px; 
	    height: 4px;
	    opacity:0.5;
	}
	#list3::-webkit-scrollbar-thumb {
		border-radius: 10px;
		/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
	    background:#a4cde5;
	    margin-right:2px;
	    
	}
	#list3::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
	    border-radius:10px;
	    background:#999;
	    margin-right:2px;
	}
	/**/
	#list4::-webkit-scrollbar{
		width: 7px; 
	    height: 4px;
	    opacity:0.5;
	}
	#list4::-webkit-scrollbar-thumb {
		border-radius: 10px;
		/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
	    background:#a4cde5;
	    margin-right:2px;
	    
	}
	#list4::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
	    border-radius:10px;
	    background:#999;
	    margin-right:2px;
	}
	/**/
	#list5::-webkit-scrollbar{
		width: 7px; 
	    height: 4px;
	    opacity:0.5;
	}
	#list5::-webkit-scrollbar-thumb {
		border-radius: 10px;
		/*-webkit-box-shadow: inset 0 0 10px rgba(0,0,0,0.2);*/
	    background:#a4cde5;
	    margin-right:2px;
	    
	}
	#list5::-webkit-scrollbar-track {
		-webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
	    border-radius:10px;
	    background:#999;
	    margin-right:2px;
	}
	/*line*/
	.lsgl-1_line{
		width:80%;
		height:1px;
		background:#145486;
		margin:0 auto;
	}
	.lsgl_dtxg_border{
		border:1px solid #f00;
		height:32px;
		}
	#gzzy-1,#sfjd-2{
		margin-bottom:10px;
	}
	.viewZyqk-title{
		width:100%;
		padding-top:10px;
		
	}
	.viewZyqk-title div{
		width:90%;
		font-size:20px;
		float:left;
		line-height:30px;
		margin:0 auto;
		text-align:center;
	}
	.viewZyqk-title div span{
		width:145px;
	}
		/* 分表格 */
	.zyqk_panel{
		height:95%;
		background-color:#1d2942;
		min-width:250px;
		line-height:30px;
		opacity: 0.9;
		border:1px solid #6fb4f3;
		border-radius:8px;
		margin:0px 10px 0px 10px;
		margin-top:15px;
		overflow-x: hidden;
	    overflow-y: auto;
	}
	#sfjd >li{
		margin:4px 0px;
		border: 2px solid transparent;
    	padding: 2px;
	}
	.mouseover_selected{
		border: 2px solid #f00 !important;
	}
</style>
</head>
<body>
<!-- 标题 -->
<div style="width:100%;height:100%;" class="view_zyqk">
	<div id="list" class="col-md-12 col-sm-12">
		<div class="viewZyqk-title">
		<div style="width:30px;height:10px;padding-left:100px;float:left;" >
		</div>
			<div>
			<a href="nnn_viewJCZLDSJ.jsp"  style="float: left;width: 47px;"><img alt="返回" src="images/bbb.png"></a>
				<span>综合资源管理情况</span>
			</div>
		</div>
		<div class="col-md-1 col-sm-1" style="padding-right:0px;padding-left:0px;width:5%;"></div>
		<div id="list1" class="col-md-2 col-sm-2 zyqk_panel" style="margin-left:0px;">
			<div id="lsgl-1" class="title"><span class="glyphicon glyphicon-user" style="padding-right:10px;"></span>律师管理信息</div>
			<div class="lsgl-1_line"></div>
			<div id="lsgl-2" class="quanqu list_main_text" >全区</div>
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="jg" >
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="lsgl-3">机构</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="lsgl-5">0</div>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="ren">
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="lsgl-4">律师</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="lsgl-6">0</div>
					</div>
				</div>
			</div>
			<div class="row list_main_text"></div>
			<div class="list_main" id="list_main_beirong">
				<div class="row list_main_text">
					<div class="col-md-3 col-sm-2 col-xs-2 list_main_text" id="lsgl-7">序号</div>
					<div class="col-md-5 col-sm-4 col-xs-4 list_main_text" id="lsgl-8">区域</div>
					<div class="col-md-4 col-sm-6 col-xs-6 list_main_text" id="lsgl-9">机构总数</div>
				</div>
				<!------------------------------------------------->
				<ul style="margin-left:-15%;" id ="lsul">
				</ul>
				<!-------------------------------------------------------------------->
			</div>
		</div>	
		<div id="list2" class="col-md-2 col-sm-2 zyqk_panel">
			<div id="sfjd-1" class="title"><span class="glyphicon glyphicon-eye-open"style="padding-right:10px;"></span>司法鉴定资源情况</div>
			<div class="lsgl-1_line"></div>
			<div id="sfjd-2" class="quanqu list_main_text">全区</div>
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="jg" >
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="sfjd-3">机构</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="sfjd-5">0</div>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="ren">
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="sfjd-4">鉴定人员</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="sfjd-6">0</div>
					</div>
				</div>
			</div>
			<div class="row list_main_text"></div>
			<div class="row list_main_text">
				<div class="col-md-3 col-sm-2 col-xs-2 list_main_text" id="sfjd-7">序号</div>
				<div class="col-md-5 col-sm-4 col-xs-4 list_main_text" id="sfjd-8">区域</div>
				<div class="col-md-4 col-sm-6 col-xs-6 list_main_text" id="sfjd-9">机构总数</div>
			</div>
				<ul style="margin-left:-15%;" id ="sfjd">
				</ul>
		</div>
		
		
		<div id="list3" class="col-md-2 col-sm-2 zyqk_panel">
			<div id="gzzy-1" class="title"><span class="glyphicon glyphicon-list-alt"style="padding-right:10px;"></span>公证资源情况</div>
			<div class="lsgl-1_line"></div>
			<div id="gzzy-2" class="quanqu list_main_text">全区</div>
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="jg" >
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="gzzy-3">机构</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="gzzy-5">0</div>
					</div>
				</div>
				<div  class="col-md-6 col-sm-6 col-xs-6" >
					<div class="ren">
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="gzzy-4">工证人员</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="gzzy-6">0</div>
					</div>
				</div>
			</div>
			<div class="row list_main_text"></div>
			<div class="row list_main_text">
				<div  class="col-md-3 col-sm-2 col-xs-2 list_main_text" id="gzzy-7">序号</div>
				<div  class="col-md-5 col-sm-4 col-xs-4 list_main_text" id="gzzy-8">区域</div>
				<div  class="col-md-4 col-sm-6 col-xs-6 list_main_text" id="gzzy-9">机构总数</div>
			</div>
				<!------------------------------------------------->
				<ul style="margin-left:-15%;" id ="gzzy">
				</ul>
				<!-------------------------------------------------------------------->
		</div>
	
		
		<div id="list4" class="col-md-2 col-sm-2 zyqk_panel">
			<div id="rmtj-1" class="title"><span class="glyphicon glyphicon-random"style="padding-right:10px;"></span>人民调解资源信息</div>
			<div class="lsgl-1_line"></div>
			<div id="rmtj-2" class="quanqu list_main_text">全区</div>
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div  class="jg" >
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="rmtj-3">机构</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="rmtj-5">0</div>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="ren">
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="rmtj-4">调解员</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="rmtj-6">0</div>
					</div>
				</div>
			</div>
			<div class="row list_main_text"></div>
					<div class="row list_main_text">
				<div class="col-md-3 col-sm-2 col-xs-2 list_main_text" id="rmtj-7">序号</div>
				<div class="col-md-5 col-sm-4 col-xs-4 list_main_text" id="rmtj-8">区域</div>
				<div class="col-md-4 col-sm-6 col-xs-6 list_main_text" id="rmtj-9">机构总数</div>
			</div>
				<!------------------------------------------------->
				<ul style="margin-left:-15%;" id ="rmtj">
				</ul>
				<!-------------------------------------------------------------------->
			
		</div>
		
		
		<div id="list5" class="col-md-2 col-sm-2 zyqk_panel">
			<div id="sqjz-1" class="title"><span class="glyphicon glyphicon-folder-open"style="padding-right:10px;"></span>社区矫正资源信息</div>
			<div class="lsgl-1_line"></div>
			<div id="sqjz-2" class="quanqu list_main_text">全区</div>
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div  class="jg" >
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="sqjz-3">机构</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="sqjz-5">0</div>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6" >
					<div class="ren">
						<div class="col-md-12 col-sm-12 col-xs-12 viewZyqk_jg" id="sqjz-4">工作人员</div>
						<div class="col-md-12 col-sm-12 col-xs-12" id="sqjz-6">0</div>
					</div>
				</div>
			</div>
			<div class="row list_main_text"></div>
				<div class="row list_main_text">
					<div  class="col-md-3 col-sm-2 col-xs-2 list_main_text" id="sqjz-7">序号</div>
					<div  class="col-md-5 col-sm-4 col-xs-4 list_main_text" id="sqjz-8">区域</div>
					<div  class="col-md-4 col-sm-6 col-xs-6 list_main_text" id="sqjz-9">机构总数</div>
				</div>
			<!------------------------------------------------->
				<ul style="margin-left:-15%;" id ="sqjz">
				</ul>
				<!-------------------------------------------------------------------->
		</div>
		<div class="col-md-1 col-sm-1" style="padding-right:0px;padding-left:0px;width:1%;"></div>
	</div>
</div>
</body>
</html>