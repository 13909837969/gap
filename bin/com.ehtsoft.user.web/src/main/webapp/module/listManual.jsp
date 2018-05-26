<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统数据模型查询手册</title>
<jsp:include page="common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/ModelManualService.js"></script>
<script type="text/javascript">
$(function(){
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable();
	toolbar.enable("#search");
	new Eht.Layout({top:"#top",center:"#center"});
	new Eht.Layout({left:"#c_left",center:"#c_center"});
	var collay=new Eht.Layout({center:{selector:"#c_ctop",border:false,title:"表字段信息"},bottom:"#c_cbottom"});
	new Eht.Layout({top:"#b_top",center:"#b_bottom"});
	var tabledg = new Eht.Datagrid({selector:"#tabledg",hasFooter:false,pkField:"name"});
	var tablecol = new Eht.Datagrid({selector:"#tablecol",hasFooter:false});
	var uniquedg = new Eht.Datagrid({selector:"#unique",hasFooter:false});
	var fkdg = new Eht.Datagrid({selector:"#fkdg",hasFooter:false});
	var ms = new ModelManualService();
	var wintxt = new Eht.Window({selector:"#wintxt",iframe:false,modal:true});
	tabledg.transColumn("xh",function(data,rowIndex,cell){
		cell.css("text-align","center")
		return rowIndex+1;
	});
	tabledg.loadData(function(page,res){
		ms.getAllTableConfig(res);
	});
	tablecol.transColumn("xh",function(data,rowIndex,cell){
		cell.css("text-align","center")
		return rowIndex+1;
	});
	tabledg.clickRow(function(data){
		toolbar.enable();
		var a = $("<a href='#' style='color:#1b57b0;'>"+data.name + " " + data.label+"</a>");
		a.data({name:data.name});
		a.click(function(){
			tabledg.setSelectedRow($(this).data().name);
		});
		collay.setTitle("center",a);
		tablecol.clear();
		fkdg.clear();
		uniquedg.clear();
		if(data.foreigns && data.foreigns.length>0){
			fkdg.loadData(data.foreigns);
		}
		if(data.uniques && data.uniques.length>0){
			uniquedg.loadData(data.uniques);
		}
		tablecol.transColumn("ys",function(d1,ri,cell){
			if(data.primary && data.primary.field.toLowerCase()==d1.field.toLowerCase()){
				return "PK";
			}
			if(data.uniques && data.uniques.length>0){
				for(var i=0;i<data.uniques.length;i++){
					if(data.uniques[i].field.toLowerCase().search(d1.field.toLowerCase())!=-1){
						return "UK";
					}
				}
			}
			if(data.foreigns && data.foreigns.length>0){
				for(var i=0;i<data.foreigns.length;i++){
					if(data.foreigns[i].field.toLowerCase()==d1.field.toLowerCase()){
						tablecol.getRow(ri).addClass("row-red-font");
						return "FK";
					}
				}
			}
		});
		tablecol.loadData(data.columns);
	});
	fkdg.clickRow(function(data){
		tabledg.setSelectedRow(data.reference);
	});
	wintxt.openComplete(function(){
		$("#selectAllbtn").click(function(e){
			$("#txtarea").select();
			if(window.clipboardData){
				window.clipboardData.setData("Text",$("#txtarea").val());
			}else if(e.originalEvent && e.originalEvent.clipboardData){
				e.originalEvent.clipboardData.setData("Text",$("#txtarea").val());
			}
		});
	});
	toolbar.click(function(id){
		switch(id){
			case "search"://查询
				break;
			case "formbtn"://生成表单及表格代码
				 var ds = tabledg.getSelectedData();
				wintxt.setTitle("生成【"+ds[0].name+"|"+ds[0].label+"】表单及表格代码 &nbsp;<input id='selectAllbtn' type='button' value='全选复制'/>");
				wintxt.open();
				makeDgFormCode();
				break;
			case "sqlbtn"://生成查询脚本
				var ds = tabledg.getSelectedData();
				wintxt.setTitle("生成【"+ds[0].name+"|"+ds[0].label+"】查询脚本 &nbsp;<input id='selectAllbtn' type='button' value='全选复制'/>");
				wintxt.open();
				$("#txtarea").val("");
				ms.getSql(ds[0].name,new Eht.Responder({complete:function(rep){
					var v = rep.responseText.replace("\{\"value\":\"","").replace("\"\}","");
					$("#txtarea").val(v);
				},error:function(){}}));
				break;
		}
	});
	function makeDgFormCode(){
		$("#txtarea").val("");
	    var ds = tabledg.getSelectedData();
	    if(ds!=null && ds.length>0){
	    	var cols = ['<!-- '+ds[0].name+' '+ds[0].label+' 表单 -->','<div id="form" class="form_class">'];
	    	for(var i=0;i<ds[0].columns.length;i++){
	    		cols.push('\t<div class="form_item"><label>'+ds[0].columns[i].label+'</label><span><input type="text" name="'+ds[0].columns[i].field.toLowerCase()+'"/></span></div>');
	    	}
	    	cols.push('</div>');
	    	cols.push("\n");
	    	cols.push('<!-- '+ds[0].name+' '+ds[0].label+' datagrid表格 -->');
	    	cols.push('<div id="dg">');
	    	for(var i=0;i<ds[0].columns.length;i++){
	    		cols.push('\t<div field="'+ds[0].columns[i].field.toLowerCase()+'" label="'+ds[0].columns[i].label+'"></div>');
	    	}
	    	cols.push('</div>');
	    	$("#txtarea").val(cols.join("\n"));
	    }
	}
});
</script>
<style>
.row-red-font div{
	color:#1b57b0;
}
textarea{
 resize:none;
 border:0px;
}
</style>
</head>
<body>
<div id="top">
	<div id="toolbar">
		<a id="search" icon="eht-search-icon">查询</a>
		<a id="formbtn" icon="eht-toolbtn-icon">生成表单及表格代码</a>
		<a id="sqlbtn" icon="eht-toolbtn-icon">生成查询脚本</a>
	</div>
</div>
<div id="center">
	<div id="c_left" style="width:480px;">
		<div id="tabledg">
			<div field="xh" label="序号" width="30"></div>
			<div field="name" label="表名" width="75"></div>
			<div field="label" label="表描述" width="200"></div>
			<div field="remark" label="备注" width="250"></div>
		</div>
	</div>
	<div id="c_center">
		<div id="c_ctop">
			<div id="tablecol">
				<div field="xh" label="序号" width="30"></div>
				<div field="field" label="字段" width="65"></div>
				<div field="label" label="字段描述"></div>
				<div field="type" label="类型" width="70"></div>
				<div field="ys" label="约束" width="30"></div>
				<div field="length" label="长度" width="40"></div>
				<div field="precision" label="小数位" width="40"></div>
				<div field="defaultValue" label="默认值" width="40"></div>
				<div field="required" label="必填项目" width="60"></div>
				<div field="remark" label="备注" width="400"></div>
			</div>
		</div>
		<div id="c_cbottom" style="height:220px;">
			<div id="b_top" style="height:100px;">
				<div id="unique">
					<div field="name" label="唯一约束名" width="240"></div>
					<div field="field" label="唯一约束字段" width="280"></div>
				</div>
			</div>
			<div id="b_bottom">
				<div id="fkdg">
					<div field="name" label="外键名称" width="200"></div>
					<div field="field" label="外键字段" width="80"></div>
					<div field="reference" label="外键参照表" width="100"></div>
					<div field="referField" label="参照的字段" width="80"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="wintxt">
	<textarea  id="txtarea"></textarea>
</div>
</body>
</html>