/**
 * @author wangbao
 */
Eht.Dialog=function(opt){
	var def = {
		selector:null,
		width:500,
		height:300
	}
	var dialog = this;
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.selector.width(0);
	this.selector.height(0);
	this.selector.css({left:$(window).width()/2,top:$(window).height()/2});
	this.selector.addClass("eht-dialog");
	
	this.closeBar = $("<span class='eht-dialog-close'></span>");
	this.closeBar.css({left:this.opt.width - 15});
	this.selector.append(this.closeBar);
	this.selector.hide();
	this.bgmodal = $('<div class="eht-window-modal"></div>');
	
	this.closeBar.click(function(){
		dialog.close();
	});
	$(window).resize(function(){
		dialog.resize();
	});
};
Eht.Dialog.prototype.open=function(func){
	var dialog = this;
	$(document.body).append(this.bgmodal);
	$(document.body).css("overflow","hidden");
	this.selector.show();
	this.selector.animate({left:($(window).width()-this.opt.width)/2,
						   top:($(window).height()-this.opt.height)/2,
						   width:this.opt.width,
						   height:this.opt.height},function(){
							   if(dialog._openComplete){
								   dialog._openComplete();
							   }else{
								   if(func){
									   func();
								   }
							   }
						   });
};
Eht.Dialog.prototype.openComplete=function(func){
	this._openComplete = func
};
Eht.Dialog.prototype.close=function(){
	this.bgmodal.remove();
	$(document.body).css("overflow","");
	this.selector.hide();
	this.selector.animate({left:$(window).width()/2,
		   top:$(window).height()/2,
		   width:0,
		   height:0});
};
Eht.Dialog.prototype.resize=function(){
	this.selector.css({left:($(window).width()-this.opt.width)/2,
		   top:($(window).height()-this.opt.height)/2});
}