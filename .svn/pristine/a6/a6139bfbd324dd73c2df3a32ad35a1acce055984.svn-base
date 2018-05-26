<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>基层法律服务管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqJzJcflfwService.js"></script>
<script type="text/javascript">
var regionid;
var list;
$(function(){
	//区域树
	var tree = new Eht.BootTree({selector:"#jcflfw_form #tree",labelField:"region_name"});
	var jcflfw = new SqJzJcflfwService();
	//获取点击的li
	var data = tree.clickItem(function(ds){
		 regionid = ds.parentid;//获取父级id
		 region_code = ds.regionid;//本级id
		$("#regionid").val(regionid);
		$("#region_code").val(region_code);
		if (regionid == $("#regionid").val()) {
			list.loadData(function(page,res){
			jcflfw.findAll({"a.regionid":region_code},page,res);
		});
		}
	});
	tree.loadData(function(res){
		jcflfw.findTree(res);
	});
	//列表
	 var query={};
	 query["jgmc[like]"] = $("#dosearch").val();
	    list = new Eht.TableView({selector:"#jcflfw_form #list"});
	    //列表点击事件
	    list.clickRow(function (data) {
	    	//检索区域id
	    	jcflfw.findParentid(data.region_name,new Eht.Responder({success:function(datas){
	    		regionid = datas[0].parentid;
		    	region_code = datas[0].regionid;
	    	
	    	$("#myModal").modal({
				backdrop : 'static',
				keyboard : false
			});
			$("#modal-body #iframe").attr("src",
					"${localCtx}/module/sqjz/formSqJzJcflfw.jsp?regionid= '"
					+ regionid+ "' &region_code='"+ region_code+ "'&id="+data.id 
					+ "&bzsj="+data.bzsj + "&dh="+data.dh + "&dz="+data.dz + "&fzr="+data.fzr
					+ "&jgmc="+data.jgmc + "&jgzh="+data.jgzh + "&region_name="+data.region_name + "&fzr="+data.fzr+ "&jgjj="+data.jgjj
					+"");
	    	}}));
		});
		list.loadData(function(page,res){
		jcflfw.findAll(query,page,res);
	});
});
//新增
function jcflfwadd() {
	//传值 区域名称
	regionid = $("#regionid").val();
	region_code = $("#region_code").val();
	if (regionid == "") {
		alert("请选择所属区域！再进行添加服务所！");
	}else{
		$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		});
		$("#modal-body #iframe").attr("src",
				"${localCtx}/module/sqjz/formSqJzJcflfw.jsp?regionid= '"
				+ regionid
				+ "' &region_code='"
				+ region_code
				+ "'");
	}
	
};
//查询
function jcflfwsearch() {
	jgmc = $("#dosearch").val();
	var jcflfw = new SqJzJcflfwService();
	 var query={};
	 query["jgmc[like]"] = jgmc;
		list.loadData(function(page,res){
		jcflfw.findAll(query,page,res);
	});
}
</script>
</head>
<body>
<div id="jcflfw_form" class="container-fluid">
	<div class="row">
		<div id="query_id" style="margin-top: 21px; margin-bottom: 12px; margin-left: 31px;">服务所名称：
		<input style="border-radius:3px;border:1px solid #b3b0b0;" id="dosearch" type="text" placeholder="请输入机构名称..."/>
			<div style="float: right;padding-right: 77%;">
			<input type="hidden" id="regionid" value=""> 
			<input type="hidden" id="region_code" value=""> 
			<button id="fat-btn" onclick="jcflfwsearch()"
				style="border-radius:3px;border:1px solid #b3b0b0;margin-right: 10px;">查询</button>
				<button id="fat-btn" onclick="jcflfwadd()"
				style="border-radius:3px;border:1px solid #b3b0b0;margin-right: 10px;">新增</button>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div id="tree"></div>
		</div>
		<div class="col-md-9">
			 <div id="list">
				<!-- <div field="id" label="id" style="display: none;"></div> -->
				<div field="region_name" label="所属区域"></div>
				<div field="jgmc" label="机构名称"></div>
				<div field="jgzh" label="机构证号"></div>
				<div field="zzxs" label="组织形式"></div>
				<div field="bzsj" label="颁证日期"></div>
				<div field="fzr" label="负责人"></div>
				<div field="dh" label="电话"></div>
				<div field="dz" label="地址"></div>
			</div> 
		</div>
	</div>
	<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="height: 52%; width: 660px;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" id="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">新增法律事务所基本管理</h4>
				</div>
				<div class="modal-body" id="modal-body" style="height: 100%;">
					<iframe id="iframe" width="640px" height="418px;" scrolling="no"
						frameborder="0"> </iframe>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>