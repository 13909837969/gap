<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${localCtx}/json/FxpgService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JbxxService.js"></script>
<title>风险评估</title>
<style type="text/css">
#pgxx table{
	border-collapse:collapse;
	width:100%;
}
 #pgxx td{
	text-align:center;
	width:100px;
	font-weight: bold;
}

#pgxx tr{
	height:20px;
}




</style>
<script type="text/javascript">
	$(function(){
		var service=new FxpgService();
		var tableView = new Eht.TableView({selector:"#listzlpg_tableView"});
		var form=new Eht.Form({selector:"zlpg_fieldset"});
		var form_table=new Eht.Form({selector:"#pgxx"});
	
		/* 初始化加载数据 */
		tableView.loadData(function(page,res){
			service.findAll(form.getData(),page,res);
		});
		
		/* 单击查询按钮触发事件 */
		$("#zlpg_fieldset #btnSelect").click(function(){
			tableView.refresh();//再执行上次方法
		});

		/* ******************当单击某条数据时，将数据放入json内，以备点击【修改】按钮时调取数据*************************** */
		var json={}
		tableView.clickRow(function(data){
			json=data;
			
		});
		
		tableView.transColumn("cz",function(data){
			
			var	button = new Array($('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-edit"></span>&nbsp;评估</button>'),
					$('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;查看</button>'));
				button[0].unbind("click").bind("click",function(){//委托书id
					var jbxxService=new JbxxService();
					var jzryjbxx=new Eht.Form({selector:"#jzryjbxx"});
					$('#myModal_zlpg').modal({backdrop:'static',keyboard: false});
					$("#myModal_zlpg #iframe").attr("src","${localCtx}/module/sqjz/form_jbxx.jsp?load=load");
					
					jbxxService.findJbxx(data.id,new Eht.Responder({//根据ID查询个人基本信息
						success:function(data){
							debugger;
							jzryjbxx.fill(data);
							
						}
				 	}));  
				 	
					return false;
				})
				return button;
			
		});
		
		
		////////////////////////////////////////////////
		
		
	});
</script>
</head>
<body>
	<div class="panel panel-default" id="Sqjz_bddj">
		<div class="panel-heading">
			<fieldset id="zlpg_fieldset" style="margin-top:10px;">
				<label>姓名：<input type="text" id="search-xm" name="xm[like]" style="width:170px;height:28px;text-align:center;" placeholder="请输入姓名" autocomplete="off"/></label>
				<label>矫正起止：<input type="text" id="search_ks" name="sqjzksrq" class="form_date" style="width:170px;height:28px;text-align:center;"readonly="readonly"/>至
					<input type="text" id="search_js" name="sqjzjsrq" class="form_date" style="width:170px;height:28px;text-align:center;"readonly="readonly"/>
				</label>
				<input  id="btnSelect" type="button" class="btn btn-default btn-sm" value="查询">
			</fieldset>
		</div>
		<div class="panel-body" id="listzlpg_tableView" style="text-align:center;">
			<div field="op" checkbox=true label="选择"></div>
			<div field="xm" label="姓名"></div>
			<div field="xb" label="性别" code="sys000"></div>
			<div field="ypxf" label="原判刑罚" code="sys012"></div>
			<div field="jzlb" label="矫正类别" code="sys017"></div>
			<div field="sqjzryjsrq" label="接收日期"></div>
			<div field="pgzt" label="评估状态"></div>
			<div field="cz" label="操作"></div>
		</div>
		
		<!-- 模态框 -->
		<div class="modal fade" id="myModal_zlpg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg" >
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false">
							&times;
						</button>
						<h4 class="modal-title">社区矫正质量效果阶段评估</h4>
					</div>
					<div class="modal-body" id="model_jbxx" style="overflow: hidden;">
						<iframe id="iframe" width="100%" height="175px" scrolling="no" frameborder="0">
						</iframe>
						<div class="modal-header">
							<h4 class="modal-title">社区服刑人员评估项</h4>
						</div>
						<div id="pgxx">
							<table border="1" cellspacing="0" id="table_view" align="center">
								<tr>
									<td>管理等级(20分)</td>
									<td>管理等级</td>
									<td><input radio="true" name="gldj" code="sys114">
								</tr>
								<tr>
									<td rowspan="6">个体因素(24分)</td>
									<td>住房条件(3分)</td>
									<td><input radio="true" code="sys061">
								</tr>
								<tr>
									<td>生活来源(5分)</td>
									<td><input radio="true" code="sys062"></td>
								</tr>
								<tr>
									<td>就业能力(3分)</td>
									<td><input radio="true" code="sys063"></td>
								</tr>
								<tr>
									<td>自控能力(3分)</td>
									<td><input radio="true" code="sys064"></td>
								</tr>
								<tr>
									<td>认罪伏法态度(5分)</td>
									<td><input radio="true" code="sys078"></td>
								</tr>
								<tr>
									<td>对社会的心态(5分)</td>
									<td><input radio="true" code="sys079"></td>
								</tr>
								<tr>
									<td rowspan="4">社会因素(16分)</td>
									<td>婚姻家庭关系(4分)</td>
									<td><input radio="true" code="sys065">
								</tr>
								<tr>
									<td>家庭成员配合矫正情况(4分)</td>
									<td><input radio="true" code="sys066"></td>
								</tr>
								<tr>
									<td>交友状况(4分)</td>
									<td><input radio="true" code="sys067"></td>
								</tr>
								<tr>
									<td>社会邻里关系(4分)</td>
									<td><input radio="true" code="sys068"></td>
								</tr>
								<tr>
									<td rowspan="8">矫正表现(40分)</td>
									<td>对社区矫正的认识和接受程度(4分)</td>
									<td><input radio="true" code="sys069"></td>
								</tr>
								<tr>
									<td>服从日常管理及遵纪守法情况(6分)</td>
									<td><input radio="true" code="sys070"></td>
								</tr>
								<tr>
									<td>接受教育情况(5分)</td>
									<td><input radio="true" code="sys071"></td>
								</tr>
								<tr>
									<td>遵守请销假制度情况(6分)</td>
									<td><input radio="true" code="sys072"></td>
								</tr>
								<tr>
									<td>完成社区服务情况(3分)</td>
									<td><input radio="true" code="sys073"></td>
								</tr>
								<tr>
									<td>思想汇报及沟通(3分)</td>
									<td><input radio="true" code="sys074"></td>
								</tr>
								<tr>
									<td>参加就业技能培训(3分)</td>
									<td><input radio="true" code="sys075"></td>
								</tr>
								<tr>
									<td>矫正奖惩情况(10分)</td>
									<td><input radio="true" code="sys076"></td>
								</tr>
							</table>
						</div>
					</div>	
					<div class="modal-footer">
						<button id="register" type="button" class="btn btn-default">登记</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>