/**
 * @author wangbao
 */
Eht.BootTree=function(opt){
	var self = this;
	var def = {
		selector:null,
		labelField:null,// default text
		pidField:"parentid",
		pkField:"id",
		color:"#444",
		childrenField:"nodes",
		showBorder:false,
		showCheckbox:false
	}
	this.opt=$.extend(def,opt); 
	this.selector = $(this.opt.selector);
	
	this.resp = new Eht.Responder();
	this.resp.success=function(data){
		self._createTreeview(data);
	}
};
Eht.BootTree.prototype._createTreeview=function(data){
	var self = this;
	self.opt.data = data;
	if(self.opt.labelField!=null){
		_s(data);
	}
	function _s(ds){
		for(var i=0;i<ds.length;i++){
			var od = ds[i];
			for(var p in od){
				if(p == self.opt.labelField){
					od["text"] = od[p];
					break;
				}
			}
			if(od.nodes != null && od.nodes.length > 0){
				_s(od.nodes);
			}
		}
	}
	self.selector.empty();
	self.selector.treeview(self.opt);
	if(this._clickItem!=null && $.isFunction(this._clickItem)){
		this.selector.on('nodeSelected', function(event, data) {
			self._clickItem.call(self,data,true);
		});
		this.selector.on('nodeUnselected',function(event,data){
			self._clickItem.call(self,data,false);
		});
	}
};
Eht.BootTree.prototype.getParentData=function(nodeData){
	var self = this;
	var rtn = null;
	if(self.opt.data!=null){
		_s(self.opt.data)
		
	}
	function _s(ds){
		for(var i=0;i<ds.length;i++){
			var pid= nodeData[self.opt.pidField];
			var id = ds[i][self.opt.pkField];
			if(id == pid){
				rtn = ds[i];
				break;
			}
			if(ds[i][self.opt.childrenField]!=null){
				_s(ds[i][self.opt.childrenField]);
			}
		}
	}
	return rtn;
};
Eht.BootTree.prototype.loadData=function(args){
	var self = this;
	this._loaddata = args;
	if($.isFunction(args)){
		args.call(this,this.resp);
	}
	if($.isArray(args)){
		self._createTreeview(args);
	}
};
Eht.BootTree.prototype.refresh=function(){
	if(this._loaddata){
		this._loaddata(this.resp);
	}
};
Eht.BootTree.prototype.clickItem=function(func){
	//func(data)
	this._clickItem=func;
};
Eht.BootTree.prototype.getSelectedData=function(){
	return this.selector.treeview('getSelected');
};

Eht.BootTree.prototype.getCheckedData=function(){
	return this.selector.treeview('getChecked');
};