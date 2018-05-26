/**
 * 表格组件
 * @param opt
 * @returns {Eht.Datagrid}
 * @author wangbao
 * 属性 ：this.data 为 datagrid 中的所有数据
 * 方法 ：getData 为 datagrid 中变化的数据（包括添加和更新修改的数据）
 */
Eht.Datagrid=function(opt){
	var pre_class="datagrid-col-";
	var datagrid = this;
	var def = {
		selector:null,
		hasHeader:true,
		hasFooter:true,
		multable:false,
		enableSingleCancel:false,//允许单选取消 row
		loadInit:true, //true 页面加载后，直接调用 loadData 方法，填充表格数据  false 页面加载后，不填充表格数据
		selectedField:"_selected",//boolean true/false
		rowIndexField:"_rowIndex",
		pkField:null,//datagrid 唯一的字段属性，（ this.keepSelectedValues 数据为保持选中的数据）
		paginate:new Eht.Paginate(),
		isPaginate:true,
		footerSelector:null,
		headerSelector:null,
		defaultDisValue:"",
		defaultColumnWidth:100,
		minColumnWidth:30,
		codeValueField:"daaa02",
		codeLabelField:"daaa03",
		changeFlag:"_change_flag" // 添加 或 编辑的时候，数据属性为 1;
	};
	//保持选中的数据(主键)  key pkField 值  value pkField 值
	this.keepSelectedValues=new Object();
	this.opt=$.extend(def,opt); 
	this.data = null;
	this._transColumn = new Object();
	this._comboxs = new Array();
	//header
	this.selector = $(this.opt.selector);
	var pre_col_class = pre_class + this.selector.attr("id")+"-";
	this.container = $("<div class='eht-base eht-datagrid'></div>");
	this.header = $("<div class='eht-base eht-datagrid-header' style='overflow:hidden;'></div>");
	this.selector.before(this.container);
	this.selector.before(this.header);
	this.tableCaption = $("<caption class='eht-datagrid-caption'></caption>");
	if(this.selector.is("table")){
		this.header.append(this.selector);
		if(this.opt.headerSelector){
			this.selector.append(this.tableCaption);
		}
	}else{
		this.headerTable = $("<table></table>");
		this.header.append(this.headerTable);
		if(this.opt.headerSelector){
			this.headerTable.append(this.tableCaption);
		}
	}
	if(this.opt.headerSelector){
		this.tableCaption.append(this.opt.headerSelector);
	}
	this.lineSplit = $("<div style='width:1px;background:#444;position:absolute;cursor:col-resize;display:none;'></div>");
	//body
	this.body = $("<div class='eht-base eht-datagrid-body' style='overflow:auto;'></div>");
	this.rowForm = $("<div class='row-form' style='display:none;'></div>");
	this.body.append(this.rowForm);
	this.modalWait = $("<div class='datagrid-modal-wait' style='position:absolute;'></div>");
	this.tabBody=$("<table></table>");
	//footer
	this.footer = $("<div class='eht-base eht-datagrid-footer'></div>");
	this.style = $("<style></style>");
	//implements
	this.header.after(this.body);
	this.body.after(this.footer);
	this.body.append(this.tabBody);
	this.container.append(this.header);
	this.container.append(this.body);
	this.container.append(this.footer);
	this.container.append(this.lineSplit);
	this.body.append(this.modalWait);
	this.header.before(this.style);
	if(this.selector.is("table")){
		this.columns = getTableColumns(this.selector);
	}else{
		this.columns = getDivColumns(this.selector);
	}
	initbody(this.selector,this.tabBody,this.columns);
	initfooter(this.footer,this.opt.paginate);
	this.comboPanels = new Array();
	this.editorRenderers = new Array();
	this.setPaginate(this.opt.paginate);
	
	if(this.opt.hasHeader){
		this.header.show();
	}else{
		this.header.hide();
	}
	if(this.opt.hasFooter){
		this.footer.show();
	}else{
		this.footer.hide();
	}
	//滚动条事件
	this.body.scroll(function(e){
		datagrid.header.scrollLeft($(this).scrollLeft());
	});
	
	this.resize();
	//向 body table 中初始一行 高为 0 的 tr
	function initbody(selector,table,cols){
		var css = new Array();
		/**
		var row = $("<tr class='datagrid-first-row' style='height:0px;border:0px;margin:0px;padding:0;'></tr>");
		*/
		for(var i=0;i<cols.length;i++){
			table.append("<col field='"+cols[i].field+"' class='"+pre_col_class+cols[i].field+"'></col>");
			css.push("."+pre_col_class+cols[i].field+"{width:"+cols[i].width+"px;text-overflow:ellipsis;overflow:hidden;}");
		}
		/**table.append(row);**/
		if(datagrid.style.get(0).styleSheet){
			datagrid.style.get(0).styleSheet.cssText = css.join("\n");
		}else{
			datagrid.style.get(0).appendChild(document.createTextNode(css.join("\n")));
		}
		var rs = selector.find("tr").size(); 
		if(rs>0){
			selector.find("tr").eq(0).append("<td class='datagrid-header-last-col' rowspan='"+rs+"' style='width:100%;'><div style='width:16px;'></div></td>");
		}
	}
	function initfooter(footer,page){
		/**
		 * add footer button
		 */
		var footerSelector = $("<span style='float:left;'></span>");
		footerSelector.append($(datagrid.opt.footerSelector));
		var toolbar = $("<span style='float:right;'></span>");
		var barbtn = "<a id='firstPage'>首页</a><a id='prevPage'>上页</a><a id='nextPage'>下页</a><a id='endPage'>末页</a>" +
				"<input id='txtIndex' type='text' style='width:20px;height:14px;'/>" +
				"<input id='goBtn' type='button' style='height:20px;padding-top:0;' value='Go..'/>" +
				"<span style='padding:0 4px 0 4px;'>" +
				"第<span id='indexPage'>1</span>页/共<span id='totalPage'>2</span>页</span>" +
				"<span style='padding:0 4px 0 4px;'><span>每页</span></span>" +
				"<select id='pageCount'>" +
				"<option value='20'>20</option>" +
				"<option value='40'>40</option>" +
				"<option value='60'>60</option>" +
				"<option value='80'>80</option>" +
				"<option value='100'>100</option>" +
				"</select>" +
				"<span>条" +
				"(共<span id='totalCount'>10</span>条)</span>";
		if(datagrid.opt.isPaginate==true){
			toolbar.append(barbtn);
		}else{
			datagrid.opt.paginate = null;
		}
		footer.append(footerSelector);
		footer.append(toolbar);
		footer.append("<div style='clear:both;'></div>");
		new Eht.Toolbar({selector:toolbar});
		//首页
		var first = footer.find("#firstPage");
		first.unbind("click").bind("click",function(){
			page.getFirstPage();
			if(datagrid._clickPage){
				datagrid._clickPage(page);
			}
		});
		//上页
		var prev = footer.find("#prevPage");
		prev.unbind("click").bind("click",function(){
			page.getPrevPage();
			if(datagrid._clickPage){
				datagrid._clickPage(page);
			}
		});
		//下页 
		var next = footer.find("#nextPage");
		next.unbind("click").bind("click",function(){
			page.getNextPage();
			if(datagrid._clickPage){
				datagrid._clickPage(page);
			}
		});
		//末页
		var end = footer.find("#endPage");
		end.unbind("click").bind("click",function(){
			page.getEndPage();
			if(datagrid._clickPage){
				datagrid._clickPage(page);
			}
		});
		var pc = footer.find("#pageCount");
		pc.change(function(){
			page.pageCount = parseInt($(this).val());
			datagrid.refresh();
			
		});
		//页码输入框
		var txt = footer.find("#txtIndex");
		//转页按钮
		var gobtn = footer.find("#goBtn");
		gobtn.unbind("click").bind("click",function(){
			page.indexPage=isNaN(txt.val())?1:parseInt(txt.val());
			if(page.indexPage<=0){
				page.indexPage=1;
			}
			if(page.indexPage>=page.getTotalPage()){
				page.indexPage=page.getTotalPage();
			}
			txt.val(page.indexPage);
			if(datagrid._clickPage){
				datagrid._clickPage(page);
			}
		});
	}
	/**
	 * column attr：
	 * width
	 * field
	 * label
	 * enable
	 * code     仅在  rowForm 中实现，datagrid 的编辑行中没有实现
	 * mkform
	 * ehtType  仅在  rowForm 中实现，datagrid 的编辑行中没有实现
	 * validate 仅在  rowForm 中实现，datagrid 的编辑行中没有实现
	 * opt      仅在  rowForm 中实现，datagrid 的编辑行中没有实现
	 * display  true , false false 不显示列
	 */
	function toColumnObj($this,field,label){
		var column = new Object();			
		var w = parseFloat($this.attr("width")?$this.attr("width"):datagrid.opt.defaultColumnWidth);
		if(w < datagrid.opt.minColumnWidth){
			w = datagrid.opt.minColumnWidth;
		}
		column.field=field;
		column.width = w;
		column.label = label;
		column.enable = $this.attr("enable")?$this.attr("enable"):true;
		column.display = $this.attr("display")?$this.attr("display"):true;
		column.merge = Boolean($this.attr("merge"));
		column.valign = $this.attr("valign");
		if($this.attr("code")){
			var attrCode = $this.attr("code");
			//code 仅在  rowForm 中实现，datagrid 的行中没有实现
			var ds = Eht.DataCode[attrCode.toLowerCase()];
			if(ds==null){
				var reg = /\[.*?\]/g;
				if(reg.test(attrCode.trim())){
					try{
						ds = eval("(" + attrCode.trim() + ")");
						for(var b=0;b<ds.length;b++){
							ds[b][datagrid.opt.codeValueField]=ds[b].v;
							ds[b][datagrid.opt.codeLabelField]=ds[b].d;
						}
					}catch(e){
						alert("datagrid " + field + " code="+attrCode+e.message);
					}
				}
			}
			column.code = attrCode;//标准数据代码或 [{v:1,d:""}]
			column.codes = ds;
		}
		if($this.attr("mkform")!=null){
			column.mkform = "false";
		}
		if($this.attr("ehtType")){
			//ehtType 仅在  rowForm 中实现，datagrid 的行中没有实现
			column.ehtType = $this.attr("ehtType");//tree
		}
		if($this.attr("validate")){
			//validate 仅在  rowForm 中实现，datagrid 的行中没有实现
			vs = $this.attr("validate").trim();
			var  reg = /\[.*?\]/g;
			var varr = new Array();
			try{
				if(reg.test(vs)){
					varr = eval("(" + vs + ")");
				}else{
					varr = eval("(["+vs+"])");
				}
			}catch(e){
				alert(e);
			}
			column.validate = varr;
		}
		if($this.attr("opt")){
			//opt 仅在  rowForm 中实现，datagrid 的行中没有实现
			vs = $this.attr("opt").trim();
			var  reg = /\{.*?\}/g;
			var vobj = {};
			try{
				if(reg.test(vs)){
					vobj = eval("(" + vs + ")");
				}
			}catch(e){
				alert(e);
			}
			column.opt = vobj;
		}
		return column;
	}
	//得到columns 并对头进行div 初始化
	function getTableColumns(selector){
		//查找头中的 <tr> 标签
		var rows = selector.find("tr");
		var fields = new Array();
		rows.each(function(r){
			var len = 0;
			var cols = new Array();
			$(this).children().each(function(){
				var c = 1;
				if($(this).attr("colspan")){
					c = parseInt($(this).attr("colspan"));
				}
				len += c;
				if(c==1){
					var html = $(this).html();
					var field = $(this).attr("field")==undefined?"field":$(this).attr("field");		
					var cr = $("<span class='header-col-resize'></span>");
					var coltnt=$("<div style='white-space:nowrap;' class='"+pre_col_class+field+"'><span>"+html+"</span></div>");
					coltnt.append(cr);
					$(this).html("");
					$(this).append(coltnt);
					
					cols[len-1] = toColumnObj($(this),field,html);
					fields[r]=cols;
					//手动设置宽度
					manresize(cr);
				}
				if(r==0){
					if(cols[len-1]==null){
						cols[len-1] = null;
					}
				}
			});
		});
		var n = 0;
		for(var i=0;i<fields.length;i++){
			if(fields.length>1){
				if(fields[n]==null || fields[n]==undefined){
					n++;
				}
				for(var j=0;j<fields[n].length;j++){
					if(fields[n][j]==null || fields[n][j]==undefined){
						if(fields[i+1]){
							fields[n][j]=fields[i+1].shift();
						}
					}
				}
			}
		}
		return fields[n];
	};
	function manresize(cr){
		//手动设置列宽
		cr.unbind("mousedown").bind("mousedown",function(down){
			var crobj = $(this);
			var initX = down.clientX;
			var initW = crobj.parent().width();
			var offsetX = down.clientX - crobj.position().left-1;
			datagrid.lineSplit.show();
			datagrid.lineSplit.height(datagrid.container.height());
			datagrid.lineSplit.css({"top":datagrid.container.position().top,
				left:initX - offsetX
				});
			datagrid.container.unbind("mousemove").bind("mousemove",function(move){
				//Eht.Utils.unselect();
				$(this).unselect();
				datagrid.lineSplit.css({left:move.clientX - offsetX});
				
			});
			datagrid.container.unbind("mouseup").bind("mouseup",function(up){
				//Eht.Utils.select();
				datagrid.lineSplit.hide();
				var colw = initW +up.clientX-initX;
				if(colw<20){
					colw=20;
				}
				var fid = crobj.parent().parent().attr("field");
				var cw = datagrid.tabBody.find("td[field='"+fid+"']").children();
				cw.width(colw - Eht.Utils.getMPBWidth(cw));
				crobj.parent().width(colw);
				
				datagrid.tabBody.find("col[field='"+fid+"']").css("width",colw);
				
				for(var i=0;i<datagrid.columns.length;i++){
					if(datagrid.columns[i].field==fid){
						datagrid.columns[i].width = colw;
					}
				}
				$(this).unbind("mouseup");
			});
		});
	}
	/**
	 * 计算  div 嵌套乘积(表头行数）
	 * @param selector
	 * @param lvl
	 * @param array
	 * @returns
	 */
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
	/**
	 * 初始化 div colspan 数值
	 * @param selector
	 */
	function  initColumn(selector){
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
	
	function getDivColumns(selector){
		
		initColumn(selector);
		var row = computeRow(selector,1,new Array());
		
	    var rowArray = new Array();
		for(var i=0;i<row;i++){
			var tr = $("<tr></tr>");
			rowArray.push(tr);
			datagrid.headerTable.append(tr);
		}
		
		for(var i=0;i<rowArray.length;i++){
			selector.find("div[row='"+(i+1)+"']").each(function(){
				var field = $(this).attr("field")==undefined?"field":$(this).attr("field");	
				var cr = $("<span class='header-col-resize'></span>");
				var coltnt=$("<div style='white-space:nowrap;' class='"+pre_col_class+field+"'><span>"+$(this).attr("label")+"</span></div>");
				coltnt.append(cr);
				var td = $("<td></td>");
				td.append(coltnt);
				td.attr("field",field);
				td.attr("colspan",$(this).attr("colspan"));
				if($(this).attr("display")=="false"){
					td.hide();
				}
				if($(this).children().size()==0){
					td.attr("rowspan",row - i);
				}
				rowArray[i].append(td);
				manresize(cr);
			});
		}
		var columns = new Array();
		
		selector.find("div[colspan='1']").each(function(){
			columns.push(toColumnObj($(this),$(this).attr("field"),$(this).attr("label")));
		});
		datagrid.selector.remove();
		datagrid.selector = datagrid.headerTable;
		return columns;
	}
	$(window).resize(function(){
		datagrid.resize();
	});
};
Eht.Datagrid.prototype.hasHeader=function(value){
	this.opt.hasHeader = value;
	if(this.opt.hasHeader){
		this.header.show();
	}else{
		this.header.hide();
	}
};
Eht.Datagrid.prototype.hasFooter=function(value){
	this.opt.hasFooter = value;
	if(this.opt.hasFooter){
		this.footer.show();
	}else{
		this.footer.hide();
	}
};
Eht.Datagrid.prototype.resize=function(){
	this.container.height(this.container.parent().height()-2);
	var h = this.container.height();
	if(this.opt.hasHeader){
		h = h -this.header.outerHeight(true);
	}
	if(this.opt.hasFooter){
		h = h - this.footer.outerHeight(true);
	}
	this.body.css("height",h-4);
	this.modalWait.height(this.body.height());
	this.modalWait.width(this.body.width());
	this.modalWait.css("top",this.body.position().top);
};
Eht.Datagrid.prototype.loadData=function(dataObj){
	if(this._object==null){
		this._object = dataObj;
	}
	//Object|array|func(this.opt.paginate,this.loadResp)
	var dg = this;
	if(this.opt.loadInit==true){
		this.modalWait.show();	
	}
	if(dataObj){
		if($.type(dataObj)=="object"){
			this.data = dataObj.rows?dataObj.rows:[];	
			this.setPaginate(dataObj.paginate);
		}else if($.type(dataObj)=="array"){
			this.data = dataObj;
		}else if($.type(dataObj)=="function"){
			this._loadData=dataObj;
			if(this.loadResp==null){
				this.loadResp = new Eht.Responder();
				var error = this.loadResp.error;
				this.loadResp.success=function(data, textStatus, jqXHR){
					if(dg._loadCompleteBefore){
						dg._loadCompleteBefore(data);
					}
					dg.loadData(data);
					if(dg._loadComplete){
						dg._loadComplete(data);
					}
				};
				this.loadResp.error=function(data, textStatus, jqXHR){
					error(data,textStatus,jqXHR);
					dg.modalWait.hide();
				};
			}
			if(this.opt.loadInit==true){
				this._loadData(this.opt.paginate,this.loadResp);
			}
			// 翻页事件调用
			this._clickPage = function(page){
				dg.modalWait.show();	
				dg._loadData(page,dg.loadResp);
			};
			return;
		}
		if($.type(this.data)=="array"){
			this.tabBody.empty();
			for(var i=0;i<this.data.length;i++){
				this.addRow(this.data[i],i,true);
			}
			this.modalWait.hide();
		}
	}
};
Eht.Datagrid.prototype.closeWait=function(){
	this.modalWait.hide();
}
Eht.Datagrid.prototype.loadCompleteBefore=function(func){
	//func(data);
	this._loadCompleteBefore=func;
};
Eht.Datagrid.prototype.loadComplete=function(func){
	// func(data)
	if(func==undefined){
		if(this._loadComplete){
			this._loadComplete(this.data);
		}
	}else{
		this._loadComplete = func;
	}
};
/**
 * 获取变化的数据（包含新增及修改的数据）
 */
Eht.Datagrid.prototype.getData=function(){
	var rtn = [];
	if(this.data!=null){
		for(var i=0;i<this.data.length;i++){
			if(this.data[i][this.opt.changeFlag]==1){
				var obj = new Object();
				for(var p in this.data[i]){
					if(p!=this.opt.changeFlag){
						obj[p] = this.data[i][p];
					}
				}
				rtn.push(obj);
			}
		}
	}
	return rtn;
};
Eht.Datagrid.prototype.setKeepSelectedValue=function(pkfieldValue){
	this.keepSelectedValues[pkfieldValue]=true;
};
Eht.Datagrid.prototype.clearKeepSelected=function(){
	for(var p in this.keepSelectedValues){
		delete this.keepSelectedValues[p];
	}
};
Eht.Datagrid.prototype.addRow=function(data){
	var dg = this;
	var r = arguments[1];
	var load = arguments[2];
	if(r==undefined){
		if(this.data){
			r = this.data.length;
		}else{
			r = 0;
			this.data=[];
		}
	}
	if(load==undefined || load==false){
		if(data==undefined){
			data = {};
		}
		data[this.opt.changeFlag] = 1;
		this.data.push(data);
	}
	var row = $("<tr class='eht-datagrid-row'></tr>");
	row.data(data);
	if(r%2==0){
		row.addClass("background-row1");
	}else{
		row.addClass("background-row2");
	}
	var pkFieldValue = data[dg.opt.pkField];
	if(pkFieldValue){
		if(dg.keepSelectedValues[pkFieldValue]){
			data[dg.opt.selectedField] = true;
		}
	}
	
	if(data[dg.opt.selectedField]){
		row.removeClass("eht-datagrid-row");
		row.addClass("datagrid-select-row");
	}
	this.tabBody.append(row);
	var cols = this.columns;
	var merge = true;
	for(var i=0;i<cols.length;i++){
		var col = $("<td></td>");
		col.attr("field",cols[i].field);
		col.attr("enable",cols[i].enable);
		if(cols[i].valign!=undefined){
			col.attr("valign",cols[i].valign);
		}
		if(cols[i].display==true||cols[i].display=="true"){
			col.show();
		}else{
			col.hide();
		}
		col.data(data);
		var tdcont=$("<div class='cell-container' style='overflow:hidden;width:"+cols[i].width+"px'></div>");
		var cell = $("<div class='eht-datagrid-cell'></div>");
		var lv = data[cols[i].field];
		if(lv==undefined){
			lv = dg.opt.defaultDisValue;
		}
		cell.html(lv);
		tdcont.append(cell);
		col.append(tdcont);
		col.dblclick(function(){
			if(dg._dblclickCell){
				var cfld = $(this).attr("field");
				return dg._dblclickCell(cfld,$(this).data());
			}
			return true;
		});
		if(cols[i].codes){
			var ds = cols[i].codes;
			var lbl=lv;
			for(var mm=0;mm<ds.length;mm++){
				if(lv==ds[mm][dg.opt.codeValueField]){
					lbl = ds[mm][dg.opt.codeLabelField];
					break;
				}
			}
			cell.html(lbl);
		}
		if(this._transColumn && this._transColumn[cols[i].field]){
			var h = this._transColumn[cols[i].field](data,r,cell,cols[i].field);
			if(h!=undefined){
				cell.html(h);
			}
			cell.find("input,select,textarea").change(function(){
				data[dg.opt.changeFlag] = 1;
			});
		}
		
		//行合并
		if(cols[i].merge==true){
			if(r>0){
				var fid = cols[i].field;
				var ctddata=data[fid];
				var ptddata=this.data[r-1][fid];
				if(this._transColumn && this._transColumn[fid]){
					var c_v = this._transColumn[fid](data,r,cell,fid);
					if(c_v!=undefined){
						ctddata = c_v;
					}
					var p_v = this._transColumn[fid](this.data[r-1],r-1,cell,fid);
					if(p_v!=undefined){
						ptddata = p_v;
					}
				}
				merge = merge && (ctddata==ptddata);
				if(merge){
					var tmtd=prevtr(row,fid);
					var rsp = tmtd.attr("rowspan")?parseInt(tmtd.attr("rowspan")):1;
					tmtd.attr("rowspan",rsp+1);
				}else{
					row.append(col);
				}
			}else{
				row.append(col);
			}
		}else{
			row.append(col);
		}
	}
	row.click(function(){
		var rowIndex = $(this).index();
		var rd = dg.data[rowIndex];
		if(dg.opt.multable){
			if(rd[dg.opt.selectedField]){
				row.addClass("eht-datagrid-row");
				row.removeClass("datagrid-select-row");
				delete rd[dg.opt.selectedField];
				delete rd[dg.opt.rowIndexField];
			}else{
				row.removeClass("eht-datagrid-row");
				row.addClass("datagrid-select-row");
				rd[dg.opt.selectedField]=true;
				rd[dg.opt.rowIndexField]=rowIndex;
			}
		}else{
			if(dg.opt.enableSingleCancel==true){
				if(rd[dg.opt.selectedField]==undefined){
					dg.clearSelected();
					row.removeClass("eht-datagrid-row");
					row.addClass("datagrid-select-row");
					rd[dg.opt.rowIndexField]=rowIndex;
					rd[dg.opt.selectedField]=true;
				}else{
					dg.clearSelected();
				}
			}else{
				dg.clearSelected();
				row.removeClass("eht-datagrid-row");
				row.addClass("datagrid-select-row");
				rd[dg.opt.selectedField]=true;
				rd[dg.opt.rowIndexField]=rowIndex;
			}
		}
		if(dg._clickRow){
			var selected = rd[dg.opt.selectedField];
			dg._clickRow(rd,selected,rowIndex,$(this));
		}
	});
	row.dblclick(function(){
		var rowIndex = $(this).index();
		var rd = dg.data[rowIndex];
		if(dg._dblclickRow){
			dg._dblclickRow(rd,rowIndex,$(this));
		}
	});
	
	if(load==undefined || load==false){
		this.body.scrollTop(this.tabBody.height());
	}
	
	function prevtr(trcomp,field){
		var td=trcomp.prev().children("td[field='"+field+"']");
		if(td.size()==0){
			return prevtr(trcomp.prev(),field);
		}
		return td;
	}
	if(this._addRowComplete){
		this._addRowComplete(r,data);
	}
	return r;
};
Eht.Datagrid.prototype.addRowComplete=function(func){
	//func(rowIndex,data);
	this._addRowComplete = func;
};
/**
 * 更新行数据
 * @param data 更新的数据
 * @param r 行号 从 0 开始
 */
Eht.Datagrid.prototype.updateRow=function(data,r){
	var dg = this;
	if(data==null || data==undefined){
		return;
	}
	if(r==undefined){
		r = data[this.opt.rowIndexField];
	}
	for(var p in data){		
		this.data[r][p]=data[p];
	}
	var row = this.tabBody.children("tbody").children("tr").eq(r);
	row.data(this.data[r]);
	row.children().each(function(){
		var v = dg.data[r][$(this).attr("field")];
		$(this).find("div.eht-datagrid-cell").html(v);
	});
};
Eht.Datagrid.prototype.updateColumn=function(field,value,func){
	/**
	 * func(data){return ["field1","field2"]}
	 * return array 返回的数组作为其他更新列
	 */
	//<div class="eht-datagrid-cell">A0009</div>
	//<input class="eht-datagrid-editcell" type="text" field="baaa02" readonly="readonly" style="vertical-align: middle; padding-right: 20px; width: 68px;">
	if(this.data){
		var trs = this.tabBody.children("tbody").children("tr");
		var col = null;
		for(var i=0;i<this.columns.length;i++){
			if(this.columns[i].field==field){
				col = this.columns[i];
				break;
			}
		}
		for(var i=0;i<this.data.length;i++){
			this.data[i][field] = value;
			var lbl = value;
			if(col!=null){
				if(col.codes!=null){
					for(var n=0;n<col.codes.length;n++){
						if(value==col.codes[n][this.opt.codeValueField]){
							lbl = col.codes[n][this.opt.codeLabelField];
							break;
						}
					}
				}
			}
			trs.eq(i).find("td[field='"+field+"']").find("input[field='"+field+"']").val(lbl);
			trs.eq(i).find("td[field='"+field+"']").find("div.eht-datagrid-cell").html(lbl);
			//更新 renderer 列
			var rd = this.editorRenderers[i];
			if(rd && rd[field] && rd[field].editor){
				rd[field].editor.setValue(value);
			}
			if(func){
				var arrays = func(this.data[i]);
				if(arrays){
					for(var j=0;j<arrays.length;j++){
						var v = this.data[i][arrays[j]];
						trs.eq(i).find("td[field='"+arrays[j]+"']").find("input[field='"+field+"']").val(v);
						trs.eq(i).find("td[field='"+arrays[j]+"']").find("div.eht-datagrid-cell").html(v);
					}
				}
			}
		}
	}
}
Eht.Datagrid.prototype.clearSelected=function(extendfunc){
	//extendfunc(index,row,data) //扩展接口方法
	this.tabBody.find("tr").addClass("eht-datagrid-row");
	this.tabBody.find("tr").removeClass("datagrid-select-row");
	this.tabBody.find("input[type='checkbox'],input[type='radio']").each(function(){
		if($(this).attr("clear")!="false"){
			this.checked = false;
		}
	});
	for(var i=0;i<this.data.length;i++){
		delete this.data[i][this.opt.selectedField];
		delete this.data[i][this.opt.rowIndexField];
		if(extendfunc){
			var row = this.tabBody.children("tbody").children("tr").eq(i);
			extendfunc(i,row,this.data[i]);
		}
	}
};
Eht.Datagrid.prototype.multable=function(flag){
	this.opt.multable = flag;
};
Eht.Datagrid.prototype.clickRowBefore=function(func){
	//func(data) return boolean  ,true 继续执行，false 不执行下面的操作
};
Eht.Datagrid.prototype.clickRow=function(func){
	// func(data,selected,rowIndex,row)
	this._clickRow=func;
};
Eht.Datagrid.prototype.dblclickRow=function(func){
	// func(data,rowIndex,row)
	this._dblclickRow=func;
};
Eht.Datagrid.prototype.dblclickCell=function(func){
	// func(field,data)  return true/false
	this._dblclickCell = func;
};
Eht.Datagrid.prototype.refresh=function(){
	this.opt.loadInit=true;
	this.loadData(this._object);
	/*
	if(this.opt.isPaginate){
		this.opt.paginate.indexPage = 1;
		this._clickPage(this.opt.paginate);
	}else{
		this._clickPage(null);
	}
	*/
};
Eht.Datagrid.prototype.clickPage=function(func){
	//func(Eht.Paginate)
	this._clickPage=func;
};
Eht.Datagrid.prototype.setPaginate=function(page){
	if(this.opt.isPaginate==true){
		if(page){
			if(this.opt.paginate){
				for(p in page){
					this.opt.paginate[p]=page[p];
				}
			} else{
				this.opt.paginate = $.extend(new Eht.Paginate(),page);
			}
			page = this.opt.paginate;
			var txt = this.footer.find("#txtIndex");
			txt.val(page.indexPage);
			//当前页
			var ipage = this.footer.find("#indexPage");
			ipage.html(page.indexPage);
			//总页数
			var tp = this.footer.find("#totalPage");
			tp.html(page.getTotalPage());
			//每页条数
			var pc = this.footer.find("#pageCount");
			pc.val(page.pageCount);
			//一共条数
			var tc = this.footer.find("#totalCount");
			tc.html(page.totalCount);
		}
	}
};
/**
 * 获取选中的数据
 * @param 如果有参数，只获取选中对应参数的属性的值的数据，没有参数，获取选中的所有的属性数据
 * @returns {Array}
 */
Eht.Datagrid.prototype.getSelectedData=function(){
	var rtn = new Array();
	if(this.data==null || this.data==undefined){
		return rtn;
	}
	for(var i=0;i<this.data.length;i++){
		if(this.data[i][this.opt.selectedField]==true){
			if(arguments.length>0){
				var ds = new Object();
				for(var j=0;j<arguments.length;j++){
					ds[arguments[j]] = this.data[i][arguments[j]];
				}
				rtn.push(ds);
			}else{
				rtn.push(this.data[i]);
			}
		}
	}
	return rtn;
};
Eht.Datagrid.prototype.transColumn=function(field,func){
	//func(data,rowIndex,cell,field)
	/*if(this._transColumn==undefined || this._transColumn==null){
		this._transColumn = new Object();
	}*/
	this._transColumn[field]=func;
};
Eht.Datagrid.prototype.editRow=function(rowIndex,option){
	if(this.data[rowIndex]){
		this.data[rowIndex][this.opt.changeFlag] = 1;
	}
	// option 参数格式如下：
	var def = [{field:null, //列
				editor:null,//默认为   text   editor:new ComboBox();
				enable:true,//true 编辑，flase 不可编辑
				validate:[]  // 验证 ，见 form validate
				}
		];
	var opt = new Object();;
	if(option==undefined){
		option = new Array();
	}
	var opttmp = {};
	for(var i=0;i<option.length;i++){
		opttmp[option[i].field] = true;
	}
	///// 优先级以当前 option 为优先级的功能没有实现，实现的时候，要判断目前已经存在的属性 
	///// 和 _renderer 中的 field 比较，如果，有了，_renderer信息就不添加到 option 中了
	var comboObj={};
	if(this._renderer){
		for(var p in this._renderer){
			if(this._renderer[p].funcEditor && $.isFunction(this._renderer[p].funcEditor)){
				this._renderer[p].editor = this._renderer[p].funcEditor(rowIndex);
				comboObj[p]=this._renderer[p].editor;
			}
			if(opttmp[p]!=true){
				option.push(this._renderer[p]);
			}
		}
	}
	this._comboxs[rowIndex]=comboObj;
	if($.type(option)=="object"){
		initOption(option);
		opt[option.field] = option;
	}
	if($.type(option)=="array"){
		for(var i=0;i<option.length;i++){
			initOption(option[i]);
			opt[option[i].field] = option[i];
		}
	}
	var dg = this;
	var row = this.tabBody.children("tbody").children("tr").eq(rowIndex); 
	row.children().each(function(){
		var field = $(this).attr("field");
		var v = dg.data[rowIndex][field];
		if(v==undefined){
			v=dg.opt.defaultDisValue;
		}
		var divtxt = $("<div class='eht-datagrid-editcell-div'></div>");
		var txt = $("<input class='eht-datagrid-editcell' type='text'/>");
		txt.val(v);
		//txt.attr("rowIndex",rowIndex);
		txt.attr("field",field);
		
		if(opt && opt[field]!=null && opt[field].enable){
			if($(this).children("div").find("input,select,textarea").size()==0){
				//添加默认编辑框
				divtxt.append(txt);
				$(this).children("div").html("");
				$(this).children("div").append(divtxt);
			}
			//不可编辑
		}else if(opt && opt[field]!=null && opt[field].enable==false){
			$(this).attr("enable","false");
			return;
		}else if($(this).attr("enable")=="true"){//可编辑
			if($(this).children("div").find("input,select,textarea").size()==0){
				divtxt.append(txt);
				$(this).children("div").html("");
				$(this).children("div").append(divtxt);
			}
		}
		if(opt && opt[field]!=null){
			if(opt[field].validate && opt[field].validate.length>0){
				txt.attr("validate",JSON.stringify(opt[field].validate));
			}
			//添加编辑的渲染（combobox渲染）
			if(opt[field].editor){
				opt[field].editor.init(txt);
				dg.comboPanels.push(opt[field].editor.comboPanel);
				dg.editorRenderers[rowIndex] = opt;
				opt[field].editor.container.css({"margin":"0px",padding:"0px"});
				opt[field].editor.button.css({"margin-top":"-1px","margin-left":"-17px"});
				opt[field].editor.setValue(v);
				opt[field].editor.change(function(data){
					var tr = getTr(this.selector);
					var ri = tr.index();
					if($.type(data)=="object"){
						dg.data[ri][this.selector.attr("field")]=data[this.opt.valueField];
					}else{
						dg.data[ri][this.selector.attr("field")]=data;
					}
					if(dg._cellChange){
						dg._cellChange(this.selector.attr("field"),dg.data[ri],data,ri);
					}
				});
			}else{
				txt.unbind("change").bind("change",function(){
					var tr = getTr($(this));
					var ri = tr.index();
					dg.data[ri][$(this).attr("field")] = $(this).val();
					//getTr($(this)).data(dg.data[$(this).attr("rowIndex")-0]);
					if(dg._cellChange){
						dg._cellChange($(this).attr("field"),dg.data[ri],$(this).val(),ri);
					}
				});
			}
		}else{
			txt.unbind("change").bind("change",function(){
				var tr = getTr($(this));
				var ri = tr.index();
				dg.data[ri][$(this).attr("field")] = $(this).val();
				//getTr($(this)).data(dg.data[$(this).attr("rowIndex")-0]);
				if(dg._cellChange){
					dg._cellChange($(this).attr("field"),dg.data[ri],$(this).val(),ri);
				}
			});
		}
	});
	
	function getTr(node){
		if(node.parent().is("tr")){
			return node.parent();
		}else{
			return getTr(node.parent());
		}
	};
	function initOption(option){
		for(p in def[0]){
			if(option[p]==undefined){
				option[p]=def[0][p];
			}
		}
	};
};
/**
 * option 格式可以为 {editor:function(){return },enable:true,validate:[]} 也可以使 function(){return eht.combobox}
 * @param field
 * @param option
 */
Eht.Datagrid.prototype.renderer = function(field,option){
	// option 参数个数如下：
	var def = {
		editor:null,//默认为   text   editor:new ComboBox();
		enable:true,//true 编辑，flase 不可编辑
		validate:[]  // 验证 ，见 form validate
	};
	if(this._renderer == undefined || this._renderer == null){
		this._renderer = new Object();
	}
	if($.isFunction(option)){
		if(this._renderer[field]==undefined){
			this._renderer[field]=new Object();
		}
		var o = option();
		if(o.editor==undefined){
			this._renderer[field].funcEditor = option;
			this._renderer[field].field = field;
		}else{
			o.field = field;
			if($.isFunction(o.editor)){
				o.funcEditor = o.editor;
			}
			this._renderer[field] = o;
		}
	}else{
		option.field = field;
		this._renderer[field] = option;
	}
};
Eht.Datagrid.prototype.getRenderer = function(rowIndex,field){
	var rend = this._comboxs[rowIndex];
	if(rend!=null){
		if(rend[field]){
			return rend[field];
		}
	}
	return null;
}
/**
 * 清除
 */
Eht.Datagrid.prototype.clear=function(){
	this.data = [];
	/*
	for(var i=0;i<this.comboPanels.length;i++){
		//清楚编辑渲染编辑器
		if(this.comboPanels[i]){
			this.comboPanels[i].remove();
		}
	}
	this.comboPanels = [];
	*/
	//this.tabBody.children().remove();
	this.tabBody.empty();
};
Eht.Datagrid.prototype.getSelectedRow=function(rowIndex){
	var row = this.tabBody.children("tbody").children("tr").eq(rowIndex);
	row.parent().children().removeClass("datagrid-select-row");
	row.addClass("datagrid-select-row");
	
	var rowtop = row.offset().top - this.body.offset().top;
	if(rowtop + row.outerHeight(true) + this.body.scrollTop() > this.body.height()){
		this.body.scrollTop(rowtop + row.outerHeight(true) + this.body.scrollTop() - this.body.height());
	}else{
		this.body.scrollTop(0);
	}
	return row;
};
Eht.Datagrid.prototype.getRow=function(rowIndex){
	var row = this.tabBody.children("tbody").children("tr").eq(rowIndex);
	return row;
};
Eht.Datagrid.prototype.selectAllRow=function(extendfunc){
	//extendfunc(index,row,data) //扩展接口方法
	for(var i = 0;i<this.data.length;i++){
		var row = this.tabBody.children("tbody").children("tr").eq(i);
		row.addClass("datagrid-select-row");
		var rd = this.data[i];
		rd[this.opt.selectedField]=true;
		rd[this.opt.rowIndexField]=i;
		if(extendfunc){
			extendfunc(i,row,rd);
		}
	}
};
/**
 * 设置 选择的数据及行
 * @param ds   要选择的数据集合 array
 * @param isFunc  符合的条件 function
 * 注：如果，第一个参数为 数字类型，则是 rowIndex 数据，直接对行进行选择，第二个参数为 boolean 类型，表示是否清除选择
 */
Eht.Datagrid.prototype.setSelectedRow=function(ds,isFunc,extendfunc){
	//isFunc([],data[i]) return true/false
	//extendfunc(index,row,data) //扩展接口方法
	var dg = this;
	if(arguments.length>=1 && $.isNumeric(arguments[0])){
		if(arguments.length>=2){
			if(arguments[1]==true){
				this.clearSelected();
			}
		}else{
			this.clearSelected();
		}
		var rowIndex = arguments[0];
		var row = this.tabBody.children("tbody").children("tr").eq(rowIndex);
		row.addClass("datagrid-select-row");
		var rd = dg.data[rowIndex];
		if(rd!=null){
			rd[dg.opt.selectedField]=true;
			rd[dg.opt.rowIndexField]=rowIndex;
		}
		if(arguments.length==3){
			if(arguments[2]){
				arguments[2](rowIndex,row,rd);
			}
		}
		return;
	}
	this.clearSelected();
	if(arguments.length>=1 && $.type(arguments[0])=="string"){
		for(var i = 0;i<this.data.length;i++){
			if((this.data[i][dg.opt.pkField]+"")==arguments[0]){
				var row = this.tabBody.children("tbody").children("tr").eq(i);
				row.addClass("datagrid-select-row");
				var rd = dg.data[i];
				if(rd!=null){
					rd[dg.opt.selectedField]=true;
					rd[dg.opt.rowIndexField]=i;
				}
			}
		}
	}
	if(ds && $.isArray(ds) && isFunc && $.isFunction(isFunc)){
		for(var i = 0;i<this.data.length;i++){
			if(isFunc(ds,this.data[i])){
				var row = this.tabBody.children("tbody").children("tr").eq(i);
				row.addClass("datagrid-select-row");
				var rd = dg.data[i];
				if(rd!=null){
					rd[dg.opt.selectedField]=true;
					rd[dg.opt.rowIndexField]=i;
					if(extendfunc){
						extendfunc(i,row,rd);
					}
				}
			}
		}
	}
};
Eht.Datagrid.prototype.cellChange=function(func){
	//func(field,rowData,changeData,rowIndex)
	this._cellChange = func;
};
Eht.Datagrid.prototype.setRendererData=function(rowIndex,field,data,defaultValue){
	var rd = this.editorRenderers[rowIndex];
	if(rd && rd[field] && rd[field].editor){
		rd[field].editor.loadData(data);
		if(defaultValue){
			rd[field].editor.setValue(defaultValue);
			this.data[rowIndex][field]=defaultValue;
		}
	}
};
Eht.Datagrid.prototype.setCell=function(rowIndex,field,value,setdata){
	var cell = this.tabBody.children("tbody").children("tr").eq(rowIndex-0).children("td[field='"+field+"']");
	if(cell.find(".eht-datagrid-cell").size()>0){
		cell.find(".eht-datagrid-cell").html(value);
	}
	if(cell.find(".eht-datagrid-editcell").size()>0){
		cell.find(".eht-datagrid-editcell").val(value);
	}
	if(setdata==undefined || setdata==null || setdata == true){
		var rd = this.data[rowIndex-0];
		rd[field]=value;
	}
};
/**
 * @param rowIndex 索引，如果是 string类型，数据为 pkfield 值
 * 移除所选择的行及数据
 * @returns {Array}  返回选择的移除行数据
 */
Eht.Datagrid.prototype.removeSelectedData=function(){
    var rtn = new Array();
    for(var i=this.data.length - 1;i>=0;i--){
    	if(this.data[i][this.opt.selectedField]==true){
    		this.tabBody.children("tbody").children("tr").eq(i).remove();
    		this._comboxs.splice(i,1);
    		rtn.push(this.data.splice(i,1)[0]);
    	}
    }
    return rtn;
};
Eht.Datagrid.prototype.removeRow=function(rowIndex){
	var rtn = null;
	if(this.data !=null){
		if($.type(rowIndex)=="string"){
			for(var i=this.data.length-1;i>=0;i--){
				if(this.data[i][this.opt.pkField]==rowIndex){
					this.tabBody.children("tbody").children("tr").eq(i).remove();
					this._comboxs.splice(i,1);
					rtn = this.data.splice(i,1)[0];
				}
			}
		}else{
			if(rowIndex<this.data.length){	
				this.tabBody.children("tbody").children("tr").eq(rowIndex).remove();
				this._comboxs.splice(rowIndex,1);
				rtn = this.data.splice(rowIndex,1)[0];
			}
		}
	}
    return rtn;
};
Eht.Datagrid.prototype.openRowForm=function(data){
	var dg = this;
	/**
		column.field=field;
		column.width = w;
		column.label = html;
		column.enable = $(this).attr("enable")?$(this).attr("enable"):true;
		column.code = "",or "[{v:1,d:"d"}]"
		column.ehtType
		column.validate
		column.type =  $(this).attr("type");
	 */
	this.rowForm.empty();
	for(var i=0;i<this.columns.length;i++){
		if(this.columns[i].mkform!="false"){
			var itemform = $("<div class='row-form-item'><label>"+this.columns[i].label+"：</label></div>");
			var input = $("<input type='text'/>");
			input.attr("name",this.columns[i].field);
			if(this.columns[i].code){
				input.attr("code",this.columns[i].code);
			}
			if(this.columns[i].ehtType){
				input.attr("ehtType",this.columns[i].ehtType);
			}
			if(this.columns[i].validate){
				input.attr("validate",JSON.stringify(this.columns[i].validate));
			}
			if(this.columns[i].opt){
				input.attr("opt",JSON.stringify(this.columns[i].opt));
			}
			itemform.append(input);
			this.rowForm.append(itemform);
		}
	}
	var formCmd = $("<div align='center' style='text-align:center;margin-top:5px;'></div>");
	var enterbtn = $("<input type='button' value='确认'/>");
	var cannel = $("<input type='button' value='取消'/>");
	formCmd.append(enterbtn);
	formCmd.append(cannel);
	this.rowForm.append(formCmd);
	this.rowForm.width(this.body.width()-2);
	this.rowForm.show();
	this.rowForm.animate({opacity:1,top:dg.body.height()/2-this.rowForm.height()});
	this.form = new Eht.Form({selector:this.rowForm});
	if(data){
		this.form.fill(data);
	}
	/**
	 * datagrid renderer 方式 暂时 没有实现 
	 */
	enterbtn.unbind("click").bind("click",function(){
		if(dg._clickOk){
			if(dg.form.validate()){
				dg._clickOk(dg.form.getData());
				dg.closeRowForm();
			}
		}
	});
	cannel.unbind("click").bind("click",function(){
		dg.closeRowForm();
	});
};
Eht.Datagrid.prototype.closeRowForm=function(){
	this.rowForm.animate({top:"",opacity:0},{complete:function(){		
		$(this).hide();
	}});
};
Eht.Datagrid.prototype.clickOk=function(func){
	//func(rowData)
	this._clickOk = func;
};
Eht.Datagrid.prototype.hideColumn=function(field){
	this.headerTable.find("td[field='"+field+"']").hide();
	this.tabBody.find("td[field='"+field+"']").hide();
	for(var i=0;i<this.columns.length;i++){
		if(field==this.columns[i].field){
			this.columns[i].display=false;
		}
	}
};
Eht.Datagrid.prototype.showColumn=function(field){
	this.headerTable.find("td[field='"+field+"']").show();
	this.tabBody.find("td[field='"+field+"']").show();
	for(var i=0;i<this.columns.length;i++){
		if(field==this.columns[i].field){
			this.columns[i].display=true;
		}
	}
};