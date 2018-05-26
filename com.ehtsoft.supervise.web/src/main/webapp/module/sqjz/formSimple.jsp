<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息录入</title>
<jsp:include page="../ltrhao-app.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/FormSimpleServise.js"></script>
<script type="text/javascript" src="${localCtx}/resources/jss/formSimple.js?<%=Math.random() %>"></script>
<script type="text/javascript">

</script>
<style>
.formSimple-gdlb{
	position: relative;
	padding-left:200px;
    margin-top: 20px;
}
</style>
</head>
<body>
	<div id="formSimple-body">
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="JzTaf-Form">
					<div>
						<input type="hidden" value="${param.id}" fixedValue="true" name="id"/>
					</div>
						<input type="text" id="sqjzrybh" autoComplete="off"  name="sqjzrybh" label="社区服刑人员编号" valid="{required:true}"/>
						<input type="text" name="jglx" label="矫管类型" getdis="true"  valid="{required:true}" code="sys114" />
						<input type="text" label="矫正机构编码" name="jzjgbm" getdis="true"  />
						<input type="text" label="矫正机构" name="jzjg" getdis="true"  />
						<input type="text" id="xm" autoComplete="off"  name="xm" label="姓名" valid="{required:true}"/>
						<input type="text" name="cym" label="曾用名" getdis="true"  valid="{required:true}"/>
						<input type="text" name="xb" label="性别" getdis="true"  valid="{required:true}" code="sys000" />
						<input type="text" name="mz" label="民族" getdis="true"  valid="{required:true}" code="sys003" />
						<input type="text" name="sfzh" label="身份证号" getdis="true"  valid="{required:true,cardNo:true}" />
						<input type="text" name="csrq" label="出身日期" getdis="true"  valid="{required:true}" />
						<input type="text" name="sfcn" label="是否成年"  getdis="true"  code="sys001"/>
						<input type="text" name="wcn" label="未成年"  getdis="true"  code="sys035"/>
						<input type="text" label="婚姻状况" name="hyzk"  getdis="true" />
						<input type="text" label="原政治面貌" name="yzzmm" getdis="true"  code="sys091"/>
						<input type="text" label="现政治面貌" name="xzzmm" getdis="true"  code="sys091"/>
						<input type="text" name="grlxdh" label="手机号" getdis="true"  valid="{required:true}" />
						<input type="text" label="捕前职业" name="pqzy" getdis="true"  code="sys098"/>
						<input type="text" label="文化程度" name="whcd" getdis="true" code="sys028"/>
						<input type="text" label="现工作单位" name="xgzdw" getdis="true" />
						<input type="text" label="原工作单位" name="ygzdw" getdis="true" />
						<input type="text" name="dwlxdh" label="单位联系电话" getdis="true"  valid="{required:true}" />
						<input type="text" name="qtlxfs" label="其他联系方式" getdis="true"  valid="{required:true}" />
						<input id="sfswry" type="text" label="是否三无人员" name="sfswry" getdis="true"  code="sys001"/>
						<input id="jyjxqk" type="text" label="就业就学情况" name="jyjxqk" getdis="true" code="sys031"/>
				</div>
				<div id="formSimple-gd">
					<input id="formSimple-djgd" type="button" value="点击展开添加更多选项..."/>
					<input id="formSimple-sq" type="button" value="收起..."/>
				</div>
				<div id="formSimple-gdlb" style="display:none;">
					<div class="formSimple-gdlb">
						<input id="formSimple-gdlb-fjsf" type="button" value="单击添加服刑人员-附加身份信息"/>
					</div>
					<div class="formSimple-gdlb">
						<input id="formSimple-gdlb-jzxx" type="button" value="单击添加服刑人员-矫正信息"/>
					</div>
					<div class="formSimple-gdlb">
						<input id="formSimple-gdlb-fzxx" type="button" value="单击添加服刑人员-犯罪信息"/>
					</div>
					<div class="formSimple-gdlb">
						<input id="formSimple-gdlb-xgdz" type="button" value="单击添加服刑人员-相关地址"/>
					</div>
					<div class="formSimple-gdlb">
						<input id="formSimple-gdlb-jkxx" type="button" value="单击添加服刑人员-健康信息"/>
					</div>
				</div>
				<div style="position: fixed;bottom: 0px;right: 0px; margin: 10px;">
					<button id="edit" class="btn btn-default" type="button">修改</button>
					<button id="submit" class="btn btn-primary"  disabled="true" type="button">提交</button>
				</div>
				<!-- 模态框（Modal） -->
				<div class="modal fade" id="myModal">
					<div class="modal-dialog ">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="false" id="xxx">×</button>
								<h4 class="modal-title" id="myModalLabel">附加信息</h4>
							</div>
							<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
								
							</div>
							<div class="modal-footer">
						        <button type="button" class="btn btn-default" id="close" data-dismiss="modal">关闭</button>
						        <button type="button" class="btn btn-primary" id="btn-primary">提交</button>
						    </div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>	
			</div>
		</div>
	</div>
</body>
</html>