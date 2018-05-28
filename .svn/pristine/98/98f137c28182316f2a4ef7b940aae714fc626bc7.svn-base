<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>矫正人员居住地变更情况监管</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzryjzdbgService.js"></script>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<style type="text/css">
.modal-lg{
	width:600px;
}
td{
   	text-align:center;
   	width:70px;
   	height:60px;
   	
   }
textarea{
	resize:none;
}
.combo-select{
    max-width:500px;
}   

</style>
<script type="text/javascript">
	$(function(){
		
	//省区联动
	var region = new RegionService();//省市区后台
	region.find(1,null,new Eht.Responder({//省份初始化
		success:function(data){
			for (var i = 0; i < data.length; i++) {
				$("#qrdszs").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
			}
		}
	}));  
	$("#qrdszs").blur(function(){
		region.find(2,$("#qrdszs").val(),new Eht.Responder({
		success:function(data){
			for (var i = 0; i < data.length; i++) {
				$("#qrdszd").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
			}
		}
	}));
	$("#qrdszd").blur(function(){	
		region.find(3,$("#qrdszd").val(),new Eht.Responder({
			success:function(data){
			$("#qrdszx").empty();
				for (var i = 0; i < data.length; i++) {
					$("#qrdszx").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
			}	
		}));
	 });
	});
		//获取系统当前时间
		var nowTime=new Date().format("yyyy-MM-dd");
		var jzdbg = new JzryjzdbgService();
		var form = new Eht.Form({
			selector:"#tqcx_field"
		});
		var formModelsq = new Eht.Form({
			selector:"#jzdbg_model_field",
			autolayout:true	
		});
		var formModelxq = new Eht.View({
			selector:"#jzdbgxq_model_field",
			fieldname:"field"
		});
		//textaera的计数
		formModelsq.charValid(function(name,min,max){
			if(name=="jzdbgsy"){
				$("#count").html(min+"/"+max);
				var dl =min/max;
				if( dl> 3/4 ){
					$("#count").css("color","#f00");
				}else{
					$("#count").css("color","#00f");
				}
			}
		});
		
		var formModelsp = new Eht.Form({
			selector:"#sbsp_modal_form",
			autolayout:true	
		});
		
		formModelsp.charValid(function(name,min,max){
			var dc =min/max;
			if(name=="sfsshyj"){
				$("#count2").html(min+"/"+max);
				if( dc > 3/4 ){
					$("#count2").css("color","#f00");
				}else{
					$("#count2").css("color","#00f");
				}
			}
			if(name=="xsfjspyj"){
				$("#count3").html(min+"/"+max);
				if( dc > 3/4 ){
					$("#count3").css("color","#f00");
				}else{
					$("#count3").css("color","#00f");
				}
			}
		});
	
		var table = new Eht.TableView({
			selector:"#jzdbg_list_all #tableview "
		});
		
		//获取form表单的值
		var query = {};
		//页面加载时
		table.loadData(function(page,res){
			 jzdbg.find(query,page,res);
		});
		//添加操作按钮
		table.transColumn("cz",function(data){
				var dv = $("<div></div>");
				var btn1 = $('<button id="xqan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon-sound-6-1" ></span>&nbsp;提请情况</button>');
				var btn2 = $('<button id="shan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon-sound-6-1" ></span>&nbsp;审批</button>');
				btn1.data(data);
				btn2.data(data);
				btn1.click(function(){
					jzdbg.findOne(data.id,new Eht.Responder({//根据ID查询个人基本信息
						success:function(data){
				 		formModelxq.fill(data);
						}
					}));
				  $("#jzdbg_list_all #jzdbgxq_Modal").modal({backdrop: 'static', keyboard: false});//弹出模态框
					
				});
				btn2.click(function(){
					var ds = $(this).data();
					formModelsp.fill(ds);
					$("#sfsshsj").val(nowTime);	
					$("#xsfjspsj").val(nowTime);	
				 	$("#jzdbg_list_all #jzdbgsp_myModal").modal({backdrop:'static'});
					
				});
			//判断审核按钮
			if(orgType==3 && data.xsfjspyj==null ){
				dv.append(btn1,btn2);
				
			}else if(orgType==4 && data.sfsshyj==null){
				dv.append(btn1,btn2);
			}
			else{
				dv.append(btn1);
			}
				return dv;
		});
		
		//查询单条数据
		$("#querybtn").click(function(){
			 query.audit = $("#spzt").val(); 
			/* query["audit[eq]"] = $("#spzt").val(); */
			query["xm[like]"] = $("#searchXm").val();
			table.refresh();
		})
		
		//添加上报模态框添加
		$("#jzdbg_list_all #addbtn").click(function(){
			//动态添加审批历史记录信息
	  			jzdbg.findJzry({},new Eht.Responder({
				success:function(data){
				$("#jzdbgform_jzrybhAndxm").empty();
				$("#jzdbgform_jzrybhAndxm").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#jzdbgform_jzrybhAndxm").append("<option value="+data[i].id+">"+data[i].sqjzrybh + "     " + data[i].xm +"</option>");
				}
				$("#jzdbgform_jzrybhAndxm").comboSelect();
				}
			})); 
			$("#sqsj").val(nowTime);		
			$("#jzdbg_list_all #jzdbg_tjsq_Modal").modal({backdrop:'static'});
			
		});
		 //获取当前机构的级别	 
		var orgType="${CURRENT_USER_SESSION.orgType}";
	     if(orgType==3){
	    	 $("#sfsshsj").attr("disabled","disabled");
	         $("#sfsshyj").attr("disabled","disabled");
	         $("#xsfjspr").val("${CURRENT_USER_SESSION.name}");
	     };
		if(orgType ==4){
			$("#addbtn").attr("type","button");
			$("#sfsshr").val("${CURRENT_USER_SESSION.name}");
		};
		
	   //上报数据
	   	$("#jzdbg_list_all #tjsb_btn").click(function(){
			if(formModelsq.validate()){
				jzdbg.save(formModelsq.getData(),new Eht.Responder({	
					success:function(){
						table.refresh();
						$('#jzdbg_tjsq_Modal').modal("hide");
					}
				}));
				formModelsq.clear();
			}
		});
		
		//保存审批
		$("#jzdbg_list_all #sp_btn").click(function(){
			if(formModelsp.validate()){	
				jzdbg.saveSp(formModelsp.getData(),new Eht.Responder({	
					success:function(){
						//table.refresh();
						$('#jzdbgsp_myModal').modal("hide");
						$('#shan').hide();
					}
				}));
				formModelsp.clear();
			}
		});
	});
	
</script>
</head>
<body>
<div id="jzdbg_list_all" class="panel panel-default">
		<div id="head" class="panel-heading" style="padding-left:20px;">
			<div id="tqcx_field">
				姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>
				<label>审核状态</label>
				<select class="btn btn-default" type="text" label="审批状态" id="spzt">
					<option value="">全部</option>
					<option value="1">通过</option>
					<option value="3">未通过</option>
					<option value="0">待审核</option>
				</select>
				<span>
				<input id="querybtn" class="btn btn-default btn-sm"  type="button"  value="查询"> 
				<input id="addbtn"   class="btn btn-default btn-sm"  type="hidden"  value="添加上报">
				<!-- <input id="updatebtn" class="btn btn-default btn-sm"  type="button"  value="修改"> 
				<input id="deletebtn"   class="btn btn-default btn-sm"  type="hidden"  value="删除"> -->
				</span>
			</div>
	</div>	
	<div id="tableview">
				<div field="jzrybh" label="社区矫正人员编号"></div>
				<div field="xm" label="姓名"></div>
				<div field="sqsj" label="申请时间"></div>
				<div field="qrdmx" label="迁入地"></div>
				<div field="spyj" label="审批意见"></div>
				<div field="cz" label="操作" ></div>
	</div>	
	
	<!-- 添加上报模态框 -->
	<div class="modal fade" id="jzdbg_tjsq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">添加居住地变更信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="jzdbg_model_field">
						<select id="jzdbgform_jzrybhAndxm" name="f_aid" label="服刑人员" ></select>
		    			<input name="sqsj"    label="申请时间"  class="form_date" id="sqsj" fixedValue="true" readonly="readonly">
		    			<select name="qrdszs"  label="迁入地所在省(区、市)"  id="qrdszs" ></select>
		    			<select name="qrdszd"  label="迁入地所在地(市、州)"  id="qrdszd"></select>
		    			<select name="qrdszx"  label="迁入地所在县(市、区)"  id="qrdszx" ></select>
		    			<input name="qrdxz"  label="迁入地(乡镇、街道)"  id="qrdxz" >
		    			<input name="qrdmx"  label="迁入地明细"  id="qrdmx" >
		    			<textarea rows="8" name="jzdbgsy"    label="居住地变更理由"  id="jzdbgsy"  maxlength="500"  getdis="true" ></textarea>
		    			<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
		    		</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="tjsb_btn" type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 提请情况模态框 -->
	<div class="modal fade" id="jzdbgxq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">居住地变更详细信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="jzdbgxq_model_field">
					  <table border="1" cellspacing="0" align="center" style="border-collapse:collapse;"><br>
							<tr>
								<td>姓名</td>
								<td field="xm"></td>
								<td>性别</td>
								<td><div field="xb" code="SYS000"></div></td>
								<td>罪名</td>
								<td><div field="jtzm"></div></td>
								<td>原判<br>刑期</td>
								<td><div field="ypxq"></div></td>
							</tr>
							<tr>
								<td>矫正<br>类别</td>
								<td><div field="jzlb" code="SYS017"></div></td>
								<td>矫正<br>期限</td>
								<td><div field="sqjzqx"></div></td>
								<td>起止日</td>
								<td colspan="3">
									<div><span field="sqjzksrq"></span>(起)<br><span field="sqjzjsrq"></span>(止)</div>
								</td>
							</tr>
							<tr>
								<td>现居<br>住地</td>
								<td colspan="3"><div field="gdjzdmx"></div></td>
								<td>拟迁往地</td>
								<td colspan="3"><div field="qrdmx"></div></td>
							</tr>
							<tr>
								<td>户籍地</td>
								<td colspan="3"><div field="hjszdmx"></div></td>
								<td>身份证号码</td>
								<td colspan="3"><div field="sfzh"></div></td>
							</tr>
							<tbody id="jzdbg">
								<tr>
									<td>居住地变更理由</td>
									<td colspan="7"><div><span field="jzdbgsy"></span></div></td>
								</tr>
								<tr>
									<td>司法所<br>意&nbsp;&nbsp;&nbsp;见</td>
									<td colspan="7"><div><span field="sfsshyj"></span></div></td>
								</tr>
								<tr>
									<td>现居住地县级司法行政机关意见</td>
									<td colspan="7"><div><span field="xsfjspyj"></span></div></td>
								</tr>
							</tbody>
							<tr>
								<td>备注</td>
								<td colspan="7"><div><span field="remark"></span></div></td>
							</tr>
						</table>
						<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：用于居住地变更时，抄送现居住地县级人民检察院、公安(分)局；变更后，复印送新居住地县级人民检察院、公安(分)局。</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 审批模态框 -->
	<div class="modal fade" id="jzdbgsp_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">x</button>
						<h4 class="modal-title" id="myModalLabel">居住地变更审批</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 510px; overflow: auto">
						<div id="sbsp_modal_form">   
								<input id="id" name="id" type="hidden" style="height:0;">  
								<input name="qrdxz"  label="迁入地(乡镇、街道)" readonly="true" >
				    			<input name="qrdmx"  label="迁入地明细" readonly="true" >
				    			<textarea name="jzdbgsy"    label="变更理由"  id="jzdbgsy"  maxlength="500" readonly="true" ></textarea>
				    			<input name="sfsshsj"    label="司法所审核时间"  class="form_date" id="sfsshsj" readonly="readonly" fixedValue="true">
				    			<input type="text" id="sfsshr" name="sfsshr"  readonly="true" fixedValue="true" label="审核人">					
								<textarea id="sfsshyj" name="sfsshyj"  rows="8" type="text" label="司法所审核意见" maxlength="200"></textarea>
								<div class="text-right"><span id="count2" style="color: #3F51B5;margin-right: 40px;"></span></div>
								<c:if test="${CURRENT_USER_SESSION.orgType == 2}">
								<input name="xsfjspsj" type="text"   label="县(市、区)司法局审批时间"  class="form_date" id="xsfjspsj" readonly="readonly" fixedValue="true">
					    			<input  id="xsfjspr" name="xsfjspr"  readonly="true" fixedValue="true" label="县(市、区)司法局审批人">					
									<textarea id="xsfjspyj" name="xsfjspyj"  rows="8"  label="县(市、区)司法局审批意见" maxlength="200"></textarea>
									<div class="text-right"><span id="count3" style="color: #3F51B5;margin-right: 40px;"></div>
								</c:if>
								<select id="audit" name="audit" label="最终意见" code="SYS171"></select>
						</div>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button id="sp_btn" type="button" class="btn btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
	
</div>
</body>
</html>