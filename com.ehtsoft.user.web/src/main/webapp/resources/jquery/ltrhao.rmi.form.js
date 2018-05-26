/**
 * 表单
 */
Eht.Form=function(opt){
	var def = {
		selector:null,
		defaultDisplay:"",
		autolayout:false,
		placeholder:true,
		codeField:"code",
		codeValueField:"f_code",
		codeLabelField:"f_name",  // 多字段用 “,” 分割 （select 已经实现，其他没有实现）
		childrenNodeField:"children",
		formCol:1,
		colLabel:"col-sm-2",
		colCombo:"col-sm-10",
		smallForm:false
	}
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.data = {};

	if(this.opt.autolayout){
		this.init();
	}
};
Eht.Form.prototype.init=function(){
	var self = this;
	this.selector.addClass("form-horizontal row");
	var combos = [];
	this.selector.children().each(function(){
		combos.push($(this));
	});
	//将对象 android bootstrap 布局及添加样式
	for(var i=0;i<combos.length;i++){
		if(combos[i].is("input") || combos[i].is("textarea") || combos[i].is("select")){
			var formGroup = $('<div class="form-group">'
								+'<label class="ltrhao-form-label control-label"></label>'
								+'<div class="ltrhao-form-control">'
								+'</div>'
							+'</div>');
			if(this.opt.smallForm==true){
				formGroup.addClass("form-group-sm");
			}
			//glyphicon-ok form-control-feedback
			//<input type="text" class="form-control" placeholder="xxxx"/>
			var validSpan = $('<span class="glyphicon"></span>');
			this.selector.append(formGroup);
			formGroup.addClass("col-sm-" + (12/self.opt.formCol));
			var label = formGroup.find(".ltrhao-form-label");
			var fmgrop = formGroup.find(".ltrhao-form-control");
			if(self.opt.formCol>1){
				label.addClass("col-sm-4");
				fmgrop.addClass("col-sm-8");
			}else{
				label.addClass(this.opt.colLabel);
				fmgrop.addClass(this.opt.colCombo);
			}
			var comboId = "form_" + combos[i].attr("name") + "_" + i;
			if(combos[i].attr("id")!=null){
				comboId = combos[i].attr("id");
			}
			label.html(combos[i].attr("label"));
			label.attr("for",comboId);
			fmgrop.append(combos[i]);
			fmgrop.append(validSpan);
			var help=$('<span id="help_'+comboId+'" class="help-block"></span>');
			fmgrop.append(help);
			help.hide();
			validSpan.attr("fromcontrol",comboId);
			var code = combos[i].attr(self.opt.codeField);
			if(code!=null){
				code = code.toLowerCase().trim();
				var sel = $("<select></select>");
				sel.attr("name",combos[i].attr("name"));
				sel.attr("label",combos[i].attr("label"));
				if(Eht.DataCode[code]!=null){
					for(var c=0;c<Eht.DataCode[code].length;c++){
						var dc = Eht.DataCode[code][c];
						var children = dc[self.opt.childrenNodeField];
						if(children!=null){
							var optgroup = $("<optgroup></optgroup>");
							optgroup.attr("label",dc[self.opt.codeLabelField]);
							for(var cc=0;cc<children.length;cc++){
								var dcc = children[cc];
								var opt = "<option value='"+dcc[self.opt.codeValueField]+"'>"+dcc[self.opt.codeLabelField]+"</option>";
								optgroup.append(opt);
							}
							sel.append(optgroup);
						}else{
							var opt = "<option value='"+dc[self.opt.codeValueField]+"'>"+dc[self.opt.codeLabelField]+"</option>";
							sel.append(opt);
						}
					}
				}
				combos[i].replaceWith(sel);
				combos[i] = sel;
			}
			combos[i].attr("id",comboId);
			combos[i].attr("tabindex",i+1);
			combos[i].attr("id",comboId);
			combos[i].addClass("form-control");
			
			if(self._codeCombo!=null){
				if(Eht.DataCode[code]!=null){
					zdyCodeCombo = self._codeCombo.call(self,combos[i].attr("name"),combos[i],Eht.DataCode[code]);
				}
			}
			
			combos[i].change(function(){
				if(self._change!=null){
					var pfg = self.getParentFormGroup($(this));
					self._change.call(self,$(this).attr("name"),$(this).val(),$(this),pfg);
				}
				if (self.validateItem($(this))) {
					var a = combos[$(this).attr("tabindex")-0];
					if(a!=null){
						a.focus();
					}
				}
			});
			combos[i].blur(function(){
				if(self._blur!=null){
					var pfg = self.getParentFormGroup($(this));
					self._blur.call(self,$(this).attr("name"),$(this).val(),$(this),pfg);
				}
				self.validateItem($(this));
			});
			combos[i].keyup(function(){
				self.validateItem($(this));
			});
			if(this.opt.placeholder){
				combos[i].attr("placeholder",combos[i].attr("label"));
			}
		}else{
			this.selector.append(combos[i]);
		}
	}
	
	this.getParentFormGroup=function(combo){
		if(combo.parent().hasClass("form-group")){
			return combo.parent();
		}else{
			return self.getParentFormGroup(combo.parent());
		}
	}
};
Eht.Form.prototype.validateItem = function(combo){
	var self = this;
	var rtn = true;	
	var val = combo.val();
	if(val==null){
		val="";
	}
	var validstr = combo.attr("valid");
	var validObj = {};
	try{
		validObj = eval("(" + validstr + ")");
	}catch(e){
		console.log(e.message);
	}
	if(validObj==null){
		validObj = {};
	}
	var _r = true;
	//非空验证 required 验证
	if (validObj.required==true) {
		if(combo.val()==null || combo.val().trim()==""){
			rtn = false;
			_r = false;
		}else{
			_r = true;
		}
	}else{
		validObj.required=false;
	}
	var helpText = "";
	var lbltxt = combo.attr("label");
	if(lbltxt==null){
		lbltxt = "";
	}
	if(val.trim()!="" || validObj.required){ //必填的时候，需要验证
		//日期验证
		if(validObj.date==true){
			rtn = rtn & Eht.Utils.isDate(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确，日期格式为：yyyy-mm-dd";
			}
		}
		//日期时间验证
		if(validObj.datetime==true){
			rtn = rtn & Eht.Utils.isDatetime(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确，时间格式为：yyyy-MM-dd HH:mm:ss";
			}
		}
		//数字验证
		if(validObj.number==true){
			rtn = rtn & Eht.Utils.isNumber(val);
			if(rtn==false){
				helpText = lbltxt + "数据必须为数字";
			}
		}
		//整数验证
		if(validObj.int==true){
			rtn = rtn & Eht.Utils.isInt(val);
			if(rtn==false){
				helpText = lbltxt + "数据必须为整数";
			}
		}
		//浮点类型
		if(validObj.float==true){
			rtn = rtn & Eht.Utils.isFloat(val);
			if(rtn==false){
				helpText = lbltxt + "数据必须为小数（浮点数据）";
			}
		}
		//Email 验证
		if(validObj.email==true){
			rtn = rtn & Eht.Utils.isEmail(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式为Email格式，数据格式：xxxx@xxx.com";
			}
		}
		//手机号码验证
		if(validObj.mobile==true){
			rtn = rtn & Eht.Utils.isMobile(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确";
			}
		}
		//身份证强制验证
		if(validObj.cardNo==true){
			rtn = rtn & Eht.Utils.isPersonCard(val);
			if(rtn==false){
				helpText = lbltxt + "数据不正确，身份证号码必须为争取的";
			}
		}
		//存的汉字验证
		if(validObj.onlyChinese==true){
			rtn = rtn & Eht.Utils.isOnlyChinese(val);
			if(rtn==false){
				helpText = lbltxt + "必须为汉字";
			}
		}
		//是否存在汉字验证
		if(validObj.hasChinese==true){
			rtn = rtn & Eht.Utils.isHasChinese(val);
			if(rtn==false){
				helpText = lbltxt + "必须包含汉字";
			}
		}
		if(_r==false){
			helpText = lbltxt + "不能为空";
		}
	}
	//自定义验证，事件方法为 customValid(name,value,combo,parent);
	if(this._customValid!=null){
		rtn = self._customValid.call(self,combo.attr("name"),combo.val(),combo,pfg);
	}
	var pfg = this.getParentFormGroup(combo);
	if (rtn) {
		if(!combo.is("select")){
			pfg.removeClass("has-error")
			   .removeClass("has-success");
			pfg.find("span[fromcontrol=" + combo.attr("id") + "]")
			   .removeClass("glyphicon-remove")
			   .removeClass("glyphicon-ok")
			   .removeClass("form-control-feedback");
			pfg.find("#help_" + combo.attr("id")).hide();
			//验证成功，并且不是必填项同时 内容 不为空的时候，添加成功颜色
			if ((validObj.required==null || validObj.required==false) && combo.val().trim()!="" || validObj.required==true){
				//通过验证
				pfg.addClass("has-success has-feedback");
				pfg.find("span[fromcontrol=" + combo.attr("id") + "]")
					.addClass("glyphicon-ok form-control-feedback");
			}
		}
	}else{
		//验证不通过的时候
		pfg.removeClass("has-success")
		   .removeClass("has-error");
		pfg.find("span[fromcontrol=" + combo.attr("id") + "]")
		   .removeClass("glyphicon-remove")
		   .removeClass("glyphicon-ok")
		   .removeClass("form-control-feedback");

		pfg.addClass("has-error has-feedback");
		pfg.find("span[fromcontrol=" + combo.attr("id") + "]")
			.addClass("glyphicon-remove form-control-feedback");
		pfg.find("#help_" + combo.attr("id")).html(helpText).show();
	}
	return rtn;
};
/**
* 验证属性
* valid="{required:true,number:true,date:true,email:true,cardNo:true,tel:true}"
* required:true    不能为空
* date : true      日期格式验证 yyyy-MM-dd
* datetime : true  日期格式验证 yyyy-MM-dd HH:mm | yyyy-MM-dd HH:mm:ss
* number:true      数字验证
* int:true         整数验证
* float : true     浮点类型验证
* email: true      email
* cardNo:true      身份证号码强制验证
* mobile: true     手机号码验证
* onlyChinese : true 存汉字的验证
* hasChinese : true  是否存在汉字验证
*/
Eht.Form.prototype.validate=function(){
	var self = this;
	var rtn = true;
	var ds = this.getData();
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		var r = self.validateItem($(this));
		rtn = rtn && r;
	});
	return rtn;
};
Eht.Form.prototype.getData=function(){
	var rtn = {};
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		var name = new String($(this).attr("name")).toLowerCase();
		var type = new String($(this).attr("type")).toLowerCase();
		if(type != "radio" && type != "checkbox"){
		    rtn[name] = $(this).val();
		}else{
		  if(this.checked){
			  if(type == "radio"){
				  rtn[name] = $(this).val();
			  }
			  if(type == "checkbox"){
				  var arr = rtn[name];
				  if(arr==null){
					  arr=new Array();
					  arr.push($(this).val());
					  rtn[name] = arr;
				  }else{
					  rtn[name].push($(this).val());
				  }
			  }
		  }
		  if($(this).attr("else")!=null){
			  if(this.checked){
				  rtn[name] = $(this).val();
			  }else{
				  rtn[name] = $(this).attr("else");
			  }
		  }
		}
	});
	for(var p in rtn){
		if($.isArray(rtn[p])){
			rtn[p] = rtn[p].join(",");
		}
	}
	for(var p in this.data){
		if(rtn[p]==null){
			rtn[p] = this.data[p];
		}
	}
	return rtn;
};
Eht.Form.prototype.fill=function(arg){
	var self = this;
	if(arg!=null){
		for(var p in arg){
			this.data[p] = arg[p];
		}
	}
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		var name = new String($(this).attr("name")).toLowerCase();
		var type = new String($(this).attr("type")).toLowerCase();
		if(type != "radio" && type != "checkbox"){
			if(self.data[name]==null){
				$(this).val(self.opt.defaultDisplay);
			}else{
				$(this).val(self.data[name]);
			}
		}else{
			if(type == "radio"){
				if($(this).val() == self.data[name]){
					this.checked = true;
				}else{
					this.checked = false;
				}
			}
			if(type == "checkbox"){
				var v = self.data[name];
				if(v==null){
					this.checked = false;
				}else{
					var vs = v.split(",");
					self.selector.find("input[type='checkbox'][name='"+name+"']").each(function(){
						this.checked = false;
						for(var i=0;i<vs.length;i++){
							if($(this).val()==vs[i]){
								this.checked = true;
							}
						}
					});
				}
			}
		}
	});
};
Eht.Form.prototype.clear=function(cleardata){
	if(cleardata==true){
		for(p in this.data){
			delete this.data[p];
		}
	}
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		var type = $(this).attr("type");
		if(type != "radio" && type != "checkbox"){
			$(this).val("");
		}else{
			this.checked = false;
		}
	});
	this.selector.find(".has-success,.has-error,.glyphicon-remove,.glyphicon-ok,.form-control-feedback")
	   .removeClass("has-success")
	   .removeClass("has-error")
	   .removeClass("glyphicon-remove")
	   .removeClass("glyphicon-ok")
	   .removeClass("form-control-feedback");	
	this.selector.find(".help-block").hide();
};
Eht.Form.prototype.change=function(func){
	//func(name,value,combo,parent)
	this._change = func;
};
Eht.Form.prototype.blur=function(func){
	//func(name,value,combo,parent)
	this._blur = func;
}
Eht.Form.prototype.codeCombo=function(func){
	//func(name,thisCombo,codeData) 
	//return boolean true 自定义的 codeCombo false or void 默认框架生成的
	this._codeCombo = func;
}
Eht.Form.prototype.customValid=function(func){
	//func(name,value,combo,parent) 函数返回：boolean true 成功  false  失败
	this._customValid = func;
};
