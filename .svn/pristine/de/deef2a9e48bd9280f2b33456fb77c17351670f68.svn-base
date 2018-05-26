
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="${localCtx}/json/ZzczService.js"></script>
	<title>组织查找</title>
<script type="text/javascript">
$(function(){
	var service=new ZzczService();
	var table=new Eht.TableView({selector:"#zzcz_body"});
	var form=new Eht.Form({selector:"#zzcz-field"})
	var form_zzcz=new Eht.Form({selector:"#model_zzcz",autolayout:true});
	$("#zzcz_add").click(function(){
		$('#MyModal_zzcz').modal({backdrop:'static',keyboard: false});
   		
	})
	/* 初始化加载数据 */
	table.loadData(function(page,res){
		service.findZzcz(form.getData(),page,res);
	});
	/* 单击查询按钮触发事件 */
	$("#zzcz-field #btn").click(function(){
		table.refresh();//再执行上次方法
	});
	table.transColumn("czjg",function(data){
		if(data.bdqk == '03'){
			return "未找到";
		}
		
	})  
})


</script>
</head>
<body>
	
	<div  class="panel panel-default">
			<div id="zzcz_head" class="panel-heading">
				<fieldset id="zzcz-field" style="margin-top:10px;">
					<label>查找对象姓名:<input name="xm[like]"  type="text" style="width:100px;text-align: center;" ></label>&nbsp;&nbsp;
					<label>查找结果:<select name="czjg" type="text" style="width:100px;text-align: center; height: 26px;" >
									<option value="1">全部</option>
									<option value="2">未找到</option>
									<option value="3">已找到</option>
							</select>
					</label>&nbsp;&nbsp;
					<button class="btn btn-default btn-sm" id="btn">查询</button>&nbsp;&nbsp;
					<button class="btn btn-default btn-sm" id="zzcz_add">新增记录</button>
				</fieldset>
			</div>
			<div id="zzcz_body" class="panel-body">
				<div field="op" checkbox=true label="选择"></div>
				<div field="xm" label="姓名"></div>
				<div field="bdqk" label="查找类型" code="sys016"></div>
				<div field="czjg" label="查找结果"></div>
				<div field="name" label="记录人"></div>
				<div field="cdate" label="记录日期"></div>
				<div field="cz" label="操作" ></div>
			</div>
			<!-- <table id="sqjzDjjs_body">
				<tr>
					<td>序号</td>
					<td>姓名</td>
					<td>来源单位类型</td>
					<td>来源单位名称</td>
					<td>旗县级处理状态</td>
					<td>接受司法所</td>
					<td>司法所处理状态</td>
					<td>是否报到</td>				
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table> -->
			<!-- 页面按钮查看模态框（Modal） -->
			<div class="modal fade" id="MyModal_zzcz">
				<div class="modal-dialog modal-lg" >
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×
							</button>
							<h4 class="modal-title">新增记录</h4>
						</div>
						<div class="modal-body" id="model_zzcz" style="overflow:auto;">
						<input type="text" label="查找对象姓名" name="xm" getdis="true">
						<textarea  label="事实说明" name="sssm" getdis="true" style="resize: none; height: 200px;"></textarea></lable>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button id="btn_djjs" type="button" class="btn btn-primary">提交</button>
						</div>
					</div>
				</div>
			</div>
			
	</div>
	
</body>
</html>