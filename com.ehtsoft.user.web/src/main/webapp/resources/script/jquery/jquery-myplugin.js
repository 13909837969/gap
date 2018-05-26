$(function(){
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
	$.fn.unselect=function(selector){
		/*
		if(document.selection){//IE,Opera
			if(document.selection.empty){//IE
				document.selection.empty();
			}else{//Opera
				document.selection = null;
			}
		}else if(window.getSelection){//FF,Safari
			window.getSelection().removeAllRanges();
		}
		*/
		$(selector).attr('unselectable','on') 
		.css({'-moz-user-select':'-moz-none', 
		'-moz-user-select':'none', 
		'-o-user-select':'none', 
		'-khtml-user-select':'none', /* you could also put this in a class */ 
		'-webkit-user-select':'none',/* and add the CSS class here instead */ 
		'-ms-user-select':'none', 
		'user-select':'none' 
		}).bind('selectstart', function(){ return false; }); 
		$(document).attr('unselectable','on') 
		.css({'-moz-user-select':'-moz-none', 
		'-moz-user-select':'none', 
		'-o-user-select':'none', 
		'-khtml-user-select':'none', /* you could also put this in a class */ 
		'-webkit-user-select':'none',/* and add the CSS class here instead */ 
		'-ms-user-select':'none', 
		'user-select':'none' 
		}).bind('selectstart', function(){ return false; }); 
	};
	$.fn.dropAndDrag=function(opt){
		var def = {selector:null,
				   start:function(e){},//开始拖
				   drag:function(e){},//拖
				   drop:function(e){}, //放
				   accept:null,
				   clone:false,
				   zeroDrag:true // top left 小于 0 时，可以拖动
		};
		if(opt==undefined){
			opt={};
		}
		opt = $.extend(def,opt);
		if(opt.accept!=null){
			opt.clone = true;
		}
		var target = $(this);
		opt.self = target;
		var hander = opt.selector?$(opt.selector):$(this);
		hander.unbind("mousedown").bind("mousedown",function(down){
			var targetClone = target.clone();
			targetClone.hide();
			if(opt.clone==true){
				targetClone.css({"position":"fixed"});
				$(document.body).append(targetClone);
				targetClone.hide();
			}
			if(opt.start){
				opt.start(down);
			}
			target.unselect($(this));
			$(this).css("cursor","move");
			var offx = down.clientX-target.position().left;
			var offy = down.clientY-target.position().top;
			var h = $(this);
			setTimeout(function(){h.attr("down","true");},14);
			$(document.body).unbind("mousemove").bind("mousemove",function(m){
				if(h.attr("down")=="true"){
					if(opt.drag)
						opt.drag(m);
					target.css("position","fixed");
					var y = m.clientY-offy;
					var x = m.clientX-offx;
					if(opt.zeroDrag==false){
						if(y<=0){
							y=0;
						}
						if(x<= -h.width()+20){
							x=-h.width()+20;
						}
					}
					if(opt.clone){
						setTimeout(function(){
							targetClone.show();
						},80);
						targetClone.css({top:m.clientY + 10,left:m.clientX});
					}else{
						target.css({top:y,left:x});
					}
				}
			});
			try{
			$("iframe").contents().unbind("mousemove").bind("mousemove",function(m){
				if(h.attr("down")=="true"){
					if(opt.drag)
						opt.drag(m);
					target.css("position","fixed");
					var y = m.clientY-offy;
					var x = m.clientX-offx;
					if(opt.zeroDrag==false){
						if(y<=0){
							y=0;
						}
						if(x<= -h.width()+20){
							x=-h.width()+20;
						}
					}
					if(opt.clone){
						setTimeout(function(){
							targetClone.show();
						},80);
						targetClone.css({top:m.clientY + 10,left:m.clientX});
					}else{
						target.css({top:y,left:x});
					}
				}
			});
			$("iframe").contents().unbind("mouseup").bind("mouseup",function(e){
				$("iframe").contents().unbind("mouseup");
			});
			}catch(e){}
			$(document.body).unbind("mouseup").bind("mouseup",function(e){
				h.removeAttr("down");
				if(opt.drop){
					if(opt.accept==null){
						opt.drop(e);
					}else{
						if($(e.target).is(opt.accept)){
							if(opt.drop(e)==undefined || opt.drop(e)==true){
								targetClone.remove();
							}else{
								targetClone.animate({left:target.offset().left,top:target.offset().top},{duration:200,complete:function(){
									targetClone.remove();
								}});
							}
						}else{
							if(opt.clone){
								targetClone.animate({left:target.offset().left,top:target.offset().top},{duration:200,complete:function(){
									targetClone.remove();
								}});
							}
						}
					}
				}
				targetClone.animate({left:target.offset().left,top:target.offset().top},{duration:200,complete:function(){
					targetClone.remove();
				}});
				h.css("cursor","auto");
				$(e.target).unbind("mouseup");
				$(this).unbind("mouseup");
				$(this).unbind("mousemove");
				$(this).unbind("selectstart");
				$("iframe").contents().unbind("mousemove");
			});
		});
		
	};
});
$(function($){
	$.fn.showClose=function(func){
		$(this).parent().css({"position":"relative"});
		$(this).mouseenter(function(){
			var _self = $(this);
			_self.func = func;
			var div = $("<div></div>");	
			var closeDiv = $("<div class='open-close-button'></div>");
			var w = $(this).outerWidth(true);
			var h = $(this).outerHeight(true);
			var l = $(this).position().left;
			var t = $(this).position().top;
			div.css({"position":"absolute",
			    "left":(l +"px"),
			    "top": (t +"px"),
			    "background" : "#aaa",
			    "filter":"alpha(opacity=50)",
			    "-moz-opacity":0.5,
			    "opacity":0.5
			    });
			var ol = $(this).offset().left;
			closeDiv.css({
				"left":(w-15)+"px",
			    "top": ("-10px")});
			div.width(w);
			div.height(h);
			$(this).after(div);
			div.append(closeDiv);
			closeDiv.mouseenter(function(){
				return false;
			})
			div.mouseout(function(){
				div.remove();
			});
			closeDiv.click(function(){
				if(_self.func!=null){
					_self.func();
				}
			});
		});
		
	}
});