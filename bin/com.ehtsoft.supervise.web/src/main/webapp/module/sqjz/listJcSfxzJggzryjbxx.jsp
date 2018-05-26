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
			selector : "#list_JcSfxzJggzryjbxxService #list_tableview",
			autolayout:true,		
			});
		var query={}
		//页面显示获取数据库的信息
		tableView.loadData(function(page,res) {
			service.findOrgid(query,page,res);
		});
		//模态框里面的点击事件，自适应布局
		var form = new Eht.Form({
			selector:'#list_JcSfxzJggzryjbxxService #jzjzlxx-form',
			autolayout:true,
			formCol:2,
			});	
		//模态框
		$('#modification').click(function(){
			form.clear();
			$('#myModal').modal('show');
		});
//点击列表把数据带进模态框
		tableView.clickRow(function(query){
			console.log(query);
			$('#modification').attr("disabled",false); 
			$("#modification").click(function(data){
				form.fill(query);
			});
		});
		
//修改禁用
		$('#modification').attr("disabled",true);
		//保存
		$("#submit").click(function(data){
				if(form.validate()){
					service.update(form.getData(),
							new Eht.Responder({success:function(data){
								$('#myModal').modal('hide');
								tableView.refresh();
								
						},
					}));
				}
			});
		//查询信息
		$("#list_JcSfxzJggzryjbxxService #query_cx").click(function(){
			query["xm[like]"] = $("#cxxm").val();
			query["sjhm[like]"] = $("#cxsjh").val();
			tableView.refresh();
		});
		
	});
	
	
</script>

</head>
<body>
<div class="container-fluid" id="list_JcSfxzJggzryjbxxService">
		<div class="panel panel-default" >
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
				 	姓名:<input class="btn btn-default" 	type="text" id="cxxm"		name="xm"  placeholder="请正确输入姓名"  style="margin-left: 10px;"/> 
					 手机号:<input class="btn btn-default"type="text" 	id="cxsjh"		name="grlxdh"   placeholder="请正确输入手机号"  style="margin-left: 10px;"/>
					  <input class="btn btn-default " 	type="button" id="query_cx" 	value="查询" style="margin-left: 10px;">
					  <input class="btn btn-default" 	type="button" id="modification" value="修改" style="margin-left: 10px;">
				</fieldset>
			</div>
		</div>
<!-- 列表内容 -->
	<div id="list_tableview">
		<div field="op" checkbox="true" label="选择"></div>
		<div field="xm" 	label="姓名"></div>
		<div field="xb"  	label="性别" code="sys000"></div>
		<div field="csrq" 	label="出生日期"></div>
		<div field="sfzh" 	label="身份证号"></div>
		<div field="mz" 	label="民族" code="sys003"></div>
		<div field="zzmm" 	label="政治面貌" code="sys091"></div>
		<div field="hyzk" 	label="婚姻状况" code="sys030"></div>
		<div field="byyx" 	label="毕业院校"></div>
		<div field="xl" 	label="学历" code="sys093"></div>
		<div field="zgxw" 	label="最高学位" code="sys094"></div>
		<div field="zy" 	label="专业" code="sys095"></div>
		<div field="ssjg" 	label="所属机构"></div>
		<div field="zw" 	label="职务"></div>
		<div field="rybz" 	label="人员编制" code="sys007"></div>
		<div field="sjhm" 	label="手机号码"></div>
		<div field="lxdh" 	label="联系电话"></div>
		<div field="dzyx" 	label="电子邮箱"></div>
		<div field="zz" 	label="住址"></div>
		<div field="cjgzsj" label="参加工作时间"></div>
	</div>
	
<!-- 模态框 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</Button>
						<h4 class="modal-title" id="myModalLabel">修改司法工作人员基本信息</h4>
					</div>
					<div class="modal-body" style="height:490px; overflow: auto">
					<div class="modal-body">
						<div id="jzjzlxx-form">
							<input type="text" name="rybm" 	label="人员编码" valid="{required:true}" disabled>
							<input type="text" name="xm"	label="姓名" 	valid="{required:true}"  disabled >
							<input type="text" name="ywm" 	label="英文名"	valid="{required:true,ENname:true}">
							<input type="text" name="xb"	label="性别"		valid="{required:true}"	code="sys000">
							<input type="text" name="csrq"	label="出生日期" valid="{date:true,required:true}" class="form_date" data-date-format="yyyy-MM-dd">
							<input type="text" name="sfzh"	label="身份证号"	valid="{cardNo:true,int:true,required:true}">
							<input type="text" name="mz" 	label="民族"		valid="{required:true}" code="sys003">
							<input type="text" name="zzmm"	label="政治面貌"	valid="{required:true}" code="sys091">
							<input tyep="text" name="hyzk"	label="婚姻状况"	valid="{required:true}" code="sys030">
							<input type="text" name="byyx"	label="毕业院校"	valid="{required:true}"	>
							<input type="text" name="xl"	label="学历" code="sys093">
							<input type="text" name="zgxw" 	label="最高学位"	valid="{required:true}" code="sys094">
							<input type="text" name="zy"	label="专业"		valid="{required:true}" code="sys095">
							<input type="text" name="ssjg"	label="所属机构"	valid="{required:true,onlyChinese:true}" >
							<input type="text" name="zw"	label="职务"		valid="{required:true,onlyChinese:true}">
							<input type="text" name="rybz"	label="人员编制"	valid="{required:true}" code="sys007">
							<input type="text" name="sjhm"	label="手机号码"	valid="{mobile:true,,required:true}">
							<input type="text" name="lxdh"	label="联系电话"	valid="{required:true,required:true,int:true}">
							<input type="text" name="dzyx"	label="电子邮箱"	valid="{email:true,required:true}">
							<input type="text" name="zz"	label="住址"		valid="{required:true}">
							<input type="text" name="cjgzsj"label="参加工作时间"	valid="{date:true,required:true}" class="form_date" data-date-format="yyyy-MM-dd">
						</div>
					</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="submit">确认更新</button>
					</div>
				</div>
			</div>
		</div>
		
</div>

</body>
</html>