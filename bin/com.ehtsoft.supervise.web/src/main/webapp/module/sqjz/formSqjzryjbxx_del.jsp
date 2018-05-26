<%@page import="java.util.UUID"%>
<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>个人基本信息-操作页</title>
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
	<div id="sqjz_formSqjzryjbxx" class="container-fluid">
		<div class="row">
			<button style="margin-left:10px;" class="btn btn-default btn-sm" id="formSqjzryjbxx-bj">编辑</button>
			<button style="margin-left:10px;" class="btn btn-default btn-sm" id="formSqjzryjbxx-tj">提交</button>
		</div>
		<div class="tab-content col-sm-12" >
			<div class="tab-pane active" id="jzryjbxx">
			<div id="formJ">
					<span><input id="id" type="hidden" name="id" value="<%=jzryjbxxid%>"/></span>
					<div class="form-group col-sm-2 col-xs-12" style="padding-left:80px;">
						<label for="jbxxfile" class="pull-right" style="width:120px;height:140px;">
							<img id="jzryjbxx_photo" 
							osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=jzryjbxxid%>&icon=per"
							src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=jzryjbxxid%>&icon=per" 
							 style="width:110px;height:140px;">
							<form id="jzryjbxxuploadForm" action="${localCtx}/upload/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=jzryjbxxid%>" 
									method="post" enctype="multipart/form-data" 
									target="importFrame" style="margin:0px;padding:0px;">
								<!-- 文件上传成功或失败的回调方法 -->
								<input type="hidden" name="callback" fixedValue="true" value="callbackJzryjbxxImg" id="jzryjbxxhidden">
								<input type="file" name="fname" id="jbxxfile" style="display:none;">
							</form>
							<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
						</label>
					</div>
					<input col="10" labelCol="3" id="sqjzrybh" type="text" label="服刑人员编号" name="sqjzrybh" getdis="true" valid="{required:true}"/>
					<input col="10" labelCol="3" id="jzjgbm" type="text" label="矫正机构编码" name="jzjgbm" getdis="true"/>
					<input col="10" labelCol="3" id="xm" type="text" label="姓名" name="xm" getdis="true" valid="{required:true,onlyChinese:true}"/>
					<input id="cym" type="text" label="曾用名" name="cym" getdis="true" valid="{onlyChinese:true}"/>
					<input id="xb" type="text" label="性别" name="xb" getdis="true" valid="{required:true}" code="sys000"/>
					<input id="mz" type="text" label="民族" name="mz" getdis="true"  code="sys003"/>
					<input id="gj" type="text" label="国籍" name="gj" getdis="true"  code="sys051" noChild="true"/>
					<input id="sfzh" type="text" label="身份证号" name="sfzh" getdis="true" valid="{required:true,cardNo:true}"/>
					<input id="csrq" type="text" label="出生日期" name="csrq" getdis="true" valid="{required:true,date:true}" class="form_date"/>
					<input id="whcd" type="text" label="文化程度" name="whcd" getdis="true" code="sys028"/>
					<input id="sfcn" type="text" label="是否成年" name="sfcn" getdis="true"  code="sys001"/>
					<input id="wcn" type="text" label="未成年" name="wcn" getdis="true" code="sys035"/>
					<input id="hyzk" type="text" label="婚姻状况" name="hyzk" getdis="true" code="sys030"/>
					<input id="grlxdh" type="text" label="个人联系电话(手机号)" getdis="true" name="grlxdh" valid="{required:true,mobile:true}"/>
					<input id="pqzy" type="text" label="捕前职业" name="pqzy" getdis="true"  code="sys098"/>
					<input id="jyjxqk" type="text" label="就业就学情况" name="jyjxqk" getdis="true" code="sys031"/>
					<input id="xzzmm" type="text" label="现政治面貌" name="xzzmm" getdis="true"  code="sys091"/>
					<input id="yzzmm" type="text" label="原政治面貌" name="yzzmm" getdis="true"  code="sys091"/>
					<input id="yxjtcyjzyshgx" type="text" label="有无家庭成员及主要社会 关系" name="yxjtcyjzyshgx" getdis="true" code="sys102"/>
					<input id="hjdsfyjzdxt" type="text" label="户籍地是否与居住地相同" name="hjdsfyjzdxt" getdis="true"  code="sys001"/>
					<input id="sfdcpg" type="text" label="是否调查评估" name="sfdcpg" getdis="true"  code="sys001"/>
					<input id="dcpgyj" type="text" label="调查评估意见" name="dcpgyj" getdis="true"  code="sys033"/>
					<input id="dcyjcxqk" type="text" label="调查意见采信情况" name="dcyjcxqk" getdis="true"  code="sys034"/>
					<input id="jzlb" type="text" label="矫正类别" name="jzlb" getdis="true"  code="sys017"/>
					<input id="ywhz" type="text" label="有无护照" name="ywhz" getdis="true"  code="sys102"/>
					<input id="hzhm" type="text" label="护照号码" name="hzhm" getdis="true" />
					<input id="ywgatsfz" type="text" label="有无港澳台身份证" name="ywgatsfz" getdis="true"  code="sys102"/>
					<input id="gatsfzlx" type="text" label="港澳台身份证类型" name="gatsfzlx" getdis="true" code="sys046"/>
					<input id="gatsfzhm" type="text" label="港澳台身份证号码" name="gatsfzhm" getdis="true" />
					<input id="hzbczt" type="text" label="护照保存状态" name="hzbczt" getdis="true" code="sys045"/>
					<input id="ywgattxz" type="text" label="有无港澳台通行证" name="ywgattxz" getdis="true"  code="sys102"/>
					<input id="gattxzlx" type="text" label="港澳台通行证类型" name="gattxzlx" getdis="true" code="sys047"/>
					<input id="gattxzhm" type="text" label="港澳台通行证号码" name="gattxzhm" getdis="true"/>
					<input id="gattxzbczt" type="text" label="港澳台通行证保存状态" name="gattxzbczt" getdis="true" code="sys048"/>
					<input id="ywgajmwlndtxz" type="text" label="有无港澳居民往来内地通 行证" name="ywgajmwlndtxz" getdis="true"  code="sys102"/>
					<input id="gajmwlndtxz" type="text" label="港澳居民往来内地通行证 号码" name="gajmwlndtxz"/>
					<input id="gajmwlndtxzbczt" type="text" label="港澳居民往来内地通行证 保存状态" name="gajmwlndtxzbczt" getdis="true" code="sys049"/>
					<input id="ywtbz" type="text" label="有无台胞证" name="ywtbz"  getdis="true" code="sys102"/>
					<input id="tbzhm" type="text" label="台胞证号码" name="tbzhm"getdis="true" />
					<input id="tbzbczt" type="text" label="台胞证保存状态" name="tbzbczt" getdis="true" code="sys050"/>
					<input id="zyjwzxrystzk" type="text" label="暂予监外执行人员身体状 况" name="zyjwzxrystzk" getdis="true" code="sys036"/>
					<input id="zhjzyy" type="text" label="最后就诊医院" name="zhjzyy"/>
					<input id="sfyjsb" type="text" label="是否有精神病" name="sfyjsb" getdis="true"  code="sys102"/>
					<input id="jdjg" type="text" label="鉴定机构" name="jdjg" getdis="true" />
					<input id="sfycrb" type="text" label="是否有传染病" name="sfycrb"  getdis="true" code="sys102"/>
					<input id="jtcrb" type="text" label="具体传染病" name="jtcrb" code="sys037" getdis="true"/>
					<input id="ygzdw" type="text" label="原工作单位" name="ygzdw" getdis="true"/>
					<input id="xgzdw" type="text" label="现工作单位" name="xgzdw" getdis="true" />
					<input id="dwlxdh" type="text" label="单位联系电话" name="dwlxdh" getdis="true"/>
					<input id="qtlxfs" type="text" label="其他联系方式" name="qtlxfs" getdis="true"/>
					
					
					<select id="gdjzdszs" type="text" label="固定居住地所在省（区、 市）" name="gdjzdszs" getdis="true">
					</select>
					<select id="gdjzdszds" type="text" label="固定居住地所在地（市、 州）" name="gdjzdszds" getdis="true">
					</select>
					<select id="gdjzdszxq" type="text" label="固定居住地所在县（市、 区）" name="gdjzdszxq" getdis="true">
					</select> 
					
					
					<input id="gdjzd" type="text" label="固定居住地（乡镇、街道）" name="gdjzd" getdis="true" />
					<input id="gdjzdmx" type="text" label="固定居住地明细" name="gdjzdmx" getdis="true" />
					
					
					<select id="hjszs" type="text" label="户籍所在省（区、市）" name="hjszs" getdis="true">
					</select>
					<select id="hjszds" type="text" label="户籍所在地（市、州）" name="hjszds" getdis="true">
					</select>
					<select id="hjszxq" type="text" label="户籍所在县（市、区）" name="hjszxq" getdis="true">
					</select>
					
					
					<input id="hjszd" type="text" label="户籍所在地（乡镇、街道）" name="hjszd" getdis="true" />
					<input id="hjszdmx" type="text" label="户籍所在地明细" name="hjszdmx" getdis="true" />
					<input id="sfswry" type="text" label="是否三无人员" name="sfswry" getdis="true"  code="sys001"/>
					<input id="jzjg" type="text" label="矫正机构" name="jzjg"/>
					<input id="sqjzjdjg" type="text" label="社区矫正决定机关" name="sqjzjdjg" getdis="true"  code="sys055"/>
					<input id="sqjzjdjgmc" type="text" label="社区矫正决定机关名称" name="sqjzjdjgmc" getdis="true" />
					<input id="zxtzswh" type="text" label="执行通知书文号" name="zxtzswh" getdis="true" />
					<input id="zxtzsrq" type="text" label="执行通知书日期" name="zxtzsrq" getdis="true"  class="form_date"/>
					<input id="jfzxrq" type="text" label="交付执行日期" name="jfzxrq" getdis="true"  class="form_date"/>
					<input id="yjzfjg" type="text" label="移交罪犯机关" name="yjzfjg" getdis="true" code="sys056"/>
					<input id="yjzfjgmc" type="text" label="移交罪犯机关名称" name="yjzfjgmc" getdis="true"/>
					<input id="sfyqk" type="text" label="是否有前科" name="sfyqk" getdis="true"  code="sys001"/>
					<input id="sflf" type="text" label="是否累犯" name="sflf" getdis="true"  code="sys001"/>
					<input id="qklx" type="text" label="前科类型" name="qklx" getdis="true" code="sys057"/>
					<input id="zyfzss" type="text" label="主要犯罪事实" name="zyfzss" getdis="true" />
					<input id="sqjzqx" type="text" label="社区矫正期限" name="sqjzqx" getdis="true" />
					<input id="sqjzksrq" type="text" label="社区矫正开始日期" name="sqjzksrq" getdis="true"  class="form_date"/>
					<input id="sqjzjsrq" type="text" label="社区矫正结束日期" name="sqjzjsrq" getdis="true"  class="form_date"/>
					<input id="fzlx" type="text" label="犯罪类型" name="fzlx" getdis="true"  code="sys014"/>
					<input id="jtzm" type="text" label="具体罪名" name="jtzm" getdis="true" />
					<input id="gzqx" type="text" label="管制期限" name="gzqx" getdis="true" code="sys058"/>
					<input id="hxkyqx" type="text" label="缓刑考验期限" name="hxkyqx" getdis="true" code="sys059"/>
					<input id="sfszbf" type="text" label="是否数罪并罚" name="sfszbf" getdis="true"  code="sys001"/>
					<input id="ypxf" type="text" label="原判刑罚" name="ypxf" getdis="true" code="sys012"/>
					<input id="ypxq" type="text" label="原判刑期" name="ypxq" getdis="true"/>
					<input id="ypxqksrq" type="text" label="原判刑期开始日期" name="ypxqksrq" getdis="true"  class="form_date"/>
					<input id="ypxqjsrq" type="text" label="原判刑期结束日期" name="ypxqjsrq" getdis="true"  class="form_date"/>
					<input id="yqtxqx" type="text" label="有期徒刑期限" name="yqtxqx" code="sys032" getdis="true" />
					<input id="fjx" type="text" label="附加刑" name="fjx"  getdis="true" code="sys013"/>
					<input id="sfwd" type="text" label="是否“五独”" name="sfwd"  getdis="true" code="sys040"/>
					<input id="sfws" type="text" label="是否“五涉”" name="sfws"  getdis="true" code="sys041"/>
					<input id="sfyss" type="text" label="是否有“四史”" name="sfyss"  getdis="true" code="sys038"/>
					<input id="sfbxgjzl" type="text" label="是否被宣告禁止令" name="sfbxgjzl"  getdis="true" code="sys001"/>
					<input id="sqjzryjsrq" type="text" label="社区服刑人员接收日期" name="sqjzryjsrq"  getdis="true" class="form_date"/>
					<input id="sqjzryjsfs" type="text" label="社区服刑人员接收方式" name="sqjzryjsfs" code="sys015" getdis="true" />
					<input id="flwssdsj" type="text" label="法律文书收到时间" name="flwssdsj"  getdis="true" class="form_date"/>
					<input id="flwszl" type="text" label="法律文书种类" name="flwszl" code="sys100"/>
					<input id="bdqk" type="text" label="报到情况" name="bdqk"  code="sys016" getdis="true"/>
					<input id="wasbdqksm" type="text" label="未按时报到情况说明" name="wasbdqksm" getdis="true"/>
					<input id="sfjljzxz" type="text" label="是否建立矫正小组" name="sfjljzxz"  code="sys001" getdis="true"/>
					<input id="jzxzryzcqk" type="text" label="矫正小组人员组成情况" name="jzxzryzcqk" code="sys020"/>
					<input id="sfcydzdwgl" type="text" label="是否采用电子定位管理" name="sfcydzdwgl"  code="sys001" getdis="true"/>
					<input id="dzdwfs" type="text" label="电子定位方式" name="dzdwfs" code="sys060" getdis="true"/>
					<input id="dwhm" type="text" label="定位号码" name="dwhm" getdis="true"/>
					<input id="sftk" type="text" label="是否脱管" name="sftk"  code="sys001" getdis="true"/>
					<input id="jcqk" type="text" label="奖惩情况" name="jcqk"  code="sys001" getdis="true"/>
					<!-- <input id="online" type="text" label="是否在线" name="online" code="sys001"/> -->
					<input id="remark" type="text" label="备注" name="remark" getdis="true"/>
			</div>
			</div>
		</div>
		<!-- </form> -->
	</div>
</body>
</html>