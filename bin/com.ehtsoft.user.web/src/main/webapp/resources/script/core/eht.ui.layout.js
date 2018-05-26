/**
 * UI布局类
 * @param opt
 * @returns {Eht.Layout}
 * @author wangbao
 */
Eht.Layout=function(opt){
	var layout = this;
	var def = {//or "#selectId"
		selector:null,//parent 的div
		top:{selector:null,title:null,titleSelector:null,border:true},
		left:{selector:null,border:true},
		center:{selector:null,border:true},
		right:{selector:null,border:true},
		bottom:{selector:null,border:true}
	};
	this.opt=$.extend(def,opt);
	if(this.opt.selector!=null){
		this.selector = $(this.opt.selector);
	}else{
		this.selector=null;
	}
	if(this.opt.top!=null && $.type(this.opt.top)=="string"){
		this.top = $(this.opt.top);
	}else if(this.opt.top.selector!=null){
		if(this.opt.top.border==true || this.opt.top.border==undefined)
		$(this.opt.top.selector).addClass("eht-layout-border");
		if(this.opt.top.title!=null){
			this.top = $("<div></div>");
			$(this.opt.top.selector).before(this.top);
			this.topTitle = $("<div class='eht-base eht-layout-title'></div>");
			if(this.opt.top.titleSelector){
				this.topTitle.append($(this.opt.top.titleSelector));
			}else{
				this.topTitle.html(this.opt.top.title);
			}
			this.top.append(this.topTitle);
			this.top.append($(this.opt.top.selector));
		}else{
			this.top = $(this.opt.top.selector);
		}
	}
	if(this.opt.left!=null && $.type(this.opt.left)=="string"){
		this.left = $(this.opt.left);
	}else if(this.opt.left.selector!=null){
		if(this.opt.left.border==true || this.opt.left.border==undefined)
		$(this.opt.left.selector).addClass("eht-layout-border");
		if(this.opt.left.title!=null){
			this.left = $("<div></div>");
			$(this.opt.left.selector).before(this.left);
			this.left.width($(this.opt.left.selector).outerWidth(true));
			this.leftTitle = $("<div class='eht-base eht-layout-title'></div>");
			if(this.opt.left.titleSelector){
				this.leftTitle.append($(this.opt.left.titleSelector));
			}else{
				this.leftTitle.html(this.opt.left.title);
			}
			this.left.append(this.leftTitle);
			this.left.append($(this.opt.left.selector));
		}else{
			this.left = $(this.opt.left.selector);
		}
	}
	if(this.opt.center!=null && $.type(this.opt.center)=="string"){
		this.center = $(this.opt.center);
	}else if(this.opt.center.selector!=null){
		if(this.opt.center.border==true || this.opt.center.border==undefined)
		$(this.opt.center.selector).addClass("eht-layout-border");
		if(this.opt.center.title!=null){
			this.center = $("<div></div>");
			$(this.opt.center.selector).before(this.center);
			this.centerTitle = $("<div class='eht-base eht-layout-title'></div>");
			if(this.opt.center.titleSelector){
				this.centerTitle.append($(this.opt.center.titleSelector));
			}else{
				this.centerTitle.html(this.opt.center.title);
			}
			this.center.append(this.centerTitle);
			this.center.append($(this.opt.center.selector));
		}else{
			this.center = $(this.opt.center.selector);
		}
	}
	if(this.opt.right!=null && $.type(this.opt.right)=="string"){
		this.right = $(this.opt.right);
	}else if(this.opt.right.selector!=null){
		if(this.opt.right.border==true || this.opt.right.border==undefined)
		$(this.opt.right.selector).addClass("eht-layout-border");
		if(this.opt.right.title!=null){
			this.right = $("<div></div>");
			$(this.opt.right.selector).before(this.right);
			this.right.width($(this.opt.right.selector).outerWidth(true));
			this.rightTitle = $("<div class='eht-base eht-layout-title'></div>");
			if(this.opt.right.titleSelector){
				this.rightTitle.append($(this.opt.right.titleSelector));
			}else{
				this.rightTitle.html(this.opt.right.title);
			}
			this.right.append(this.rightTitle);
			this.right.append($(this.opt.right.selector));
		}else{
			this.right = $(this.opt.right.selector);
		}
	}
	if(this.opt.bottom!=null && $.type(this.opt.bottom)=="string"){
		this.bottom = $(this.opt.bottom);
	}else if(this.opt.bottom.selector!=null){
		if(this.opt.bottom.border==true || this.opt.bottom.border==undefined)
		$(this.opt.bottom.selector).addClass("eht-layout-border");
		if(this.opt.bottom.title!=null){
			this.bottom = $("<div></div>");
			$(this.opt.bottom.selector).before(this.bottom);
			this.bottomTitle = $("<div class='eht-base eht-layout-title'></div>");
			if(this.opt.bottom.titleSelector){
				this.bottomTitle.append($(this.opt.bottom.titleSelector));
			}else{
				this.bottomTitle.html(this.opt.bottom.title);
			}
			this.bottom.append(this.bottomTitle);
			this.bottom.append($(this.opt.bottom.selector));
		}else{
			this.bottom = $(this.opt.bottom.selector);
		}
	}
	var pl = parseInt($(this.selector).css("margin-left")?$(this.selector).css("margin-left"):0);
	pl = isNaN(pl)?0:pl;
	var pr = parseInt($(this.selector).css("margin-right")?$(this.selector).css("margin-right"):0);
	pr = isNaN(pr)?0:pr;
	if(this.top!=null){
		this.top.css("margin-left",pl);
		this.top.css("margin-right",pr);
		this.top.css({position:"absolute"});
		this.top.css("left",0);
		this.top.css("right",0);
		this.top.css("top",0);
		this.top.css("bottom","auto");
	}
	if(this.bottom!=null){
		this.bottom.css("margin-left",pl);
		this.bottom.css("margin-right",pr);
		this.bottom.css({position:"absolute"});
		this.bottom.css("top","auto");
		this.bottom.css("bottom",0);
		this.bottom.css("left",0);
		this.bottom.css("right",0);
	}
	if(this.left!=null){
		var th = 0;
		if(this.top!=null){
			th = this.top.outerHeight(true);
		}
		var bh = 0;
		if(this.bottom!=null){
			bh=this.bottom.outerHeight(true);
		}
		this.left.css("margin-left",pl);
		this.left.css({position:"absolute"});
		this.left.css("left",0);
		this.left.css("right","auto");
		this.left.css("top",th);
		this.left.css("bottom",bh+1);
	}
	if(this.right!=null){
		var th = 0;
		if(this.top!=null){
			th = this.top.outerHeight(true);
		}
		var bh = 0;
		if(this.bottom!=null){
			bh=this.bottom.outerHeight(true);
		}
		this.right.css("margin-right",pr);
		this.right.css({position:"absolute"});
		this.right.css("left","auto");
		this.right.css("right",0);
		this.right.css("top",th);
		this.right.css("bottom",bh+1);
	}
	if(this.center!=null){
		var gap = 3;//左右间隔
		var th = 0;
		if(this.top!=null){
			th = this.top.outerHeight(true);
		}
		var bh = 0;
		if(this.bottom!=null){
			bh=this.bottom.outerHeight(true);
		}
		var lw = 0;
		if(this.left!=null){
			lw = this.left.outerWidth(true) + gap;
			this.leftDivide = $("<span class='leftDivide'></span>");
			this.leftDivide.css({position:"absolute",display:"block"});
			//e-resize,ne-resize,nw-resize,n-resize,se-resize,sw-resize,s-resize,w-resize
			this.leftDivide.css({"width":gap,"zIndex":100});//,"cursor":"e-resize"});
			this.center.parent().append(this.leftDivide);
		}else{
			this.center.css("margin-left",pl);
		}
		var rw = 0;
		if(this.right!=null){
			rw = this.right.outerWidth(true) + gap;
			this.rightDivide = $("<span></span>");
		}else{
			this.center.css("margin-right",pr);
		}
		this.center.css({position:"absolute"});
		this.center.css("left",lw);
		this.center.css("right",rw);
		this.center.css("top",th);
		this.center.css("bottom",bh+1);
		if($.browser.msie() && $.browser.version()=="7.0"){
			this.center.find("iframe").height(this.center.height());
			$(window).resize(function(){
				layout.center.find("iframe").height(layout.center.height());
			});
		}
		if(this.leftDivide){
			this.leftDivide.css({"left":lw-gap,top:th,bottom:bh});
		}
	}
	this.resize();
	$(window).resize(function(){
		layout.resize();
	});
};
Eht.Layout.prototype.resize=function(){
	//var winHeight = this.selector==null?$(window).height():(this.selector.height()-Eht.Utils.getPaddingHeight(this.selector));
	//var winWidth = this.selector==null?$(window).width():(this.selector.width()-Eht.Utils.getPaddingWidth(this.selector));
	if(this.leftTitle){
		var h = this.left.height()-this.leftTitle.outerHeight(true)-Eht.Utils.getMPBHeight(this.opt.left.selector);
		$(this.opt.left.selector).height(h);
	}
	if(this.centerTitle){
		var h = this.center.height()-this.centerTitle.outerHeight(true)-Eht.Utils.getMPBHeight(this.opt.center.selector);
		$(this.opt.center.selector).height(h);
	}
	if(this.rightTitle){
		var h = this.right.height()-this.rightTitle.outerHeight(true)-Eht.Utils.getMPBHeight(this.opt.right.selector);
		$(this.opt.right.selector).height(h);
	}
	/*
	var pl = parseInt($(this.selector).css("margin-left")?$(this.selector).css("margin-left"):0);
	pl = isNaN(pl)?0:pl;
	var pr = parseInt($(this.selector).css("margin-right")?$(this.selector).css("margin-right"):0);
	pr = isNaN(pr)?0:pr;
	if(this.left){
		this.left.css("margin-left",pl);
	}else{
		this.center.css("margin-left",pl);		
	}
	if(this.right){
		this.right.css("margin-right",pr);
	}else{
		this.center.css("margin-right",pr);
	}
	if(this.top){
		this.top.css("margin-left",pl);
		this.top.css("margin-right",pr);
	}
	if(this.bottom){
		this.bottom.css("margin-left",pl);
		this.bottom.css("margin-right",pr);
	}
	*/
};
Eht.Layout.prototype.setTitle=function(type,title){
	// type:left,right,center,top,bottom
	if(this[type+"Title"]){
		this[type+"Title"].html(title);
	};
};
$.browser={
		userAgent:function(){
			return navigator.userAgent.toLowerCase();
		},
		version:function(){return (this.userAgent().match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1];},
        safari:function(){return /webkit/.test(this.userAgent());},
        opera:function(){return /opera/.test(this.userAgent());},
        msie:function(){return /msie/.test(this.userAgent()) && !/opera/.test(this.userAgent());},
        mozilla:function(){ return /mozilla/.test(this.userAgent()) && !/(compatible|webkit)/.test(this.userAgent());}
};