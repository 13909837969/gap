<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>提请撤销缓刑信息管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzTqcxhxxxcjbService.js"></script>
<style type="text/css">
.modal-lg{
	width:600px;
}
#table td{
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
			var nowTime=new Date().format("yyyy-MM-dd");
			var tqcxhx = new JzTqcxhxxxcjbService();
			var form = new Eht.Form({//查询form
				selector:"#tqcx_field"
			});
			var formsq = new Eht.Form({//添加上报信息表
				selector:"#tqcxhxsq_field",
				autolayout:true	
			});
			formsq.charValid(function(name,min,max){
				if(name=="tqly"){
					$("#count").html(min+"/"+max);
					var bl = min/max;
					if( bl > 3/4 ){
						$("#count").css("color","#f00");
					}else{
						$("#count").css("color","#00f");
					}
				}
				if(name=="tqyj"){
					$("#count2").html(min+"/"+max);
					if(bl > 3/4){
						$("#count2").css("color","#f00");
					}else{
						$("#count2").css("color","#00f");
					}
				}
				if(name=="xsfjshyj"){
					$("#count3").html(min+"/"+max);
					if(bl > 3/4){
						$("#count3").css("color","#f00");
					}else{
						$("#count3").css("color","#00f");
					}
				}
			});
				var formlsp = new Eht.Form({//审批form
					selector:"#tqsp_form",
					autolayout:true	
				});
				var formshxq = new Eht.View({//详细信息view
					selector:"#tqcxhx_field",
					fieldname:"field"
						
				});
				
				var table = new Eht.TableView({
					selector:"#tqcx_list_all #tableview "
				});
				
				//获取form表单的值
				var query = {};
				//页面加载时
				table.loadData(function(page,res){
					tqcxhx.findAll(query,page,res);
				});
				//审核状态判断
				table.transColumn("audit",function(data){
	            	var rtn = "";
	        		if(data.audit==1){
	        			rtn="旗县司法局通过";
	        			
	        		}
	        		if(data.audit==2){
	        			rtn="地(市、区)司法局通过";
	        		}
	        		if(data.audit==3 ){
	        			rtn="旗县司法局未通过";
	        		}if(data.audit==4){
	        			rtn="地(市、区)司法局未通过";
	        		}
	        		if(data.audit==0){
	        			rtn="待审核";
	        		}
	            	return rtn;
		            });
				//查询符合条件的数据
				$("#querybtn").click(function(){
					query.audit = $("#spzt").val(); 
					query["xm[like]"] = $("#searchXm").val();
					table.refresh();
				});
				
				//获取当前账号type
				var orgType="${CURRENT_USER_SESSION.orgType}";
				//添加上报按钮
				if(orgType==4 || orgType==3){
					$("#addbtn").attr("type","button");
				};
				if(orgType==2){
					$("#xsfjshyj").attr("disabled","disabled");
				}
				
				//添加上报模态框
				$("#tqcx_list_all #addbtn").click(function(){
					//动态添加审批历史记录信息
		   			tqcxhx.findJzry({},new Eht.Responder({
						success:function(data){
						$("#tqzaform_xmAndLxdh").empty();
						$("#tqzaform_xmAndLxdh").append('<option selected="selected"></option>');
						for(var i=0;i<data.length;i++){
							$("#tqzaform_xmAndLxdh").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].grlxdh +"</option>");
						}
						$("#tqzaform_xmAndLxdh").comboSelect();
						}
					})); 
					$("#sfssqsj").val(nowTime);		
					$("#tqcx_list_all #tqcxhx_tjsq_Modal").modal({backdrop:'static'});
					
				});
				//保存上报数据
			   	$("#tqcx_list_all #tjsb_btn").click(function(){
					if(formsq.validate()){
						tqcxhx.save(formsq.getData(),new Eht.Responder({	
							success:function(){
								table.refresh();
								$('#tqcxhx_tjsq_Modal').modal("hide");
							}
						}));
						formsq.clear();
					}
				});
				
				//添加操作按钮
				table.transColumn("caozuo",function(data){
					var dv = $("<div></div>");
					var btn1 = $('<button id="xqan" class="btn btn-default btn-sm"  ><span class="glyphicon glyphicon-th-list" ></span>&nbsp;详细</button>');
					var btn2 = $('<button id="shan" class="btn btn-default btn-sm"  ><span class="glyphicon glyphicon-edit" ></span>&nbsp;审批</button>');
					btn1.data(data);
					btn2.data(data);
					btn1.click(function(){
						tqcxhx.findOne(data.id,new Eht.Responder({//根据ID查询个人基本信息
							success:function(data){
								formshxq.fill(data);
								if(data.audit != 3){
					        		$("#tjfy_btn").show();
								}else{
					        		$("#tjfy_btn").hide();
								}
								if(data.audit == 2 ){
					        		$("#tjzjfy_btn").show();
								}
								if(data.audit == 4 ){
					        		$("#tjzjfy_btn").hide();
								}
							}
						}));
						$("#tqcx_list_all #cxhxspxq_Modal").modal({backdrop:'static'});
					});
					btn2.click(function(){
						var ds = $(this).data();
						formlsp.fill(ds);
						$("#xsfjspsj").val(nowTime);
						$("#xsfjspr").val("${CURRENT_USER_SESSION.name}");
						$("#dsfjshsj").val(nowTime);	
				        $("#dsfjshr").val("${CURRENT_USER_SESSION.name}");
					 	$("#tqcx_list_all #tqcxhxsp_myModal").modal({backdrop:'static'});
					});
					
					//判断审核按钮
					if(orgType==3 && data.xsfjshyj==null ){
						dv.append(btn2);
					}else if(orgType==2 && data.dsfjshyj==null ){
						dv.append(btn2);
					}else{
						dv.append(btn1);
					}
					return dv;
				});
				//提交审批
				$("#tqcx_list_all #spjg_btn").click(function(){
					if(formlsp.validate()){	
						tqcxhx.saveSp(formlsp.getData(),new Eht.Responder({	
							success:function(){
								table.refresh();
								$('#tqcxhxsp_myModal').modal("hide");
							}
						}));
						formlsp.clear();
					}
				});
				
				
			});
	</script>
</head>
<body>
<div id="tqcx_list_all" class="panel panel-default">
		<div id="head" class="panel-heading" style="padding-left:20px;">
			<div id="tqcx_field">
				姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>
				<label>审核状态</label>
				<select class="btn btn-default" type="text" label="审批状态" id="spzt">
					<option value="">全部</option>
					<option value="1">旗县司法局通过</option>
					<c:if test="${CURRENT_USER_SESSION.orgType == 3}">  
					<option value="3">旗县司法局驳回</option>
					<option value="0">待审核</option>
					</c:if>
					<option value="2">地(市、区)司法局通过</option>
					<option value="4">地(市、区)司法局驳回</option>
				</select>
				<span>
				<input id="querybtn" class="btn btn-default btn-sm"  type="button"  value="查询"> 
				<input id="addbtn"   class="btn btn-default btn-sm"  type="hidden"  value="添加上报" >
				</span>
			</div>
	</div>	
	<div id="tableview">
		<div field="jzrybh" label="社区矫正人员编号" ></div>
		<div field="xm"       label="姓名"></div>
		<div field="xb"       label="性别"         code="SYS000"></div>
		<div field="mz"       label="民族"         code="SYS003"></div>
		<div field="grlxdh"   label="个人联系电话"></div>
		<div field="sfssqr"   label="司法所申请人"></div>
		<div field="audit"    label="审批状态"></div>
		<div field="caozuo"  label="操作"></div>	
	</div>	
	
	<!-- 添加上报模态框 -->
	<div class="modal fade" id="tqcxhx_tjsq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">提请撤销缓刑信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="tqcxhxsq_field">
						<select id="tqzaform_xmAndLxdh" name="aid" label="服刑人员" ></select>
		    			<textarea rows="4" id="tqly2"	 type="text"    label="提请理由"     name="tqly"    maxlength="500"  valid="{required:true}"></textarea>
		    			<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
		    			<textarea rows="4" id="tqyj2"     type="text"    label="提请依据" 	   name="tqyj"    maxlength="500"  valid="{required:true}"></textarea>
						<div class="text-right"><span id="count2"  style="color: #3F51B5;margin-right: 40px;"></span></div>
						<input name="sfssqsj"    label="申请时间"  class="form_date" id="sfssqsj" fixedValue="true" readonly="readonly">
						<input name="sfssqr" type="text" label="申请人" id="sfssqr" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
		    		</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="tjsb_btn" type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
		</div>
	</div>
	
<!-- 提请详情情况模态框 -->
	<div class="modal fade" id="cxhxspxq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">提请撤销缓刑详细信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="tqcxhx_field">
					  <table id="table" border="1" cellspacing="0" align="center" style="border-collapse:collapse;"><br>
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
								<td>户籍地</td>
								<td colspan="3"><div field="hjszdmx"></div></td>
								<td>身份证号码</td>
								<td colspan="3"><div field="sfzh"></div></td>
							</tr>
							<tbody id="jzdbg">
								<tr>
									<td>提请理由</td>
									<td colspan="7"><div><span field="tqly"></span></div></td>
								</tr>
								<tr>
									<td>提请依据</td>
									<td colspan="7"><div><span field="tqyj"></span></div></td>
								</tr>
								<tr>
									<td>县司法局意见</td>
									<td colspan="7"><div><span field="xsfjshyj"></span></div></td>
								</tr>
								<tr>
									<td>地(市、区)司法局审核意见</td>
									<td colspan="7"><div><span field="dsfjshyj"></span></div></td>
								</tr>
								
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<c:if test="${CURRENT_USER_SESSION.orgType == 3}"> 
							<button id="tjfy_btn" type="button" class="btn btn-primary">提交法院</button>
						</c:if>
						<c:if test="${CURRENT_USER_SESSION.orgType == 2}"> 
							<button id="tjzjfy_btn" type="button" class="btn btn-primary">提交中级法院</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<!-- 审批模态框 -->
	<div class="modal fade" id="tqcxhxsp_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">提请撤销缓刑审批</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 510px; overflow: auto">
						<div id="tqsp_form">   
								<input type="text" id="xsfjspsj" name="xsfjspsj" label="审核时间" class="form_date" readonly="readonly">
								<input type="text" id="xsfjspr" name="xsfjspr"   label="审核人" readonly="true" fixedValue="true" >					
								<textarea rows="4" id="xsfjshyj" name="xsfjshyj" label="审核意见" type="text" getdis="true"></textarea>
								<div class="text-right"><span id="count3"  style="color: #3F51B5;margin-right: 40px;"></span></div>
				    			<c:if test="${CURRENT_USER_SESSION.orgType == 2}">  
								<input id="dsfjshsj" name="dsfjshsj" type="text"   label="地(市、区)司法局审核时间"  class="form_date"  readonly="readonly">
				    			<input  id="dsfjshr" name="dsfjshr"  label="地(市、区)司法局审核人"  fixedValue="true" readonly="readonly">					
								<textarea id="dsfjshyj" name="dsfjshyj"  rows="4"  label="地(市、区)司法局审核意见" maxlength="200"></textarea>
								<div class="text-right"><span id="count3" style="color: #3F51B5;margin-right: 40px;" ></div>
								<select id="audit" name="audit" label="审核结果">
									<option value="2">通过</option>
									<option value="4">未通过</option>
								</select>
								</c:if>
			    				<c:if test="${CURRENT_USER_SESSION.orgType == 3}">  
								<select id="audit" name="audit" label="审核结果">
									<option value="1">通过</option>
									<option value="3">未通过</option>
								</select>
								</c:if>
						</div>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button id="spjg_btn" type="button" class="btn btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
	
</div>
</body>
</html>