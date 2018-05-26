Eht.Accordion = function(opt){
	var accordion = this;
	var def = {
		selector:null,
		labelField:"label",
		childrenField:"children",
		openIndex:0,
		duration:200
	};
	this.opt=$.extend(def,opt);
	this.selector = $(this.opt.selector);
	var itemAttr = [];
	if(this.selector.children().length>0){
		this.data = new Array();
		this.selector.children().each(function(){
			var d = new Object();
			d[accordion.opt.labelField] = $(this).attr(accordion.opt.labelField);
			accordion.data.push(d);
			itemAttr.push($(this).remove());
		});
	}
	this.ul = $("<ul class='eht-base eht-accordion'></ul>");
	this.selector.append(this.ul);
	
	if(this.data && this.data.length>0){
		for(var i=0;i<this.data.length;i++){
			this.addItem(this.data[i],itemAttr[i]);
		}
		this.resize();
		this.expansion(this.opt.openIndex);
	}
	this.resize();
	
	$(window).resize(function(){
		accordion.resize();
	});
};
Eht.Accordion.prototype.loadData=function(object){
	var accordion = this;
	if($.type(object)=="array"){
		this.data = object;
		for(var i=0;i<object.length;i++){
			this.addItem(object[i]);
		}
	}
	if($.type(object)=="object"){
		this.data = [];
		this.data.push(object);
	}
	if($.type(object)=="function"){
		this.loadResp = new Eht.Responder();
		this._loadFunc = object;
		this.loadResp.success=function(data){
			accordion.loadData(data);
		};
		this._loadFunc(this.loadResp);
	}
	this.resize();
	this.expansion(this.opt.openIndex);
};
Eht.Accordion.prototype.addItem = function(data,itemSelector){
	var accordion = this;
	var li = $("<li class='eht-accordion-item'></li>");
	li.data(data);
	var h3 = $("<h3 class='header'></h3>");
	var div = $("<div class='body' style='display:none'></div>");
	div.attr("uuid",Eht.Utils.createUuid());
	h3.html(data[this.opt.labelField]);
	
	h3.click(function(){
		accordion.ul.find(".selected-header").removeClass("selected-header");
		$(this).addClass("selected-header");
		
		var body = $(this).parent().find(".body");
		accordion.ul.find(".body").each(function(){
			if(body.attr("uuid")==$(this).attr("uuid")){
				$(this).show(accordion.opt.duration);
			}else{
				$(this).hide(accordion.opt.duration);
			}
		});
	});
	
	li.append(h3);
	li.append(div);
	if(itemSelector==undefined){
		if(data[this.opt.childrenField]){
			if(!hasChildren(data)){
				for(var i=0;i<data[this.opt.childrenField].length;i++){
					var item = $("<a class='item'></a>");
					item.data(data[this.opt.childrenField][i]);
					item.html(data[this.opt.childrenField][i][this.opt.labelField]);
					div.append(item);
					item.unbind("click").bind("click",function(){
						accordion.ul.find(".selected-item").removeClass("selected-item");
						$(this).addClass("selected-item");
						if(accordion._click){
							accordion._click($(this).data());
						}
					});
				}
			}else{//accordion 末节点（item)的数据含有子数据节点时，生成 tree
				var tree = new Eht.Tree({selector:div,labelField:accordion.opt.labelField,
					childrenField:accordion.opt.childrenField});
				tree.loadData(data[this.opt.childrenField]);
				tree.clickRow(function(data){
					if(data[accordion.opt.childrenField]==undefined || data[accordion.opt.childrenField].length==0){
						if(accordion._click){
							accordion._click(data);
						}
					}
				});
				tree.resize=function(){};
			}
		}
	}else{
		div.append(itemSelector);
	}
	this.ul.append(li);
	
	function hasChildren(itemdata){
		var rtn = false;
		if(itemdata.children){
			for(var i=0;i<itemdata.children.length;i++){
				if(itemdata.children[i].children && 
						itemdata.children[i].children.length > 0){
					rtn = true;
					break;
				}
			}
		}
		return rtn;
	}
};
/**
 * 展开
 */
Eht.Accordion.prototype.expansion=function(itemIndex){
	var accordion = this;
	this.ul.find(".body").each(function(i,item){
		if(i==itemIndex){
			$(item).show(accordion.opt.duration);
		}else{
			$(item).hide(accordion.opt.duration);
		}
	});
};
Eht.Accordion.prototype.click=function(func){
	//func(data)
	this._click = func;
};
Eht.Accordion.prototype.resize=function(){
	this.selector.height(this.selector.parent().height());
	this.ul.height(this.selector.height());
	
	var hh = 0;
	this.ul.find(".header").each(function(){
		hh+=$(this).outerHeight(true) + Eht.Utils.getMPBHeight($(this).parent());
	});
	this.ul.find(".body").height(this.ul.height()-hh);
};