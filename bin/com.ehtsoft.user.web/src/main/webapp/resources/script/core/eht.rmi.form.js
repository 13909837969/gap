/**
 * 表单操作类
 * 表单元素代码数据的属性定义：
 * code   :标准数据字典中的类型编码 eg:code = "gb0001"  or [{v:1,d:"label",'def':1},{}]
 * mult : true 多选，界面生成 checkbox
 * ehtType:表单元素中的类型，类型为 date,tree
 * opt    :表单元素中的配置项目   {leaf:true,default:true,radio:true,checkbox:true,empty:true}   
 *        leaf: 表示的是数据类型为 tree 的数据只能选择 叶子节点的数据，根节点不能选择。
 *        default:是否有默认代码值， 默认为有默认值；false 没有默认值。 
 *        radio:code数据单选时，采用 radio 方式
 *        checkbox:code 数据多选是采用  checkbox 方式
 *        empty:true 将 code 代码中在 select 中添加一个空数据 <option value=""></option> 到第一个
 * @param opt
 * @returns {Eht.Form}
 * @author wangbao
 */
Eht.Form=function(opt){
	var form = this;
	var def = {
		sourceAttrs:["name","parent","group","code","disabled"],
		selector:null,
		o2mObj:"parent",// 一对多的对象属性(该属性值为html 表单标签的自定义属性)
		o2mGroup:"group",// 一对多对象中的数据分组属性(该属性值为html 表单标签的自定义属性)
		clearHidden:false,
		codeValueField:"daaa02",
		codeLabelField:"daaa03", // 多字段用 “,” 分割 （select 已经实现，其他没有实现）
		defaultField:"def",
		query:false,
		queryLabel:""
	};
	this.opt = $.extend(def,opt);
	this.selector=$(this.opt.selector);
	this.comboboxs = new Object();
	this.getcombokey=function(ele){
		var name = ele.attr("name");
		if(ele.attr("parent")){
			name+=ele.attr("parent");
		}
		if(ele.attr("group")){
			name+=ele.attr("group");
		}
		return name;
	};
	this.selector.find("select,textarea,input:not(input[type='button'],input[type='image'])").each(
		function(){
			var _eopt = $(this).attr("opt");
			var optObj = {};
			if(_eopt){
				try{
					optObj = eval("("+_eopt+")");
				}catch(e){
					alert("opt 格式错误");
				}
			}
			if($(this).attr("ehtType")=="date"){//date
				var vs = $(this).attr("validate");//添加 date 验证
				if(vs){
					var  reg = /\[.*?\]/g;
					var varr = new Array();
					try{
						if(reg.test(vs)){
							varr = eval("(" + vs + ")");
						}else{
							varr = eval("(["+vs+"])");
						}
						var f = false;
						for(var i=0;i<varr.length;i++){
							if(varr[i].date){
								f=true;
							}
						}
						if(f==false){
							varr.push({date:true});
							$(this).attr("validate",JSON.stringify(varr));
						}
					}catch(e){
						alert(e.message);
					}
				}else{
					$(this).attr("validate","[{date:true}]");
				}
				var name = form.getcombokey($(this));
				var datebox = new Eht.ComboBox({selector:$(this),feature:new Eht.DatePicker(),readOnly:false,icon:"eht-combobox-date-icon",overIcon:"eht-combobox-date-hover"});
				//设置date 默认值
				if(optObj!=null){
					if(optObj["default"]==false){
						datebox.setValue($(this).val());
					}else{
						datebox.setValue(new Date().format("yyyy-MM-dd"));
					}
				}else{
					datebox.setValue(new Date().format("yyyy-MM-dd"));
				}
				loadcomboboxs(name,datebox);
				datebox.change(function(data){
					if(form._change){
						form._change(this.selector,data,this.name);
					}
				});
			}
			//代码数据 来自标准数据中的代码表（ph_data_detail)
			if($(this).attr("code")){
				var ds = null;
				var codestr = $(this).attr("code").toLowerCase();
				if(!(/\[.*?\]/g).test(codestr)){
					ds = Eht.DataCode[codestr];
				}
				if(ds==null && $(this).attr("code")){
					var reg = /\[.*?\]/g;
					if(reg.test($(this).attr("code").trim())){
						try{
							ds = eval("(" + $(this).attr("code").trim() + ")");
							for(var i=0;i<ds.length;i++){
								ds[i][form.opt.codeValueField]=ds[i].v;
								ds[i][form.opt.codeLabelField]=ds[i].d;
							}
						}catch(e){
							alert($(this).attr("name")+"code="+$(this).attr("code").trim()+e.message);
						}
					}
				}
				if($(this).attr("ehtType")=="tree"){
					var olc = false;
					if(optObj!=null && optObj.leaf!=undefined){
						olc = optObj.leaf;
					}
					var name = form.getcombokey($(this));
					var treebox = new Eht.ComboBox({selector:$(this),labelField:form.opt.codeLabelField,valueField:form.opt.codeValueField});
					treebox.setFeature(new Eht.Tree({onlyLeafClick:olc,labelField:form.opt.codeLabelField,css:{border:"1px solid #c3d8f9"}}));
					treebox.loadData(ds);
					loadcomboboxs(name,treebox);
					treebox.change(function(data){
						if(form._change){
							form._change(this.selector,data,this.name);
						}
					});
				}else{
					//mult 多选
					if($(this).attr("mult")||optObj.checkbox||optObj.radio){
						var cboxdivs = $("<div style='display:inline-block;'></div>");
						var typename = "checkbox";
						if(optObj.radio){
							typename = "radio";
						}
						if(ds && ds.length>0){
							for(var i=0;i<ds.length;i++){
								var boxdiv = $("<div style='display:inline-block;'></div>");
								var cbox = $("<input type='"+typename+"' style='vertical-align:middle;'/>");
								for(var a = 0;a<form.opt.sourceAttrs.length;a++){
									cbox.attr(form.opt.sourceAttrs[a],$(this).attr(form.opt.sourceAttrs[a]));
								}
								cbox.attr("value",ds[i][form.opt.codeValueField]);
								boxdiv.append(cbox);
								boxdiv.append("<span style='vertical-align:middle;'>"+ds[i][form.opt.codeLabelField]+"</span>");
								cboxdivs.append(boxdiv);
							}
							$(this).replaceWith(cboxdivs);
						}
					}else{
						if(!$(this).is("select")){
							var select = $("<select></select>");
							if(optObj.empty==true || form.opt.query==true){
								select.append("<option value=''>"+form.opt.queryLabel+"</option>");
							}
							for(var i=0;i<this.attributes.length;i++){
								if(this.attributes[i].value!=null && this.attributes[i].value!=""){
									select.attr(this.attributes[i].name,this.attributes[i].value);
								}
							}
							if(ds){
								for(var i=0;i<ds.length;i++){
									var label = "";
									var ls = form.opt.codeLabelField.split(",");
									for(var l=0;l<ls.length;l++){
										if(l>0){
											label +=(" "+ds[i][ls[l]]);
										}else{
											label += ds[i][ls[l]];
										}
									}
									var otn = $("<option value='"+ds[i][form.opt.codeValueField]+"'>"+label+"</option>");
									if(ds[i][form.opt.defaultField]=="1" || ds[i][form.opt.defaultField]==true ||ds[i][form.opt.defaultField]==1){
										otn.attr("selected",true);
									}
									select.append(otn);
								}
							}
							for(var a = 0;a<form.opt.sourceAttrs.length;a++){
								select.attr(form.opt.sourceAttrs[a],$(this).attr(form.opt.sourceAttrs[a]));
							}
							$(this).replaceWith(select);
							select.unbind("change").bind("change",function(e){
								if(form.textValidate($(this))){
									if(form._change){
										form._change(e,$(this).val(),$(this).attr("name"));
									}
								}
							});
							select.hover(function(e){
								if(!$(this).hasClass("eht-validatebox-invalid")){
									$(this).css({"background":"rgb(199,237,204)"});
									$(this).height($(this).height());
									$(this).width($(this).width());
								}
							},function(e){
								$(this).css({"background":""});
							});
						}else{
							//select 标签
							if(ds){
								if(optObj.empty==true || form.opt.query==true){
									$(this).append("<option value=''>"+form.opt.queryLabel+"</option>");
								}
								for(var i=0;i<ds.length;i++){
									var label = "";
									var ls = form.opt.codeLabelField.split(",");
									for(var l=0;l<ls.length;l++){
										if(l>0){
											label +=(" "+ds[i][ls[l]])
										}else{
											label += ds[i][ls[l]];
										}
									}
									$(this).append("<option value='"+ds[i][form.opt.codeValueField]+"'>"+label+"</option>");
								}
							}
						}
					}
				}
			}
			$(this).unbind("change").bind("change",function(e){
				if(form.textValidate($(this))){
					if(form._change){
						form._change(e,$(this).val(),$(this).attr("name"));
					}
				}
			});
			$(this).unbind("blur").bind("blur",function(e){
				if(form.textValidate($(this))){
					/*if(form._change){
						form._change(e,$(this).val(),$(this).attr("name"));
					}*/
				}
			});
			if(!$(this).attr("readonly")){
				$(this).hover(function(e){
					if(!$(this).hasClass("eht-validatebox-invalid")){
						$(this).css({"background":"rgb(199,237,204)"});
					}
				},function(e){
					$(this).css({"background":""});
				});
			}
		}
	);
	function loadcomboboxs(name,combobox){
		if(name){
			if(form.comboboxs[name]){
				if(!$.isArray(form.comboboxs[name])){
					var arr = new Array();
					arr.push(form.comboboxs[name]);
					arr.push(combobox);
					form.comboboxs[name] = arr;
				}else{
					form.comboboxs[name].push(combobox);
				}
			}else{
				form.comboboxs[name]=combobox;
			}
		}
	}
};
Eht.Form.prototype.fill=function(dataObj){
	var form = this;
	var o2mObj = this.opt.o2mObj;
	var clr = true;
	if(arguments.length==2 && arguments[1]==false){
		clr = false;
	}
	if(clr){
		this.clear();
	}
	var data = new Object();
	for(p in dataObj){
		data[p]=dataObj[p];
	}
	this._data = data;
	if(data){
		for(var p in data){
			var element = this.selector.find("*[name='"+p+"']:not(input[type='button'],input[type='file'],input[type='image'])");
			if(element.size()>0){
				if(element.attr(o2mObj)==undefined){
					form.setValue(element.attr("name"), data[p]);
				} 
			}
			form.setO2mObj(p,data[p]);
		}
	}
	// 将获取的值放到 oldvalue 属性中去（将来用于唯一数据验证或数据变化）
	this.selector.find("select,textarea,input:not(input[type='button'],input[type='image'])").each(
			function(){
				if(new String($(this).attr("type")).toLowerCase()!="radio" && new String($(this).attr("type")).toLowerCase()!="checkbox"){
					$(this).attr("oldvalue",$(this).val());
				}
			}
		);
};
/**
 * 向表单中的输入框中赋值
 * @param name   输入框的  name 值 或 id 值
 * @param value  输入框的 value 值，当输入框中有多个name相同的值时，该 value 值的类型可以使数组类型，分别对应name的值，如 ：[value1,value2]
 */
Eht.Form.prototype.setValue=function(name,value){
	if(value && $.type(value)=="string"){
		value = value.trim();
	}
	var form = this;
	var element = this.selector.find("*[name='"+name+"'],*[id='"+name+"']");
	if(element.size()>0){
		element.each(function(i){
			if($(this).is(":radio")||$(this).is(":checkbox")){
				if($.isArray(value)){
					for(var m=0;m<value.length;m++){
						if($(this).val()==value[m]){
							$(this).get(0).checked = true;
						}
					}
				}else{
					if($(this).val()==value){
						$(this).get(0).checked = true;
					}
				}
			}else{
				if($.isArray(value)){
					if(value.length>i){
						$(this).val(value[i]);
					}
				}else{
					if(i==0){
						if($(this).is("input") || $(this).is("select") || $(this).is("textarea")){
							$(this).val(value);
						}else{
							if($(this).attr("code")){
								var ds = null;
								var codestr = $(this).attr("code").toLowerCase();
								if(!(/\[.*?\]/g).test(codestr)){
									ds = Eht.DataCode[codestr];
								}
								if(ds==null){
									var reg = /\[.*?\]/g;
									if(reg.test($(this).attr("code").trim())){
										try{
											ds = eval("(" + $(this).attr("code").trim() + ")");
											for(var i=0;i<ds.length;i++){
												ds[i][form.opt.codeValueField]=ds[i].v;
												ds[i][form.opt.codeLabelField]=ds[i].d;
											}
										}catch(e){
											alert($(this).attr("name")+"code="+$(this).attr("code").trim()+e.message);
										}
									}
								}
								if(ds){
									var tmpvalue = value;
									for(var mm=0;mm<ds.length;mm++){
										if(value==ds[mm][form.opt.codeValueField]){
											tmpvalue = ds[mm][form.opt.codeLabelField];
											break;
										}
									}
									$(this).html(tmpvalue);
								}
							}else{
								$(this).html(value);
							}
						}
						$(this).attr("oldvalue",value);
					}
				}
			}
		});
	}
	if(this.comboboxs[name]){
		if(!$.isArray(this.comboboxs[name])){
			if($.isArray(value)){
				this.comboboxs[name].setValue(this.selector.find("input[type='hidden'][name='"+name+"']").val());
			}else{
				this.comboboxs[name].setValue(value);
			}
		}else{
			
		}
	}
};
Eht.Form.prototype.setO2mObj=function(parent,data){
	var form = this;
	var pe = this.selector.find("*[parent='"+parent+"']");
	if(pe.size()>0){
		var gtmp = new Object();
		pe.each(function(){
			var g = $(this).attr("group")?$(this).attr("group"):"un-defined";
			if(gtmp[g]){
				gtmp[g].push($(this));
			}else{
				var gs = new Array($(this));
				gtmp[g]=gs;
			}
		});
		var i=0;
		if(data){
			var valuetmp = new Object();// key=name + parent + group
			for(var p in gtmp){
				if($.isArray(gtmp[p])){
					for(var j=0;j<gtmp[p].length;j++){
						if(i<data.length){
							if(gtmp[p][j].attr("name")){
								var v = data[i][gtmp[p][j].attr("name")];
								if(gtmp[p][j].is(":radio")||gtmp[p][j].is(":checkbox")){
									if($.isArray(v)){
										for(var m=0;m<v.length;m++){
											if(gtmp[p][j].val()==v[m]){
												gtmp[p][j].get(0).checked = true;
											}
										}
									}else{
										if(gtmp[p][j].val()==v){
											gtmp[p][j].get(0).checked = true;
										}
									}
								}else{
									var ke = form.getcombokey(gtmp[p][j]);
									if($.isArray(v)){
										if(!valuetmp[ke]){
											var vs = [];
											for(var m=0;m<v.length;m++){
												vs.push(v[m]);
											}
											valuetmp[ke] = vs;
										}
										gtmp[p][j].val(valuetmp[ke].shift());
									}else{
										if(valuetmp[ke]==undefined){
											valuetmp[ke] = v;
										}
										gtmp[p][j].val(valuetmp[ke]);
										valuetmp[ke]="";
									}
									var key = form.getcombokey(gtmp[p][j]);
									if(form.comboboxs[key]){
										if(!$.isArray(form.comboboxs[key])){
											form.comboboxs[key].setValue(v);
										}else{
											
										}
									}
								}
							}
						}
					}
				}
				i++;
			}
		}
	}
};
Eht.Form.prototype.getOldValue=function(name){
	var em = this.selector.find("input[name='"+name+"'],select[name='"+name+"'],textarea[name='"+name+"']");
	var r = em.attr("oldvalue");
	return r;
};
Eht.Form.prototype.getValue=function(name){
	var rtn = null;
	var element = this.selector.find("*[name='"+name+"'],*[id='"+name+"'],*."+name);
	if(element.size()>0){
		if(element.size()==1){
			if(new String(element.attr("type")).toLowerCase()=="radio"||
			   new String(element.attr("type")).toLowerCase()=="checkbox"){
				if(element.get(0).checked == true){
					rtn = element.val();
				}
			}else{
				 rtn = element.val();
			}
		}else{
			var vals = [];
			element.each(function(){
				if(new String($(this).attr("type")).toLowerCase()=="radio"){
					if($(this).get(0).checked == true){
						rtn = $(this).val();
					}
				}else if(new String($(this).attr("type")).toLowerCase()=="checkbox"){
					if($(this).get(0).checked == true){
						vals.push($(this).val());
					}
				}else{
					vals.push($(this).val());
				}
			});
			if(rtn==null){
				rtn = vals;
			}
		}
	}
	return rtn;
};
/**
 * checkbox 单选  不选择的时候，默认值为 "",如果有 otherwise 属性的时候，不选择的值为  otherwise 的值
 * <input type="checkbox" value="1" otherwise="0">
 * @returns {Object}
 */
Eht.Form.prototype.getData=function(){
	// arguments[0] == "enable" 时，只获取 非 disabled 中的数据（ disabled 数据不取出来） 如果内存中也存在 disabled 的数据，也排除在外
	var o2mObj = this.opt.o2mObj;
	var o2mGroup = this.opt.o2mGroup;
	var data = new Object();
	var gObj = new Object();//每组的数据
	var setor = "select[name],textarea[name],input[name]:not(input[type='button'],input[type='image'])";
	if(arguments.length>0 && arguments[0]=="enable"){
		setor = "select[name]:not(:disabled),textarea[name]:not(:disabled),input[name]:not(:disabled,input[type='button'],input[type='image'])";
	}
	var checkRadioData=new Object();
	this.selector.find(setor).each(
		function(){
			var value = $(this).val();
			var name = $(this).attr("name");
			if(new String($(this).attr("type")).toLowerCase()=="radio" || new String($(this).attr("type")).toLowerCase()=="checkbox"){
				if($(this).get(0).checked){
					value = $(this).val();
					checkRadioData[name] = value;
				}else{
					if(checkRadioData[name]==undefined){
						if($(this).attr("otherwise")!=null && $(this).attr("otherwise")!=undefined){
							checkRadioData[name] = $(this).attr("otherwise");
						}else{
							checkRadioData[name] = "";
						}
					}
					value = null;
				}
			}
			if(value!=null){
				var group = $(this).attr(o2mGroup);
				if(group!=undefined){//group 分组
					var parent = $(this).attr(o2mObj);
					var gp = parent + group;
					if(gObj[gp]){
						if(gObj[gp][name]==undefined){
							gObj[gp][name]=value;
						}else{
							if($.type(gObj[gp][name])=="array"){
								gObj[gp][name].push(value);
							}else{
								var gn = new Array();
								gn.push(gObj[gp][name]);
								gn.push(value);
								gObj[gp][name] = gn;
							}
						}
					}else{
						var g = new Object();
						//g[name]=value;
						form2Obj(g,name,value);
						gObj[gp]=g;
					}
					//将 gObj （组对象赋给parent属性中 
					if(parent!=undefined){
						if(data[parent]==undefined){
							var p = new Array();
							p.push(gObj[gp]);
							data[parent] = p;
						}else{
							//data[parent]数组中不存在 gObj[group] 对象时 ，push 一个对象进去 ，否则 不放对象 
							if(!isExist(data[parent],gObj[gp])){
								data[parent].push(gObj[gp]);
							}
						}
					}
				}else{
					form2Obj(data,name,value);
				}
			}
		}
	);
	function isExist(array,obj){
		var rtn = false;
		for(var i=0;i<array.length;i++){
			if(obj==array[i]){
				rtn =true;
				break;
			}
		}
		return rtn;
	};
	function form2Obj(object,name,value){
		
		if(object[name]!=undefined){
			if($.type(object[name])=="array"){
				object[name].push(value);
			}else{
				var array = new Array();
				array.push(object[name]);
				array.push(value);
				object[name]=array;
			}
		}else{
			object[name]=value;
		}
	};
	for(var p in checkRadioData){
		if(!$.isArray(data[p]) && data[p]==null){
			data[p] = checkRadioData[p];
		}
	}
	if(this._data){
		for(var p in this._data){
			if(data[p]==undefined){
				data[p]=this._data[p];
			}
		}
	}
	if(arguments.length>0 && arguments[0]=="enable"){
		this.selector.find("select[name]:disabled,textarea[name]:disabled,input[name]:disabled").each(function(){
			var nm = $(this).attr("name");
			delete data[nm];
		});
	}
	return data;
};
Eht.Form.prototype.remove=function(name){
	if(this._data){
		delete this._data[name];
	}
};
/**
 * 参数为 表单收入框中的name属性值或id值
 * 如果方法没有参数，调用该方法的时候，将全部禁用所有的收入框
 * 如果有参数，并且为表单输入框中的name属性值或id值，最后一个参数不为 boolean 类型的 true
 * 则表示禁用除了传递参数的输入框外的所有其他的输入框，如果，最后一个参数是boolean 类型的 true 值
 * 则表示禁用传递参数中的输入框
 */
Eht.Form.prototype.disable=function(){
	var form = this;
	var args = arguments;
	var flag = false;
	if(args.length > 0){
		if($.type(args[args.length-1])=="boolean"){
			if(args[args.length-1]==true){
				flag = true;
			}
		}
	}
	this.selector.find("select,textarea,input:not(input[type='button'],input[type='image'])").each(
			function(){
				if(flag==false){
					if(!isNoDisable($(this).attr("name"),$(this).attr("id"))){
						$(this).disable();
						if(form.comboboxs[$(this).attr("name")]){
							if($.isArray(form.comboboxs[$(this).attr("name")])){
								for(var i=0;i<form.comboboxs[$(this).attr("name")].length;i++){
									form.comboboxs[$(this).attr("name")][i].disable();
								}
							}else{
								form.comboboxs[$(this).attr("name")].disable();
							}
						}
					}
				}else{
					if(isNoDisable($(this).attr("name"),$(this).attr("id"))){
						$(this).disable();
						if(form.comboboxs[$(this).attr("name")]){
							if($.isArray(form.comboboxs[$(this).attr("name")])){
								for(var i=0;i<form.comboboxs[$(this).attr("name")].length;i++){
									form.comboboxs[$(this).attr("name")][i].disable();
								}
							}else{
								form.comboboxs[$(this).attr("name")].disable();
							}
						}
					}
				}
			}
		);
	this.selector.find(".eht-date-picker-head select").enable();
	function isNoDisable(name,id){
		var rtn = false;
		for(var i=0;i<args.length;i++){
			if(name==args[i]||id==args[i]){
				rtn = true;
			}
		}
		return rtn;
	}
};
/**
 * 参数为 表单收入框中的name属性值或id值
 * 如果方法没有参数，调用该方法的时候，将全部启用所有的收入框
 * 如果有参数，并且为表单输入框中的name属性值或id值，最后一个参数不为 boolean 类型的 true
 * 则表示启用除了传递参数的输入框外的所有其他的输入框，如果，最后一个参数是boolean 类型的 true 值
 * 则表示启用传递参数中的输入框
 */
Eht.Form.prototype.enable=function(){
	var form = this;
	var args = arguments;
	var flag = false;
	if(args.length > 0){
		if($.type(args[args.length-1])=="boolean"){
			if(args[args.length-1]==true){
				flag = true;
			}
		}
	}
	this.selector.find("select,textarea,input:not(input[type='button'],input[type='image'])").each(
			function(){
				if(flag==false){
					if(!isNoEnable($(this).attr("name"),$(this).attr("id"))){
						$(this).enable();
						if(form.comboboxs[$(this).attr("name")]){
							if($.isArray(form.comboboxs[$(this).attr("name")])){
								for(var i=0;i<form.comboboxs[$(this).attr("name")].length;i++){
									form.comboboxs[$(this).attr("name")][i].enable();
								}
							}else{
								form.comboboxs[$(this).attr("name")].enable();
							}
						}
					}
				}else{
					if(isNoEnable($(this).attr("name"),$(this).attr("id"))){
						$(this).enable();
						if(form.comboboxs[$(this).attr("name")]){
							if($.isArray(form.comboboxs[$(this).attr("name")])){
								for(var i=0;i<form.comboboxs[$(this).attr("name")].length;i++){
									form.comboboxs[$(this).attr("name")][i].enable();
								}
							}else{
								form.comboboxs[$(this).attr("name")].enable();
							}
						}
					}
				}
			}
		);
	this.selector.find(".eht-date-picker-head select").enable();
	function isNoEnable(name,id){
		var rtn = false;
		for(var i=0;i<args.length;i++){
			if(name==args[i]||id==args[i]){
				rtn = true;
			}
		}
		return rtn;
	}
};
/**
 * 参数为 表单收入框中的name属性值或id值
 * 如果方法没有参数，调用该方法的时候，将全部清空所有的收入框
 * 如果有参数，并且为表单输入框中的name属性值或id值，最后一个参数不为 boolean 类型的 true
 * 则表示清空除了传递参数的输入框外的所有其他的输入框，如果，最后一个参数是boolean 类型的 true 值
 * 则表示清空传递参数中的输入框
 */
Eht.Form.prototype.clear=function(){
	var form = this;
	var args = arguments;
	var flag = false;
	if(args.length > 0){
		if($.type(args[args.length-1])=="boolean"){
			if(args[args.length-1]==true){
				flag = true;
			}
		}
	}
	//this.selector.find("select[name],textarea[name],input[name]:not(input[type='button'],input[type='image'])").each(
	this.selector.find("*[name]:not(input[type='button'],input[type='image'],button)").each(
		function(){
			if(flag==false){
				if(!isNoClear($(this).attr("name"),$(this).attr("id"))){
					if($(this).is("input") || $(this).is("select") || $(this).is("textarea")){
						if(new String($(this).attr("type")).toLowerCase()!="radio" && new String($(this).attr("type")).toLowerCase()!="checkbox"){
							if(new String($(this).attr("type")).toLowerCase()!="hidden" || form.opt.clearHidden==true){
								$(this).val("");
							}
						}else{
							$(this).attr("checked",false);
						}
						if($(this).attr("oldvalue")){
							$(this).attr("oldvalue","");
						}
					}else{
						$(this).html("");
					}
				}
			}else{
				if(isNoClear($(this).attr("name"),$(this).attr("id"))){
					if($(this).is("input") || $(this).is("select") || $(this).is("textarea")){
						if(new String($(this).attr("type")).toLowerCase()!="radio" && new String($(this).attr("type")).toLowerCase()!="checkbox"){
							if(new String($(this).attr("type")).toLowerCase()!="hidden" || form.opt.clearHidden==true){
								$(this).val("");
							}
						}else{
							$(this).attr("checked",false);
						}
						if($(this).attr("oldvalue")){
							$(this).attr("oldvalue","");
						}
					}else{
						$(this).html("");
					}
				}
			}
		}
	);
	this.selector.find(".eht-validatebox-invalid").removeClass("eht-validatebox-invalid");
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

Eht.Form.prototype.clearData=function(){
	if(this._data){
		for(var p in this._data){
			delete this._data[p];
		}
	}
};
Eht.Form.prototype.change=function(func){
	//func(event,data,name);
	this._change=func;
};
/**
 * 表单验证
 */
Eht.Form.prototype.validate=function(){
	var rtn = true;
	var form = this;
	this.selector.find("input[validate],select[validate],textarea[validate]:not(input[type='button'],input[type='image'])").each(function(){
		if(!$(this).is(":disabled")&&!$(this).is(":hidden")){
			if(form.textValidate($(this))==false){
				rtn = false;
			}
		}
	});
	return rtn;
};
/**validate="[
 * {required:true,message:'姓名不能为空!'},
 * {unique:true,type:"mongo",callback:"funcname",table:'ARCH_BASIC_ARCHIVES',where:'column1,column2',message:'$已经存在'}
 * {date:true,message:"日期格式不正确,格式:yyyy-mm-dd"},
 * {datetime:true,message:"日期格式不正确,格式:yyyy-mm-dd HH:mm:ss"},
 * {email:true,message:"邮箱格式不正确"},
 * {int:true,message:"整形数据",minNum:范围最小值,maxNum:范围最大值,padded:"整形数值类型数据长度为数补齐字符，如：padded:0"},
 * {float:true,message:"小数数据",minNum:范围最小值,maxNum:范围最大值},
 * {number:true,message:"数子类型数据"},
 * {hasChinese:true,message:"数据存在中文字符"},
 * {onlyChinese:true,message:"数据纯中文字符"},
 * {personCard:true,message:"身份证号码强行验证"},
 * {mobile:true,message:"手机号码为11位数字"},
 * {extend:true,callback:"funcname",message:"验证不通过"}   //funcname 返回参数为  {value:true/false,message:""};
 * ]" **/
Eht.Form.prototype.textValidate=function(combo){
	var form = this;
	var rtn = true;
	var vs = combo.attr("validate");
	combo.removeAttr("title");
	var oldvalue = combo.attr("oldvalue");
	if(vs){
		var  reg = /\[.*?\]/g;
		var arr = new Array();
		try{
			if(reg.test(vs)){
				arr = eval("(" + vs + ")");
			}else{
				arr = eval("(["+vs+"])");
			}
		}catch(e){
			alert(e.message);
		}
		var lblstr = combo.attr("label")?combo.attr("label"):"";
		for(var i=0;i<arr.length;i++){
			combo.removeClass("eht-validatebox-invalid");
			/** required 必填验证 **/
			if(arr[i].required && Eht.Utils.isEmpty(combo.val())){//必填项验证
				rtn = false;
				combo.addClass("eht-validatebox-invalid");
				combo.attr("title",arr[i].message?arr[i].message:lblstr+"不能为空！");
				break;
			}
			/** unique 唯一验证**/
			//唯一    {unique:true,type:"mongo",callback:"funcname",table:'ARCH_BASIC_ARCHIVES',where:'column1,column2',message:'$已经存在'}
			// callback 函数中的方法必须为同步方法
			if(arr[i].unique && Eht.Utils.isNotEmpty(combo.val())){
				var func = arr[i].callback;
				if(func==false){
					//callback 函数中的方法必须为同步方法,方法返回为boolean类型 ，true 表示，通过验证，false 表示不通过验证
					if(combo.attr("oldvalue")!=combo.val()){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",arr[i].message?arr[i].message.replace("$",combo.val()):lblstr+combo.val()+"数据已经存在！");
					}else{
						rtn = true;
						combo.removeClass("eht-validatebox-invalid");
						combo.removeAttr("title");
					}
				}else if(func==true){
				}else if(func!=undefined){
					try{
						rtn = eval(arr[i].callback);
					}catch(e){
						alert(e.message);
					}
					if(combo.attr("oldvalue")!=combo.val()){
						if(rtn==false || rtn==undefined){
							rtn = false;
							combo.addClass("eht-validatebox-invalid");
							combo.attr("title",arr[i].message?arr[i].message.replace("$",combo.val()):lblstr+combo.val()+"数据已经存在！");
						}
					}else{
						rtn = true;
						combo.removeClass("eht-validatebox-invalid");
						combo.removeAttr("title");
					}
				}else{
					var bs = {};
					if(arr[i].type && arr[i].type=="mongo"){
						bs = new MBasicService();
					}else{
						bs = new SqlBasicService();
					}
					bs.async=false;
					var q = new Object();
					q[combo.attr("name")+"[eq]"]=combo.val();
					if(arr[i].where){
						var wtmp = arr[i].where.split(",");
						for(var w=0;w<wtmp.length;w++){
							q[wtmp[w]+"[eq]"]=this.data[wtmp[w]];
						}
					}
					if(combo.attr("oldvalue")!=combo.val()){//编辑修改
						var r = bs.validateUnique(arr[i].table,q);
						if(r && r.value==false){
							rtn = false;
							combo.addClass("eht-validatebox-invalid");
							combo.attr("title",arr[i].message?arr[i].message.replace("$",combo.val()):lblstr+combo.val()+"数据已经存在！");
							break;
						}
					}else{	
						rtn = true;
						combo.removeClass("eht-validatebox-invalid");
						combo.removeAttr("title");
					}
				}
			}
			/** date 日期验证 **/
			//{date:true,message:"日期格式不正确,格式:yyyy-mm-dd"},
			if(arr[i].date && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isDate(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"日期数据错误！格式：yyyy-mm-dd");
					break;
				}else{
					var str = combo.val();
					str = str.replace(/\.|\-/g,"");
					if(str.search("-")==-1){
						combo.val(str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6,8));
					}
				}
			}
			//{datetime:true,message:"日期格式不正确,格式:yyyy-mm-dd"},
			if(arr[i].datetime && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isDatetime(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"时间格式数据错误！格式：yyyy-mm-dd HH:mm:ss");
					break;
				}else{
					var str = combo.val();
					str = str.replace(/\.|\-/g,"");
					if(str.search("-")==-1){
						combo.val(str.slice(0,4)+"-"+str.slice(4,6)+"-"+str.slice(6));
					}
				}
			}
			/**Mail验证**/
			//{email:true,message:"邮箱格式不正确"},
			if(arr[i].email && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isEmail(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"数据格式为 email格式，如：manager@ehtsoft.com");
					break;
				}
			}
			/** 手机号验证 **/
			//{mobile:true,message:"手机号码为11位数字"}
			if(arr[i].mobile && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isMobile(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"请输入正确的手机号码");
					break;
				}
			}
			/** int 整数验证 **/
			//{int:true,message:"整数数据",minNum:范围最小值,maxNum:范围最大值}
			if(arr[i].int && Eht.Utils.isNotEmpty(combo.val())){
				var val = combo.val();
				if(!Eht.Utils.isInt(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"不是整数！");
					break;
				}else{
					if(arr[i].minNum>combo.val()||arr[i].maxNum<combo.val()){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",arr[i].message?arr[i].message:lblstr+"超出有效数值范围（"+arr[i].minNum+","+arr[i].maxNum+"）！");
						break;
					}
				}
				if(arr[i].padded!=undefined){
					var pad = arr[i].padded;
					var maxlength = combo.attr("maxLength")?combo.attr("maxLength"):0;
					var inistr = "";
					if(maxlength>0 && maxlength<10){
						for(var k=0;k<maxlength;k++){
							inistr += pad;
						}
						inistr +=val;
						combo.val(inistr.substring(inistr.length-maxlength));
					}
				}
			}
			/** float 小数验证**/
			//{float:true,message:"小数数据",minNum:范围最小值,maxNum:范围最大值}
			if(arr[i].float && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isFloat(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"不是浮点数！");
					break;
				}else{					
					if(arr[i].minNum>combo.val()||arr[i].maxNum<combo.val()){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",arr[i].message?arr[i].message:lblstr+"超出有效数值范围！");
						break;
					}
				}
			}

			/** number 数字验证**/
			//{number:true,message:"数组类型数据",minNum:范围最小值,maxNum:范围最大值}
			if(arr[i].number && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isNumber(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"不是数字！");
					break;
				}else{					
					if(arr[i].minNum>combo.val()||arr[i].maxNum<combo.val()){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",arr[i].message?arr[i].message:lblstr+"超出有效数值范围！");
						break;
					}
				}
			}
			/** hasChinese 包含汉字**/
			//{hasChinese:true,message:"数据存在中文字符"}
			if(arr[i].hasChinese && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isHasChinese(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"数据没有包含中文！");
					break;
				}
			}
			/** chinese 只能是汉字**/
			//{onlyChinese:true,message:"数据纯中文字符"}
			if(arr[i].onlyChinese && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isOnlyChinese(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:lblstr+"数据只能是汉字！");
					break;
				}
			}
			/** personCard 身份证号码验证**/
			//{personCard:true,message:"身份证号码强行验证"}
			if(arr[i].personCard && Eht.Utils.isNotEmpty(combo.val())){
				if(!Eht.Utils.isPersonCard(combo.val())){
					rtn = false;
					combo.addClass("eht-validatebox-invalid");
					combo.attr("title",arr[i].message?arr[i].message:"身份证号码错误，请输入标准的身份证号码！");
					break;
				}
			}
			//{extend:true,callback:"funcname",message:"验证不通过"}   //funcname 返回参数为  {value:true/false,message:""};
			if(arr[i].extend && Eht.Utils.isNotEmpty(combo.val())){
				var func = arr[i].callback;
				if($.type(func)=="object"){
					//func 函数中的方法必须为同步方法,方法返回为boolean类型 ，true 表示，通过验证，false 表示不通过验证
					if(func.value==false){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",func.message?func.message:"验证不通过");
					}
				}else if($.type(func)=="string"){
					try{
						var o = eval(func);
						if(o.value==false){
							rtn = false;
							combo.addClass("eht-validatebox-invalid");
							combo.attr("title",o.message?o.message:"验证不通过");
						}
					}catch(e){
						alert(e.message);
					}
				}else if($.type(func)=="function"){
					var o = func(form);
					if(o.value==false){
						rtn = false;
						combo.addClass("eht-validatebox-invalid");
						combo.attr("title",o.message?o.message:"验证不通过");
					}
				}
			}
		}
	}
	return rtn;
};
/**
 * 向表单中添加数据
 * @param data  = eg:{"_id":value}
 */
Eht.Form.prototype.setData=function(data){
	if(data){
		if(this._data){
			for(var p in data){
				this._data[p]=data[p];
			}
		}else{
			this._data = new Object();
			for(var p in data){
				this._data[p]=data[p];
			}
		}
	}
};