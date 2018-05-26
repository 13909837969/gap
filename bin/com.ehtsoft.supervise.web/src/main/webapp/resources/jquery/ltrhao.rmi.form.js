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
		colLabel:"col-sm-2 col-xs-2",
		colCombo:"col-sm-10 col-xs-10",
		smallForm:false,
		codeEmpty:true,
		codeEmptyLabel:""
	}
	this.opt = $.extend(def,opt);
	this.selector = $(this.opt.selector);
	this.data = {};
	this.attrs = ["name","id","code","style","class","valid","label","data-placement"];
	this.init(this.opt.autolayout);
};
/**
 * 注：
 * 1.标记 code 的组件为字典数据组件，自动形成选项,主子关系自动形成 <optgroup>
 * 2.标记 valid 属性组件为数据验证，具体见验证方法
 * 3.noChild = true 表示，字典数据取消子数据关系
 * 4.mult = true 表示多选，默认采用 checkbox
 * 5.radio = true 默认采用 radio
 * 6.getdis = true 表示 disabled 的组件可以获取数据
 */
Eht.Form.prototype.init=function(layout){
	var self = this;
	if(layout){
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
				var label = formGroup.find(".ltrhao-form-label");
				var fmgrop = formGroup.find(".ltrhao-form-control");
				if(self.opt.formCol>1){
					if(combos[i].attr("labelCol")==null){
						label.addClass("col-sm-4 col-xs-3");
						fmgrop.addClass("col-sm-8 col-xs-9");
					}
				}else{
					if(combos[i].attr("labelCol")==null){
						label.addClass(this.opt.colLabel);
						fmgrop.addClass(this.opt.colCombo);
					}
				}
				if(combos[i].attr("col")==null){ // input 添加自定义属性 col，用于真对 bootstrap 列的布局 
					formGroup.addClass("col-sm-" + (12/self.opt.formCol));
					formGroup.addClass("col-xs-12");
				}else{
					formGroup.addClass("col-sm-" + combos[i].attr("col"));
					formGroup.addClass("col-xs-12");
				}
				if(combos[i].attr("xscol")==null){ // input 添加自定义属性 col，用于真对 bootstrap 列的布局 
					formGroup.addClass("col-xs-12");
				}else{
					formGroup.addClass("col-xs-" + combos[i].attr("xscol"));
				}
				if(combos[i].attr("labelCol")!=null){
					var lblcol = parseInt(combos[i].attr("labelCol"));
					label.addClass("col-sm-" + lblcol);
					label.addClass("col-xs-" + lblcol);
					fmgrop.addClass("col-sm-" + (12-lblcol));
					fmgrop.addClass("col-xs-" + (12-lblcol));
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
					var mult = combos[i].attr("mult");
					if(mult=="true"){ //多选
						var chkgroup = $("<div></div>");
						for(var c=0;c<Eht.DataCode[code].length;c++){
							var dc = Eht.DataCode[code][c];
							var nm = combos[i].attr("name");
							var checkitem = $("<div class='col-sm-3'><input id='"+nm+c+"' name="+nm+" type='checkbox' value='"+dc[self.opt.codeValueField]+"'/><label style='margin-left:4px;font-weight: normal;' for='"+nm+c+"'>"+dc[self.opt.codeLabelField]+"</label></div>");
							if(dc.f_def==1){
								checkitem.find("input").attr("checked",true);
							}
							chkgroup.append(checkitem);
						}
						combos[i].replaceWith(chkgroup);
					}else{
						var sel = $("<select></select>");
						if(combos[i].attr("getdis")!=null){
							sel.attr("getdis",combos[i].attr("getdis"));
						}
						for(var ar=0;ar<self.attrs.length;ar++){
							sel.attr(self.attrs[ar],combos[i].attr(self.attrs[ar]));
						}
						if(Eht.DataCode[code]!=null){
							var nochild = combos[i].attr("noChild");
							if(nochild == null){
								nochild = "false";
							}
							for(var c=0;c<Eht.DataCode[code].length;c++){
								var dc = Eht.DataCode[code][c];
								var children = dc[self.opt.childrenNodeField];
								if(children!=null && nochild=="false"){
									var optgroup = $("<optgroup></optgroup>");
									optgroup.attr("label",dc[self.opt.codeLabelField]);
									for(var cc=0;cc<children.length;cc++){
										var dcc = children[cc];
										var opt = "<option value='"+dcc[self.opt.codeValueField]+"'>"+dcc[self.opt.codeLabelField]+"</option>";
										if(dcc.f_def==1){
											opt.attr("selected",true);
										}
										optgroup.append(opt);
									}
									sel.append(optgroup);
								}else{
									var opt = $("<option value='"+dc[self.opt.codeValueField]+"'>"+dc[self.opt.codeLabelField]+"</option>");
									if(dc.f_def==1){
										opt.attr("selected",true);
									}
									sel.append(opt);
								}
							}
						}
						combos[i].replaceWith(sel);
						combos[i] = sel;
					}
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
					var mx = $(this).attr("maxlength");
					if(mx!=null){
						if(self._charValid!=null){
							mx = parseInt(mx);
							var mi = $(this).val().length;
							self._charValid($(this).attr("name"),mi,mx);
						}
					}
				});
				if(this.opt.placeholder){
					combos[i].attr("placeholder",combos[i].attr("label"));
				}
			}else{
				this.selector.append(combos[i]);
			}
		}
	}else{
		//非自动布局时
		this.selector.find("input[name],textarea[name],select[name]").each(function(){
			var code = $(this).attr("code");
			if($(this).attr("valid")!=null){
				$(this).attr("data-placement","right");
			}
			if(code!=null){
				//具备字典的数据
				code = code.toLowerCase();
				if($(this).attr("mult")=="true" || $(this).attr("radio")=="true"){
					var t = "checkbox";
					if($(this).attr("radio")=="true"){
						t = "radio";
					}
					var mg = $("<div></div>");
					if($(this).attr("valid")!=null){
						mg.attr("valid",$(this).attr("valid"));
						mg.attr("data-placement",$(this).attr("data-placement"));
						var mt = $(this).attr("radio")=="true"?"false":"true";
						mg.attr("multable",mt);
					}
					$(this).replaceWith(mg);
					for(var c=0;c<Eht.DataCode[code].length;c++){
						var v = Eht.DataCode[code][c][self.opt.codeValueField];
						var l = Eht.DataCode[code][c][self.opt.codeLabelField];
						var cb = $("<input type='"+t+"' value='"+v+"'>");
						cb.attr("label",l);
						mg.append(cb);
						mg.append("<label style='padding-left:5px;padding-right:15px;'>"+l+"</label>");
						for(var i=0;i<self.attrs.length;i++){
							var at = $(this).attr(self.attrs[i]);
							if(at!=null){
								if("valid"!=self.attrs[i] && "data-placement"!=self.attrs[i]){
									cb.attr(self.attrs[i],at);
								}
							}
						}
						cb.click(function(){
							self.validateItem($(this).parent(),true);
							if(self._change){
								var vs = [];
								$(this).parent().find("input[name='"+$(this).attr("name")+"']").each(function(){
									if($(this).attr("type")=="checkbox"){
										if(this.checked){
											vs.push($(this).val());
										}
									}
									if($(this).attr("type")=="radio"){
										if(this.checked){
											vs.push($(this).val());
										}
									}
								});
								//name,value,combo,parent
								self._change($(this).attr("name"),vs.join(","),$(this),$(this).parent());
							}
						});
					}
				}else{
					var ce = self.opt.codeEmpty;
					var sel = $("<select></select>");
					if(ce==true){
						sel.append("<option value=''>"+self.opt.codeEmptyLabel+"</option>");
					}
					for(var i=0;i<self.attrs.length;i++){
						var at = $(this).attr(self.attrs[i]);
						if(at!=null){
							sel.attr(self.attrs[i],at);
						}
					}
					for(var c=0;c<Eht.DataCode[code].length;c++){
						var v = Eht.DataCode[code][c][self.opt.codeValueField];
						var l = Eht.DataCode[code][c][self.opt.codeLabelField];
						sel.append("<option value='"+v+"'>"+l+"</option>");
					}
					$(this).replaceWith(sel);
					sel.change(function(){
						self.validateItem($(this));
						if(self._change){
							//name,value,combo,parent
							self._change(sel.attr("name"),sel.val(),sel,sel.parent());
						}
					});
				}
			}else{
				//不具备字典的数据
				$(this).change(function(){
					self.validateItem($(this));
					if(self._change){
						//func(name,value,combo,parent)
						self._change($(this).attr("name"),$(this).val(),$(this),$(this).parent());
					}
				});
				$(this).keyup(function(){
					self.validateItem($(this));
				});
				$(this).blur(function(){
					self.validateItem($(this));
				});
			}
		});
	}
};
Eht.Form.prototype.tiggerChange=function(){
	var self = this;
	this.selector.find("input[name]:not(:disabled),textarea[name]:not(:disabled),select[name]:not(:disabled)").each(function(){
		//var pfg = self.getParentFormGroup($(this));
		self._change.call(self,$(this).attr("name"),$(this).val(),$(this));//,pfg);
	});
};
Eht.Form.prototype.getParentFormGroup=function(combo){
	var self = this;
	if(combo.parent().hasClass("form-group")){
		return combo.parent();
	}else{
		return self.getParentFormGroup(combo.parent());
	}
};
Eht.Form.prototype.validateItem = function(combo,checkFlag){
	var autolayout = this.opt.autolayout;
	if(checkFlag==null || checkFlag == undefined){
		checkFlag = false;
	}
	var self = this;
	var rtn = true;	
	var val = combo.val();
	if(checkFlag){
		if(combo.attr("multable")=="true"){ //多选
			var vvs=[];
			combo.find("input[type='checkbox']:checked").each(function(){
				vvs.push($(this).val());
			});
			val = vvs.join(",");
		}else{
			var r = combo.find("input[type='radio']:checked");
			if(r.size()>0){
				val = r.val();
			}else{
				val = null;
			}
		}
	}
	if(val==null){
		val="";
	}
	var validstr = combo.attr("valid");
	if(validstr==null){
		return true;
	}
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
		if(val==null || val.trim()==""){
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
		//传真验证
		if(validObj.faxtell==true){
			rtn = rtn & Eht.Utils.isFaxTell(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确，传真号码格式为：0000-00000000";
			}
		}
		//英文字母验证
		if(validObj.ENname==true){
			rtn = rtn & Eht.Utils.isEnglishName(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确，请输入英文字母！";
			}
		}
		//日期时间验证
		if(validObj.datetime==true){
			rtn = rtn & Eht.Utils.isDatetime(val);
			if(rtn==false){
				helpText = lbltxt + "数据格式不正确，时间格式为：yyyy-MM-dd HH:mm:ss";
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
				helpText = lbltxt + "数据不正确，身份证号码必须为正确的";
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
		rtn = self._customValid.call(self,combo.attr("name"),val,combo);
	}
	if(autolayout){
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
				if ((validObj.required==null || validObj.required==false) && val.trim()!="" || validObj.required==true){
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
	}else{
		//非自动布局的验证方法
		if (rtn) {
			combo.css("border","");
			combo.tooltip('destroy');
		}else{
			//combo.tooltip('destroy');
			//combo.attr("title",helpText);
			combo.attr("data-original-title",helpText);
			combo.css("border","1px solid #f00");
			combo.tooltip("show");
		}
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
	this.selector.find("input[valid]:not(:disabled,input[type='radio'],input[type='checkbox']),textarea[valid]:not(:disabled),select[valid]:not(:disabled)").each(function(){
		var r = self.validateItem($(this));
		rtn = rtn && r;
	});
	this.selector.find("[multable]").each(function(){
		var r = self.validateItem($(this),true);
		rtn = rtn && r;
	});
	return rtn;
};
/**
 * checkbox else
 * 注：
 * 1.disabled 的组件数据不能获取
 * 2.checkbox 多选，获取的数据用 “,” 分隔
 * 3.单一checkbox 取消选择的数据，放到 else 自定义属性中
 */
Eht.Form.prototype.getData=function(){
	var rtn = {};
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		var disable = $(this).attr("disabled");
		var getdis = $(this).attr("getdis");
		if(getdis==null){
			getdis = false;
		}else{
			getdis = true;
		}
		if(disable==null){
			disable = false;
		}else{
			disable = true;
		}
		if(disable == false || getdis==true){
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
/**
 * 注:
 * 属性标记为 fixedValue 的组件，不能 fill 值，该组件为固定值
 */
Eht.Form.prototype.fill=function(arg,triggerChange){
	var self = this;
	if(arg!=null){
		this.clear(true);
		for(var p in arg){
			this.data[p] = arg[p];
		}
	}
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		if($(this).attr("fixedValue")!="true"){
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
			if(triggerChange==true){
				if(self._change!=null){
					//var pfg = self.getParentFormGroup($(this));
					self._change.call(self,$(this).attr("name"),$(this).val(),$(this));
				}
			}
		}
	});
};
/**
 * args:最后一个参数为 boolean 类型，true 表示，
 *      clean form 的同时，将缓存的数据清除掉，false 表示只清除 form 显示的数据
 * 参数不为 boolean 的时候，表示，clear 的时候排除需要清除的数据字段
 */
Eht.Form.prototype.clear=function(){
	if(arguments.length>0){
		if(arguments[arguments.length-1]===true){
			for(p in this.data){
				delete this.data[p];
			}
		}
	}
	var map = {};
	for(var i=0;i<arguments.length;i++){
		if(arguments[i]===true){
		}else{
			map[arguments[i]] = true;
		}
	}
	this.selector.find("input[name],textarea[name],select[name]").each(function(){
		if($(this).attr("fixedValue")!="true"){
			var nm = $(this).attr("name");
			if(map[nm]!=true){
				var type = $(this).attr("type");
				if(type != "radio" && type != "checkbox"){
					$(this).val("");
				}else{
					this.checked = false;
				}
			}
		}
	});
	this.clearValidStyle();
};
Eht.Form.prototype.clearValidStyle=function(){
	this.selector.find(".has-success,.has-error,.glyphicon-remove,.glyphicon-ok,.form-control-feedback")
	   .removeClass("has-success")
	   .removeClass("has-error")
	   .removeClass("glyphicon-remove")
	   .removeClass("glyphicon-ok")
	   .removeClass("form-control-feedback");	
	this.selector.find(".help-block").hide();
};
Eht.Form.prototype.getValue=function(name){
	var combo = this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']");
	return combo.val();
}
Eht.Form.prototype.setValue=function(name,value,triggerChange){
	var self = this;
	this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']").each(function(){
		var type = new String($(this).attr("type")).toLowerCase();
		if(type != "radio" && type != "checkbox"){
			if(value==null){
				$(this).val(self.opt.defaultDisplay);
			}else{
				$(this).val(value);
			}
		}else{
			if(type == "radio"){
				if($(this).val() == value){
					this.checked = true;
				}else{
					this.checked = false;
				}
			}
			if(type == "checkbox"){
				var v = value;
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
		if(triggerChange==true){
			if(self._change!=null){
				var pfg = self.getParentFormGroup($(this));
				self._change.call(self,$(this).attr("name"),$(this).val(),$(this),pfg);
			}
		}
	});
};
Eht.Form.prototype.loadSelectData=function(name,opt,func){
	//opt:{firstEmpty:true,labelField:"",valueField:""}
	var combo = this.selector.find("select[name='"+name+"']");
	var res = new Eht.Responder();
	res.success=function(data){
		var fe = false;
		if(opt!=null){
			fe = opt.firstEmpty;
			if(fe==null){
				fe = false;
			}
			if(fe){
				combo.append("<option></option>");
			}
			var ds = [];
			if($.isArray(data)){
				ds = data;
			}else if(data.rows!=null){
				ds = data.rows;
			}
			for(var i=0;i<ds.length;i++){
				combo.append("<option value='"+ds[i][opt.valueField]+"'>"+ds[i][opt.labelField]+"</option>");
			}
		}
	};
	if(func!=null){
		func(res);
	}
};
Eht.Form.prototype.hideCombo=function(name){
	var combo = this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']");
	combo.disable();
	if(combo.size()>0){
		this.getParentFormGroup(combo).hide();
	}
};
Eht.Form.prototype.showCombo=function(name){
	var combo = this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']");
	combo.enable();
	if(combo.size()>0){
		this.getParentFormGroup(combo).show();
	}
};
Eht.Form.prototype.disable=function(name){
	if(name!=null){
		var combo = this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']");
		combo.disable();
	}else{
		this.selector.find("input[name],textarea[name],select[name]").disable();
	}
};
Eht.Form.prototype.enable=function(name){
	var combo = null;
	if(name!=null){
	  combo = this.selector.find("input[name='"+name+"'],textarea[name='"+name+"'],select[name='"+name+"']");
	}else{
	  combo = this.selector.find("input[name],textarea[name],select[name]");
	}
	combo.enable();
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
	//func(name,value,combo) 函数返回：boolean true 成功  false  失败
	this._customValid = func;
};
Eht.Form.prototype.charValid=function(func){
	//func(name,minNum,maxNum)
	this._charValid=func;
};