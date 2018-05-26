<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>矫正人员综合管理系统</title>
    <jsp:include page="module/ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="${localCtx}/resources/main-bootstrap.css">
	
    <script type="text/javascript">
    	$(function(){
    		/* 带有close的 tab */
    		$(".ltrhao_nav_tabs>li").click(function(){
    			$(".ltrhao_nav_tabs>li").each(function(){
    				$(this).removeClass("active");
    			});
    			$(this).addClass("active");
    			
    			$("#test").load("module/sqjz/formSqjzryxxb.jsp?load=load",{},function(){
    				$(".main-sidebar").height($(this).height() + $(this).position().top);
    			});
    		});
    		/* 主菜单（上面) */
			$(".navbar-nav>li").click(function(){
    			$(".navbar-nav>li").each(function(){
    				$(this).removeClass("active");
    			});
    			$(this).addClass("active");
    		});
			/* 侧边栏 accordion 点击事件 */
			$(".accordion-heading").click(function(){
				$(".accordion-heading").each(function(){
					$(this).removeClass("active");
				});
				$(this).addClass("active");
			});
    		var sidebar = $(".main-sidebar .sidebar-toggle");
    		sidebar.data({close:false,width:$(".main-sidebar").width()});
    		
			/* 侧边框 toggle 按钮事件（关闭或打开侧边菜单） */
			$(".main-sidebar .sidebar-toggle").click(function(){
				var d = $(this).data();
				if(!d.close){
					$("#main-sidebar").width(40);
					$(".main-article").css("left",41);
					$("#sidebar-search").toggle();
					d.close=true;
					$(this).data(d);
				}else{
					$("#main-sidebar").width(d.width);
					$(".main-article").css("left","");
					$("#sidebar-search").toggle();
					d.close=false;
					$(this).data(d);
				}
			});
    	});
    </script>
  </head>

  <body>
  <div>
		<header>
			<nav class="navbar navbar-default mainframe-navbar">  <!-- role="navigation" -->
				    <div class="container-fluid">
				    <div class="navbar-header main-navbar-default">
				        <button type="button" class="navbar-toggle" data-toggle="collapse"
				                data-target="#example-navbar-collapse">
				                <!--
				            <span class="sr-only">切换导航</span>
				            -->
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
					<div class="accordion">
						<div class="accordion-group">
							<div class="accordion-heading header active">
								 <div class="accordion-toggle" data-toggle="collapse" 
								 	href="#accordion-element-193110">
								 	<i class="sidebar-icon"></i><span>  选项卡 #1</span>
								 </div>
							</div>
							<div id="accordion-element-193110" class="accordion-body collapse in">
								<div class="accordion-inner">
									<ul>
										<li>项目001</li>
										<li>项目002</li>
										<li>项目003</li>
									</ul>
								</div>
							</div>
						</div>
						<div class="accordion-group">
							<div class="accordion-heading header active">
								 <div class="accordion-toggle" data-toggle="collapse" 
								 	data-parent="#accordion-746522" 
								 	href="#accordion-element-193111">
								 	<i class="sidebar-icon"></i><span>  选项卡 #1</span>
								 </div>
							</div>
							<div id="accordion-element-193111" class="accordion-body collapse">
								<div class="accordion-inner">
									功能块...afafaf
								</div>
							</div>
						</div>
						<div class="accordion-group">
							<div class="accordion-heading header active">
								 <div class="accordion-toggle" data-toggle="collapse" 
								 	data-parent="#accordion-746522" 
								 	href="#accordion-element-193111">
								 	<i class="sidebar-icon"></i><span>  选项卡 #1</span>
								 </div>
							</div>
							<div id="accordion-element-193111" class="accordion-body collapse">
								<div class="accordion-inner">
									功能块...afafaf
								</div>
							</div>
						</div>
					</div>

			    </section>
			    <!-- /.sidebar -->
			  </aside>

			  
			  <article class="main-article">
					<ul class="ltrhao_nav_tabs">
						  <li class="active">
						  	<a href="#"><span>系统模块1</span><span class="glyphicon glyphicon-remove"></span></a>
						  </li>
						  <li><a href="#">Profile</a></li>
						  <li><a href="#">Messages</a></li>
						  <li ><a href="#">Profile</a><span class="close"></span></li>
					</ul>

					<div class="main-article-content">
						<div style="border:1px solid #f0f;" id="test">
								


						</div>
					</div>
			  </article>
			 
		</div>

    </div>
	</body>
</html>