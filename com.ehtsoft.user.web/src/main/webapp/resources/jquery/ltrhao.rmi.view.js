/**
 * @author wangbao
 */
Eht.View=function(opt){
	var form = this;
	var def = {
		selector:null,
		fieldname:"field",
		codeField:"code",
		codeValueField:"f_code",
		codeLabelField:"f_name", // 多字段用 “,” 分割 （select 已经实现，其他没有实现）
		defaultField:"def",
		defaultDisplay:""
	};
	this.opt = $.extend(def,opt);
	this.selector=$(this.opt.selector);
};
/**
 * attr:field,code
 */
Eht.View.prototype.fill=function(data){
	var opt = this.opt;
	this.selector.find("*[" + opt.fieldname + "]").each(function(){
		var field = $(this).attr(opt.fieldname);
		var code = $(this).attr(opt.codeField);
		var value = data[field];
		if(code!=null){
			var dc = Eht.DataCode[code.toLowerCase()];
			if(dc!=null){
				for(var i=0;i<dc.length;i++){
					if(dc[i].f_code == value){
						value = dc[i].f_name;
						break;
					}
				}
			}
		}
		if(value!= undefined ){
			$(this).html(value);
		}else{
			$(this).html(opt.defaultDisplay);
		}
	});
};