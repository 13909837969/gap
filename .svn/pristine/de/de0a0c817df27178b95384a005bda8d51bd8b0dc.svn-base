<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司法所业务用房信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/YwyfService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/bootstrap/js/bootstrap-typeahead.js"></script>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var f_aid = "${param.f_aid}";
	query.f_aid = f_aid;
	//连接service
	var ywyfService = new YwyfService();
	var form = new Eht.Form({selector:'Ywyf-Form',autolayout:true});
	//查询信息
	var query = {};
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
			ywyfService.findAll(query,res);
		});
	});	
	
	
	$('#yes').click(function(){
		ywyfService.deleteOne({'id':json_data.id},new Eht.Responder({
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
		ywyfService.findAll(query,res);
	});
	form.change(function(name){
		if(name=="xm"){
			$("input[name='id']").val("");
			changeInput(false);
			$('#xm').typeahead({
				source:function(query,process){
					query = query.trim();
					ywyfService.findTafBasic({"xm[like]":query},new Eht.Responder({
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
			debugger;
		if(form.validate()){
			ywyfService.saveInfo(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	
	function changeInput(ifboolean){
		$('Ywyf-Form').find("input[name='csrq'],select[name='xb'],input[name='zm'],input[name='xq'],input[name='jtzz']").each(function(){
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
					<div field="sfsbm" label="司法所编号"></div>
					<div field="dlywyf" label="独立业务用房"></div>
					<div field="bgcssj" label="办公场所实景" ></div>
					<div field="ywyfcqgs" label="业务用房产权归属"></div>
					<div field="ywyftzf" label="业务用房投资方"></div>
					<div field="ywyfxz" label="业务用房性质"></div>
					<div field="ywyfmj" label="业务用房面积"></div>
					<div field="ywyftzje" label="业务用房投资金额"></div>
					<div field="jcsj" label="建成时间"></div>
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
						<h4 class="modal-title" id="myModalLabel">新增业务用房信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto">
						<div class="modal-body-div">
							<div id="Ywyf-Form">
								<div>
									<input type="hidden" value="${param.f_aid}" fixedValue="true" name="f_aid"/>
									<input type="hidden" name="id"/>
								</div>
								<input type="text" id="sfsbm" autoComplete="off"  name="sfsbm" label="司法所编码" valid="{required:true}"/>
								<input type="text" name="dlywyf" label="独立业务用房" getdis="true"  valid="{required:true}" code="sys001" />
								<select name="bgcssj"  label="办公场所实景"> 
									<option value=""></option> 
									<option value="01">司法所照片</option>
									<option value="02">办公场所实景</option>
									<option value="03">制度文件</option>
								</select>
								<select name="ywyfcqgs"  label="业务用房产权归属"> 
									<option value=""></option> 
									<option value="01">县（市、区）司法局</option>
									<option value="02">乡镇（街道）政府</option>
									<option value="03">司法所</option>
									<option value="99">其他</option>
								</select>
								<select name="ywyftzf"  label="业务用房投资方"> 
									<option value=""></option> 
									<option value="01">中央投资</option>
									<option value="02">地方投资</option>
									<option value="03">中央和地方共同投资</option>
									<option value="99">其他</option>
								</select>
								<select name="ywyftzf" label="业务用房性质"> 
									<option value=""></option> 
									<option value="01">划拨</option>
									<option value="02">租赁</option>
									<option value="03">自有</option>
									<option value="99">其他</option>
								</select>
								<input type="text" name="ywyfmj" label="业务用房面积" getdis="true"valid="{number:true}"/>
								<input type="text" name="ywyftzje" label="业务用房投资金额" getdis="true" valid="{number:true}"/>
								<input type="text" name="jcsj" label="建成时间" getdis="true" class="form_date" data-date-formate="yyyy-MM-dd" />
								
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