var common=$(function($){
	//页面布局
	new Eht.Layout({top:"#top",left:{selector:"#left",title:"公司部门"},center:"#center",right:{selector:"#right",title:"角色"}});
	new Eht.Layout({top:{selector:"#r_form1",title:"编辑医疗机构"},center:"#r_form2"});
	
	//toolbar
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable("#savebtn");
	
	//创建树(组织机构)
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname",hideChildren:true});
	var roleQuery = {};
	var rolelist = new Eht.Tree({selector:"#rolelist",labelField:"rolename",multable:true});
	//新建类
	var service = new PsaOrganizationService();
	
	//创建form表单
	var form = new Eht.Form({selector:"#form"});
	var orgOpenForm = new Eht.Form({selector:"#orgOpenForm"});
	
	//创建列表
	var datagrid = new Eht.Datagrid({selector:"#datagrid",multable:false}); 
	
	//window
	 var window = new Eht.Window({iframe:false,title:"组织机构查询",selector:"#orgOpenWin",width:"250",height:"200",maxButton:false,resize:true});
	
	//树加载数据
	tree.loadData(function(res){
		service.getOrgTree({"orgcode[rlike]":$("#appid").val()},res);
	});	
	
	rolelist.loadData(function(res){
		service.getRole(roleQuery.orgid,res);
	});
	var query = {};
	var prov = [{v:1,d:"集团"},{v:2,d:"公司"},{v:3,d:"部门"}];
	var jgs = [{v:4,d:"医院"},{v:5,d:"社区卫生服务中心"},{v:6,d:"乡镇卫生院"},{v:7,d:"村卫生室"}];
	
	//列表显示数字转化成汉字在前台显示
	datagrid.transColumn("lvl", function(data){
		var rtn = data.lvl;
		for(var i=0;i<prov.length;i++){
			if(data.lvl == prov[i].v){
				rtn = prov[i].d;
				break;
			}
		}
		return rtn;
	});
	var selectRowDatas = [];
	datagrid.loadComplete(function(){
		this.setSelectedRow(selectRowDatas,function(ds,d){
			var rtn = false;
			for(var i=0;i<ds.length;i++){
				if(ds[i]==d.sysid){
					rtn = true;
					break;
				}
			}
			return rtn;
		});
	});
	//加载组织机构信息
	datagrid.loadData(function(page,res) {
		service.find(query,page,res);
	});
	
	//单击列表的某行
	datagrid.clickRow(function(data){
		selectRowDatas[0]=data.sysid;
		roleQuery.orgid = data.sysid;
		form.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
		form.enable();
		form.disable("orgcode",true);
		form.fill(data);
		toolbar.enable("#savebtn");
		rolelist.refresh();
	});
	
	//单击树的某行
	tree.clickRow(function(data){
		form.clear();
		form.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
		form.setData({"parentid":data.sysid});
		query = {"sysids":tree.radioData2Array("sysid"),
			  "orgcode[rlike]":$("#appid").val()};
		datagrid.refresh();
	});
	
	//类型选择行政区划的时，医院类型控件不可用
	$("select[name='lvl']").change(function(){
		if($("select[name='lvl']").val() == "1" || $("select[name='lvl']").val() == "2" || $("select[name='lvl']").val() == "3"){
			$("select[name='type']").attr("disabled",true);
		}else{
			$("select[name='type']").attr("disabled",false);
		}
	});
	
	$("#appid").change(function(){
		tree.refresh();
		datagrid.refresh();
	});
	
	
	//点击菜单按钮
	toolbar.click(function(id){
		switch(id){
			//新增组织机构信息
			case "addbtn":	
				form.remove("sysid");
				form.clear();
				form.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
				form.enable();
				toolbar.enable("#savebtn");
				if(tree.radioData==null){
					if(tree.data!=null && tree.data.length>0){
						tree.radioData = tree.data[0];
					}
				}
				if(tree.radioData!=null){
					form.setValue("orgcode",tree.radioData.orgcode);
					var lvl = tree.radioData.lvl;
					if(lvl<3){
						form.setValue("lvl",lvl+1);
						service.createBm(form.getValue("orgcode"),new Eht.Responder({success:function(data){
							form.setValue("orgcode", data.value);
						}}));
					}
				}else{
					form.setValue("lvl", "1");
					form.enable();
					service.createBm(form.getValue("orgcode"),new Eht.Responder({success:function(data){
						form.setValue("orgcode", data.value);
					}}));
				}
				break;
			//将新增组织机构信息保存到系统中
			case "savebtn":
				var data = form.getData();
				service.save(data,rolelist.getSelectedData(),new Eht.Responder({success:function(d){
					new Eht.Tips().show();
					tree.refresh();
					datagrid.refresh();	
				}}));
				break;
				//将新增组织机构信息保存到系统中
			case "searbtn":
				window.open();
				break;
	}});
	
	//组织机构查询
	$("#orgSearch").click(function(){
			window.close();
			query = orgOpenForm.getData();
			datagrid.refresh();
			orgOpenForm.clear();
	});
	
	//刷新
	$.fn.refresh=function(){
		datagrid.refresh();
	};
});