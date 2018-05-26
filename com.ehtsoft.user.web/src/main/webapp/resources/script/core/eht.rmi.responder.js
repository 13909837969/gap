/**
 * 对象继承的方法复写
 * @returns
 * @author wangbao
 */
Object.extend = function(){
	var args = arguments;
	args = (args[1]) ? [args[0], args[1]] : [this, args[0]];
	for (var property in args[1]) args[0][property] = args[1][property];
	return args[0];
};
Eht.Class=function(properties){
	var clazz = function(){
		if (this.initialize && arguments[0] != 'noinit') return this.initialize.apply(this, arguments);
		else return this;
	};
	for (var property in this) clazz[property] = this[property];
	clazz.prototype = properties;
	return clazz;
};
/*
Object.Native = function(){
	for (var i = 0; i < arguments.length; i++) arguments[i].extend = Eht.Class.prototype.implement;
};
*/
//new Object.Native(Function, Array, String, Number, Eht.Class);
Eht.Class.prototype = {
		extend: function(properties){
			var pr0t0typ3 = new this('noinit');
			var parentize = function(previous, current){
				if (!previous.apply || !current.apply) return false;
				return function(){
					this.parent = previous;
					return current.apply(this, arguments);
				};
			};
			for (var property in properties){
				var previous = pr0t0typ3[property];
				var current = properties[property];
				if (previous && previous != current) current = parentize(previous, current) || current;
				pr0t0typ3[property] = current;
			}
			return new Eht.Class(pr0t0typ3);
		},
		implement: function(properties){
			for (var property in properties) this.prototype[property] = properties[property];
		},
		empty : function(){}
	};
/**
 * ajax 相应返回对象及方法
 * @returns
 * @author wangbao
 */
Eht.Responder=function(setting){
	this.debug = true;
	if(setting){
		this.ds = setting.ds;
	}
	this.context = new Object();
	this.success = function(data, textStatus, jqXHR) {
	};
	this.error = function(request, textStatus, error) {
		if(textStatus=="error" && request.status==0){
			new Eht.Alert({title:"错误信息",message:"应用停止服务或网络中断！"});
		}else{
			new Eht.Alert({title:"错误信息",message:request.responseText});
		}
	};
	this.complete = function(res, status) {
		if (this.debug) {
			alert("ajax complete");
		}
	};
	this.beforeSend = function(xml) {
		if (this.debug) {
			alert("ajax beforeSend:" + xml);
		}		
	};
	if(setting){
		Object.extend(this,setting);
	}
};
Eht.RemoteJsonService=new Eht.Class({
	jsonGateway: "/json/",
	async:		 true,
	ajaxCall:function(data,res){
		if(res.sendHandler)
			res.sendHandler(this,data,res);
		else {
			var r=this.__send(data,res);
			if(this.async == false && res.context) {
				return r;
			}
		}
	},
	__send: function(data,res) {
		var rtn = jQuery.ajax({				
					type: 		"POST",
					url:  		this.jsonGateway,
					data: 		data,
					dataType: 	"json",
					async: 		this.async,
					debug:		res.debug,
					context:	res.context,
					success: 	res.success,							
					error:   	res.error,
					complete: 	res.complete,
					beforeSend: res.beforeSend
				});
		if(this.async==false){
			var reg = /^\[.*\]$|^\{.*\}$/;
			if(reg.test(rtn.responseText)){	
				try{
					return JSON.parse(rtn.responseText);
				}catch(e){
					return rtn.responseText;
				}
			}else{
				return rtn.responseText;
			}
		}
	},
	preprocess: function() {
		var res;
		if (arguments.length > 0 && (arguments[arguments.length-1] instanceof Eht.Responder)) {
			res = arguments[arguments.length-1];
			Array.prototype.splice.apply(arguments,[arguments.length-1,1]);
		}
		var newArgs = new Array();
		for (var i=0; i<arguments.length; i++) {
			newArgs[i] = arguments[i];
		}
		if (!res) {
			res = new Eht.Responder();
		}
		var data = new Object();
		data.service = this.serviceName;		
		data.arguments = JSON.stringify(newArgs);		
		var preprocessResult = new Object();
		preprocessResult.res = res;
		preprocessResult.data = data;
		return 	preprocessResult;
	}
});
