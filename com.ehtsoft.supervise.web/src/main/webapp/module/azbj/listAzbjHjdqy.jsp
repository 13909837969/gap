<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 叶建楠 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjHjdqyService.js"></script>
<script type="text/javascript" src="${localCtx }/json/RegionService.js"></script>
<title>户籍地迁移信息</title>
<script type="text/javascript">
$(function(){
	/* var query = {}; */
	var service = new AzbjHjdqyService();
	var region = new RegionService();//省市区后台
	var form = new Eht.Form({selector:'#hjdqyForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#tableview'});
	var qf = new Eht.Form({selector:"#divcx",codeEmpty:true,codeEmptyLabel:"全部"});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(qf.getData(), page, res);
	});
	//获取当前选中行的数据	
	form.fill($(":checkbox:checked").data());
	//新增按钮触发事件
	$('#btn_add').click(function(){
		$("#btn_submit").show();
		$("#btn_close").show();
		form.clear();
		$('#myModal').modal({backdrop:'static'});
	});
	/* //初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide(); */
	//点击查询时查模糊查询
	$("#btn_search").click(function(){
		tableview.refresh();
	});
	
	//查看按钮触发事件
	$("#btn_check").click(function(){
		if($(":checkbox:checked").length==1){
			$("#myModal").modal();
			$("#btn_submit").hide();
			$("#btn_close").hide();
			form.disable();
			form.fill($(":checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			
		}
	});
	//修改按钮事件
	$("#btn_update").click(function(){
		if($(":checkbox:checked").length==1){
			form.enable();
			form.clear();
			$("#btn_submit").show();
			$("#btn_close").show();
			$("#myModal").modal();
			form.fill($(":checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
	//删除按钮事件
	$("#btn_delete").click(
			function() {
				var sd_ry = tableview.getSelectedData();
				if (sd_ry.length == 1) {
					if (confirm("确定删除数据")) {
						service.removeOne($(":checkbox:checked").data().id);
						new Eht.Tips().show("删除成功");
						tableview.refresh();
					} else {
						new Eht.Tips().show("删除失败");
					}
				}else{
					var ale = new Eht.Alert();
					ale.show("请选中一条数据进行操作!");
					tableview.refresh();
				}
			});

	//模态框保存并且隐藏
	$('#btn_submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	//模态框查询人员信息事件
	service.findJz(new Eht.Responder({
		success:function(data){
			$("#jzryxx_xm").empty();
			$("#jzryxx_xm").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				if(i==4){
				$("#jzryxx_xm").append("<option value="+data[i].id+"selected>"+data[i].xm + data[i].grlxdh + "</option>");	
				}else{
					$("#jzryxx_xm").append("<option value="+data[i].id+">"+data[i].xm + data[i].grlxdh + "</option>");
				}
			}
			$("#jzryxx_xm").comboSelect();
		}
	}))
	/* 省区联动  */
region.find(1,null,new Eht.Responder({	//省份初始化
success:function(data){
	for (var i = 0; i < data.length; i++) {
	$("#shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
	}
	$("#shengji").change();
}
}));  

$("#shengji").change(function(){	//市初始化
region.find(2,$("#shengji").val(),new Eht.Responder({
	success:function(data){
		$("#shiji").empty();
		for (var i = 0; i < data.length; i++) {
		$("#shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
		}
		$("#shiji").change();
	}
}));
})

$("#shiji").change(function(){	//县初始化
region.find(3,$("#shiji").val(),new Eht.Responder({
	success:function(data){
	$("#xianji").empty();
		for (var i = 0; i < data.length; i++) {
		$("#xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
		}
		$("#xiangji").change();
	}
}));
})

$("#xianji").change(function(){	//乡初始化
region.find(4,$("#xianji").val(),new Eht.Responder({
	success:function(data){
	$("#xiangji").empty();
		for (var i = 0; i < data.length; i++) {
		$("#xiangji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
		}
	}
}));
})
});

</script>
</head>
<body>
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<div class="toolbar">
					<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
					<button type="button" id="btn_check" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
					<button type="button" id="btn_update" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
					<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
					</div></br>
						<div id="divcx">
						姓名：<input type="text" id="btn_exit" name="xm[like]" class="btn btn-default" label="姓名" placeholder="姓名"/>
						时间：<input type="text" id="search_sj" name="sj[like]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd" label="时间" placeholder="时间"> 
						事由：<input type="text" id="search-sy" name="sy[like]" class="btn btn-default" label="事由" placeholder="事由"/>
						状态：<input type="text" id="search-zt" name="zt[like]" class="btn btn-default" label="状态" placeholder="状态"/>
						<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
						</div>
				</fieldset>
		</div>
<!-- 			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div> -->
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field="xzk" label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="sj" label="时间"></div>
					<div field="sy" label="事由"></div>
					<div field="zt" label="状态"></div>
					<div field="shyj" label="审核意见"></div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<!-- <h4 class="modal-title" id="myModalLabel">新增户籍迁移人员信息</h4> -->
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="hjdqyForm">
								<input type="hidden" name="id"> 
								<select id="jzryxx_xm" name="azbjryid" label="姓名" style="max-width:none" valid="{required:true}" placeholder="姓名" >
								</select>
								<select name="qrds" type="text" id="shengji" getdis="true" label="迁入地-省" valid="{required:true}">
									<option value="" selected="selected">---选择省份---</option>
								</select>
								<select name="qrdsq" type="text" id="shiji" getdis="true" label="迁入地-市" valid="{required:true}">
									<option value="" selected="selected">---选择盟市---</option>
								</select>
								<select name="qrdx" type="text" id="xianji" getdis="true" label="迁入地-县" valid="{required:true}">
									<option value="" selected="selected">---选择县---</option>
								</select>
								<input id="qrdxxmph" type="text" name="qrdxxmph"   placeholder="迁入地-乡"  label="迁入地-乡" valid="{required:true}"valid="{required:true}">
								<input id="qrdxxmph" type="text" name="qrdxxmph"   placeholder="迁入地-详细门牌号"  label="迁入地-详细门牌号" valid="{required:true}">
								<input id="sj" type="date" name="sj" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd HH:mm"  placeholder="时间" name="sfsspsj" label="时间">
								<input id="sy" type="text" name="sy"    placeholder="事由"  label="事由" valid="{required:true}">
								<input id="zt" type="text" name="zt"   placeholder="状态"  label="状态">
								<input id="shyj" type="text" name="shyj"   placeholder="审核意见"  label="审核意见">
								<div class="text-right"><span id="count1"  style="color: #3F51B5;margin-right: 40px;"></span></div>								
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
						<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>