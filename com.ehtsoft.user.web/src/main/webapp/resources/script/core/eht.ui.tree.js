/**
 * @author wangbao
 * @param opt
 * @returns {Eht.Tree}
 */
Eht.Tree=function(opt){
	var tree = this;
	var def = {
		selector:null,
		labelField:"label",
		pkField:"_uuid",
		pidField:"_puid",//上级编码 属性
		childrenField:"children",
		loadInit:true, //true 页面加载后，直接调用 loadData 方法，填充表格数据  false 页面加载后，不填充表格数据
		hideChildren:false,
		multable:false,//多选
		checkbox:false,
		cascadeSelect:true, //点击 checkbox 时，级联选择 父节点及children 节点 checkbox
		hideParentCheckbox:false,
		selectedField:"selected",
		onlyLeafClick:false, //是否仅 叶子节点触发点击事件 
		keep:false,
		css:{}
	};
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector==null?"<div></div>":this.opt.selector);
	this.selector.addClass("eht-base");
	this.selector.addClass("eht-tree");
	this.body = $("<ul class='eht-tree-ul'></ul>");
	this.modalWait = $("<div class='datagrid-modal-wait' style='position:absolute;'></div>");
	this.selector.append(this.body);
	this.selector.append(this.modalWait);
	this.container = this.selector;
	this.radioData = null;
	this.radioUuid = null;
	this.resize();
	$(window).resize(function(){
		tree.resize();
	});
};
Eht.Tree.prototype.loadData=function(obj){
	// [] or func(res)
	this.radioData = null;// load 时，将 单选的数据清空
	var tree = this;
	if(this._object==null){
		this._object = obj;
	}
	this.modalWait.show();
	this.modalWait.height(this.selector.outerHeight(true));
	this.modalWait.width(this.selector.outerWidth(true));
	this.modalWait.css("top",this.selector.position().top);
	this.modalWait.css("left",0);
	
	var childrenField = this.opt.childrenField;
	if($.type(obj)=="array"){
		this.data = obj;
		this.body.empty();
		iterdata(this.data,this.body,null);
		tree.modalWait.hide();
	}else if($.type(obj)=="function"){
		this._loadData = obj;
		if(this.loadResp==null){
			this.loadResp = new Eht.Responder();
			this.loadResp.success=function(data, textStatus, jqXHR){
				tree.loadData(data);
				if(tree._loadComplete){
					tree._loadComplete(data);
				}
			};
			this.loadResp.error=function(data, textStatus, jqXHR){
			};
		}
		if(this.opt.loadInit == true){
			this._loadData(this.loadResp);
		}else{
			tree.modalWait.hide();
		}
	}
	function iterdata(data,body,puid){
		for(var i=0;i<data.length;i++){
			if(data[i][tree.opt.pkField]==undefined){
				data[i][tree.opt.pkField] = Eht.Utils.createUuid();
			}
			var li = tree.addRow(data[i],puid,body);
			if(data[i][childrenField] && data[i][childrenField].length>0){
				var pid = data[i][tree.opt.pkField];
				var ul = $("<ul class='eht-tree-item-ul'></ul>");
				ul.attr("pid",pid);
				if(tree.opt.hideChildren==true){
					ul.hide();
				}
				li.append(ul);
				iterdata(data[i][childrenField],ul,pid);
			}
		}
	}
};
Eht.Tree.prototype.loadComplete=function(func){
	//func(data)
	this._loadComplete = func;
};
Eht.Tree.prototype.hideChildren=function(){
	this.body.find(".eht-tree-item-ul").hide();
	this.body.find(".eht-tree-icon-open").removeClass("eht-tree-icon-open").addClass("eht-tree-icon-close");
	this.opt.hideChildren = true;
};
Eht.Tree.prototype.showChildren=function(){
	this.body.find(".eht-tree-item-ul").show();
	this.body.find(".eht-tree-icon-close").removeClass("eht-tree-icon-close").addClass("eht-tree-icon-open");
	this.opt.hideChildren = false;
};
Eht.Tree.prototype.addRow=function(data,pid,body){
	var tree = this;
	if(data[tree.opt.pidField]==undefined){
		data[tree.opt.pidField] = pid;
	}
	var childrenField = this.opt.childrenField;
	var icon = $("<span class='eht-tree-icon eht-tree-icon-open'></span>");
	if(tree.opt.hideChildren==true){
		icon.removeClass("eht-tree-icon-open").addClass("eht-tree-icon-close");
	}
	if(data[childrenField]==undefined ||
			data[childrenField]==null || 
			data[childrenField].length==0){
		icon.removeClass("eht-tree-icon-open").removeClass("eht-tree-icon-close").addClass("eht-tree-icon-text");
		if(tree._eachLeafIcon){
			var leaf = tree._eachLeafIcon(data,icon);
			if(leaf){
				icon.removeClass("eht-tree-icon-text").addClass(leaf);
			}
		}
	}
	var li = $("<li style='cursor:pointer;'></li>");
	var row = $("<div class='eht-tree-item'></div>");
	row.data(data);
	row.attr("uuid",data[tree.opt.pkField]);
	if(tree.radioUuid==data[tree.opt.pkField]){
		tree.radioData = data;
		row.addClass("eht-tree-selected");
		var scbox = row.find("input[type='checkbox'][uuid='"+$(this).attr("uuid")+"']");
		if(scbox.size()>0){
			scbox.get(0).checked = true;
		}
	}
	// 多选
	if(this.opt.multable || this.opt.checkbox){
		var checkbox = $("<input type='checkbox' style='vertical-align:top;'/>");
		checkbox.attr("uuid",data[tree.opt.pkField]);
		checkbox.attr("pid",pid);
		var sv = data[this.opt.selectedField];
		if(sv==true||sv=="true"||sv==1||sv=="1"||sv=="y"||sv=="Y"||sv=="T"||sv=="t"){
			checkbox.attr("checked",true);
		}
		checkbox.data(data);
		var spanbox = $("<span style='vertical-align:top;'></span>");
		if(this.opt.hideParentCheckbox==false){
			spanbox.append(checkbox);
			row.append(spanbox);
		}else{
			if(data[childrenField]==null || data[childrenField].length==0){
				spanbox.append(checkbox);
				row.append(spanbox);
			}
		}
		checkbox.unbind("change").bind("change",function(e){
			if(tree.opt.cascadeSelect){
				bindChildrenbox($(this));
				bindParentBox($(this));
			}
			if(tree._checkboxChange){
				tree._checkboxChange($(this).data(),e);
			}
		});
		
	}
	row.append(icon);
	var lbl = $("<span style='vertical-align:top;margin-left:4px;'>"+data[this.opt.labelField]+"</span>");
	row.append(lbl);
	if(tree._transLabel){
		var lblv = tree._transLabel(data);
		if(lbl!=undefined){
			lbl.html(lblv);
		}
	}
	li.append(row);
	body.append(li);
	// 事件
	icon.unbind("click").bind("click",function(){
		if(tree.body.find("ul[pid='"+$(this).parent().attr("uuid")+"']").is(":hidden")){
			tree.body.find("ul[pid='"+$(this).parent().attr("uuid")+"']").show();
			$(this).removeClass("eht-tree-icon-close").addClass("eht-tree-icon-open");
		}else{
			tree.body.find("ul[pid='"+$(this).parent().attr("uuid")+"']").hide();
			$(this).removeClass("eht-tree-icon-open").addClass("eht-tree-icon-close");
		}
	});
	row.unbind("click").bind("click",function(){
		tree.body.find(".eht-tree-selected").removeClass("eht-tree-selected");
		$(this).addClass("eht-tree-selected");
		//单选 并且 显示  checkbox
		if(tree.opt.multable==false && tree.opt.checkbox==true){
			tree.selector.find("input[type='checkbox']").each(function(){
				this.checked = false;
			});
			var scbox = tree.selector.find("input[type='checkbox'][uuid='"+$(this).attr("uuid")+"']");
			if(scbox.size()>0){
				scbox.get(0).checked = true;
			}
		}
		if(tree._clickRow){
			if(tree.opt.onlyLeafClick==true){
				//只有叶子节点才触发点击事件
				if(!($(this).data()[tree.opt.childrenField] && $(this).data()[tree.opt.childrenField].length>0)){
					tree.radioData=$(this).data();
					tree._clickRow($(this).data());
				}
			}else{
				tree.radioData=$(this).data();
				tree._clickRow($(this).data());
			}
			tree.radioUuid = $(this).attr("uuid");
		}
	});
	
	row.unbind("dblclick").bind("dblclick",function(){
		if(tree._dblclickRow){
			if(tree.opt.onlyLeafClick==true){
				//只有叶子节点才触发点击事件
				if(!($(this).data()[tree.opt.childrenField] && $(this).data()[tree.opt.childrenField].length>0)){
					tree._dblclickRow($(this).data());
				}
			}else{
				tree._dblclickRow($(this).data());
			}
		}
	});
	
	function bindChildrenbox(box){
		var d = box.data();
		if(d[childrenField] && d[childrenField].length>0){
			for(var i=0;i<d[childrenField].length;i++){
				tree.body.find("input[type='checkbox'][uuid='"+d[childrenField][i][tree.opt.pkField]+"']").each(function(){
					$(this).get(0).checked =  box.get(0).checked;
					if($(this).data()[childrenField] && $(this).data()[childrenField].length>0){
						bindChildrenbox($(this));
					}
				});
			}
		}
	}
	function bindParentBox(box){
		var pid = box.attr("pid");
		var pbox = tree.body.find("input[type='checkbox'][uuid='"+pid+"']");
		if(pbox.size()>0){
			var ul = getParentNode(box,"ul");
			if(box.get(0).checked){
				pbox.get(0).checked = box.get(0).checked;
			}
			if(ul.find("input[type='checkbox']").is(":checked")==false){
				pbox.get(0).checked = box.get(0).checked;
			}
			bindParentBox(pbox);
		}
	}
	function getParentNode(box,node){
		if(box.parent().is(node)){
			return box.parent();
		}else{
			return getParentNode(box.parent(),node);
		}
	}
	return li;
};
Eht.Tree.prototype.clickRow=function(func){
	//func(data)
	this._clickRow=func;
};
Eht.Tree.prototype.dblclickRow=function(func){
	//func(data)
	this._dblclickRow = func;
};
Eht.Tree.prototype.checkboxChange=function(func){
	//func(data,e);
	this._checkboxChange=func;
};
Eht.Tree.prototype.refresh=function(){
	this.opt.loadInit = true;
	this.loadData(this._object);
	if(this.opt.keep==false){
		this.radioUuid = null;
	}
};
Eht.Tree.prototype.resize=function(){
	this.container.height(this.container.parent().height()-Eht.Utils.getMPBHeight(this.container));
	this.container.css("overflow","auto");
	this.container.css(this.opt.css);
	this.modalWait.height(this.selector.outerHeight(true));
	this.modalWait.width(this.selector.outerWidth(true));
	this.modalWait.css("top",this.selector.position().top);
	this.modalWait.css("left",0);
};
/**
 * 将单选择的数据（包含子节点）转化成数组并返回
 * @param property  需要转化数组的属性，无参数时，将所有手续转化成对象的数组
 * @returns {Array}
 */
Eht.Tree.prototype.radioData2Array=function(property){
	var children = this.opt.childrenField;
	var rtn = new Array();
	if(this.radioData==null){
		return rtn;
	}
	if(property){
		iterate2(this.radioData);
	}else{
		iterate1(this.radioData);
	}
	function iterate1(radioData){
		var obj = new Object();
		for(p in radioData){
			if(p!=children){
				obj[p]=radioData[p];
			}else{
				if(radioData[children]){
					for(var i=0;i<radioData[children].length;i++){
						iterate1(radioData[children][i]);
					}
				}
			}
		}
		rtn.push(obj);
	}
	function iterate2(radioData){
		var obj = radioData[property];
		if(radioData[children]){
			for(var i=0;i<radioData[children].length;i++){
				iterate2(radioData[children][i]);
			}
		}
		rtn.push(obj);
	}
	return rtn;
};
/**
 * 得到复选的数据
 * @param lastnode  有参数，并且参数 = true 时，获取末节点数据
 * @param singleProp 只获取 对象中的一个属性数据，作为 array 返回 
 * @returns {Array}
 */
Eht.Tree.prototype.getSelectedData=function(lastnode,singleProp){
	var tree = this;
	var rtn = new Array();
	this.body.find("input[type='checkbox']:checked").each(function(){
		var data = $(this).data();
		var obj = new Object();
		for(var p in data){
			if(p!=tree.opt.childrenField){
				obj[p] = data[p];
			}
		}
		if(lastnode==true){
			if(!data[tree.opt.childrenField] ||(data[tree.opt.childrenField] && data[tree.opt.childrenField].length==0)){
				if(singleProp!=null){
					rtn.push(obj[singleProp]);
				}else{
					rtn.push(obj);
				}
			}
		}else{
			if(singleProp!=null){
				rtn.push(obj[singleProp]);
			}else{
				rtn.push(obj);
			}
		}
	});
	return rtn;
};
Eht.Tree.prototype.tree2List = function(){
	var rtn = new Array();
	if(this.data){
		iter(this.data);
	}
	var cfd = this.childrenField;
	function iter(data){
		for(var i=0;i<data.length;i++){
			rtn.push(data[i]);
			if(data[i][cfd] && data[i][cfd].length > 0){
				var children = data[i][cfd];
				delete data[i][cfd];
				iter(children);
			}
		}
	}
};
Eht.Tree.prototype.transLabel=function(func){
	//func(data)
	this._transLabel = func;
};
Eht.Tree.prototype.eachLeafIcon=function(func){
	//func(data,iconspan)
	this._eachLeafIcon = func;
};

Eht.Tree.prototype.clear=function(){
	this.selector.find(".eht-tree-selected").removeClass("eht-tree-selected");
	this.selector.find("input[type='checkbox']:checked").each(function(){
		this.checked = false;
	});
};
/**
 * pkFields 为对应  opt 中的 pkField 值的数组
 * @param pkFields
 */
Eht.Tree.prototype.setSelectedRow=function(pkFields){
	this.clear();
	if(pkFields!=null && $.isArray(pkFields)){
		for(var i=0;i<pkFields.length;i++){
			this.selector.find("[uuid='"+pkFields[i]+"']").each(function(){
				if($(this).is("input")){
					this.checked = true;
				}else{
					$(this).addClass("eht-tree-selected");
				}
			});
		}
	}
};
