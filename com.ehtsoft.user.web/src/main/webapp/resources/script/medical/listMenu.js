/**
 * 《功能菜单管理》页面的JS文件
 * 
 * @author 杜杰
 * @since 2014-04-02
 * @version 1.0
 */

$(function(){
//声明Service对象
	var ms=new MenuService();

//表单调用
	var form=new Eht.Form({selector:"#menuform"});
	/*
	var icons = new Eht.ComboBox({selector:"#icon"});
	var icondata = [];
	for(var i=34;i<=49;i++){
		icondata.push({value:"window-func-icon" + i,label:"taskbar-func-icon" + i});
	}
	icons.feature.transLabel(function(data){
		return "<div style='float:left;width:32px;height:32px;margin-right:4px;' class='"+data.label+"'></div>" + data.value;
	});
	icons.change(function(data){
		this.selector.val("");
		this.selector.css("background-repeat","no-repeat");
		this.selector.css("background-position","10px");
		this.selector.removeClass().addClass(data.value);
	});
	icons.loadData(icondata);
	*/
	var toolbar=new Eht.Toolbar({selector:"#topBar"});
	toolbar.disable("#savebut");
//布局调用
	new Eht.Layout({left:{selector:"#left",title:"功能菜单",titleSelector:"#application"},center:"#center",top:"#mtop"});
	new Eht.Layout({top:{selector:"#top",title:"功能菜单编辑"},center:"#infList"});
	
	var as = new ApplicationService();
	as.async = false;//同步
	var appdata = as.find({});
	
	$("#appid").data(appdata);
	for(var i=0;i<appdata.length;i++){
		var option = $("<option value='"+appdata[i].sysid+"'>"+"["+appdata[i].appcode+"]"+appdata[i].appname+"</option>");
		$("#appid").append(option);
	}
	$("#menucode").val($("#appid").data()[0].appcode);
	//Datagride调用
	var dg=new Eht.Datagrid({selector:"#personInf",multable:false,hasFooter:true,defaultColumnWidth:90});
	var query = new Object();
	query["appid[eq]"]=$("#appid").val();
	query["sort[asc]"]=1;
	dg.loadData(function(page,res){
		ms.findGrid(query,page,res);
	});
	
	//对应显示修改 rowData当前行的数据   cell表格的值得外层DIV
	dg.transColumn("appid", function(rowData,cell){
		var rtn = rowData.appid;
		for(var i=0;i<appdata.length;i++){
			if(rowData.appid==appdata[i].sysid){
				rtn = appdata[i].appname;
				break;
			}
		}
		return rtn;
	});
	dg.transColumn("menuname", function(rowData,rowIndex,cell,field){
		var rtn = "<span style='display:block;float:left;width:18px;height:18px;background-position:center;top'></span><span style='padding-left:2px;'>"+rowData.menuname + "</span>";
		return rtn;
	});
	dg.transColumn("icon",function(rowData,rowIndex,cell,field){
		var rtn = '<div>'
				+ '<div><span class="func_menu_icon '+rowData.icon+'" style="background-color:#999;border-radius:3px;margin:auto auto;"></span></div>'
				+ '<div style="text-align:center">'+rowData.icon+'</div>'
				+ '</div>';
		return rtn;
	});
	dg.clickRow(function(data){
		toolbar.enable("#savebut");
		form.fill(data);
//		icons.selector.removeClass().addClass(data.icon);
		if(!(data.icon && data.icon.length>3)){
			form.setValue("icon","");
		}
//		icons.enable();
		form.enable();
	});
	
//左侧树调用
	var tree = new Eht.Tree({selector:"#tree",labelField:"menuname",hideChildren:true});
	tree.clickRow(function(treeData){
		toolbar.enable("#savebut");
		form.enable();
//		icons.enable();
		form.setData({"parentid":treeData.sysid});
		form.fill(treeData);
		
		query["sysid[in]"]=this.radioData2Array("sysid");
		dg.refresh();
	});
	tree.loadData(function(res){
		ms.findTree({"appid[eq]":$("#appid").val(),"sort[asc]":1},res);
	});
	
	$("#appid").change(function(){
		$("#menucode").val($(this).data()[$(this).get(0).selectedIndex].appcode);
		tree.refresh();
		delete query["sysid[in]"];
		query["appid[eq]"]=$("#appid").val();
		dg.refresh();
	});

//按钮单击事件
	toolbar.click(function(id){
		switch(id){
			case "addbut":
				toolbar.enable("#savebut");
				form.clear();
				form.clearData();
				form.setValue("menucode",$("#appid").data()[$("#appid").get(0).selectedIndex].appcode);
				if(tree.radioData!=null){
					form.setData({appid:$("#appid").val(),"parentid":tree.radioData.sysid,"sysid":null});
					form.setValue("menucode",tree.radioData.menucode);
					form.setValue("parentid",tree.radioData.sysid);
				}else{
					form.setData({appid:$("#appid").val()});
				}
				form.enable();
			break;
			case "savebut":
				var d = form.getData();
				delete d.children;
				delete d.uuid;
				delete d.puid;
				ms.saveMenu(d,new Eht.Responder({
					success:function(){
						form.clear();
						form.setValue("menucode",$("#appid").data()[$("#appid").get(0).selectedIndex].appcode);
						tree.refresh();
						dg.refresh();
						new Eht.Tips().show("保存成功");
					}
				}));
			break;
		}
	});
});