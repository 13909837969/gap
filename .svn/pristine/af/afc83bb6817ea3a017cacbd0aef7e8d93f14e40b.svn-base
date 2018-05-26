<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>刑期变动情况信息采集表</title>
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
					<div class="text-center lead">刑期变动情况信息采集表</div><br>
					<input id="sqjzrybh" type="text" label="社区矫正人员编号" name="sqjzrybh" getdis="true" code="" />
					<input id="bdrq" type="text" label="变动日期" name="bdrq" getdis="true" code="" />
					<textarea id="bdfd" type="text" label="变动幅度" name="bdfd" getdis="true"></textarea>
					<textarea id="bdyy" type="text" label="变动原因" name="bdyy" getdis="true"></textarea>
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