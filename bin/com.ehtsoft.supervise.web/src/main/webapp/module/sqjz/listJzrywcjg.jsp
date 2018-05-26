<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>矫正人员外出情况监管</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzrywcjgService.js"></script>
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
</style>
<script type="text/javascript">
	$(function(){
		//省区联动
		var region = new RegionService();//省市区后台
		region.find(1,null,new Eht.Responder({//省份初始化
			success:function(data){
				for (var i = 0; i < data.length; i++) {
					$("#wcmddszs").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
				$("#wcmddszs").change();
			}
		}));  
		//获取市
		$("#wcmddszs").change(function(){
		  region.find(2,$("#wcmddszs").val(),new Eht.Responder({
			success:function(data){
				$("#wcmddszd").empty();
				for (var i = 0; i < data.length; i++) {
					$("#wcmddszd").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
			  }
			}));
		 	//获取旗县
			$("#wcmddszd").change(function(){	
			region.find(3,$("#wcmddszd").val(),new Eht.Responder({
				success:function(data){
				$("#wcmddszx").empty();
					for (var i = 0; i < data.length; i++) {
						$("#wcmddszx").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
				  }	
			}));
		 });
		});
		//获取系统当前时间
		var nowTime=new Date().format("yyyy-MM-dd");
		//获取当前机构的级别	 
		var orgType="${CURRENT_USER_SESSION.orgType}";
		var wcjg = new JzrywcjgService();
		var form = new Eht.Form({
			selector:"#tqcx_field"
		});
		//添加上报模态款
		var formModelsq = new Eht.Form({
			selector:"#wcjg_model_field",
			autolayout:true	
		});
		//提请情况模态框
		var formModelxq = new Eht.View({
			selector:"#wcjgxq_model_field",
			fieldname:"field"
		});
		//textaera的计数
		formModelsq.charValid(function(name,min,max){
			if(name=="wcly"){
				$("#count").html(min+"/"+max);
				if(min/max > 3/4 ){
					$("#count").css("color","#f00");
				}else{
					$("#count").css("color","#00f");
				}
			}
		});
			
		//审批模态框
		var formModelsp = new Eht.Form({
			selector:"#sbsp_modal_form",
			autolayout:true	
		});
		//司法审核意见计数
		formModelsp.charValid(function(name,min,max){
			if(name=="sfsshyj"){
				$("#count2").html(min+"/"+max);
				if(min/max > 3/4){
					$("#count2").css("color","#f00");
				}else{
					$("#count2").css("color","#00f");
				}
			}
			if(name=="xsfjspyj"){
				$("#count3").html(min+"/"+max);
				if(min/max > 3/4){
					$("#count3").css("color","#f00");
				}else{
					$("#count3").css("color","#00f");
				}
			}
		});
		
		
		var table = new Eht.TableView({
			selector:"#wcjg_list_all #tableview "
		});
		
		//获取form表单的值
		var query = {};
		//页面加载时
		table.loadData(function(page,res){
			 wcjg.find(query,page,res);
		});
		
		
		//添加操作按钮
		table.transColumn("cz",function(data){
			var dv = $("<div></div>");
			var btn1 = $('<button id="xqan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon-sound-6-1" ></span>&nbsp;申请详情</button>');
			var btn2 = $('<button id="shan" class="btn btn-default btn-sm"  style="color:blue"><span class="glyphicon glyphicon-sound-6-1" ></span>&nbsp;审批</button>');
			btn1.data(data);
			btn2.data(data);
			btn1.click(function(){
				wcjg.findOne(data.id,new Eht.Responder({//根据ID查询个人基本信息
					success:function(data){
			 		formModelxq.fill(data);
					}
				}));
			  $("#wcjg_list_all #wcjgsqxq_Modal").modal({backdrop: 'static', keyboard: false});//弹出模态框
				
			});
			btn2.click(function(){
				var ds = $(this).data();
				formModelsp.fill(ds);
				$("#sfsshsj").val(nowTime);	
				$("#xsfjspsj").val(nowTime);	
			 	$("#wcjg_list_all #wcsp_myModal").modal({backdrop:'static'});
				
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
		})
		
		//查询单条数据
		$("#querybtn").click(function(){
			 query.audit = $("#spzt").val(); 
			query["xm[like]"] = $("#searchXm").val();
			table.refresh();
		})
		
		//添加上报模态框添加
		$("#wcjg_list_all #addbtn").click(function(){
			//动态添加审批历史记录信息
	  			wcjg.findJzry({},new Eht.Responder({
				success:function(data){
				$("#wcjgform_jzrybhAndxm").empty();
				$("#wcjgform_jzrybhAndxm").append('<option selected="selected"></option>');
				for(var i=0;i<data.length;i++){
					$("#wcjgform_jzrybhAndxm").append("<option value="+data[i].id+">"+data[i].sqjzrybh + "     " + data[i].xm +"</option>");
				}
				$("#wcjgform_jzrybhAndxm").comboSelect();
				}
			})); 
			$("#sqsj").val(nowTime);		
			$("#wcjg_list_all #wcjg_tjsq_Modal").modal({backdrop:'static'});
			
		});
		
		if(orgType==3){
	    	 $("#sfsshsj").attr("disabled","disabled");
	         $("#sfsshyj").attr("disabled","disabled");
	         $("#xsfjspr").val("${CURRENT_USER_SESSION.name}");
	     };
		if(orgType ==4){
			$("#addbtn").attr("type","button");
		 	$("#xsfjspsj").attr("disabled","disabled");
			$("#xsfjspyj").attr("disabled","disabled");
			$("#sfsshr").val("${CURRENT_USER_SESSION.name}");
		};
		
	   //上报数据
	   	$("#wcjg_list_all #tjsb_btn").click(function(){
			if(formModelsq.validate()){
				wcjg.save(formModelsq.getData(),new Eht.Responder({	
					success:function(){
						table.refresh();
						$('#wcjg_tjsq_Modal').modal("hide");
					}
				}));
				formModelsq.clear();
			}
		});
		
		//保存审批
		$("#wcjg_list_all #sp_btn").click(function(){
			if(formModelsp.validate()){	
				wcjg.saveSp(formModelsp.getData(),new Eht.Responder({	
					success:function(){
						table.refresh();
						$('#wcsp_myModal').modal("hide");
					}
				}));
				formModelsp.clear();
			}
		});
		
		//判断开始于结束日期
		$("#ksqr,#jsrq").change(function(){
			var a = new Date($("#ksqr").val());
	        var b = new Date($("#jsrq").val());
	        a = a.valueOf();
	        b = b.valueOf();
	       
	        if(b<=a){
		  		new Eht.Alert().show("结束日期必须大于开始日期");
		  		$("#ksqr").val("");
		  		$("#jsrq").val("");
		  		$("#wcts").val("");
	        }else{
		        var offsetTime = Math.abs(a - b);
		        var days = Math.floor(offsetTime / (3600 * 24 * 1e3));
		        $("#wcts").val(days) ;
	        }
	      
		});
		 
	});
	
</script>
</head>
<body>
<div id="wcjg_list_all" class="panel panel-default">
		<div id="head" class="panel-heading" style="padding-left:20px;">
			<div id="tqcx_field">
				姓名：<input class="input-group-addon" style="width: 150px; border:1px solid #ccc;background-color: #fff;" type="text" name="xm" placeholder="请输入姓名" id="searchXm"/>
				<label>审核状态</label>
				<select class="btn btn-default" type="text" label="审批状态" id="spzt">
					<option value="">全部</option>
					<option value="1">通过</option>
					<option value="2">未通过</option>
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
				<div field="wcmddmx" label="外出目的地"></div>
				<div field="wcts" label="外出天数"></div>
				<div field="spyj" label="审批意见"></div>
				<div field="cz" label="操作" ></div>
	</div>	
	
	<!-- 添加上报模态框 -->
	<div class="modal fade" id="wcjg_tjsq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
					<h4 class="modal-title" id="myModalLabel">申请外出登记表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="wcjg_model_field">
						<select id="wcjgform_jzrybhAndxm" name="f_aid" label="服刑人员" ></select>
		    			<input name="sqsj"    label="申请时间"  class="form_date" id="sqsj" fixedValue="true">
		    			<select name="wcmddszs"  label="外出目的地所在省(区、市)"  id="wcmddszs"></select>
		    			<select name="wcmddszd"  label="外出目的地所在地(市、州)"  id="wcmddszd"></select>
		    			<select name="wcmddszx"  label="外出目的地所在县(市、区)"  id="wcmddszx"></select>
		    			<input name="wcmddxz"  label="外出目的地(乡镇、街道)"  id="wcmddxz" >
		    			<input name="wcmddmx"  label="外出目的地明细"  id="wcmddmx" >
		    			
		    			<textarea name="wcly"    label="外出理由"  id="wcly"  maxlength="500"  getdis="true" ></textarea>
		    			<div class="text-right"><span id="count" style="color: #3F51B5;margin-right: 40px;"></span></div>
		    			
		    			<input name="ksqr"    label="外出开始时间"  class="form_date" id="ksqr" fixedValue="true">
		    			<input name="jsrq"    label="外出结束时间"  class="form_date" id="jsrq" fixedValue="true">
		    			<input name="wcts" id="wcts" label="外出天数"  valid="{number:true}" fixedValue="true">
		    			
		    		</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="tjsb_btn" type="button" class="btn btn-primary">提交</button>
				</div>
			</div>
		</div>
	</div>
<!-- 外出监管人员及审批详细情况模态框 -->
	<div class="modal fade" id="wcjgsqxq_Modal">
		<div class="modal-dialog modal-lg" >
			<div class="modal-content" >
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" 
							aria-hidden="false">×
					</button>
					<h4 class="modal-title" id="myModalLabel">外出监管申请详细信息表</h4>
				</div>
				<div class="modal-body" id="modal-bodyAdd" style="height:510px;overflow-y:auto;overflow-x:hidden;">
					<div id="wcjgxq_model_field">
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
								<td>外出目的地</td>
								<td colspan="3"><div field="wcmddmx"></div></td>
							</tr>
							<tr>
								<td>户籍地</td>
								<td colspan="3"><div field="hjszdmx"></div></td>
								<td>身份证号码</td>
								<td colspan="3"><div field="sfzh"></div></td>
							</tr>
							<tbody id="jzdbg">
								<tr>
									<td>外出理由</td>
									<td colspan="7"><div><span field="wcly"></span>
									<div class="right" field="sqsj"></div></td>
									</td>
								</tr>
								<tr>
									<td>司法所<br>意&nbsp;&nbsp;&nbsp;见</td>
									<td colspan="7"><div><span field="sfsshyj"></span>
									<div class="right" field="sfsshsj"></div></td>
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
	<div class="modal fade" id="wcsp_myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false" id="xxx"></button>
						<h4 class="modal-title" id="myModalLabel">外出监管审批</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 510px; overflow: auto">
						<div id="sbsp_modal_form">   
								<input id="id" name="id" type="hidden" style="height:0;">  
								<input name="wcmddxz"  label="外出目的地(乡镇、街道)" readonly="true" >
				    			<input name="wcmddmx"  label="外出目的地明细" readonly="true" >
				    			<textarea name="wcly"    label="外出理由"  id="wcly"  maxlength="500" readonly="true" ></textarea>
				    			<input name="sfsshsj"    label="司法所审核时间"  class="form_date" id="sfsshsj" fixedValue="true">
				    			<input type="text" id="sfsshr" name="sfsshr"  readonly="true" fixedValue="true" label="司法所审核人">	
				    							
								<textarea id="sfsshyj" name="sfsshyj"  rows="4" type="text" label="司法所审核意见" maxlength="200"></textarea>
								<div class="text-right"><span id="count2" style="color: #3F51B5;margin-right: 40px;"></span></div>
									
								<input name="xsfjspsj" type="text"   label="县(市、区)司法局审批时间"  class="form_date" id="xsfjspsj" fixedValue="true">
				    			<input type="text" id="xsfjspr" name="xsfjspr"  readonly="true" fixedValue="true" label="县(市、区)司法局审批人">	
				    							
								<textarea id="xsfjspyj" name="xsfjspyj"  rows="4" type="text" label="县(市、区)司法局审批意见" maxlength="200"></textarea>
								<div class="text-right"><span id="count3" style="color: #3F51B5;margin-right: 40px;"></span></div>
							
								
								<select id="audit" name="audit" label="审批意见" code="SYS171"></select>
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