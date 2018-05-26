<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>矫正人员综合管理系统</title>
    <jsp:include page="module/ltrhao-common.jsp"></jsp:include>
<link rel="stylesheet" href="${localCtx}/resources/main-bootstrap.css">
<%-- <script type="text/javascript" src="${localCtx}/user/json/MenuService.js"></script> --%>
<style type="text/css">
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
    margin: 3px 0px;
    position: absolute;
    left: 0px;
    right: 0px;
    bottom: 0px;
    top: 0px;
}
.main-header{
  box-shadow: 0 1px 8px rgba(0, 0, 0, 0.3);
}
</style>
    <script type="text/javascript">
    	$(function(){
    		init();
    		var ss = [
    		          {title:"决策总览",url:"module/rep/nnn_viewJCZLDSJ.jsp"},
    		          {title:"社区矫正",url:"module/rep/viewRepSqjz.jsp"},
    		          {title:"人民调解",url:"module/sps/spsRmtj.jsp"},
    		          {title:"法律援助",url:"module/sps/dasbord1.jsp"},
    		          {title:"法制宣传",url:"module/sps/spsFzxc.jsp"},
    		          {title:"法律服务",url:"module/sps/dasbord1.jsp"},
    		          {title:"安置帮教",url:"module/sps/spsAzbj.jsp"},
    		          {title:"功能清单",url:"module/sps/spsListGnqd.jsp"}
    		];
    		for(var i=0;i<ss.length;i++){
    			var li = $(' <li><a href="#">'+ss[i].title+'</a></li>');
    			li.attr("url",ss[i].url);
    			li.data(ss[i]);
    			$("#mainframe-body .navbar-nav").append(li);
    			if(i==0){
    				li.addClass("active");
    				$("#mainiframe").attr("src",li.data().url);
    			}
    		}
    		/* 主菜单（上面) */
			$("#mainframe-body .navbar-nav>li").click(function(){
    			$(".navbar-nav>li").each(function(){
    				$(this).removeClass("active");
    			});
    			$(this).addClass("active");
    			
    			$("#mainiframe").attr("src",$(this).data().url);
    		});
			
    		var sidebar = $(".main-sidebar .sidebar-toggle");
    		sidebar.data({close:false,width:$(".main-sidebar").width()});
			//var me = new MenuService();
			
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
  <div id="mainframe-body" style="overflow:hidden;z-index:1;">
		<header id="main-header" >
			<nav class="navbar navbar-default mainframe-navbar">  <!-- role="navigation" -->
				    <div class="container-fluid">
				    <div class="navbar-header main-navbar-default">
				        <button type="button" class="navbar-toggle" data-toggle="collapse"
				                data-target="#example-navbar-collapse">
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				            <span class="icon-bar"></span>
				        </button>
				        <!-- <a class="navbar-brand" href="#">内蒙古公共法律服务智能一体化平台</a> -->
				        <div class="navbar-brand" >内蒙古公共法律服务智能一体化平台</div>
				    </div>
				    <div class="collapse navbar-collapse" id="example-navbar-collapse">
				        <ul class="nav navbar-nav">
				       </ul>
			    </div>
			    </div>
			</nav>
		</header>

		<div class="main-content">
			  <!-- 主要内容区域 -->
			  <article class="main-article" id="main-article">
					<div class="main-article-content" style="overflow:hidden" id="main-article-content">
						<iframe id="mainiframe"  frameborder="0" style="width:100%;height:100%;margin:0px;border:0px;padding:0px;"></iframe>
					</div>
			  </article>
		</div>
    </div>
	</body>
</html>