Eht.ComboBox=function(opt){
	var def = {
			selector:null,
			feature:new Eht.ComboPanel(),
			icon:"eht-combobox-downarr-icon",
			overIcon:"eht-combobox-downarr-hover",
			labelField:"label",//多字段用 "," 分割
			valueField:"value",
			readOnly:true,
			width:200,
			filterField:[]//检索字段,默认是当前显示属性 及 value值属性  this.labelField,this.valueField
		};
	this.opt = $.extend(def,opt);
	this.opt.feature.opt.labelField = this.opt.labelField;
	this.opt.feature.opt.valueField = this.opt.valueField;
	this.container = $("<div class='eht-combobox'></div>");
	this.button = $("<span class='eht-combobox-basic-icon'></span>");
	this.comboPanel = $("<div class='eht-combobox-combo-panel' style='display:none;position:absolute;'></div>");
	this.comboPanel.attr("uuid",Eht.Utils.createUuid());
	this.button.addClass(this.opt.icon);
	this.button.addClass(this.opt.overIcon);
	this.feature = this.opt.feature;
	if(this.opt.filterField==null || this.opt.filterField.length==0){
		this.opt.filterField = [this.opt.labelField,this.opt.valueField];
	}
	if(this.opt.selector!=null){
		this.init(this.opt.selector);
	}
	
};
Eht.ComboBox.prototype.init=function(selector){
	var combo = this;
	this.selector = $(selector);
	this.selector.attr("readOnly",this.opt.readOnly);
	this.name = this.selector.attr("name");
	if(!(this.feature instanceof Eht.DatePicker)){
		this.hidden = $("<input type='hidden'/>");
		this.hidden.attr("name",this.name);
		this.hidden.attr("parent",this.selector.attr("parent"));
		this.hidden.attr("group",this.selector.attr("group"));
		this.selector.removeAttr("name");
	}
	this.selector.css({"vertical-align":"middle","padding-right":"20px"});
	this.selector.width(this.selector.width() - 20);
	this.selectedData = null;
	this.container.insertBefore(this.selector);
	this.container.append(this.selector);
	this.container.append(this.button);
	if(!(this.feature instanceof Eht.DatePicker)){
		this.container.append(this.hidden);
	}
	//$(document.body).append(this.comboPanel);
	this.container.append(this.comboPanel);
	if(this.selector.attr("disabled")){
		this.disable();
	}
	if(this.feature instanceof Eht.Datagrid){
		if(this.opt.width<440){
			this.opt.width = 440;
		}
	}
	this.comboPanel.width(this.opt.width);
	this.button.unbind("click").bind('click',function(e){
		if($(this).attr("disable")==undefined){
			combo.selector.focus();
			combo.shrink();
		}
		e.stopPropagation();
		return false;
	});
	this.comboPanel.unbind("click").bind('click',function(e){
		e.stopPropagation();
		return false;
	});
	this.selector.focus(function(){
		$(this).addClass("eht-combobox-text-bgcolor");
	});
	this.selector.blur(function(){
		$(this).removeClass("eht-combobox-text-bgcolor");
	});
	this.selector.unbind("click").bind('click',function(e) {
		combo.shrink();
		e.stopPropagation();
		return false;
	});
	this.selector.unbind("keyup").bind("keyup",function(e){
		if(!$(this).attr("readOnly")){
			if(e.keyCode!=38 && e.keyCode!=40 && e.keyCode!=39 && e.keyCode!=37 && e.keyCode!=13){
				rowIndex = 0;
				var obj = new Object();
				var rows = new Array();
				
				var val = $(this).val();
				var filters = combo.opt.filterField;
				if(combo.getData() && val.trim()!=""){
					if(filters.length>0){
						for(var i=0;i<combo.getData().length;i++){
							for(var j=0;j<filters.length;j++){
								var s = combo.getData()[i][filters[j]];
								if(s!=null||s!=undefined){
									if(s.search(val)!=-1){
										rows.push(combo.getData()[i]);
										break;
									}
								}
							}
						}
						if($.type(combo.data)=="object"){
							obj.paginate = combo.data.paginate;
							obj.rows = rows;
						}
						if($.type(combo.data)=="array"){
							obj = rows;
						}
						combo.loadData(obj,true);
					}
				}else{
					combo.loadData(combo.getData(),true);
				}
				combo.shrink();
			}
		}else{
			if(e.keyCode==9){
				combo.shrink();
			}
		}
	});
	var rowIndex = 0;
	this.selector.unbind("keydown").bind("keydown",function(e){
			switch(e.keyCode){
				case 38: //向上箭头 
					var cnt = combo.feature.data.length;
					if(rowIndex>=cnt-1){
						rowIndex=cnt-1;
					}
					if(rowIndex<=0){
						rowIndex=0;
					}
					var row = combo.feature.getSelectedRow(rowIndex--);
					$(this).data(row.data());
					break;
				case 40: //向下箭头
					combo.comboPanel.show(100);
					var cnt = combo.feature.data.length;
					if(rowIndex>=cnt-1){
						rowIndex=cnt-1;
					}
					if(rowIndex<=0){
						rowIndex=0;
					}
					var row = combo.feature.getSelectedRow(rowIndex++);
					$(this).data(row.data());
					break;
				case 13:
					if(combo._changeBefore){
						combo._changeBefore($(this).data());
					}
					combo.selector.val($(this).data()[combo.opt.labelField]);
					combo.hidden.val($(this).data()[combo.opt.valueField]);
					if(combo._change){
						combo._change($(this).data());
					}
					combo.selectedData = $(this).data();
					combo.comboPanel.hide(100);
					break;
			}
	});
	$(document).click(function(){
		$(".eht-combobox-combo-panel").hide(100);
	});
	this.comboPanel.append(this.feature.container);
	this.bindFeatureEvent();
};
/*收起其他的打开的下列选择项目*/
Eht.ComboBox.prototype.shrink=function(){
	var combo = this;
	this.comboPanel.append(this.feature.container);
	var top = combo.selector.position().top + combo.selector.outerHeight(true) - Eht.Utils.getMarginHeight(combo.selector) + 2;
	var left = combo.selector.position().left;
	combo.comboPanel.css({position:"absolute",top:top,left:left});
	var cbp = $(".eht-combobox-combo-panel");
	cbp.each(function(i,item){
		if($(item).attr("uuid")!=combo.comboPanel.attr("uuid")){
			$(item).hide(100);
		}else{
			if(combo.feature instanceof Eht.DatePicker){
				$(item).show(100,function(){
					if(combo.feature.resize){
						combo.feature.resize();
					};
				});
			}else{
				if(combo.feature.selector)
					combo.feature.selector.show();
				if(combo.feature.container)
					combo.feature.container.show();
				$(item).show(100,function(){
					if(combo.feature.resize){
						combo.feature.resize();
					};
				});
			}
		}
	});
	this.bindFeatureEvent();
};
Eht.ComboBox.prototype.setFeature=function(ehtui){
	if(ehtui!=null){
		this.feature = ehtui;
		this.opt.feature = ehtui;
		if(this.feature instanceof Eht.Datagrid){
			if(this.opt.width<440){
				this.opt.width = 440;
			}
			if(this.feature.data && this.feature.data.length>0){
				this.feature.loadData(this.feature.data);
			}else{
				this.feature.refresh();
			}
			this.comboPanel.width(this.opt.width);
		}
		if(this.feature instanceof Eht.DatePicker){
			var nm = this.container.find("input[type='hidden']").attr("name");
			if(nm){
				this.container.find("input[type='text']").attr("name",nm);
			}
			this.container.find("input[type='hidden']").removeAttr("name");
		}
		this.comboPanel.children().remove();
		this.comboPanel.append(this.feature.container);
		this.bindFeatureEvent();
	}
};
Eht.ComboBox.prototype.disable=function(){
	this.selector.disable();
	this.button.addClass("eht-buttonbar-disable");
	this.button.attr("disable",true);
	this.button.hide();
};
Eht.ComboBox.prototype.enable=function(){
	this.selector.enable();
	this.button.removeClass("eht-buttonbar-disable");
	this.button.removeAttr("disable");
	this.button.show();
};
Eht.ComboBox.prototype.setReadOnly=function(read){
	this.opt.readOnly=read;
	this.selector.attr("readOnly",this.opt.readOnly);
};
Eht.ComboBox.prototype.loadData=function(object){
	var combo = this;
	this._loadDataParam = object;
	if(this.feature==null){
		this.feature = new Eht.ComboPanel({
			labelField:combo.opt.labelField,
			valueField:combo.opt.valueField
		});
	}
	if($.type(object)!="function"){
		if(arguments.length==1){
			this.data = object;
		}
	}else{
		this._func = object;
	}
	if(this.feature.loadData)
	this.feature.loadData(object);
};
Eht.ComboBox.prototype.refresh=function(){
	this.loadData(this._loadDataParam);
};
Eht.ComboBox.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.ComboBox.prototype.bindFeatureEvent=function(){
	var combo = this;
	if(this.feature instanceof Eht.DatePicker){
		this.feature.click(function(value){
			combo.selector.val(value);
			if(combo._change){
				combo._change(value);
			}
			$(".eht-combobox-combo-panel").hide(100);
		});
	}
	if(this.feature.loadComplete){
		this.feature.loadComplete(function(data){
			combo.data = data;
			if(combo._loadComplete){
				combo._loadComplete(data);
			}
		});
	}
	if(this.feature.clickPage){
		this.feature.clickPage(function(page){
			if(combo._func){
				combo._func(page,this.loadResp);
			}
		});
	}
	if(this.feature.clickRow){
	this.feature.clickRow(function(data){
		if(combo._changeBefore){
			combo._changeBefore(data);
		}
		combo.selector.val(data[combo.opt.labelField]);
		combo.hidden.val(data[combo.opt.valueField]);
		if(combo._change){
			combo._change(data);
		}
		combo.selectedData = data;
		combo.comboPanel.hide(100);
	});
	}
};
Eht.ComboBox.prototype.changeBefore = function(func){
	//func(itemdata)
	this._changeBefore = func;
};
Eht.ComboBox.prototype.change = function(func){
	//func(itemdata)
	this._change = func;
};
Eht.ComboBox.prototype.getSelectedData=function(){
	return this.selectedData;
};
Eht.ComboBox.prototype.getValue=function(){
	var rtn = null;
	if(this.feature instanceof Eht.DatePicker){
		rtn = this.selector.val();
	}else{
		rtn = this.hidden.val();
	}
	return rtn;
};

Eht.ComboBox.prototype.setValue=function(value){
	if(this.feature instanceof Eht.DatePicker){
		this.selector.val(value);
		this.feature.setValue(value);
	}else{
		this.hidden.val(value);
		for(var i=0;i<this.getData().length;i++){
			if(this.getData()[i][this.opt.valueField]==value){
				this.selector.val(this.getData()[i][this.opt.labelField]);
				break;
			}
		}
	}
};
Eht.ComboBox.prototype.getData=function(){
	var rtn = new Array();
	if($.type(this.data)=="object" && this.data.rows){
		rtn = this.data.rows;
	}
	if($.type(this.data)=="array"){
		iter(this.data);
	}
	function iter(ds){
		for(var i=0;i<ds.length;i++){
			rtn.push(ds[i]);
			if(ds[i].children && ds[i].children.length>0){
				iter(ds[i].children);
			}
		}
	}
	return rtn;
};

Eht.ComboPanel = function(opt){
	var def = {
		selector:null,
		labelField:"label",
		valueField:"sysid"
	};
	this.opt = $.extend(def,opt);
	this.selector = this.opt.selector==null?$("<ul class='eht-combopanel'></ul>"):$(this.opt.selector);
	this.container = $("<div class='eht-combopanel-combopanel'></div>");
	this.container.append(this.selector);
};
Eht.ComboPanel.prototype.loadData=function(data){
	var combo = this;
	if(data){
		this.selector.children().remove();
		if($.type(data)=="array"){
			this.data = data;
			for(var i=0;i<this.data.length;i++){
				this.addItem(this.data[i]);
			}
		}
		if($.type(data)=="object"){
			this.data = data.rows;
			for(var i=0;i<this.data.length;i++){
				this.addItem(this.data[i]);
			}
		}
		if(combo._loadComplete){
			combo._loadComplete(this.data);
		}
		if($.type(data)=="function"){
			this._loadData = data;
			var res = new Eht.Responder();
			res.success=function(ds){
				combo.loadData(ds);
			};
			this._loadData(res);
		}
	}
};
Eht.ComboPanel.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.ComboPanel.prototype.addItem=function(data){
	var combo = this;
	var item = $("<li></li>");
	item.data(data);
	if(this._transLabel){
		item.html(this._transLabel(data));
	}else{
		item.html(data[this.opt.labelField]);
	}
	this.selector.append(item);
	item.click(function(){
		if(combo._clickRow){
			combo._clickRow($(this).data());
		}
	});
};
Eht.ComboPanel.prototype.transLabel=function(func){
	// func(data)
	this._transLabel = func;
};
Eht.ComboPanel.prototype.clickRow=function(func){
	//func(data)
	this._clickRow = func;
};
Eht.ComboPanel.prototype.getSelectedRow=function(rowIndex){
	this.selector.children("li").removeClass("eht-combopanel-selected");
	var li = this.selector.children("li").eq(rowIndex);
	li.addClass("eht-combopanel-selected");
	var litop = li.offset().top - this.container.offset().top;
	if(litop + li.outerHeight(true) + this.container.scrollTop() > this.container.height()){
		this.container.scrollTop(litop + li.outerHeight(true) + this.container.scrollTop() - this.container.height());
	}else{
		this.container.scrollTop(0);
	}
	return li;
};