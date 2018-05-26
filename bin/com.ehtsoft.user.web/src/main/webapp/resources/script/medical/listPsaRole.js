/**
 * 《功能角色管理》页面的JS文件
 * 
 * @author 王宝
 * @since 2014-04-02
 * @version 1.0
 */

$(function(){
	var rs=new RoleService();
	//导航调用
	var toolbar=new Eht.Toolbar({selector:"#toolbar"}); 
	toolbar.disable("#savebut");
	
	toolbar.click(function(id){
	switch(id){
		case "savebut":
			var treeData = tree.getSelectedData();
			var menus = new Array();
			for(var i=0;i<treeData.length;i++){
				if(!treeData[i].appcode){					
					menus.push({menuid:treeData[i].sysid});
				}
			}
			rs.save(form.getData(),menus,new Eht.Responder({
					success:function(){
						new Eht.Tips().show("保存成功");
						dg.refresh();
						if(parent.common && parent.common.refresh){
							parent.common.refresh();
						}
					}
				})
			);
			break;
		case  "addbut":
			form.enable();
			form.clear();
			form.clearData();
			form.setValue("flag",1);
			form.setValue("frule","-1");
			toolbar.enable("#savebut");
			break;
		case "delbtn":
			if(dg.getSelectedData().length==0){
				new Eht.Alert("请选择需要删除的角色");
				return;
			}
			var conf = new Eht.Confirm("确认要删除该角色");
			conf.clickOk(function(){
				rs.remove(dg.getSelectedData(),new Eht.Responder({success:function(){
					dg.refresh();
				}}));
			});
			break;
		break;
	}
});
	
//布局调用
	new Eht.Layout({right:{selector:"#right",title:"功能菜单"},center:"#center",top:"#topbar"});
	new Eht.Layout({top:{selector:"#top",title:"角色"},center:"#infList"});
//表格调用	
	var dg=new Eht.Datagrid({selector:"#personInf",multable:false,hasFooter:true});
	var form=new Eht.Form({selector:"#formRole"});
	form.disable();
	
	dg.clickRow(function(data){
		toolbar.enable("#savebut");
		
		form.fill(data);
		query.roleid=data.sysid;
		query.appfrule=data.frule;
		
		if(data.frule==null){
			form.setValue("frule","-1");
			query.appfrule="OSA";
		}
		
		tree.refresh();
		form.enable();
		toolbar.enable("#savebut");
	});
	dg.transColumn("frule", function(data){
		if(data.frule=="PSA"){
			return "平台系统管理员";
		}
		if(data.frule=="OSA"){
			return "机构用户管理员";
		}
		if(data.frule==null){
			return "机构普通用户";
		}
	});
	dg.loadData(function(page,res){
		rs.findRole({},page,res);
	});

	var query = new Object();
	query.appfrule="OSA";
	//右侧树调用
	var tree = new Eht.Tree({selector:"#tree",labelField:"menuname",multable:true,hideChildren:true});
	
	tree.loadData(function(res){
		rs.findMenuTree(query,res);
	});
	dg.transColumn("flag",function(rowData,cell){
		var rtn = rowData.flag;
			if(rowData.flag==1){
				rtn = "开启";
			}
			if(rowData.flag==0){
				rtn = "关闭";
			}
		   return rtn;
		}
	);
	
	$("#frule").change(function(){
		delete query.roleid;
		if($(this).val()=="PSA"){
			query.appfrule="PSA";
		}else{
			query.appfrule="OSA";
		}
		tree.refresh();
	});
});