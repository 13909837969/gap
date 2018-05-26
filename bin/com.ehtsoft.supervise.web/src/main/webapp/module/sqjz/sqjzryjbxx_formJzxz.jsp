<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 孙海龙 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--矫正小组</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JzjzxzService.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	var jzjzxzService = new JzjzxzService();
	var form = new Eht.Form({selector:'#sqjzryjbxx_formJzxz #jzryJzxz-form',autolayout:true,formCol:2});
	var tableview = new Eht.TableView({selector:'#sqjzryjbxx_formJzxz #tableview',paginate:null});
	tableview.loadData(function(page,res){
		jzjzxzService.findXzcy(query.f_aid,page,res);
	});
	tableview.clickRow(function(data){
		json_data = data;
		form.fill(json_data);
	});
	//初始提示信息为隐藏状态
	$('#sqjzryjbxx_formJzxz #close_alert_div').hide();
	$('#sqjzryjbxx_formJzxz #delete_alert_div').hide();
	
	$('#sqjzryjbxx_formJzxz #edit').click(function(){
		form.clear();
	});
	$('#sqjzryjbxx_formJzxz #delete').click(function(){
		if(json_data.xzid==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#sqjzryjbxx_formJzxz #no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#sqjzryjbxx_formJzxz #yes').click(function(){
		jzjzxzService.deleteOne({'xzid':json_data.xzid},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
				form.clear();
				new Eht.Tips().show();
			}
		}));
	});
	$('#sqjzryjbxx_formJzxz #close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	$('#sqjzryjbxx_formJzxz #save').click(function(){
		if(form.validate()){
			jzjzxzService.saveJzjzxz(form.getData(),new Eht.Responder({
				success:function(data){
					tableview.refresh();
					form.clear();
					new Eht.Tips().show();
				}
			}));
		}
	});
});
</script>
</head>
<body>
<div class="panel panel-default" id="sqjzryjbxx_formJzxz">
		<div class="panel-heading">
			<div class="panel-heading">
				<fieldset>
					<input type="button" id="edit" class="btn btn-default" value="新增"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
					<input type="button" id="save" class="btn btn-default" value="保存"/>
				</fieldset>
			</div>
		</div>
		<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
			<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
		</div>
		<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 确定删除？
			<input id="yes" class="btn btn-default" type="button" value="确定" />
			<input id="no" class="btn btn-default" type="button" value="取消" />
		</div>	
		
		<div class="panel-body" >
			<div id="jzryJzxz-form">
				<div>
					<input type="hidden" value="${param.id}" fixedValue="true" name="f_aid"/>
					<input type="hidden" name="id"/>
				</div>
				<input type="text" name="xzcylx" label="成员类型" placeholder="请输入成员类型" valid="{required:true}" code="SYS020"/>
				<input type="text" name="xzcylb" label="成员类别" placeholder="请输入成员类别" valid="{required:true}" code="SYS021"/>
				<input type="text" name="xm" label="姓名" placeholder="请输入姓名" valid="{required:true}"/>
				<input type="text" name="xb" label="性别" placeholder="请选择性别" valid="{required:true}" code="SYS000"/>
				<input type="text" name="sfzh" label="身份证号" placeholder="请输入身份证号" valid="{required:true,cardNo:true}" />
				<input type="text" name="csrq" label="出身日期" placeholder="请输入出身日期" class="form_date" data-date-formate="yyyy-MM-dd" />
				<input type="text" name="sj" label="手机" placeholder="请输入手机" valid="{required:true,mobile:true}"/>
			</div>
		</div>
		<div class="panel-heading">
			<div id="tableview" class="table-responsive">
				<div field='op' label="选择" checkbox="true"></div>
				<div field="xm" label="姓名" code="sys000"></div>
				<div field="xb" label="性别" ></div>
				<div field="xzcylx" label="成员类型" ></div>
				<div field="xzcylb" label="成员类别"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="csrq" label="出身日期"></div>
				<div field="sj" label="手机"></div>
			</div>
		</div>
	</div>
</body>
</html>