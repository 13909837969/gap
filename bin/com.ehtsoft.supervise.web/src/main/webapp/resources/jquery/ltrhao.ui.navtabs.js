/**
 * @author wangbao
 */
Eht.NavTabs=function(opt){
	var self = this;
	var def = {
		selector:null,
		target:"#main-article-content",
		labelField:"menuname",
		pkField:"sysid"
	};
	this.opt = $.extend(def,opt);
	this.selector=$(this.opt.selector);
	this.targetPanel = $(this.opt.target);
	this.navtab = $("<ul class='ltrhao_nav_tabs'></ul>");
	this.selector.append(this.navtab);
};
Eht.NavTabs.prototype.addTab=function(data,url,option){
	var self = this;
	this.navtab.children("li").removeClass("active");
	this.targetPanel.children("div,iframe").hide();
	var tmp = this.navtab.find("#" + "tab_"+data[this.opt.pkField]);
	if(tmp.size()==0){
		var item = $('<li>' + 
		  	 		'<a href="#"><span>'+data[this.opt.labelField]+'&nbsp;</span>'+
		  	 		'<span id="navtabClose" class="glyphicon glyphicon-remove"></span>'+
		  	 		'</a>' +
			 	    '</li>');
		item.data(data);
		item.attr("id","tab_"+data[this.opt.pkField]);
		item.addClass("active");
		this.navtab.append(item);
		item.click(function(){
			if(self._clickItem){
				self._clickItem.call(self,data);
			}
			self.navtab.children("li").removeClass("active");
			self.targetPanel.children("div,iframe").hide();
			$(this).addClass("active");
			$("#tabcnt_"+$(this).data()[self.opt.pkField]).show();
		});
		item.find("#navtabClose").click(function(){
			alert("close");
		});
		if(option!=null){
			if(option.frame){
				var tabcnt = $("<iframe id='tabcnt_"+data[this.opt.pkField]+"' style='width:100%;height:100%;' frameborder=0></iframe>");
				tabcnt.attr("src",url);
	    		this.targetPanel.append(tabcnt);
	    		tabcnt.show();
			}else{
				var tabcnt = $("<div id='tabcnt_"+data[this.opt.pkField]+"'></div>");
	    		this.targetPanel.append(tabcnt);
	    		tabcnt.show();
				tabcnt.load(url);
			}
		}else{
			var tabcnt = $("<div id='tabcnt_"+data[this.opt.pkField]+"'></div>");
    		this.targetPanel.append(tabcnt);
    		tabcnt.show();
			tabcnt.load(url);
		}
	}else{
		tmp.addClass("active");
		$("#tabcnt_"+data[self.opt.pkField]).show();
	}
};
Eht.NavTabs.prototype.clickItem=function(func){
	//func(data)
	this._clickItem = func;
}