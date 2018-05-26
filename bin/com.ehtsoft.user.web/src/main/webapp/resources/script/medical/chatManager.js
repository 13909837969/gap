var chatWindow = $(function($){
	new Eht.Layout({center:{selector:"#right",title:"聊天对象",titleSelector:"#right-title"}});
	//新政区划tree
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname"});
	var ws =new WebCommunicationService();
	//tree载入数据
	//树加载数据
	tree.loadData(function(res){
		ws.getTree($("#benyuan").get(0).checked,res);
	});
	$("#benyuan").change(function(){
		tree.refresh();
	});
	
	var sso = new SSO();
	sso.async=false;
	var user = sso.getCurrentUser();
	
	tree.eachLeafIcon(function(data){
		var rtn = null;
		if(data.parentid){
			rtn = "tree-icon-unline";
			if(data.status=="1"){
				rtn="tree-icon-online";
			}
			if(data.sysid==user.userid){
				rtn="tree-icon-online";
			}
		}
		return rtn;
	});
	tree.dblclickRow(function(data){
		parent.common.openChatWindow(data.sysid,data.orgname);
	});
	
	var sso = new SSO();
	sso.async=false;
	var user = sso.getCurrentUser();
	
	
	var amq = org.activemq.Amq;
	var chatId = "HAP.CHAT";
	amq.init({uri:"amq?online=online",timeout: 45,clientId:user.userid,
		connectStatusHandler:function(status){
		},
		sessionInitializedCallback:function(){
	    	var msg = "<msg date='"+new Date().format("MM-dd hh:mm:ss")+ "' " +
			  		"userid='"+user.userid+"' "+
			  		"username='机构 "+user.unitName+" 用户 "+user.accountId+"'"+
			        "> 从 IP "+user.ipAddr+" 上线</msg>";
	    	
	    	//登录消息提醒（广播方式）监听
	    	amq.addListener("HAP.MSG","topic://HAP.MSG",function(message){
	    		//登录提示的消息 发送到父页面的 receiveMsg 方法，来打开提示框
	    		parent.common.receiveMsg(message);
	    	},
	    	{selector:"online='online'"}
	    	);
	    	//上线消息提醒格式  <msg date='MM-dd hh:mm:ss' userid='' username=''></msg>
	    	amq.sendMessage("topic://HAP.MSG",msg);
	    	
	    	/** 聊天提示对话监听 **/
	    	//取消当前监听
	    	amq.removeListener(chatId, "queue://HAP.MSG");
	    	amq.addListener(chatId,"queue://HAP.MSG",
				function(message){
					parent.common.receiveMsg(message,"chat");
				},
				{selector:"sendTo = '"+ user.userid +"'"});
		}});

	/**\\**/
	
	
	$.fn.removeChat=function(){
		amq.removeListener(chatId, "queue://HAP.MSG");
	};
	$(window).unload(function(){
		amq.removeListener(chatId, "queue://HAP.MSG");
	});
});