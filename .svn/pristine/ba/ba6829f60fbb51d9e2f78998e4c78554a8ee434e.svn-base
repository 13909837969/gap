Eht.Autocomplete = function(opt){
	var ac = this;
	var def = {
		selector:null,//input text
		labelField:"label",
		valueField:"value",
		offsetLeft:0,
		offsetTop:0,
		offsetWidth:0
	};
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	
	this.container = $("<div class='eht_auto_complete_div'></div>");
	this.ul = $("<ul></ul>");
	this.container.append(this.ul);
	
	$(document.body).find(".eht_auto_complete_div").remove();
	$(document.body).append(this.container);
	this.resize();
	this.container.hide();
	this.res = new Eht.Responder();
	this.res.success=function(data){
		ac.ul.empty();
		var ds = [];
		if($.isArray(data)){
			ds = data;
		}
		if($.type(data)=="object"){
			if(data.rows){
				ds = data.rows;
			}
		}
		if(ds.length>0){
			ac.container.show();
		}else{
			ac.container.hide();
		}
		for(var i=0;i<ds.length;i++){
			var li=$("<li></li>");
			li.data(ds[i]);
			ac.ul.append(li);
			li.attr("index",i);
			if(ac._renderer){
				li.html(ac._renderer(ds[i]));
			}else{
				li.html(ds[i][ac.opt.labelField]);
			}
			li.unbind("click").bind("click",function(){
				ac.selector.val($(this).data(ac.opt.valueField));
				ac.container.hide();
				if(ac._click){
					ac._click($(this).data());
				}
			});
		}
	};
	var keyIndex = -1;
	this.selector.unbind("keyup").bind("keyup",function(e){
		if(e.keyCode==38){//up
			keyIndex --;
			if(keyIndex<0){
				keyIndex = ac.ul.find("li").size()-1;
			}
			var d = ac.ul.find("li[index='"+keyIndex+"']").data();
			var v = d[ac.opt.valueField];
			ac.ul.find("li").removeClass("eht_auto_complete_item");
			ac.ul.find("li[index='"+keyIndex+"']").addClass("eht_auto_complete_item");
			
			$(this).val(v);
			if(ac._keyup){
				ac._keyup(d);
			}
			if(ac._click){
				ac._click(d);
			}
		}
		if(e.keyCode==40){//down
			keyIndex ++;
			if(keyIndex>ac.ul.find("li").size()-1){
				keyIndex = 0;
			}
			var d = ac.ul.find("li[index='"+keyIndex+"']").data();
			var v = d[ac.opt.valueField];
			ac.ul.find("li").removeClass("eht_auto_complete_item");
			ac.ul.find("li[index='"+keyIndex+"']").addClass("eht_auto_complete_item");
			$(this).val(v);
			if(ac._keyup){
				ac._keyup(d);
			}
			if(ac._click){
				ac._click(d);
			}
		}
		if(e.keyCode==13){
			ac.container.hide();
			if(ac._click){
				var d = ac.ul.find("li[index='"+keyIndex+"']").data();
				ac._click(d);
			}
		}
		if(e.keyCode!=38 && e.keyCode!=40 && e.keyCode!=13){
			ac._loadData($(this).val(),ac.res);
		}
	});
	
	$(window).resize(function(){
		ac.resize();
	});
	$(window).click(function(e){
		ac.container.hide();
	});
};
Eht.Autocomplete.prototype.resize=function(){
	var t = this.selector.offset().top+this.selector.outerHeight(true) + this.opt.offsetTop;
	var l = this.selector.offset().left + this.opt.offsetLeft;
	this.container.css({position:"absolute",top:t,left:l});
	this.container.width(this.selector.outerWidth(true) + this.opt.offsetWidth);
};
Eht.Autocomplete.prototype.loadData=function(data){
	//data: function(value,res)
	if($.isFunction(data)){
		this._loadData = data;
	}
};
Eht.Autocomplete.prototype.renderer=function(func){
	//func(data)  return html
	this._renderer = func;
};
Eht.Autocomplete.prototype.keyup=function(func){
	//func(data)
	this._keyup = func;
};
Eht.Autocomplete.prototype.click=function(func){
	//func(data)
	this._click = func;
};