Eht.TableView=function(opt){
	var def = {
			selector:null,
			defaultDisValue:"",
			paginate:new Eht.Paginate(),
			defColumnWidth:150,
			valueCodeField:"daaa02",
			labelCodeField:"daaa03",
			multable:false
		};
	var tableView = this;
	//保持选中的数据(主键)  key pkField 值  value pkField 值
	this.keepSelectedValues=new Object();
	this.opt=$.extend(def,opt); 
	this.selector = $(this.opt.selector);
	this.selector.data({refresh:function(){tableView.refresh()}});
	this._transColumn = new Object();
	/* field,label */
	this.columns = getColumns(this.selector);
	//table-striped 条纹表格  table-hover 悬停样式
	this.table = $("<table class='table table-striped table-hover ltrhao-table table-bordered'></table>");
	this.thead = $("<thead></thead>");
	this.tbody = $("<tbody></tbody>");
	this.paginateBar = $('<div class="ltrhao-bar text-right ltrhao-pagebar">'+
			'<ul class="ltrhao-pagination">'+
			'<li><a id="tableView_first">首页</a></li>'+
			'<li><a id="tableView_previous">上页</a></li>'+
			'<li><a id="tableView_next">下页</a></li>'+
			'<li><a id="tableView_last">末页</a></li>'+
			'<li><input id="tableView_page" text="text" style="width:40px;margin-right:4px;"/></li>'+
			'<li><input id="tableView_go" type="button" value="Go.."/></li>'+
			'<li><div>第<span id="pageIndex"></span>页/共<span id="totalPage"></span>页 '+
			'每页 <select id="pageIndexOpt"><option>60</option></select>条 （共 <span id="total"></span> 条）</div></li>'+
			'</ul>'+
			'</div>');
	this.table.append(this.thead);
	this.table.append(this.tbody);
	
    initHeader(this.selector);
    this.selector.append(this.table);
    if(this.opt.paginate!=null){
    	this.selector.append(this.paginateBar);
    }
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
	this.paginateBar.find("#tableView_go").click(function(){
		if(tableView._loadData!=null && tableView.loadResp!=null){
			page.indexPage = parseInt(tableView.paginateBar.find("#tableView_page").val());
			tableView._loadData(page,tableView.loadResp);
		}
	});
	this.paginateBar.find("#pageIndexOpt").change(function(){
		page.pageCount = parseInt($(this).val());
		if(tableView._loadData!=null && tableView.loadResp!=null){
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
					var checkbox = $(this).attr("checkbox");
					
					var th = $("<th class='ui-state-default'></th>");
					if(checkbox=="true" || checkbox==true){
						th.css("text-align","center");
						th.attr("checkbox","true");
					}
					var label = $(this).attr("label");
					th.html(label);
					th.attr("field",field);
					th.attr("colspan",$(this).attr("colspan"));
					
					var w = $(this).attr("width");
					if(w!=null){
						th.css("width",w+"px");
					}
					var align = $(this).attr("align");
					if(align!=null){
						th.css("text-align",align);
					}
					
					if($(this).children().size()==0){
						th.attr("rowspan",hrCnt - i);
					}
					rowArray[i].append(th);
				});
			}
			tableView.thead.find("th[checkbox='true'] input[type=checkbox]").click(function(){
				tableView.toggle(this.checked);
			});
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
			var checkbox = $(this).attr("checkbox");
			var col = {};
			col.field = field;
			col.label = label;
			col.width = width;
			col.align = align;
			col.checkbox = checkbox;
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

Eht.TableView.prototype.loadData=function(args){
	if(this._object==null){
		this._object = args;
	}
	//Object|array|func(this.opt.paginate,this.loadResp)
	var tv = this;
	if(args){
		if($.type(args)=="object"){
			this.data = args.rows?args.rows:[];	
			//在翻页栏中显示翻页相关数据
			//this.setPaginate(dataObj.paginate);
		}else if($.type(args)=="array"){
			this.data = args;
		}else if($.type(args)=="function"){
			this._loadData=args;
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
	var self = this;
	var row = $("<tr ></tr>");
	row.data(data);
	for(var c=0;c<this.columns.length;c++){
		var field = this.columns[c].field;
		var td = $("<td field='"+field+"'></td>");
		var w = this.columns[c].width;
		if(w!=null){
			td.css("width",w+"px");
		}
		var align = this.columns[c].align;
		if(align!=null){
			td.css("text-align",align);
		}
		var v = data[field]!=null?data[field]:this.opt.defaultDisValue;
		if(this.columns[c].checkbox=="true" ||this.columns[c].checkbox==true){
			var cbox = $("<input type='checkbox'/>"); 
			td.append(cbox);
			td.attr("align","center");
			td.attr("checkbox","true")
			cbox.data(data);
		}else{
			td.html(v);
		}
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
			var ts = this._transColumn[field].call(this,data,rowIndex,td,field);
			if(ts!=null){
				td.html(ts);
			}
		}
	}
	this.tbody.append(row);
	row.click(function(){
		if(self.opt.multable==false){
			//单选
			$(this).parent().children().removeClass("active");
			$(this).parent().find("td[checkbox=true] input[type=checkbox]").attr("checked",false);
		}
		var tdcheck = $(this).find("td[checkbox=true] input[type=checkbox]");
		var thcheck = self.thead.find("th[checkbox='true'] input[type=checkbox]");
		if($(this).hasClass("active")){
			$(this).removeClass("active");
			tdcheck.get(0).checked = false;
		}else{
			$(this).addClass("active");
			if(tdcheck.size()>0){
				tdcheck.get(0).checked = true;
			}
			if(thcheck.size()>0){
				thcheck.get(0).checked = true;
			}
		}
		var rtn = true;
		if(self._clickRow){
			rtn = self._clickRow.call(self,$(this).data());
			if(rtn==null){
				rtn = true;
			}
		}
		if(!$(this).parent().children().hasClass("active")){
			thcheck.get(0).checked = false;
		}
		return rtn;
	});
	row.dblclick(function(){
		if(self._dblclickRow){
			self._dblclickRow.call(self,$(this).data());
		}
	});
};
Eht.TableView.prototype.getSelectedData=function(){
	var rtn = new Array();
	this.tbody.children(".active").each(function(){
		rtn.push($(this).data());
	});
	return rtn;
};
Eht.TableView.prototype.toggle=function(selected){
	this.tbody.children().removeClass("active");
	if(selected==true){
		this.tbody.children().addClass("active");
	}
	this.tbody.find("td[checkbox=true] input[type=checkbox]").each(function(){
		this.checked = selected;
	});
};
Eht.TableView.prototype.transColumn=function(field,func){
	//func(data,rowIndex,cell,field)
	this._transColumn[field] = func;
};
Eht.TableView.prototype.clickRow=function(func){
	//func(data,rowIndex,cell,field)
	this._clickRow = func;
};
Eht.TableView.prototype.dblclickRow=function(func){
	//func(data,rowIndex,cell,field)
	this._dblclickRow = func;
};
Eht.TableView.prototype.setPageInfo=function(page){
	if(this.opt.paginate!=null && page!=null){
		if(this.opt.paginate){
			for(p in page){
				this.opt.paginate[p]=page[p];
			}
		} else{
			this.opt.paginate = $.extend(new Eht.Paginate(),page);
		}
		page = this.opt.paginate;
		this.paginateBar.find("#pageIndex").html(page.indexPage);
		this.paginateBar.find("#totalPage").html(page.getTotalPage());
		this.paginateBar.find("#tableView_page").val(page.indexPage);
		this.paginateBar.find("#total").html(page.totalCount);
		var pselect = this.paginateBar.find("#pageIndexOpt");
		
		pselect.val(page.pageCount);
		if(pselect.get(0).selectedIndex==-1){
			for(var i=0;i<pselect.children().size();i++){
				if(page.pageCount<parseInt(pselect.children().eq(i).val())){
					pselect.children().eq(i).before("<option>"+page.pageCount+"</option>");
					break;
				}
			}
		}
	}
};
Eht.TableView.prototype.refresh=function(){
	this.loadData(this._object);
};
$(function(){
	$.fn.refreshTable=function(){
		if($(this).data() && $(this).data().refresh){
			$(this).data().refresh();
		}
	}
});