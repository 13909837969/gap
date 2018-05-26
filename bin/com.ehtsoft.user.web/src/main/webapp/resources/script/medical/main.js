/**
 * 《登陆成功页面main1》页面的JS文件
 * @author 王宝
 * @since 2014-04-28
 * @version 1.0
 */
var common = $(function($){
	var sso = new SSO();
	sso.async=false;
	var user = sso.getUser();
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
			if(data[i].disable || data[i].dis){
				data.splice(i,1);
			}
		}
	});
    desktop.loadData(function(res){
    	me.findShortcut(false,res);
    });
	desktop.dblclick(function(data){
		var win = new Eht.Window({title:data.menuname,url:data.url,width:1200,iframe:true,remove:true,keep:true});
		win.setId(data.menucode);
		win.setIcon(data.icon.replace("desktop","window"));
		win.getIcon=function(){
			if(this.icon){
				return this.icon.replace("window","taskbar");
			}
		};
		if(data.ids){
			//win.setParameter({"ids":data.ids});
			win.setParameter({"menucode":data.menucode});
		}
		taskbar.addWindow(win);
	});
	var sst = {menuname:"快捷方式",icon:"window-func-icon25",id:"K001"};
	var tit = $("#corgname").val() + ($("#corgcode").val()!=""?" ["+$("#corgcode").val()+"] - ":"") + $("#cname").val();
	var menu=new Eht.Menu({hasRight:true,width:300,cWidth:200,height:200,contextmenu:false,labelField:"menuname",title:tit});
	menu.addSnapshot(sst);
	menu.addSnapshot({menuname:"退出系统",icon:"window-func-exit",id:"exit"});
	menu.addSnapshot({menuname:"修改密码",icon:"window-modify-psw",id:"change"});
	var rightMenu=new Eht.Menu({selector:"#rightMenu",hasRight:false,width:170,height:200,contextmenu:true,title:"快捷菜单",labelField:"menuname"});
	var rightData=[{icon:"window-func-refresh",id:"rMenu",menuname:"刷新"},sst];
	rightMenu.loadData(rightData);
     //快捷菜单form树
	var menuTree=new Eht.Tree({selector:"#menuTree",labelField:"menuname",multable:true});
	/**
	 * 替换图标（没有图标时，采用默认图标)
	 */
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
	/**
	 * 打开开始菜单
	 */
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
	/**
	 * 开始菜单
	 */
	menu.clickItem(function(data){
		if(data.id=="exit"){
			var ls = new LoginService();
			ls.logout(new Eht.Responder({success:function(data){
				removeChatListen();
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
			var win = new Eht.Window({title:data.menuname,url:data.url,width:1200,iframe:true,remove:true,keep:true});
			win.setId(data.menucode);
			win.setIcon(data.icon);
			win.getIcon=function(){
				if(this.icon){
					return this.icon.replace("window","taskbar");
				}
			};
			
			/**
			 * 通过开始菜单项目，打开window
			 */
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
	/**
	 * 设置快捷方式保存功能
	 */
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
	
	$.fn.refresh=function(){
		desktop.refresh();
		menuTree.refresh();
		menu.refresh();
	};
	
	/**
	 * 密码修改
	 */
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
    

	/////////////////////////////// 消息及聊天代码部分 ////////////////////////////////////////
    /** 聊天人员管理窗口及打开窗口事件 **/
    /***** 任务栏中的工具栏 *****/
	var tasktoolbar = new Eht.Toolbar({selector:"#task-toolbar"});
	taskbar.addToolbar($("#task-toolbar"));
	/*消息人员管理窗口*/
	var msgWin = new Eht.Window({selector:"#messageWindow",
							keep:true,parentContainer:"#desktop",
							remove:false,title:user.name+" 通信窗口",
							width:230,height:500,resize:false,
							maxButton:false});
	
	taskbar.windowsManager.add(msgWin);
	msgWin.openBefore(function(){
		this.container.css("z-index",4000);
		this.container.css("top",30);
		this.container.css("left","");
		this.container.css("bottom","");
		this.container.css("right",20);
		this.container.width(this.opt.width,this.opt.height);
	});
	msgWin.openAnimateOption({height:msgWin.opt.height});
	/*打开人员消息管理窗口*/
	tasktoolbar.click(function(id){
		if(id=="msg"){
			/** 点击 消息图标，打开消息人员管理框
			var array = this.extradata("msg");
			if(array!=null && $.isArray(array)){
				var data = array.pop();
				if(data!=null){
					common.openChatWindow(data.userid,data.username);
					if(array.length==0){
						this.setIcon("msg", "eht-talk-icon");
						this.setTips("msg","");
					}else{
						this.setTips("msg",array[array.length-1].text);
					}
				}else{
					msgWin.open();
				}
			}else{
				msgWin.open();
			}
			*/
			$("#message-tips").empty();
			scantips("0");
			tipsWin.open();
		}
	});

	
	/*上线等提醒框*/
	var tipsWin = new Eht.Window({iframe:false,selector:"#winMessage",maxButton:false,
		resize:false,title:'<div id="message-option"><div class="mes-opt-active" flag="0">未读</div><div class="mes-opt-bg" flag="1">已读</div></div>',
		width:300,height:200,parentContainer:"#desktop"});
	tipsWin.datalength=0;
    /** 消息提示窗口 **/
   // taskbar.windowsManager.add(tipsWin);
	tipsWin.openBefore(function(){
		this.container.css("z-index",4000);
		this.container.css("top","");
		this.container.css("left","");
		this.container.css("bottom",0);
		this.container.css("right",0);
	});
	tipsWin.openAnimateOption({bottom:0,right:0,width:tipsWin.opt.width,height:tipsWin.opt.height});
	tipsWin.closeAnimateOption({bottom:0,right:0,width:0,height:0});
	
	var flag = "0";
	tipsWin.closeBefore(function(){
		flag = "0";
		$("#message-option div").removeClass("mes-opt-active");
		$("#message-option div").eq(0).addClass("mes-opt-active");
		return true;
	});
	/** 点击 **/
	$("#message-option div").click(function(){
		flag = $(this).attr("flag");
		scantips(flag);
		$("#message-option div").removeClass("mes-opt-active");
		$(this).addClass("mes-opt-active");
	});
	function scantips(flag){
		var msgSrv = new MessageService();
		msgSrv.find(flag,new Eht.Responder({success:function(data){
			$("#message-tips").empty();
			for(var i=0;i<data.length;i++){
				var cdiv = $("<div style='padding:5px;border-bottom:1px solid #ddd;'></div>");
				var tit = $("<div>"+(i+1)+".<a href='javascript:void(0)' "+(flag=="1"?"style='color:#333;'":"")+">"+data[i].content+"</a></div>");
				tit.data(data[i]);
				var from = "<div><div style='width:150px;float:right;'>发送人："+data[i].from_username+"</div></div>";
				var cts = "<div><div style='width:150px;float:right;'>日期："+(data[i].cts+"").replace(/\.\d+/g,"")+"</div></div>";
				cdiv.append(tit,from,cts,"<div style='clear:both;'></div>");
				$("#message-tips").append(cdiv);
				//打开window
				tit.unbind("click").bind("click",function(){
					var d = $(this).data();
					var win = new Eht.Window({title:d.title,url:d.url,width:1000,iframe:true,remove:true,keep:true});
					win.tipData = d;
					win.setId(d.sysid);
					win.setIcon("window-func-general");
					win.getIcon=function(){
						if(this.icon){
							return this.icon.replace("window","taskbar");
						}
					};
					win.openComplete(function(){
						//标记为 已读
						msgSrv.update(this.tipData);
					});
					taskbar.addWindow(win);
				});
			}
			if(data.length==0){
				if(flag=="0"){
					$("#message-tips").html("没有需要做业务");
				}else{
					$("#message-tips").html("没有已读的信息");
				}
				tipsWin.datalength = data.length;
			}
			if(data.length>0 && data.length!=tipsWin.datalength){
				tipsWin.datalength = data.length;
				tipsWin.open();
			}
		},error:function(){}}));
	}
	/** 消息提醒服务 */
//	setInterval(function(){scantips(flag)},6000);
//	scantips(flag);
	
	
    /** 人员聊天窗口 **/
	/*
	 * var thandle = null;
    $.fn.openChatWindow=function(id,name){
    	
    	var wmsg = taskbar.windowsManager.getWindowById(id);
    	if(wmsg==null){
    		wmsg=new Eht.Window({iframe:true,url:"chatWindow.jsp",
    			keep:true,remove:false,resize:false,maxButton:false,
			    width:600,height:420,
			    title:"正与["+name+"]交谈"});
    		wmsg.setId(id);
    		wmsg.setParameter({toUserId:id});
    	}
    	taskbar.windowsManager.add(wmsg);
		
		wmsg.open();
    };
    */
    /**接受登录消息信息并打开提示框**/
    /*
    $.fn.receiveMsg=function(message,flag){
    	if(flag=="chat"){
    		//聊天信息提醒
    		tasktoolbar.setIcon("msg", "taskbar-icon-message-tips");
    		var userid = $(message).attr("userid");
    		var username = $(message).attr("username");
    		var text = $(message).text();
    		var edata = tasktoolbar.extradata("msg");
    		if(edata!=null && $.isArray(edata)){
    			//一个人的聊天多个聊天消息提醒只提醒一次
    			if(!isExists(edata,userid)){
    				//将接受的消息放入到数组中，用于信息的排队（点击提示的消息菜单是根据消息提醒打开不同的聊天对话框
    				edata.push({userid:userid,username:username,text:text});
    			}
    		}else{
    			edata = new Array();
    			edata.push({userid:userid,username:username,text:text});
    		}
    		//设置人员的消息提示信息
    		tasktoolbar.extradata("msg", edata);
    		tasktoolbar.setTips("msg", text);
    		try{
    			window.focus();
    		}catch(e){
    		}
    	}else{//登录信息提醒
	    	var div = $("<div></div>");
			var time = $("<div>"+$(message).attr("date")+"</div>");
			div.append(time);
			var user = $("<a href='javascript:void(0)'>"+$(message).attr("username")+"</a>");
			user.attr("userid",$(message).attr("userid"));
			div.append(user);
			div.append("<span>&nbsp;"+$(message).text()+"</span>");
			$("#message-tips").append(div);
			tipsWin.open();
			$("#winMessage").scrollTop($("#message-tips").height());
			user.unbind("click").bind("click",function(){
				common.openChatWindow(user.attr("userid"),$(this).text());
			});
			if(thandle!=null){
				clearTimeout(thandle);
			}
    	}
    };
    function isExists(array,userid){
    	var rtn = false;
    	for(var i=0;i<array.length;i++){
    		if(array[i].userid==userid){
    			rtn = true;
    			break;
    		}
    	}
    	return rtn;
    }
    */
    //////////////////////////\\/////////////////////////////

    $(window).unload(function(){
    	removeChatListen();
    });
    function removeChatListen(){
    	for(var i=0;i<window.frames.length;i++){
    		if(window.frames[i].chatWindow && window.frames[i].chatWindow.removeChat){
    			window.frames[i].chatWindow.removeChat();
    		}
    	}
    }
});


