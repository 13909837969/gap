/**
 * 
 * @param opt
 * @returns {Eht.Alert}
 * @author wangbao
 */
Eht.Alert=function(opt){
	var art = this;
	var def = {
			   title:"信息提示",
			   message:"",
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
    "<input class='eht-alert-button' type='button' value='确认'/>"+
    "</div>"+
    "</div>"+
     "</div>");
	this.selector.find(".eht-alert-message").html(this.opt.message);
	this.selector.find(".eht-alert-message").css("padding",this.opt.padding  + "px");
    this.window = new Eht.Window({selector:this.selector,duration:150,
						title:this.opt.title,remove:true,resize:false,
						width:this.opt.width,height:this.opt.height,
						maxButton:false,modal:true});
    this.window.open();
    this.window.openComplete(function(){
    	this.selector.find(".eht-alert-message").css("height",(this.selector.height() - 32 - art.opt.padding*2)+"px");
    	//this.selector.find(".eht-alert-message").css("height",(this.selector.height() - 32)+"px");
    });
	this.selector.find(".eht-alert-button").click(function(){
		if(art._clickOk){
			art._clickOk();
		}
		art.window.close();
		$(document.body).css("overflow","");
	});
	this.selector.find(".eht-alert-button").focus();
};
Eht.Alert.prototype.clickOk=function(func){
	this._clickOk = func;
};