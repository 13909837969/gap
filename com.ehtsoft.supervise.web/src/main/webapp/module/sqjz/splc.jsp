<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>审批流程</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"  src="${localCtx}/json/SqlcService.js"></script>
<script type="text/javascript">
//审批流程 
var list;
var splc = new SqlcService();
$(function() {
	//顶部单选列表
	splc.findDocument(new Eht.Responder({success:function(data){
		if (data.length > 0 ) {
			for (var i = 0; i < data.length; i++) {
				$("#djlx").append('<option  value="'+ data[i].f_id+'">' + data[i].f_name +'</option>');
			}
		}
	}}));
	
	//列表的list
	var query = {},
	 list = new Eht.TableView({selector:"#sqlc_form #list"});
	 list.loadData(function(page,res){
		 splc.findAll(query,page,res);
	 });

});
/* 检索功能 */
function search() {
	var djlx = $("#djlx option:selected").val();
	if (djlx == '' || djlx == undefined) {
		alert("请选择您要检索的单据类型！");
	}else{
		var query = {};
		query["djlx"]= djlx;
		 list.loadData(function(page,res){
			 splc.findAll(query,page,res);
		 });
	}
}

function add() {
	alert("打开");
	$("#myModal").modal({
		backdrop : 'static',
		keyboard : false
	});
	$("#modal-body #iframe").attr("src",
			"${localCtx}/module/sqjz/fromsplc.jsp");/* ?regionid= '"
			+ regionid
			+ "' &region_code='"
			+ region_code
			+ "' */
}
</script>
</head>
<body>
<div id="sqlc_form" class="container-fluid">
	<div class="row">
		<div class="col-md-4">
			<div class="row">
				<div class="col-md-12">单据类型 
					<span>&nbsp;&nbsp;</span>
					<select id="djlx" style="border-radius: 5px;height: 24px;margin-right: 12px;">
						<option value="">请选择</option>
					</select>
					<button type="button" onclick="search()" value="查询" style="border-radius: 5px;height: 24px;margin-right: 12px;">查询</button>
					<button type="button" onclick="add()" value="新增流程" style="border-radius: 5px;height: 24px;">新增流程</button>
				</div>
			</div>
		</div>	
	</div>
	<div style="height: 13px;"></div>
	<div class="row">
		<div class="col-md-12">
			 <div id="list">
				<div field="f_id" label="编码类型"></div>
				<div field="f_name" label="单据类型"></div>
				<div field="xm" label="审批人"></div>
				<div field="f_lvl" label="审批级别"></div>
				<div field="f_teamname" label="协同工作组"></div>
				<div field="xm" label="组员"></div>
				<div field="dh" label="操作"></div>
			</div> 
		</div>
	</div>
	<!-- 模态框 -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="height: 82%; width: 50%;margin-top: 3%;">
			<div class="modal-content" style="height: 100%">
				<div class="modal-header">
					<button type="button" class="close" id="close" data-dismiss="modal"
						aria-hidden="false">x</button>
					<h4 class="modal-title" id="myModalLabel">新增审批流程</h4>
				</div>
				<div class="modal-body" id="modal-body" style="height: 100%;">
				<iframe id="iframe" width="100%" height="90%" scrolling="no"
						frameborder="0"> </iframe>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>