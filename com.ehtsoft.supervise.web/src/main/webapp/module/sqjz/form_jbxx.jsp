<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息录入</title>
<style>
.text-input{
		text-align: center;
	}
.formSimple-gdlb{
	position: relative;
	padding-left:200px;
    margin-top: 20px;
}
 #sqjzryjbxx_form_jbxx table{
	border-collapse:collapse;
	width:100%;
}
 #sqjzryjbxx_form_jbxx td{
	text-align:center;
	width:100px;
	font-weight: bold;
}
#sqjzryjbxx_form_jbxx td>textarea{
	width:100%;
	text-align:center;
	line-height:40px;
	height:40px;
	border: none;
	resize: none;
	overflow: hidden;
	
}
#sqjzryjbxx_form_jbxx tr{
	height:40px;
}
 #sqjzryjbxx_form_jbxx td>input{
	border:none;
	text-align: center;
	width: 100%;
}
 #sqjzryjbxx_form_jbxx .all div{
	width:600px;
	display: inline;
	margin: 10px;
}
</style>
</head>
<body>
	
	
	<div id="formSimple-body">
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="sqjzryjbxx_form_jbxx">
					<div id="jzry_id">
						<span><input id="id" type="hidden" name="id" value="${param.id}" fixedValue="true"/></span>
					</div>	
						<table border="1" cellspacing="0" id="table_view" align="center">
							<tr style="height:height: 30px;font-size: 20px;">
								<td colspan="7">基&nbsp;&nbsp;本&nbsp;&nbsp;身&nbsp;&nbsp;份&nbsp;&nbsp;信&nbsp;&nbsp;息</td>
							</tr>
								<tr>
									<td >是否调查评估</td>
									<td>
										<input radio="true" name="sfdcpg" label="是否调查评估" valid="{required:true}"code="sys001"/>
									</td>
									
									<td colspan="2">评估意见采信情况</td>
									<td colspan="2">
										<input  name="dcyjcxqk" label="评估意见采信情况" valid="{required:true}" code="sys034" radio="true" style="margin-left: 6px;padding: 0px;"/>
									</td>
									<td rowspan="3">
										<label for="jbxxfile" style="width:120px;height:140px;">
											<img id="jzryjbxx_photo" 
												src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per" 
												osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per"
												 style="width:110px;height:140px; "/>
											<span id="photo_remark" style="font-size: 1px;">照片格式:JPG 格式，分辨率 295*413，大小不超 100KB</span>
											<form id="jzryjbxxuploadForm" action="${localCtx}/upload/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}" 
												method="post" enctype="multipart/form-data" 
												target="importFrame" style="margin:0px;padding:0px;">
													<!-- 文件上传成功或失败的回调方法 -->
												<input type="hidden" name="callback" fixedValue="true" value="callbackJzryjbxxImg" id="jzryjbxxhidden">
												<input type="file" name="fname" id="jbxxfile" style="display:none;" onchange="Javascript:validate_img(this);">
											</form>
											<iframe name="importFrame" style="width:0;height:0;display:none;"></iframe>
										</label>
									</td>
								</tr>
								<tr>
									<td>评估意见</td>
									<td colspan="5">
										<input radio="true" label="评估意见" valid="{required:true}"name="dcpgyj" style="margin-left: 35px;" code="sys033"/>
									</td>
								</tr>
								<tr>
									<td>矫正类别</td>
									<td colspan="5" id="jzlb">
										<input  name="jzlb" label="矫正类别" valid="{required:true}" code="sys017" radio="true" valid="{requierd:true}"/>
										
									</td>
								</tr>
								<tr>
									<td >是否成年</td>
									<td colspan="2" id="sfcn">
										<input  name="sfcn" label="是否成年"  code="sys001" radio="true" label="是否成年" valid="{requierd:true}"/>
									</td>
									<td >未成年</td>
									<td colspan="3" id="wcn">
										<input  name="wcn" radio="true" code="sys035"/>
									</td>
								</tr>
								<tr>
									<td>人员编号</td>
									<td colspan="6"><input name="sqjzrybh" id="sqjzrybh" label="人员编号" valid="{required:true}" type="text" style="height: 40px;">
								</tr>
								<tr>
									<td>姓名</td>
									<td colspan="2"><input style="height: 46px;"label="姓名" valid="{required:true}" type="text" name="xm" id="xm" valid="{requierd:true}"></td>
									<td>曾用名</td>
									<td colspan="3"><input style="height: 46px;" type="text" name="cym" id="cym"></td>
								</tr>
								<tr>
									<td>性别</td>
									<td colspan="2">
										<input  name="xb" code="sys000" label="性别" valid="{required:true}" radio="true" valid="{requierd:true}"/>
										
									</td>
									<td>民族</td>
									<td colspan="3" id="mz">
										<input  name="mz" code="sys003"label="民族" valid="{required:true}" type="input" style="width:100%;height: 40px;border: none;" valid="{requierd:true}"/>
									
									</td>
								</tr>
								<tr>
									<td>身份证号</td>
									<td colspan="2"><input style="height: 46px;"label="身份证号" valid="{required:true,cardNo:true}" type="text" name="sfzh" id="sfzh" valid="{cardNO:true}"></td>
									<td>出生日期</td>
									<td colspan="3"><input style="height: 46px;" type="text" name="csrq" id="csrq" getdis="true" label="出生日期" valid="{required:true,date:true}"></textarea></td>
								</tr>
								<tr>
									<td>有无港澳台身份证</td>
									<td colspan="2" id="ywgatsfz">
										<input radio="true" name="ywgatsfz"   code="sys102"label="有无港澳台身份证" valid="{required:true}"/>
									</td>
									<td>港澳台身份证号码</td>
									<td colspan="3"><input type="text" name="gatsfzhm" id="gatsfzhm" style="height: 55px;"label="港澳台身份证号码" valid="{number:true}"></td>
								</tr>
								<tr>
									<td>港澳台身份证类型</td>
									<td id="gatsfzlx" colspan="6">
										<input mult="true" name="gatsfzlx" style="margin-left: 5px;" code="sys046"/>
									</td>
								</tr>
								<tr>
									<td>有无护照</td>
									<td  id="ywhz">
										<input radio="true" name="ywhz"  code="sys102" label="有无护照" valid="{required:true}"/>
									</td>
									<td>护照号码</td>
									<td colspan="2"><input style="height: 46px;" name="hzhm" id="hzhm" type="text"label="护照号码" valid="{number:true}"></td>
									<td>护照状态</td>
									<td id="hzbczt">
										<input type="input" name="hzbczt"  code="sys045"style="width:100%;height: 47px;border: none;" />
									</td>
								</tr>
								<tr>
									<td>有无港澳台通行证</td>
									<td id="ywgattxz"colspan="2">
										<input radio="true" name="ywgattxz"  code="sys102"label="有无港澳台通行证" valid="{required:true}"/>
									</td>
									<td>港澳台通行证状态</td>
									<td colspan="3" id="gattxzbczt">
										<input type="input"" name="gattxzbczt" style="width:100%;height:40px;border: none;text-align: center;" code="sys045"/>
									</td>
								</tr>
								<tr>
									<td>港澳台通行证类型</td>
									<td id="gattxzlx" colspan="6">
										<input radio="true" name="gattxzlx"style="margin-left: 25px;"  code="sys047"/>
									</td>
								</tr>
								<tr>
									<td>港澳台通行证号码</td>
									<td colspan="6">
										<input  name="gattxzhm" id="gattxzhm" type="text" style="height:41px;"label="港澳台通行证号码" valid="{number:true}"></td>
								</tr>
								<tr>
									<td>有无港澳居民往来内地通行证</td>
									<td id="ywgajmwlndtxz">
										<input radio="true" name="ywgajmwlndtxz" value="0" code="sys102" label="有无港澳居民往来内地通行证" valid="{required:true}"/>
									
									</td>
									<td>港澳居民往来内地通行证号码</td>
									<td colspan="2"><input type="text" style="height: 61px;" name="gajmwlndtxz" id="gajmwlndtxz"label="港澳居民往来内地通行证号码" valid="{number:true}"></td>
									<td>港澳居民往来内地通行证状态</td>
									<td id="gajmwlndtxzbczt">
										<input type="input" name="gajmwlndtxzbczt"style="width:100%;height: 61px;border: none;"  code="sys045"/>
									</td>
								</tr>
								<tr>
									<td>有无台胞证</td>
									<td id="ywtbz">
										<input radio="true" name="ywtbz" code="sys102"label="有无台胞证" valid="{required:true}"/>
									</td>
									<td>台胞证号码</td>
									<td colspan="2"><input style="height: 46px;" name="tbzhm" id="tbzhm" type="text"label="台胞证号码" valid="{number:true}"></td>
									<td>台胞证状态</td>
									<td id="tbzbczt">
										<input type="input" name="tbzbczt" style="width:100%;height: 46px;border: none;" code="sys045"/>
									</td>
									
								</tr>
								<tr id="zyjw" style="display:none;">
									<td>暂予监外执行人员身体状况</td>
									<td colspan="6" id="zyjwzxrystzk" >
										<input radio="true" name="zyjwzxrystzk" code="sys036" valid="{required:true}"/>
									</td>
								</tr>
								<tr id="zhjzyy" style="display: none;">
									<td>就诊医院</td>
									<td colspan="6"><input id="yy" style="height: 46px;"label="就诊医院" valid="{required:true}" name="zhjzyy"  type="text"></textarea></td>
								</tr>
								<tr>
									<td>是否有精神病</td>
									<td colspan="2" id="sfyjsb">
										<input radio="true" name="sfyjsb"  code="sys001"label="是否有精神病" valid="{required:true}"/>
                              		</td>
									<td>鉴定机构</td>
									<td colspan="3"><input type="text"label="鉴定机构" valid="{onlyChinese:true}" style="height: 46px;" name="jdjg" id="jdjg"></textarea></td>
								</tr>
								<tr>
									<td>是否有传染病</td>
									<td colspan="2" id="sfycrb">
										<input radio="true" name="sfycrb"  code="sys001"label="是否有传染病" valid="{required:true}"/>
									</td>
									<td>具体传染病</td>
									<td colspan="3" id="jtcrb">
										<input type="input" name="jtcrb" style="width:100%;height: 40px;border: none;" code="sys037"/>
									</td>
								</tr>
								<tr>
									<td>文化程度</td>
									<td colspan="2">
										<input type="input" name="whcd" style="width:100%;height: 54px;border: none;text-align: center;" code="sys028"label="文化程度" valid="{required:true}"/>
									</td>
									<td>捕前职业</td>
									<td colspan="3">
										<input type="input" name="pqzy" style="width:100%;height: 54px;border: none;text-align: center;" code="sys098"label="文化程度" valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>婚姻状况</td>
									<td colspan="6">
										<input radio="true" name="hyzk"  code="sys030"style="margin-left: 6px;" label="文化程度" valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>就业就学情况</td>
									<td colspan="6">
										<input radio="true" name="jyjxqk"  code="sys031"style="margin-left: 6px;"label="文化程度" valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>现政治面貌</td>
									<td colspan="2">
										<input type="input" name="xzzmm" style="width:100%;height: 46px;border: none;text-align: center;" code="sys091"label="文化程度" valid="{required:true}"/>
									</td>
									<td>原政治面貌</td>
									<td colspan="3">
										<input type="input" name="yzzmm" style="width:100%;height: 46px;border: none;text-align: center;" code="sys091"label="文化程度" valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>现工作的单位</td>
									<td colspan="4"><input type="text"label="现工作的单位" valid="{hasChinese:true}" style="height: 46px;" name="xgzdw"></td>
									<td>单位联系电话</td>
									<td><input style="height: 46px;" label="单位联系电话" valid="{number:true}" type="text" name="dwlxdh"></textarea></td>
								</tr>
								<tr>
									<td>国籍</td>
									<td colspan="4">
										<input radio="true" name="gj" label="国籍" valid="{required:true}" code="sys051"/>
									</td>
									<td>个人联系电话</td>
									<td colspan="1"><input style="height: 46px" label="个人联系电话" valid="{number:true,required:true}" type="text" name="grlxdh" id="grlxdh"></td>
								</tr>
								<tr>
								<td>指派机构</td>
									<td colspan="6">
										<select id="jgmc" name="sfsid"label="指派机构"  style="margin: 0px;width:100%;max-width: none;"></select>
									</td>
								</tr>
							<tbody id="dzxx">	
								<tr>
									<td>户籍地是否与居住地相同</td>
									<td colspan="6" id="hjdsfyjzdxt">
										<input radio="true" name="hjdsfyjzdxt" code="sys001"label="文化程度" valid="{required:true}"/>
									</td>
								</tr>
								<tr>
									<td>居住地详细地址</td>
									<td colspan="6">
										<div>
											<select name="gdjzdszs" type="text" id="gdjzdszs" getdis="true"label="文化程度" valid="{required:true}">
			      							</select>&nbsp;&nbsp;
			      							<select name="gdjzdszds" type="text" id="gdjzdszds" getdis="true"label="文化程度" valid="{required:true}">
			      								<option value="" selected="selected">---选择盟市---</option>
			      							</select>&nbsp;&nbsp;
			      							<select name="gdjzdszxq" type="text"  id="gdjzdszxq" getdis="true"label="文化程度" valid="{required:true}">
			      								<option value="" selected="selected">---选择旗县---</option>
			      							</select>&nbsp;&nbsp;
			      							<input type="text" id="gdjzdmx" name="gdjzdmx" style="height:20px;" placeholder="请填写详细地址" getdis="true"label="详细地址" valid="{hasChinese:true,required:true}" >
			      						</div>
									</td>
								<tr>
									<td>户籍地详细地址</td>
									<td colspan="6">
										<div>
											<select name="hjszs" type="text" id="hjszs" getdis="true" style="margin-left: 48px;"label="文化程度" valid="{required:true}">
			      							</select>&nbsp;&nbsp;
			      							<select name="hjszds" type="text" id="hjszds" getdis="true"label="文化程度" valid="{required:true}">
			      								<option value="" selected="selected">---选择盟市---</option>
			      							</select>&nbsp;&nbsp;
			      							<select name="hjszxq" type="text" id="hjszxq" getdis="true"label="文化程度" valid="{required:true}">
			      								<option value="" selected="selected">---选择旗县---</option>
			      							</select>&nbsp;&nbsp;
			      							<input type="text" id="hjszdmx" name="hjszdmx" style="height: 20px;" placeholder="请填写详细地址" getdis="true"label="详细地址" valid="{hasChinese:true,required:true}">
			      							
			      						</div>
		      						</td>
								</tr>
							</tbody>
						
						</table>
				
				</div>
			</div>
		</div>
	</div>
</body>
</html>