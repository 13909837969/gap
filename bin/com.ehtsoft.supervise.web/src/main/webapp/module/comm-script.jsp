<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String ctx= (String)request.getAttribute("com.ehtsoft.fw.sso.url");
if(ctx==null){
	ctx = "/user";
}
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
String localCtx = application.getContextPath();

request.setAttribute("localCtx",localCtx);
request.setAttribute("ctx", ctx);
%>

<link rel="stylesheet" type="text/css" href="<%=ctx%>/resources/css/core/default/eht.ui.core.css"/>
<script type="text/javascript" src="<%=localCtx%>/resources/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=localCtx%>/resources/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.json.js"></script>
<script type="text/javascript" src="<%=localCtx%>/resources/bootstrap/js/jquery-plugin.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.utils.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.responder.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.paginate.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.window.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.tips.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.alert.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.confirm.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.toolbar.js"></script>
