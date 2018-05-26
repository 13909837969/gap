/**
 * 《登陆成功页面main1》页面的JS文件
 * 
 * @author 王宝
 * @since 2014-04-28
 * @version 1.0
 */
$(function(){
	if($.cookie("sso_token")==null){
		window.history.forward(1);
		return;
	}
	var toolbar = new Eht.Toolbar({selector:"#toolBar"});
	var taskbar = new Eht.Taskbar({selector:"#taskbar",position:"right"});
	var desktop = new Eht.Desktop({selector:"#desktop",enableDrag:true,labelField:"menuname"});
    var form = new Eht.Form({selector:"#form"});
	var me = new MenuService();
	desktop.setTaskbar(taskbar);
	desktop.addItemBefore(function(data){
		if(data.icon && data.icon.length>0){
			data.icon = data.icon.replace("window","desktop");
		}else{
			data.icon = "desktop-func-general";
		}
	});
	desktop.loadCompleteBefore(function(data){
		for(var i=data.length-1;i>=0;i--){
			if(!data[i].url || data[i].url==undefined || data[i].url==""){
				data.splice(i,1);
			}
		}
	});
    desktop.loadData(function(res){
    	me.findShortcut(res);
    });
	desktop.dblclick(function(data){
		var win = new Eht.Window({title:data.menuname,url:data.url,width:1100,iframe:true,remove:true,keep:true});
		win.setId(data.menucode);
		win.setIcon(data.icon.replace("desktop","window"));
		win.getIcon=function(){
			if(this.icon){
				return this.icon.replace("window","taskbar");
			}
		};
		taskbar.addWindow(win);
	});
	var sst = {menuname:"快捷方式",icon:"window-func-icon25",id:"K001"};
	var menu=new Eht.Menu({hasRight:true,width:300,cWidth:200,height:200,contextmenu:false,labelField:"menuname"});
	menu.addSnapshot(sst);
	menu.addSnapshot({menuname:"退出系统",icon:"window-func-exit",id:"exit"});
	menu.addSnapshot({menuname:"修改密码",icon:"window-modify-psw",id:"change"});
	var rightMenu=new Eht.Menu({selector:"#rightMenu",hasRight:false,width:170,height:200,contextmenu:true,title:"快捷菜单",labelField:"menuname"});
	var rightData=[{icon:"window-func-refresh",id:"rMenu",menuname:"刷新"},sst];
	rightMenu.loadData(rightData);
     //快捷菜单form树
	var menuTree=new Eht.Tree({selector:"#menuTree",labelField:"menuname",multable:true});
	
	menu.each(function(item){
		if(!(item.icon && item.icon.length>0)){
			item.icon = "window-func-general";
		}
	});
	menu.loadData(function(res){		
		me.findMenusByUser(res);
	});
	menuTree.loadData(function(res){
		me.findShortcutSetting(res);
	});
	
	taskbar.clickStart(function(e){
		 menu.show(e);
		 return false;
	});
	taskbar.drop(function(){
		desktop.resize();
	});
	var snap=new Eht.Window({
		selector:"#winMenu",
		width:400,height:600,
		resize:false,
		maxButton:false});
	var winPsw = new Eht.Window({selector:"#form",title:"修改密码",width:"300",height:"200",maxButton:false,modal:true,resize:false});						
	menu.clickItem(function(data){
		if(data.id=="exit"){
			var ls = new LoginService();
			ls.logout(new Eht.Responder({success:function(data){
				window.top.location.href = data.value;
			}}));
			return;
		}
		if(data.id=="change"){
			winPsw.open();
			form.clear();
			$("#errortips").html("");
			return;
		}
		if(data.id!="K001"){
			//系统功能菜单中的内容
			var win = new Eht.Window({title:data.menuname,url:data.url,width:1100,iframe:true,remove:true,keep:true});
			win.setId(data.menucode);
			win.setIcon(data.icon);
			win.getIcon=function(){
				if(this.icon){
					return this.icon.replace("window","taskbar");
				}
			};
			taskbar.addWindow(win);
		}else{
			//快捷方式
			snap.setId(data.id);
			snap.setIcon("taskbar-func-icon25");
			snap.setTitle("创建快捷菜单");
			taskbar.addWindow(snap);
		}
	});
	rightMenu.clickItem(function(data){
		if(data.id!="K001"){
			top.location.reload();
		}else{
			snap.setId(data.id);
			snap.setIcon("taskbar-func-icon25");
			snap.setTitle("创建快捷菜单");
			taskbar.addWindow(snap);
		}
	});
	toolbar.click(function(id){
		switch(id){
		case "psavebtn":
		var treeMenuData=menuTree.getSelectedData();
		var fundata=[];
		for(var i=0;i<treeMenuData.length;i++ ){
			if(treeMenuData[i].sysid){
				var a={"menuid":treeMenuData[i].sysid};		
					fundata.push(a);
			};
		}
		me.saveShortcut(fundata,
				new Eht.Responder({
					success : function() {
						new Eht.Tips().show("保存成功");
						desktop.reload();
					}
				})
		);
		break;
		}
	});
	
	
	
	
	
    $("#savebtn").click(function(){
	    var data = form.getData();
	    if(data.xmm!=data.xmmqr){
	        $("#errortips").html("新密码与新密码确认不相同，请重新输入");
	        return;
	    }
	    if(form.validate()){
	    	var ls = new LoginService();
			ls.modifyPsw(data.dqmm,data.xmm,
					new Eht.Responder({success:function(d){
						new Eht.Tips().show();
						winPsw.close();
					},
					error:function(request, textStatus, error){
						$("#errortips").html(request.responseText);
					}
				}));
	    }
	});
});



