/**
 * @param opt
 * @returns {Eht.Window}
 * @author wangbao
 */
Eht.Window=function(opt){
	var def = {
		selector:null,
		width:850,
		height:700,
		title:null,
		iframe:false,
		url:null,
		remove:false,
		minButton:false,
		maxButton:true,
		refreshButton:true,
		keep:false,
		resize:true,
		modal:false,
		duration:400,
		parentContainer:null
	};
	this.opt = $.extend(def,opt);
	this.closed = true;
	this.manager = false;
	this.windowManager = null;
	this.status="nomal"; //min,nomal,max  窗口状态
	this.modalDiv = $("<div class='eht-window-modal'></div>");
	this.init();
};
Eht.Window.prototype.init=function(){
	var win = this;
	this.id = Eht.Utils.createUuid();
	this.iframe = $('<iframe marginheight="100%" marginwidth="100%" frameborder="0" style="background:#fff;"></iframe>');
	this.ajaxKeep = false;
	this.selectorParent = $("<div></div>");
	if(this.opt.selector==null){
		this.selector = $("<div></div>");
		if(this.opt.iframe){
			this.selector.append(this.iframe);
		}
	}else{
		this.selector = $(this.opt.selector);
	}
	this.selectorParent.addClass("eht-window-body");
	this.selectorParent.css("position","absolute");
	this.selector.addClass("eht-window-selector");
	this.selectorParent.append(this.selector);
	this.container = $('<div class="eht-base eht-window eht-window-active" style="position:fixed;"></div>');
	this.container.width(0);
	this.container.height(0);
	
	this.container.css("top",$(window).height()/2);
	this.container.css("left",$(window).width()/2);
	
	this.container.hide();
	this.title = $("<div class='eht-window-title eht-window-title-active'><span id='window-icon' title='双击关闭' style='float:left;margin-top:3px;'><div style='display:inline-block;width:18px;height:18px;'></div></span><span id='window-title' style='float:left;margin-top:3px;'></span>"+
			"<span style='float:right;position:absolute;right:2px;'>" +
			"<a id='eht_window_refresh' class='eht-window-button eht-window-refresh-btn'></a>"+
			"<a id='eht_window_min' class='eht-window-button eht-window-min-btn'></a>"+
			"<a id='eht_window_nomal' class='eht-window-button eht-window-max-btn'></a>"+
			"<a id='eht_window_close' class='eht-window-button eht-window-close-btn'></a></span>" +
	        "</div>");
	this.title.find("#window-title").html(this.opt.title);
	if(this.opt.refreshButton==false){
		this.title.find("#eht_window_refresh").hide();
	}
	if(this.opt.minButton==false){
		this.title.find("#eht_window_min").hide();
	}else{
		this.title.find("#eht_window_min").css("display","inline-block");
	}
	if(this.opt.maxButton==false){
		this.title.find("#eht_window_nomal").hide();
	}else{
		this.title.find("#eht_window_nomal").css("display","inline-block");
	}
	if(this.opt.parentContainer!=null){
		$(this.opt.parentContainer).append(this.container);
	}else{
		$(document.body).append(this.container);
	}
	this.container.append(this.title);
	this.container.append(this.selectorParent);
	
	Eht.Utils.unselect(this.title);
	
	this.container.click(function(e){
		if(win._active){
			win._active(e);
		}
	});
	this.title.find("#eht_window_refresh").unbind("click").bind("click",function(e){
		if(win.iframe){
			var iurl = win.iframe.attr("src");
			win.iframe.attr("src",iurl);
		}
		if(win._refresh){
			win._refresh();
		}
	});
	this.title.find("#eht_window_min").unbind("click").bind("click",function(e){
		win.minBeforeLeft = win.container.offset().left;
		win.minBeforeTop = win.container.offset().top;
		win.minBeforeWidth = win.container.width();
		win.minBeforeHeight = win.container.height();
		if(win._clickMin){
			win._clickMin();
		}
		e.stopPropagation();
		return false;
	});
	if(this.opt.resize==true){
		this.title.unbind("dblclick").bind("dblclick",function(){
			win.title.find("#eht_window_nomal").click();
		});
	}else{
		this.title.unbind("dblclick");
	}
	this.computeRect=function(){
		win.initPosition={top:win.container.position().top,left:win.container.position().left};
		if(win._getMaxRect){
			var rect = win._getMaxRect();
			win.container.height(rect.height?rect.height:$(window).height()-2);
			win.container.width(rect.width?rect.width:$(window).width());
			win.container.css({position:"absolute",left:(rect.left?rect.left:0),top:(rect.top?rect.top:0)});
			win.left = win.container.position().left;
			win.top = win.container.position().top;
			win.width = win.container.width();
			win.height = win.container.height();
		}else{
			win.container.height($(window).height()-2);
			win.container.width($(window).width());
			win.container.css({position:"absolute",left:0,top:0});
			win.left = win.container.position().left;
			win.top = win.container.position().top;
			win.width = win.container.width();
			win.height = win.container.height();
		}
	};
	this.title.find("#eht_window_nomal").unbind("click").bind("click",function(e){
		if(win.status=="nomal"){
			$(this).removeClass("eht-window-max-btn").addClass("eht-window-nomal-btn");
			win.computeRect();
			win.status = "max";
			$(document.body).css({"overflow":"hidden","margin":"0px"});
			win.resize();
		}else{
			$(this).removeClass("eht-window-nomal-btn").addClass("eht-window-max-btn");
			win.container.height(win.opt.height);
			win.container.width(win.opt.width);
			win.container.css(win.initPosition);
			win.resize();
			win.status = "nomal";
			
			win.left = win.initPosition.left;
			win.top = win.initPosition.top;
			win.width = win.opt.width;
			win.height = win.opt.height;
		}
		if(win._resize && $.isFunction(win._resize)){
			win._resize();
		}
		win.minBeforeLeft = win.container.offset().left;
		win.minBeforeTop = win.container.offset().top;
		win.minBeforeWidth = win.container.width();
		win.minBeforeHeight = win.container.height();
		e.stopPropagation();
		return false;
	});
	this.title.find("#eht_window_close").unbind("click").bind("click",function(e){
		if(win._closeBefore){
			if(win._closeBefore()==true){
				win.close();
			}
		}else{
			win.close();
		}
		e.stopPropagation();
		return false;
	});
	this.title.find("#window-icon").unbind("dblclick").bind("dblclick",function(){
		win.title.find("#eht_window_close").click();
		return false;
	});
	this.mark=$("<div></div>");
	this.container.dropAndDrag({selector:this.title,zeroDrag:false,
		start:function(e){
			if(win._active){
				win._active(e);
			}
			win.container.append(win.mark);
			win.mark.css({"position":"absolute",top:win.title.height()+4,left:win.title.position().left+3});
			win.mark.height(win.selector.height()+3);
			win.mark.width(win.selector.width()+3);
			win.mark.css({"background":"#aaa",filter:"alpha(opacity=40)","-moz-opacity":"0.4","opacity":0.4});
			win.mark.css("zindex","2000");
		},
		drop:function(e){
			win.mark.remove();
		}
	});
	
	this.container.unbind("mousedown").bind("mousedown",function(e){
		if(e.which==3){
			return false;
		}
		return true;
	});
	this.container.unbind("contextmenu").bind("contextmenu",function(){
		return true;
	});
	var sw=$("<div style='position: absolute;bottom: 0px;left: 0px;width: 5px;height: 5px;overflow: hidden;cursor: sw-resize;'></div>");
	var se=$("<div style='position: absolute;bottom: 0px;right: 0px;width: 5px;height: 5px;overflow: hidden;cursor: se-resize;'></div>");
	this.container.append(sw);
	this.container.append(se);
	
	sw.unbind("mousedown").bind("mousedown",function(e1){
		win.container.append(win.mark);
		win.mark.css({"position":"absolute",top:win.title.height()+4,left:win.title.position().left+5});
		win.mark.height(win.container.height()-win.title.height()-12);
		var x = e1.clientX;
		var y = e1.clientY;
		var w = win.container.width();
		var h = win.container.height();
		var l = win.container.offset().left;
		$(document).unbind("mousemove").bind("mousemove",function(e2){
			win.container.height(h + (e2.clientY-y));
			win.container.width(w - (e2.clientX-x));
			win.mark.width(win.container.width()-12);
			win.mark.height(win.container.height()-win.title.height()-12);
			win.container.css({"left":l + (e2.clientX-x)});
			win.resize();
		});
	});
	se.unbind("mousedown").bind("mousedown",function(e1){
		win.container.append(win.mark);
		win.mark.css({"position":"absolute",top:win.title.height()+4,left:win.title.position().left+5});
		win.mark.height(win.container.height()-win.title.height()-12);
		var x = e1.clientX;
		var y = e1.clientY;
		var w = win.container.width();
		var h = win.container.height();
		$(document).unbind("mousemove").bind("mousemove",function(e2){
			win.container.height(h + (e2.clientY-y));
			win.container.width(w + (e2.clientX-x));
			win.mark.width(win.container.width()-12);
			win.mark.height(win.container.height()-win.title.height()-12);
			win.resize();
		});
	});
	se.unbind("mouseup").bind("mouseup",function(e1){
		$(document).unbind("mousemove");
		win.mark.remove();
	});
	sw.unbind("mouseup").bind("mouseup",function(e1){
		$(document).unbind("mousemove");
		win.mark.remove();
	});
	$(document).unbind("mousemove").bind("mousemove",function(){
		$(document).unbind("mousemove");
		win.mark.remove();
	});
};
Eht.Window.prototype.active=function(func){
	this._active=func;
};
/**
 * resize 方法，同时也是 resize 事件，参数为 function
 */
Eht.Window.prototype.resize=function(){
	this.selectorParent.height(this.container.height()-this.title.outerHeight(true)-Eht.Utils.getMPBHeight(this.selectorParent));
	this.selectorParent.width(this.container.width()-Eht.Utils.getMPBWidth(this.selectorParent));
	this.selector.height(this.container.height()-this.title.outerHeight(true)-Eht.Utils.getMPBHeight(this.selector) - Eht.Utils.getMPBHeight(this.selectorParent));
	this.selector.width(this.container.width() - Eht.Utils.getMPBWidth(this.selector) - Eht.Utils.getMPBHeight(this.selectorParent) - 2);
	if(this.selector.children().size()==1){
		var sc = this.selector.children().eq(0);
		sc.height(this.selector.height() - Eht.Utils.getMPBHeight(sc));
		sc.width(this.selector.width() - Eht.Utils.getMPBWidth(sc));
	}
	if(this._resize==null){
		this._resize=(arguments.length==1?arguments[0]:null);
	}
};
Eht.Window.prototype.setUrl=function(url){
	this.opt.url = url;
};
Eht.Window.prototype.open=function(){
	if(this.opt.width>$(window).width()){
		this.opt.width = $(window).width() - 10;
	}
	if(this.opt.height>$(window).height()){
		this.opt.height = $(window).height() - 10;
	}
	var win = this;
	if(this.opt.remove==true){
		if(this.manager==false){
			this.container.remove();
			this.init();
		}
	}
	if(this.opt.modal==true){
		$(document.body).append(this.modalDiv);
		if($(document).height()>$(window).height()){
			this.modalDiv.css("height",$(document).height()+2);
		}
		$(document.body).css("overflow","hidden");
		this.container.css("z-index",parseInt(this.modalDiv.css("z-index"))+300);
	}
	this.container.attr("windowId",this.id);
	this.iframe.attr("windowId",this.id);
	if(this.closed==true){
		//if(win.status != "max"){
			this.left = ($(window).width()-this.opt.width)/2;
			this.top = ($(window).height()-this.opt.height)/2;// + $(document.body).scrollTop() - 20;
			this.width = this.opt.width;
			this.height = this.opt.height;
		//}
		if(this.top<0){
			this.top=0;
		}
		if(this.manager==true){
			var mwin = null;
			if(this.windowManager.windows.length > 1){
				mwin = this.windowManager.windows[this.windowManager.windows.length-2];
			}
			if(mwin==null){
				this.left = ($(window).width()-this.opt.width)/4;
				this.top = ($(window).height()-this.opt.height)/3;
				if(this.top<0){
					this.top=0;
				}
			}else{
				if(mwin.left!=null){
					this.left = mwin.left + 20;
				}
				if(mwin.top!=null){
					this.top = mwin.top + 20;
				}
			}
		}
//		this.container.css({"left":this.left,"top":this.top});
		if(this.opt.height>$(window).height()){
			this.opt.height=$(window).height();
		}
		if(this.opt.width>$(window).width()){
			this.opt.width=$(window).width();
		}
	}
	if(this._openBefore){
		this._openBefore();
	}
	this.container.show();
	this.selector.show();
	var styles={top:this.top,left:this.left,width:this.width,height:this.height};
	if(win.opt.iframe){
		win.container.append(win.mark);
		win.mark.css({"position":"absolute",top:win.title.height()+4,left:win.title.position().left+3});
	}
	if(this._openAnimateOption){
		styles = this._openAnimateOption;
	}
	this.container.animate(styles,{duration:win.opt.duration,progress:function(){
		win.resize();				
		win.mark.height(win.selector.height());
		win.mark.width(win.selector.width());
		win.mark.css({"background":"#aaa",filter:"alpha(opacity=40)","-moz-opacity":"0.4","opacity":0.4});
		win.mark.css("zindex","2000");
	    },
		complete:function(){
		win.resize();	
		if(win.iframe.attr("src")){
			win.mark.remove();
		}
		if(win.opt.url!=null){
			var url = win.opt.url;
			if(win.param!=undefined){
				if(url.search("\\?")!=-1){
					if(url.search("token")==-1){
						url = url + "&param=" + encodeURIComponent(JSON.stringify(win.param))+"&token="+Eht.WindowManager.getToken(); 
					}else{
						url = url + "&param=" + encodeURIComponent(JSON.stringify(win.param));
					}
				}else{
					if(url.search("token")==-1){
						url = url + "?param=" + encodeURIComponent(JSON.stringify(win.param))+"&token="+Eht.WindowManager.getToken();
					}else{
						url = url + "?param=" + encodeURIComponent(JSON.stringify(win.param));
					}
				}
			}
			if(win.opt.selector==null){
				if(win.opt.iframe){
					if(win.opt.keep==true){
						if(win.iframe.attr("src")!=url){
							win.iframe.attr("src",url);
						}
					}else{
						win.iframe.attr("src",url);
					}
					if(win._openComplete){
						win._openComplete();
					}
				}else{
					if(win.ajaxKeep==false){
						jQuery.ajax({				
							type: 		"GET",
							url:  		url,
							dataType: 	"html",
							async: 		true,
							complete : function(res, status) {
								win.selector.html(res.responseText);
								if(win.opt.keep==true){
									win.ajaxKeep = true;
								}
								if(win._openComplete){
									win._openComplete();
								}
							}					
						});
						//win.selector.load(url + " #container");
						//debugger;
					}
				}
			}else{
				if(win._openComplete){
					win._openComplete();
				}
			}
		}else{
			if(win._openComplete){
				win._openComplete();
			}
		}
	}});
	this.closed = false;
	
	if(this._resize && $.isFunction(this._resize)){
		this._resize();
	}
	if(this._active){//活动状态
		this._active();
	}
	
	this.iframe.load(function(){
		try{
			$(this).contents().click(function(){
				if(win._active){
					win._active();
				}
			});
		}catch(e){
			if(e.code!=18){
				var a = new Eht.Alert({title:"错误信息",message:"应用停止服务或网络中断！"});
				a.clickOk(function(){
					win.close();
				});
			}
		};
		win.mark.remove();
	});
};
Eht.Window.prototype.openBefore=function(func){
	this._openBefore = func;
};
Eht.Window.prototype.openComplete=function(func){
	this._openComplete = func;
};
Eht.Window.prototype.closeBefore=function(func){
	//func()  return boolean true 表示可以关闭window 否则 不可以关闭 window
	this._closeBefore = func;
};
Eht.Window.prototype.close=function(){
	var win = this;
	//$(document.body).css("overflow","");
	var styles = {width:0,height:0,top:$(window).height()/2,left:$(window).width()/2};
	if(this._closeAnimateOption){
		styles = this._closeAnimateOption;
	}
	if(this.opt.remove==true){
		this.container.animate(styles,
				{duration:win.opt.duration,complete:function(){			
				win.container.remove();
		}});
	}else{
		this.container.animate(styles,
				{duration:win.opt.duration,complete:function(){			
				win.container.hide();
				$(document.body).css("overflow","");
		}});
		this.closed = true;
	}
	if(this.windowManager && this.windowManager.windows){
		for(var i=this.windowManager.windows.length-1;i>=0;i--){
			if(this.id==this.windowManager.windows[i].id){
				this.windowManager.windows.splice(i,1);
			}
		}
	}
	this.modalDiv.remove();
};
Eht.Window.prototype.setParameter=function(param){
	this.param = param;
	if(param!=null){
		this.iframe.attr("param",encodeURIComponent(JSON.stringify(param)));
	}
};
Eht.Window.prototype.getParameter=function(){
	return this.param;
};
Eht.Window.prototype.clearParameter=function(){
	this.param = null;
	this.iframe.removeAttr("param");
};
Eht.Window.prototype.setTitle=function(title){
	this.opt.title = title;
	this.title.find("#window-title").html(this.opt.title);
};
Eht.Window.prototype.setId=function(id){
	this.id = id;
};
Eht.Window.prototype.getId=function(){
	return this.id;
};
Eht.Window.prototype.getMaxRect=function(func){
	/*func(){
	   return {width:_width,height:_height,left:0,top:0}
	 }*/
	this._getMaxRect = func;
};
Eht.Window.prototype.showButton=function(button){
	//min,max,close 按钮
	if(button=="min"){
		this.opt.minButton=true;
		this.title.find("#eht_window_min").css("display","inline-block");
	}
	if(button=="max"){
		this.title.find("#eht_window_nomal").css("display","inline-block");
	}
	if(button=="close"){
		this.title.find("#eht_window_close").css("display","inline-block");
	}
};
Eht.Window.prototype.setIcon=function(iconClass){
	this.icon = iconClass;
	if(this.icon){
		this.title.find("#window-icon").removeClass().addClass(this.icon);
		this.title.find("#window-icon").show();
		this.title.find("#window-title").css("margin-left","5px");
	}else{
		this.title.find("#window-title").css("margin-left","10px");
	}
};
Eht.Window.prototype.getIcon=function(){
	return this.icon;
};

Eht.Window.prototype.clickMin=function(func){
	if(func){
		this._clickMin=func;
	}else{
		if(this._clickMin){
			this._clickMin();
		}
	}
};
Eht.Window.prototype.openAnimateOption=function(option){
	this._openAnimateOption = option;
};
Eht.Window.prototype.closeAnimateOption=function(option){
	this._closeAnimateOption = option;
};
Eht.Window.prototype.refresh=function(func){
	this._refresh = func;
}