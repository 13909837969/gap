<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--矫正小组</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjzxzService.js"></script>
<style type="text/css">
	#table_modal table{
	border-collapse:collapse;
	width:100%;
}
 #table_modal td{
	text-align:center;
	width:100px;
	font-weight: bold;
}

#table_modal tr{
	height:40px;
}
 
#table_modal .all div{
	width:600px;
	display: inline;
	margin: 10px;
}


</style>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var json={};
	var jzjzxzService = new JzjzxzService();
	var form = new Eht.Form({selector:'#Jzjzxz-form',autolayout:true});
	var form_search = new Eht.Form({selector:'#form_search'});
	var tableview = new Eht.TableView({selector:'#tableview'});
	var jzxz_table=new Eht.TableView({selector:"#jzxz_jbxx"});
	var tbody=new Eht.View({selector:"#table_modal #tbody",fieldname:"field"});
	tableview.loadData(function(page,res){
		jzjzxzService.findJzjzxz(form_search.getData(),page,res);
	});
	tableview.clickRow(function(data){
		$('#close_alert_div').hide();
		json_data=data;
		jzxz_table.loadData(function(page,res){
			jzjzxzService.findXzcy(data.id,page,res);
			
		});
	});
	
	//点击查询
	$('#search').click(function(){
		tableview.refresh();
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	jzxz_table.transColumn("cz",function(data) {
		var	button = new Array($('<button   class="btn btn-default btn-sm "><span class="glyphicon glyphicon-edit"></span>&nbsp;查看</button>'),
			$('<button  class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;编辑</button>'),
			$('<button   class="btn btn-default btn-sm" style="margin-left:10px;"><span class="glyphicon glyphicon-print"></span>&nbsp;删除</button>'));
		button[0].click(function() {
			tbody.fill(data);
			$('#viewModal').modal({backdrop:'static'});
			return false;
		});
		button[1].click(function() {
			
			$("#myModal #myModalLabel").text("修改矫正小组人员信息");
			form.fill(data);
			$('#myModal').modal({backdrop:'static'});
			
			return false;
		});
		button[2].click(function() {
			json=data;
			$('#delete_alert_div').show();
			
			return false;
		});
		return button;
	});
	
	
	$('#add').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			form.clear();
			$("#f_aid").val(json_data.id);
			$('#myModal').modal({backdrop:'static'});
			
		}
	});
	
	$('#no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#yes').click(function(){
		jzjzxzService.deleteOne(json.xzid,new Eht.Responder({
			success:function(){
				jzxz_table.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	
	
	$('#close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#submit').click(function(){
		if(form.validate()){
			console.log(form.getData());
			jzjzxzService.saveJzjzxz(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					
					jzxz_table.refresh();
					
				}
			}));
		}
	});
});
</script>
</head>
<body>
	<div id="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset id="form_search">
					<label>服刑人员姓名：<input type="text" id="seaarch-xm" name="xm[like]"style="width:170px;height:28px;text-align:center;" placeholder="请输入姓名" autocomplete="off"/></label>
					<input type="button" id="search" class="btn btn-default btn-sm" value="查询"/>
					<input type="button" id="add" class="btn btn-default btn-sm" value="新增"/>
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div>
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class=" panel-heading"><center>服刑人员信息</center></div>
						<div class="panel-body" id="tableview">
							<div  class="table-responsive">
								<div field='op' label="选择" checkbox="true"></div>
								<div field="xm" label="姓名"></div>
								<div field="jglx" label="管教类型" code="SYS114"></div>
								<div field="jzlb" label="矫正类型" code="SYS017"></div>
								<div field="grlxdh" label="手机"></div>
							</div>
						</div>
					</div>
				</div>
			<div class="col-md-8">
				<div class="panel panel-default">	
					<div class="panel-heading"><center>矫正小组</center></div>
					<div class="panel-body"  id="yzxx" >
						<div id="jzxz_jbxx" class="table-responsive">
							<div>
								<div field="xm"  	label="服刑人员姓名" code="SYS014"></div>
								<div field="name" 	label="姓名" maxlength="20"></div>
								<div field="xzcylx" label="小组成员类型" code="sys020"></div>
								<div field="xzcylb" label="小组成员类别" code="sys021"></div>
								<div field="zhy" 	label="职业" ></div>
								<div field="lxdh" 	label="联系电话"></div>
								<div field="cz" label="操作"></div>
							</div>		
						</div>		
					</div>	
				</div>	  
			</div>
		</div>
		<!-- 新增和修改矫正小组成员(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增矫正小组成员</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="Jzjzxz-form">
								<input type="hidden" name="f_aid" id="f_aid">
								<input type="text" name="xm" label="姓名" valid="{required:true}"/>
								<input type="text" name="xb" label="性别" code="SYS000"/>
								<input type="text" name="csrq" label="出生日期" class="form_date" readonly="readonly"/>
								<input type="text" name="lxdh" label="联系电话" placeholder="请输入手机" valid="{mobile:true}"/>
								<input type="text" name="zzmm" label="政治面貌" code="sys091">
								<input type="text" name="zy" label="专业" code="sys095">
								<input type="text" name="xzcylx" label="小组成员类型" code="sys020" valid="{required:true}">
								<input type="text" name="xzcylb" label="小组成员类别" code="sys021" valid="{required:true}">
								<input type="text" name="shgzzylzc" label="社会工作专业类职称 " code="sys026">
								<input type="text" name="jtzz" label="家庭住址">
								<input type="text" name="remark" label="备注">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button class="btn btn-primary" type="button" id="submit">提交</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 查看(Modal) -->
		<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="viewModalLabel">查看详情</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div" id="table_modal">
							<table >
								<tbody id="tbody">
									<tr>
										<td>姓名</td>
										<td><div field="xm"></div></td>
										<td>性别</td>
										<td><div field="xb" code="sys000"></div></td>
										<td>出生日期</td>
										<td><div field="csrq"></div></td>
									</tr>
									<tr>
										<td>联系电话</td>
										<td><div field="lxdh"></div></td>
										<td>政治面貌</td>
										<td><div field="zzmm" code="sys091"></div></td>
										<td>专业</td>
										<td><div field="zy" code="sys095"></div></td>
									</tr>
									<tr>
										<td>小组成员类别</td>
										<td><div field="xzcylx" code="sys020"></div></td>
										<td>小组成员类型</td>
										<td><div field="xzcylb" code="sys021"></div></td>
										<td>社会工作专业类职称</td>
										<td><div field="shgzzylzc" code="sys026"></div></td>
									</tr>
									<tr>
										<td>家庭住址</td>
										<td field="jtzz"></td>
										<td>备注</td>
										<td field="remark"></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>