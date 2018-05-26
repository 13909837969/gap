<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<title>社区矫正——矫正衔接</title>
<script type="text/javascript">
$(function(){
	var count = 0;
	var tabCnt = $("#form_jzxj_tab").children().size();
	$("#form_jzxj_tab").children().each(function(){
		$(this).load($(this).attr("load"),function(){
			count++;
			initJzryjbxxForm();
		});
	});
	var initJzryjbxxForm = function(){
		if(count!=tabCnt){
			return;
		}
	}

})

</script>
</head>

<body>
	<div>
		<div id="fromXzdh"><!--表单的导航列表  -->
			<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  <li class="active ">
				  	<a href="#formJzxj_djjs" data-toggle="tab" >登记接收</a>
				  </li>
		          <li>
		            <a href="#formJzxj_zzcz" data-toggle="tab" >组织查找</a>
		           </li>
			</ul>
		</div>
		<div class="tab-content"  id="form_jzxj_tab">
		<!--导航列表页面  -->
			<div class="tab-pane active" id="formJzxj_djjs" load="${localCtx}/module/sqjz/Jzxj_djjs.jsp?load=load"></div>
			<div class="tab-pane" id="formJzxj_zzcz" load="${localCtx}/module/sqjz/Sqjz_formZzcz.jsp?load=load"></div>
		</div>
		
		
		
	</div>
</body>
</html>