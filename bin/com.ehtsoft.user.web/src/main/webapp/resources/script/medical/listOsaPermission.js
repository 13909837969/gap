/**
 * 《权限授权管理》页面的js文件
 * @author 王宝
 * @since 2014-04-02
 */


$(function(){
	var flag=false;
	
	var accid = '';
	//生成方法对象
	var	ps=new PermissionService();
	var or=new OsaOrganizationService();
	//布局调用
	new Eht.Layout({center:"#center",right:"#right",top:"#systemTop"});
	new Eht.Layout({top:{selector:"#top",title:"用户查询"},center:"#infList"});
	//调用按钮
	var Toolbar=new Eht.Toolbar({selector:"#toolbar"});

	//Datagride调用
	var dgAcc=new Eht.Datagrid({selector:"#personInf",multable:false,hasFooter:true});
	
	//调用
	var tab = new Eht.Tab({selector:"#tab"});	
	var roleTree = new Eht.Tree({selector:"#role",labelField:"rolename",multable:true});
	var menuTree=new Eht.Tree({selector:"#fun",labelField:"menuname",multable:true});

	var orglist = new Eht.Tree({selector:"#orglist",labelField:"orgname",multable:true});
		////new Eht.Tree({selector:"#boll",labelField:"orgname",checkbox:true,cascadeSelect:false,hideParentCheckbox:true});
	orglist.loadData(function(res){
		or.findOrgs(accid,res);
	});
	
//功能菜单树 query 右侧树  查询条件 
	var query={};
	menuTree.loadData(function(res){
		var roles = roleTree.getSelectedData();
		var rids = new Array();
		for(var i=0;i<roles.length;i++){
			rids.push(roles[i].sysid);
		}
		query["ROLEID"] = rids;
		ps.findMenuTree(query,res);
	});
	
	roleTree.loadData(function(res){
		ps.findRoleTree(query,res);
	});
	//tree checkbox 变化时调用
	roleTree.checkboxChange(function(data){
		menuTree.refresh();
	});
	roleTree.loadComplete(function(data){
		menuTree.refresh();
	});
	dgAcc.loadComplete(function(){
		flag=false;
	});
	dgAcc.loadData(function(page,res){
		var q = {};
		q["A.accountid[like]"]=$("#accountid").val();
		if($("#flag").val()!=""){
			q["a.flag[eq]"] = parseInt($("#flag").val());
		}
		or.findAcc(q,page,res);
	});
	
	dgAcc.clickRow(function(data){
		accid=data.sysid;
		flag=true;
		query["accountid"]=accid;
		roleTree.refresh();
		menuTree.refresh();
		orglist.refresh();
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
	
	var qf = new Eht.Form({selector:"#queryform"});
	qf.change(function(){
		dgAcc.refresh();
	});
	Toolbar.click(function(id){
		switch(id){
		case "searchbut":{
			dgAcc.refresh();
			break;
		}
		case "savebut":
			if(flag==false){
				new Eht.Alert("请选择账户信息");
			}else if(roleTree.getSelectedData().length<=0 ){
				new Eht.Alert("没有选择分配的角色");
			}else{
			var treeRoleData=roleTree.getSelectedData();
			var treeMenuData=menuTree.getSelectedData();
			var roledata=[];
			for(var i=0; i<treeRoleData.length;i++){
				if(treeRoleData[i].sysid){
					var a={"accountid":accid,"roleid":treeRoleData[i].sysid};
					roledata.push(a);
				};
			};
			
			var fundata=[];
			for(var i=0;i<treeMenuData.length;i++ ){
				if(treeMenuData[i].sysid){
					var a={"accountid":accid,"menuid":treeMenuData[i].sysid};		
						fundata.push(a);
				};
			}
			var orgids = orglist.getSelectedData(true,"orgid");
			ps.save(accid,roledata,fundata,orgids,
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