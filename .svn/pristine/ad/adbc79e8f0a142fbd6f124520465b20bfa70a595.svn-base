<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所工作人员职务信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SfsGzryzwxxService.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new SfsGzryzwxxService();
	var form = new Eht.Form({selector:'#listRyzwxx #shjzjdForm',autolayout:true});
	var search_form = new Eht.Form({selector:'#listRyzwxx #search_field'});
	var showForm = new Eht.Form({selector:'#listRyzwxx #showForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listRyzwxx #tableview'});
	//查询按钮事件
	$('#listRyzwxx #search').click(function(){
		tableview.refresh();
	});	
	//默认界面展示的数据
	tableview.loadData(function(page,res){
		service.findAll(search_form.getData(),page,res);
	});
	//单击一行获取数据
	tableview.clickRow(function(data){
		json_data = data;
		console.log(data);
	});
	
	 
	//新增按钮事件
	$('#listRyzwxx #add').click(function(){
		form.clear();
		//动态添加人员
		var Jzry_json={};
		$("#myModalLabel").text("新增职务信息");
		$("#listRyzwxx #ryxm").removeAttr("disabled");
		service.findGzry(Jzry_json,new Eht.Responder({
			success:function(data){
				
				$("#listRyzwxx #ryxm").empty();
				$("#listRyzwxx #ryxm").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#listRyzwxx #ryxm").append("<option value="+data[i].id+">"+data[i].xm+"</option>");
				}
				/* $("#listRyzwxx #ryxm").comboSelect(); */
			}
		}));
		$('#listRyzwxx #myModal').modal({backdrop:'static'});
	});
	$("#listRyzwxx #ryxm").change(function(){
		/* $("#listRyzwxx #ryid").val($(this).val()); */
		$("#listRyzwxx #id").val($(this).val());
		service.findRybm($(this).val(),new Eht.Responder({
			success:function(data){
				$("#listRyzwxx #ryid").val(data.rybm);
			}
		}))
		
	})
	
	
	
	//修改按钮事件
	$('#listRyzwxx #edit').click(function(){
		if(json_data.id==null){
			$('#listRyzwxx #close_alert_div').show();
		}else{
			$("#myModalLabel").text("修改信息");
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					form.fill(data);
					$("#listRyzwxx #ryxm").append('<option selected="selected">'+data.xm+'</option>');
					$("#listRyzwxx #ryxm").attr("disabled",true);
					if($("#cclb").val()=="01"){
						$("#xzcf").attr("disabled",true);
						$("#dncf").removeAttr("disabled");
					}else{
						$("#dncf").attr("disabled",true);
						$("#xzcf").removeAttr("disabled");
					}
					$('#listRyzwxx #myModal').modal({backdrop:'static'});
				}
			}));
		}
	});
	//删除按钮事件
	$('#listRyzwxx #delete').click(function(){
		if(json_data.id==null){
			$('#listRyzwxx #close_alert_div').show();
		}else{
			$('#listRyzwxx #delete_alert_div').show();
		}
	});
	//初始提示信息为隐藏状态
	$('#listRyzwxx #close_alert_div').hide();
	$('#listRyzwxx #delete_alert_div').hide();
	
	//提示界面取消按钮事件
	$('#listRyzwxx #no').click(function(){
		$('#listRyzwxx #delete_alert_div').hide();
	});
	//提示界面确定按钮事件
	$('#listRyzwxx #yes').click(function(){
		service.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listRyzwxx #delete_alert_div').hide();
				new Eht.Tips().show();
			}
		}));
	});
	
	$('#listRyzwxx #close_alert').click(function(){
		$('#listRyzwxx #close_alert_div').hide();
	});
	//模态框保存并且隐藏
	$('#listRyzwxx #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listRyzwxx #myModal').modal('hide');
					new Eht.Tips().show();
					tableview.refresh();
				}
			}));
		}
	});
	tableview.transColumn("cz",function(data){
		var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
		button.click(function(){
			
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					showForm.fill(data);
					$("#listRyzwxx #ryxm_s").append('<option selected="selected">'+data.xm+'</option>');
					
					$("#showForm input").each(function(){
						$(this).attr("disabled",true);
					})
					$("#zj").attr("disabled",true);
					$("#zwlx").attr("disabled",true);
					$("#jrqtdzzwqk").attr("disabled",true);
				/* 	$("#cclb_s").attr("disabled",true);
					$("#dncf_s").attr("disabled",true);
					$("#xzcf_s").attr("disabled",true); */
					$('#listRyzwxx #showModal').modal({backdrop:'static'});
					
				}
			}));
			
		})
		return button;
	})
	/* //var yourtime=document.getElementById('begin_time').value;  
	var yourtime='2009-12-10';  
	  console.log(111)
	yourtime = yourtime.replace(/-/g,"/");//替换字符，变成标准格式  
	var d2=new Date();//取今天的日期  
	var d1 = new Date(Date.parse(yourtime));  
	alert(d1);  
	alert(d2);  
	if(d1<d2){  
	  alert("开始大于结束");  
	}   */
	
});
</script>
</head>
<body>
	<div id="listRyzwxx">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入基地名称"/>
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
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="sfzh" label="身份证号码"></div>
					<div field="zwlx" label="职务类型" code="sys217"></div>
					<div field="zj" label="职级" code="sys006"></div>
					<div field="jrqtdzzwqk" label="兼任其他党政职务" code="sys216"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
		<!-- 新增社会矫正基地信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增职务信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:400px">
						<div class="modal-body-div">
							<div id="shjzjdForm">
								<div>
									<input type="hidden" name="ryid" id="id"/>
								</div>
								<select name="xm" label="姓名" id="ryxm" valid="{required:true}"></select>
								<input type="text" id="ryid" name="rybm" label="人员编码" getdis="true"  valid="{required:true}">
								<input type="text" name="zwlx" label="行政职务" getdis="true" code="sys217" valid="{required:true}">
								<input type="text" name="rzkssj" label="任职开始时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" readonly="readonly">
								<input type="text" name="rzjssj" label="任职结束时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" readonly="readonly">
								<input type="text" name="zj" label="职级" code="sys006" getdis="true"  valid="{required:true}">
								<input type="text" name="jrqtdzzwqk" label="兼任其他党政职务情况" code="sys216" valid="{required:true}">
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
		
		<!-- 查看 -->
		<div class="modal fade" id="showModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title">查看信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:400px">
						<div class="modal-body-div">
							<div id="showForm">
								<select name="xm" label="姓名" id="ryxm_s" valid="{required:true}" disabled="disabled"></select>
								<input type="text" id="ryid_s" name="rybm" label="人员编码" getdis="true"  valid="{required:true}"disabled="disabled">
								<input type="text" id="zwlx" name="zwlx" label="行政职务" getdis="true" code="sys217" valid="{required:true}"disabled="disabled">
								<input type="text" name="rzkssj" label="任职开始时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" disabled="disabled">
								<input type="text" name="rzjssj" label="任职结束时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" disabled="disabled">
								<input type="text" id="zj"name="zj" label="职级" code="sys006" getdis="true"  valid="{required:true}"disabled="disabled">
								<input type="text" id="jrqtdzzwqk"name="jrqtdzzwqk" label="兼任其他党政职务情况" code="sys216" valid="{required:true}"disabled="disabled">
							</div>
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