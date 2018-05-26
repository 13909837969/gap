Eht.WindowManager=function(){
	this.windows = new Array();
	this.map=new Object();
	if(arguments && arguments.length > 0){
		for(var i=0;i<arguments.length;i++){
			this.add(arguments[i]);
		}
	}
};

Eht.WindowManager.prototype.add=function(window,unique){
	window.manager = true;
	window.windowManager = this;
	var wm = this;
	if(unique==true){
		if(this.map[window.getId()]==null){
			this.windows.push(window);
		}
		this.map[window.getId()]=window;
	}else{
		this.map[window.getId()]=window;
		this.windows.push(window);
	}
	window.active(function(){
		for(var i=0;i<wm.windows.length;i++){
			if(wm.windows[i].container){
				if(wm.windows[i].opt.modal==true){
					wm.windows[i].container.css("z-index",parseInt(wm.windows[i].modalDiv.css("z-index"))+300);
					wm.windows[i].container.removeClass("eht-window-back").addClass("eht-window-active");
					wm.windows[i].title.removeClass("eht-window-title-back").addClass("eht-window-title-active");
				}else{
					if(this==wm.windows[i]){
						wm.windows[i].container.css("zIndex",1000);
						wm.windows[i].container.removeClass("eht-window-back").addClass("eht-window-active");
						wm.windows[i].title.removeClass("eht-window-title-back").addClass("eht-window-title-active");
					}else{
						if(wm.windows[i].status == "max"){
							wm.windows[i].container.css("zIndex",550);
						}else{
							wm.windows[i].container.css("zIndex",500);
						}
						wm.windows[i].container.removeClass("eht-window-active").addClass("eht-window-back");
						wm.windows[i].title.removeClass("eht-window-title-active").addClass("eht-window-title-back");
					}
				}
			}
		}
	});
};

Eht.WindowManager.prototype.getWindowById=function(id){
	return this.map[id];
};

Eht.WindowManager.getParameter=function(){
	var rtnObj = null;
	var param = decodeURIComponent(window.location.search);
	if(param!="" && param.length>0){
		param = param.replace("?","");
		rtnObj = getParamObj(param);
	}
	
	function getParamObj(str){
		var r = null;
		var ps = str.split("&");
		for(var i=0;i<ps.length;i++){
			if(ps[i].search("param=")!=-1){
				var p = ps[i].replace("param=","").trim();
				try{
					r = eval("("+p+")");
					break;
				}catch(e){
					r = null;
				}
			}
		}
		return r;
	}
	return rtnObj;
};
Eht.WindowManager.getToken=function(){
	var rtn = null;
	var param = decodeURI(window.location.search);
	if(param!="" && param.length>0){
		param = param.replace("?","");
		rtn = _getToken(param);
	}
	
	function _getToken(str){
		var r = null;
		var ps = str.split("&");
		for(var i=0;i<ps.length;i++){
			if(ps[i].search("token=")!=-1){
				r = ps[i].replace("token=","").trim();
				break;
			}
		}
		return r;
	}
	return rtn;
};