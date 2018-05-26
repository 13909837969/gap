/**
 * 表单操作类
 * @param opt
 * @returns {Eht.Form}
 * @author wangbao
 */
Eht.View=function(opt){
	var def = {
		selector:null,
		o2mObj:"parent",// 一对多的对象属性(该属性值为html 表单标签的自定义属性)
		o2mGroup:"group",// 一对多对象中的数据分组属性(该属性值为html 表单标签的自定义属性)
		clearHidden:false
	};
	this.opt = $.extend(def,opt);
	this.selector=$(this.opt.selector);
};
/**
 * 参数为 表单收入框中的name属性值或id值
 * 如果方法没有参数，调用该方法的时候，将全部清空所有的收入框
 * 如果有参数，并且为表单输入框中的name属性值或id值，最后一个参数不为 boolean 类型的 true
 * 则表示清空除了传递参数的输入框外的所有其他的输入框，如果，最后一个参数是boolean 类型的 true 值
 * 则表示清空传递参数中的输入框
 */
Eht.View.prototype.clear=function(){
	var args = arguments;
	var flag = false;
	if(args.length > 0){
		if($.type(args[args.length-1])=="boolean"){
			if(args[args.length-1]==true){
				flag = true;
			}
		}
	}
	this.selector.find("*[name]:not(input[type='button'],input[type='image'])").each(
		function(){
			if($(this).is("input") || $(this).is("textarea")){
				$(this).attr("readOnly",true);
			}
			if(flag==false){
				if(!isNoClear($(this).attr("name"),$(this).attr("id"))){
					if($(this).is("input") || $(this).is("textarea")){
						$(this).val("");
					}else{
						$(this).html("");
					}
				}
			}else{
				if(isNoClear($(this).attr("name"),$(this).attr("id"))){
					if($(this).is("input") || $(this).is("textarea")){
						$(this).val("");
					}else{
						$(this).html("");
					}
				}
			}
		}
	);
	function isNoClear(name,id){
		var rtn = false;
		for(var i=0;i<args.length;i++){
			if(name==args[i]||id==args[i]){
				rtn = true;
			}
		}
		return rtn;
	}
};
Eht.View.prototype.fill=function(dataObj){
	var view = this;
	var o2mObj = this.opt.o2mObj;
	var o2mGroup = this.opt.o2mGroup;
	this.clear();
	var data = new Object();
	for(p in dataObj){
		data[p]=dataObj[p];
	}
	if(data){
		for(var p in data){
			var element = this.selector.find("*[name='"+p+"']");
			if(element.size()>0){
				if(element.attr(o2mObj)==undefined){
					if(element.size()==1){
						view.setValue(element.attr("name"), data[p]);
					}
					if(element.size()>1){
						if($.type(data[p])=="array"){
							element.each(function(i){
								if($(this).is("input") || $(this).is("textarea")){
									// input element
									if(i<data[p].length){
										var d = data[p][i];
										$(this).val(d);
									}
								}else{
									if(i<data[p].length){
										var d = data[p][i];
										$(this).html(d);
									}
								}
							});
						}else{
							if(element.is("input") || element.is("textarea")){
								element.eq(0).val(data[p]);
							}else{
								element.eq(0).html(data[p]);
							}
						}
					}
				} 
			}
			//exist parent attr 
			var pe = this.selector.find("*[parent='"+p+"']");
			if(pe.size()>0){
				if($.type(data[p])=="array" && data[p].length > 0){
					if(pe.size()==1){
						pe.val(data[p][0][pe.attr("name")]);
					}else{
						var gtmp = new Object();
						var gtmparr = new Array();
						pe.each(function(i){
							var omgroup = $(this).attr(o2mGroup);
							var o2mo = $(this).attr(o2mObj);
							var omg = o2mo + omgroup;
							if(omgroup){// exist group attr
								
								if(gtmp[omg]!=undefined){
									gtmp[omg].push($(this));
								}else{
									var garr = new Array();
									garr.push($(this));
									gtmp[omg]=garr;
								}
							}else{
								gtmparr.push($(this));
								gtmp[$(this).attr(o2mObj)] = gtmparr;
							}
						});
						var k = 0;
						for(var gp in gtmp){
							if(k<data[p].length){
								var ni = 0;
								for(var n = 0;n<gtmp[gp].length;n++){
									var item = gtmp[gp][n];
									if($.type(data[p][k][item.attr("name")])=="array"){
										if(item.is("input") ||item.is("textarea")){
											if(ni<data[p][k][item.attr("name")].length){
												item.val(data[p][k][item.attr("name")][ni]);
												ni++;
											}
										}else{
											if(ni<data[p][k][item.attr("name")].length){
												item.html(data[p][k][item.attr("name")][ni]);
												ni++;
											}
										}
									}else{
										if(item.is("input") ||item.is("textarea")){
											item.val(data[p][k][item.attr("name")]);
										}else{
											item.html(data[p][k][item.attr("name")]);
										}
									}
								}
							}
							k++;
						}
					}
				}
			}
		}
	}
};
Eht.View.prototype.setValue=function(name,value){
	var element = this.selector.find("*[name='"+name+"'],*[id='"+name+"']");
	if(element.size()>0){
		if(element.size()==1){
			if(element.is("input") || element.is("textarea")){
				element.val(value);
			}else{
				element.html(value);
			}
		}else{
			element.each(function(){
				if($(this).is("input") || $(this).is("textarea")){
					$(this).val(value);
				}else{
					$(this).html(value);
				}
			});
		}
	}
};
