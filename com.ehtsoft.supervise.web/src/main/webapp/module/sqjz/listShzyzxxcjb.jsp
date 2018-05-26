<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>社会志愿者信息管理</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${localCtx}/json/ShzyzxxbService.js"></script>
<script type="text/javascript">
	$(function(){
		var service=new ShzyzxxbService();
		tableView=new Eht.TableView({
			selector:"#tableview"
		});
		
		form=new Eht.Form({
			selector:"#JzGrjl-form",
			autolayout:true,
		});
		
		var query={};
		var NowData={};
		tableView.loadData(function(page,res){
			//列表只显示志愿者
			query["rybm"]='03';
			service.find(query,page,res);
		});
		
		$("#delete").attr('disabled',true);
		
		tableView.clickRow(function(data){
			NowData=data;
			if(data.id!=null){
				$("#delete").attr('disabled',false);
			}
		});
		
		$("#search").click(function(){
			query["xm[like]"] = $("#search-xm").val();
			query["sfzh[like]"] = $("#search-sfzh").val();
			tableView.refresh();
		});
		
		$("#add").click(function(){
			form.clear();
			$("#myModal").modal({backdrop : 'static',keyboard : false});
			$("#rylx").val("03");
 		 	$("#rylx").attr("disabled",true);  
 		 	$("#csrq").click(function(){
 		 		
 				var Cardid=document.getElementById("sfzh").value;
 				var year=Cardid.substring(6,10);
 				var month=Cardid.substring(10,12);
 				var day=Cardid.substring(12,14);
 				var csrq=year+"-"+month+"-"+day;
 				
 		 		$("#csrq").val(csrq);
 		 	});
 		 	
 		});
		
		$("#delete").click(function(data){
			data=NowData;
			var con; 
			con=confirm("确定要删除？");
			if(con==true){
				service.deleteOne(data);
			}
			tableView.refresh();
		});
		
		//修改
		tableView.dblclickRow(function(data){
			$("#myModal").modal({backdrop : 'static',keyboard : false}); 
 		 	$("#csrq").click(function(){
 				var Cardid=document.getElementById("sfzh").value;
 				var year=Cardid.substring(6,10);
 				var month=Cardid.substring(10,12);
 				var day=Cardid.substring(12,14);
 				var csrq=year+"-"+month+"-"+day;
 		 		$("#csrq").val(csrq);
 		 	});
 		 	
			form.fill(data);
		}); 
		
		
		$('#zyzxx_submit').click(function(){
			if(form.validate()){
				$("#rylx").attr("disabled",false);
				service.saveSfsry(form.getData(),new Eht.Responder({
					success:function(data){
						$('#myModal').modal('hide');
						tableView.refresh();
					},
					error:function(msg){
					}
				}));
			}
		});
		

		
		
	});
	</script>
</head>

<body>
<div id="list_fxryzpgl">

	<div class="panel panel-default">
		<div class="panel-heading">
			<fieldset>
				<label>姓名：</label><input type="text" name="xm" class="btn btn-default" placeholder="请输入姓名" id="search-xm"/>
				<label>身份证号：</label><input type="text" name="sfzh" class="btn btn-default" placeholder="请输入身份证号" id="search-sfzh"/>
				<input type="button" id="search" class="btn btn-default" value="查询"/>
				<input type="button" id="add" class="btn btn-default" value="新增"/>
				<input type="button" id="delete" class="btn btn-default" value="删除"/>
			</fieldset>
		</div>
		
		<!-- 主表 -->	
		<div class="panel-body" >
			<div id="tableview" class="table-responsive">
				<div field="op" label="选择" 	checkbox="true"></div>
				<div field="xm" label="姓名"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="xl" label="学历" code="SYS093"></div>
				<div field="zy" label="专业" code="SYS095"></div>
				<div field="sjhm" label="手机"></div>
				<div field="ssjg" label="工作单位"></div>
				<div field="zz" label="家庭住址"></div>
			</div>
		</div> 
		
		<!--模态框-->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<Button class="close" type="button" data-dismiss="modal" aria-hidden="true">
							&times;
						</Button>
						<h4 class="modal-title" id="myModalLabel" style="">社会志愿者信息</h4>
					</div>
					<div class="modal-body">
						<div id="JzGrjl-form">
							<input type="text" name="rybm" label="人员类型"  id="rylx" code="SYS020"  maxlength="18"/>
							<input type="text" name="xm" label="姓名" valid="{required:true,onlyChinese:true}"/>
							<input type="text" name="xb" label="性别" code="SYS000" valid="{required:true}"/>
							<input type="text" id="sfzh" name="sfzh" label="身份证号" valid="{required:true,cardNo:true}" maxlength="18"/>
							<input type="text" id="csrq" name="csrq" label="出生日期" valid="{date:true}" readonly/>
							<input type="text" name="xl" label="学历" code="SYS093"/>
							<input type="text" name="zgxw" label="最高学位" code="SYS094"/>
							<input type="text" name="zzmm" label="政治面貌" code="SYS091" />
							<input type="text" name="zy" label="专业" code="SYS095"/>
					<!-- 	<input type="hidden" name="zhiy" label="职业" code="SYS090" />
							<input type="text" name="zc" label="职称" code="SYS026"/> -->
							<input type="text" name="ssjg" label="工作单位" maxlength="20" />
							<input type="text" name="lxdh" label="联系电话" maxlength="15" />
							<input type="text" name="sjhm" label="手机"  maxlength="11" valid="{mobile:true}"/>
							<input type="text" name="zz" label="家庭住址" maxlength="30" />
							<input type="text" name="bz" label="备注" maxlength="30"  />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="zyzxx_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
		
	
	</div>
</div>	
</body>
</html>