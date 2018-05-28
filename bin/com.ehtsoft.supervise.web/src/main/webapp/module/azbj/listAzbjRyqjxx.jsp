<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--王世凯  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjRyqjxxService.js"></script>
<script type="text/javascript" src="${localCtx }/json/RegionService.js"></script>
<title>人员迁居信息管理</title>
<script type="text/javascript">
$(function() {
	var region = new RegionService();//省市区后台
	var query = {};
	var ryqj = new AzbjRyqjxxService();
	var form = new Eht.Form({selector : "#ryqjForm",autolayout : true});
	var tableview = new Eht.TableView({selector : "#tableview"});
	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
	var v = null;
	//展示页面信息
	tableview.loadData(function(page, res) {
		ryqj.findAll(qf.getData(), page, res);
	});
	//获取省市县的id值
	function findId(){
		v = $('#tableview :checkbox:checked').data().aid;
		shengs = $('#tableview :checkbox:checked').data().qrds;
		shis = $('#tableview :checkbox:checked').data().qrdsq;
		xias = $('#tableview :checkbox:checked').data().qrdx;
	}
	//模态框新增人员信息事件
	function findRy(){
		ryqj.findJz(new Eht.Responder({
			success:function(data){
			$("#azbjryid").empty();
			$("#azbjryid").append('<option></option>');
			for(var i=0;i<data.length;i++){
				if(data[i].id == v){
					$("#azbjryid").append("<option value=" + data[i].id+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
				}else{
					$("#azbjryid").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
			$("#azbjryid").comboSelect();
			}
		}))
	}
	//模糊查询
	$("#btn_cha").click(function() {
		tableview.refresh();
	});
	//使保存与关闭按钮显示
	function showbtn(){
		$("#btn_close").show();
		$("#btn_submit").show();
	}
	//新增按钮触发事件
	$("#btn_add").click(function() {
			form.clear();
			v = null;
			findRy();
			form.enable();
			$("#myModal").modal({
			backdrop : 'static'
		})
		showbtn();
	});
	//点击显示省菜单
	$("#shengji").click(sheng());
	//点击查看时显示代码只读
	$("#btn_search").click(function(){
		if($("#tableview :checkbox:checked").length==1){
			form.clear();
			findRy();
			sheng();
			findId();
			$("#myModal").modal({backdrop : 'static'});
			$("#btn_submit").hide();
			form.disable();
			form.fill($("#tableview :checkbox:checked").data());
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
		});
		//修改按钮事件
		$("#btn_edit").click(function() {
			form.clear();
			if($("#tableview :checkbox:checked").length==1){
			findId();
			findRy();
			sheng();
			showbtn();
			form.enable();
			$("#myModal").modal({backdrop : 'static'});
			form.fill($("#tableview :checkbox:checked").data());
			}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
			}
		});
		//删除按钮事件
		$("#btn_delete").click(function(){
			showbtn();
			if($("#tableview :checkbox:checked").length == 1){
				var c = new Eht.Confirm();
				c.show("此操作不可恢复，确定要删除选中记录吗！");
				c.onOk(function(){
				ryqj.removeOne($("#tableview :checkbox:checked").data().id,new Eht.Responder({
					success:function(){
					tableview.refresh();
					c.close();
					new Eht.Tips().show("删除成功");
					}
				}));
			});
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
		});
		//模态框保存并且隐藏
		$('#btn_submit').click(function() {
		if (form.validate()) {
				ryqj.saveOne(form.getData(), new Eht.Responder({
					success : function(data) {
					$('#myModal').modal('hide');
					new Eht.Tips().show("保存成功");
					tableview.refresh();
					}
				}));
			}else{
				new Eht.Tips().show("保存失败");
			}
		});
		/* 省区联动  */
	 	function sheng(){
			region.find(1,null,new Eht.Responder({	//省份初始化
				success:function(data){
					for (var i = 0; i < data.length; i++) {
						if($("#tableview :checkbox:checked").length == 1){
						if(data[i].regionid == $("#tableview :checkbox:checked").data().qrds)
							{
							$("#shengji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
							}
						else{
							$("#shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
						}
						else{
							$("#shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
					$("#shengji").change();
					}	
					}
				}))
		}
	 	function shi(){
			region.find(2,$("#shengji").val(),new Eht.Responder({ //市初始化
				success:function(data){
					$("#shiji").empty();
					for (var i = 0; i < data.length; i++) {
						if($("#tableview :checkbox:checked").length == 1){
						if(data[i].regionid == $("#tableview :checkbox:checked").data().qrdsq)
							{
							$("#shiji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
							}
						else{
							$("#shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
						}
						else{
							$("#shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
					$("#shiji").change();
					}
					}
				}))
		}
	 	function xian(){
			region.find(3,$("#shiji").val(),new Eht.Responder({ //县初始化
				success:function(data){
					$("#xianji").empty();
					for (var i = 0; i < data.length; i++) {
						if($("#tableview :checkbox:checked").length == 1){
						if(data[i].regionid == $("#tableview :checkbox:checked").data().qrdx)
							{
							$("#xianji").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
							}
						else{
							$("#xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
						}
						else{
							$("#xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
							}
					}
				}
			}))
		}
		$("#shengji").change(function(){	//市初始化
			shi();
		})
		$("#shiji").change(function(){	//县初始化
			xian();
		})
});
</script>
</head>
<body>
		<div class="toolbar">
		<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
		<button type="button" id="btn_search" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
		<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
		<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
		</div>
		<br/>
		<div id="query_form">
			<form class="form-inline" style="margin:10px;">
			<div class="form-group">
				<label for="xm">姓名</label>
				<input type="text" class="form-control" name="xm[like]" id="search_xm" placeholder="姓名">
			</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="sj">时间</label>
				<input type="text"  class="form_date btn btn-default" name="sj[like]" data-date-formate="yyyy-MM-dd"   data-date-formate="yyyy-MM-dd" placeholder="时间">
			</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="yy">原因</label>
				<input type="text" class="form-control" name="yy[like]" id="search-yy" placeholder="原因">
				</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="zt">状态</label>
				<input type="text" class="form-control" name="zt[like]" code="SYS153" id="search-zt" placeholder="状态">
			</div>
				<button type="button" class="btn btn-primary" id="btn_cha" style="margin-left:10px;">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>		
			</form>
		</div>
		<div id="tableview" class="table-responsive">
			<div field="xzk" label="选择" checkbox=true></div>
			<div field="xm" label="姓名"></div>
			<div field="sj" label="时间"></div>
			<div field="yy" label="原因"></div>
			<div field="zt" label="状态"></div>
			<div field="shyj" label="审核意见"></div>
		</div>
<!-- 新增迁居人员信息(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">人员迁居信息</h4>
			</div>
			<div class="modal-body" style="overflow: auto; height: 450px;">
				<div id="ryqjForm">
				<input type="hidden" name="id"/>
				<select  id="azbjryid"  name="azbjryid" label="迁居人员" style="max-width:none" valid="{required:true}"></select>
				<select name="qrds" type="text" id="shengji" getdis="true" label="选择省份" valid="{required:true}">
					<option value="" selected="selected"></option>
				</select>
				<select name="qrdsq" type="text" id="shiji" getdis="true" label="选择盟市" valid="{required:true}">
					<option value="" selected="selected"></option>
				</select>
				<select name="qrdx" type="text" id="xianji" getdis="true" label="选择旗县" valid="{required:true}">
					<option value="" selected="selected"></option>
				</select>
				<input type="text" id="qrdxz" name="qrdxz"  label="乡镇" placeholder="请填写乡镇" valid="{required:true}"/>
				<input type="text" id="qrdxxmph" name="qrdxxmph"  label="详细地址" placeholder="请填写详细地址" valid="{required:true}"/>
				<input type="text" label="时间" name="sj" class="form_date" data-date-formate="yyyy-MM-dd" valid="{required:true}"  data-date-formate="yyyy-MM-dd" placeholder="时间">
				<input type="text" id="yy" name="yy"  label="原因" placeholder="原因"/> 
				<input type="text" id="zt" name="zt"  label="状态" placeholder="状态" code="SYS153"/>
				<input type="text" id="shyj" name="shyj"  label="审核意见" placeholder ="审核意见"/>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
				<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>