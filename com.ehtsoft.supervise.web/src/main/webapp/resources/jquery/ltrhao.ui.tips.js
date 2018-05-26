Eht.Tips=function(opt){
	var def = {
		opacityDelay:500,
		topDelay:500,
		stopDelay:100,
		top:true,
		autoClose:true,
		css:{background:"#eee",border:"1px solid #aaa",padding:"5px"}
	};
	this.opt = $.extend(def,opt);
	this.selector =$("<div class='eht-base'></div>");
	this.selector.css({"position":"absolute","opacity":0,"display":"none","z-index":"8000"});
	this.selector.css(this.opt.css);
};
Eht.Tips.prototype.show=function(msg){
	var tips = this;
	$(document.body).append(tips.selector);
	if(msg==undefined){
		this.selector.html("操作成功");
	}else{
		this.selector.html(msg);
	}
	this.selector.show();
	this.selector.css({top:($(window).height()-this.selector.height())/2,left:($(window).width()-this.selector.width())/2});
	if(this.opt.autoClose){
		this.close();
	}else{
		this.selector.animate({"opacity":1},{duration:tips.opt.opacityDelay});
	}
};
Eht.Tips.prototype.close=function(){
	var tips = this;
	this.selector.animate({"opacity":1},{duration:tips.opt.opacityDelay,complete:function(){
		setTimeout(function(){
			if(tips.opt.top){
				tips.selector.animate({top:5},{duration:tips.opt.topDelay,complete:function(){
					tips.selector.remove();
				}});
			}else{
				tips.selector.animate({"opacity":0},{duration:tips.opt.opacityDelay,complete:function(){
					tips.selector.remove();
				}});
			}
		},tips.opt.stopDelay);
	}});
};