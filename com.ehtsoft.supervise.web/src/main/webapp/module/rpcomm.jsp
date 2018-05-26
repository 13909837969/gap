<%String ctx= (String)request.getAttribute("com.ehtsoft.fw.sso.url"); %>
<%
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
String localCtx = application.getContextPath();
%>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" /> 
<link rel="stylesheet" type="text/css" href="<%=ctx%>/resources/css/core/default/eht.ui.core.css"/>
<link rel="shortcut icon" type="image/x-icon" href="<%=ctx%>/resources/images/login/logo.ico" media="screen" />
<script type="text/javascript" src="<%=ctx%>/resources/script/jquery/eht.rmi.json.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/jquery/jquery-myplugin.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/jquery/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.utils.js"></script>
<script type="text/javascript" src="<%=localCtx%>/resources/script/datacode/eht.csm.datacode.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.responder.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.paginate.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.form.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.rmi.view.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.layout.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.toolbar.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.datagrid.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.tree.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.menu.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.tab.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.confirm.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.combobox.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.tips.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.accordion.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.window.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.datepicker.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.alert.js"></script>
<script type="text/javascript" src="<%=ctx%>/resources/script/core/eht.ui.autocomplete.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=rlBfGG2RtC3vgylVySAenO30Ihk31FZO"></script>
<style>
<!--
.form_class{
	margin:7px 25px;
}
.form_item label{
	display:inline-block;width:80px;vertical-align: top;text-align: right;padding-top:4px;margin-right:4px;
}
.form_item input[type='text']{
	width:145px;
}
.form_item select{
	width:148px;
}
.form_item{
	margin:2px 0px;
	display:inline-block;
}
.form_class textarea{
    width:380px;
    resize:none;
}

-->
</style>