/**
 * jquery 插件
 * @author wangbao
 */
(function($){
	$.browser = {};	
	$.browser.mozilla = /firefox/.test(navigator.userAgent.toLowerCase());
	$.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
	$.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
	$.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());
	
	
	$.fn.enable=function(blnValue){
		if(blnValue==undefined || blnValue==null){
			$(this).attr("disabled",false);
		}else{
			$(this).attr("disabled",blnValue);
		}
	};
	$.fn.disable=function(blnValue){
		if(blnValue==undefined || blnValue==null){
			$(this).attr("disabled",true);
		}else{
			$(this).attr("disabled",blnValue);
		}
	};
	/**
	 * 基于html5 css3 的动画
	 * 参数为：css3 class 值
	 * animationName 值为下面的值
	 * "bounceIn","bounceInDown","bounceInLeft","bounceInRight","bounceInUp",
        "fadeIn", "fadeInDown", "fadeInLeft", "fadeInRight", "fadeOutUp",
        "fadeInDownBig", "fadeInLeftBig", "fadeOutRightBig", "fadeOutUpBig",
        "flipInX","flipInY",
        "lightSpeedIn","rotateIn","rotateInDownLeft","rotateInDownRight","rotateInUpLeft",
        "rotateInUpRight",
        "zoomIn","zoomInDown","zoomInLeft","zoomInRight","zoomInUp","slideInDown","slideInLeft",
        "slideInRight", "slideInUp","rollIn"
	 */
	$.fn.animateCss=function (animationName,func) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
            if(func!=null && $.isFunction(func)){
            	func.call(this);
            }
        });
    };
    $.fn.datetimepicker.dates['zh-CN'] = {
    			days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
    			daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    			daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
    			months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    			//months: [1,2,3,4,5,6,7,8,9,10,11,12],
    			monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    			today: "今天",
    			suffix: [],
    			meridiem: ["上午", "下午"]
    };
    $.fn.password=function(arg){
    	//有问题，废掉
    	if(arg==null){
    		var pwdhidden = $("<input type='text'/>");
    		$(this).after(pwdhidden);
	    	$(this).keyup(function(e){
	    		var pwd = $(this).val();
	    		var rep = "";
	    		pwdhidden.val(pwd);
	    		for(var i=0;i<pwd.length;i++){
	    			rep += "✱";
	    		}
	    		$(this).val(rep);
	    	});
    	}
    	var funcObj={
    		"getValue":function(){return vals;}
    	};
    	if(funcObj[arg] && $.isFunction(funcObj[arg])){
    		return funcObj[arg].call(this);
    	}
    	
    }
    $.fn.click=function(func){
    	this.each(function(){
	    	if(this.attachEvent){
		    	this.attachEvent( "onclick", function(e) {
		    		var skip=$(this).attr("skipSsoValid");
	    			if(skip==null){
	    				skip = false;
	    			}
		    		if(skip==false && isSessionInvalidate()){
		    			top.openLoginPanel();
		    		}else{
			    		if(func!=null){
			    			if(func.call(this,e) == false){
			    				e.stopPropagation();
			    				return false;
			    			};
			    		}
		    		}
				});
	    	}
	    	if(this.addEventListener){
	    		this.addEventListener("click",function(e){
	    			var skip=$(this).attr("skipSsoValid");
	    			if(skip==null){
	    				skip = false;
	    			}
	    			if(skip==false && isSessionInvalidate()){
	    				top.openLoginPanel();
		    		}else{
		    			if(func!=null){
			    			if( func.call(this,e) == false){
			    				e.stopPropagation();
			    				return false;
			    			};
			    		}
		    		}
	    		});
	    	}
    	});
    	
    	function isSessionInvalidate(){
    		var ps = location.pathname.split("/");
    		var ctxPath = "/";
    		if(ps.length>1){
    			ctxPath = "/"+ps[1];
    		}
    		var rtn = false;
    		//判断
    		var param = {service:"SSO",method:"isSessionInvalidate",arguments:"[]"};
			jQuery.ajax({				
				type: 		"POST",
				url:  		ctxPath+"/json?debug=false",
				data: 		param,
				dataType: 	"json",
				async: 		false,
				success: 	function(data){
					rtn = data.value;
				},							
				error: function(request){
				}
			});
			return rtn;
    	}
    };
}(jQuery));
$(function(){
	init();
	function init(){
		$(".form_date").datetimepicker({
			format: 'yyyy-mm-dd', 
			language:  'zh-CN',
			autoclose: true,
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			//todayHighlight: 1,
			//startView: 2,
			minView: 2,
			forceParse: 0	
		});
		$(".calendar").click(function(){
			$(this).parent().find(".form_date").datetimepicker("show");
		});
	}
	$.fn.initDatetimepicker=function(){
		init();
	}
});