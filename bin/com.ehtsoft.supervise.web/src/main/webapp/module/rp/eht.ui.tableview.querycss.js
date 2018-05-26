Eht.TableView=function(opt){
	var def = {
			selector:null,
			defaultDisValue:"",
			paginate:new Eht.Paginate(),
			defColumnWidth:150,
			valueCodeField:"daaa02",
			labelCodeField:"daaa03"
		};
	var tableView = this;
	//保持选中的数据(主键)  key pkField 值  value pkField 值
	this.keepSelectedValues=new Object();
	this.opt=$.extend(def,opt); 
	this.selector = $(this.opt.selector);
	this._transColumn = new Object();
	/* field,label */
	this.columns = getColumns(this.selector);
	this.table = $("<table class='table table-striped dataTable'></table>");
	this.thead = $("<thead></thead>");
	this.tbody = $("<tbody></tbody>");
	this.paginateBar = $('<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-bl ui-corner-br ui-helper-clearfix" style="padding: 10px;">'
			+'<div class="dataTables_info" id="tableView_info"></div>'
			+'<div class="dataTables_paginate fg-buttonset ui-buttonset fg-buttonset-multi ui-buttonset-multi paging_full_numbers" id="tableView_paginate">'
			+'<a class="first ui-corner-tl ui-corner-bl fg-button ui-button ui-state-default" id="tableView_first">首页</a><!--ui-state-disabled-->'
			+'<a class="previous fg-button ui-button ui-state-default" id="tableView_previous">上一页</a>'
			+'<span id="pagenum"><a class="fg-button ui-button ui-state-default "></a></span>'
			+'<a class="next fg-button ui-button ui-state-default" id="tableView_next">下一页</a>'
			+'<a class="last ui-corner-tr ui-corner-br fg-button ui-button ui-state-default" id="tableView_last">末页</a>'
			+'</div>'
			+'</div>');
	this.table.append(this.thead);
	this.table.append(this.tbody);
	
    initHeader(this.selector);
    this.selector.append(this.table);
    this.selector.append(this.paginateBar);
    //翻页事件
    var page = tableView.opt.paginate;
    //tableView_first tableView_previous  tableView_next  tableView_last
	this.paginateBar.find("#tableView_first").click(function(){
		if(tableView._loadData!=null && tableView.loadResp!=null){
			page.getFirstPage();
			tableView._loadData(page,tableView.loadResp);
		}
	});
    
	this.paginateBar.find("#tableView_previous").click(function(){
		if(tableView._loadData!=null && tableView.loadResp!=null){
			page.getPrevPage();
			tableView._loadData(page,tableView.loadResp);
		}
	});
	
	this.paginateBar.find("#tableView_next").click(function(){
		if(tableView._loadData!=null && tableView.loadResp!=null){
			page.getNextPage();
			tableView._loadData(page,tableView.loadResp);
		}
	});
	this.paginateBar.find("#tableView_last").click(function(){
		if(tableView._loadData!=null && tableView.loadResp!=null){
			page.getEndPage();
			tableView._loadData(page,tableView.loadResp);
		}
	});
	
	function initHeader(selector){
		//计算头行数
		var hrCnt = computeRow(selector,1,new Array());
		 var rowArray = new Array();
			for(var i=0;i<hrCnt;i++){
				var tr = $("<tr></tr>");
				rowArray.push(tr);
				tableView.thead.append(tr);
			}
			for(var i=0;i<rowArray.length;i++){
				selector.find("div[row='"+(i+1)+"']").each(function(){
					var field = $(this).attr("field")==undefined?"field":$(this).attr("field");	
					var th = $("<th class='ui-state-default'></th>");
					var label = $(this).attr("label");
					th.html(label);
					th.attr("field",field);
					th.attr("colspan",$(this).attr("colspan"));
					if($(this).children().size()==0){
						th.attr("rowspan",hrCnt - i);
					}
					rowArray[i].append(th);
				});
			}
	}
	function getColumns(selector){
		initColumn(selector);
		var rtn = new Array();
		selector.find("div[colspan='1']").each(function(){
			var field = $(this).attr("field");
			var label = $(this).attr("label");
			var width = $(this).attr("width");
			var code = $(this).attr("code");
			var align = $(this).attr("align");
			var col = {};
			col.field = field;
			col.label = label;
			col.width = width;
			col.align = align;
			if(code!=null){
				col.code = code;
			}
			rtn.push(col);
		});
		return rtn;
	}
	function initColumn(selector){
		selector.children("div").each(function(i,item){
			if($(item).children().size()==0){
				$(item).attr("colspan","1");
			}else{
				initColumn($(item));
			}
		});
		selector.children("div").each(function(i,item){
			if($(item).children().size()>0){
				$(item).attr("colspan",$(item).find("div[colspan='1']").size());
				initColumn($(item));
			}
		});
	}
	function computeRow(selector,lvl,array){
		selector.children("div").each(function(i,item){
			$(item).attr("row",lvl);
			array.push(lvl);
			if($(item).children().size()>0){
				return computeRow($(item),lvl+1,array);
			}
		});
		return Math.max.apply(Math,array);
	}
};

Eht.TableView.prototype.loadData=function(dataObj){
	if(this._object==null){
		this._object = dataObj;
	}
	//Object|array|func(this.opt.paginate,this.loadResp)
	var tv = this;
	if(dataObj){
		if($.type(dataObj)=="object"){
			this.data = dataObj.rows?dataObj.rows:[];	
			//在翻页栏中显示翻页相关数据
			//this.setPaginate(dataObj.paginate);
		}else if($.type(dataObj)=="array"){
			this.data = dataObj;
		}else if($.type(dataObj)=="function"){
			this._loadData=dataObj;
			if(this.loadResp==null){
				this.loadResp = new Eht.Responder();
				var error = this.loadResp.error;
				this.loadResp.success=function(data, textStatus, jqXHR){
					tv.loadData(data);
					tv.setPageInfo(data.paginate);
				};
				this.loadResp.error=function(data, textStatus, jqXHR){
					error(data,textStatus,jqXHR);
				};
			}
			this._loadData(this.opt.paginate,this.loadResp);
			return;
		}
		if($.type(this.data)=="array"){
			this.tbody.empty();
			for(var i=0;i<this.data.length;i++){
				this.addRow(this.data[i],i);
			}
		}
	}
};
Eht.TableView.prototype.addRow=function(data,rowIndex){
	var row = $("<tr ></tr>");
	for(var c=0;c<this.columns.length;c++){
		var field = this.columns[c].field;
		var td = $("<td field='"+field+"'></td>");
		var w = this.columns[c].width?this.columns[c].width:this.opt.defColumnWidth;
		td.css("width",w+"px");
		var align = this.columns[c].align?this.columns[c].align:'center';
		td.css("text-align",align);
		var v = data[field]!=null?data[field]:this.opt.defaultDisValue;
		td.html(v);
		row.append(td);
		if(this.columns[c].code){
			if(this.columns[c].code.trim().match(/^\[.*\]$/g)){
				try{
					var jsonarray = eval("("+this.columns[c].code.trim()+")");
					for(var i=0;i<jsonarray.length;i++){
						if(jsonarray[i].v == v){
							td.html(jsonarray[i].d);
							break;
						}
					}
				}catch(e){
					alert(e.message);
				}
			}else{
				if(Eht.DataCode){
					var arry = Eht.DataCode[this.columns[c].code.trim().toLowerCase()];
					if(arry!=null){
						for(var i=0;i<arry.length;i++){
							if(arry[i][this.opt.valueCodeField]==v){
								td.html(arry[i][this.opt.labelCodeField]);
								break;
							}
						}
					}
				}
			}
		}
		if(this._transColumn[field] && $.isFunction(this._transColumn[field])){
			var ts = this._transColumn[field](data,rowIndex,td,field);
			if(ts!=null){
				td.html(ts);
			}
		}
	}
	this.tbody.append(row);
};
Eht.TableView.prototype.transColumn=function(field,func){
	//func(data,rowIndex,cell,field)
	this._transColumn[field] = func;
};
Eht.TableView.prototype.setPageInfo=function(page){
	if(page){
		if(this.opt.paginate){
			for(p in page){
				this.opt.paginate[p]=page[p];
			}
		} else{
			this.opt.paginate = $.extend(new Eht.Paginate(),page);
		}
		page = this.opt.paginate;
		this.paginateBar.find("#tableView_info").html("共 " + page.getTotalPage() + "页" + page.totalCount + " 条信息 当前第 " + page.indexPage+" 页");
	}
};
Eht.TableView.prototype.refresh=function(){
	this.loadData(this._object);
};