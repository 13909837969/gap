<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>考核管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/KhglService.js"></script>
<script type="text/javascript">
var f_aids;
$(function () {
	var khgl = new KhglService();
	var list;
	var f_aid;
	//列表
		var query={};
	 	query["xm"] = $("#search_name").val();
	 	query["sfzh"] = $("#search_sfzh").val();
	    list = new Eht.TableView({selector:"#khgl_from #list"});
	    //列表点击事件
	    list.clickRow(function (data) {
	    	$("#jfjl").html('');
	    	f_aid = data.id;
	    	f_aids = f_aid;
	    	kfjv(f_aid);
		});
		list.loadData(function(page,res){
			khgl.findAssessmentManage(query,page,res);
		});
		
	/* 检索 */
	$("#khgl_search").click(function () {
		query["xm"] = $("#search_name").val();
	 	query["sfzh"] = $("#search_sfzh").val();
	 	list.loadData(function(page,res){
			khgl.findAssessmentManage(query,page,res);
		});
	});
	
	/* 提交数据 */
	$("#submit_sj").click(function() {
		//扣分 KFFS  考核内容 KHXM  描述 KHMSQK  矫正人 F_AID
		var datas = {
				"f_aid":f_aid,
				"khxm":$("#khnr").val(),
				"kffs":$("#khkf").val(),
				"khmsqk":$("#sfqk").val()
		};
		khgl.insert(datas,new Eht.Responder({success:function(data){
			/* 绘制回显的减分想 */
			$("#khnr").val('');
			$("#khkf").val('');
			$("#sfqk").val('');
			$("#jfjl").html('');
			f_aid = data[0].f_aid;
			kfjv(f_aid);
		}}));
	});
	/* 关闭模态框并刷新数据  */
	$('#myModal').on('hidden.bs.modal', function (e) {
		$("#jfjl").html('');
		list.refresh();
		});
	
	
	
	/* 绘制减分记录 */
	function kfjv(f_aid) {
    	query["id"] = f_aid;
    	khgl.findDetails(query,{"paginate":""},new Eht.Responder({success:function(datas){
    	$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		});
    	/* 绘制回显的减分记录 */
    	if (datas.rows.length > 0) {
			for (var i = 0; i < datas.rows.length; i++) {
				if (datas.rows[i].f_aid == f_aid) {
					$("#jfjl").append(
							'<div class="col-md-2" style="margin: 4px;background-color: #999;color: #333;width: 100%;">'+
								'<div>'+
									'<div>'+
										'<span>-'+datas.rows[i].kffs+'分</span>'+
									'</div>'+
								'</div>'+
								'<div class="col-md-9" >'+
									'<div calss="row">'+
										'<div class="col-md-8">'+datas.rows[i].khxm+'</div>'+
										'<div class="col-md-4">'+datas.rows[i].cts+'</div>'+
									'</div>'+
									'<div calss="row">'+
										'<div class="col-md-8">'+datas.rows[i].khmsqk+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="col-md-1"><input type="button" value="删除" onclick="kfjvsc('+"'"+datas.rows[i].id+"'"+')"></div>'+
							'</div>'
							);
				}
				
			}
		}
    	}}));
	}
});

/* 删除 *//* 后期可进行优化 */
function kfjvsc(id) {
	var khgl = new KhglService();
	khgl.remove({"id":id},new Eht.Responder({success:function(datas){
		var query = {};
    	query["id"] = f_aids;
    	khgl.findDetails(query,{"paginate":""},new Eht.Responder({success:function(datas){
    	$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		});
    	/* 绘制回显的减分记录 */
    	if (datas.rows.length > 0) {
    		$("#jfjl").html('');
			for (var i = 0; i < datas.rows.length; i++) {
				if (datas.rows[i].f_aid == f_aids) {
					$("#jfjl").append(
							'<div class="col-md-2" style="margin: 4px;background-color: #999;color: #333;width: 100%;">'+
								'<div>'+
									'<div>'+
										'<span>-'+datas.rows[i].kffs+'分</span>'+
									'</div>'+
								'</div>'+
								'<div class="col-md-9" >'+
									'<div calss="row">'+
										'<div class="col-md-8">'+datas.rows[i].khxm+'</div>'+
										'<div class="col-md-4">'+datas.rows[i].cts+'</div>'+
									'</div>'+
									'<div calss="row">'+
										'<div class="col-md-8">'+datas.rows[i].khmsqk+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="col-md-1"><input type="button" value="删除" onclick="kfjvsc('+"'"+datas.rows[i].id+"'"+')"></div>'+
							'</div>'
							);
				}
				
			}
		}else{
			$("#jfjl").html('');
		}
    	}}));
	}}));
}
</script>
</head>
<body>
	<div id="khgl_from" class="container-fluid">
		<div class="row" style="margin-top: 1%;margin-bottom: 1%;">
			<div class="col-md-2">
				<div><sapn>姓名</sapn><sapn>&nbsp;&nbsp;</sapn><input type="text" id="search_name" value="" style="border-radius:3px;border:1px solid #b3b0b0;" placeholder="请输姓名..."></div>
			</div>
			<div class="col-md-3">
				<div>
					<sapn>身份证号</sapn><sapn>&nbsp;&nbsp;</sapn><input type="text" id="search_sfzh" value="" style="border-radius:3px;border:1px solid #b3b0b0;" placeholder="请输身份证号...">
					<sapn>&nbsp;&nbsp;</sapn>
					<input type="button" id="khgl_search" value="查询" style="border-radius:3px;border:1px solid #b3b0b0;">
				</div>
			</div>
		</div>
		<div class="row">
			 <div id="list">
				<div field="sqjzrybh" label="矫正编号"></div>
				<div field="xm" label="姓名"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="result" label="分数"></div>
			</div> 
		</div>
		<!-- 模态框 -->
		<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="height: 60%; width: 660px;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" id="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">考核内容详细情况</h4>
				</div>
				<div class="modal-body" id="modal-body" style="height: 100%;">
					<div class="row" style="margin-bottom: 2%;">
						<div class="col-md-6">考核内容<span>&nbsp;&nbsp;</span> <input placeholder="请输考核内容..." type="text" id="khnr" style="border-radius:3px;border:1px solid #b3b0b0;"></div>
						<div class="col-md-6">扣分<span>&nbsp;&nbsp;</span> <input  placeholder="请输扣除分数..." type="text" id="khkf" style="border-radius:3px;border:1px solid #b3b0b0;"></div>
					</div>
					<div class="row">
						<div class="col-md-3">描述情况 <span>&nbsp;&nbsp;</span></div>
						<div class="col-md-9" style="margin-left: -14.8%;"><textarea placeholder="请输描述情况..." id="sfqk" rows="12" cols="64"></textarea></div>
					</div>
					<div class="row" style="margin-bottom: 2%;">
						<div class="col-md-12" style="margin-top: 2%;margin-left: 69.8%;"><input type="button" value="提交数据" id="submit_sj"></div>
					</div>
					
					<!-- 显示减分记录   -->
					<div calss="row"  id="jfjl" style="background-color: #eee; height: 150px; overflow-y: auto; overflow-x:hidden;">
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>