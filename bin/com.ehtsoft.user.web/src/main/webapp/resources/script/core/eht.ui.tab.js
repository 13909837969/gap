Eht.Tab=function(opt){
	var tab = this;
	var def = {
		selector:null,
		position:"top",
		labelField:"label",
		idField:"_id",
		selectedField:"selected",
		headerHeight:28,
		showClose:false,
		iframe:false,
		loadHtml:false,//非 iframe 存在 url 并且 loadHtml 值为 true 时, tab 标签自动加 url 页面到  tab body 中
		srcField:"url",
		lazyLoad:false //针对iframe的懒加载，在addTab 时，不加载iframe 数据，只有在点击 tab 标签的时候，加载iframe 数据 （防止循环加载iframe产生的性能问题）
	};
	this.opt = $.extend(def,opt);
	this.container = $(this.opt.selector);
	this.container.addClass("eht-base");
	
	this.header = $("<div class='eht-tab-header'></div>");
	this.header.height(this.opt.headerHeight);
	this.tabHeader = $("<table style='border:0px;'><tr style='border:0px;'></tr></table>");
	this.body = $("<div class='eht-tab-body'></div>");
	this.header.append(this.tabHeader);
	this.container.children("div["+this.opt.labelField+"]").each(function(i){
		if($(this).attr("id")==undefined){
			$(this).attr("id","tab_" + i);
		}
		tab.body.append($(this));
		var obj = new Object();
		obj[tab.opt.idField] = $(this).attr("id"); 
		obj[tab.opt.labelField]=$(this).attr(tab.opt.labelField);
		if($(this).attr(tab.opt.selectedField) || this.getAttribute(tab.opt.selectedField)){
			obj[tab.opt.selectedField]=true;
		}
		tab.addTab(obj);
	});
	
	this.container.append(this.header);
	this.container.append(this.body);
	
	this.resize();
	
	$(window).resize(function(){
		tab.resize();
	});
};
Eht.Tab.prototype.addTab=function(data){
	var tab = this;
	var def = {
		label:"",
		url:"",
		iframe:false,
		loadHtml:false,
		showClose:false,
		param:null // 数据位 当前 tab 页中的参数，该参数为JSON 对象格式，数据参数主要提供给iframe子页面调用，调用方法为 Eht.WindowManger.getParameter()
	};
	if(data[tab.opt.idField]==undefined){
		data[tab.opt.idField] = Eht.Utils.createUuid();
	};
	if(this.tabHeader.find("#"+data[this.opt.idField]).size()==0){
		// header
		var td = $("<td class='eht-tab-base-item eht-tab-item-nomal'></td>");
		td.attr("id",data[this.opt.idField]);
		td.append(data[this.opt.labelField]);
		td.data(data);
		var closebtn = $("<a class='eht-tab-item-close'></a>");
		if(this.opt.showClose==true || data.showClose==true){
			td.append(closebtn);
		}
		this.tabHeader.find("tr").eq(0).append(td);
	
		// body
		if(this.body.find("#"+data[this.opt.idField]).size()==0){
			var div = $("<div style='border:0px;'></div>");
			div.attr("id",data[this.opt.idField]);
			div.height(this.body.height());
			div.width(this.body.width());
			if(this.opt.iframe==true || data.iframe==true){
				var iframe = $('<iframe frameborder="0"></iframe>');
				iframe.height(this.body.height());
				iframe.width(this.body.width());
				div.append(iframe);
				var url = data[this.opt.srcField];
				if(data.param!=null){
					if(url.search("\\?")!=-1){
						url = url + "&param=" + JSON.stringify(data.param); 
					}else{
						url = url + "?param=" + JSON.stringify(data.param); 
					}
				}
				if(this.opt.lazyLoad==false){
					iframe.attr("src",url);
				}else{
					iframe.attr("url",url);
				}
			}else{
				if(this.opt.loadHtml==true || data.loadHtml==true){
					jQuery.ajax({				
						type: 		"GET",
						url:  		data[this.opt.srcField],
						data: 		data.param,
						dataType: 	"html",
						async: 		true,
						context:{tabContent:div,data:data},
						complete : function(res, status) {
							this.tabContent.html(res.responseText);
							if(tab._addTabComplete){
								tab._addTabComplete(this.data,res.responseText,this.tabContent);
							}
							if(tab._loadComplete){
								tab._loadComplete(res.responseText,this.tabContent);
							}
						}					
					});
				}
			}
			this.body.append(div);
			
			this.tabHeader.find(".eht-tab-base-item").removeClass("eht-tab-item-active").addClass("eht-tab-item-nomal");
			this.tabHeader.find(".eht-tab-base-item").removeAttr("selected");
			this.body.children().hide();
			
			this.tabHeader.find("#"+div.attr("id")).removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
			this.tabHeader.find("#"+div.attr("id")).attr("selected",true);
			div.show();
		}else{
			if(data[this.opt.selectedField]){
				td.removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
				td.attr("selected",true);
				this.body.find("#"+data[this.opt.idField]).show();
			}else{
				this.body.find("#"+data[this.opt.idField]).hide();
				td.removeAttr("selected");
			}
		}
		td.unbind("click").bind("click",function(e){
			if(tab._clickBefore!=undefined || tab._clickBefore!=null){
				if(tab._clickBefore($(this).index(),$(this).data())==false){
					return;
				}
			}
			$(this).parent().children().removeClass("eht-tab-item-active").addClass("eht-tab-item-nomal");
			$(this).parent().children().removeAttr("selected");
			tab.body.children().hide();
			
			$(this).removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
			$(this).attr("selected",true);
			var cdiv = tab.body.find("#"+$(this).attr("id"));
			cdiv.show();
			if(tab.opt.lazyLoad==true && cdiv.find("iframe").attr("url")!=undefined){
				cdiv.find("iframe").attr("src",cdiv.find("iframe").attr("url"));
				cdiv.find("iframe").removeAttr("url");
			}
			if(tab._click){
				tab._click($(this).index(),$(this).data());
			}
		});
		closebtn.unbind("click").bind("click",function(e){
			if(tab._closeBefore){
				if(tab._closeBefore($(this).parent().index(),$(this).parent().data())==false){
					return;
				}
			}
			var prev = $(this).parent().prev();
			var next = $(this).parent().next();
			
			var ctd = $(this).parent().remove();
			tab.body.find("#"+ctd.attr("id")).remove();
			if(tab.tabHeader.find("td[selected]").size()==0){
				if(prev.size()>0){
					prev.click();
				}
				if(next.size()>0){
					next.click();
				}
			}
			return false;
		});
	}else{
		this.tabHeader.find(".eht-tab-base-item").removeClass("eht-tab-item-active").addClass("eht-tab-item-nomal");
		this.tabHeader.find(".eht-tab-base-item").removeAttr("selected");
		this.body.children().hide();
		
		this.tabHeader.find("#"+data[this.opt.idField]).removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
		this.tabHeader.find("#"+data[this.opt.idField]).attr("selected",true);
		this.body.find("#"+data[this.opt.idField]).show();
	}
};
Eht.Tab.prototype.addTabComplete=function(func){
	//func(data,html,tabContent)
	this._addTabComplete = func;
};
Eht.Tab.prototype.resize=function(){
	this.container.height(this.container.parent().height());
	this.container.width(this.container.parent().width());
	this.body.height(this.container.height()-this.header.outerHeight(true)-Eht.Utils.getMPBHeight(this.header)-Eht.Utils.getMPBHeight(this.body));
	var ch = this.body.height()-Eht.Utils.getMPBHeight(this.body.children());
	this.body.children().height(ch);
	var cw = this.body.width()-Eht.Utils.getMPBWidth(this.body.children());
	this.body.children().width(cw);
	this.body.children().css("position","absolute");
	this.body.children().find("iframe").height(ch);
	this.body.children().find("iframe").width(cw);
};
Eht.Tab.prototype.click=function(func){
	//func(index,data)
	this._click = func;
};
Eht.Tab.prototype.clickBefore=function(func){
	/*func(index,data)  return true | false
	 * 方法返回 false 时,不进行tab标签的转换 
	 */
	this._clickBefore = func;
};
Eht.Tab.prototype.closeBefore=function(func){
	//func(index,data) return boolean  true / false  返回 false 时，不关闭tab 中项目标签
	this._closeBefore = func;
};
Eht.Tab.prototype.close=function(index){
	if(index!=undefined){
		this.tabHeader.find(".eht-tab-item-close").each(function(){
			if($(this).parent().index()==index){
				$(this).click();
			}
		});
	}else{
		this.tabHeader.find(".eht-tab-item-close").each(function(){
				$(this).click();
		});
	}
};
Eht.Tab.prototype.clear=function(){
	this.tabHeader.find("tr").eq(0).empty();
	this.body.empty();
}
/**
 * 选择激活tab项目方法
 * @param index tab 项目的索引，从 0 开始
 */
Eht.Tab.prototype.active=function(index){
	var clength = this.tabHeader.find("tr").eq(0).children().size();
	if(index < clength && index >= 0){
		var data = this.tabHeader.find("tr").eq(0).children().eq(index).data();
		this.tabHeader.find(".eht-tab-base-item").removeClass("eht-tab-item-active").addClass("eht-tab-item-nomal");
		this.tabHeader.find(".eht-tab-base-item").removeAttr("selected");
		this.body.children().hide();
		
		this.tabHeader.find("#"+data[this.opt.idField]).removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
		this.tabHeader.find("#"+data[this.opt.idField]).attr("selected",true);
		var cdiv = this.body.find("#"+data[this.opt.idField]);
		cdiv.show();
		if(this.opt.lazyLoad==true && cdiv.find("iframe").attr("url")!=undefined){
			cdiv.find("iframe").attr("src",cdiv.find("iframe").attr("url"));
			cdiv.find("iframe").removeAttr("url");
		}
		if(this._click){
			this._click(index,data);
		}
	}
};
Eht.Tab.prototype.setActiveById=function(id){
	this.tabHeader.find(".eht-tab-base-item").removeClass("eht-tab-item-active").addClass("eht-tab-item-nomal");
	this.tabHeader.find(".eht-tab-base-item").removeAttr("selected");
	this.body.children().hide();
	var td = this.tabHeader.find("#"+id);
	td.removeClass("eht-tab-item-nomal").addClass("eht-tab-item-active");
	td.attr("selected",true);
	var cdiv = this.body.find("#"+id);
	cdiv.show();
	if(this.opt.lazyLoad==true && cdiv.find("iframe").attr("url")!=undefined){
		cdiv.find("iframe").attr("src",cdiv.find("iframe").attr("url"));
		cdiv.find("iframe").removeAttr("url");
	}
	if(this._click){
		this._click(td.index(),td.data());
	}
};
Eht.Tab.prototype.loadComplete=function(func){
	//func(html,tabContent)
	this._loadComplete = func;
};
Eht.Tab.prototype.getLength=function(){
	return this.tabHeader.find("tr").eq(0).children().size();
};
Eht.Tab.prototype.getData=function(){
	var rtn = new Array();
	this.tabHeader.find("tr").eq(0).children().each(function(){
		rtn.append($(this).data());
	});
};
Eht.Tab.prototype.change=function(func){
	
};