<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--陈崇 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询未成年子女帮扶信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjWcnznbfxxcjbService.js"></script>
<script type="text/javascript">
$(function()
 {
 	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
 	var service = new AzbjWcnznbfxxcjbService();
 	var form = new Eht.Form({selector:"#azbjryForm",autolayout:true});
 	var tableview = new Eht.TableView({selector:"#tableview"});
 	var v= null;
 	//展示页面信息
 	tableview.loadData(function(page,res)
 	{
 		service.findAll(qf.getData(), page, res);
 		});
 	//获取当前选中行的数据
	form.fill($("#tableview :checkbox:checked").data());
	$("#btn_add").click(function()
	{
		form.clear();	
	$("#myModal").modal({backdrop:'static'});
	});
	//模态框保存并且隐藏
	$("#btn_submit").click(function(res)
	{	
		var data = form.getData();
   		if(form.validate())
   		{ 
   			console.log(data);
   			service.saveOne(data,new Eht.Responder(
   			{
   				success:function()
   				{
   					$("#myModal").modal("hide");
   					new Eht.Tips().show("保存成功");
   					tableview.refresh();
   				}
   				}));	
   		 }else
   		 {
   			new Eht.Tips().show("保存失败");
   		 }	 
   	}); 
	//新增按钮触发事件
  $("#btn_add").click(function()
  	{		
  		form.clear();
  		v = null;
  		findRy(); 
  		form.enable();
  	   	$("#btn_submit").show();
  	   	$("#btn_close").show();
		$("#myModal").modal({backdrop : 'static'});
		tableview.refresh();
  		});
  	    //模糊查询按钮事件
  	$("#btn_search").click(function()
  	{
  		tableview.refresh();
  	});
  	//编辑按钮事件
  	$("#btn_edit").click(function()
  	{
  		if($("#tableview :checkbox:checked").length==1)
  		{
  			v = $('#tableview :checkbox:checked').data().aid;
  			findRy();
  			$("#btn_submit").show();
			$("#btn_close").show();
  			form.enable();
  			form.clear();
  			$("#myModal").modal({backdrop : 'static'});
  			form.fill($("#tableview :checkbox:checked").data());
  			tableview.refresh();
  		}
  	else
  	{
  	   	var ale = new Eht.Alert();
  		ale.show("请选中一条数据进行操作!");
  	  }
  	});
  	//人员查看事件
  	$("#btn_view").click(function() 
  		{
		if($("#tableview :checkbox:checked").length==1)
		{
			  v = $('#tableview :checkbox:checked').data().aid;
			  findRy();
		   	  $("#btn_submit").hide();
			  $("#myModal").modal({backdrop:'static'});
		      form.disable();
		      form.fill($("#tableview :checkbox:checked").data());
		}else
		{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});
 	//删除事件
  	$("#btn_delete").click(function()
   		{
			if($("#tableview :checkbox:checked").length==1)
			{
				var c = new Eht.Confirm();
				c.show("请确认是否删除！");
				c.onOk(function()
				{
					service.removeOne($("#tableview :checkbox:checked").data(),new Eht.Responder(
					{
						success:function()
						{
							tableview.refresh();
							c.close();
							new Eht.Tips().show();
						}
					}));
				});
			}
			 else
			{
				var ale = new Eht.Confirm();
				ale.show("请选中一条数据进行操作!");
			} 
		});
    //模态框查询人员信息事件
  	function findRy()
  		{
  			service.findJz(new Eht.Responder(
  			{
  				success:function(data)
  				{
  					$("#jzryxx_xmajglx").empty();
  					$("#jzryxx_xmajglx").append('<option></option>');
  					for(var i=0;i<data.length;i++)
  					  {
  						if(data[i].id == v)
  						{
  							$("#jzryxx_xmajglx").append("<option value=" + data[i].id+" selected>" + data[i].xm + data[i].grlxdh + "</option>");
  						 }else
  						 {
  							$("#jzryxx_xmajglx").append("<option value=" + data[i].id+">" + data[i].xm + data[i].grlxdh + "</option>");
  						 }
  					   }
  					$("#jzryxx_xmajglx").comboSelect();
  				}
  			}))
  		 }
  });  
</script>
<body>
	<div class="toolbar">
   			<button id="btn_add" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
   			<button id="btn_view" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
			<button id="btn_edit" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
			<button id="btn_delete" type="button" class="btn btn-default" style="margin-left:10px;">
				<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
	</div>
   	<!-- 模糊查询条件部分 -->
   	<form class="form-inline" style="margin:10px;">
		<div id="query_form">
			<div class="form-group">
				<label for="xm">姓名</label>
				<input type="text" class="form-control" name="xm[like]"  placeholder="请输入姓名">
			</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="sfzh">身份证号</label>
				<input type="text" class="form-control" name="sfzh[like]" placeholder="请输入身份证号">
			</div>
			<div class="form-group" style="margin-left:10px;">
				<label for="jzd">居住地</label>
				<input type="text" class="form-control" name="jzd[like]" placeholder="请输入居住地">
			</div>
			<button id="btn_search" type="button" class="btn btn-primary" style="margin-left:10px;">
				<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
   		</div>
	</form>
	<div id="tableview" class="table-responsive">
		<div field="xz" label="选择" checkbox="true"></div>
		<div field="xm" label="服刑人员"></div>
		<div field="sfrzetfly" label="是否入住儿童福利院" code="SYS232"></div>
		<div field="sfjtjy" label="是否家庭寄养" code="SYS233"></div>
		<div field="sfrzjzzhbhzx" label="是否入住救助站或保护中心" code="SYS234"></div>
		<div field="sflsdb" label="是否落实低保" code="SYS235"></div>
		<div field="sffx" label="是否复学" code="SYS236"></div>
		<div field="sffflsbt" label="是否发放临时补贴" code="SYS237"></div>
		<div field="sfjmxzf" label="是否减免学杂费" code="SYS238"></div>
		<div field="sfzh" label="身份证号"></div>
	</div>
   </div>
   <!-- 新增未成年子女帮扶信息(Modal) -->
   	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   		<div class="modal-dialog" style="width:800px;">
   			<div class="modal-content">
   				<div class="modal-header">
   					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
   						&times;
   					</button>
   					<h4 class="modal-title" id="myModalLabel">未成年子女帮扶信息</h4>
   				</div>
   				<div class="modal-body" style="height:400px; overflow:auto">
   					<div class="modal-body-div">
   						<div id="azbjryForm" >
   							<input type="hidden" name="id">
   							<select id="jzryxx_xmajglx" name="azbjryid" label="服刑人员:" style="max-width:none">
							</select>
							<input name="sfrzetfly" label="是否入住儿童福利院:" code="SYS232"  valid="{required:true}" >
							<input name="sfjtjy" label="是否家庭寄养:" code="SYS233"  valid="{required:true}">
							<input name="sfrzjzzhbhzx" label="是否入住救助站或保护中心:" code="SYS234"  valid="{required:true}">
							<input name="sflsdb" label="是否落实低保:" code="SYS235"  valid="{required:true}">
							<input name="sffx" label="是否复学:" code="SYS236"  valid="{required:true}">
							<input name="sffflsbt" label="是否发放临时补贴:" code="SYS237"  valid="{required:true}">
							<input name="sfjmxzf" label="是否减免学杂费:" code="SYS238"  valid="{required:true}">
							<input id="bfhdkzcs" name="bfhdkzcs" label="帮扶活动开展次数:" placeholder="帮扶活动开展次数" valid="{required:true,int:true}"></br>
							<input id="hjd" name="hjd" label="户籍地:" placeholder="户籍地"  valid="{required:true}"></br>
							<input id="jzd" name="jzd" label="居住地:" placeholder="居住地"  valid="{required:true}"></br>
							<input id="sfzh" name="sfzh" label="身份证号:" placeholder="身份证号"  valid="{required:true,cardNo:true}"></br>
   						</div>
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