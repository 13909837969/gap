<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>社区矫正人员在社区矫正期间再犯罪信息采集表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%if(!"load".equals(request.getParameter("load"))){ %>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<%}%>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formSqjzryjbxx.js"></script>
<style type="text/css">
.grjl-border{
	border-bottom:1px solid #ddd;
}
#formSqjzryjbxx-bj{
	position: absolute;
    left: 0px;
    top: 10px;
}
#formSqjzryjbxx-tj{
	position: absolute;
    left: 50px;
    top: 10px;
}
#jzryjbxx{
	margin-top: 40px;
}
</style>
</head>

<body>
	<%String jzryjbxxid = UUID.randomUUID().toString(); 
	String id = request.getParameter("id");
		if(id != null){
			jzryjbxxid = id ;
			out.print("<input type='hidden' value='1' id='form-edit-flag1'>");
		}else{
			out.print("<input type='hidden' value='0' id='form-edit-flag1'>");
		}
	%>
	<div class="text-center lead">社区矫正人员在社区矫正期间再犯罪信息采集表</div>
	<div id="sqjz_formSqjzryjbxx" class="container-fluid">
		
		<div class="tab-content col-sm-12" >
			<div class="tab-pane active" id="jzryjbxx">
			<div id="formJ">
					<input id="xzzmm" type="text" label="社区矫正人员编号" name="xzzmm" getdis="true"  code=""/>
					<input id="yzzmm" type="text" label="罪名" name="yzzmm" getdis="true"  code="sys096"/>
					<input id="yzzmm" type="text" label="原判刑罚" name="yzzmm" getdis="true"  code="sys012"/>
					<input id="yzzmm" type="text" label="附加刑" name="yzzmm" getdis="true"  code="sys013"/>
					<input id="dwhm" type="text" label="犯罪日期" name="dwhm" getdis="true"/>
					<input id="dwhm" type="text" label="服刑单位" name="dwhm" getdis="true"/>
					<input id="dwhm" type="text" label="刑期开始日期" name="dwhm" getdis="true"/>
					<input id="dwhm" type="text" label="刑期结束日期" name="dwhm" getdis="true"/>
					<input id="hjdsfyjzdxt" type="text" label="判决机关" name="hjdsfyjzdxt" getdis="true"  />
					<input id="hjdsfyjzdxt" type="text" label="备注" name="hjdsfyjzdxt" getdis="true"  />
					
			</div>
			</div>
		</div>
		<div>
			<center><button id="asdfghgjg" type="button" class="btn btn-primary" >保存</button></center>
	</div>
	</div>
</body>
</html>