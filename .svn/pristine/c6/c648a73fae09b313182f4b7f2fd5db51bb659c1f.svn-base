<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>社区矫正人员状态信息采集表</title>
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
	<div class="text-center lead">社区矫正人员状态信息采集表</div>
	<div id="sqjz_formSqjzryjbxx" class="container-fluid">
		
		<div class="tab-content col-sm-12" >
			<div class="tab-pane active" id="jzryjbxx">
			<div id="formJ">
					<input id="xzzmm" type="text" label="社区矫正人员编号" name="xzzmm" getdis="true"  code=""/>
					<input id="yzzmm" type="text" label="管理级别" name="yzzmm" getdis="true"  code="sys054"/>
					<input id="yxjtcyjzyshgx" type="text" label="居住条件" name="yxjtcyjzyshgx" getdis="true" code="sys061"/>
					<input id="hjdsfyjzdxt" type="text" label="生活来源" name="hjdsfyjzdxt" getdis="true"  code="sys062"/>
					<input id="sfdcpg" type="text" label="就业能力" name="sfdcpg" getdis="true"  code="sys063"/>
					<input id="dcpgyj" type="text" label="自控能力" name="dcpgyj" getdis="true"  code="sys064"/>
					<input id="dcpgyj" type="text" label="婚姻家庭关系" name="dcpgyj" getdis="true"  code="sys065"/>
					<input id="dcpgyj" type="text" label="家庭成员配合矫正情况" name="dcpgyj" getdis="true"  code="sys066"/>
					<input id="dcpgyj" type="text" label="交友状况" name="dcpgyj" getdis="true"  code="sys067"/>
					<input id="dcpgyj" type="text" label="社会邻里关系" name="dcpgyj" getdis="true"  code="sys068"/>
					<input id="dcpgyj" type="text" label="对社区矫正的认识和接受程度" name="dcpgyj" getdis="true"  code="sys069"/>
					<input id="dcpgyj" type="text" label="服从日常管理及遵纪守法情况" name="dcpgyj" getdis="true"  code="sys070"/>
					<input id="dcpgyj" type="text" label="接受教育情况" name="dcpgyj" getdis="true"  code="sys071"/>
					<input id="dcpgyj" type="text" label="遵守请销假制度情况" name="dcpgyj" getdis="true"  code="sys072"/>
					<input id="dcpgyj" type="text" label="完成社区服务情况" name="dcpgyj" getdis="true"  code="sys073"/>
					<input id="dcpgyj" type="text" label="思想汇报及沟通" name="dcpgyj" getdis="true"  code="sys074"/>
					<input id="dcpgyj" type="text" label="参加就业技能培训" name="dcpgyj" getdis="true"  code="sys075"/>
					<input id="dcpgyj" type="text" label="矫正惩戒情况" name="dcpgyj" getdis="true"  code="sys076"/>
					<input id="dcpgyj" type="text" label="家庭人员变故信息" name="dcpgyj" getdis="true"  code="sys077"/>
					<input id="dcpgyj" type="text" label="认罪服法态度" name="dcpgyj" getdis="true"  code="sys078"/>
					<input id="dcpgyj" type="text" label="对社会的心态" name="dcpgyj" getdis="true"  code="sys079"/>
					<input id="dcpgyj" type="text" label="对生活是否有信心" name="dcpgyj" getdis="true"  code="sys080"/>
					<input id="dcpgyj" type="text" label="心理健康状况" name="dcpgyj" getdis="true"  code="sys081"/>
					<input id="dwhm" type="text" label="采集人" name="dwhm" getdis="true"/>
					<input id="dwhm" type="text" label="采集日期" name="dwhm" getdis="true"/>
					
					
					
			</div>
			</div>
		</div>
		<div>
			<center><button id="asdfghgjg" type="button" class="btn btn-primary" >保存</button></center>
	</div>
	</div>
</body>
</html>