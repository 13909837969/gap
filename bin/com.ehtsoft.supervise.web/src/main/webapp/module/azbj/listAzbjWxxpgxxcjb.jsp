<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- 冉令孚 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjWxxpgService.js"></script>
<title>危险性评估信息管理</title>
<script type="text/javascript">
$(function(){
    var service = new AzbjWxxpgService();
	var form = new Eht.Form({selector:'#jcflfwsForm',autolayout:true,formCol:2});
	var tableview = new Eht.TableView({selector:'#tableview'});
	var qf = new Eht.Form({selector:"#divcx",codeEmpty:true,codeEmptyLabel:"全部"});
	var v = null;
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(qf.getData(), page, res);
	});
	//新增按钮触发事件
	$("#btn_add").click(function(){
		form.clear();
		v = null;
		findRy();
		$("#myModal").modal({backdrop:'static'});
		$("#btn_submit").show();
		form.enable();
	});
	//查看按钮触发事件
	$("#btn_view").click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			v = $("#tableview :checkbox:checked").data().aid;
			findRy();
			$("#btn_submit").hide();
			$("#myModal").modal({backdrop:'static'});
			form.fill($("#tableview :checkbox:checked").data());
			form.disable();
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中其中一条数据进行操作!");
		}
	}); 
	//删除按钮事件
	$('#btn_delete').click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			var c = new Eht.Confirm();
			c.show("此操作不可恢复，确定要删除选中记录吗！");
			c.onOk(function(){
				service.removeOne($("#tableview :checkbox:checked").data(),new Eht.Responder({
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
	//查询按钮事件
	$("#btn_search").click(function(){
		tableview.refresh();
	});	
	//编辑按钮事件
	$("#btn_edit").click(function(){
		if($("#tableview :checkbox:checked").length == 1){
			v = $("#tableview :checkbox:checked").data().aid;
			findRy();
			$("#myModal").modal({backdrop:'static'});
			form.fill($("#tableview :checkbox:checked").data());
			$("#btn_submit").show();
			form.enable();
		}else{
			var ale = new Eht.Alert();
			ale.show("请选中其中一条数据进行操作！");
		}
	});
	//模态框保存并且隐藏
	$("#btn_submit").click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal("hide");
					tableview.refresh();
					new Eht.Tips().show("保存成功");
				}
			}));
		}else{
			new Eht.Tips().show("保存失败");
		}
	});
	//模态框新增人员信息事件
	function findRy(){
		service.findJz(new Eht.Responder({
			success:function(data){
				$("#wxxpg_xmajglx").empty();
				$("#wxxpg_xmajglx").append('<option></option>');
				for(var i=0;i<data.length;i++){
					if(data[i].id == v){
						$("#wxxpg_xmajglx").append("<option value=" + data[i].id+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
					}else{
						$("#wxxpg_xmajglx").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
					}
				}
				$("#wxxpg_xmajglx").comboSelect();
			}
		}))
	}
});
</script>
</head>
<body>
<!-- 增删改查操作按钮部分 -->
<div class="toolbar">
	<button id="btn_add"  type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
	<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
	<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!--查询条件部分  -->
<form class="form-inline" style="margin:10px;">
	<div id="divcx">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="jyqk">就业情况</label>
			<input type="text" class="form-control" name="jyqk[eq]" placeholder="就业情况" code="SYS175">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="shly">生活来源</label>
			<input type="text" class="form-control" name="shly[eq]" placeholder="生活来源" code="sys176">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="rzfftd">认罪服法态度</label>
			<input type="text" class="form-control" name="rzfftd[eq]" placeholder="认罪服法态度" code="sys188">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="dazbjtd">对安置帮教态度</label>
			<input type="text" class="form-control" name="dazbjtd[eq]" placeholder="对安置帮教态度" code="sys193">
		</div>
		<button type="button" id="btn_search" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<!--页面遍历基本情况部分  -->
<div id="tableview" class="table-responsive">
	<div field="xzk" label="选择" checkbox="true"></div>
	<div field="xm" label="姓名"></div>
	<div field="nl" label="年龄" code="SYS173"></div>
	<div field="whcd" label="文化程度" code="SYS219"></div>
	<div field="jyqk" label="就业情况" code="SYS175"></div>
	<div field="shly" label="生活来源" code="SYS176"></div>
	<div field="gdzs" label="固定住所" code="SYS179"></div>
	<div field="wffzlx" label="违法犯罪类型" code="SYS245"></div>
	<div field="rzfftd" label="认罪服法态度" code="SYS188"></div>
	<div field="gzbx" label="改造表现" code="SYS189"></div>
	<div field="dazbjtd" label="对安置帮教态度" code="SYS193"></div>
	<div field="sfswry" label="是否三无人员" code="SYS226"></div>
</div>
<!-- 服刑人员危险性评估信息(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">服刑人员危险评估信息</h4>
			</div>
			<div class="modal-body" style="overflow: auto;height:450px;">
				<div id="jcflfwsForm">
					<input type="hidden" name="id"/>
					<select id="wxxpg_xmajglx" name="azbjryid" label="服刑人员姓名" style="max-width:none">
					</select>
					<input id="sfzh" name="sfzh" label="身份证号" code="SYS241" valid="{required:true}">
   					<input id="zz" name="zz" label="住址" code="SYS172" valid="{required:true}">
   					<input id="nl" name="nl" label="年龄" code="SYS173" valid="{required:true}">
					<input id="whcd" name="whcd" label="文化程度" code="SYS219" valid="{required:true}">
					<input id="jyqk" name="jyqk" label="就业情况" code="SYS175" valid="{required:true}">
					<input id="shly" name="shly" label="生活来源" code="SYS176" valid="{required:true}">
					<input id="gdzs" name="gdzs" label="固定住所" code="SYS242" valid="{required:true}">
					<input id="stzk" name="stzk" label="身体状况" code="SYS177" valid="{required:true}">
					<input id="hyzk" name="hyzk" label="婚姻状况" code="SYS178" valid="{required:true}">
					<input id="jtcygx" name="jtcygx" label="家庭成员关系" code="SYS179" valid="{required:true}">
					<input id="jtjjqk" name="jtjjqk" label="家庭经济情况" code="SYS180" valid="{required:true}">
					<input id="jtcyfzjl" name="jtcyfzjl" label="家庭成员犯罪记录" code="SYS243" valid="{required:true}">
					<input id="jzjsbs" name="jzjsbs" label="家族精神病史" code="SYS244" valid="{required:true}">
					<input id="wffzlx" name="wffzlx" label="违法犯罪类型" code="SYS245" valid="{required:true}"/>
					<input id="zgexcd" name="zgexcd" label="主观恶性程度" code="SYS181" valid="{required:true}"/>
					<input id="fflf" name="fflf" label="是否累犯" code="SYS080" valid="{required:true}">
					<input id="xljkzk" name="xljkzk" label="心理健康状况" code="SYS182" valid="{required:true}">
					<input id="zknl" name="zknl" label="自控能力" code="SYS183" valid="{required:true}">
					<input id="flzshfzgn" name="flzshfzgn" label="法律知识或法制观念" code="SYS184" valid="{required:true}">
					<input id="dxsshxt" name="dxsshxt" label="对现实社会心态" code="SYS185" valid="{required:true}">
					<input id="jwfw" name="jwfw" label="交往范围" code="SYS186" valid="{required:true}">
					<input id="shjwtd" name="shjwtd" label="社会交往态度" code="SYS187" valid="{required:true}">
					<input id="xq" name="xq" label="刑期" code="SYS220" valid="{required:true}">
					<input id="rzfftd" name="rzfftd" label="认罪服法态度" code="SYS188" valid="{required:true}">
					<input id="gzbx" name="gzbx" label="改造表现" code="SYS189" valid="{required:true}">
					<input id="zyjn" name="zyjn" label="职业技能" code="SYS190" valid="{required:true}"> 
					<!-- <input id="jspg" name="jspg" label="监所评估" code="SYS248" valid="{required:true}">  -->
					<input id="jspg" type="text" name="jspg" label="监所评估" placeholder="监所评估" valid="{required:true}">
					<input id="hgqx" name="hgqx" label="回归去向" code="SYS192" valid="{required:true}">
					<input id="dazbjtd" name="dazbjtd" label="对安置帮教态度" code="SYS193" valid="{required:true}">
					<input id="sfswry" name="sfswry" label="是否三无人员" code="SYS226" valid="{required:true}">
					<input type="text" name="zf" label="总分" placeholder="总分">
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