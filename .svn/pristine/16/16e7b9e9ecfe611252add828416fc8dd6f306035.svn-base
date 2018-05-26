Eht.MapEngine=function(options){
	var engine = this;
	var defaults={
		paper:null,
		mousemove:function(evt,data){
		},
		mouseover:function(evt,data){
		},
		mouseout:function(evt,data){
		},
		click:function(evt,data){
		},
		dblclick:function(evt,data){},
		data:[{alias:"zh",qb:34,q1:23},{alias:"ch",qb:34,q1:23}],
		alias:"alias",
		click:function(e){}
	};
	this.options=$.extend(defaults,options);
	this.paper = this.options.paper;
	this.data = this.options.data;
	
	var ebuffer = new Object();
	
	if(this.paper!=null){
		this.paper.forEach(function(e){
			if(e.node.tagName=="path" || e.node.tagName=="shape"){
				var cdata = engine.getDataByAlias(e.id);
				if(cdata==null){
					return;
				}
				e.data = cdata;
				var alias = cdata[engine.options.alias];
				e.alias = alias;
				if(ebuffer[alias]==undefined){
					ebuffer[alias] = new Array();
					ebuffer[alias].push(e);
				}else{
					ebuffer[alias].push(e);
				}
    			e.mousemove(function(e){
    				engine.mousemove(e,cdata);
    			});
    			e.hover(function(e){
    				var r=engine.options.mouseover(e,cdata);
    				if(r==false){
    					return;
    				}
    				this.oldfill=this.attr("fill");
    				this.attr("fill","#efefef");
    				if(ebuffer[this.alias]){
    					for(var i=0;i<ebuffer[this.alias].length;i++){
    						ebuffer[this.alias][i].attr("fill","#efefef");
    					}
    				}
    			},function(e){
    				var r=engine.options.mouseout(e,cdata);
    				if(r==false){
    					return;
    				}
    				this.attr("fill",this.oldfill);
    				if(ebuffer[this.alias]){
    					for(var i=0;i<ebuffer[this.alias].length;i++){
    						ebuffer[this.alias][i].attr("fill",this.oldfill);
    					}
    				}
    			});
    			e.click(function(e){
    				engine.options.click(e,cdata);
    			});
    			e.dblclick(function(e){
    				engine.options.dblclick(e,cdata);
    			});
    		}
		});
	}
};
Eht.MapEngine.prototype.getDataByAlias=function(pathid){
	var rtn = null;
	pathid = pathid+"";
	for(var i=0;i<this.data.length;i++){
		if(this.data[i][this.options.alias]){
			if(pathid.search(this.data[i][this.options.alias])==0){
				rtn = this.data[i];
			}
		}
	}
	return rtn;
};
Eht.MapEngine.prototype.mousemove=function(evt,data){
	this.options.mousemove(evt,data);
};