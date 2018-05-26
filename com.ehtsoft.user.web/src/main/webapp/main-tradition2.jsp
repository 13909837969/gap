<%@page import="com.ehtsoft.fw.utils.NumberUtil"%>
<%@page import="com.ehtsoft.fw.core.sso.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>内蒙古公共法律服务智能化一体平台</title>
    <jsp:include page="module/ltrhao-common.jsp"></jsp:include>
	<link rel="stylesheet" href="${localCtx}/resources/main-bootstrap.css">
	<script type="text/javascript" src="${localCtx}/json/MenuService.js"></script>
	<script type="text/javascript" src="${localCtx}/json/LoginService.js"></script>

	<style type="text/css">
	
	
	.cle{
	clear:both;
	}
	input:-webkit-autofill {
         -webkit-box-shadow: 0 0 0px 1000px white inset;
    }
	a:hover{
		text-decoration: none; 
	}
	#mainframe-body {
	    min-height: 100%;
	}
	.main-article {
	    padding: 0px;
	    float: left;
	    right: 0px;
	    left: 0px;
	    position: absolute;
	    min-height: 100%;
	}
	.main-article-content {
	    margin: 0px 0px;
	    position: absolute;
	    left: 0px;
	    right: 0px;
	    bottom: 0px;
	    top: 0px;
	}
	.main-header{
	  box-shadow: 0 1px 8px rgba(0, 0, 0, 0.3);
	}
	.mainframe-navbar{
		padding-bottom:1px;
	}
	/*
	.nav>li:hover>.dropdown-menu{
		display: block;
	}
	*/
	.dropdown-submenu>.dropdown-menu {
	     top: 0;
	     left: 100%;
	     margin-top: -6px;
	     margin-left: -1px;
	     -webkit-border-radius: 0 6px 6px 6px;
	     -moz-border-radius: 0 6px 6px;
	     border-radius: 0 6px 6px 6px;
	 }
	.ltrhao-main-func{
		cursor:default;
		padding: 8px 10px;
	}
	.ltrhao-main-func>span{
		color:#fff;
	}
	.ltrhao-main-func:hover{
		 background:#1089c1;
		 /*background-color: #4f5b6f;*/
	}
	.func_menu_icon{
		width:30px;
	 	height:30px;
	 	display: block;
	 	background-size: 30px 30px;
	 	background-repeat: no-repeat;
	 	background-position: center;
	}
	.toolbar_icon{
		width:34px;
	 	height:50px;
	 	display: block;
	 	background-size: 24px 24px;
	 	background-repeat: no-repeat;
	 	background-position: center;
	}
	.func_menu_close_icon{
		width:16px;
	 	height:16px;
	 	display: none;
	 	background-size: 16px 16px;
	 	background-repeat: no-repeat;
	 	background-position: center;
		background-image:url(resources/images/cool/icon/icon-minus.png);
		position: absolute;
		top:4px;
		right:8px;
		cursor: pointer;
	}
	.func_menu_add_icon{
		width:16px;
	 	height:16px;
	 	display: none;
	 	background-size: 16px 16px;
	 	background-repeat: no-repeat;
	 	background-position: center;
		background-image:url(resources/images/cool/icon/icon_add_green.png);
		position: absolute;
		top:4px;
		right:8px;
		cursor: pointer;
	}
	.func_menu_icon_sub{
		width:24px;
	 	height:24px;
	 	display: block;
	 	background-size: 24px 24px;
	 	background-repeat: no-repeat;
	 	background-position: center;
	 	margin-right:4px;
	}
	.func_menu_icon_72x72{
		width:64px;
	 	height:64px;
	 	display: block;
	 	background-size: 64px 64px;
	 	background-repeat: no-repeat;
	 	background-position: center;
	}
	.func_selected{
		position:absolute;
		display:block;
		width:20px;
		height:20px;
		border-radius:50%;
		background-size:20px 20px;
		top:0px;
		right:0px;
	}
	.duihao_white{
		background-image:url(resources/images/cool/icon/icon_duihao.png);
	}
	.duihao_green{
		background-image:url(resources/images/cool/icon/icon_duihao_green.png);
	}
	.remind{
		background-image:url(resources/images/cool/main/remind.png);
	}
	.headerimg{
		background-image:url(resources/images/cool/main/header.png);
	}
	/*更多功能*/
	.func_more{
		width:25px;
		height:30px;
		transition: All 0.6s ease-in-out;
	    -webkit-transition: All 0.6s ease-in-out;
	    -moz-transition: All 0.6s ease-in-out;
	    -o-transition: All 0.6s ease-in-out;
	}
	/*跟多旋转动画*/
	.func_more_anmi{
	     transform: rotate(90deg);
	    -webkit-transform: rotate(90deg);
	    -moz-transform: rotate(90deg);
	    -o-transform: rotate(90deg);
	    -ms-transform: rotate(90deg);
	}
	/*弹出的右侧更多菜单面板*/
	.func_menu_right-panel {
		background: #fff;
		border: 1px solid #aaa;
		position: absolute;
		top: 0px;
		right: 0px;
		bottom: 0px;
		display: none;
		box-shadow: 0px 0px 10px #888888;
		z-index: 100;
		overflow-y: auto;
		overflow-x: hidden;
		width:0px;
	}
	/*授权情况清单*/
	.ltrhao-main-func-qd{
		border-radius:5px;
		position:relative;
		margin:5px;
		background:#43a047;
		min-width:140px;
		padding:10px 10px;
		color:#fff;
		cursor: default;
	}
	/* 授权清单第二个span样式 */
	.ltrhao-main-func-qd span:nth-child(2){
		margin-left:4px;
	}
	/*清单中的图标*/
	.ltrhao-main-func-qd .qd-icon{
	 	display: inline-block;
	 	vertical-align: middle;
	}
	.overlay{
		display: none;
		position: absolute;
		top:0;
		background: #424141;
		left:0px;right:0px;
		bottom:0px;
		opacity:0.55;
		filter:Alpha(opacity=55);
		box-shadow: 0px 0px 10px #333;
	}
	.overlay-cmd{
		position: absolute;
		top:0;
		left:0px;right:0px;
		bottom:0px;
		display: none;
		color:#fff;
		padding-top:8px;
	}
	.overlay-cmd button{
		background-color: #f00;
	}
	/*
	.ltrhao-main-func-qd:hover .overlay{
		display:block;
	}
	.ltrhao-main-func-qd:hover .overlay-cmd{
		display:block;
	}
	*/
	
	
	
	.ltrhao-main-func-all{
		position:relative;
		background:#175eec;
		border-radius:5px;
	}
	
	/* 全部功能清单查询样式 */
	.form-control{
		width:50%;
		height:50px;
		border-radius:50px;
		border:1px solid #ccc;
	}
	
	#input-group-gbcolor{
		width: 80px;
		height: 40px;
    	background-color: #175eec;
    	position: absolute;
    	right: 0px;
		border-radius:0px 50px 50px 0px;
		z-index:99998;
	}
	#input-group-img{
		background: transparent;
	    width: 20px;
	    height: 20px;
	    border-radius: 50%;
	    /* background-color: #f00; */
	    border: 4px solid #fff;
	    position: absolute;
	    top: 0px;
	    z-index: 99999;
	}
	#input-group-images{
		width: 14px;
	    height: 4px;
	    border: 0px;
	    background: #fff;
	    border-radius:5px;
	    transform: rotate(45deg);
	    position: absolute;
	    top: 18px;
	    left: 32px;
	}
	#input-group-gbcolor-cent{
		width: 35px;
	    height: 35px;
	    position: absolute;
	    text-align: center;
	    padding-left: 5px;
	    top:10px;
	}
	
	#text-center-text{
		font-size: 20px;
	    text-align: center;
	    width: 100%;
	    float: left;
	    color: #686868;
	    padding-bottom:20px;
	}
	#text-center-text2{
		font-size: 20px;
	    text-align: center;
	    width: 100%;
	    float: left;
	    color: #686868;
	    padding-bottom:20px;
	    padding-top:40px;
		
	}
	
	
	
	
	.overlay-add{
		background-image:url("resources/images/cool/icon/icon_add.png");
		background-size: 30px 30px;
		background-repeat: no-repeat;
		background-position: center;
	}
	.ltrhao_func_edit{
		margin-right:20px;
		padding:4px;
		cursor:pointer;
	}
	.ltrhao_func_edit>img{
		width:20px;
		height:20px;
		margin-right:4px;
	}
	.ltrhao_func_edit:hover{
		background: #ddd;
	}
	.dropdown-menu li{
		padding:5px;
		cursor: default;
	}
	.dropdown-menu li:hover{
		background: #aaa;
	}
	.dropdown-submenu>table .menu-label:after {
	    display: block;
	    content: " ";
	    float: right;
	    width: 0;
	    height: 0;
	    border-color: transparent;
	    border-style: solid;
	    border-width: 5px 0 5px 5px;
	    border-left-color: #ccc;
	    margin-top: 5px;
	    margin-right: -10px;
	}
	.navbar-default .navbar-nav > .active {
	  color: #61a0a8;
	  background-color: #4f5b6f;
	}
	.navbar-brand{
	width:480px;
	height:66px;
	}
	.func-edit-anmi {
		animation: shake 0.22s  infinite;
		
		backface-visibility: hidden;
		perspective: 1000px;
	}
	@keyframes shake {
		10%{transform: rotate(1deg);}
		20%{transform: rotate(2deg);}
		30%{transform: rotate(3deg);}
		40%{transform: rotate(2deg);}
		50%{transform: rotate(1deg);}
		60%{transform: rotate(0deg);}
		70%{transform: rotate(-1deg);}
		80%{transform: rotate(-2deg);}
		90%{transform: rotate(-1deg);}
		100%{transform: rotate(0deg);}
		/*
		10%{transform: rotate(0.5deg);}
		20%{transform: rotate(1deg);}
		30%{transform: rotate(1.5deg);}
		40%{transform: rotate(1deg);}
		50%{transform: rotate(0.5deg);}
		60%{transform: rotate(0deg);}
		70%{transform: rotate(-0.5deg);}
		80%{transform: rotate(-1deg);}
		90%{transform: rotate(-0.5deg);}
		100%{transform: rotate(0deg);}
		*/
	}
	#main-tooltips-header{
		position:fixed;color:#fff;
		min-height:100px;
		background:#2a3940;
		min-width:200px;
		display:none;
		z-index:1000;
	}
	#main-tooltips-header .tooltip-item{
	 	padding: 8px;
	 	text-align: left;
	}
	#main-tooltips-header .tooltip-item:nth-child(1){
		background: #455258;
	}
	#main-tooltips-header .opitem:hover{
		color:#a2ea60;
	}
	#main-tooltips-header .exit-btn:hover{
		color:#fff;
		border:1px solid #aaa;
	}
	.tooltip-item .item-icon{
		width:20px;
		height:20px;
		background-size: 20px 20px;
		background-position: center;
		margin-right:6px;
		vertical-align: bottom;
		display: inline-block;
	}
	.tooltip-item .notreadmsg{
		background-image: url(resources/images/cool/icon/icon_msg.png);
	}
	.tooltip-item .mdypsw{
		background-image: url(resources/images/cool/icon/icon_mdypsw.png);
	}
	.navbar{
	border:0px;
	}
	.nav-logo-txet{
		
	}
	.nav-logo-txet-mw span{
		transform:rotate(90deg);
		float:left;
		font-size:16px;
	}
	.nav-logo-txet-mw{
		float:left;
	}
	/*修改 复选框样式*/	
	.checkbox {
		width: 20px;
		height: 20px;
		background: url(checkbox.png) no-repeat;
		display: block;
		float: left;
		margin: 0 !important;
		}
	</style>
	<script type="text/javascript">
    	$(function(){
    		window.onpopstate = function(event) {
    			  alert("location: " + document.location + ", state: " + JSON.stringify(event.state));
    			};
    		init();
    		var ms = new MenuService();
    		//获取快捷方式（订阅的功能-主菜单内容）
    		ms.findShortcut(true,new Eht.Responder({success:function(menus){
    			 mainShortcut(menus);
    		}}));
    		//获取已经授权的功能菜单和申请的功能菜单（排除快捷方式）
    		ms.findMenuSetting(new Eht.Responder({
    			success:function(menus){
			 	 mainFuncQd(menus);
				}
    		}));
    		//全部功能（PSA/OSA） PSA 系统管理员
    		ms.findAllMenus({},new Eht.Responder({
    			success:function(menus){
    				allmenus(menus);
    			}
    		}))
    		var formpsw = new Eht.Form({selector:"#form-modify-psw",
    									colLabel:"col-sm-3",
    									colCombo:"col-sm-9",    				
						    			autolayout:true,
						    			smallForm:true});
    		//修改密码
    		$("#mainsavepswbtn").click(function(){
    			var data = formpsw.getData();
    		    if(data.xmm!=data.xmmqr){
    		        $("#errortips").html("新密码与新密码确认不相同，请重新输入");
    		        return;
    		    }
    		    if(formpsw.validate()){
    		    	var ls = new LoginService();
    				ls.modifyPsw(data.dqmm,data.xmm,
    						new Eht.Responder({success:function(d){
    							new Eht.Tips().show();
    							$('#window-password-panel').modal('hide');
    						},
    						error:function(request, textStatus, error){
    							$("#errortips").html(request.responseText);
    						}
    					}));
    		    }
    		});
    		//清空表单
    		$("#window-password-panel").on("hide.bs.modal",function(e){
    			formpsw.clear();
    			$("#errortips").hide();
    		});
    		$("#mainsystem-exit-btn").click(function(){
    			var ls = new LoginService();
    			ls.logout(new Eht.Responder({success:function(data){
    				window.top.location.href = data.value;
    			}}));
    		});
    		//功能编辑事件
    		$("#ltrhao_func_edit").click(function(){
    			var fm = $("#mainframe-body .navbar-nav li");
    			var qd = $("#mainframe-body .ltrhao-main-func-qd");
    			if(fm.hasClass("func-edit-anmi")){
    				//关闭编辑动画
	    			fm.removeClass("func-edit-anmi");
	    			fm.find(".func_menu_close_icon").hide();
	    			$(this).find("span").html("编辑");
	    			qd.removeClass("func-edit-anmi");
	    			qd.find(".func_menu_add_icon").hide();
	    			qd.find(".func_selected").show();
    			}else{
	    			//启动编辑动画
	    			fm.addClass("func-edit-anmi");
	    			fm.find(".func_menu_close_icon").show();
	    			$(this).find("span").html("关闭");
	    			qd.addClass("func-edit-anmi");
	    			qd.find(".func_menu_add_icon").show();
	    			qd.find(".func_selected").hide();
    			}
    		});
    		//头像 提醒 部分按钮
			$("#main-remind-header").hover(function(){
				$("#main-tooltips-header").css({"right":"0px","top":$("#mainframe-body #main-header").outerHeight(true)}).show();
			},function(){
				$("#main-tooltips-header").hide();
			});
			//更多功能按钮事件
			$("#mainframe-body .func_more").click(function(){
				if(!$(this).hasClass("func_more_anmi")){
					showMoreFunc($(this));
				}else{
					hideMoreFunc($(this));
				}
			});
			var menuli = $('<li>' +
				    '<div class="ltrhao-main-func text-center" class="dropdown-toggle" data-toggle="dropdown">' +
        		      '<span class="center-block func_menu_icon"></span>' +
        		      '<span class="center-block menu-label"></span>' +
        		      '<span class="func_menu_close_icon"></span>' +
        		    '</div>' +
        		   '</li>');
			
			function mainFuncQd(menus){
				for(var i=0;i<menus.length;i++){
					addFuncQdItem(menus[i],false,true);
				}
			}
			function mainShortcut(menus){
				for(var i=0;i<menus.length;i++){
					addShortcutMenu(menus[i]);
        		}
			};
			function getFuncQdParentCol(target){
				if(target.parent().hasClass("col-sm-2")){
					return target.parent();
				}
				return getFuncQdParentCol(target.parent());
			}
			var li_length;
			//添加功能清单（授权应用清单） 功能
			function addFuncQdItem(menu,anim,selected){
				var col = $('<div class="col-sm-2 center-block" style="text-align:center;"></div>');
				var qdItem = $('<div class="ltrhao-main-func-qd">'+
									'<span class="func_menu_icon qd-icon"></span>'+
					       			'<span>'+menu.menuname+'</span>'+
					       			'<span class="func_selected duihao_white"></span>'+
					       			'<span class="func_menu_add_icon"></span>'+
					       			'<span class="func_menu_close_icon"></span>'+
									'<div class="overlay"></div>'+
									'<div class="overlay-cmd text-center">'+
										'<div class="tooltitle">需要管理授权</div>'+ //需要管理授权
										'<button class="cmddel">删除</button>'+
										'<div class="tooltxt">永久</div>' +
									'</div>'+
								'</div>');
				col.append(qdItem);
				qdItem.attr("id","qd"+menu.sysid);
				qdItem.data(menu);
				if(selected==true){
					if(menu.delable=="1"){
						qdItem.find(".func_selected").hide();
					}else{
						qdItem.find(".func_selected").show();
					}
				}else{
					qdItem.find(".func_selected").hide();
				}
				if(anim==true){
					qdItem.addClass("func-edit-anmi");
					qdItem.find(".func_menu_add_icon").show();
					qdItem.find(".func_selected").hide();
				}
				qdItem.find(".func_menu_add_icon").data(menu);
				$("#ltrhao-main-func-qd-container").append(col);
				if(menu.icon!=null){
					qdItem.find(".func_menu_icon").addClass(menu.icon);
				}else{
					qdItem.find(".func_menu_icon").addClass("menu_img");
				}
				//鼠标在功能上的时候
				qdItem.hover(function(){
					$(this).find(".cmddel").hide();
					$(this).find(".tooltxt").hide();
					if(!$(this).hasClass("func-edit-anmi")){
						if($(this).data().delable=="1"){
							$(this).find(".overlay").show();
							$(this).find(".overlay-cmd").show();
							$(this).find(".cmddel").show();
						}
					}
				},function(){
					$(this).find(".overlay").hide();
					$(this).find(".overlay-cmd").hide();
				});
				//点击授权功能清单删除按钮
				qdItem.find(".cmddel").click(function(){
					var item = $(this).parent().parent(); 
					var d = item.data();
					var f = $("#all"+d.sysid);
					var os = f.offset();
					ms.removeSub(d,new Eht.Responder({success:function(){
						item.css("position","fixed").animate({left:os.left,top:os.top,width:50,
							height:50,"min-width":0,opacity:0.05},function(){
							$(this).parent().animate({width:0},140,function(){
								$(this).remove();
							});
							f.find(".func_selected").removeClass("duihao_green");
						});
					}}));
				});
				//编辑的时候，点击清单下面的(+)按钮，添加到主的 shortcut 菜单
				qdItem.find(".func_menu_add_icon").click(function(){
					var it =  $(this);
					var md = $(this).data();
					var col = getFuncQdParentCol($(this));
					var nav = $("#mainframe-body .navbar-nav");
					var navli = nav.children("li");
					var l = nav.position().left;
					var t = nav.position().top;
					
					/* 获取到要移除的菜单的信息  */
					//alert(navli.size() + "+++++++++++++++"); //处理 li的个数 问题 个数 <= 7
					/* if (navli.size() >= 8) {
						 li_length = navli.eq(navli.size()-1);
						 li_length.remove(); */
						 /* var qdcs = $("#ltrhao-main-func-qd-container");
							var l = 160;
							var t = 155;
							var cs=qdcs.children();
							if(cs.size()>0){
								var c = cs.eq(cs.size()-1);
								l = c.offset().left+c.outerWidth(true);
								t = c.offset().top;
							}
							debugger;
							 m = li_length[0];
							//var vli = $(this).parent().parent();
							var vli = li_length.parent().parent();
							vli.removeClass("func-edit-anmi");
							vli.css({"width":"76px","display":"block","border": "1px solid transparent"});
							var item = li_length.parent();//$(this);
							ms.removeShortcut(m,new Eht.Responder({
								success:function(){
									item.parent().css({position:"fixed","z-index":150})
									 .animate({width:140,height:60,left:l,top:t,opacity:0.1},function(){
										addFuncQdItem(m,true,true);
										li_length[0].parent().parent().css("opacity",0).animate({width:0},300,function(){
											li_length[0].parent().remove()
										});
									});
								}
							}));
							return false; */
					//	}
					
					if(navli.size()>0){
						var li = navli.eq(navli.size()-1);
						var p = li.position();
						l = p.left + li.outerWidth(true);
						t = p.top
					}
					//添加到 shortcut 中
					ms.insertShortcut(md,new Eht.Responder({success:function(){
						it.parent().css("position","fixed").animate({
							opacity:0.07,
							width:70,
							height:60,
							top:t,
							left:l
							},
							function(){
							  addShortcutMenu(md,true);
							  col.animate({width:0},140,function(){
								  $(this).remove();
							  });
						    });
					}}));
				});
			}
			//生成（添加）主页面功能快捷菜单
			var li ;
			function addShortcutMenu(menu,anim){ //
				li = $('<li>' +
					    '<div class="ltrhao-main-func text-center" class="dropdown-toggle" data-toggle="dropdown">' +
	        		      '<span class="center-block func_menu_icon"></span>' +
	        		      '<span class="center-block">'+menu.menuname+'</span>' +
	        		      '<span class="func_menu_close_icon"></span>' +
	        		    '</div>' +
	        		   '</li>');
				if(anim==true){
					li.addClass("func-edit-anmi");
					li.find(".func_menu_close_icon").show();
				}
				li.attr("url",menu.url);
				li.data(menu);
				li.find(".func_menu_close_icon").data(menu);
				li.attr("id",menu.sysid);
				$("#mainframe-body .navbar-nav").append(li);
				if(menu.icon!=null){
					li.find(".func_menu_icon").addClass(menu.icon);
				}else{
					li.find(".func_menu_icon").addClass("menu_img");
				}
				/* if(i==0){
					li.addClass("active");
					$("#mainiframe").attr("src",li.data().url);
				} */
				submenuItem(menu.children,li);
				
				li.hover(function(){
					if(!$(this).hasClass("func-edit-anmi")){
						//打开二级菜单
						$(this).addClass("open");
					}
				},function(){
					//关闭二级菜单
					$(this).removeClass("open");
				});
				li.click(function(){
					var _menucode = $(this).data().menucode;
					if(_menucode == "JC99"){
						$("#main_popopen_menu_func").modal();
						var url = $(this).data().url;
						$("#main_popopen_menu_func_ifr").attr("src",url);
						return;
					}
					if(!$(this).hasClass("func-edit-anmi")){
						hideMoreFunc($("#mainframe-body .func_more"));
						$("#mainframe-body .navbar-nav").find("li").removeClass("active");
						$(this).addClass("active");
						//////=======
        				////$("#main-article-content").empty(); //情况之前的内容，切换到现在的内容
        				$("#main-article-content iframe").hide();
        				var iframe = $('<iframe frameborder="0" style="width:100%;height:100%;margin:0px;border:0px;padding:0px;"></iframe>');
        				var menuid = "mu_"+$(this).data().sysid;
        				iframe.attr("id",menuid);
        				var url = $(this).data().url;
        				if(url!=null){
        					if($("#mainframe-body .func_more").hasClass("func_more_anmi")){
	        					//菜单点击事件，打开url功能，关闭右侧更多功能菜单并恢复菜单图标动画
	        					$("#mainframe-body .func_more").removeClass("func_more_anmi");
	        					$('#mainframe-body #right-menu_panel').animate({
	        						width : 0
	        					},function() {
	        						$(this).hide();
	        						if(url.search("load=load")>0){
			        				}else{
			        					if($("#"+menuid).size()==0){
			        						$("#main-article-content").append(iframe);
			        						iframe.attr("src",url);
			        						iframe.show();
			        					}else{
			        						$("#"+menuid).show();
			        					}
			        					if("JC04"==_menucode){
			        						iframe.attr("src",url);
			        					}
			        				}
	        					});
        					}else{
        						if(url.search("load=load")>0){
		        				}else{
		        					if($("#"+menuid).size()==0){
			        					$("#main-article-content").append(iframe);
			        					iframe.attr("src",url);
			        					iframe.show();
		        					}else{
		        						$("#"+menuid).show();
		        					}
		        					if("JC04"==_menucode){
		        						iframe.attr("src",url);
		        					}
		        				}
        					}
        				}
	        				
					}
				});
				//点击关闭图标【 - 号 】（编辑的时候）
				li.find(".func_menu_close_icon").click(function(){
					var qdcs = $("#ltrhao-main-func-qd-container");
					var l = 160;
					var t = 155;
					var cs=qdcs.children();
					if(cs.size()>0){
						var c = cs.eq(cs.size()-1);
						l = c.offset().left+c.outerWidth(true);
						t = c.offset().top;
					}
					var m = $(this).data();
					var vli = $(this).parent().parent();
					vli.removeClass("func-edit-anmi");
					vli.css({"width":"76px","display":"block","border": "1px solid transparent"});
					var item = $(this);
					ms.removeShortcut(m,new Eht.Responder({
						success:function(){
							item.parent().css({position:"fixed","z-index":150})
							 .animate({width:140,height:60,left:l,top:t,opacity:0.1},function(){
								addFuncQdItem(m,true,true);
								$(this).parent().css("opacity",0).animate({width:0},300,function(){
									$(this).remove()
								});
							});
						}
					}));
					return false;
				});
			}
			//添加二级，三级菜单（递归算法）
    		function submenuItem(children,li){
    			if(children!=null){
    				var submenu = $('<ul class="dropdown-menu"></ul>');
    				for(var j=0;j<children.length;j++){
    					var mItem = children[j];
	        			var subli = $('<li><table><tr><td><span class="func_menu_icon_sub menu_img"></span></td><td class="menu-label">'+mItem.menuname+'</td></tr></li>');
	        			submenu.append(subli);
	        			subli.data(mItem);
	        			subli.click(function(){
	        				//$("#main-article-content").empty(); //情况之前的内容，切换到现在的内容
	        				$("#main-article-content iframe").hide();
	        				var iframe = $('<iframe frameborder="0" style="width:100%;height:100%;margin:0px;border:0px;padding:0px;"></iframe>');
	        				var menuid = "mu_"+$(this).data().sysid;
	        				iframe.attr("id",menuid);
	        				var url = $(this).data().url;
	        				if(url!=null){
	        					if($("#mainframe-body .func_more").hasClass("func_more_anmi")){
		        					//菜单点击事件，打开url功能，关闭右侧更多功能菜单并恢复菜单图标动画
		        					$("#mainframe-body .func_more").removeClass("func_more_anmi");
		        					$('#mainframe-body #right-menu_panel').animate({
		        						width : 0
		        					},function() {
		        						$(this).hide();
		        						if(url.search("load=load")>0){
				        				}else{
				        					if($("#"+menuid).size()==0){
				        						$("#main-article-content").append(iframe);
				        						iframe.attr("src",url);
				        						iframe.show();
				        					}else{
				        						$("#"+menuid).show();
				        					}
				        				}
		        					});
	        					}else{
	        						if(url.search("load=load")>0){
			        				}else{
			        					if($("#"+menuid).size()==0){
				        					$("#main-article-content").append(iframe);
				        					iframe.attr("src",url);
				        					iframe.show();
			        					}else{
			        						$("#"+menuid).show();
			        					}
			        				}
	        					}
	        				}
	        				var fm = $("#mainframe-body .navbar-nav li").removeClass("open");
	        				return false;
	        			}); 
						if(mItem.children!=null && mItem.children.length>0){
							subli.addClass("dropdown-submenu");
							mItem.children.push({menuname:"工作总览",url:"module/sps/dasbord1.jsp"});
						}
	        			submenuItem(mItem.children,subli);
    				}
	        		li.append(submenu);
    			}
    		};
    		var addFlag = true;
    		//所有的功能菜单
    		function allmenus(menus){
    			if(menus!=null){
    				var row;
    				for(var i=0;i<menus.length;i++){
    					var div = $('<div class="col-sm-6">'+
								'<div class="media">'+
							      '<div class="media-left">'+
							      	'<div class="ltrhao-main-func-all">'+
							        	'<span class="func_menu_icon_72x72 qd-icon" style="transform:scale(0.8);"></span>'+
							        	'<span class="func_selected"></span>'+
							        	'<div class="overlay"></div>'+
							        	'<div class="overlay-cmd overlay-add">'+
										'</div>'+
							        '</div>'+
							      '</div>'+
							      '<div class="media-body">'+
							        '<h4 class="media-heading"><a>'+menus[i].menuname+' ('+menus[i].appname+')</a></h4>'+
							         (menus[i].remark?menus[i].remark:"") +
							      '</div>'+
							 '</div>'+
						 '</div>');
    					if(i%2==0){
		    				row = $('<div class="row" style="margin-bottom:8px;"></div>');
		    				$("#ltrhao_main_func_all_container").append(row);
    					}
    					row.append(div);
    					if(menus[i].icon!=null){
    						div.find(".func_menu_icon_72x72").addClass(menus[i].icon);    						
    					}else{
    						div.find(".func_menu_icon_72x72").addClass("menu_img");    			
    					}
    					if(menus[i].selected){
    						//添加选择的 对号
    						div.find(".func_selected").addClass("duihao_green");
    					}
    					div.find(".ltrhao-main-func-all").data(menus[i]);
    					div.find(".ltrhao-main-func-all").attr("id","all" + menus[i].sysid);
    					div.find(".ltrhao-main-func-all").hover(function(){
    						if(!$(this).find(".func_selected").hasClass("duihao_green")){ //有权限的（selected=true）不现实 “+” 号
    							$(this).find(".overlay").show();
    							$(this).find(".overlay-add").show();
    						}
    					},function(){
    						$(this).find(".overlay").hide();
    						$(this).find(".overlay-add").hide();
    					});
    					div.find(".overlay-cmd").data(menus[i]);
    					//点击加号的时候
    					div.find(".overlay-cmd").click(function(){
    						if(addFlag){
	    						//没有添加的时候，添加新功能
	    						if($("#qd"+$(this).data().sysid).size()==0){
		    						var qdcs = $("#ltrhao-main-func-qd-container");
		    						var l = 160;
		    						var t = 155;
		    						var cs=qdcs.children();
		    						if(cs.size()>0){
		    							var c = cs.eq(cs.size()-1);
		    							l = c.offset().left+c.outerWidth(true);
		    							t = c.offset().top;
		    						}
		    						var m = $(this).data();
		    						//$(this).css({"width":"76px","display":"block","border": "1px solid transparent"});
		    						var parent=$(this).parent();
		    						var clone = parent.clone().css({position:"fixed","z-index":150,left:parent.offset().left,top:parent.offset().top,width:80});
		    						ms.subscribe(m,new Eht.Responder({
		    							success:function(){
		    								$("#ltrhao_main_func_all_container").append(clone);
				    						clone.animate({width:140,height:60,left:l,top:t},function(){
				    							addFlag = true;
				    							m.delable = "1";
				    							addFuncQdItem(m,false,false);
				    							$(this).remove();
				    							parent.find(".func_selected").addClass("duihao_green");
				    						});
		    							}
		    						}));
	    						}
    						}
    						return false;
    					});
    				}
    			}
    		};
			function showMoreFunc(taget){
				taget.addClass("func_more_anmi");
				$('#mainframe-body #right-menu_panel').show().animate({
					width : "100%"
				});
			};
			function hideMoreFunc(taget){
				taget.removeClass("func_more_anmi");
				$('#mainframe-body #right-menu_panel').animate({
					width : 0
				},function() {
					$(this).hide()
				});
			}
			$(window).resize(function(){
        		init();
    		});
			function init(){
				var h = $(window).height()-$("#mainframe-body #main-header").height();
        		$("#mainframe-body #main-sidebar").css("min-height",h+"px");
        		$("#mainframe-body #main-article").css("min-height",h+"px");
			}
    	});
    </script>
  </head>
  <body>
	<%
	   User user = (User)request.getSession().getAttribute("CURRENT_USER_SESSION");
	   if(user==null){
		   out.println("<script type='text/javascript'>top.openLoginPanel();</script>");
	   }
	%>
  	<div id="mainframe-body" style="overflow:hidden;z-index:1;">
		<header id="main-header">
			<nav class="navbar navbar-default mainframe-navbar">  <!-- role="navigation" -->
			    <div class="col-sm-11" style="padding:0px;">
				    <div class="navbar-header main-navbar-default" style="width: 390px;">
				        <div class="navbar-brand" style="white-space:nowrap;padding:2px 3px; float:left;">
				        	<div style="margin-right:15px;">
						        <img src="${localCtx}/resources/images/cool/main/logo.png" style="width:70px;height:70px; float:left;margin-top: -8px;"/>
						        <div class="nav-logo-txet">
						        	<img src="${localCtx}/resources/images/cool/main/text_mw.png"/>
						        	<!-- <div class="nav-logo-txet-mw" style="float:left; height:37px;">
						        		<span>ᠦᠪᠦᠷ</span>
						        		<span>ᠮᠣᠩᠭᠤᠯ</span>
						        		<span> ᠤᠨ</span>
						        		<span>ᠤᠯᠠᠨ</span>
						        		<span>ᠨᠡᠢᠲᠡ</span>
						        		<span> ᠶᠢᠨ</span>
						        		<span>ᠬᠠᠤᠯᠢ</span>
						        		<span>ᠴᠠᠭᠠᠵᠠ</span>
						        		<span> ᠶᠢᠨ</span>
						        		<span>ᠦᠢᠯᠡᠴᠢᠯᠡᠭᠡ</span>
						        	</div> -->
						        	<span style="float:left;transform:rotate(0deg);height:25px;font-size:18px;margin:0px;padding:0px;">内蒙古公共法律服务智能化一体平台</span>
						        </div>
					        </div>
					       <!--  <div class="cle"></div> -->
				        </div>
				        <button type="button" class="navbar-toggle" data-toggle="collapse"
				                data-target="#example-navbar-collapse">
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				        </button>
				    </div>
				    <div class="collapse navbar-collapse" id="example-navbar-collapse">
				       <!-- 主要功能菜单（快捷菜单） -->
				       <ul class="nav navbar-nav" id="nav_ul">
				       </ul>
			   	    </div>
			   	</div>
		   	    <div class="col-sm-1 text-right">
		   	    	<table align="right">
			   	    	<tr>
				   	    	<td>
							    <div class="ltrhao-main-func text-center">
					           		<span class="center-block toolbar_icon menu_znfx"></span>
					           		<!-- <span class="center-block">预判分析</span>  -->
					           	</div>
				           	</td>
				           	<td>
				           	 <div id="main-remind-header" class="ltrhao-main-func text-center" style="position:relative;">
				           		<span class="center-block toolbar_icon headerimg"></span> <!-- toolbar_icon remind -->
				           		<i class="badge" style="position:absolute;top:6px;right:0px;background:#f00; padding:2px 5px;font-size:9px;">1</i>
				           		<!-- <span class="center-block">提醒</span> -->
				           		<div id="main-tooltips-header" style="top:65px;">
							    	<div class="tooltip-item">${CURRENT_USER_SESSION.orgname}&nbsp;&nbsp;${CURRENT_USER_SESSION.name}(${CURRENT_USER_SESSION.accountid})</div>
							    	<div class="tooltip-item opitem" data-toggle="modal" data-target="#window-password-panel"><span class="item-icon mdypsw"></span>修改密码</div>
							    	<div class="tooltip-item opitem"><span class="item-icon notreadmsg"></span>未读的消息<span style="background:#f00;" class="badge pull-right">1</span></div>
							    	<div class="tooltip-item text-right" style="text-align: right;"><div id="mainsystem-exit-btn" class="btn exit-btn">退出&nbsp;<span class="glyphicon glyphicon-paste"></span></div></div>
							    </div>
				           	</div>
				           	</td>
				           	<td>
					           	<div style="margin-left:20px;">
					           		<img src="resources/images/cool/main/more.png" class="func_more">
					           	</div>
				           	</td>
			           	</tr>
		           	</table>
          		</div>
			</nav>
		</header>
		<div class="main-content">
			  <!-- 主要内容区域 -->
			  <article class="main-article" id="main-article">
					<div class="main-article-content" style="overflow:hidden" id="main-article-content">
						<%
						String url = "/supervise/module/firstPage.htm";
						if(user!=null){
							if(NumberUtil.toInt(user.getOrgType())>=4){ 
								url = "/supervise/module/rep/viewsqjzSy.jsp";
							}else{
							    url = "/supervise/module/firstPage.htm";
							}
						}
						%>
						<iframe frameborder="0" style="width:100%;height:100%;margin:0px;border:0px;padding:0px;" src="<%=url %>"></iframe>
					</div>
					<div class="func_menu_right-panel container" id="right-menu_panel" style="background:#f1f1f1;">
						<div class="row">
							<span id="ltrhao_func_edit" class="pull-right ltrhao_func_edit" style="font-size:18px;"><img src="resources/images/cool/icon/icon_edit.png"><span>编辑</span></span>
							<div class="text-center"  >
								<div id="text-center-text">
									<span id="text-center-line1" class="col-md-5" style="background: #ccc; margin-top: 15px;height:1px;"></span>
									<span  id="text-center-title" class="col-md-2">授权应用清单</span>
									<span id="text-center-line2" class="col-md-5" style="background: #ccc; margin-top: 15px; height:1px;"></span>
								</div>
							</div>
						</div>
						<div class="row">
							<!-- 授权应用清单内容 -->
							<div class="container" id="ltrhao-main-func-qd-container" style="width:80%;">
							
							</div>
						</div>
						<div>
							<div id="text-center-text2">
								<span id="text-center-line3" class="col-md-5" style="background: #ccc; margin-top: 15px;height:1px;"></span>
								<span  id="text-center-title2" class="col-md-2">授权应用清单</span>
								<span id="text-center-line4" class="col-md-5" style="background: #ccc; margin-top: 15px; height:1px;"></span>
							</div>
							<!-- 查询框 -->
							<div class="input-group input-group-sm col-sm-6" style="margin:0 auto;padding-bottom:50px;">
							    <input type="text" class="form-control" placeholder="点击查询" aria-describedby="sizing-addon2" style="width:100%;font-size:18px;padding-left:30px;height:40px;border-radius:50px;"/>
							    <a href="#">
							    	<div id="input-group-gbcolor">
								        <div id="input-group-gbcolor-cent" style="top:7px;left:5px;">
									  	    <span id="input-group-img"></span>
									  	    <span id="input-group-images"></span>
								    	</div>
							        </div>
							   </a>
							</div>
						</div>
						
						<div class="row">
							<div class="container" id="ltrhao_main_func_all_container" style="width:80%;">
								
							</div>
						</div>
			 		</div>
			  </article>
		</div>
    </div>
    
    <div id="window-password-panel" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
	  <div class="modal-dialog" style="width:400px;" role="document">
	    <div class="modal-content" style="top:200px;">
	      	 <div class="modal-header">
		         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		         <h5 class="modal-title" id="myModalLabel">修改密码</h5>
		      </div>
		      <div class="modal-body">
		      	<div id="form-modify-psw">
		         <input type="password" name="dqmm" label="当前密码" valid="{required:true}" />
	 			 <input type="password" id="xmm" name="xmm" label="新密码"  valid="{required:true}" />
	 			 <input type="password" id="xmmqr" name="xmmqr" label="新密码确认"   valid="{required:true}"/>
	 			 </div>
	 			 <div id="errortips" style="color:#a94442" class="text-right"></div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
		        <button type="button" id="mainsavepswbtn" class="btn btn-primary btn-sm">确认</button>
		      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 辅助决策  \\\\\\ -->
	 <div id="main_popopen_menu_func" class="modal fade" tabindex="-1" role="dialog">
		 <div  class="modal-dialog" style="width:500px;" role="document">
		    <div class="modal-content" style="top:70px;">
		      	 <div class="modal-header">
			         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			         <h5 class="modal-title" id="myModalLabel">数据分析研判报告</h5>
			      </div>
			      <div class="modal-body" style="height:300px;padding:0px;">
			      	<div style="margin:20px;">
						<div style="margin-top:15px;">
							<h5>根据以下指标分析生成数据研判报告</h5>
							<div><input class="checkbox" type="checkbox" name="radio" id="tjr" value="1"><label style="padding-left: 5px;" for="tjr">全区第一季度各地区人民调解员数量统计</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_zsa" value="2"><label style="padding-left: 5px;"  for="aj_zsa">2018年第一季度全区人民调解案件类型数量统计</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tjb" value="3"><label  style="padding-left: 5px;" for="aj_tjb">2017年第一季度全区人民调解案件类型数量统计</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tblc" value="4"><label style="padding-left: 5px;"  for="aj_tblc">2018年第一季度人民调解案件类型数量统计同比增长率</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_zs" value="5"><label  style="padding-left: 5px;" for="aj_zs">全区第一季度纠纷案件数量走势</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tj" value="6"><label  style="padding-left: 5px;" for="aj_tj">全区第一季度各类案件纠纷统计</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tbl" value="7"><label style="padding-left: 5px;"  for="aj_tbl">全区第一季度各类案件同比增长率</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tblc1" value="8"><label style="padding-left: 5px;"  for="aj_tblc1">2018年第一季度各地区人民调解案件数量</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_zs1" value="9"><label style="padding-left: 5px;" for="aj_zs1">2017年第一季度各地区人民调解案件数量</label></div>
							<div><input class="checkbox" type="checkbox" name="radio" id="aj_tj1" value="10"><label  style="padding-left: 5px;" for="aj_tj1">2018年第一季度各地区人民调解案件数量同比增长率</label></div>
						</div>
					</div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary btn-sm linshi_prev">预览</button>
			        <button type="button" class="btn btn-primary btn-sm linshi_prev">生成</button>
			        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
			      </div>
			      	 <script>
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
						$(function(){
							$(".linshi_prev").click(function(){
								 $("#main_popopen_linshimodal").modal();
								    var check_val = "";
								     $('input:checkbox:checked').each(function(){
								    	 check_val +="," + $(this).val();
								     });
								     debugger;
								    if (check_val.search("2")>0 ||check_val.search("3") >0 || check_val.search("4")>0 ) {
								    	$("#linshimodal_frame").attr("src","/supervise/module/pdf/报告1.pdf");
									}else {
								    	$("#linshimodal_frame").attr("src","/supervise/module/pdf/2.pdf");
									}
								});
						});
					</script>
		    </div>
		  </div>
	  </div>
		<!-- 临时的 modal -->
		<div id="main_popopen_linshimodal" class="modal fade" tabindex="-1" role="dialog">
			<div  class="modal-dialog" style="width:900px;" role="document">
			    <div class="modal-content" style="top:70px;">
			      	 <div class="modal-header">
				         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				         <h5 class="modal-title" id="myModalLabel">数据分析研判报告</h5>
				      </div>
				      <div class="modal-body" style="height:600px;padding:0px;">
				      	<iframe id="linshimodal_frame" frameborder="0" style="width:100%;height:100%;margin:0px;padding:0px;"></iframe>
				      </div>
				      
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
				      </div>
			    </div>
			 </div>
	    </div>

	  <!-- \\\ 有问题，以后修改 -->
	</body>
</html>