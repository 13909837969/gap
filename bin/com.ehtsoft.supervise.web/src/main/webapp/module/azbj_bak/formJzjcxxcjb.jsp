<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>矫正解除（终止）信息采集表</title>
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
					<div class="text-center lead">矫正解除（终止）信息采集表</div><br>
					<input id="sqjzrybh" type="text" label="社区矫正人员编号" name="sqjzrybh" getdis="true" code="" />
					<input id="jzjclx" type="text" label="矫正解除（终止）类型" name="jzjclx" getdis="true" code="sys018" />
					<input id="jzjcrq" type="text" label="矫正解除（终止）日期" name="jzjcrq" getdis="true" code="" />
					<input id="sjzxyy" type="text" label="收监执行原因" name="sjzxyy" getdis="true" code="sys010" />
					<input id="sjzxlx" type="text" label="收监执行类型" name="sjzxlx" getdis="true" code="sys011" />
					<input id="sjzxrq" type="text" label="收监执行日期" name="sjzxrq" getdis="true" code="" />
					<input id="swrq" type="text" label="死亡日期" name="swrq" getdis="true" code="" />
					<input id="swyy" type="text" label="死亡原因" name="swyy" getdis="true" code="sys019" />
					<input id="jtsy" type="text" label="具体死因" name="jtsy" getdis="true"/>
					<input id="jzdbgrq" type="text" label="居住地变更日期" name="jzdbgrq" getdis="true" code="" />
					<input id="xjzddz" type="text" label="新居住地地址" name="xjzddz" getdis="true"/>
					<input id="jzqjbx" type="text" label="矫正期间表现" name="jzqjbx" getdis="true" code="sys024" />
					<input id="rztd" type="text" label="认罪态度" name="rztd" getdis="true" code="sys042" />
					<input id="jzqjsfcjzyjnpx" type="text" label="矫正期间是否参加职业技能培训" name="jzqjsfcjzyjnpx" getdis="true"/>
					<input id="jzqjsfhdzyjnzs" type="text" label="矫正期间是否获得职业技能证书" name="jzqjsfhdzyjnzs" getdis="true"/>
					<input id="jstcjdj" type="text" label="技术特长及等级" name="jstcjdj" getdis="true">
					<input id="wxxpg" type="text" label="危险性评估" name="wxxpg" getdis="true" code="sys043" />
					<input id="jtlxqk" type="text" label="家庭联系情况" name="jtlxqk" getdis="true" code="sys044" />
					<input id="jzqjtsqkbzjbjjy" type="text" label="矫正期间特殊情况备注及帮教建议" name="jzqjtsqkbzjbjjy" getdis="true">
					<input id="bz" type="text" label="备注" name="bz" getdis="true"></textarea>
					<input id="sfsjcr" type="text" label="司法所解除人" name="sfsjcr" getdis="true"/>
					<input id="sfsjcsj" type="text" label="司法所解除时间" name="sfsjcsj" getdis="true" code="" /> 
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