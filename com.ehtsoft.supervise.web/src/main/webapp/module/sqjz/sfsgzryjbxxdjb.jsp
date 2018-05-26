<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<%@page import="com.ehtsoft.fw.utils.Util"%>
<%@page import="java.util.UUID"%>

<html>
<head>
<title>司法所工作人员基本信息登记表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzDcpgxxService.js"></script>
<script type="text/javascript">

	$(function() {
		var form = new Eht.Form({
			selector : '#sqjz_fromDcpg_add_form'
		});
		var sfzh=new Eht.Form({
			selector : '#sfzh'
		$("#sqjz_listDcpg_all #btn-primary").click(function() {
			console.log(form.getData());
			var service = new JzDcpgxxService();
			service.save(form.getData(), new Eht.Responder({
				success : function() {
					$("#tableaaa").refreshTable();
					$('#sqjz_listDcpg_all #myModal').modal('hide');
				}
			}));
		});
	});
	$("#sqjz_listDagl_all #quxiaobtnCj").click(function(){//单击取消按钮
		$("#sqjz_listDagl_all #hideDivCj").hide();
	});
	//填写逻辑：月视图
	$("#formSqjzryjbxx_ws .form_date").datetimepicker({
	       format: "yyyy-mm-dd",
	       autoclose: true,
	       todayBtn: true,
	       todayHighlight: true,
	       showMeridian: true,
	       pickerPosition: "bottom-left",
	       language: 'zh-CN',//中文，需要引用zh-CN.js包
	        startView: 2,//月视图
	        minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
	});
</script>
<style type="text/css">
	.ds{
		width: 900px;
		margin-left: 260px;
		
	}
	.dm{
		width: 450px;
	}
	
	.dd{
		margin: 0 auto;
		
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
<div class="ds" >
	<h3 align="center">司法所工作人员基本信息登记表</h3><br/>
	<div id="sqjz_fromDcpg_add " >
		<div id="sqjz_fromDcpg_add_form">
			
			<div class="row form-group">
				<div class="col-sm-10 control-label" >
					<div class="row form-group">
						<label for="firstname" class="col-sm-2 control-label">司法所编码：</label>
						<div class="col-sm-3">
						<input name="sfsbm" type="text" class="form-control"
						id="firstname" placeholder="司法所编码">
					</div>
						<label for="firstname" class="col-sm-2 control-label" >人员编码:</label>
						<div class="col-sm-3 ">
							<input name="rybm" type="text" class="form-control"
								id="firstname" placeholder="人员编码">
						</div>
					</div>
					<div class="row form-group">
						<label for="lastname" class="col-sm-2 control-label">姓名:</label>
						<div class="col-sm-3 " >
						<input name="xm" type="text" class="form-control" id="lastname"
							placeholder="姓名" >
						</div>
						<label for="lastname" class="col-sm-2 control-label">性别：</label>
						<div class="col-sm-3 div">
							<input type="text" name="mz" code="sys000" class="form-control" id="lastname" label="性别"> 
						</div>
				   </div>
				
				<div class="row form-group" >
					<label for="lastname" class="col-sm-2 control-label">身份证号码：</label>
					<div class="col-sm-3 div" style="margin-right: 0"id="sfzh" >
						<input name="ffzhm" type="text" class="form-control" id="lastname"
						valid="{required:true,cardNo:true}" placeholder="身份证号码" >
					</div>
					 <label for="lastname" class="col-sm-2 control-label">出生年月：</label>
						<div class="col-sm-3">
							<div class="input-group input-group-sm">
						   		<input name="csny" type="text" class="form-control form_date" data-date-format="yyyy-MM" id="lastname formSqjzryjbxx_ws">
						    	<span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
					    	</div>
						</div>
					</div>
				</div>
				
				<div class="col-sm-2 control-label dd">
					<label for="jbxxfile" style="width:120px;height:140px;">
					<img id="jzryjbxx_photo" 
						src="${l8}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=id%>&icon=per" 
						osrc = "${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=<%=id%>&icon=per"
						 style="width:110px;height:140px; "/>
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
			</div>
			
			
			<div class="row form-group" id="list_mz ">
				<label for="lastname" class="col-sm-2 control-label">民族：</label>
				<div class="col-sm-10 div">
					<input type="text" name="mz" code="sys003" class="form-control" id="lastname" label="民族"> 
				</div>
			</div>
			<div class="row form-group" id="list_mz ">
				<label for="lastname" class="col-sm-2 control-label">政治面貌：</label>
				<div class="col-sm-10 div">
					<input type="text" name="zzmm" code="sys091" class="form-control" id="lastname" label="政治面貌"> 
				</div>
			</div>
			
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">人员类型:</label>
				<div class="col-sm-10">
					<select name="rylx" class="form-control" id="lastname"> 
						<option value=""></option> 
						<option value="01">政法专项编制</option>
						<option value="02">地方行政编制</option>
						<option value="03">地方事业编制</option>
						<option value="04">政府购买服务人员</option>
						<option value="05">其他聘用人员</option>
						<option value="06">兼职</option>
						<option value="99">其他</option>
					</select>
				</div>
			</div>
			<div class="row form-group" id="list_mz ">
				<label for="lastname" class="col-sm-2 control-label">学历：</label>
				<div class="col-sm-10 div">
					<input type="text" name="xl" code="sys093" class="form-control" id="lastname" label="学历"> 
				</div>
			</div>
			<!-- <div class="row form-group" id="list_mz ">
				<label for="lastname" class="col-sm-2 control-label">专业：</label>
				<div class="col-sm-10 div">
					<input type="text" name="zy" code="sys026" class="form-control" id="lastname" label="专业"> 
				</div>
			</div> -->
			
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">毕业学校：</label>
				<div class="col-sm-10 div" >
					<input name="byxx" type="text" class="form-control" id="lastname"
						placeholder="毕业学校" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">联系电话：</label>
				<div class="col-sm-10 div" >
					<input name="dhhm" type="text" class="form-control"  id="lastname"
						 placeholder="联系电话" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">手机：</label>
				<div class="col-sm-10 div" >
					<input name="sj" type="text" class="form-control"  id="lastname"
						valid="{mobile:true}" placeholder="手机" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">电子邮箱：</label>
				<div class="col-sm-10 div" >
					<input name="dzyx" type="text" class="form-control"  id="lastname"
						 placeholder="电子邮箱" >
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">参加工作时间：</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="cjgzsj" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group">
				<label for="lastname" class="col-sm-2 control-label">参加司法工作时间：</label>
				<div class="col-sm-10">
					<div class="input-group input-group-sm">
					    <input name="cjsfgzsj" type="text" class="form-control form_date" data-date-format="yyyy-MM-dd" id="lastname">
					    <span class="input-group-addon calendar"><span class="glyphicon glyphicon-calendar"></span></span>
				   </div>
				</div>
			</div>
			<div class="row form-group"  align="right">
				<button type="button" class="btn btn-default quxiaobtnCj sqjz_listDcpg_all" data-dismiss="modal">关闭</button>
							<button id="dagl_list_btn_primary" type="button" class="btn btn-primary sqjz_listDcpg_all">提交</button>
			</div>
		</div>
	</div>
</div>
</body>
</html>