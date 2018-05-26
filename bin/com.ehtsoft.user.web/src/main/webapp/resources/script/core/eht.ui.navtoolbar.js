/**
 * tab toolbar 导航工具类
 * @param opt
 * @author 王宝
 * @returns {Eht.NavToolbar}
 */
Eht.NavToolbar=function(opt){
	var def = {
		selector:null,
		labelField:"label",
		childrenField:"children",
		iconField:"icon",
		urlField:"url",
		menucode:null,
		iconHeight:50,
		iframe:false,
		mouseoverchange:true, //鼠标略过时候，切换 tab
		customBar:null,
		styleType:"middle" // small,lage,middle  小图标，大图标，普通图标
	};
	this.lrbarWidth=60;
	var nav = this;
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.navToolbar = $("<div></div>");
	this.navToolbar.addClass("eht-navtoolbar");
	this.selector.append(this.navToolbar);
	var container = $('<div class="navtoolbar-tab-container"></div>');
	this.tabContainer = $('<ul class="navtoolbar-tab"></ul>');
	this.leftBar = $("<a class='navtoolbar_navbtn navtoolbar-leftbar'></a>");
	this.rightBar = $("<a class='navtoolbar_navbtn navtoolbar-rightbar'></a>");
	this.customBar = $("<div class='navtoolbar_customBar'></div>");
	if(this.opt.customBar!=null){
		this.customBar.append($(this.opt.customBar));
	}
	container.append(this.leftBar,this.tabContainer,this.rightBar,this.customBar);
	this.navToolbar.append(container);
	
	this.tabContainer.width($(window).width() - this.getCustomWidth());
	
	this.childMenu = new Object();
	
	if(this.opt.styleType=="middle"){
		this.opt.iconHeight = 32;
	}
	
	this.iframe = $("<iframe class='eht-navtoolbar-iframe' frameborder='0'></iframe>");
	if(this.opt.iframe){
		this.selector.append(this.iframe);
		this.resize();
		$(document.body).css("overflow","hidden");
	}
	$(window).resize(function(){
		nav.resize();
	});
	this.iframe.load(function(){
		try{
			$(this).contents().click(function(){
				var childMenu = nav.childMenu;
				for(var p in childMenu){
					if(childMenu[p]){
						childMenu[p].hide();
					}
				}
			});
		}catch(e){
		};
	});
	this.rightBar.click(function(){
		var n=findRightshownode();
		var hscroll=0;
		if(n){
			var r = nav.tabContainer.outerWidth(true) + nav.tabContainer.offset().left;
			var nright = n.offset().left + n.outerWidth(true);
			if(nright > r){
				hscroll= nright - r;
			}else{
				hscroll=n.width();
			}
		}
		nav.tabContainer.scrollLeft(nav.tabContainer.scrollLeft()+hscroll);
	});
	this.leftBar.click(function(){
		var n=findLeftshownode();
		var hscroll=0;
		if(n){
			if(n.offset().left < nav.tabContainer.offset().left){
				hscroll= nav.tabContainer.offset().left - n.offset().left;
			}else{
				hscroll=n.width();
			}
		}
		nav.tabContainer.scrollLeft(nav.tabContainer.scrollLeft()-hscroll);
	});
	function findRightshownode(){
		var rtn = null;
		nav.tabContainer.children().each(function(){
			var r = nav.tabContainer.outerWidth(true) + nav.tabContainer.offset().left;
			var thisRight = $(this).outerWidth(true) + $(this).offset().left;
			if(thisRight > r
			&& $(this).offset().left <= r ){
				rtn = $(this);
				return rtn;
			}
		});
		return rtn;
	}
	function findLeftshownode(){
		var rtn = null;
		nav.tabContainer.children().each(function(){
			  var thisRight = $(this).offset().left + $(this).outerWidth(true);
			  if(thisRight >= nav.tabContainer.offset().left
				&& $(this).offset().left < nav.tabContainer.offset().left){
					rtn = $(this);
					return rtn;
				}
			});
			return rtn;
	}
};
Eht.NavToolbar.prototype.getCustomWidth=function(){
	if(this.customBar.outerWidth(true)>8){
		return this.customBar.outerWidth(true) + 10 + this.lrbarWidth;
	}else{
		return 10;
	}
};
Eht.NavToolbar.prototype.loadData=function(data){
	//data:Array|func(res)
	var nav = this;
	nav.selector.find(".navtoolbar-tool-container").remove();
	nav.tabContainer.empty();
	if($.isArray(data)){
		for(var i=0;i<data.length;i++){
			this.addItem(data[i],i);
		}
		
		this.resize();
	}
	if($.isFunction(data)){
		var res = new Eht.Responder();
		res.success=function(ds){
			nav.loadData(ds);
			if(nav._loadComplete){
				nav._loadComplete(ds);
			}
			var w = 0;
			nav.tabContainer.children().each(function(){
				w+=$(this).outerWidth(true);
			});
			if(w<nav.tabContainer.outerWidth(true)){
				nav.rightBar.hide();
				nav.leftBar.hide();
				nav.lrbarWidth = 0;
			}else{
				nav.rightBar.show();
				nav.leftBar.show();
				nav.lrbarWidth = 60;
			}
			nav.tabContainer.width($(window).width() - nav.getCustomWidth());
		};
		this._loadFunc = data;
		this._loadFunc(res);
	}
};
Eht.NavToolbar.prototype.refresh=function(){
	this.loadData(this._loadFunc);
};
Eht.NavToolbar.prototype.resize=function(){
	var nav = this;
	var h = $(window).height() - this.navToolbar.outerHeight(true) - 2;
	var w = $(window).width() - 2;
	if(this.parentBox){
		h = this.parentBox.height() - this.navToolbar.outerHeight(true) - 2;
		w = this.parentBox.width() - 2;
	}
	this.iframe.height(h);
	this.iframe.width(w);
	
	var w = 0;
	nav.tabContainer.children().each(function(){
		w+=$(this).outerWidth(true);
	});
	if(w<nav.tabContainer.outerWidth(true)){
		nav.rightBar.hide();
		nav.leftBar.hide();
		nav.lrbarWidth = 0;
	}else{
		nav.rightBar.show();
		nav.leftBar.show();
		nav.lrbarWidth = 60;
	}
	nav.tabContainer.width($(window).width() - this.getCustomWidth());
	nav.selector.find(".navtoolbar-tool").width($(window).width() - 60 - 30);
	var w2=0;
	var tooldiv = nav.selector.find("div[display='true']");
	tooldiv.find("ul.navtoolbar-tool").children().each(function(){
		w2+=$(this).outerWidth(true);
	});
	if(w2<tooldiv.find("ul.navtoolbar-tool").outerWidth(true)){
		tooldiv.find(".navtool-leftbar").hide();
		tooldiv.find(".navtool-rightbar").hide();
	}else{
		tooldiv.find(".navtool-leftbar").show();
		tooldiv.find(".navtool-rightbar").show();
	}
};
Eht.NavToolbar.prototype.addItem=function(data){
	var nav = this;
	var childMenu = this.childMenu;
	if(data){
		var itemIndex = arguments[1];
		//tool tab
		var tabItem = $("<li>"+data[this.opt.labelField]+"</li>");
		tabItem.data(data);
		var uuid = nav.opt.menucode==null? Eht.Utils.createUuid() : data[nav.opt.menucode];
		
		tabItem.attr("toolContainer",uuid);
		//默认第一个为激活状态
		if(itemIndex==0){
			tabItem.addClass('navtoolbar-tab-active');
		}
		//添加  tab
		this.tabContainer.append(tabItem);
		//tab 下面的 tool 容器
		var tc = $('<div class="navtoolbar-tool-container"></div>');
		tc.attr("id",uuid);
		tc.attr("display","false");
		tc.hide();
		//tab 激活的 下面 tool 显示
		if(tabItem.hasClass("navtoolbar-tab-active")){
			tc.show();
			tc.attr("display","true");
		}
		var tool = $('<ul class="navtoolbar-tool"></ul>');
		tool.attr("id","ul_" + uuid);
		var toolLeftBar = $("<a class='navtoolbar_navbtn navtool-leftbar'></a>");
		var toolRightBar = $("<a class='navtoolbar_navbtn navtool-rightbar'></a>");
		toolLeftBar.hide();
		toolRightBar.hide();
		// tool ul
		tc.append(toolLeftBar,tool,toolRightBar);
		toolLeftBar.attr("tc",uuid);
		toolRightBar.attr("tc",uuid);
		toolLeftBar.mouseover(function(){
			var ulid = "#ul_"+$(this).attr("tc");
			f();
			function f(){
				nav.handler = setTimeout(function(){
					$(ulid).scrollLeft($(ulid).scrollLeft()-6);
					f();
				},10);
			}
			
		});
		toolLeftBar.mouseout(function(){
			clearTimeout(nav.handler);
		});
		toolRightBar.mouseover(function(){
			var ulid = "#ul_"+$(this).attr("tc");
			f();
			function f(){
				nav.handler = setTimeout(function(){
					$(ulid).scrollLeft($(ulid).scrollLeft()+6);
					f();
				},10);
			}
			
		});
		toolRightBar.mouseout(function(){
			clearTimeout(nav.handler);
		});
		tool.width($(window).width()- 60- 30);////// tool ui width
		this.navToolbar.append(tc);
		if(data[this.opt.childrenField]){
			var children = data[this.opt.childrenField];
			for(var i=0;i<children.length;i++){
				var itm = $('<li class="tool-item">'+
								'<div class="tool-icon"></div>'+
								'<div class="tool-text">'+children[i][this.opt.labelField]+'</div>'+
							  '</li>');
				itm.data(children[i]);
				tool.append(itm);
				itm.attr("id",children[i][nav.opt.menucode]);
				itm.find(".tool-icon").height(this.opt.iconHeight);
				
				if(this.opt.styleType=="small"){
					itm.removeClass("tool-item").addClass("tool-item-line");
					itm.find(".tool-icon").width(18);
					itm.find(".tool-icon").height(18);
					itm.find(".tool-text").css("margin-left","5px");
				}
				if(this.opt.styleType=="middle"){
				}
				if(this.opt.styleType=="lage"){
					itm.css("width","80px");
				}
				if(children[i][this.opt.iconField] && children[i][this.opt.iconField].length>0){
					if(this._getIcon){
						var icon = this._getIcon(children[i][this.opt.iconField]);
						itm.find(".tool-icon").addClass(icon);
					}else{
						if(this.opt.styleType=="small"){
							itm.find(".tool-icon").addClass(children[i][this.opt.iconField].replace(/desktop|taskbar/,"window"));
						}
						if(this.opt.styleType=="middle"){
							itm.find(".tool-icon").addClass(children[i][this.opt.iconField].replace(/desktop|window/,"taskbar"));
						}
						if(this.opt.styleType=="lage"){
							itm.find(".tool-icon").addClass(children[i][this.opt.iconField].replace(/window|taskbar/,"desktop"));
						}
					}
				}else{
					//添加默认图标
					if(this.opt.styleType=="small"){
						itm.find(".tool-icon").addClass("window-func-general");
					}
					if(this.opt.styleType=="middle"){
						itm.find(".tool-icon").addClass("taskbar-func-general");
					}
					if(this.opt.styleType=="lage"){
						itm.find(".tool-icon").addClass("desktop-func-general");
					}
				}
				if(children[i][this.opt.childrenField] && children[i][this.opt.childrenField].length>0){
					var cdown = $("<div class='tool-item-down'></div>");
					var uuid = nav.opt.menucode==null? Eht.Utils.createUuid() : children[i][nav.opt.menucode];
					itm.attr("uuid",uuid);
					itm.attr("hasChild",true);
					cdown.attr("uuid",uuid);
					childMenu[uuid] = new Eht.Menu({
						height:50,
						width:200,
						cwidth:200,
						labelField:this.opt.labelField,showTitle:false,
						title:children[i][this.opt.labelField]});
					childMenu[uuid].loadData(children[i][this.opt.childrenField]);
					childMenu[uuid].clickItem(function(data){
						if(nav.opt.iframe){
							var url = data[nav.opt.urlField];
							if(nav.iframe.attr("src")!=url){
								nav.iframe.attr("src",url);
							}
						}
						if(nav._clickItem){
							nav._clickItem(data);
						}
					});
					itm.append(cdown);
					cdown.click(function(e){
						for(var p in childMenu){
							childMenu[p].container.hide();
						}
						var top = $(this).parent().outerHeight(true) + $(this).parent().position().top + 2;
						var left = $(this).parent().offset().left;
						childMenu[$(this).attr("uuid")].show(e,{top:top,left:left});
						return false;
					});
					itm.unbind("click").bind("click",function(e){
						nav.selector.find(".navtoolbar-tool-active").removeClass("navtoolbar-tool-active");
						$(this).addClass("navtoolbar-tool-active");
						
						for(var p in childMenu){
							childMenu[p].container.hide();
						}
						var top = $(this).outerHeight(true) + $(this).position().top + 2;
						var left = $(this).offset().left;
						childMenu[$(this).attr("uuid")].show(e,{top:top,left:left});
						return false;
					});
				}else{
					itm.unbind("click").bind("click",function(){
						nav.selector.find(".navtoolbar-tool-active").removeClass("navtoolbar-tool-active");
						$(this).addClass("navtoolbar-tool-active");
						
						if(nav.opt.iframe){
							var url = $(this).data()[nav.opt.urlField];
							if(nav.iframe.attr("src")!=url){
								nav.iframe.attr("src",url);
							}
						}
						if(nav._clickItem){
							nav._clickItem($(this).data());
						}
					});
				}
			}
		}
		tabItem.unbind("click").bind("click",function(e){
			nav.selector.find(".navtoolbar-tab-active").removeClass("navtoolbar-tab-active");
			nav.selector.find("div[display='true']").attr("display","false");
			$(this).addClass("navtoolbar-tab-active");
			nav.selector.find(".navtoolbar-tool-container").hide();
			var tooldiv = nav.selector.find("#"+$(this).attr("toolContainer"));
			tooldiv.show();
			tooldiv.attr("display","true");
			var w2=0;
			var tooldiv = nav.selector.find("div[display='true']");
			tooldiv.find("ul.navtoolbar-tool").children().each(function(){
				w2+=$(this).outerWidth(true);
			});
			if(w2<tooldiv.find("ul.navtoolbar-tool").outerWidth(true)){
				tooldiv.find(".navtool-leftbar").hide();
				tooldiv.find(".navtool-rightbar").hide();
			}else{
				tooldiv.find(".navtool-leftbar").show();
				tooldiv.find(".navtool-rightbar").show();
			}
			
			if(nav._clickTab){
				nav._clickTab($(this).data());
			}
		});
		tabItem.unbind("mouseover").bind("mouseover",function(e){
			if(nav.opt.mouseoverchange){
				$(this).click();
			}
		});
	}
};
Eht.NavToolbar.prototype.setIcon=function(func){
	//func(string)
	this._getIcon = func;
};
Eht.NavToolbar.prototype.clickTab=function(func){
	//func(data)
	this._clickTab = func;
};
Eht.NavToolbar.prototype.clickItem=function(func){
	//func(data)
	this._clickItem = func;
};
Eht.NavToolbar.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.NavToolbar.prototype.setRootUrl=function(url){
	this.iframe.attr("src",url);
};
Eht.NavToolbar.prototype.setSelected=function(arg){
	if($.isFunction(arg)){
		
	}
	if($.type(arg)=="string"){
		if(arg.length>=7){
			this.selector.find(".navtoolbar-tab-active").removeClass("navtoolbar-tab-active");
			this.selector.find(".navtoolbar-tool-container").hide();
			var tooldiv= this.selector.find("#" + arg.substring(0,5)).show();
			tooldiv.attr("display","true");
			this.navToolbar.find("li[toolcontainer='"+arg.substring(0,5)+"']").addClass("navtoolbar-tab-active");
			this.navToolbar.find("#" + arg.substring(0,7)).addClass("navtoolbar-tool-active");
		}
	}
};