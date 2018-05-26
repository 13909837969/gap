/**
 * 《权限授权管理》页面的js文件
 * @author 王宝
 * @since 2014-04-02
 */


$(function(){
	var flag=false;
	
	var accid = 0;
	//生成方法对象
	var	ps=new FirstPageService();
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
	var menuTree=new Eht.Tree({selector:"#funtab",labelField:"menuname",
		multable:false,checkbox:true,cascadeSelect:false,hideParentCheckbox:true,
		loadInit:false});

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
	
//功能菜单树 query 右侧树  查询条件 
	menuTree.loadData(function(res){
		ps.findMenu(accid,res);
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
		menuTree.refresh();
		$("input[name='sceneid']").each(function(){
			if($(this).val()==data.sceneid){
			  this.checked = true;
			  $(this).parent().parent().addClass("tr_selected");
			}else{
				this.checked = false;
				$(this).parent().parent().removeClass("tr_selected");
			}
		});
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
			}else {
				var d={};
				d.sysid = accid;
				d.sceneid = $("input[name='sceneid']:checked").val();
				if(menuTree.getSelectedData().length>0){
					d.menuid = menuTree.getSelectedData()[0].sysid;
				}
				ps.save(d,new Eht.Responder({success:function(){
					new Eht.Tips().show();
					dgAcc.refresh();
				}}));
			}
		}
	});
});