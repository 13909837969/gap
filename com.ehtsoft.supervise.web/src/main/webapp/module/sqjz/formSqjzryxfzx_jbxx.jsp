<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息录入</title>
<style>
.formSimple-gdlb{
	position: relative;
	padding-left:200px;
    margin-top: 20px;
}
 #sqjzryxfzx_form_jbxx table{
	border-collapse:collapse;
	width:100%;
}
#sqjzryxfzx_form_jbxx td>input{
	border:none;
	text-align: center;
}
 #sqjzryxfzx_form_jbxx td{
	text-align:center;
	width:100px;
	font-weight: bold;
}
.td1{
	width:100%;
	text-align:center;
	line-height:40px;
	height:40px;
	border: none;
	resize: none;
	overflow: hidden;
	
}
.td2{
	width:100%;
	height:100%;
	border: none;
	resize: none;
	overflow: hidden;
}
.td3{
	width:100%;
	height:22px;
	border: none;
	resize: none;
	overflow: hidden;
	text-align: center;
}
#sqjzryxfzx_form_jbxx tr{
	height:40px;
}
.input_1{
	border:none;
	width:100%;
	height:40px;
	text-align: center;
	cursor: pointer;
}
.input_2{
	border:none;
	width:85px;
	height:20px;
	text-align: center;
	cursor: pointer;
}
 #sqjzryxfzx_form_jbxx .all div{
	width:600px;
	display: inline;
	margin: 10px;
}

</style>
</head>
<body>
	<%
		String id = request.getParameter("id");
		if(Util.isNotEmpty(id)){
			out.print("<input type='hidden' value='1' id='form-edit-flag1'>");
		}else{
			out.print("<input type='hidden' value='0' id='form-edit-flag1'>");
			id = UUID.randomUUID().toString();
		} 
	%>
	<div id="formSimple-body">
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="sqjzryxfzx_form_jbxx">
					<span><input id="id" type="hidden" name="id" value="<%=id%>" fixedValue="true"/></span>
					<table border="1" cellspacing="0" id="table_view" align="center">
						<tr style="height:height: 30px;font-size: 20px;">
							<td colspan="7">刑&nbsp;&nbsp;罚&nbsp;&nbsp;执&nbsp;&nbsp;行&nbsp;&nbsp;信&nbsp;&nbsp;息</td>
						</tr>
							<tr>
								<td>矫正类别</td>
								<td id="jzlb" colspan="5">
										<input radio="true" name="jzlb" code="sys017"  getdis="true" type="text"/>
								</td>
							</tr>
							<tr>
								<td>矫正起止日期</td>
								<td colspan="2">
									自<input type="text" name="sqjzksrq" id="sqjzksrq" class="form_date input_2" readonly="readonly" getdis="true"/>起&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span><br/>
									至<input type="text" name="sqjzjsrq" id="sqjzjsrq" class="form_date input_2" readonly="readonly" getdis="true"/>止&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span>
								</td>
								<td>矫正期限</td>
								<td colspan="2"><input type="text" style="width: 100%;" name="sqjzqx" id="sqjzqx" class="td1" disabled="disabled" getdis="true"></textarea></td>
							</tr>
							<tr>
								<td>罪名</td>
								<td colspan="2"><input type="text" style="width:100%; border: none;" name="zm" class="td1" getdis="true"></textarea></td>
								<td>犯罪类型</td>
								<td colspan="3" id="fzlx">
									<input type="input" name="fzlx" code="sys014" style="width:100%;height: 40px;border: none;"getdis="true" />
									
								</td>
							</tr>
							<tr>
								<td>管制期限</td>
								<td colspan="5" id="gzqx">
									<input radio="true" name="gzqx" style="margin-left: 10px;"  code="sys058"getdis="true"/>
								</td>
							</tr>
							<tr>
								<td>缓刑考验期</td>
								<td colspan="5" id="hxkyqx">
									<input radio="true" name="hxkyqx" style="margin-left: 2px;" code="sys059" getdis="true"/>
									
								</td>
							</tr>
							
							<tr>
								<td>是否数罪并罚</td>
								<td id="sfszbf" colspan="2">
									<input radio="true" name="sfszbf" code="sys001" getdis="true"/>
									
								</td>
								<td>原判刑期起止日</td>
								<td colspan="2" id="yprq">
									自<input type="text" name="ypxqksrq" id="ypxqksrq" class="form_date input_2" readonly="readonly"getdis="true"/>起&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span><br/>
									至<input type="text" name="ypxqjsrq" id="ypxqjsrq" class="form_date input_2" readonly="readonly"getdis="true"/>止&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span>
								</td>
							</tr>
							<tr>
								<td>原判刑罚</td>
								<td colspan="5"id="ypxf">
									<input radio="true" name="ypxf"  code="sys012"getdis="true"/>
									
								</td>
							</tr>
							<tr>
								<td>原判刑期</td>
								<td colspan="2"><input getdis="true" name="ypxq" type="text" style="height: 40px; border: none;width:100%;text-align: center;" disabled="disabled" id="ypxq"></textarea></td>
								<td>有期徒刑期限</td>
								<td id="yqtxqx" colspan="2" >
									<input getdis="true" type="input" name="yqtxqx"style="width:100%;height: 40px;border: none;" code="sys032" disabled="disabled"/><br>
									
								</td>
							</tr>
							<tr>
								<td>附加刑</td>
								<td colspan="5" id="fjx">
									<input getdis="true" mult="true" name="fjx" style="margin-left: 2px;" code="sys013"/>
									
								</td>
							</tr>
							<tr>
								<td>是否“五独”</td>
								<td colspan="5" id="sfwd">
									<input getdis="true" radio="true" name="sfwd" style="margin-left: 10px;" code="sys040" />
									
								</td>
							</tr>
							<tr>
								<td>是否“五涉”</td>
								<td colspan="5" id="sfws">
									<input getdis="true" radio="true" name="sfws" value="00" code="sys041" style="margin-left: 4px;"/>
								
								</td>
							</tr>
							<tr>
								<td>是否有“四史”</td>
								<td  colspan="6" id="sfyss">
									<input getdis="true" radio="true" name="sfyss" value="05" code="sys038" checked="true"/>
								</td>	
							</tr>
							<tr id="jzl">
								<td>是否被宣告禁止令</td>
								<td id="sfbxgjzl" colspan="2">
									<input getdis="true" radio="true" name="sfbxgjzl" style="margin-top: 20px;" code="sys001" />&nbsp;&nbsp;
								</td>
								<td>禁止期限起止日</td>
								<td colspan="2">
									自<input getdis="true" type="text" name="jzqxksrq" id="jzqxksrq" class="form_date input_2" readonly="readonly"/>起&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span><br/>
									至<input  getdis="true" type="text" name="jzqxjsrq" id="jzqxjsrq" class="form_date input_2" readonly="readonly"/>止&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></span>
								</td>
							</tr>
							<tr>	
								<td>禁止令内容</td>
								<td colspan="5"><textarea getdis="true" name="jzlnr" style="width: 100%;height: 54px;resize: none;overflow: hidden;border: none; margin: 0px;outline: none;" id="jzlnr"></textarea></td>
							</tr>
							<tr>
								<td>报道情况</td>
								<td colspan="5" id="bdqk">
									<input getdis="true" radio="true" name="bdqk" style="margin-left: 15px;" code="sys016" />
									
								</td>
							</tr>
							<tr>	
								<td>未按时报到情况说明</td>
								<td colspan="5"><textarea  getdis="true" name="wasbdqksm" class="td2" style="height: 80px;" id="wasbdqksm"></textarea></td>
							</tr>
						
							<tr id="sqjs">
								<td>社区矫正人员接收方式</td>
								<td colspan="3" id="sqjzryjsfs">
									<input radio="true" getdis="true" name="sqjzryjsfs"  code="sys015" style="margin-left: 2px;"/>
									
								</td>
								<td>社区矫正人员接收日期</td>
								<td colspan="2"><input  getdis="true" type="text" name="sqjzryjsrq"  class="form_date" id="sqjzryjsrq" readonly="readonly" style="border:none;width:100px;heiht:40px;text-align: center;cursor: pointer;"/>&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></td>
							</tr>
							<tr id="jzxz">
								<td>是否建立矫正小组</td>
								<td colspan="2" id="sfjljzxz">
									<input getdis="true" radio="true" name="sfjljzxz"  code="sys001" />
									
								</td>
								<td>矫正小组人员组成情况</td>
								<td colspan="3" id="jzxzryzcqk">
									<input getdis="true" type="input" name="jzxzryzcqk" style="width:100%;height: 40px;border: none;" code="sys020" disabled="disabled"/>
									
								</td>
							</tr>
							<tr id="dwgl">
								<td>是否采取电子定位管理</td>
								<td id="sfcqdzdwgl">
									<input getdis="true" radio="true" name="sfcqdzdwgl"  code="sys001" />
									
								</td>
								<td>电子定位方式</td>
								<td  id="dzdwfs">
									<input  getdis="true"radio="true" name="dzdwfs" style="margin-left: 15px;" code="sys060" />
								
								
								</td>
								<td>定位号码</td>
								<td colspan="3"><input getdis="true" name="dwhm" class="td1" id="dwhm"></td>
							</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>