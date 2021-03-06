/**
 * bootstrap Alert 封装 （Dialog）
 * @author wangbao
 */
Eht.Alert=function(opt){
	var self = this;
	var def = {
		title:"系统错误提示",
		labelBtn1:"关闭",
		labelBtn2:"", //有内容的时候显示按键
		labelBtn3:"", //有内容的时候显示按键
		message:"",
		panelId:"_ltrhao_bootstrip_dialog_alert_panel"
	}
	this.opt = $.extend(def,opt);
	if($("#"+this.opt.panelId).size()==0){
		this.alertPanel = $('<div id="'+this.opt.panelId+'" class="modal fade" tabindex="-1">'
				  + '<div class="modal-dialog" style="width:360px;" role="document">'
				  + '  <div class="modal-content">'
				  + '    <div class="modal-header" style="padding:8px;">'
				  + '      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>'
				  + '     <h4 class="modal-title" id="_mySmallModalLabel">'+this.opt.title+'</h4>'
				  + '   </div>'
				  + '   <div class="modal-body" style="max-height: 100px;overflow:auto;">'
				  +  this.opt.message
				  + '    </div>'
				  + '   <div class="modal-footer" style="padding:8px;">'
				  + (this.opt.labelBtn1==''?'':'<button id="_dialog_alert_btn1" type="button" class="btn btn-default btn-sm" data-dismiss="modal">'+this.opt.labelBtn1+'</button>')
				  + (this.opt.labelBtn2==''?'':'<button id="_dialog_alert_btn2" type="button" class="btn btn-default btn-sm">'+this.opt.labelBtn2+'</button>')
				  + (this.opt.labelBtn3==''?'':'<button id="_dialog_alert_btn3" type="button" class="btn btn-default btn-sm">'+this.opt.labelBtn3+'</button>')
				  + '   </div>'
				  + ' </div>'
				  + '</div>'
				  + '</div>');
		$(document.body).append(this.alertPanel);
		this.alertPanel.find("#_dialog_alert_btn1").click(function(){
			if(self._onClickBtn1!=null){
				self._onClickBtn1.call(self);
			}
		});
		this.alertPanel.find("#_dialog_alert_btn2").click(function(){
			if(self._onClickBtn2!=null){
				self._onClickBtn2.call(self);
			}
		});
		this.alertPanel.find("#_dialog_alert_btn3").click(function(){
			if(self._onClickBtn3!=null){
				self._onClickBtn3.call(self);
			}
		});
	}
};
Eht.Alert.prototype.show=function(message){
	if(message!=null){
		$("#"+this.opt.panelId).find(".modal-body").html(message);
	}
	$("#"+this.opt.panelId).modal({backdrop:'static'});
	var mdialg = $("#"+this.opt.panelId).find(".modal-dialog");
	var top = ($(window).height())/3;
	mdialg.css("margin-top",top);
};
Eht.Alert.prototype.showNotSelected=function(){
	this.show("请选择一条数据进行操作.");
};
Eht.Alert.prototype.close=function(){
	$("#"+this.opt.panelId).modal("hide");
};
Eht.Alert.prototype.onClickBtn1=function(func){
	this._onClickBtn1 = func;
};
Eht.Alert.prototype.onClickBtn2=function(func){
	this._onClickBtn2 = func;
};
Eht.Alert.prototype.onClickBtn3=function(func){
	this._onClickBtn3 = func;
};
/**
 * 确认提示
 */
Eht.Confirm=function(opt){
	var self = this;
	var def = {
		title:"信息提醒",
		labelBtn1:"",
		labelBtn2:"确认", //有内容的时候显示按键
		labelBtn3:"取消", //有内容的时候显示按键
		message:"",
		panelId:"_ltrhao_bootstrip_dialog_confirm_panel"
	}
	this.opt = $.extend(def,opt);
	this.alert = new Eht.Alert(this.opt);
	this.alert.onClickBtn3(function(){
		this.close();
	});
};
Eht.Confirm.prototype.show=function(message){
	this.alert.show(message);
};
Eht.Confirm.prototype.showDelete=function(message){
	this.alert.show("此操作不可恢复，确定要删除选中记录吗?");
};
Eht.Confirm.prototype.onOk=function(func){
	this.alert.onClickBtn2(func);
};
Eht.Confirm.prototype.onCancel=function(func){
	this.alert.onClickBtn3(func);
};
Eht.Confirm.prototype.close=function(){
	this.alert.close();
};