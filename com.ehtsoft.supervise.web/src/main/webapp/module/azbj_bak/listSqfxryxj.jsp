<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区服刑人员衔接</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjRyxjService.js"></script>
<style>
.right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	display: none;
	box-shadow: 0px 0px 10px #888888;
}

table>tbody>tr.active>td
.control-group>label {
	margin-right: 10px;
}

.control-group div {
	width: 100%;
	height: 300px;
}

.row-fluid #right-panel_div3 {
	margin: 0 0 0 150px;
}
#right-panel_div2 #f_pf {
	display: block;
	float: right;
	font-size: 30px;
	margin: 0 10px 30px 0;
}
.table-bordered>thead>tr>th{
	text-align: center;
}
.table-bordered>tbody>tr>td{
    text-align: center
}
</style>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_listSqfxryxj #querypanel"
		});
		var tableView = new Eht.TableView({
			multable : false,
			selector : "#sqjz_listSqfxryxj #tableView",
			valueCodeField : "f_code",
			labelCodeField : "f_name"
		});
		var service = new AzbjRyxjService();
		tableView.loadData(function(page, res) {
			service.findAllRy(form.getData(), page, res);
		});	
		//查询按钮事件
		$("#sqjz_listSqfxryxj #querybtn").click(function() {
			tableView.refresh();
		})
	});
</script>
</head>
<body>
	<div id="sqjz_listSqfxryxj">
		<div class="panel panel-default">	
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="querypanel"  style="padding-left: 20px;">
					姓名:<input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/> 
					身份证号:<input type="text"name="sfzh[like]" class="btn btn-default" placeholder="请输入身份证号"/> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
				</fieldset>
			</div>
			<div class="panel-body" style="padding:3px 0 0 0;">
				<div id="tableView" class="table-responsive" >
                 <div field="xh" label="序号" checkbox="true"></div>
                 <div field="xm" label="姓名" class="text-center"></div>
                 <div field="sfzh" label="身份证号码"></div>
                 <div field="sqfxsfs" label="社区服刑司法所"></div>
                 <div field="hjdz" label="户籍地址"></div>
                 <div field="xjzt" label="衔接状态"></div>
                 <div field="jjrq" label="解矫日期"></div>
                 <div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>