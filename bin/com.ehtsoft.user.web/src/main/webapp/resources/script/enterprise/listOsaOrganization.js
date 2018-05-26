/**
 * 《系统用户管理》页面的JS文件
 * 
 * @author 王宝
 * @since 2014-04-01
 * @version 1.0
 */

$(function(){
	var sso = new SSO();
	sso.async=false;
	var user = sso.getCurrentUser();
	
	var personIdx=new Object();
	
//生成方法对象用于调用
	var or=new OsaOrganizationService();
	var pos = new PsaOrganizationService();
//调用toolbar
	var perbar= new Eht.Toolbar({selector:"#perbut"});
	var accbar= new Eht.Toolbar({selector:"#accbut"});
	new Eht.Layout({left:{selector:"#left",title:" ",titleSelector:"#lefttitle"},center:"#right"});
	var layout = new Eht.Layout({top:{selector:"#top",title:"用户设置"},center:{selector:"#infList",border:false}});
	layout.setTitle("top",user.unitName+"用户设置");
//表单控制
	var form = new Eht.Form({selector:"#querycon"});
	//机构window
	var orgWin = new Eht.Window({selector:"#win_form",
		modal:true,
		width:300,height:200,
		minButton:false,
		maxButton:false});
	var orgform = new Eht.Form({selector:"#form"});
	var orgtree = new Eht.Tree({selector:"#orgtree",labelField:"orgname"});
	orgtree.loadData(function(res){
		or.findOrg(res);
	});
	//暂时没有用
	orgtree.clickRow(function(data){
		form.setData({"B.ORGID[eq]":data.sysid});
		dgPer.refresh();
		dgAcc.refresh();
	});
	orgtree.dblclickRow(function(data){
		orgWin.setTitle("编辑机构信息");
		orgWin.open();
		orgform.fill(data);
		orgWin.newflag = false;//编辑标记
	});
//标签调用
	var tab = new Eht.Tab({selector:"#tab"});	
//调用人员表
	var dgPer=new Eht.Datagrid({selector:"#personInf",multable:true,hasFooter:true,footerSelector:"#perbut"});
	dgPer.loadData(function(page,res){
		var q=form.getData();
		delete q["accountid[like]"];
		or.findPer(q,page,res);
	});
	dgPer.transColumn("sex",function(rowData){
		
		var rtn=rowData.sex;
		if(rtn=="1"){
			rtn="男";
		}else if(rtn=="2"){
			rtn="女";
		}
		return rtn;
	});
	//对应显示修改 rowData当前行的数据   cell表格的值得外层DIV
	dgPer.transColumn("orgid",function(rowData){
		var unitname = user.unitName;
		if(orgtree.radioData!=null){
			unitname = orgtree.radioData.orgname;
		}
		return unitname;
	});
	
	dgPer.renderer("sex",function(){
		var ds1=[{"v":1,"d":"男"},{"v":2,"d":"女"}];
		var xb = new Eht.ComboBox({labelField:"d",valueField:"v"});xb.loadData(ds1);
		return xb;
	});
	//添加渲染列
	dgPer.renderer("birthday",function(){
		var csrq = new Eht.ComboBox();
		csrq.setFeature(new Eht.DatePicker());
		return csrq;
	});
	
	 var downperson =  new Eht.Datagrid({selector:"#downperson",isPaginate:false});
	    downperson.loadData(function(page,res){
	    	var orgid = null;
			or.findPer({"orgid[eq]":orgid},null,res);
		});
	    
//调用用户信息
	var dgAcc=new Eht.Datagrid({selector:"#accountInf",hasFooter:true,multable:true,footerSelector:"#accbut"});
	dgAcc.transColumn("flag",function(rowData){
		var rtn=rowData.flag;
		if(rtn==0){
			rtn="禁用";
		}else if(rtn==1){
			rtn="开启";
		}
		return rtn;
	});
	dgAcc.transColumn("frule",function(rowData){
		var rtn="";
		if(rowData.frule=="OSA"){
			rtn = "管理员";
		}
		return rtn;
	});
	dgAcc.transColumn("userid",function(rowData){
		return rowData.name;
	});
	dgAcc.transColumn("orgname",function(rowData){
		var unitname = user.unitName;
		if(orgtree.radioData!=null){
			unitname = orgtree.radioData.orgname;
		}
		return unitname;
	});
	dgAcc.renderer("flag",function(){
	    var flagData=[{"v":1,"d":"开启"},{"v":0,"d":"禁用"}];
		var combo = new Eht.ComboBox({labelField:"d",valueField:"v"});
		combo.loadData(flagData);
		
		return combo;
	    });
	dgAcc.renderer("userid", function(){
		var combo = new Eht.ComboBox({labelField:"name",valueField:"sysid"});
		combo.data = downperson.data;
		combo.setFeature(downperson);
		return combo;
	});
	dgAcc.loadData(function(page,res){
		var q={"A.accountid[like]":$("#querycon #accountid").val()};
		if(form.getData()["B.ORGID[eq]"]!=null){
			q["B.ORGID[eq]"]=form.getData()["B.ORGID[eq]"];
		}
		or.findAcc(q,page,res);
	});
	
	//双击开启账户信息编辑
	dgAcc.dblclickRow(function(data,rowIndex){
		if(data.frule!="OSA"&&data.frule!="PSA"){
			dgAcc.editRow(rowIndex);
			accbar.enable("#ieditbtn,#isavebtn,#idel");
		}
	});
	
	
	tab.click(function(d){
		dgAcc.resize();
	});
	orgWin.closeBefore(function(){
		if(this.newflag==true){
			orgform.clear("orgcode");
		}else{
			//关闭的时候情况form 中的数据，双击tree时打开的窗口（编辑窗口），如果点击关闭按钮时，表单全部清空
			orgform.clear();
		}
		orgform.clearData();
		return true;
	});
    //添加当前用户机构的子机构
	$("#addSub").click(function(){
		orgWin.setTitle("新增子机构");
		orgWin.open();
		orgWin.newflag = true;//新增标记
		
		orgform.setData({parentid:user.unitId});
		if(orgform.getData().orgcode==""){
			pos.createBm(user.unitCode,new Eht.Responder({success:function(ds){
				orgform.setValue("orgcode", ds.value);
			}}));
		}
	});
	//保存组织机构
	$("#saveOrg").click(function(){
		$(this).disable();
		or.saveOrg(orgform.getData(),new Eht.Responder({success:function(){
			new Eht.Tips().show();
			orgform.clear();
			orgtree.refresh();
		}}));
		orgWin.close();
		setTimeout(function(){
			$("#saveOrg").enable();
		},1000);
	});
//调用按钮表单用于事件处理	
	$("#search").click(function(){
		dgPer.refresh();
		dgAcc.refresh();
	});	
//双击开启人员信息编辑
	dgPer.dblclickRow(function(data,rowIndex){
		dgPer.editRow(rowIndex);
	});

//编辑按钮展开编辑 当personIdx为0时 默认为false;
	dgPer.clickRow(function(data,selected,rowIndex){
		perbar.enable();
		accbar.enable();
		if(selected){
			personIdx[rowIndex]=rowIndex;
		}else{
			delete personIdx[rowIndex];
		}
		//perbar.enable("#paddbtn,#peditbtn,#psavebtn,#pdel,#pchange,#pinit");
	});

	
//点击账户信息编辑
	var accIdx=new Object();  
	dgAcc.clickRow(function(data,selected,rowIndex){
		perbar.enable();
		accbar.enable();
		if(selected){
			accIdx[rowIndex]=rowIndex;
		}else{
			delete accIdx[rowIndex];
		}
	});


	perbar.click(function(id){
		switch(id){
		case "paddbtn":{
				var unitid = user.unitId;
				if(orgtree.radioData!=null){
					unitid = orgtree.radioData.sysid;
				}
				var rowIndex=dgPer.addRow({"orgid":unitid});
				dgPer.editRow(rowIndex);
		}break;
		case "pdel":{
			if(dgPer.getSelectedData().length==0){
				new Eht.Alert("请选择需要删除的数据");
				return;
			}
			var cfm = new Eht.Confirm("确认要删除选择的数据");
			cfm.clickOk(function(){
				or.removePer(dgPer.getSelectedData(),new Eht.Responder({success:function(){
				  dgPer.refresh();
				}}));
			});
		}
		break;
		case "psavebtn":
			if(dgPer.getData().length==0){
				new Eht.Alert("数据没有更新，不需要保存！");
				return;
			}
			or.savePer(dgPer.getData(),
					new Eht.Responder({
						success : function() {
							new Eht.Tips().show("保存成功");
							dgPer.refresh();
							downperson.refresh();
						}
					})
			);
		break;
		case "peditbtn":
			for(var p in personIdx){
				dgPer.editRow(p);
			}
			personIdx = new Object();
		
		break;
		case "initAcc":
			if(dgPer.getSelectedData().length==0){
				new Eht.Alert("请选择需要初始化账户的用户");
				return;
			}
			or.initAccount(dgPer.getSelectedData(),new Eht.Responder({success:function(data){
				new Eht.Tips().show("初始账户成功");
				dgAcc.refresh();
			}}));
			break;
		}
	});
	/*
	 *账户信息底部按钮
	 */	
	accbar.click(function(id){
		switch(id){
		case "iaddbtn":
				var unitid = user.unitId;
				if(orgtree.radioData!=null){
					unitid = orgtree.radioData.sysid;
				}
				//添加对应orgid的值
				var rowIndex=dgAcc.addRow({"accountid":"","userid":"","flag":1,"orgid":unitid});
				dgAcc.editRow(rowIndex);
				accbar.enable("#ieditbtn,#isavebtn,#idel");
	break;
		case "idel":
			if(dgAcc.getSelectedData().length==0){
				new Eht.Alert("请选择需要删除的数据");
				return;
			}
			var cfm = new Eht.Confirm("确认要删除选择的数据");
			cfm.clickOk(function(){
				for(var i=0;i<dgAcc.getSelectedData().length;i++){
					var d = dgAcc.getSelectedData()[i];
					if(d.frule=="OSA"|| d.frule=="PSA"){
						new Eht.Alert("账号：" + d.accountid + " 为管理员账号，不能删除！");
						return;
					}
				}
				or.removeAcc(dgAcc.getSelectedData(),new Eht.Responder({success:function(){
					dgAcc.refresh();
				}}));
			});
		break;
		case "ieditbtn":
			for(var p in accIdx){
				dgAcc.editRow(p);
			}
			accIdx = new Object();
		break;
		case "isavebtn":
			if(dgAcc.getData().length==0){
				new Eht.Alert("数据没有更新，不需要保存！");
				return;
			}
			or.saveAcc(dgAcc.getData(),
					new Eht.Responder({
						success : function() {
							new Eht.Tips().show("保存成功");
							dgAcc.refresh();
						}
					})
			);
		break;
		}
	});

});


