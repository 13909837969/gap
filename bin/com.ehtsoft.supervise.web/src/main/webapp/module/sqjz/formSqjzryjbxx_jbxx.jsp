<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../ltrhao-taglib.jsp"></jsp:include>
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
				<div id="sqjzryjbxx_form_jbxx">
				<div class="form-group col-sm-2 col-xs-12" style="padding-left:20px;margin-right: 44px; float: right;">
					<label for="jbxxfile" class="pull-right" style="width:120px;height:140px;">
					<img id="jzryjbxx_photo" 
						osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=id%>&icon=per"
						src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=id%>&icon=per" 
						 style="width:110px;height:140px;">
					<form id="jzryjbxxuploadForm" action="${localCtx}/upload/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=id%>" 
						method="post" enctype="multipart/form-data" 
						target="importFrame" style="margin:0px;padding:0px;">
							<!-- 文件上传成功或失败的回调方法 -->
						<input type="hidden" name="callback" fixedValue="true" value="callbackJzryjbxxImg" id="jzryjbxxhidden">
						<input type="file" name="fname" id="jbxxfile" style="display:none;">
					</form>
					<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
					</label>
				</div>
				<span><input id="id" type="hidden" name="id" value="<%=id%>" fixedValue="true"/></span>
				<input col="10" labelCol="3" id="sqjzrybh" type="text" label="服刑人员编号" name="sqjzrybh" disabled/>
				<input col="10" labelCol="3" id="xm" type="text" label="姓名" name="xm" getdis="true" valid="{required:true}"/>
				<input col="10" labelCol="3" type="text" name="sfzh" id="sfzh" label="身份证号" getdis="true"  valid="{cardNo:true}" />
				<input  type="text" name="cym" label="曾用名" getdis="true"  />
				<input type="text" name="csrq" id="csrq" label="出生日期" getdis="true"  class="form_date" data-date-formate="yyyy-MM-dd" />
				<input  id="sfdcpg" type="text" label="是否调查评估" name="sfdcpg" getdis="true"  code="sys001"/>
				<input  id="dcpgyj" type="text" label="调查评估意见" name="dcpgyj" getdis="true"  code="sys033"/>
				<input id="dcyjcxqk" type="text" label="调查意见采信情况" name="dcyjcxqk" getdis="true"  code="sys034"/>
				<input  id="jglx" type="text" label="矫正类型" name="jglx" getdis="true" code="sys114" />
				<input  id="jzjg" type="text" label="矫正机构" name="orgid" getdis="true" code="sys114" />
				<input type="text" name="xb" label="性别" getdis="true"   code="sys000" />
				<input id="gj" type="text" label="国籍" name="gj" getdis="true"  code="sys051" noChild="true"/>
				<input type="text" name="mz" label="民族" getdis="true"   code="sys003" />
				<input type="text" name="grlxdh" label="手机号" getdis="true"  />
				<input type="text" name="sfcn" label="是否成年"  getdis="true"  code="sys001"/>
				<input type="text" name="wcn" label="未成年"  getdis="true"  code="sys035"/>
				<input id="hjdsfyjzdxt" type="text" label="户籍地是否与居住地相同" name="hjdsfyjzdxt" getdis="true"  code="sys001"/>
				<input id="gdjzdmx" type="text" label="居住地详细地址" name="gdjzdmx" getdis="true" />
				<input id="hjszdmx" type="text" label="户籍地详细地址" name="hjszdmx" getdis="true" />
				<input type="text" label="婚姻状况" name="hyzk"  getdis="true" code="sys030"/>
				<input type="text" label="原政治面貌" name="yzzmm" getdis="true"  code="sys091"/>
				<input type="text" label="现政治面貌" name="xzzmm" getdis="true"  code="sys091"/>
				<input type="text" label="捕前职业" name="pqzy" getdis="true"  code="sys098"/>
				<input type="text" label="文化程度" name="whcd" getdis="true" code="sys028"/>
				<input type="text" label="现工作单位" name="xgzdw" getdis="true" />
				<input type="text" label="原工作单位" name="ygzdw" getdis="true" />
				<input type="text" name="dwlxdh" label="单位联系电话" getdis="true"   />
				<input type="text" name="qtlxfs" label="其他联系方式" getdis="true"  />
				<input id="sfswry" type="text" label="是否三无人员" name="sfswry" getdis="true"  code="sys001"/>
				<input id="jyjxqk" type="text" label="就业就学情况" name="jyjxqk" getdis="true" code="sys031"/>
				<input id="ywhz" type="text" label="有无护照" name="ywhz" getdis="true"  code="sys102"/>
				<input id="hzhm" type="text" label="护照号码" name="hzhm" getdis="true" />
				<input id="hzbczt" type="text" label="护照状态" name="hzbczt" getdis="true" code="sys045"/>
				<input id="ywgatsfz" type="text" label="有无港澳台身份证" name="ywgatsfz" getdis="true"  code="sys102"/>
				<input id="gatsfzlx" type="text" label="港澳台身份证类型" name="gatsfzlx" getdis="true" code="sys046"/>
				<input id="gatsfzhm" type="text" label="港澳台身份证号码" name="gatsfzhm" getdis="true" />
				<input id="ywgattxz" type="text" label="有无港澳台通行证" name="ywgattxz" getdis="true"  code="sys102"/>
				<input id="gattxzlx" type="text" label="港澳台通行证类型" name="gattxzlx" getdis="true" code="sys047"/>
				<input id="gattxzhm" type="text" label="港澳台通行证号码" name="gattxzhm" getdis="true"/>
				<input id="gattxzbczt" type="text" label="港澳台通行证状态" name="gattxzbczt" getdis="true" code="sys045"/>
				<input id="ywgajmwlndtxz" type="text" label="有无港澳居民往来内地通 行证" name="ywgajmwlndtxz" getdis="true"  code="sys102"/>
				<input id="gajmwlndtxz" type="text" label="港澳居民往来内地通行证 号码" name="gajmwlndtxz"/>
				<input id="gajmwlndtxzbczt" type="text" label="港澳居民往来内地通行证 状态" name="gajmwlndtxzbczt" getdis="true" code="sys045"/>
				<input id="ywtbz" type="text" label="有无台胞证" name="ywtbz"  getdis="true" code="sys102"/>
				<input id="tbzhm" type="text" label="台胞证号码" name="tbzhm"getdis="true" />
				<input id="tbzbczt" type="text" label="台胞证状态" name="tbzbczt" getdis="true" code="sys045"/>
				<input id="zyjwzxrystzk" type="text" label="暂予监外执行人员身体状 况" name="zyjwzxrystzk" getdis="true" code="sys036"/>
				<input id="zhjzyy" type="text" label="最后就诊医院" name="zhjzyy"/>
				<input id="sfyjsb" type="text" label="是否有精神病" name="sfyjsb" getdis="true"  code="sys102"/>
				<input id="jdjg" type="text" label="鉴定机构" name="jdjg" getdis="true" />
				<input id="sfycrb" type="text" label="是否有传染病" name="sfycrb"  getdis="true" code="sys102"/>
				<input id="jtcrb" type="text" label="具体传染病" name="jtcrb" code="sys037" getdis="true"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>