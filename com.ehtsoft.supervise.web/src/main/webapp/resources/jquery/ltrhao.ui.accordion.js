/**
 * @author wangbao
 */
Eht.BootAccordion=function(opt){
	var self = this;
	var def = {
		selector:null,
		labelField:"menuname",
		pkField:"sysid"
	};
	this.opt = $.extend(def,opt);
	this.selector=$(this.opt.selector);
	this.selector.addClass("accordion");
	this.panel = $('<div class="sidebar-popup">'+
					 '<div class="sidebar-popup-header">'+
			           '<div style="padding: 10px 8px;"><span id="popup-header-label"></span></div>'+
			         '</div>'+
			         ' <div id="popup-panel-content"></div>'
			        +'</div>');
	this.group = $('<div class="accordion-group group-menu"></div>');
	this.selector.append(this.group);
	this.res = new Eht.Responder();
	this.res.success=function(data){
		self.loadData(data);
	}
	this.sidehide = false;
};
Eht.BootAccordion.prototype.openItem=function(){
	
};
Eht.BootAccordion.prototype.sideCollapse=function(hide){
	this.panel.hide();
	this.selector.find(".collapse").collapse("hide");
	if(hide){
		this.selector.find(".sideitem-text").hide();
	}else{
		this.selector.find(".sideitem-text").show();
	}
	this.sidehide = hide;
};
Eht.BootAccordion.prototype.clickItem=function(args){
	this._clickItem = args;
};
Eht.BootAccordion.prototype.loadData=function(args){
	var self = this;
	this.group.empty();
	this.group.append(this.panel);
	this.panel.hide();
	if($.isFunction(args)){
		args.call(this,this.res);
	}
	if($.isArray(args)){
		for(var i=0;i<args.length;i++){
			var item = args[i];
			this.addItem(item);
		}
	}
	if($.type(args)=="object"){
		console.log(args);
	}
};
Eht.BootAccordion.prototype.addItem=function(item){
	var self = this;
	
	var itemHeader = $('<div class="accordion-heading header">'+
		'	 <div class="accordion-toggle toggle" data-toggle="collapse" '+
		//'	 	href="#acc_'+item[this.opt.pkField]+
		'"><i class="sidebar-icon"></i><span class="sideitem-text">'+item[this.opt.labelField]+'</span>'+
		'	 </div>'+
		'</div>');
	var itemContent = $('<div id="acc_'+item[this.opt.pkField]+'" class="accordion-body collapse">'+
		'	<div class="accordion-inner"></div>'+
	    '</div>');
	itemHeader.data(item);
	this.group.append(itemHeader);
	this.group.append(itemContent);
	itemHeader.click(function(){
		self.group.find(".accordion-heading").each(function(){
			$(this).removeClass("active");
		});
		$(this).addClass("active");
		if(self.sidehide==false){
			$("#acc_" + $(this).data()[self.opt.pkField]).collapse("toggle");
		}
		if(self._clickItem){
			self._clickItem.call(self,$(this).data());
		}
	});
	itemHeader.hover(function(){
		if(self.sidehide){
			//background: #1e2f35;
			self.panel.css({left:self.selector.width()+"px",
							top:$(this).position().top + "px",
							position:"absolute"
							});
			self.panel.find(".sidebar-popup-header").height($(this).outerHeight(true));
			self.panel.find("#popup-header-label").html($(this).data()[self.opt.labelField]);
			var pp = self.panel.find("#popup-panel-content").empty();
			_children(pp,$(this).data());
			self.panel.show();
			self.group.find(".accordion-heading").each(function(){
				$(this).removeClass("active");
			});
			$(this).addClass("active");
			self.panel.hover(function(){},function(){
    			$(this).hide();
    			return false;
    		});
		}
	},function(){
		
	});
	var inner = itemContent.find(".accordion-inner");
	_children(inner,item);
	
	function _children(inner,item){
		if(item.children && item.children.length>0){
			var ul = $("<ul></ul>");
			inner.append(ul);
			for(var j=0;j<item.children.length;j++){
				var child = item.children[j];
				var li = $("<li><span>"+child[self.opt.labelField]+"</span></li>");
				li.data(child);
				ul.append(li);
				li.click(function(){
					$(".accordion-inner li").removeClass("itemActive");
					self.panel.find("#popup-panel-content li").removeClass("itemActive");
					$(this).addClass("itemActive");
					if(self._clickItem){
    					self._clickItem.call(self,$(this).data());
    				}
				});
				if(child.children && child.children.length>0){
					_children(li,child);
				}
			}
		}
	}

}