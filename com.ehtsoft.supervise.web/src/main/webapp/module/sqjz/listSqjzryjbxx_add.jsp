<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>个人基本信息-操作页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript">
/* 
 * 户籍地是否与居住地相同字段:
 *	 				相同:1
 *					不同:0 
 */
$(function(){
	$("#sqjz_listSqjzryjbxx_add #phfile").change(function(){
		$("#uploadForm").submit();
		$("#sqjz_listSqjzryjbxx_add #xians").attr("src","${localCtx}/image/RMIImageService?_table_name=JZ_JZRYJBXX_IMG&imgid=" + $("#xxid").val());
		console.log($("#xians").attr("src"));
	});
	
});
</script>
<style type="text/css">

	.col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, 
	.col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9,
	.col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-12, .col-sm-7, .col-sm-8, .col-sm-9,
	.col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 
	{
		position: relative;
		min-height: 1px;
		padding-right: 10px;
		padding-left: 10px;
		padding-top:5px;
		padding-motton:5px;
		text-align:left;
	}
	.img-thumbnail {
	    display: inline-block;
	    max-width: 100%;
	    height: 130px;
	    width:95px;
	    padding: 4px;
	    line-height: 1.42857143;
	    background-color: #fff;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    -webkit-transition: all .2s ease-in-out;
	    -o-transition: all .2s ease-in-out;
	    transition: all .2s ease-in-out;
	}
	.col-sm-12 .col-sm-6{
		padding-left: 10px;
	}
	.sfradio input[type='radio'],input[type='checkbox']{
		margin-left:50px;
	}
	.left50{/* 内容区离模态框左边50px */
		margin-left:50px;
	}
</style>
</head>
<%String jzryjbxxid = UUID.randomUUID().toString(); %>
<%=jzryjbxxid %>
<body><!--data-spy="scroll" data-target=".navbar-example" -->
	<div id="sqjz_listSqjzryjbxx_add" class="container-fluid">
		<!-- <form class="form-horizontal" role="form" id="form"> -->
		<div style="position:fixed"><!--class="navbar-example" -->
			<ul class="nav nav-pills nav-stacked pull-left">
				<li class="active">
					<a href="#jzryjbxx" data-toggle="tab">基<br>本<br>信<br>息</a>
				</li>
				<li>
					<a href="#jzrygrjl" data-toggle="tab">个<br>人<br>简<br>历</a>
				</li>
				<li>
					<a href="#jtcyjshgx" data-toggle="tab">家<br>庭<br>成<br>员<br>及<br>主<br>要<br>社<br>会<br>关<br>系</a>
				</li>
			</ul>
		</div>
		
					
		<div class="tab-content left50">
			<div class="tab-pane active" id="jzryjbxx">
			<p>
				<div class="col-xs-12 col-sm-6" style="text-align:center; padding-top:50px;">
					<label for="phfile"><img id="zpxs" class="img-thumbnail" alt="正面免冠二寸彩色证件照" width="295" height="413"/></label>
					<form id="uploadForm"  
						action="${localCtx}/image/RMIImageService?_table_name=JZ_JZRYJBXX_IMG&imgid=<%=jzryjbxxid%>"
						method="post" enctype="multipart/form-data" target="importFrame" 
						style="margin:0px;padding:0px;display:none;">
						<input id="phfile" type="file" name="filename" class="eht-toolbar-file"/>
						<iframe id="xians"name="importFrame" style="width:0;height:0;display:none;"></iframe>
					</form>
				</div>
			<form action="#">
				<input id="xxid" type="hidden" name="id" value="<%=jzryjbxxid%>"/>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzrybh" class="col-sm-12 control-label">1.社区服刑人员编号:</label>
						<div class="col-sm-12">
							<input id="sqjzrybh" name="sqjzrybh" onblur="vld(event)" type="text" required class="form-control" autocomplete="off">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="jzjgbm" class="col-sm-12 control-label">2.矫正机构编码:</label>
						<div class="col-sm-12">
							<input id="jzjgbm" name="jzjgbm" onblur="vld(event)" type="text" class="form-control" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfdcpg" class="col-sm-12 control-label">3.是否调查评估:</label>
						<div class="col-sm-12 sfradio" id="sfdcpg" name="sfdcpg">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="dcpgyj" class="col-sm-12 control-label">4.调查评估意见:</label>
						<div class="col-sm-12 sfradio" id="dcpgyj" name="dcpgyj">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="dcyjcxqk" class="col-sm-12 control-label">5.调查意见采信情况:</label>
						<div class="col-sm-12 sfradio"  id="dcyjcxqk" name="dcyjcxqk">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="jzlb" class="col-sm-12 control-label">6.矫正类别:</label>
						<div class="col-sm-12">
							<select id="jzlb" name="jzlb" class="form-control" onchange="vld(event)" onblur="vld(event)" onclick="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfcn" class="col-sm-12 control-label">7.是否成年:</label>
						<div class="col-sm-12 sfradio"  id="sfcn" name="sfcn">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="wcn" class="col-sm-12 control-label">8.未成年:</label>
						<div class="col-sm-12 sfradio" id="wcn" name="wcn">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="xm" class="col-sm-12 control-label">9.姓名:</label>
						<div class="col-sm-12">
							<input id="xm" name="xm" type="text" required class="form-control" onblur="vld(event)"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="cym" class="col-sm-12 control-label">10.曾用名:</label>
						<div class="col-sm-12">
							<input id="cym" name="cym" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="xb" class="col-sm-12 control-label">11.性别:</label>
						<div class="col-sm-12 sfradio" id="xb" name="xb">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-12">
						<label for="mz" class="col-sm-12 control-label">12.民族:</label>
						<div class="col-sm-5">
							<select id="mz" name="mz" class="form-control">
								<option value=""></option>
							</select>
						</div>
						<div class="col-sm-2">
							<label><input id="mzTag" style="margin-left:0;margin-right:0;" type="checkbox">其他</label>
						</div>
						<div class="col-sm-5">
								<input id="mzQ" type="text" class="form-control" autocomplete="off" placeholder="请输入民族">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfzh" class="col-sm-12 control-label">13.身份证号:</label>
						<div class="col-sm-12">
							<input id="sfzh" name="sfzh" type="text" class="form-control" onblur="vld(event)"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="csrq" class="col-sm-12 control-label">14.出生日期:</label>
						<div class="col-sm-12">
							<input id="csrq" name="csrq" type="text" class="form-control form_date" onblur="vld(event)"  autocomplete="off" data-date-format="yyyy-MM-dd">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="ywgatsfz" class="col-sm-12 control-label">15.有无港澳台身份证:</label>
						<div class="col-sm-12 sfradio" id="ywgatsfz" name="ywgatsfz">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gatsfzlx" class="col-sm-12 control-label">16.港澳台身份证类型:</label>
						<div class="col-sm-12 sfradio" id="gatsfzlx" name="gatsfzlx">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="gatsfzhm" class="col-sm-12 control-label">17.港澳台身份证号码:</label>
						<div class="col-sm-12">
							<input id="gatsfzhm" name="gatsfzhm" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="ywhz" class="col-sm-12 control-label">18.有无护照:</label>
						<div class="col-sm-12 sfradio" id="ywhz" name="ywhz">
						</div>	
					</div>
				</div>	
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="hzhm" class="col-sm-12 control-label">19.护照号码:</label>
						<div class="col-sm-12">
							<input id="hzhm" name="hzhm" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="hzbczt" class="col-sm-12 control-label">20.护照保存状态:</label>
						<div class="col-sm-12">
							<select id="hzbczt" name="hzbczt" class="form-control">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="ywgattxz" class="col-sm-12 control-label">21.有无港澳台通行证:</label>
						<div class="col-sm-12 sfradio" id="ywgattxz" name="ywgattxz">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="gattxzlx" class="col-sm-12 control-label">22.港澳台通行证类型:</label>
						<div class="col-sm-12 sfradio" id="gattxzlx" name="gattxzlx">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gattxzhm" class="col-sm-12 control-label">23.港澳台通行证号码:</label>
						<div class="col-sm-12">
							<input id="gattxzhm" name="gattxzhm" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="gattxzbczt" class="col-sm-12 control-label">24.港澳台通行证保存状态:</label>
						<div class="col-sm-12">
							<select id="gattxzbczt" name="gattxzbczt" class="form-control">
								<option value=""></option>
							</select>							
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="ywgajmwlndtxz" class="col-sm-12 control-label">25.有无港澳居民往来内地通行证:</label>
						<div class="col-sm-12 sfradio" id="ywgajmwlndtxz" name="ywgajmwlndtxz">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gajmwlndtxz" class="col-sm-12 control-label">26.港澳居民往来内地通行证号码:</label>
						<div class="col-sm-12">
							<input id="gajmwlndtxz" name="gajmwlndtxz" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="gajmwlndtxzbczt" class="col-sm-12 control-label">27.港澳居民往来内地通行证保存状态:</label>
						<div class="col-sm-12">
							<select id="gajmwlndtxzbczt" name="gajmwlndtxzbczt" class="form-control">
								<option value=""></option>
							</select>	
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="ywtbz" class="col-sm-12 control-label">28.有无台胞证:</label>
						<div class="col-sm-12 sfradio" id="ywtbz" name="ywtbz">
						</div>	
					</div>
					<div class="col-xs-12 col-sm-6">
						<label for="tbzhm" class="col-sm-12 control-label">29.台胞证号码:</label>
						<div class="col-sm-12">
							<input id="tbzhm" name="tbzhm" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="tbzbczt" class="col-sm-12 control-label">30.台胞证保存状态:</label>
						<div class="col-sm-12">
							<select id="tbzbczt" name="tbzbczt" class="form-control">
								<option value=""></option>
							</select>	
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="zyjwzxrystzk" class="col-sm-12 control-label">31.暂予监外执行人员身体状况:</label>
						<div class="col-sm-12 sfradio" id="zyjwzxrystzk" name="zyjwzxrystzk">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="zhjzyy" class="col-sm-12 control-label">32.最后就诊医院:</label>
						<div class="col-sm-12">
							<input id="zhjzyy" name="zhjzyy" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfyjsb" class="col-sm-12 control-label">33.是否有精神病:</label>
						<div class="col-sm-12 sfradio" id="sfyjsb" name="sfyjsb">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="jdjg" class="col-sm-12 control-label">34.鉴定机构:</label>
						<div class="col-sm-12">
							<input id="jdjg" name="jdjg" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfycrb" class="col-sm-12 control-label">35.是否有传染病:</label>
						<div class="col-sm-12 sfradio" id="sfycrb" name="sfycrb">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="jtcrb" class="col-sm-12 control-label">36.具体传染病:</label>
						<div class="col-sm-12">
							<select  id="jtcrb" name="jtcrb" class="form-control">
								<option value=""></option>
							</select>							
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="whcd" class="col-sm-12 control-label">37.文化程度:</label>
						<div class="col-sm-12">
							<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
							<select  id="whcd" name="whcd" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="hyzk" class="col-sm-12 control-label">38.婚姻状况:</label>
						<div class="col-sm-12 sfradio" id="hyzk" name="hyzk">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="pqzy" class="col-sm-12 control-label">39.捕前职业:</label>
						<div class="col-sm-12">
							<select id="pqzy" name="pqzy" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="jyjxqk" class="col-sm-12 control-label">40.就业就学情况:</label>
						<div class="col-sm-12 sfradio" id="jyjxqk" name="jyjxqk">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="xzzmm" class="col-sm-12 control-label">41.现政治面貌:</label>
						<div class="col-sm-12">
							<select id="xzzmm" name="xzzmm" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="yzzmm" class="col-sm-12 control-label">42.原政治面貌:</label>
						<div class="col-sm-12">
							<select id="yzzmm" name="yzzmm" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="ygzdw" class="col-sm-12 control-label">43.原工作单位:</label>
						<div class="col-sm-12">
							<input id="ygzdw" name="ygzdw" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="xgzdw" class="col-sm-12 control-label">44.现工作单位:</label>
						<div class="col-sm-12">
							<input id="xgzdw" name="xgzdw" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="dwlxdh" class="col-sm-12 control-label">45.单位联系电话:</label>
						<div class="col-sm-12">
							<input id="dwlxdh" name="dwlxdh" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">	
					<div class="col-xs-6 col-sm-6">
						<label for="grlxdh" class="col-sm-12 control-label">46.个人手机号:</label>
						<div class="col-sm-12">
							<input id="grlxdh" name="grlxdh" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="col-xs-6 col-sm-6">
						<label for="qtlxfs" class="col-sm-12 control-label">其它联系方式:</label>
						<div class="col-sm-12">
							<input id="qtlxfs" name="qtlxfs" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gj" class="col-sm-12 control-label">47.国籍:</label>
						<div class="col-sm-12 sfradio" id="gj" name="gj">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="yxjtcyjzyshgx" class="col-sm-12 control-label">48.有无家庭成员及主要社会关系:</label>
						<div class="col-sm-12 sfradio" id="yxjtcyjzyshgx" name="yxjtcyjzyshgx">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="hjdsfyjzdxt" class="col-sm-12 control-label">49.户籍地是否与居住地相同:</label>
						<div class="col-sm-12 sfradio">
							<input name="hjdsfyjzdxt" type="radio" value="1" autocomplete="off">相同
							<input name="hjdsfyjzdxt" type="radio" value="0" autocomplete="off">不同
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gdjzdszs" class="col-sm-12 control-label">50.固定居住地所在省（区、市）:</label>
						<div class="col-sm-12">
							<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
							<select  id="gdjzdszs" name="gdjzdszs" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="gdjzdszds" class="col-sm-12 control-label">51.固定居住地所在地（市、州）:</label>
						<div class="col-sm-12">
							<select id="gdjzdszds" name="gdjzdszds" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gdjzdszxq" class="col-sm-12 control-label">52.固定居住地所在县（市、区）:</label>
						<div class="col-sm-12">
							<select id="gdjzdszxq" name="gdjzdszxq" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="gdjzd" class="col-sm-12 control-label">53.固定居住地（乡镇、街道）:</label>
						<div class="col-sm-12">
							<input id="gdjzd" name="gdjzd" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="gdjzdmx" class="col-sm-12 control-label">54.固定居住地明细:</label>
						<div class="col-sm-12">
							<input id="gdjzdmx" name="gdjzdmx"  readonly="readonly" type="text" class="form-control"  autocomplete="off">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="hjszs" class="col-sm-12 control-label">55.户籍所在省（区、市）:</label>
						<div class="col-sm-12">
							<select id="hjszs" name="hjszs" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="hjszds" class="col-sm-12 control-label">56.户籍所在地（市、州）:</label>
						<div class="col-sm-12">
							<select id="hjszds" name="hjszds" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="hjszxq" class="col-sm-12 control-label">57.户籍所在县（市、区）:</label>
						<div class="col-sm-12">
							<select id="hjszxq" name="hjszxq" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="hjszd" class="col-sm-12 control-label">58.户籍所在地（乡镇、街道）:</label>
						<div class="col-sm-12">
							<input id="hjszd" name="hjszd" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
							<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-12">
						<label for="hjszdmx" class="col-sm-12 control-label">59.所在地明细:</label>
						<div class="col-sm-12">
							<input id="hjszdmx" name="hjszdmx" type="text" readonly="readonly" class="form-control" autocomplete="off" placeholder="请输入">
							<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfswry" class="col-sm-12 control-label">60.是否三无人员:</label>
						<div class="col-sm-12 sfradio" id="sfswry" name="sfswry">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="jzjg" class="col-sm-12 control-label">61.矫正机构:</label>
						<div class="col-sm-12">
							<input id="jzjg" name="jzjg" type="text" class="form-control" autocomplete="off" placeholder="请输入" onblur="vld(event)">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzjdjg" class="col-sm-12 control-label">62.社区矫正决定机关:</label>
						<div class="col-sm-12 sfradio" id="sqjzjdjg" name="sqjzjdjg">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzjdjgmc" class="col-sm-12 control-label">63.社区矫正决定机关名称:</label>
						<div class="col-sm-12">
							<input id="sqjzjdjgmc" name="sqjzjdjgmc" type="text" class="form-control" autocomplete="off" placeholder="请输入" onblur="vld(event)">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="zxtzswh" class="col-sm-12 control-label">64.执行通知书文号:</label>
						<div class="col-sm-12">
							<input id="zxtzswh" name="zxtzswh" type="text" class="form-control"  autocomplete="off" placeholder="请输入" onblur="vld(event)">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="zxtzsrq" class="col-sm-12 control-label">65.执行通知书日期:</label>
						<div class="col-sm-12">
							<input id="zxtzsrq" name="zxtzsrq" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" autocomplete="off" onblur="vld(event)">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="jfzxrq" class="col-sm-12 control-label">66.交付执行日期:</label>
						<div class="col-sm-12">
							<input id="jfzxrq" name="jfzxrq" type="text" class="form-control form_date" onblur="vld(event)" data-date-format="yyyy-MM-dd"  autocomplete="off">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="yjzfjg" class="col-sm-12 control-label">67.移交罪犯机关:</label>
						<div class="col-sm-12 sfradio" id="yjzfjg" name="yjzfjg">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="yjzfjgmc" class="col-sm-12 control-label">68.移交罪犯机关名称:</label>
						<div class="col-sm-12">
							<input id="yjzfjgmc" name="yjzfjgmc" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sfyqk" class="col-sm-12 control-label">69.是否有前科:</label>
						<div class="col-sm-12 sfradio" id="sfyqk" name="sfyqk">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sflf" class="col-sm-12 control-label">70.是否累犯:</label>
						<div class="col-sm-12 sfradio" id="sflf" name="sflf">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="qklx" class="col-sm-12 control-label">71.前科类型:</label>
						<div class="col-sm-12 sfradio" id="qklx" name="qklx">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="zyfzss" class="col-sm-12 control-label">72.主要犯罪事实:</label>
						<div class="col-sm-12">
							<input id="zyfzss" name="zyfzss" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzqx" class="col-sm-12 control-label">73.社区矫正期限:</label>
						<div class="col-sm-12">
							<input id="sqjzqx" name="sqjzqx" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzksrq" class="col-sm-12 control-label">74.社区矫正开始日期:</label>
						<div class="col-sm-12">
							<input id="sqjzksrq" name="sqjzksrq" type="text" class="form-control form_date" onblur="vld(event)" data-date-format="yyyy-MM-dd"  autocomplete="off">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzjsrq" class="col-sm-12 control-label">75.社区矫正结束日期:</label>
						<div class="col-sm-12">
							<input id="sqjzjsrq" name="sqjzjsrq" type="text" class="form-control form_date" onblur="vld(event)" data-date-format="yyyy-MM-dd" autocomplete="off">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="fzlx" class="col-sm-12 control-label">76.犯罪类型:</label>
						<div class="col-sm-12">
							<select id="fzlx" name="fzlx" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="jtzm" class="col-sm-12 control-label">77.具体罪名:</label>
						<div class="col-sm-12">
							<input id="jtzm" name="jtzm" type="text" class="form-control"  onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="gzqx" class="col-sm-12 control-label">78.管制期限:</label>
						<div class="col-sm-12 sfradio" id="gzqx" name="gzqx">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="hxkyqx" class="col-sm-12 control-label">79.缓刑考验期限:</label>
						<div class="col-sm-12 ">
							<select id="hxkyqx" name="hxkyqx" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>	
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfszbf" class="col-sm-12 control-label">80.是否数罪并罚:</label>
						<div class="col-sm-12 sfradio" id="sfszbf" name="sfszbf">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="ypxf" class="col-sm-12 control-label">81.原判刑罚:</label>
						<div class="col-sm-12 sfradio" id="ypxf" name="ypxf">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="ypxq" class="col-sm-12 control-label">82.原判刑期:</label>
						<div class="col-sm-12">
							<input id="ypxq" name="ypxq" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="ypxqksrq" class="col-sm-12 control-label">83.原判刑期开始日期:</label>
						<div class="col-sm-12">
							<input id="ypxqksrq" name="ypxqksrq" type="text" class="form-control form_date" onblur="vld(event)" data-date-format="yyyy-MM-dd" autocomplete="off">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="ypxqjsrq" class="col-sm-12 control-label">84.原判刑期结束日期:</label>
						<div class="col-sm-12">
							<input id="ypxqjsrq" name="ypxqjsrq" type="text" class="form-control form_date" onblur="vld(event)" data-date-format="yyyy-MM-dd"  autocomplete="off">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="yqtxqx" class="col-sm-12 control-label">85.有期徒刑期限:</label>
						<div class="col-sm-12">
							<select  id="yqtxqx" name="yqtxqx" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>	
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="fjx" class="col-sm-12 control-label">86.附加刑:</label>
						<div class="col-sm-12">
							<select id="fjx" name="fjx" class="form-control">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sfwd" class="col-sm-12 control-label">87.是否“五独”:</label>
						<div class="col-sm-12">
							<select  id="sfwd" name="sfwd" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfws" class="col-sm-12 control-label">88.是否“五涉”:</label>
						<div class="col-sm-12">
							<select id="sfws" name="sfws" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sfyss" class="col-sm-12 control-label">89.是否有“四史”:</label>
						<div class="col-sm-12 ">
							<select id="sfyss" name="sfyss" class="form-control" onblur="vld(event)">
								<option value=""></option>
							</select>
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sfbxgjzl" class="col-sm-12 control-label">90.是否被宣告禁止令:</label>
						<div class="col-sm-12 sfradio" id="sfbxgjzl" name="sfbxgjzl">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzryjsrq" class="col-sm-12 control-label">91.社区服刑人员接收日期:</label>
						<div class="col-sm-12">
							<input id="sqjzryjsrq" name="sqjzryjsrq" type="text" onblur="vld(event)" class="form-control form_date" data-date-format="yyyy-MM-dd" autocomplete="off">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sqjzryjsfs" class="col-sm-12 control-label">92.社区服刑人员接收方式:</label>
						<div class="col-sm-12 sfradio" id="sqjzryjsfs" name="sqjzryjsfs">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="flwssdsj" class="col-sm-12 control-label">93.法律文书收到时间:</label>
						<div class="col-sm-12">
							<input id="flwssdsj" name="flwssdsj" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" autocomplete="off">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="flwszl" class="col-sm-12 control-label">94.法律文书种类:</label>
						<div class="col-sm-12">
							<select id="flwszl" name="flwszl" class="form-control">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="bdqk" class="col-sm-12 control-label">95.报到情况:</label>
						<div class="col-sm-12 sfradio" id="bdqk" name="bdqk">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="wasbdqksm" class="col-sm-12 control-label">96.未按时报到情况说明:</label>
						<div class="col-sm-12">
							<input id="wasbdqksm" name="wasbdqksm" type="text" class="form-control"  autocomplete="off" placeholder="请输入">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sfjljzxz" class="col-sm-12 control-label">97.是否建立矫正小组:</label>
						<div class="col-sm-12 sfradio" id="sfjljzxz" name="sfjljzxz">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="jzxzryzcqk" class="col-sm-12 control-label">98.矫正小组人员组成情况:</label>
						<div class="col-sm-12">
							<select id="jzxzryzcqk" name="jzxzryzcqk" class="form-control">
								<option value=""></option>
							</select>
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="sfcydzdwgl" class="col-sm-12 control-label">99.是否采用电子定位管理:</label>
						<div class="col-sm-12 sfradio" id="sfcydzdwgl" name="sfcydzdwgl">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="dzdwfs" class="col-sm-12 control-label">100.电子定位方式:</label>
						<div class="col-sm-12 sfradio" id="dzdwfs" name="dzdwfs">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-6">
						<label for="dwhm" class="col-sm-12 control-label">101.定位号码:</label>
						<div class="col-sm-12">
							<input id="dwhm" name="dwhm" type="text" class="form-control" autocomplete="off" placeholder="请输入">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-6">
						<label for="sftk" class="col-sm-12 control-label">102.是否脱管:</label>
						<div class="col-sm-12 sfradio" id="sftk" name="sftk">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-12">
						<label for="jcqk" class="col-sm-12 control-label">103.奖惩情况:</label>
						<div class="col-sm-12 sfradio" id="jcqk" name="jcqk">
						</div>	
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-sm-12">
						<label for="online" class="col-sm-12 control-label">104.是否在线:</label>
						<div class="col-sm-12 sfradio" id="online" name="online">
						</div>	
					</div>
					<div class="clearfix visible-xs-block"></div>
					<div class="col-xs-12 col-sm-12">
						<label for="remark" class="col-sm-12 control-label">105.备注:</label>
						<div class="col-sm-12">
							<textarea id="remark" name="remark" type="text"  maxlength="250" class="form-control" autocomplete="off" placeholder="请输入"></textarea>
						</div>	
					</div>
				</div>
				<input type="submit" value="下一页" />
			</form>	
			</p>
			</div>
			<div class="tab-pane" id="jzrygrjl">
			<p id="grjlp">
				<h4>个 人 简 历：
					<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
				</h4>
				<div class="row" hidden>
					<input type="hidden" name="f_aid" value="<%=jzryjbxxid%>"/>
					<input id="sqjzrybh" name="sqjzrybh" type="text" class="form-control" autocomplete="off">
				</div>
				<div class="panel panel-default">
				    <div class="panel-body">
						<div class="row">
							<div class="col-xs-6 col-sm-6">
								<label for="qs" class="col-sm-3 control-label">起时:</label>
								<div class="col-sm-9">
									<input id="qs" name="qs" type="text" class="form-control form_month" onblur="vld(event)" data-date-format="yyyy-MM" autocomplete="off">
								</div>	
							</div>
							<div class="clearfix visible-xs-block"></div>
							<div class="col-xs-6 col-sm-6">
								<label for="zr" class="col-sm-3 control-label">止日:</label>
								<div class="col-sm-9">
									<input id="zr" name="zr" type="text" class="form-control form_month" onblur="vld(event)" data-date-format="yyyy-MM" autocomplete="off">
								</div>	
							</div>
							<div class="col-xs-6 col-sm-6">
								<label for="szdw" class="col-sm-12 control-label">所在单位（所在地）:</label>
								<div class="col-sm-12">
									<input id="szdw" name="szdw" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
								</div>	
							</div>
							<div class="clearfix visible-xs-block"></div>
							<div class="col-xs-6 col-sm-6">
								<label for="zw" class="col-sm-12 control-label">职务（职业）:</label>
								<div class="col-sm-12">
									<input id="zw" name="zw" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
								</div>	
							</div>
						</div>
				    </div>
				</div>		
				<div style="height:10px"></div>
				<div class="row" hidden>
					<input type="hidden" name="f_aid" value="<%=jzryjbxxid%>"/>
					<input id="sqjzrybh" name="sqjzrybh" type="text" class="form-control" autocomplete="off">
				</div>
				<div class="panel panel-default">
				    <div class="panel-body">
						<div class="row">
							<div class="col-xs-6 col-sm-6">
								<label for="qs" class="col-sm-3 control-label">起时:</label>
								<div class="col-sm-9">
									<input id="qs" name="qs" type="text" class="form-control form_month" onblur="vld(event)" data-date-format="yyyy-MM" autocomplete="off">
								</div>	
							</div>
							<div class="clearfix visible-xs-block"></div>
							<div class="col-xs-6 col-sm-6">
								<label for="zr" class="col-sm-3 control-label">止日:</label>
								<div class="col-sm-9">
									<input id="zr" name="zr" type="text" class="form-control form_month"  onblur="vld(event)" data-date-format="yyyy-MM" autocomplete="off">
								</div>	
							</div>
							<div class="col-xs-6 col-sm-6">
								<label for="szdw" class="col-sm-12 control-label">所在单位（所在地）:</label>
								<div class="col-sm-12">
									<input id="szdw" name="szdw" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
								</div>	
							</div>
							<div class="clearfix visible-xs-block"></div>
							<div class="col-xs-6 col-sm-6">
								<label for="zw" class="col-sm-12 control-label">职务（职业）:</label>
								<div class="col-sm-12">
									<input id="zw" name="zw" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
								</div>	
							</div>
						</div>
				    </div>
				</div>
				<div style="height:10px"></div>	
			</p>
			</div>
			<div class="tab-pane" id="jtcyjshgx">
			<p>
				<h4>家庭成员及主要社会关系：
					<input id="btnAdd" type="button" class="btn btn-default btn-sm" value="新增">
				</h4>
				<div class="row" hidden>
					<input type="hidden" name="f_aid" value="<%=jzryjbxxid%>"/>
					<input id="sqjzrybh" name="sqjzrybh" type="text" class="form-control" autocomplete="off">
				</div>
				<div class="panel panel-default">
			    <div class="panel-body">
					<div class="row">
						<div class="col-xs-6 col-sm-6">
							<label for="gx" class="col-sm-3 control-label">关系:</label>
							<div class="col-sm-9">
								<select id="gx" name="gx" class="form-control" onblur="vld(event)">
									<option value=""></option>
								</select>	
							</div>	
						</div>
						<div class="clearfix visible-xs-block"></div>
						<div class="col-xs-6 col-sm-6">
							<label for="xm" class="col-sm-3 control-label">姓名:</label>
							<div class="col-sm-9">
								<input id="xm" name="xm" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="col-xs-12 col-sm-12">
							<label for="szdw" class="col-sm-3 control-label">所在单位:</label>
							<div class="col-sm-9">
								<input id="szdw" name="szdw" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="clearfix visible-xs-block"></div>
						<div class="col-xs-12 col-sm-12">
							<label for="jtzz" class="col-sm-3 control-label">家庭住址:</label>
							<div class="col-sm-9">
								<input id="jtzz" name="jtzz" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="col-xs-12 col-sm-12">
							<label for="lxdh" class="col-sm-3 control-label">联系电话:</label>
							<div class="col-sm-9">
								<input id="lxdh" name="lxdh" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
					</div>
				</div>
				</div>
				<div style="height:10px"></div>
				<div class="row" hidden>
					<input type="hidden" name="f_aid" value="<%=jzryjbxxid%>"/>
					<input id="sqjzrybh" name="sqjzrybh" type="text" class="form-control" autocomplete="off">
				</div>	
				<div class="panel panel-default">
			    <div class="panel-body">
					<div class="row">
						<div class="col-xs-6 col-sm-6">
							<label for="gx" class="col-sm-3 control-label">关系:</label>
							<div class="col-sm-9">
								<select id="gx" name="gx" class="form-control" onblur="vld(event)">
									<option value=""></option>
								</select>	
							</div>	
						</div>
						<div class="clearfix visible-xs-block"></div>
						<div class="col-xs-6 col-sm-6">
							<label for="xm" class="col-sm-3 control-label">姓名:</label>
							<div class="col-sm-9">
								<input id="xm" name="xm" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="col-xs-12 col-sm-12">
							<label for="szdw" class="col-sm-3 control-label">所在单位:</label>
							<div class="col-sm-9">
								<input id="szdw" name="szdw" type="text" class="form-control" onblur="vld(event)"  autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="clearfix visible-xs-block"></div>
						<div class="col-xs-12 col-sm-12">
							<label for="jtzz" class="col-sm-3 control-label">家庭住址:</label>
							<div class="col-sm-9">
								<input id="jtzz" name="jtzz" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
						<div class="col-xs-12 col-sm-12">
							<label for="lxdh" class="col-sm-3 control-label">联系电话:</label>
							<div class="col-sm-9">
								<input id="lxdh" name="lxdh" type="text" class="form-control" onblur="vld(event)" autocomplete="off" placeholder="请输入">
							</div>	
						</div>
					</div>
				</div>
				</div>
				<div style="height:10px"></div>
			</p>
			</div>
		</div>
		<!-- </form> -->
	</div>
	<script type="text/javascript" src="sqjzryjbxx.js"></script>
</body>
</html>