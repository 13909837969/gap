/**
 * 桌面UI组件
 * @param opt
 * @param 王宝
 * @returns {Eht.Desktop}
 */
Eht.Desktop=function(opt){
	var desktop = this;
	var def = {
		selector:null,
		gridWidth:75,
		gridHeight:85,
		iconClassField:"icon",
		labelField:"label",
		enableDrag:true
	};
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.selector.addClass("eht-desktop");
	this.grid = $("<table class='eht-desktop-grid' cellspacing='3'></table>");
	this.selector.append(this.grid);
	
	this.desktopCells = new Array();
	this.resize();
	
	$(window).resize(function(){
		desktop.resize();
	});
};
Eht.Desktop.prototype.setTaskbar=function(taskbar){
	this.taskbar = taskbar;
};
Eht.Desktop.prototype.resize=function(){
	var desktop = this;
	var w = $(window).width();
	var h = $(window).height();
	var top = 0;
	var left = 0;
	if(this.taskbar){
		var pit = this.taskbar.getPosition();
		if(pit=="left"){
			left = this.taskbar.selector.outerWidth(true);
			w = w - left;
		}
		if(pit=="right"){
			w = w - this.taskbar.selector.outerWidth(true);
		}
		if(pit=="top"){
			top = this.taskbar.selector.outerHeight(true);
			h = h - top;
		}
		if(pit=="bottom"){
			h = h - this.taskbar.selector.outerHeight(true);
		}
	}
	this.selector.css({top:top,left:left,"position":"absolute"});
	this.selector.width(w);
	this.selector.height(h);
	this.grid.width(w);
	this.grid.height(h);
	var maxCol = Math.floor((w*1.0 - 14)/(this.opt.gridWidth + 14));
	var maxRow = Math.floor((h*1.0 - 14)/(this.opt.gridHeight + 14));
	
	this.grid.children().remove();
	
	for(var r=0;r<maxRow;r++){
		var tr = $("<tr></tr>");
		for(var c = 0;c<maxCol;c++){
			var td = $("<td align='center' valign='middle'></td>");
			var div = $("<div class='eht-desktop-grid-cell-div'></div>");
			td.append(div);
			tr.append(td);
		}
		this.grid.append(tr);
	}
	var colIndex=0;
	for(var i=0;i<this.desktopCells.length;i++){
		if(i%maxRow==0){
			if(i!=0){
				colIndex++;
			}
		}
		this.grid.find("tr").eq(i%maxRow).children().eq(colIndex).find(".eht-desktop-grid-cell-div").append(this.desktopCells[i].container);
		this.desktopCells[i].container.data(this.desktopCells[i].data);
		this.desktopCells[i].container.unbind("click").bind("click",function(){
			if(desktop._click){
				desktop._click($(this).data());
			}
		}); 
		this.desktopCells[i].container.unbind("dblclick").bind("dblclick",function(){
			if(desktop._dblclick){
				desktop._dblclick($(this).data());
			}
		});
		this.desktopCells[i].container.dropAndDrag({selector:this.desktopCells[i].icon,accept:"div.eht-desktop-grid-cell-div",
			drop:function(e){
					this.self.css({position:"",left:"",top:""});
					if(desktop.opt.enableDrag){
						$(e.target).append(this.self);
					}
					return desktop.opt.enableDrag;
			}});
		
		 this.desktopCells[i].container.hover(function(){
			$(this).find("#cell-hover").removeClass("eht-desktop-grid-cell-hover").addClass("eht-desktop-grid-cell-hover");
		},function(){
			$(this).find("#cell-hover").removeClass("eht-desktop-grid-cell-hover");
		});
		
		this.desktopCells[i].container.children().hover(function(){
			$(this).parent().find("#cell-hover").removeClass("eht-desktop-grid-cell-hover").addClass("eht-desktop-grid-cell-hover");
		},function(){
			$(this).parent().find("#cell-hover").removeClass("eht-desktop-grid-cell-hover");
		}); 
	}
};
Eht.Desktop.prototype.loadData=function(data){
	var desktop = this;
	if(this._loadParam==undefined || this._loadParam==null){
		this._loadParam = data;
	}
	if(data){
		if($.type(data)=="array"){
			this.data = data;
			for(var i=0;i<data.length;i++){
				this.addItem(data[i]);
			}
			this.resize();
		}
		if($.type(data)=="object"){
			this.data = data.rows;
			for(var i=0;i<this.data.length;i++){
				this.addItem(this.data[i]);
			}
			this.resize();
		}
		if($.type(data)=="function"){
			this._loadData=data;
			var loadResp = new Eht.Responder();
			loadResp.success=function(data){
				if(desktop._loadCompleteBefore){
					desktop._loadCompleteBefore(data);
				}
				desktop.loadData(data);
			};
			this._loadData(loadResp);
		}
	}
};
Eht.Desktop.prototype.loadCompleteBefore=function(func){
	//func(data)
	this._loadCompleteBefore = func;
};
Eht.Desktop.prototype.addItem=function(data){
	if(this._addItemBefore){
		this._addItemBefore(data);
	}
	this.desktopCells.push(new Eht.DesktopCell(data,this.opt));
};
Eht.Desktop.prototype.addItemBefore=function(func){
	//func(data);
	this._addItemBefore = func;
};
Eht.Desktop.prototype.click=function(func){
	//func(data);
	this._click = func;
};
Eht.Desktop.prototype.dblclick=function(func){
	//func(data)
	this._dblclick = func;
};
Eht.Desktop.prototype.reload=function(){
	this.desktopCells.clearAll();
	this.loadData(this._loadParam);
};
Eht.Desktop.prototype.refresh=function(){
	this.desktopCells.clearAll();
	this.loadData(this._loadParam);
};
Eht.DesktopCell = function(data,opt){
	/**
	* opt 同  Eht.Desktop 的 opt
	*/
	var cell = this;
	this.container = $("<div class='eht-desktop-icon-div'></div>");
	this.hover = $("<div id='cell-hover' class='eht-desktop-grid-cell'></div>");
	this.icon = $("<a class='eht-desktop-grid-cell'><span class='eht-desktop-grid-cell-icon'></span>"+
			      "<div class='eht-desktop-grid-cell-font'></div></a>");
	if(data){
		this.icon.find(".eht-desktop-grid-cell-font").html(data[opt.labelField]);
		this.icon.find(".eht-desktop-grid-cell-icon").addClass(data[opt.iconClassField]);
	}
	this.container.append(this.hover);
	this.container.append(this.icon);
	this.data = data;
	this.container.data(data);
	this.container.unbind("click").bind("click",function(){
		if(cell._click){
			cell._click(cell.data);
		}
	});
	this.container.unbind("dblclick").bind("dblclick",function(){
		if(cell._dblclick){
			cell._dblclick(cell.data);
		}
	});
	
};
Eht.DesktopCell.prototype.click=function(func){
	//func(data)
	this._click = func;
};
Eht.DesktopCell.prototype.dblclick=function(func){
	//func(data)
	this._dblclick = func;
};
