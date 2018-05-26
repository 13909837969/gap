<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>余罪再罪表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/YzzzService.js"></script>
<script type="text/javascript">
$(function(){
	var service =new YzzzService();
	var tableview = new Eht.TableView({
		selector:'#list_yzzz #grxx_form',
		autolayout:true
		});
 	var form = new Eht.Form({
		selector:'#list_yzzz #grxx_form',
		autolayout:true
		}); 
	var form_mtk = new Eht.Form({
		selector:'#list_yzzz #formXqbdqk',
		autolayout:true,
		colLabel:"col-sm-3 col-xs-3",
		colCombo:"col-sm-9 col-xs-9",
		});
	var table_yz = new Eht.TableView({
		multable:false,
		selector :"#yz_list",
		paginate:null
		});
	var query = {};
	tableview.loadData(function(page,res){
		service.findAllRy(query,page,res);
	});
	//提示框div初始状态为隐藏
	$('#list_yzzz #hideDiv').hide();
	$('#list_yzzz #hideScDiv').hide();
	//禁用
	$("#yz_add").attr('disabled',true);
	$("#yz_del").attr('disabled',true);
	//查询
	$("#list_yzzz #search").click(function(){
		query["xm[like]"] = $("#list_yzzz #search-xm").val();
		tableview.refresh();
		$("#yz_list").hide();
	});
	var json={};
 		
	var aid;
 	//单击一行
	tableview.clickRow(function(data){
		$("#yz_list").show();
		json=data;
		aid=json.id;
		$("#yz_del").attr('disabled',true);
		$("#yz_add").attr('disabled',false);
		table_yz.refresh();
		var res = Eht.Responder({success:function(data){
			table_yz.refresh();
		}});
		table_yz.loadData(function(page, res) {
			if(json.id!=null){
				service.findxx(aid,res);
			}
		});
	});
 
	//双击一行
	table_yz.dblclickRow(function(data){
		$("#myModal").modal({backdrop : 'static',keyboard : false});
		data.sqjzrybh=data.id;
		console.log(data.sqjzrybh);
		form_mtk.fill(data);
	});
	
	 //添加
	$('#list_yzzz #yz_add').click(function(data){			
		if(json.xm!=null){
			$('#myModal').modal({backdrop:'static'});
			var aid=json.id;
			var fdata = {};
			fdata.sqjzrybh=json.id;
			fdata.aid=json.id;
			fdata.xm=json.xm;
			form_mtk.fill(fdata);
		}
		else{
			$('#close_alert_div').show();
		}
	});
	 
	 //提交
	$("#list_yzzz #yz_submit").click(function(data){
	if(form_mtk.validate()){
		service.saveYz(form_mtk.getData(),
				new Eht.Responder({success:function(data){
				table_yz.refresh();
				$('#myModal').modal('hide');
				$('#list_yzzz #yz_submit').enable();
			},
			error:function(msg){
				$('#list_yzzz #yz_submit').disabled();
			}
		}));
		}
	});
	 
	//右侧点击一行
	table_yz.clickRow(function(data){
		$("#yz_add").attr('disabled',true);
		$("#yz_del").attr('disabled',false);
		json=data;
		console.log(json);
	});

	//删除
	$("#yz_del").click(function(data){
		$('#list_yzzz #hideScDiv').show();
			//确定按钮
		$('#list_yzzz #shanchubtn').unbind('click').bind('click', function() {
			$('#list_yzzz #hideScDiv').hide();
			service.deleteOne(json);
			table_yz.loadData(function(page,res){
			service.findxx(aid,res);
			});
				setTimeout(function (){
					table_yz.refresh();}, 200);
				$("#yz_del").attr('disabled',true);
		});
					
	});

	//重置
	$("#yz_cz").click(function(){
		window.location.reload();
	});
	 
	//点击取消隐藏提示栏
	$('#list_yzzz #close_alert').click(function(){
		$('#list_yzzz #close_alert_div').hide();
	});
	
		$(document).ready(function(){
			var org="${CURRENT_USER_SESSION.orgType}";
	 		if(org==1){
			}
			if(org!=null&&org==2){
				var add=document.getElementById("yz_add"); 
				add.setAttribute("type","hidden");
				$("#yz_add").hide();
				
				var add=document.getElementById("yz_del"); 
				add.setAttribute("type","hidden");
				$('#yz_del').hide(); 
			}
			if(org==3){
	 			var add=document.getElementById("yz_add"); 
				add.setAttribute("type","hidden");
				
				var add=document.getElementById("yz_del"); 
				add.setAttribute("type","hidden"); 
			}
			if(org==4){
				table_yz.dblclickRow(function(data){
					$('#yz_submit').attr("disabled",false);
					$("#myModal").modal({backdrop : 'static',keyboard : false}); 
					form.fill(data);
				}); 
			}
			});
			

	
});
</script>
<style type="text/css">
	#list_yzzz{
		padding-top:15px;
	}
	#list_yzzz .mycol-md{
	    padding-right: 1px;
	    padding-left: 1px;
	}
</style>
</head>
<body>
	<div id="list_yzzz">
		<div class="alert alert-warning alert_dismissible" id="close_alert_div"  hidden role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 请选择一条信息!
			<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
		</div>
		<div class="alert alert-warning alert-dismissible" role="alert"
				id="hideScDiv" style="text-align: center; font-size: 17px">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>警告!</strong> 确定删除？ <input id="shanchubtn"
					class="btn btn-default" type="button" value="确定"> <input
					id="quxiaobtn1" class="btn btn-default" type="button" value="取消">
			</div>
		<div id="listXqbdqk" class="container-fluid">
			<div class="row">
				<div class="panel panel-default">
					<div class="panel-heading" class="panel-heading">
						<fieldset>
							姓名：<input type="text" id="search-xm" name="xm" class="btn btn-default" placeholder="请输入姓名查询" />
							<input type="button" id="search" class="btn btn-default" value="查询"/>
							<input type="button" id="yz_add" class="btn btn-default" value="添加"/>
							<input type="button" id="yz_del" class="btn btn-default" value="删除"/>
							<input type="button" id="yz_cz" class="btn btn-default" value="重置"/>
						</fieldset>
					</div>
					
				<div class="col-md-7 mycol-md"> 
					<div class="panel panel-default">	
						<div class="panel-heading"><center>个人信息</center></div>
							<div class="panel-body">
								<div id="grxx_form" class="table-responsive">
									<div field='op' label="选择" checkbox="true"></div>
									<div field="xm" label="姓名"></div>
									<div field="sfzh" label="身份证号" maxlength="18"></div>
									<div field="grlxdh" label="联系电话" maxlength="20"></div>
									<div field="jglx" label="管教类型" code="SYS114" ></div>
									<div field="pjrq" label="判决日期" maxlength="20"></div>
									<div field="zm" label="罪名" code="sys120" ></div>
								</div>
							</div>
					</div>
				</div>
				<div class="col-md-5 mycol-md">
					<div class="panel panel-default">	
						<div class="panel-heading"><center>余罪再罪信息</center></div>
							<div class="panel-body"  id="yzxx" >
								<div id="formls" class="table-responsive">
									<div id="yz_list">
										<div field="sszm"  	label="所涉罪名" code="SYS014"></div>
										<div field="zcjg" 	label="侦查机关" maxlength="20"></div>
										<div field="bcqqzcssj" 	label="被采取强制措施时间"></div>
										<div field="spjg" 	label="审判机关" maxlength="20"></div>
										<div field="zmms" 	label="罪名" ></div>
										<div field="xq"  	label="刑期" maxlength="20"></div>
									</div>		
								</div>		
							</div>	
					</div>	  
				</div>
					<!-- 模态框（Modal） -->
					<div class="modal fade" id="myModal">
						<div class="modal-dialog ">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
									<center><h4 class="modal-title" id="myModalLabel">余罪再罪信息</h4></center>
								</div>
								<div class="modal-body" >
								    	<div  class="panel panel-default">
								    		<div class="panel-body" id="formXqbdqk">
								    			<input type="text" label="社区矫正人员编号" name="sqjzrybh" id="sqjzrybh" disabled/>
								    			<input type="text" label="所涉罪名" name="sszm" id="sszm" code="SYS014" valid="{required:true}"/>
								    			<input type="text" label="侦查机关" name="zcjg" id="zcjg" maxlength="20" valid="{required:true}"/>
								    			<input type="text" label="被采取强制措施时间" name="BCQQZCSSJ" id="BCQQZCSSJ" class="form_date" data-date-format="yyyy-MM-dd" valid="{date:true}" maxlength="20"/>
								    			<input type="text" label="审判机关" name="spjg" id="spjg" maxlength="20"/>
								    			<input type="text" label="罪名" name="zm" id="zm" code="sys120"/>
												<input type="text" label="刑期" valid="{number:true}" name="xq" id="xq" maxlength="20"/>
								    		</div>
								    	</div>
								</div>
								<div class="modal-footer">
							        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							        <button type="button" class="btn btn-primary" id="yz_submit">提交</button>
							    </div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>	
				</div>
		</div>
	</div>
	
    
</div>
</body>		
</html>