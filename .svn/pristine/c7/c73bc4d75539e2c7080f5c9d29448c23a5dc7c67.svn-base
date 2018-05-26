<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="module/common.jsp"></jsp:include>
<script type="text/javascript" src="resources/script/amq/amq_jquery_adapter.js"></script>
<script type="text/javascript" src="resources/script/amq/amq.js"></script>
<script type="text/javascript" src="json/SSO.js"></script>
<script type="text/javascript" src="resources/script/medical/chatWindow.js"></script>
<style>
/*气球对话框*/
.chat-box{
	margin-top:10px;
    margin-bottom:30px; 
    padding-left:2em;
    background:#fafafa; 
    border:1px solid #aaa;
    position:relative; 
    
    -moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	-khtml-border-radius: 5px;
	border-radius: 5px;
	padding:5px 10px 5px 10px;
}
.chat-box1{
	float:right;
}
.chat-box2{
	float:left;
}
.chat-user1{
	text-align: right;
}
.chat-box-cor1{
    width:0; 
    height:0; 
    font-size:0; 
    border-width:6px; 
    border-style:solid; 
    border-color:transparent transparent #aaa; 
    overflow:hidden; 
    position:absolute; 
    top:-12px; 
	left:5px;
}
.chat-user2{
	text-align: left;
}
.chat-box-cor2{
    width:0; 
    height:0; 
    font-size:0; 
    border-width:6px; 
    border-style:solid; 
    border-color:transparent transparent #aaa; 
    overflow:hidden; 
    position:absolute; 
    top:-12px; 
	right:5px;
}
</style>
</head>
<body>
<div id="msg-top">
	<div id="msg-top-msg" style="padding:10px;overflow-y: auto; ">
		<div></div>
	</div>
	<div id="msg-top-chat" style="height:100px;">
		<div style="width:100%;height:100%;">
			<textarea id="txtchat" style="width:97%;height:90px;border:0px;padding:5px;"></textarea>
		</div>
	</div>
</div>
<div id="msg-bottom" style="height:30px;">
	<div align="right" style="margin-right:10px;">
		<input type="button" id="sendBtn" value="发送"/>
	</div>
</div>
</body>
</html>