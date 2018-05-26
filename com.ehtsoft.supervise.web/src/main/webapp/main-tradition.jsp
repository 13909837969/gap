<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>矫正人员综合管理系统</title>
    <jsp:include page="module/ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="${localCtx}/resources/main-bootstrap.css">
<script type="text/javascript" src="/user/json/MenuService.js"></script>
<style type="text/css">
#mainframe-body {
    min-height: 100%;
}
</style>
    <script type="text/javascript">
    	$(function(){
    		init();
    		
    		/* 主菜单（上面) */
			$(".navbar-nav>li").click(function(){
    			$(".navbar-nav>li").each(function(){
    				$(this).removeClass("active");
    			});
    			$(this).addClass("active");
    		});
			
    		var sidebar = $(".main-sidebar .sidebar-toggle");
    		sidebar.data({close:false,width:$(".main-sidebar").width()});
			var me = new MenuService();
			var navtab = new Eht.NavTabs({selector:"#nav_tabs"});
			var accordion = new Eht.BootAccordion({selector:"#mainframe-body #accordion"});

			accordion.addItem({menuname:"test1",url:"module/sqjz/listQuestion.jsp?load=load",sysid:"00001"});
			accordion.addItem({menuname:"test2",url:"module/sqjz/listBoundary.jsp?load=load",sysid:"00002"});
			accordion.addItem({menuname:"dasbord",url:"module/sps/dasbord.jsp",sysid:"00002",frame:true});
			accordion.clickItem(function(d){
				console.log(d);
				var fr = d.frame==true?true:false;
				navtab.addTab(d,d.url,{frame:fr});
			});
			/* 侧边框 toggle 按钮事件（关闭或打开侧边菜单） */
			$(".main-sidebar .sidebar-toggle").click(function(){
				var d = $(this).data();
				if(!d.close){
					$("#main-sidebar").width(40);
					$(".main-article").css("left",41);
					$("#sidebar-search").toggle();
					d.close=true;
					$(this).data(d);
					accordion.sideCollapse(true);
				}else{
					$("#main-sidebar").width(d.width);
					$(".main-article").css("left","");
					$("#sidebar-search").toggle();
					d.close=false;
					$(this).data(d);
					accordion.sideCollapse(false);
				}
			});
			$(window).resize(function(){
        		init();
    		});
			function init(){
				var h = $(window).height()-$("#main-header").height();
        		$("#main-sidebar").css("min-height",h+"px");
        		$("#main-article").css("min-height",h+"px");
			}
    	});
    </script>
  </head>
  <body>
  <div id="mainframe-body">
		<header id="main-header">
			<nav class="navbar navbar-default mainframe-navbar">  <!-- role="navigation" -->
				    <div class="container-fluid">
				    <div class="navbar-header main-navbar-default">
				        <button type="button" class="navbar-toggle" data-toggle="collapse"
				                data-target="#example-navbar-collapse">
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				        </button>
				        <a class="navbar-brand" href="#">内蒙古公共法律服务智能一体化平台</a>
				    </div>
				    <div class="collapse navbar-collapse" id="example-navbar-collapse">
				        <ul class="nav navbar-nav">
				            <li class="active"><a href="#">工作总揽</a></li>
				            <li><a href="#">社区矫正</a></li>
				            <li class="dropdown">
				                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
				                    Java <b class="caret"></b>
				                </a>
				                <ul class="dropdown-menu">
				                    <li><a href="#">jmeter</a></li>
				                    <li><a href="#">EJB</a></li>
				                    <li><a href="#">Jasper Report</a></li>
				                    <li class="divider"></li>
				                    <li class="dropdown-submenu">
				                    	<a href="#" tabindex="-1">分离的链接</a>
										<ul class="dropdown-menu">
						                    <li><a href="#">jmeter</a></li>
						                    <li><a href="#">EJB</a></li>
						                    <li><a href="#">Jasper Report</a></li>
						                    <li class="divider"></li>
						                    <li><a href="#">分离的链接</a></li>
						                    <li class="divider"></li>
						                    <li><a href="#">另一个分离的链接</a></li>
						                </ul>
				                    </li>
				                    <li class="divider"></li>
				                    <li><a href="#">另一个分离的链接</a></li>
				                </ul>
				            </li>
				            <li><a href="#">人民调解</a></li>
				            <li><a href="#">法律援助</a></li>
				            <li><a href="#">法制宣传</a></li>
				            <li><a href="#">法律服务</a></li>
				     </ul>
			    </div>
			    </div>
			</nav>
		</header>

		<div class="main-content">
				<!-- Left side column. contains the logo and sidebar -->
			  <aside class="main-sidebar" id="main-sidebar">
			    <!-- 边框菜单中的搜索及开关按钮 -->
			    <header>
				    <div class="input-group" id="sidebar-search">
						<input type="text" class="form-control query-control" placeholder="功能搜索">
						<span class="input-group-addon query-button"></span>
					</div>
					<a class="sidebar-toggle glyphicon glyphicon-th-list" data-target="#main-sidebar"></a>
			    </header>
			    <section>
					<div id="accordion"></div>
			    </section>
			    <!-- /.sidebar -->
			  </aside>
			  <!-- 主要内容区域 -->
			  <article class="main-article" id="main-article">
			  		<!-- tabs -->
			  		<div id="nav_tabs" style="position: relative;min-height: 28px;">
					</div>
					<div class="main-article-content" id="main-article-content">
					</div>
			  </article>
			 
		</div>

    </div>
	</body>
</html>