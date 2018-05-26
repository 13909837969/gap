var Eht = window.Eht;
if(Eht==undefined){
	Eht = new Object();
};
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g,"");
};
String.prototype.startWith=function(str){ 
	var reg=new RegExp("^"+str); 
	return reg.test(this); 
};
String.prototype.endWith=function(str){ 
	var reg=new RegExp(str+"$"); 
	return reg.test(this); 
};
Date.prototype.format = function(format){
	 var o = {
		 "M+" : this.getMonth()+1, //month
		 "d+" : this.getDate(),    //day
		 "h+" : this.getHours(),   //hour
		 "m+" : this.getMinutes(), //minute
		 "s+" : this.getSeconds(), //second
		 "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
		 "S" : this.getMilliseconds() //millisecond
		 };
	 if(/(y+)/.test(format)){
		 format=format.replace(RegExp.$1,(this.getFullYear()+"").substr(4 - RegExp.$1.length));
	 }
	 for(var k in o){
		if(new RegExp("("+ k +")").test(format)){
			format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
		}
	 }
	 return format;
};
Array.prototype.clearAll=function(){
	if(this.length>0)
	this.splice(0, this.length);
};
Array.prototype.clearNull=function(){
	for(var i=this.length-1;i>=0;i--){
		if(this[i]==null || this[i]==undefined){
			this.splice(i,1);
		}
	}
};
$(document).keydown(function(e){
	var rtn = e.altKey && (e.keyCode==37||e.keyCode==39||e.keyCode==8);
	if(e.keyCode==8){
		var tagName=e.target.tagName.toUpperCase();
		if(tagName=="INPUT" || tagName=="TEXTAREA"){
			rtn = e.target.readOnly;
			if($(e.target).height()==0){
				rtn = true;
			}
		}else{
			rtn = true;
		}
	}
	return !rtn;
});
if(window.console==undefined || window.console==null){
	window.console = {log:function(a){}};
};
Eht.Utils={
	getParameter:function(p){
		var rtn = null;
		var param = decodeURI(window.location.search);
		if(param!="" && param.length>0){
			param = param.replace("?","");
			rtn = _getParam(param);
		};
		function _getParam(str){
			var r = null;
			var ps = str.split("&");
			for(var i=0;i<ps.length;i++){
				if(ps[i].search(p+"=")!=-1){
					r = ps[i].replace(p+"=","").trim();
					break;
				}
			}
			return r;
		};
		return rtn;
	},
	createUuid:function(pfix){
			var guid = "";
		    for (var i = 1; i <= 32; i++){
		      var n = Math.floor(Math.random()*16.0).toString(16);
		      guid +=   n;
		      if((i==8)||(i==12)||(i==16)||(i==20)){
		        guid += "-";
		      }
		    }
		    return pfix?pfix+guid:guid;  
		},
	unselect:function(selector){
		if(document.selection){//IE,Opera
			if(document.selection.empty){//IE
				document.selection.empty();
			}else{//Opera
				document.selection = null;
			}
		}else if(window.getSelection){//FF,Safari
			window.getSelection().removeAllRanges();
		}
		$(selector).bind("selectstart",function(){return false;});  
	},
	select:function(){
		if(window.getSelection){//FF,Safari
			window.getSelection().selectAllChildren(document.body);
		}
	},
	toNumber:function(str){
		return parseFloat(str);
	},
	isEmpty:function(str){
		if(str){
			if(str.trim().length==0){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	},
	isNotEmpty:function(str){
		if(!this.isEmpty(str)){
			return true;
		}else{
			return false;
		}
	},
	toDate:function(str){
		var s = str.replace(/\.\d+/g,"");
		var rtn = null;
		var n = Date.parse(s.replace(/-|\./g,"/"));
		if(!isNaN(n)){
			rtn = new Date(n);
		}
		return rtn;
	},
	isDatetime:function(str){
		var rtn = this.isDate(str);
		if(rtn==false){
			var ss = str.split(/\ +/);
			if(ss.length==2){
				rtn = this.isDate(ss[0]);
				if(rtn==false){
					return rtn;
				}else{
					var hms = ss[1];
					var r = new RegExp(/^(\d{1,2})\:(\d{1,2})\:(\d{1,2})$|^(\d{1,2})\:(\d{1,2})$|^(\d{1,2})$/);
					rtn = r.test(hms);
					if(rtn){
						var arr = hms.match(r);
						if(arr.length>=2){
							if(parseInt(arr[1])>=24){
								rtn = false;
							}
							if(arr[2]!=undefined && parseInt(arr[2])>=60){
								rtn = false;
							}
							if(arr[3]!=undefined && parseInt(arr[3])>=60){
								rtn = false;
							}
						}
					}
				}
			}
		}
		return rtn;
	},
	isDate:function(str){
		var r=new RegExp(/^\d{4}\-\d{2}\-\d{2}$|^\d{4}\.\d{2}\.\d{2}$|^\d{4}\d{2}\d{2}$/g);	
		if(r.test(str)==false){
			return false;
		};
		var d;
		var year=0;
		var month=0;
		var day=0;
		if(str.length==10){
			if(str.search("-")!=-1){
			d=str.split("-");
			}else{
			d=str.split(".");
			}
			year=d[0];
		    month=d[1];
		    day=d[2];
		}
		if(str.length==8){
			year=str.substring(0,4);
			month=str.substring(4,6);
			day=str.substring(6,8);
		};
		var maxMonth=[1,3,5,7,8,10,12];
		var flag=true;
		if(Number(month)>12 ||Number(month)<1){
			return false;
		}
		for(var i=0;i<maxMonth.length;i++){
			if(maxMonth[i]==Number(month)){
			    flag=false;
				if(Number(day)<1 || Number(day)>31){ return false;}
			}else if(month==2){
				var m=(Number(year)%4==0 && Number(year)%100!=0 || Number(year)%400==0) ? 29 : 28;
				flag=false;
				if(day<1 || day>m){ return false;}
			}
		}
		if(flag){
			if(day<1 || day>30){ return false;}
		}
		return true;
	},
	isEmail:function(mail){
		return(new  RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(mail));     
	},
	isMobile:function(str){
        return (new RegExp(/^1[0-9][0-9]{9}$/).test(str));
    },
	isInt:function(number){
		return(new RegExp(/^(-)?\d+$/).test(number));
	},
	isFloat:function(number){
		return(new RegExp(/^(-)?\d+\.\d+$/).test(number));
	},
	isNumber:function(number){
		return(new RegExp(/^(-)?\d+\.?\d*$/).test(number));
	},
	isHasChinese:function(str){
		return (new RegExp(/[\u4e00-\u9fa5]/).test(str));
	},
	isOnlyChinese:function(str){
		return (new RegExp(/^[\u4e00-\u9fa5]+$/).test(str));
	},
	/**
	 * 校验的计算方式：
	 * 1. 对前17位数字本体码加权求和
	 * 公式为：S = Sum(Ai * Wi), i = 0, ... , 16
	 * 其中Ai表示第i位置上的身份证号码数字值，Wi表示第i位置上的加权因子，其各位对应的值依次为： 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
	 * 2. 以11对计算结果取模
	 * Y = mod(S, 11)
	 * 3. 根据模的值得到对应的校验码
	 * 对应关系为：
	 * Y值： 0 1 2 3 4 5 6 7 8 9 10
	 * 校验码： 1 0 X 9 8 7 6 5 4 3 2
	 **/
	//身份证验证
	isPersonCard:function(str){
		if(str.trim().length!=15 && str.trim().length!=18){
			return false;
		}
		if( str.trim().length==18){
			if(this.isDate(str.trim().substring(6,14))==false){
				return false;
			}
			var validatechar=str.substring(17,18);
			//加权因子
			var weighting=[7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2];
			//校验码
			var  validate = ['1','0','X','9','8','7','6','5','4','3','2'];
			var s=0;
			for(var i=0;i<weighting.length;i++){
				s=s+Number(str.split("")[i])*weighting[i];
			}
			if(validatechar!=(validate[s%11])){
				return false;
			}
		}else{
			if(this.isDate("19"+str.trim().substring(6,12))==false){
				return false;
			}
		}
		return true;
	},
	geByPCard:function(str){
		var rtn = {date:"",sex:""};
		if(this.isPersonCard(str)){
			if(str.trim().length==18){
				//rtn.date = str.trim().substring(6,14);
				rtn.date = str.trim().substring(6,10) + "-" + str.trim().substring(10,12) + "-" + str.trim().substring(12,14);
				var l = str.trim().substring(16,17);
				rtn.sex = (l-0)%2==0?2:1;
				rtn.sex_des = rtn.sex==1?"\u7537":"\u5973";
			}
			if(str.trim().length==15){
				//rtn.date = "19"+str.trim().substring(6,12);
				rtn.date = "19"+str.trim().substring(6,8) + "-" + str.trim().substring(8,10) + "-" + str.trim().substring(10,12);
				var l = str.trim().substring(14,15);
				rtn.sex = (l-0)%2==0?2:1;
				rtn.sex_des = rtn.sex==1?"\u7537":"\u5973";
			};
		}
		return rtn;
	},
	getAge:function (birth) {
	    var rtn = "";
	    var r = new RegExp(/^\d{4}\-\d{2}\-\d{2}$/g);
	    if (r.test(birth)) {
	        var today = new Date;
	        var n = Date.parse(birth.replace(/-/g, "/"));
	        if (!isNaN(n)) {
	            bdate = new Date(n);
	            rtn = today.getFullYear() - bdate.getFullYear();
	            if (today.getMonth() < bdate.getMonth()) {
	                rtn = rtn - 1;
	            } else if (today.getMonth() == bdate.getMonth() &&
	                today.getDate() < bdate.getDate()) {
	                rtn = rtn - 1;
	            }
	        }
	    }
	    return rtn;
	},
	getMarginWidth:function(selector){
		var ml = parseInt($(selector).css("margin-left")?$(selector).css("margin-left"):0);
		ml = isNaN(ml)?0:ml;
		var mr = parseInt($(selector).css("margin-right")?$(selector).css("margin-right"):0);
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getMarginHeight:function(selector){
		var ml = parseInt($(selector).css("margin-top")?$(selector).css("margin-top"):0);
		ml = isNaN(ml)?0:ml;
		var mr = parseInt($(selector).css("margin-bottom")?$(selector).css("margin-bottom"):0);
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getPaddingWidth:function(selector){
		var ml = parseInt($(selector).css("padding-left")?$(selector).css("padding-left"):0);
		var mr = parseInt($(selector).css("padding-right")?$(selector).css("padding-right"):0);
		ml = isNaN(ml)?0:ml;
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getPaddingHeight:function(selector){
		var ml = parseInt($(selector).css("padding-top")?$(selector).css("padding-top"):0);
		var mr = parseInt($(selector).css("padding-bottom")?$(selector).css("padding-bottom"):0);
		ml = isNaN(ml)?0:ml;
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getBorderHeight:function(selector){
		var ml = parseInt($(selector).css("border-top-width")?$(selector).css("border-top-width"):0);
		var mr = parseInt($(selector).css("border-bottom-width")?$(selector).css("border-bottom-width"):0);
		ml = isNaN(ml)?0:ml;
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getBorderWidth:function(selector){
		var ml = parseInt($(selector).css("border-left-width")?$(selector).css("border-left-width"):0);
		var mr = parseInt($(selector).css("border-right-width")?$(selector).css("border-right-width"):0);
		ml = isNaN(ml)?0:ml;
		mr = isNaN(mr)?0:mr;
		return ml+mr;
	},
	getMPBWidth:function(selector){
		return this.getMarginWidth(selector) + this.getPaddingWidth(selector) + this.getBorderWidth(selector);
	},
	getMPBHeight:function(selector){
		return this.getMarginHeight(selector) + this.getPaddingHeight(selector) + this.getBorderHeight(selector);
	}
};