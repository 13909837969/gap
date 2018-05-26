/**
 * 桌面人任务栏
 * @param opt
 * @author wangbao
 * @returns {Eht.Taskbar}
 */
Eht.Taskbar = function(opt){
	var taskbar = this;
	var def = {selector:null,
			   childHeight:40,
			   childWidth:50,
			   position:"bottom",// bottom,top,left,right
			   duration:500
			  };
	this.opt = $.extend(def,opt);
	this.windowsManager = new Eht.WindowManager();
	this.selector=$(this.opt.selector);
	this.selector.addClass("eht-taskbar");
	this.startbar = $("<div class='eht-taskbar-base eht-taskbar-startbg'><div id='taskbar-start-button' class=''><div class='eht-taskbar-start-icon'></div></div></div>");
	this.contbar = $("<div class='eht-taskbar-base eht-taskbar-contbar'></div>");
	this.iconbar = $("<div class='eht-taskbar-base eht-taskbar-iconbar'></div>");
	this.selector.unselect();
	this.startbar.unselect();
	this.contbar.unselect();
	this.iconbar.unselect();
	
	this.selector.append(this.startbar);
	this.selector.append(this.contbar);
	this.selector.append(this.iconbar);
	$(document.body).css("overflow","hidden");
	this.setPosition(this.opt.position);
	
	this.startbar.find("#taskbar-start-button").width(this.opt.childWidth);
	this.startbar.find("#taskbar-start-button").height(this.opt.childHeight);
	this.startbar.find("#taskbar-start-button").unbind("click").bind("click",function(e){
		if(taskbar._clickStart){
			taskbar._clickStart(e);
		}
		e.stopPropagation();
		return false;
	});
	var temp = $("<div style='display:none;position:absolute;border:1px solid #888;z-index:3900;'></div>");
	temp.css({"background":"#aaa",filter:"alpha(opacity=40)","-moz-opacity":"0.4","opacity":0.4});
	this.selector.unbind("mousedown").bind("mousedown",function(){
		//$(document.body).data(taskbar);
		$(document.body).append(temp);
		temp.hide();
		
		$(document.body).mousemove(function(e){
			$(this).unselect();
			var psn = "bottom";
			var flag = false;
			if(e.clientY < 200){
				temp.show();
				temp.height(taskbar.opt.childHeight);
				temp.width($(window).width());
				temp.css({top:"0px",bottom:"",left:"",right:""});
				psn = "top";
				flag = true;
			}
			if(e.clientY > $(window).height() - 100){
				temp.show();
				temp.height(taskbar.opt.childHeight);
				temp.width($(window).width());
				temp.css({top:"",bottom:"0px",left:"",right:""});
				psn = "bottom";
				flag = true;
			}
			if(e.clientX < 100 && e.clientY < $(window).height() - 50 && e.clientY>50){
				temp.show();
				temp.width(taskbar.opt.childWidth);
				temp.height($(window).height());
				temp.css({top:"0px",bottom:"0px",left:"0px",right:""});
				
				psn = "left";
				flag = true;
			}
			if(e.clientX > $(window).width() - 100){
				temp.show();
				temp.width(taskbar.opt.childWidth);
				temp.height($(window).height());
				temp.css({top:"0px",bottom:"0px",left:"",right:"0px"});
				psn = "right";
				flag = true;
			}
			if(flag){
				$(this).unbind("mouseup").bind("mouseup",function(e){
					taskbar.setPosition(psn);
					temp.remove();
					$(this).unbind("mouseup");
					$(this).unbind("mousemove");
					
					for(var i=0;i<taskbar.windowsManager.windows.length;i++){
						if(taskbar.windowsManager.windows[i].status == "max"){
							taskbar.windowsManager.windows[i].container.css(taskbar.maxrect());
							taskbar.windowsManager.windows[i].resize();
							break;
						}
					}
					
					if(taskbar._drop){
						taskbar._drop();
					}
					e.stopPropagation();
					return false;
				});
			}
		});
	});
	this.selector.unbind("mouseup").bind("mouseup",function(){
		temp.remove();
		//$(document.body).unbind("mouseup");
		$(document.body).unbind("mousemove");
		//return false;
	});
	$(window).resize(function(){
		taskbar.resize();
	});
};
Eht.Taskbar.prototype.setPosition=function(position){
	var taskbar = this;
	if(position){
		this.opt.position = position;
	}
	if(this.opt.position=="bottom"||this.opt.position=="top"){
		clearCss();
		this.contbar.find(".child-task").css({"display":"inline-block","margin":"1px 2px","float":"left"});
		this.selector.css(this.opt.position,"0px");
		this.selector.width($(window).width());
		this.selector.height(taskbar.opt.childHeight + 3);
		this.startbar.css({"left":"0px","border-right":"1px solid #4f7ca9","display":"inline-block","padding":"0 0 0 5px;"});
		this.startbar.height(taskbar.opt.childHeight + 2);
		this.startbar.width(taskbar.opt.childWidth);
		
		this.iconbar.css({"right":"0px","top":"0"});
		this.iconbar.height(taskbar.opt.childHeight + 2);
		
		this.contbar.css("position","absolute");
		this.contbar.css("left",this.startbar.outerWidth(true));
		this.contbar.css("right",this.iconbar.outerWidth(true));
		this.contbar.css("top",2);
		this.contbar.height(taskbar.opt.childHeight + 2);
		this.iconbar.css("margin-right","3px");
	}else{
		clearCss();
		this.contbar.find(".child-task").css({"display":"block","margin":"3px 0px"});
		this.selector.css("top","0px");
		this.selector.css("bottom","0px");
		this.selector.css(this.opt.position,"0px");
		this.selector.width(this.opt.childWidth + 3);
		this.selector.height($(window).height());
		
		this.startbar.css({"top":"0px","border-bottom":"1px solid #4f7ca9","padding":"5px 0 0 0"});
		this.startbar.css("display","block");
		this.startbar.width(this.opt.childWidth);
		this.startbar.height(this.opt.childHeight+8);
		
		this.iconbar.css("bottom","0px");
		this.iconbar.width(this.opt.childWidth);
		
		this.contbar.css("top",this.startbar.outerHeight(true));
		this.contbar.css("bottom",this.iconbar.outerHeight(true));
		this.contbar.width(this.opt.childWidth);
		this.iconbar.css("margin-bottom","3px");
	}
	if(this.opt.position=="bottom"){
		this.selector.addClass("eht-taskbar-bottombg");
	}
	if(this.opt.position=="top"){
		this.selector.addClass("eht-taskbar-topbg");
	}
	if(this.opt.position=="left"){
		this.selector.addClass("eht-taskbar-leftbg");
	}
	if(this.opt.position=="right"){
		this.selector.addClass("eht-taskbar-rightbg");
	}
	function clearCss(){
		taskbar.selector.removeClass("eht-taskbar-topbg");
		taskbar.selector.removeClass("eht-taskbar-bottombg");
		taskbar.selector.removeClass("eht-taskbar-leftbg");
		taskbar.selector.removeClass("eht-taskbar-rightbg");
		taskbar.selector.css("top","");
		taskbar.selector.css("bottom","");
		taskbar.selector.css("left","");
		taskbar.selector.css("right","");
		taskbar.selector.css("width","");
		taskbar.selector.css("height","");
		
		taskbar.startbar.css("top","");
		taskbar.startbar.css("bottom","");
		taskbar.startbar.css("left","");
		taskbar.startbar.css("right","");
		taskbar.startbar.css("width","");
		taskbar.startbar.css("height","");
		
		taskbar.contbar.css("top","");
		taskbar.contbar.css("bottom","");
		taskbar.contbar.css("left","");
		taskbar.contbar.css("right","");
		taskbar.contbar.css("width","");
		taskbar.contbar.css("height","");
		
		taskbar.iconbar.css("top","");
		taskbar.iconbar.css("bottom","");
		taskbar.iconbar.css("left","");
		taskbar.iconbar.css("right","");
		taskbar.iconbar.css("width","");
		taskbar.iconbar.css("height","");
	}
};
Eht.Taskbar.prototype.getPosition=function(){
	return this.opt.position;
};
Eht.Taskbar.prototype.resize=function(){
	this.setPosition();
};
Eht.Taskbar.prototype.addWindow=function(win){
	var taskbar = this;
	var add = true;
	for(var i=0;i<this.windowsManager.windows.length;i++){
		if(this.windowsManager.windows[i].getId()==win.getId()){
			add = false;
			if(win.opt.iframe==true){
				win.container.remove();
			}
			if(this.windowsManager.windows[i]!=win){				
				win.open=function(){};
				win = this.windowsManager.windows[i];
			}
		}
	}
	if(add){
		this.windowsManager.add(win);
		var ctask = $("<div class='child-task'></div>");
		ctask.width(this.opt.childWidth);
		ctask.height(this.opt.childHeight);
		ctask.attr("windowId",win.getId());
		ctask.attr("title",win.opt.title);
		var ct=$("<div class='child-task-icon'></div>");
		ct.addClass(win.getIcon());
		ctask.append(ct);
		this.contbar.append(ctask);
		
		win.showButton("min");
		win.closeBefore(function(){
			taskbar.removeTask(this.id);
			return true;
		});
		win.clickMin(function(){
			var childtask = taskbar.selector.find("div[windowId='"+this.id+"']");
			var styles = childtask.offset();
			styles.width = childtask.width();
			styles.height= childtask.height();
			var w = this;
			this.container.animate(styles,{duration:taskbar.opt.duration,complete:function(){
				w.resize();
				$(this).hide();
				childtask.addClass("child-task-flash");
				setTimeout(function(){
					childtask.removeClass("child-task-flash");
				},200);
			}});
		});
		win.getMaxRect(function(){return taskbar.maxrect();});
		if(this.opt.position=="bottom" ||this.opt.position=="top"){
			this.contbar.find(".child-task").css({"display":"inline-block","margin":"1px 2px"});
		}else{
			this.contbar.find(".child-task").css({"display":"block","margin":"3px 0px"});
		}
		ctask.unbind("click").bind("click",function(){
			var current = null;
			for(var i=0;i<taskbar.windowsManager.windows.length;i++){
				if($(this).attr("windowId")==taskbar.windowsManager.windows[i].getId()){
					current = taskbar.windowsManager.windows[i];
					break;
				}
			}
			if(taskbar._clickTask){
				taskbar._clickTask(current);
			}else{
				if(current!=null){
					if(current.container.is(":hidden")){
						current.container.css({top:$(this).offset().top,left:$(this).offset().left,width:$(this).width(),height:$(this).height()});
						current.open();
						var an = {left:current.minBeforeLeft,top:current.minBeforeTop,height:current.minBeforeHeight,width:current.minBeforeWidth};
						if(current.status=="max"){
							an = current._getMaxRect();
						}
						current.container.animate(an,
								{duration:taskbar.opt.duration,complete:function(){
									current.resize();
								}
						});
						current.resize();
					}else{
						current.clickMin();
					}
				}
			}
		});
	}
	win.open();
	this.maxrect=function(){
		//{width:_width,height:_height,left:0,top:0}
		var rect = {};
		if(taskbar.opt.position=="bottom"){
			rect.top = 0;
			rect.left = 0;
			rect.width = $(window).width();
			rect.height = $(window).height() - taskbar.selector.outerHeight(true);
		}
		if(taskbar.opt.position=="top"){
			rect.top = taskbar.selector.outerHeight(true);
			rect.left = 0;
			rect.width = $(window).width();
			rect.height = $(window).height() - taskbar.selector.outerHeight(true);
		}
		if(taskbar.opt.position=="left"){
			rect.top = 0;
			rect.left = taskbar.selector.outerWidth(true);
			rect.width = $(window).width() -  taskbar.selector.outerWidth(true);
			rect.height = $(window).height();			
		}
		if(taskbar.opt.position=="right"){
			rect.top = 0;
			rect.left = 0;
			rect.width = $(window).width() -  taskbar.selector.outerWidth(true);
			rect.height = $(window).height();
		}
		return rect;
	};
};
/**
 * 任务栏中通知区域信息（图标）
 */
Eht.Taskbar.prototype.addToolbar=function(toolbar){
	if(toolbar instanceof Eht.Toolbar){
		this.iconbar.append(toolbar.selector);
	}else{
		this.iconbar.append($(toolbar));
	}
	this.iconbar.find(".eht-toolbar").removeClass("eht-toolbar").removeClass("eht-basebar").addClass("eht-taskbar-toolbar");
};

Eht.Taskbar.prototype.clickStart=function(func){
	this._clickStart = func;
};
Eht.Taskbar.prototype.clickTask=function(func){
	this._clickTask = func;
};
Eht.Taskbar.prototype.removeTask=function(windowId){
	var taskbar = this;
	taskbar.contbar.find("div[windowId='"+windowId+"']").children().remove();
	taskbar.contbar.find("div[windowId='"+windowId+"']").animate({width:3,height:3},{duration:150,complete:function(){			
		taskbar.contbar.find("div[windowId='"+windowId+"']").remove();
	}});
};
/**
 * 放下事件
 */
Eht.Taskbar.prototype.drop=function(func){
	this._drop = func;
};
