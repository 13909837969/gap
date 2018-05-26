/**
 * ui toolbar 类
 * @author wangbao
 */
Eht.Toolbar=function(opt){
	var toolbar = this;
	var def = {
		selector:null,
		fixed:false,
		delay:true
	};
	this.opt=$.extend(def,opt); 
	this.selector = $(this.opt.selector);
	this._disable = new Object();
	this.selector.addClass("eht-base");
	this.selector.addClass("eht-basebar");
	this.selector.addClass("eht-toolbar");
	this.init();
};
Eht.Toolbar.prototype.init=function(){
	var toolbar = this;
	var selor = "a,label";
	if(arguments.length>0 && arguments[0]=="dynamic"){
		selor = "a[dynamic],label[dynamic]";
	}
	this.selector.children(selor).each(function(i,item){
		var lbl = $(item).html();
		$(item).addClass("eht-buttonbar");
		$(item).addClass("eht-buttonbar-hover");
		$(item).html("");
		
		if($(item).attr("disable")=="true"){
			$(item).removeClass("eht-buttonbar-hover").addClass("eht-buttonbar-disable");
			toolbar._disable[$(this).attr("id")]=true;
			$(item).find("input").disable();
		}
		
		if($(item).attr("icon")){
			var icon = $('<span class="eht-button-icon"></span>');
			icon.addClass($(item).attr("icon"));
			$(item).append(icon);
		}
		var caret = '';
		if($(item).attr("target")){
			caret = '<i class="caret"></i>';
		}
		$(item).append("<span>"+lbl+caret+"</span>");

		if($(item).attr("target")){
			toolbar.selector.find($(item).attr("target")).addClass("eht-toolbar-menudown").hide();
		}
		$(item).unbind("click").bind("click",function(e){
			var r = true;
			var $this = $(this);
			toolbar.selector.find("a[target]").each(function(){
				var t = toolbar.selector.find($(this).attr("target"));
				t.hide();
				t.children().each(function(r,item){
					$(item).unbind("click").bind("click",function(){
						if(toolbar._click){
							toolbar._click($(this).attr("id"),$(this),e);
						}
					});
				});
			});
			
			if($(this).attr("target")){
				r = false;
				if($(this).attr("disable")==undefined){
					var tg = toolbar.selector.find($(item).attr("target"));
					tg.show();
					var l = $this.position().left;
					var t = toolbar.selector.position().top;
					tg.css({left:l,top:t + toolbar.selector.height()});
					$(document).unbind("click").bind("click",function(){
						toolbar.selector.find("a[target]").each(function(){
							var t = toolbar.selector.find($(this).attr("target"));
							t.hide();
						});
					});
				}
			}else{
				if(toolbar._click){
					if($(this).attr("disable")==undefined){
						if(toolbar.opt.delay==true || $(this).attr("delay")=="true"){
							$(this).attr("disable",true);
							$(this).removeClass("eht-buttonbar-hover").addClass("eht-buttonbar-disable");
						}
						toolbar._click($(this).attr("id"),$(this),e);
						if(toolbar.opt.delay==true || $(this).attr("delay")=="true"){
							var __id = $(this).attr("id");
							setTimeout(function(){
								if(toolbar._disable[__id]!=true){
									$this.removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
									$this.removeAttr("disable");
									toolbar._disable[__id] = false;
								}
							},800);
						}
					}
				}
			}
			return r;
		});
		$(item).unbind("dblclick").bind("dblclick",function(){
			var $this = $(this);
			if(toolbar._dblclick){
				if($(this).attr("disable")==undefined){
					setTimeout(function(){
						$this.attr("disable",true);
					},100);
					$(this).removeClass("eht-buttonbar-hover").addClass("eht-buttonbar-disable");
					toolbar._dblclick($(this).attr("id"),$(this));
					var __id = $(this).attr("id");
					setTimeout(function(){
						if(toolbar._disable[__id]!=true){
							$this.removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
							$this.removeAttr("disable");
							toolbar._disable[__id] = false;
						}
					},800);
				}
			}
		});
	});
	this.selector.children().not("a").each(function(){
		$(this).css("vertical-align", "middle");
	}
	);
	if(this.opt.fixed){
		this.selector.css("position","fixed");
		this.selector.css("width","100%");
		this.selector.after("<div style='height:"+this.selector.outerHeight(true)+"px'></div>");
		$(window).resize(function(e){
			toolbar.selector.css("width","100%");
		});
	}
}
Eht.Toolbar.prototype.disable=function(selector){
	var bar = this;
	if(selector){
		this.selector.find(selector).removeClass("eht-buttonbar-hover").addClass("eht-buttonbar-disable");
		this.selector.find(selector).attr("disable",true);
		this.selector.find(selector).each(function(){
			bar._disable[$(this).attr("id")]=true;
		});
		this.selector.find(selector).find("input").disable();
	}else{
		this.selector.children("a,label").removeClass("eht-buttonbar-hover").addClass("eht-buttonbar-disable");
		this.selector.children("a,label").attr("disable",true);
		this.selector.find("a,label").each(function(){
			bar._disable[$(this).attr("id")]=true;
		});
		this.selector.find("a,label").find("input").disable();
	}
};
Eht.Toolbar.prototype.enable=function(selector){
	var bar = this;
	if(selector){
		this.selector.find(selector).removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.find(selector).removeAttr("disable");
		this.selector.find(selector).each(function(){
			bar._disable[$(this).attr("id")]=false;
		});
		this.selector.find(selector).find("input").enable();
	}else{
		this.selector.children("a,label").removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.children("a,label").removeAttr("disable");
		this.selector.find("a,label").each(function(){
			bar._disable[$(this).attr("id")]=false;
		});
		this.selector.find("a,label").find("input").enable();
	}
};
Eht.Toolbar.prototype.hide=function(selector){
	if(selector){
		this.selector.find(selector).removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.find(selector).removeAttr("disable");
		this.selector.find(selector).hide();
	}else{
		this.selector.children("a").removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.children("a").removeAttr("disable");
		this.selector.children("a").hide();
	}
};
Eht.Toolbar.prototype.show=function(selector){
	if(selector){
		this.selector.find(selector).removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.find(selector).removeAttr("disable");
		this.selector.find(selector).show();
	}else{
		this.selector.children("a").removeClass("eht-buttonbar-disable").addClass("eht-buttonbar-hover");
		this.selector.children("a").removeAttr("disable");
		this.selector.children("a").show();
	}
};
Eht.Toolbar.prototype.click=function(func){
	// func(id,this,e)
	if(func && $.isFunction(func)){
		this._click = func;
	}else{
		if(func && $.type(func)=="string" && this._click){
			this._click(func);
		}
	}
};
Eht.Toolbar.prototype.dblclick=function(func){
	// func(id)
	if(func && $.isFunction(func)){
		this._dblclick = func;
	}else{
		if(func && $.type(func)=="string" && this._dblclick){
			this._dblclick(func);
		}
	}
};
Eht.Toolbar.prototype.setIcon=function(id,iconClass){
	this.selector.find("#"+id +" .eht-button-icon").removeClass().addClass("eht-button-icon").addClass(iconClass);
};
Eht.Toolbar.prototype.extradata=function(id,data){
	if(this.data==null){
		this.data = new Object();
	}
	if(data!=null || data!=undefined){
		this.data[id]=data;
	}
	return this.data[id];
};
Eht.Toolbar.prototype.setTips=function(id,tips){
	this.selector.find("#"+id).attr("title",tips);
};
Eht.Toolbar.prototype.setLabel=function(id,label){
	if(this.selector.find("#" + id).children("span").length>1){
		this.selector.find("#" + id).children("span").eq(1).html(label);
	}
};
Eht.Toolbar.prototype.addItem=function(data){
	var def = {icon:null,label:null,id:null,disable:null}
	var a = $("<a dynamic='dynamic' id='"+data.id+"' icon='"+data.icon+"'>"+data.label+"</a>");
	if(data.disable){
		a.attr("disable","true");
	}
	this.selector.append(a);
	this.init("dynamic");
	a.removeAttr("dynamic");
}