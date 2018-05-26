<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>司法工作人员基本信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JcSfxzJggzryjbxxService.js"></script>
<script type="text/javascript">
	$(function() {
		//连接Service
		var service = new JcSfxzJggzryjbxxService();
		//获取Service里面的数据显示在页面上
		var tableView = new Eht.TableView({
			selector : "#list_JcSfxzJggzryjbxxService #list_tableview"
		});
	
	});
	
</script>

</head>
<body>
<div class="container-fluid" id="list_JcSfxzJggzryjbxxService">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					   <button type="button" class="btn btn-primary" id="btn-primary" style="margin-left: 200px";>修改</button>
				</fieldset>
			</div>
		</div>
<!-- 列表内容 -->
	<div id="list_tableview">
		<div field="xm" label="姓名"></div>
		<div field="ywm" label="英文名"></div>
		<div field="xb"  label="性别"></div>
		<div field="csrq" label="出生日期"></div>
		<div field="sfzh" label="身份证号"></div>
		<div field="mz" label="民族"></div>
		<div field="zzmm" label="政治面貌"></div>
		<div field="hyzk" label="婚姻状况"></div>
		<div field="byyx" label="毕业院校"></div>
		<div field="xl" label="学历"></div>
		<div field="zgxw" label="最高学位"></div>
		<div filed="zy" label="专业"></div>
		<div filed="ssjg" label="所属机构"></div>
		<div filed="zw" label="职务"></div>
		<div filed="rybz" label="人员编制"></div>
		<div filed="sjhm" label="手机号码"></div>
		<div filed="lxdh" label="联系电话"></div>
		<div filed="dzyx" label="电子邮箱"></div>
		<div filed="zz" label="住址"></div>
		<div filed="cjgzsj" label="参加工作时间"></div>
	</div>

		
</div>

</body>
</html>