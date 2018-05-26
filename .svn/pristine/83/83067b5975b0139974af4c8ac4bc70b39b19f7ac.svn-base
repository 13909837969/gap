<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所工作人员受惩处情况</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SfsGzrysccService.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new SfsGzrysccService();
	var form = new Eht.Form({selector:'#listRysccqk #pxqkForm',autolayout:true});
	var showForm = new Eht.Form({selector:'#listRysccqk #showForm',autolayout:true});
	var search_form = new Eht.Form({selector:'#listRysccqk #search_field'});
	
	var tableview = new Eht.TableView({selector:'#listRysccqk #tableview'});
	//查询按钮事件
	$('#listRysccqk #search').click(function(){
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
	$('#listRysccqk #add').click(function(){
		form.clear();
		//动态添加人员
		var Jzry_json={};
		$("#myModalLabel").text("新增惩处信息");
		$("#listRysccqk #ryxm").removeAttr("disabled");
		service.findGzry(Jzry_json,new Eht.Responder({
			success:function(data){
				
				$("#listRysccqk #ryxm").empty();
				$("#listRysccqk #ryxm").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#listRysccqk #ryxm").append("<option value="+data[i].id+">"+data[i].xm+"</option>");
				}
				/* $("#listRysccqk #ryxm").comboSelect(); */
			}
		}));
		$('#listRysccqk #myModal').modal({backdrop:'static'});
	});
	$("#listRysccqk #ryxm").change(function(){
		/* $("#listRysccqk #ryid").val($(this).val()); */
		$("#listRysccqk #id").val($(this).val());
		service.findRybm($(this).val(),new Eht.Responder({
			success:function(data){
				$("#listRysccqk #ryid").val(data.rybm);
			}
		}))
		
	})
	
	
	
	//修改按钮事件
	$('#listRysccqk #edit').click(function(){
		if(json_data.id==null){
			$('#listRysccqk #close_alert_div').show();
		}else{
			$("#myModalLabel").text("修改信息");
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					form.fill(data);
					$("#listRysccqk #ryxm").append('<option selected="selected">'+data.xm+'</option>');
					$("#listRysccqk #ryxm").attr("disabled",true);
					if($("#cclb").val()=="01"){
						$("#xzcf").attr("disabled",true);
						$("#dncf").removeAttr("disabled");
					}else{
						$("#dncf").attr("disabled",true);
						$("#xzcf").removeAttr("disabled");
					}
					$('#listRysccqk #myModal').modal({backdrop:'static'});
					
				}
			}));
		}
	});
	//删除按钮事件
	$('#listRysccqk #delete').click(function(){
		if(json_data.id==null){
			$('#listRysccqk #close_alert_div').show();
		}else{
			$('#listRysccqk #delete_alert_div').show();
		}
	});
	//初始提示信息为隐藏状态
	$('#listRysccqk #close_alert_div').hide();
	$('#listRysccqk #delete_alert_div').hide();
	
	//提示界面取消按钮事件
	$('#listRysccqk #no').click(function(){
		$('#listRysccqk #delete_alert_div').hide();
	});
	//提示界面确定按钮事件
	$('#listRysccqk #yes').click(function(){
		service.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listRysccqk #delete_alert_div').hide();
				new Eht.Tips().show();
			}
		}));
	});
	tableview.transColumn("cz",function(data){
		var button=$('<button  class="btn btn-default btn-sm "><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
		button.click(function(){
			
			service.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					showForm.fill(data);
					$("#listRysccqk #ryxm_s").append('<option selected="selected">'+data.xm+'</option>');
					
					$("#showForm input").each(function(){
						$(this).attr("disabled",true);
					})
					$("#cclb_s").attr("disabled",true);
					$("#dncf_s").attr("disabled",true);
					$("#xzcf_s").attr("disabled",true);
					$('#listRysccqk #showModal').modal({backdrop:'static'});
					
				}
			}));
			
		})
		return button;
	})
	$('#listRysccqk #close_alert').click(function(){
		$('#listRysccqk #close_alert_div').hide();
	});
	//模态框保存并且隐藏
	$('#listRysccqk #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#listRysccqk #myModal').modal('hide');
					new Eht.Tips().show();
					tableview.refresh();
				}
			}));
		}
	});
	
	$("#cclb").change(function(){
		$("#xzcf").val("");
		$("#dncf").val("");
		if($(this).val()=="01"){
			$("#xzcf").attr("disabled",true);
			$("#dncf").removeAttr("disabled");
		}else{
			$("#dncf").attr("disabled",true);
			$("#xzcf").removeAttr("disabled");
		}
	})
	form.charValid(function(name,min,max){
		if(name=="cjnr"){
			$("#count").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count").css("color","#f00");
			}else{
				$("#count").css("color","#00f");
			}
		}
	})
	
	
});
</script>
</head>
<body>
	<div id="listRysccqk">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar">
				<fieldset id="search_field">
					<input type="text" id="search-xm" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/>
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
					<div field="cjmc" label="惩处名称" ></div>
					<div field="cclb" label="惩处类别" code="sys213"></div>
					<div field="cjsj" label="惩处时间"></div>
					<div field="cjqx" label="惩处期限"></div>
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
						<h4 class="modal-title" id="myModalLabel">新增惩处信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:400px">
						<div class="modal-body-div">
							<div id="pxqkForm">
								<div>
									<input type="hidden" name="ryid" id="id"/>
								</div>
								<select name="xm" label="姓名" id="ryxm" ></select>
								<input type="text" id="ryid" name="rybm" label="人员编码"  valid="{required:true}"readonly="readonly"/>
								<input type="text" name="cjmc" label="惩处名称" getdis="true"  valid="{required:true}"/>
								<input id="cclb" type="text" name="cclb" label="惩处类别" getdis="true"  valid="{required:true}" code="sys213" />
								<input id="dncf"type="text" name="dncf" label="党内处分" getdis="true"  valid="{required:true}" code="sys214" disabled="disabled"/>
								<input id="xzcf" type="text" name="xzcf" label="行政处分" getdis="true"  valid="{required:true}" code="sys215" disabled="disabled">
								<input type="text" name="cjsj" label="惩处时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" readonly="readonly">
								<input type="text" name="cjqx" label="惩处期限" getdis="true"  valid="{required:true}" >
								<textarea rows="5" name="cjnr" label="惩处内容" getdis="true" maxlength="300" valid="{required:true}" style="resize: none;"></textarea>
								<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
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
								<div>
									<input type="hidden" name="ryid_s" id="id"/>
								</div>
								<select name="xm" label="姓名" id="ryxm_s" disabled="disabled"></select>
								<input type="text" id="ryid_s" name="rybm" label="人员编码"  valid="{required:true}"readonly="readonly"/>
								<input type="text" name="cjmc" label="惩处名称" getdis="true"  valid="{required:true}"/>
								<input id="cclb_s" type="text" name="cclb" label="惩处类别" getdis="true"  valid="{required:true}" code="sys213" />
								<input id="dncf_s"type="text" name="dncf" label="党内处分" getdis="true"  valid="{required:true}" code="sys214" disabled="disabled"/>
								<input id="xzcf_s" type="text" name="xzcf" label="行政处分" getdis="true"  valid="{required:true}" code="sys215" disabled="disabled">
								<input type="text" name="cjsj" label="惩处时间" getdis="true"  valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" readonly="readonly">
								<input type="text" name="cjqx" label="惩处期限" getdis="true"  valid="{required:true}" >
								<textarea rows="5" name="cjnr" label="惩处内容" getdis="true" maxlength="300" valid="{required:true}" style="resize: none;" disabled="disabled"></textarea>
								<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
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