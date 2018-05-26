<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>社区矫正人员在社区矫正期间再犯罪信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/ZfzxxService.js"></script>	
<script type="text/javascript">
	$(function(){
		var service=new ZfzxxService();
		var tableView=new Eht.TableView({
			selector:"#tableview"
		});
		
		var tableView_right=new Eht.TableView({
			selector:"#right-panel",
			paginate:null
		});
		
		var form=new Eht.Form({
			selector:"#form",
			autolayout:true,
		});
		
		var query={};
		
		var nowData={};
		
		//读取数据
		tableView.loadData(function(page,res){
			service.find(query,page,res);
			
		});
		
		//禁用
		$("#zfz_add").attr('disabled',true);
		$("#zfz_del").attr('disabled',true);
		
		//点击一行
		var aid;
		tableView.clickRow(function(data){
			$("#right-panel").show();
			nowData=data;
			$("#zfz_del").attr('disabled',true);
			$("#zfz_add").attr('disabled',false);
			 aid=nowData.id;
				var res = Eht.Responder({success:function(data){
					tableView_right.refresh();
				}});
				tableView_right.loadData(function(page,res){
					service.findZz(aid,res);
				});
			});
		
		var json={};
		//右侧点击一行
		tableView_right.clickRow(function(data){
			$("#zfz_del").attr('disabled',false);
			json=data;
		});
		
		//删除
		$("#zfz_del").click(function(data){
			var con; 
			con=confirm("确定要删除？");
			if(con==true){
				service.deleteOne(json);
				tableView_right.loadData(function(page,res){
					service.findZz(aid,res);
				});
				 setTimeout(function () { 
					 tableView_right.refresh();
					 }, 200);
				
				$("#zfz_del").attr('disabled',true);
			}
		});
		
		//查询
		$("#zfz_search").click(function(){
			query["xm[like]"] = $("#search-xm").val();
			query["sfzh[like]"] = $("#search-sfzh").val();
			tableView.refresh();
			$("#right-panel").hide();
		});
		
		$("#zfz_cz").click(function(){
			window.location.reload();
		});
		
		//增加
		$("#zfz_add").click(function(){
			form.clear();
			$('#zfz_submit').attr("disabled",false);
			$("#myModal").modal({backdrop : 'static',keyboard : false}); 
			form.clear();
			$("#sqjzrybh").val(nowData.id);
		});
		
	
		
		//提交
		$('#zfz_submit').click(function(){
			if(form.validate()){
				service.saveZfzxx(form.getData(),new Eht.Responder({
					success:function(data){
						$('#zfz_submit').attr("disabled",true);
						$('#myModal').modal('hide');
						tableView_right.loadData(function(page,res){
							service.findZz(aid,res);
						});
					},
					error:function(msg){
					}
				}));
			}
			
		});
		
		$(document).ready(function(){
			var org="${CURRENT_USER_SESSION.orgType}";
	 		if(org==1){
			}
			if(org!=null&&org==2){
				var add=document.getElementById("zfz_add"); 
				add.setAttribute("type","hidden");
				$("#zfz_add").hide();
				
				var add=document.getElementById("zfz_del"); 
				add.setAttribute("type","hidden");
				$('#zfz_del').hide(); 
			}
			if(org==3){
	 			var add=document.getElementById("zfz_add"); 
				add.setAttribute("type","hidden");
				
				var add=document.getElementById("zfz_del"); 
				add.setAttribute("type","hidden"); 
			}
			if(org==4){
				//修改
				tableView_right.dblclickRow(function(data){
					$('#zfz_submit').attr("disabled",false);
					$("#myModal").modal({backdrop : 'static',keyboard : false}); 
					form.fill(data);
				}); 
			}
			})
	});
	</script>
	
	<style type="text/css">
		#list .mycol-md{
	    padding-right: 1px;
	    padding-left: 1px;
	}
	
	.panel-body {
	padding:5px;

	}
	
	.col-md-7, .col-md-5{
	padding-left:2px;
	padding-right:2px;
	}
	
	</style>
</head>

<body>
<div id="list-zz">

	<div class="panel panel-default">
	<!-- 表头 -->	
		<div class="panel-heading">
			<fieldset>
				<label>姓名：</label><input type="text" name="xm" class="btn btn-default" placeholder="请输入姓名" id="search-xm"/>
				<label>身份证号：</label><input type="text" name="sfzh" class="btn btn-default" placeholder="请输入身份证号" id="search-sfzh"/>
				<input type="button" id="zfz_search" class="btn btn-default" value="查询"/>
				<input type="button" id="zfz_add" class="btn btn-default" value="新增"/>
				<input type="button" id="zfz_del" class="btn btn-default" value="删除"/>
				<input type="button" id="zfz_cz" class="btn btn-default" value="重置"/>
			</fieldset>
		</div>
		
		<!-- 主表 -->	
		<div class="panel-body" >
			<div div="row">
				<div class="col-md-7 mycol-md">
					<div class="panel panel-default">	
						<div class="panel-heading"><center>个人信息</center></div>
						<div class="table-responsive">
							<div class="panel-body" id="tableview" >
								<div field="op" label="选择" checkbox="true"></div>
								<div field="xm" label="姓名"></div>
								<div field="sfzh" label="身份证号"></div>
								<div field="grlxdh" label="电话"></div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-5 mycol-md">
					<div class="panel panel-default">
						<div class="panel-heading"><center>再罪信息</center></div>
						<div class="table-responsive">
							<div class="panel-body" id="right-panel" >
								<div field="zm"   label="罪名"  code="SYS014"></div>
								<div field="fzrq" label="犯罪日期"></div>
								<div field="fxdw" label="服刑单位"></div>
								<div field="pjjg" label="判决机关"></div>
							</div>
						</div>
					</div>	
				</div>
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
						<h4 class="modal-title" id="myModalLabel" style="text-align: center;">再犯罪信息</h4>
					</div>
					<div class="modal-body">
						<div id="form">
							<input type="text"  label="社区矫正人员编号" name="aid" id="sqjzrybh" readonly/>
							<input type="text"  label="罪名"  name="zm" code="SYS014" valid="{required:true}"/>
							<input type="text"  label="原判刑罚" name="ypxf" code="SYS012" valid="{required:true}"/>
							<input type="text"  label="附加刑" name="fjx"  maxlength="18" code="SYS013"/>
							<input type="text"  label="犯罪日期" name="fzrq" class="form_date" valid="{required:true,date:true}" maxlength="18"/>
							<input type="text"  label="服刑单位" name="fxdw"  maxlength="20" valid="{required:true}"/>
							<input type="text"  label="刑期开始日期" name="xqksrq" class="form_date" valid="{date:true}"  maxlength="18"/>
							<input type="text"  label="刑期结束日期" name="xqjsrq" class="form_date" valid="{date:true}"  maxlength="18"/>
							<input type="text"  label="判决机关" name="pjjg"  maxlength="18" valid="{required:true}"/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="zfz_submit">提交</button>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>	
</body>
</html>