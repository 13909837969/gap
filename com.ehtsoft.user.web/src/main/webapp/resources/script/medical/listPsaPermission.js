/**
 * 《权限授权管理》页面的js文件
 * @author 王宝
 * @since 2014-04-02
 */


$(function(){
	var flag=false;
	
	
	//生成方法对象
	var	acc=new PermissionService();
	var or=new OsaOrganizationService();
	//布局调用
	new Eht.Layout({left:{selector:"#left",title:"组织结构"},center:"#center",right:"#right",top:"#systemTop"});
	new Eht.Layout({top:{selector:"#top",title:"用户查询"},center:"#infList"});
	//调用按钮
	var Toolbar=new Eht.Toolbar({selector:"#toolbar"});

	//Datagride调用
	var dgAcc=new Eht.Datagrid({selector:"#personInf",multable:false,hasFooter:true});
	
	//调用
	var tab = new Eht.Tab({selector:"#tab"});	
	//树调用
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname",hideChildren:true});
	var roleTree = new Eht.Tree({selector:"#role",labelField:"rolename",multable:true});
	var orgTree=new Eht.Tree({selector:"#org",labelField:"orgname",multable:true});
	var menuTree=new Eht.Tree({selector:"#fun",labelField:"menuname",multable:true});

//功能菜单树 query 右侧树  查询条件 
	var query={};
	menuTree.loadData(function(res){
		var roles = roleTree.getSelectedData();
		var rids = new Array();
		for(var i=0;i<roles.length;i++){
			rids.push(roles[i].sysid);
		}
		query["ROLEID"] = rids;
		acc.findMenuTree(query,res);
	});
//左侧组织树
	tree.loadData(function(res){
		acc.findOrgTree(res);
	});
	tree.clickRow(function(treeData){
		var q = new Object();
		q["B.ORGID[in]"] = tree.radioData2Array("sysid");
		dgAcc.refresh();
	});
	roleTree.loadData(function(res){
		acc.findRoleTree(query,res);
	});
	//tree checkbox 变化时调用
	roleTree.checkboxChange(function(data){
		menuTree.refresh();
	});
	roleTree.loadComplete(function(data){
		menuTree.refresh();
	});
//右侧组织树	
	orgTree.loadData(function(res){
		acc.findOrgTree(query,res);
	});

	orgTree.transLabel(function(data){
		var cbox = this.body.find("input[uuid='"+data.puid+"']");
		if(cbox.size()>0){
			if(data.selected==1){
				cbox.get(0).checked = true;
			}
		}
		return "["+data.orgcode+"]"+data.orgname;
	});
	

	
	
	dgAcc.loadData(function(page,res){
		var q = new Object();
		q["B.ORGID[in]"] = tree.radioData2Array("sysid");
		or.findAcc(q,page,res);
	});
	
	dgAcc.clickRow(function(data){
		accid=data.sysid;
		flag=true;
		query["accountid"]=accid;
		roleTree.refresh();
		orgTree.refresh();
		menuTree.refresh();
	});
	
	dgAcc.transColumn("flag",function(rowData){
		var trn=rowData.flag;
		if(trn==0){
			trn="禁用";
		}else if(trn==1){
			trn="开启";
		}
		return trn;
	});
	

	Toolbar.click(function(id){
		switch(id){
		case "searchbut":{
			dgAcc.loadData(function(page,res){
				var d = {};
				d["A.accountid[like]"]=$("#accountid").val();
				if($("#flag").val()!=""){
					d["a.flag[eq]"] = parseInt($("#flag").val());
				}
				or.findAcc(d,page,res);
			});
			
		break;
		}
		case "savebut":
			if(flag==false){
				new Eht.Alert("请选择账户信息");
			}else if(roleTree.getSelectedData().length<=0 ){
				new Eht.Alert("没有选择分配的角色");
			}
			else{
			var treeRoleData=roleTree.getSelectedData();
			var treeOrgData=orgTree.getSelectedData(true);
			var treeMenuData=menuTree.getSelectedData();
			var roledata=[];
			for(var i=0; i<treeRoleData.length;i++){
				if(treeRoleData[i].sysid){
					var a={"accountid":accid,"roleid":treeRoleData[i].sysid};
					roledata.push(a);
				};
			};
			
			var orgdata=[];
			for(var i=0;i<treeOrgData.length;i++){
				if(treeOrgData[i].sysid){
					var a={"accountid":accid,"orgid":treeOrgData[i].sysid};
					if(treeOrgData[i].defaultorg==null || treeOrgData[i].defaultorg==undefined){
						orgdata.push(a);
					}
				};
			}
			
			var fundata=[];
			for(var i=0;i<treeMenuData.length;i++ ){
				if(treeMenuData[i].sysid){
					var a={"accountid":accid,"menuid":treeMenuData[i].sysid};		
						fundata.push(a);
				};
			}
			acc.saveAccRole(roledata,orgdata,fundata,
					new Eht.Responder({
						success : function() {
							new Eht.Tips().show("保存成功");
							dgAcc.refresh();
							if(parent.common && parent.common.refresh){
								parent.common.refresh();
							}
						}
					})
			);
			}
		}
	});
});