
Eht.Menu = function(opt) {
	var menu = this;
	def = {
		selector : null,
		labelField : 'label',
		childrenField : 'children',
		iconField : "icon",
		hasRight : false,
		width : 300,
		height : 200,
		cWidth : 200,// 子菜单宽度
		title : "菜单项",
		showTitle:true,
		contextmenu:false
	};

	this.opt = $.extend(def, opt);

	this.selector = this.opt.selector!=null?$(this.opt.selector):$(document.body);
	this.container = $("<div class='eht_menu_container'></div>");

	this.selector.append(this.container);
	
	this.title = $("<div class='eht_menu_title'>" + this.opt.title + "</div>");
	if(this.opt.showTitle==false){
		this.title.hide();
	}
	this.bodyleft = $("<div class='eht_menu_body_left'></div>");
	this.bodyright = $("<div class='eht_menu_body_right'></div>");
	this.clearboth = $("<div style='clear:both;'></div>");
	this.container.append(this.title);
	this.container.append(this.bodyleft, this.bodyright, this.clearboth);
	this.leftline = $("<span class='eht_nemu_left_line'></span>");
	this.leftline.height("99%");
	this.ul = $("<ul></ul>");
	this.container.width(this.opt.width);
	this.container.height(this.opt.height);
	this.bodyleft.height(this.opt.height - (this.opt.showTitle?25:0));
	this.bodyright.height(this.opt.height - (this.opt.showTitle?25:0));
	this.rightUl = $("<ul></ul>");
	this.bodyright.append(this.rightUl);
	
	if(this.opt.hasRight ){
		if(this.opt.width<300){
		this.opt.width=300;
		}
		this.bodyleft.width(parseInt(this.container.width()-101));
	}else if (this.opt.hasRight == null || this.opt.hasRight == undefined || this.opt.hasRight == false) {
		this.bodyright.css("display", "none");
		this.bodyleft.width(this.opt.width);
	}
	this.container.hide();

	if(this.opt.contextmenu==true){
		$(document).bind("mousedown",function(e){
			if(e.which==3){
				menu.show(e);
				return false;
			}
		});
	}
	this.container.unbind("mousedown").bind("mousedown",function(e){
		if(e.which==3){
			return false;
		}
		return true;
	});
	this.container.unbind("contextmenu").bind("contextmenu",function(){
		return false;
	});
	this.bodyright.unbind("mouseover").bind("mouseover",function(){
		menu.container.find(".dropChild").hide();
	});
};
Eht.Menu.prototype.setContextmenu=function(flag){
	this.opt.contextmenu = flag;
	if(flag==false){
		(document).unbind("mousedown");
	}else{
		$(document).bind("mousedown",function(e){
			if(e.which==3){
				menu.show(e);
				return false;
			}
		});
	}
};
Eht.Menu.prototype.loadData = function(obj) {
	this.bodyleft.empty();
	this.ul.empty();
	var menu = this;
	if (this._object == null || this._object==undefined) {
		this._object = obj;
	}
	var childrenField = this.opt.childrenField;
	if ($.type(obj) == "array") {
		this.data = obj;
		iterdata(menu.ul, this.data);
	} else if ($.type(obj) == "function") {
		this._loadData = obj;
		if (this.loadResp == null) {
			this.loadResp = new Eht.Responder();
			this.loadResp.success = function(data, textStatus, jqXHR) {
				menu.loadData(data);
			};
			this.loadResp.error = function(data, textStatus, jqXHR) {
			};
		}
		this._loadData(this.loadResp);
	}
	function iterdata(ul, data) {
		for ( var i = 0; i < data.length; i++) {
			if(menu._each){
				menu._each(data[i]);
			}
			var li = $("<li class='dropdown'><span class="
					+ data[i][menu.opt.iconField] + "></span><a>"
					+ data[i][menu.opt.labelField] + "</a></li>");
			li.data(data[i]);
			ul.append(li);
			if (data[i][childrenField] && data[i][childrenField].length > 0) {
				var subUl = $("<ul class='dropChild'></ul>");
				li.append(subUl);
				iterdata(subUl, data[i][childrenField]);
			}
			li.unbind("click").bind("click",function(e){
				if(menu._clickItem){
					var d = $(this).data();
					if(d[menu.opt.childrenField]==undefined || d[menu.opt.childrenField].length ==0){
						menu._clickItem(d);
						menu.hide();
					}
				}
				e.stopPropagation();
				return false;
			});
		}

	}
	this.bodyleft.append(this.ul, this.leftline);
	this.bodyleft.find("ul").append(this.leftline);
	
};
Eht.Menu.prototype.each=function(func){
	//func(itemData)
	this._each = func;
};

Eht.Menu.prototype.clickItem = function(func) {
	//func(data)
	this._clickItem= func;
};
Eht.Menu.prototype.show = function(e,position) {
	var menu = this;
	var lrPosition=true;
	var tbPosition=true;
	var winWidth = $(window).width();
	var winHeight = $(window).height();
	
	
	var left = e.clientX;
	if(position){
		left = position.left;
	}
	if(winWidth-menu.container.outerWidth(true)<e.clientX){
		left = winWidth-menu.container.outerWidth(true) - 10;
		lrPosition=false;
	}
	var top = e.clientY;
	if(position){
		top = position.top;
	}
	if(winHeight-menu.container.outerHeight(true)<e.clientY){
		top = winHeight-menu.container.outerHeight(true);
		tbPosition = false;
	}
	menu.container.css({
		"left" : left,
		"top" : top
	});
	this.container.find(".dropdown").unbind("mouseover").bind("mouseover",function(e) {
	 	if ($(e.target).is('span')) {
		} else {
			$(this).children(".dropChild").width(menu.opt.cWidth);
			$(e.target).addClass("mouseHover").parent().siblings().find("a")
					.removeClass("mouseHover");
			$(this).children(".dropChild").show().parent().siblings()
					.children(".dropChild").hide();
			if(!lrPosition){
				$(this).children(".dropChild").css({left:-$(this).children(".dropChild").outerWidth(true)});
			}else{
				$(this).children(".dropChild").css({left:$(this).parent().width(),"z-index":10000});
			}
			if(!tbPosition){
				$(this).children(".dropChild").css({top:-$(this).children(".dropChild").outerHeight(true) + $(this).outerHeight(true)});
			}else{
				$(this).children(".dropChild").css({top:"","z-index":10000});
			}
		}
	});
	
	$(".eht_menu_container div ul  li").addClass("dropdown");
	var $noChild = $(".eht_menu_container div ul li:not(:has(ul))");
	$noChild.find("a").addClass("noChildren");
	$(".eht_menu_container").unbind("click").bind("click", function() {
		return false;
	});

	$(document).bind("click", function(e) {
		$(".eht_menu_container").hide();
		$(".dropdown").find("a").removeClass("mouseHover");
		$(".dropdown").children(".dropChild").hide();
	}).bind("contextmenu", function(e) {
		return false;
	});
	menu.container.show();
	if(this.ul.outerHeight(true)>this.bodyleft.outerHeight(true)){
		this.bodyleft.height(this.ul.outerHeight(true) + 10);
		this.bodyright.height(this.bodyleft.height());
		this.container.height(this.bodyleft.height() + (this.opt.showTitle?25:0));
	} 
	
	$(".noChildren").mouseover(function() {
		$(this).parent().siblings().find("ul").hide();
	});
};
Eht.Menu.prototype.hide = function() {
	this.container.hide();
};
Eht.Menu.prototype.addSnapshot=function(data){
	var menu = this;
	if(data){
		var li = $("<li class='dropdown' style='overflow: hidden;'><span class="
				+ data[menu.opt.iconField] + " style='margin-right: 10px'></span><a>"
				+ data[menu.opt.labelField] + "</a></li>");
		li.data(data);
		this.rightUl.append(li);
		li.unbind("click").bind("click",function(e){
			if(menu._clickItem){
				var d = $(this).data();
				if(d[menu.opt.childrenField]==undefined || d[menu.opt.childrenField].length ==0){
					menu._clickItem(d);
					menu.hide();
				}
			}
			e.stopPropagation();
			return false;
		});
	}
};

Eht.Menu.prototype.refresh=function(){
	this.loadData(this._object);
};