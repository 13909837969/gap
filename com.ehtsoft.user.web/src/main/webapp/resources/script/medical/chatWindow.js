var chatWindow = $(window).load(function(){
	new Eht.Layout({center:"#msg-top",bottom:"#msg-bottom"});
	new Eht.Layout({center:{selector:"#msg-top-msg",title:"聊天内容"},bottom:{selector:"#msg-top-chat"}});
	
	var sso = new SSO();
	sso.async=false;
	var user = sso.getCurrentUser();
	
	var p = Eht.WindowManager.getParameter();
	
	//聊天信息监听ID
	var chatId = "HAP.CHAT";
	//聊天信息客户id
	var clientId = user.userid+"."+ p.toUserId;
	
	var amq = org.activemq.Amq;
	var chatListen = "queue://HAP.CHAT";
	
	$.fn.removeChat=function(){
		amq.removeListener(chatId, chatListen);
	};
	
	$(window).unload(function(){
		amq.removeListener(chatId, chatListen);
	});
	
	amq.init({uri:"amq",timeout: 45, clientId:clientId,logging:true,
		connectStatusHandler:function(status){
		},
		sessionInitializedCallback:function(){
			
			//取消当前监听
			amq.removeListener(chatId, chatListen);
			
			//添加监听
			amq.addListener(chatId,chatListen,
				function(message){
					handleMessage(message,false);
				},
				{selector:"sendTo = '"+ user.userid +"'" 
					+ " AND accept='"+p.toUserId+"'"
				});
		}
	});
	
	function handleMessage(message,self){
		var text = $(message).text();
		if(text!=""){
			text = text.replace(/#\$/g,'&');
			text = text.replace(/\$\*/g,'%');
			
			var container = $("<div></div>");
			var div = $("<div></div>");
			
			var user = $("<span>"+$(message).attr("username")+"<span>");
			user.attr("userid",$(message).attr("userid"));
			var time = $("<span>"+$(message).attr("date")+"</span>");
			
			container.append(div);
			if(self){
				container.addClass("chat-box1");
				div.addClass("chat-user1");
				div.append(time);
				div.append(user);
				user.css({"margin-left":"20px","display":"inline-block"});
				container.append("<div class='chat-box'><span class='chat-box-cor2'></span>"+text+"</div>");
			}else{
				container.addClass("chat-box2");
				container.css("text-align","left");
				div.addClass("chat-user2");
				div.append(user);
				div.append(time);
				time.css({"margin-left":"20px","display":"inline-block"});
				container.append("<div class='chat-box'><span class='chat-box-cor1'></span>"+text+"</div>");
			}
			$("#msg-top-msg").children().eq(0).append(container);
			$("#msg-top-msg").children().eq(0).append("<div style='clear: both;'></div>");
			$("#msg-top-msg").scrollTop($("#msg-top-msg").children().eq(0).height());
		}
	}
	
	$("#sendBtn").unbind("click").bind("click",function(){
		var text = $("#txtchat").val();
		text = text.replace(/</g, '#$lt;');//& 字符后台会当成参数来用，所以 将 & 替换成   #$
		text = text.replace(/>/g, '#$gt;');
		text = text.replace(/&/g, '#$');
		text = text.replace(/%/g,'$*');// % 传到后台不好用，替换成  $*
		//消息格式  <msg date='MM-dd hh:mm:ss' userid='' username=''></msg>
		var msg = "<msg date='"+new Date().format("MM-dd hh:mm:ss")+ "' " +
		  "userid='"+user.userid+"' "+
		  "username='"+user.name+"'"+
		  ">"+text+"</msg>";
		  var selectorMsg = msg + "&sendTo="+p.toUserId +"&accept="+user.userid;
		  amq.sendMessage("queue://HAP.MSG" , selectorMsg);
		  amq.sendMessage("queue://HAP.CHAT", selectorMsg);
		  handleMessage(msg,true);
	});
	
});