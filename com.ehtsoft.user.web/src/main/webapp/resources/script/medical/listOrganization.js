/**
 * 《系统用户管理》页面的JS文件
 * 
 * @author 王宝
 * @since 2014-04-01
 * @version 1.0
 */

$(function(){
//树id是否存在
	//true add ,false edit
	var addflag = true;
	
	var personIdx=new Object();
	
//生成方法对象用于调用
	var or=new OsaOrganizationService();
//调用toolbar
	var perbar= new Eht.Toolbar({selector:"#perbut"});
		perbar.disable("#paddbtn,#peditbtn,#psavebtn,#pdel,#pchange,#pinit");
	var accbar= new Eht.Toolbar({selector:"#accbut"});
		accbar.disable("#iaddbtn,#ieditbtn,#isavebtn,#idel");
//表单控制
	var form = new Eht.Form({selector:".systemTopbody"});	
//布局调用	
	new Eht.Layout({left:{selector:"#left",title:"组织机构"},center:{selector:"#center",border:false}});
	new Eht.Layout({top:{selector:"#top",title:"编辑组织机构"},center:{selector:"#infList"}});
//树调用	
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname",hideChildren:true});
	tree.loadData(function(res){
		or.findOrg(res);
	});
//标签调用
	var tab = new Eht.Tab({selector:"#tab"});	
//列表调用
	var query = new Object();
//调用人员表
	var dgPer=new Eht.Datagrid({selector:"#personInf",multable:true,hasFooter:true,footerSelector:"#perbut"});
	dgPer.transColumn("sex",function(rowData){
		var rtn=rowData.sex;
		if(rtn=="1"){
			rtn="男";
		}else if(rtn=="2"){
			rtn="女";
		}
		return rtn;
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
	
	dgPer.loadData(function(page,res){
		or.findPer(query,page,res);
	});
	
	 var downperson =  new Eht.Datagrid({selector:"#downperson",isPaginate:false});
	    downperson.loadData(function(page,res){
	    	var orgid = null;
	    	if(tree.radioData!=null){
	    		orgid = parseInt(tree.radioData.sysid);
	    	}
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

	dgAcc.renderer("flag",function(){
	    var flagData=[{"v":1,"d":"开启"},{"v":0,"d":"禁用"}];
		var combo = new Eht.ComboBox({labelField:"d",valueField:"v"});
		combo.loadData(flagData);
		
		return combo;
	    });
	
	dgAcc.loadData(function(page,res){
		var q = new Object();
		q["B.ORGID[in]"] = tree.radioData2Array("sysid");
		or.findAcc(q,page,res);
	});
	
	//双击开启账户信息编辑
	dgAcc.dblclickRow(function(data,rowIndex){
		dgAcc.editRow(rowIndex);
		accbar.enable("#ieditbtn,#isavebtn,#idel");
	});
	
//左侧树事件	
	form.disable();
	tree.clickRow(function(data){
		$("#agency,#orgname,#savebut").enable();
//解除按钮不可用
		perbar.enable();
		accbar.enable();
		
		addflag = false;
		form.setData({"parentid":null});
		form.enable();
		form.fill(data);
		query["orgid[in]"]=this.radioData2Array("sysid");
		dgPer.refresh();
		dgAcc.refresh();
		downperson.refresh();
		
	});
	
	tab.click(function(d){
		dgAcc.resize();
	});
	
	$("#center").css({"-moz-border-radius-topleft":"5px","-webkit-border-top-left-radius": "5px","-khtml-border-top-left-radius": "5px","border-top-left-radius": "5px"});

//调用按钮表单用于事件处理	
	$("#addbut").click(function(){
		addflag = true;
		form.clear();
		if(tree.radioData!=null){
			form.setData({"parentid":tree.radioData.sysid,"sysid":null});
			form.setValue("orgcode",tree.radioData.orgcode);
		}
		form.enable();
		$("#savebut").attr("disabled",false);
	});
	
//保存组织机构
	$("#savebut").click(function() {
		var d = form.getData();
		delete d.children;
		delete d.uuid;
		delete d.puid;
			or.saveOrg(d,
					//回调函数保存成功后刷新
					new Eht.Responder({
					success : function() {
						if(addflag==true){
							form.clearData();
						}
						tree.refresh();
						new Eht.Tips().show("保存成功");
					}
			}));
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

	
/*
 *人员信息底部按钮 
 */	
	perbar.click(function(id){
		switch(id){
		case "paddbtn":{
			if(tree.radioData!=null){
				//添加对应orgid的值
				var rowIndex=dgPer.addRow({"orgid":tree.radioData.sysid});
				dgPer.editRow(rowIndex);
			}else{
				new Eht.Alert("请选择对应的组织结构");
			}
		}break;
		case "pdel":{
			
			var cfm = new Eht.Confirm("确认要删除选择的数据");
			cfm.clickOk(function(){
				or.removePer(dgPer.getSelectedData(),new Eht.Responder({success:function(){
				  dgPer.refresh();
				}}));
			});
		}
		break;
		case "psavebtn":
			or.savePer(dgPer.data,
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
			if(tree.radioData!=null){
				//添加对应orgid的值
				var rowIndex=dgAcc.addRow({"accountid":"","userid":"","flag":"","orgid":tree.radioData.sysid});
				dgAcc.editRow(rowIndex);
				accbar.enable("#ieditbtn,#isavebtn,#idel");
				
			}else{
				new Eht.Alert("请选择对应的组织结构");
			}
		break;
		case "idel":
			
			var cfm = new Eht.Confirm("确认要删除选择的数据");
			cfm.clickOk(function(){
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
			or.saveAcc(dgAcc.data,
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


