<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>余罪或再罪有关情况信息采集表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<%
	if (!"load".equals(request.getParameter("load"))) {
%>
<script type="text/javascript"
	src="${localCtx}/json/JzJzryjbxxService.js"></script>
<%
	}
%>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript"
	src="${localCtx}/resources/jss/formSqjzryjbxx.js"></script>
<style type="text/css">
.grjl-border {
	border-bottom: 1px solid #ddd;
}

#formSqjzryjbxx-bj {
	position: absolute;
	left: 0px;
	top: 10px;
}

#formSqjzryjbxx-tj {
	position: absolute;
	left: 50px;
	top: 10px;
}

#jzryjbxx {
	margin-top: 40px;
}
</style>
</head>

<body>
	<%
		String jzryjbxxid = UUID.randomUUID().toString();
		String id = request.getParameter("id");
		if (id != null) {
			jzryjbxxid = id;
			out.print("<input type='hidden' value='1' id='form-edit-flag1'>");
		} else {
			out.print("<input type='hidden' value='0' id='form-edit-flag1'>");
		}
	%>
	<div id="sqjz_formSqjzryjbxx" class="container-fluid">
		<div class="tab-content col-sm-12">
			<div class="tab-pane active" id="jzryjbxx">
				<div id="formJ">
					<div class="text-center lead">余罪或再罪有关情况信息采集表</div><br>
					<input id="sqjzrybh" type="text" label="社区矫正人员编号" name="sqjzrybh" getdis="true" code="" />
					<input id="sszm" type="text" label="所涉罪名" name="sszm" getdis="true" code="sys014" />
					<input id="zcjg" type="text" label="侦查机关" name="zcjg" getdis="true" code="" />
					<input id="bcqqzcssj" type="text" label="被采取强制措施时间" name="bcqqzcssj" getdis="true" code="" />
					<input id="spjg" type="text" label="审判机关" name="spjg" getdis="true" code="" />
					<input id="zm" type="text" label="罪名" name="zm" getdis="true" code="sys096" />
					<input id="xq" type="text" label="刑期" name="xq" getdis="true" code="" />
				</div>
				<div>
					<center>
						<button type="submit" class="btn btn-primary">保存</button>
					</center>
				</div>
			</div>
		</div>
		<!-- </form> -->
	</div>
</body>
</html>