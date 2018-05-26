<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="json/WebCommunicationService.js"></script>
<script type="text/javascript" src="resources/script/amq/amq_jquery_adapter.js"></script>
<script type="text/javascript" src="resources/script/amq/amq.js"></script>
<script type="text/javascript" src="resources/script/medical/chatManager.js"></script>
<script type="text/javascript" src="json/SSO.js"></script>
<title>聊天人员窗口管理</title>
<style type="text/css">
.tree-icon-online{
	background-image: url(resources/images/icon/user1.png);
}
.tree-icon-unline{
	background-image: url(resources/images/icon/user2.png);
}
</style>
</head>
<body>
<div id="right">
	<div id="right-title"><div style="float:left;">聊天对象</div><div style="float:right;margin-right:10px;"><input type="checkbox" id="benyuan" value="1" checked style="vertical-align:top;"/><font style="vertical-align: top;">本院</font></div></div>
	<div id="tree" style="overflow:auto;"></div>
</div>
</body>
</html>