<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>装备资产及机关事务-车辆牌照管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	//初始界面
	var tableView=new Eht.TableView({selector:"#clpzglBody #tableview"});
	//初始表单
	var form = new Eht.Form({selector:"#clpzglBody #cpxxForm",autolayout:true});
	//查询按钮事件
	$("#clpzglBody #search").click(function(){
		$('#clpzglBody #myModal').modal({backdrop:'static'});
	});
	//新增按钮事件
	$("#clpzglBody #add").click(function(){
		$('#clpzglBody #myModal').modal({backdrop:'static'});
	});
	//修改按钮事件
	$("#clpzglBody #edit").click(function(){
		$('#clpzglBody #myModal').modal({backdrop:'static'});
	});
	//删除按钮事件
	var json = {};
	$("#clpzglBody #delete").click(function(){
		if(json.id==null){
			$("#clpzglBody #close_alert_div").show();
		}
	});
	$("#clpzglBody #close_alert").click(function(){
		$("#clpzglBody #close_alert_div").hide();
	})
})
</script>
</head>
<body>
	<div id="clpzglBody">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset id="fieldset">
					<input type="text" id="search-cphm" class="btn btn-default" placeholder="请输入车牌号码"/>
					<!-- <input type="text" id="search-ms" class="btn btn-default" placeholder="请输入车牌描述"/> -->
					<input type="text" id="search-lx" class="btn btn-default" placeholder="请输入车牌类型"/>
					<input type="text" id="search-ssdw" class="btn btn-default" placeholder="请输入所属单位"/>
					从:<input type="text" id="search-ks" class="btn btn-default" placeholder="上牌时间" class="form_date" data-date-formate="yyyy-MM-dd"/>
					到:<input type="text" id="search-js" class="btn btn-default" placeholder="上牌时间" class="form_date" data-date-formate="yyyy-MM-dd"/>
					<input type="button" id="search" class="btn btn-default" value="查询"/>
					<input type="button" id="add" class="btn btn-default" value="新增"/>
					<input type="button" id="edit" class="btn btn-default" value="修改"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
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
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="" checkbox="true"></div>
					<div field="cz" label="操作"></div>
					<div field="cphm" label="车牌号码"></div>
					<div field="cpms" label="车牌描述"></div>
					<div field="cpss" label="车配所属"></div>
					<div field="cplx" label="车牌类型"></div>
					<div field="spsj" label="上牌时间"></div>
					<div field="spr" label="上牌人"></div>
					<div field="sfsy" label="是否使用"></div>
				</div>
			</div>
		</div>
		<!-- 新增车牌信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增车牌信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="cpxxForm">
								<div>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" name="cphm" label="车牌号码" getdis="true"  valid="{required:true}" />
								<input type="text" name="cplx" label="车牌类型" getdis="true" valid="{required:true}"  />
								<input type="text" name="spr" label="上牌人" getdis="true"  valid="{required:true}"/>
								<input type="text" name="cpss" label="车牌所属" getdis="true" valid="{required:true}"/>
								<input type="text" name="spsj" label="上牌时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd"/>
								<texta type="text" name="spms" label="上牌描述" rows="8"></texta>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="submit" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>