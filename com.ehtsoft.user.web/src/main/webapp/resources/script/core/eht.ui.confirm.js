/**
 * 
 * @param opt
 * @returns {Eht.Alert}
 * @author wangbao
 */
Eht.Confirm=function(opt){
	var art = this;
	var def = {
			   title:"确认提示",
			   message:"",
			   enterLabel:"确认",
			   cancelLabel:"取消",
			   width:300,
			   height:150,
			   padding:20
			  };
	this.opt = $.extend(def,opt);
	if($.type(opt)=="string"){
		this.opt.message = opt;
	}
	this.selector = $("<div>"+
						"<div class='eht-alert-message'></div>"+
					    "<div class='eht-alert-footer'>"+
						    "<div>" +
							    "<input class='eht-alert-okbtn' type='button' value='"+this.opt.enterLabel+"'/>&nbsp;&nbsp;&nbsp;"+
							    "<input class='eht-alert-nobtn' type='button' value='"+this.opt.cancelLabel+"'/>"+
						    "</div>"+
					    "</div>"+
     				"</div>");
	this.selector.find(".eht-alert-message").html(this.opt.message);
	this.selector.find(".eht-alert-message").css("padding",this.opt.padding+"px");
    this.window = new Eht.Window({selector:this.selector,duration:150,
						title:this.opt.title,remove:true,resize:false,
						width:this.opt.width,height:this.opt.height,
						maxButton:false,modal:true});
    this.window.open();
    this.window.openComplete(function(){
    	art.selector.find(".eht-alert-message").height(this.selector.height() - 32 - art.opt.padding*2);
    });
	this.selector.find(".eht-alert-okbtn").click(function(){
		if(art._clickOk){
			art._clickOk();
		}
		art.window.close();
	});
	this.selector.find(".eht-alert-nobtn").click(function(){
		if(art._clickNo){
			art._clickNo();
		}
		art.window.close();
	});
	this.selector.find(".eht-alert-okbtn").focus();
};
Eht.Confirm.prototype.clickOk=function(func){
	this._clickOk = func;
};
Eht.Confirm.prototype.clickNo=function(func){
	this._clickNo = func;
};