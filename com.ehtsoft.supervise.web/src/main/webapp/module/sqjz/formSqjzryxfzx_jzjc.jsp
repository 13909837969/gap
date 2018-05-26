<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../ltrhao-taglib.jsp"></jsp:include>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>解除(终止、变更)矫正信息</title>
<style>
.formSimple-gdlb{
	position: relative;
	padding-left:200px;
    margin-top: 20px;
}
 #sqjzryxfzx_form_jzjc table{
	border-collapse:collapse;
	width:100%;
}
 #sqjzryxfzx_form_jzjc td{
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
.input_1{
	border:none;
	width:100%;
	height:40px;
	text-align: center;
	cursor: pointer;
}
.input_2{
	border:none;
	width:80px;
	height:20px;
	text-align: center;
	cursor: pointer;
}
#sqjzryxfzx_form_jzjc tr{
	height:40px;
}
 #sqjzryxfzx_form_jzjc td>input{
	border:none;
}
 #sqjzryxfzx_form_jzjc .all div{
	width:600px;
	display: inline;
	margin: 10px;
}

</style>
<script type="text/javascript">
</script>
</head>
<body>
	<div id="formSimple-body">
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="sqjzryxfzx_form_jzjc">
					<table border="1" cellspacing="0" id="table_view" align="center">
						<tr style="height:height: 30px;font-size: 20px;">
							<td colspan="7" class="td1">解除（终止、变更）矫正信息</td>
						</tr>
						<tbody id="jzryjbxx">
							<tr>
								<td>解除/终止矫正原因</td>
								<td colspan="6" id="jjlx"><input getdis="true" type="text" name="jjlx" code="sys018"  radio="true"/></td>
								
							</tr>
							<tr id="sjzx">
								<td>收监执行原因</td>
								<td colspan="6"><input style="margin-left: 12px;" getdis="true" type="text" name="sjzxyy" code="sys010" id="sjzxyy" radio="true" disabled="disabled"/></td>
							</tr>
							<tr id=sjzx_2>
								<td>收监执行日期</td>
								<td colspan="2"><input getdis="true" type="text" name="sjzxrq" id="sjzxrq"  class="form_date input_2"/><span class="glyphicon glyphicon-list-alt"></td>
								<td>解除矫正日期</td>
								<td colspan="3"><input getdis="true" class="form_date input_2" name="jjrq" id="jjrq" disabled="disabled">&nbsp;&nbsp;<span class="glyphicon glyphicon-list-alt"></td>
							</tr>
							<tr>
								<td>收监执行类型</td>
								<td colspan="6"><input getdis="true" type="text" name="sjzxlx" code="sys011" id="sjzxlx" radio="true" disabled="disabled" /></td>
							</tr>
							<tr>
								<td>死亡日期</td>
								<td colspan="2"><input type="text" getdis="true" name="swsj" id="swsj" disabled="disabled" class="input_2 form_date"/><span class="glyphicon glyphicon-list-alt"></td>
								<td>死亡原因</td>
								<td  id="swyy" colspan="3"><input getdis="true" type="text" name="swyy" code="sys019" radio="true"  disabled="disabled"/></td>
							</tr>
							<tr>
								<td>具体死因</td>
								<td colspan="6"><textarea  getdis="true"name="jtsy" id="jtsy" disabled="disabled" class="td1"style="width: 100%;height: 54px;resize: none;overflow: hidden;border: none; margin: 0px;outline: none;"></textarea></td>
							</tr>
							<tr>
								<td>居住地变更日期</td>
								<td><input type="text" getdis="true" name="jzdbgrq" id="jzdbgrq" disabled="disabled" class="form_date input_2"/><span class="glyphicon glyphicon-list-alt"></td>
								<td>新居住地址</td>
								<td colspan="4"><textarea class="td1" getdis="true" name="xjzddz" id="xjzddz" disabled="disabled"></textarea></td>
							</tr>
						<tbody id="jzbx">
							<tr>
								<td>矫正期间表现</td>
								<td colspan="3"><input type="text" getdis="true" name="jzqjbx" code="sys024" radio="true" id="jzqjbx"/></td>
								
								<td>矫正期间是否参加职业技能培训</td>
								<td id="sfcjzyjnpx" colspan="2"><input type="text" getdis="true" name="sfcjzyjnpx" code="sys001" radio="true" /></td>
							</tr>
							<tr>
								<td>认罪态度</td>
								<td colspan="6"><input type="text" name="rztd" getdis="true" code="sys042" radio="true" id="rztd"/></td>
							</tr>
							<tr>
								<td>矫正期间是否获得职业技能证书</td>
								<td colspan="3" id="sfhdzyjnzs"><input getdis="true" type="text" name="sfhdzyjnzs" radio="true" code="sys001" /></td>
								<td>技术特长及等级</td>
								<td colspan="2"><textarea class="td1" getdis="true" name="jstcjdj" id="jstcjdj"></textarea></td>
							</tr>
							<tr>
								<td>危险性评估</td>
								<td colspan="3" ><input type="text" getdis="true" name="wxxpg" code="sys043" radio="true" id="wxxpg"/></td>
								<td>家庭联系情况</td>
								<td colspan="2" ><input type="text"  getdis="true"name="jtlxqk" code="sys044" radio="true" id="jtlxqk" style="margin-left: 8px;"/></td>
							</tr>
						</tbody>
							<tr>
								<td>矫正期间特殊情况备注及帮教建议</td>
								<td colspan="6"><textarea class="td2" getdis="true" name="tsqkbzjbjjy" style="width: 100%;height: 61px;resize: none;overflow: hidden;border: none; margin: 0px;outline: none;"></textarea></td>
							</tr>
							<tr>
								<td>备注</td>
								<td colspan="6"><textarea class="td2" getdis="true" name="remark" id="remark"></textarea></td>
								
							</tr>
					
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>