<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>字典定义表</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../json/DictionaryService.js"></script>
<script type="text/javascript">
var common = $(function(){
	//新建 DictionaryService 类
	var ds = new DictionaryService();
	//布局
	new Eht.Layout({
		top:{selector:"#top"},
		left:{selector:"#left",title:"数据标准"},
		center:{selector:"#center"}
	});
	
	//两个菜单切换用的函数
	var tab = new Eht.Tab({selector:"#tab"});
	tab.click(function(){
		dg.resize();
		dg.modalWait.hide();
	});
	
	//toolbar上面定义
	var toolbar = new Eht.Toolbar({
		selector:"#toolbar"
	});
	
	//toolbar下面定义
	var toolbar_down = new Eht.Toolbar({
		selector:"#add"
	});
	
	//点击下面toolbar的新增时触发的事件
	toolbar_down.click(function(id){
		switch(id){
			case "addbtn":
				var rowIndex=dg.addRow({
						"f_typecode":$(".c_f_typecode").val(),
						"f_code":"",
						"f_name":"",
						"f_pcode":"",
						"f_def":""
				});
				dg.editRow(rowIndex);
				break;
		}
	});
	//form
	var form1 = new Eht.Form({selector:"#form1"});
	var obj = null;
	//tree
	var tree = new Eht.Tree({
		selector:"#tree",
		multable:false,
		labelField:"f_typename"
	});
	//tree加载数据
	//var query={};
	tree.loadData(function(res){
		ds.findTree({
//			"f_typecode":1
			},res);
	});
	
	//tree加数据格式
	tree.transLabel(function(data){
		return "["+data.f_typecode+"]"+data.f_typename;
	});
	
	//新建datagrid
	var dg = new Eht.Datagrid({
		selector:"#datagrid",
		multable:false,
		isPaginate:true,
		hasFooter:true,
		footerSelector:"#add"
	});
	dg.transColumn("f_def", function(rowData,rowIndex,cell){
		cell.css("text-align","center");
		var checkbox =  $("<input type='checkbox' value='1'/>");
		checkbox.attr("rowIndex",rowIndex);
		checkbox.attr("clear","false");
		if(rowData.f_def=="1"){
			checkbox.get(0).checked = true;
		}
		checkbox.change(function(){
			var ds = dg.data;
			var ri = $(this).attr("rowIndex");
			for(var i=0;i<ds.length;i++){
				ds[i].f_def = "0";
			}
			dg.tabBody.find("td[field='f_def'] input[type='checkbox']").each(function(){				
				if(ri!=$(this).attr("rowIndex")){
					$(this).get(0).checked = false;
				}
			});
			if($(this).is(":checked")){
				ds[ri-0].f_def = "1";
			}
		});
		return checkbox;
	});
	
	//页面加载时,从后台查找数据
	dg.loadData(function(page,res){
		if(obj != null){
			ds.find({
				"f_typecode":obj.f_typecode
				/*"f_code[asc]":1*/
				},page,res);			
		}
	});
	
	toolbar.click(function(id){
		switch(id){
			case "addbtn1":
				//当点击上面新增时清空两个表中form中的数据
				if(form1.getData().f_typecode && form1.getData().f_typecode!=""){
					if(form1.getData().daab01==undefined){
						new Eht.Alert("数据还没有保存，请保存后，继续添加");
						return;
					}
				}
				form1.clearData();
				form1.clear();
				//把该字段赋成一个没有的值
				if(obj==null){
					obj = new Object();
				}
				form1.enable();
				dg.clear();
				tab.active(0);
				break;
			case "savebtn"://保存
			if(form1.validate()){
				var data = form1.getData();
				var detail = dg.getData();
				
				ds.save(data,detail,new Eht.Responder({success:function(d){
					form1.setData({"_id":d.value});
					obj.f_typecode = form1.getData().f_typecode;
					dg.refresh();
					tree.refresh();
					new Eht.Tips().show();
				}}));
			}
			break;
		}
	});
	
	
	//双击可对数据标准进行编辑
	dg.dblclickRow(function(data,rowIndex){
		dg.editRow(rowIndex,{field:"f_code",enable:false});
	});
	//单击tree的一行时
	tree.clickRow(function(data){
		
		obj = data;
		form1.fill(data);
		form1.disable("f_typecode",true);
		dg.setPaginate({indexPage:1});
		dg.refresh();
	});
	$(".eht-toolbar-file").change(function(){
		if($(this).val()!=""){
			setTimeout(function(){
				$("#uploadForm").submit();
			},200);
		}
	});
	$.fn.refresh=function(){
		tree.refresh();
		dg.clear();
	};
});
function uploadSuccess(str){
	common.refresh();
}
</script>
</head>
<body>
	<div id="top" style="height:28px">
		<div id="toolbar" style="vertical-align: middle;">
			<a id="savebtn" icon="eht-savebtn-icon">保存</a>
			<a id="addbtn1" icon='eht-addbtn-icon'>新增</a>
			<a id="upload" icon='eht-impexcel-icon'>导入字典
			<form id="uploadForm" action="../../upload/DictionaryService" method="post" enctype="multipart/form-data" target="importFrame" style="margin:0px;padding:0px;">
				<input type="file" name="filename" class="eht-toolbar-file"/>
			</form>
			<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
			</a>
		</div>
	</div>
	<div id="left" style="width: 220px;">
		<div id="tree" style="overflow: auto;"></div>
	</div>
	<div id="center" style="background: #fff;">
		<div id="tab">
			<div label="数据类型" style="padding:5px;" selected="true">
				<table cellspacing="0px" cellpadding="0px" table-layout="fixed"  id="form1">
					<tr>
						<td>
							类型编码
						</td>
						<td>
							<input type="text" class="c_f_typecode" name="f_typecode" validate="[{required:true}]"/>
						</td>
					</tr>
					<tr>
						<td>
							类型名称
						</td>
						<td>
							<input type="text" class="c_f_typename" name="f_typename" validate="[{required:true}]"/>
						</td>
					</tr>
				</table>
			</div>
			<div label="数据字典定义" style="padding:5px;">
				<table id="datagrid" heigth="50%">
					<tr>
						<td field="f_typecode" width="100px" enable="false">类型编码</td> 
						<td field="f_code" width="100px">编码</td>
						<td field="f_name" width="100px">名称</td>
						<td field="f_pcode" width="100px">上级编码</td>
						<td field="f_def" checkbox="true">默认值</td>
					</tr>
				</table>
			</div>
			<div id="add">
				<a id="addbtn" icon='eht-addbtn-icon'>新增</a>
			</div>
		</div>
	</div>
</body>
</html>