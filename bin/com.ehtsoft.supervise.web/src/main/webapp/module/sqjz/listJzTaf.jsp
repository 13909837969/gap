<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 何向昕 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>矫正--同案犯</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/JZTAFService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-typeahead.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	var jztafService = new JZTAFService();
	var form = new Eht.Form({selector:'#JzTaf-Form',autolayout:true});
	var tableview = new Eht.TableView({selector:'#tableview',paginate:null});
	tableview.clickRow(function(data){
		json_data = data;
	});
	$('#add').click(function(){
		form.clear("xb");
		changeInput(false);
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#close_alert_div').hide();
	$('#delete_alert_div').hide();
	$('#search').click(function(){
		query.xm = $('#search-xm').val();
		tableview.loadData(function(page,res){
			jztafService.findTaf(query,res);
		});
	});	
	$('#edit').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			jztafService.findOne({'id':json_data.id},new Eht.Responder({
				success:function(data){
					if(data.sfczda==1){
						changeInput(true);
					}
					form.fill(data);
					$('#myModal').modal({backdrop:'static'});
				}
			}));
		}
	});
	$('#delete').click(function(){
		if(json_data.id==null){
			$('#close_alert_div').show();
		}else{
			$('#delete_alert_div').show();
		}
	});
	$('#no').click(function(){
		$('#delete_alert_div').hide();
	});
	$('#yes').click(function(){
		jztafService.deleteOne({'id':json_data.id},new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#delete_alert_div').hide();
			}
		}));
	});
	
	$('#close_alert').click(function(){
		$('#close_alert_div').hide();
	});
	tableview.loadData(function(page,res){
		jztafService.findTaf(query,res);
	});
	form.change(function(name){
		if(name=="xm"){
			$("input[name='id']").val("");
			changeInput(false);
			$('#xm').typeahead({
				source:function(query,process){
					query = query.trim();
					jztafService.findTafBasic({"xm[like]":query},new Eht.Responder({
						success:function(data){
							process(data);
						}
					}));
				},
				updater:function(item){
					return item;
				},
				displayText:function(item){
					return item.xm;
				},
				matcher:function(item){
	            	return item.xm;
	            },
				afterSelect: function (item) {
					for(var p in item){
						form.setValue(p,item[p]);
					}
					form.clearValidStyle();
					changeInput(true);
					return item.xm;
				},
				items: 10, //显示10条
				delay: 500 //延迟时间
			});
		}
	});
	//模态框保存并且隐藏
	$('#submit').click(function(){
		if(form.validate()){
			jztafService.saveTaf(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	
	function changeInput(ifboolean){
		$('#JzTaf-Form').find("input[name='csrq'],select[name='xb'],input[name='zm'],input[name='xq'],input[name='jtzz']").each(function(){
			$(this).attr('disabled',ifboolean);
		});
	}
});
</script>
</head>
<body>
	<div id="body">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入姓名"/>
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
					<div field="csrq" label="出生日期"></div>
					<div field="zm" label="罪名"></div>
					<div field="xq" label="刑期"></div>
					<div field="jtzz" label="家庭住址"></div>
					<div field="bpcxzjszjs" label="服刑地点"></div>
				</div>
			</div>
		</div>
		<!-- 新增同案犯信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增同案犯信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="JzTaf-Form">
								<div>
									<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" id="xm" autoComplete="off"  name="xm" label="姓名" placeholder="请输入姓名" valid="{required:true}"/>
								<input type="text" name="xb" label="性别" getdis="true" placeholder="请选择性别" valid="{required:true}" code="sys000" />
								<input type="text" name="csrq" label="出生日期" getdis="true" placeholder="请输入出生日期" valid="{required:true}" class="form_date" data-date-formate="yyyy-MM-dd" />
								<input type="text" name="zm" label="罪名" getdis="true" placeholder="请输入罪名" valid="{required:true}"/>
								<input type="text" name="xq" label="刑期" getdis="true" placeholder="请输入刑期" valid="{required:true}"/>
								<input type="text" name="jtzz" label="家庭住址" getdis="true" placeholder="请输入家庭住址" valid="{required:true}"/>
								<input type="text" name="bpcxzjszjs" label="服刑地点" placeholder="请输入服刑地点" valid="{required:true}"/>
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