var common=$(function($){
	//页面布局
	new Eht.Layout({top:"#top",left:{selector:"#left",title:"医疗机构信息",titleSelector:"#orgtreeTitle"},center:"#center",right:{selector:"#right"}});
	new Eht.Layout({top:{selector:"#r_form1",title:"编辑医疗机构"},center:"#r_form2"});
	
	//toolbar
	var toolbar = new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable("#savebtn");
	
	var tab = new Eht.Tab({selector:"#tab"});
	//创建树(组织机构)
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname",hideChildren:true});
	var roleQuery = {};
	//角色
	var rolelist = new Eht.Tree({selector:"#rolelist",labelField:"rolename",multable:true});
	//授权能查看的机构
	var selectOrgs = new Eht.Tree({selector:"#selectOrgs",labelField:"orgname",multable:true});
	//新建类
	var service = new PsaOrganizationService();
	var scence = new SceneService();
	scence.find({},new Eht.Responder({success:function(data){
		var scencetab = $("#scence");
		for(var i=0;i<data.rows.length;i++){
			scencetab.append("<tr>" +
								 "<td><input id='radio_"+i+"' type='radio' name='sceneid' value='"+data.rows[i].sysid+"'/></td>" +
								 "<td>" +
								 "<label for='radio_"+i+"'><h4>"	+ data.rows[i].scenename +
									"</h4><img src='../../image/SceneService?sysid="+data.rows[i].sysid+"&width=140&height=100'/>" +
								 "</label>" +
								 "</td>" +
							 "</tr>");
		}
		scencetab.find("input[type='radio']").change(function(){
			scencetab.find("tr").removeClass("tr_selected");
			$(this).parent().parent().addClass("tr_selected");
		});
	}}));
	//创建form表单
	var form = new Eht.Form({selector:"#form"});
	var orgOpenForm = new Eht.Form({selector:"#orgOpenForm"});
	
	//创建列表
	var datagrid = new Eht.Datagrid({selector:"#datagrid",multable:false}); 
	
	
	tree.loadComplete(function(data){
		if($("#appid").children().length>0){
			return;
		}
		$("#appid").append($('<option value="">全部</option>'));
		for(var i=0;i<data.length;i++){
			var ct =$('<option value='+data[i].orgcode+'>'+data[i].orgname+'</option>');
			$("#appid").append(ct);
		}
	});
	//树加载数据
	tree.loadData(function(res){
		service.getOrgTree({"orgcode[rlike]":$("#appid").val()},res);
	});	
	
	rolelist.loadData(function(res){
		service.getRole(roleQuery.orgid,res);
	});
	var selOrgid = '';
	var selAccid = '';
	selectOrgs.loadData(function(res){
		service.findOrgs(selOrgid,selAccid,res);
	});
	var query = {};
	var prov = [{v:1,d:"司法厅"},{v:2,d:"市司法局"},{v:3,d:"区县司法局"}];
	/*
	var jgs = [{v:31,d:"区政府"},{v:32,d:"街道办"},{v:4,d:"社区"},{v:5,d:"安全隐患主管部门"},
		       {v:6,d:"安检站"},{v:7,d:"学校"},{v:8,d:"公益组织"}];
	*/
	var jgs = [{v:4,d:"司法所"}];
	$("#lvl").append("<option></option>");
	for(var i=0;i<prov.length;i++){
		var op = "<option value="+prov[i].v+">"+prov[i].d+"</option>";
		$("#lvl").append(op);
		$("#lvlid").append(op);
	}
	for(var i=0;i<jgs.length;i++){
		var op = "<option value="+jgs[i].v+">"+jgs[i].d+"</option>";
		$("#lvl").append(op);
		$("#lvlid").append(op);
	}
	//列表显示数字转化成汉字在前台显示
	datagrid.transColumn("lvl", function(data){
		var rtn = data.lvl;
		for(var i=0;i<prov.length;i++){
			if(data.lvl == prov[i].v){
				rtn = prov[i].d;
				break;
			}
		}
		for(var i=0;i<jgs.length;i++){
			if(data.lvl == jgs[i].v){
				rtn = jgs[i].d;
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
		$("#lvlid").empty();
		form.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
		if(data.lvl<=3){
			for(var i=0;i<prov.length;i++){
				$("#lvlid").append("<option value='"+prov[i].v+"'>"+prov[i].d+"</option>");
			}
			form.disable();
			form.enable("accid",true);
		}else{
			for(var i=0;i<jgs.length;i++){
				$("#lvlid").append("<option value='"+jgs[i].v+"'>"+jgs[i].d+"</option>");
			}
			form.enable();
			form.disable("orgcode",true);
		}
		form.fill(data);
		$("input[name='sceneid']").each(function(){
			if($(this).val()==data.sceneid){
			  this.checked = true;
			  $(this).parent().parent().addClass("tr_selected");
			}else{
				this.checked = false;
				$(this).parent().parent().removeClass("tr_selected");
			}
		});
		toolbar.enable("#savebtn");
		rolelist.refresh();
		
		selOrgid = data.sysid;
		selAccid = data.accountid;
		selectOrgs.refresh();
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
	
	$("#lvlid").change(function(){
		if(form.getData().sysid==null){
			var type = parseInt($(this).val());
			var pid = form.getData().parentid;
			service.async = false;
			service.createBm(pid,type,new Eht.Responder({success:function(data){
				form.setValue("orgcode", data.value);
				form.setValue("accid", data.value);
			}}));
			service.async = true;
		}
	});
	//点击菜单按钮
	toolbar.click(function(id){
		switch(id){
			//新增组织机构信息
			case "addbtn":	
				$("#lvlid").empty();
				form.remove("sysid");
				form.clear();
				form.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
				form.enable();
				toolbar.enable("#savebtn");
				if(tree.radioData!=null){
					form.setValue("orgcode",tree.radioData.orgcode);
					var lvl = tree.radioData.lvl - 0;
					if(lvl<3){
						for(var i=0;i<prov.length;i++){
							$("#lvlid").append("<option value='"+prov[i].v+"'>"+prov[i].d+"</option>");
						}
						form.setValue("lvl",lvl+1);
						form.disable("lvl",true);
						$("input[name='orgcode']").attr("maxLength",(lvl+1)*2);
					}else{
						for(var i=0;i<jgs.length;i++){
							$("#lvlid").append("<option value='"+jgs[i].v+"'>"+jgs[i].d+"</option>");
						}
						form.enable();
						form.disable("orgcode",true);
						/*
						service.createBm(form.getValue("orgcode"),new Eht.Responder({success:function(data){
							form.setValue("orgcode", data.value);
						}}));
						*/
						var type = parseInt(form.getData().lvl);
						var pid = form.getData().parentid;
						service.async = false;
						service.createBm(pid,type,new Eht.Responder({success:function(data){
							form.setValue("orgcode", data.value);
							form.setValue("accid", data.value);
						}}));
						service.async = true;
						datagrid.clearSelected();
					}
				}else{
					$("#lvlid").append("<option value='1'>司法厅</option>");
					form.setValue("lvl", "1");
					$("input[name='orgcode']").attr("maxLength",2);
					form.enable();
					form.remove("parentid");
					form.disable("lvl",true);
				}
				break;
			//将新增组织机构信息保存到系统中
			case "savebtn":
				if(form.validate()){
					var data = form.getData();
					data.sceneid = $("input[name='sceneid']:checked").val();
					var orgids = selectOrgs.getSelectedData(true,"orgid");
					service.save(data,rolelist.getSelectedData(),orgids,new Eht.Responder({success:function(d){
						form.setData({sysid:d.value});
						new Eht.Tips().show();
						tree.refresh();
						datagrid.refresh();	
					}}));
				}
				break;
				//将新增组织机构信息保存到系统中
			case "searbtn":
				query = orgOpenForm.getData();
				datagrid.refresh();
				break;
	}});
	//刷新
	$.fn.refresh=function(){
		datagrid.refresh();
	};
});