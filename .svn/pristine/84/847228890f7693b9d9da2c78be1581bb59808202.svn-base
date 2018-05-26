<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>司法所工作人员基本信息表</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JCshzyzxxService.js"></script>
	<script type="text/javascript">
	$(function(){
		var service=new JCshzyzxxService();
		var tableView = new Eht.TableView({
			selector : "#ssfgzry_list",
			autolayout:true
			});
		
		var form = new Eht.Form({
			selector : "#formsfsjbry",
			autolayout:true,
			colLabel:"col-sm-3 col-xs-3",
			colCombo:"col-sm-9 col-xs-9",
			});
		
		var query={};
		var NowData={};
		
		$("#sfsgzry_del").attr('disabled',true);
		
		tableView.loadData(function(page,res){
			service.find(query,page,res);
		});
		
		//查询
		$("#querybtn").click(function(){
			query["xm[like]"] = $("#search-xm").val();
			query["sfzh[like]"] = $("#search-sfzh").val();
			tableView.refresh();
		});
		
		//增加
		$("#sfsgzry_add").click(function(){
			$("#myModal").modal({backdrop : 'static',keyboard : false}); 
			form.clear();
		});
		
		tableView.clickRow(function(data){
			NowData=data;
			if(data.id!=null){
				$("#sfsgzry_del").attr('disabled',false);
			}
		});
		
		//删除
		$("#sfsgzry_del").click(function(data){
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
			$("#ssjg").html=data.orgid;
			form.fill(data);
		}); 
		
		//提交
		$('#sfsgzry_submit').click(function(){
			if(form.validate()){
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
	<div>
		<div class="panel panel-default">
			<fieldset id="xqbg_queryform" class="panel-heading">
				<label>姓名：</label><input type="text" name="xm" class="btn btn-default" placeholder="请输入姓名" id="search-xm"/>		
				<label>身份证号：</label><input type="text" name="sfzh" class="btn btn-default" placeholder="请输入身份证号" id="search-sfzh"/>				
				 <input id="querybtn" class="btn btn-default" type="button" value="查询">
				 <input id="sfsgzry_add" class="btn btn-default" type="button" value="增加">
				 <input id="sfsgzry_del" class="btn btn-default" type="button" value="删除">
			</fieldset>
		<div class="panel-body" >
			<div id="ssfgzry_list">
				<div field='op' 	label="选择" 	checkbox="true"></div>
				<div field="xm"  	label="姓名" ></div>
				<div field="sfzh"  	label="身份证号"></div>
				<div field="rybm"  	label="人员类型" code="SYS020"></div>
				<div field="sjhm"  	label="联系电话"></div>
				<div field="dzyx"  	label="电子邮箱"></div>
			</div>					
		</div>
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
					<center><h4 class="modal-title" id="myModalLabel">司法所工作人员基本信息</h4></center>
				</div>
				<div class="modal-body" >
				    	<div  class="panel panel-default">
				    		<div class="panel-body" id="formsfsjbry">
				    			<input type="text"  label="姓名" name="xm" valid="{required:true,onlyChinese:true}" maxlength="10"/>
				    			<input type="text"  label="性别" name="xb" code="sys000"/>
				    			<input type="text"  label="所属机构" name="ssjg" valid="{required:true}" maxlength="18"/>
				    			<input type="text"  label="人员类型" name="rybm" code="SYS020" maxlength="18"/>
				    			<input type="text"  label="身份证号码" name="sfzh"  maxlength="18" valid="{required:true,cardNo:true}"/>
				    			<input type="text"  label="出生日期" name="csrq" class="form_date" maxlength="18"/>
				    			<input type="text"  label="民族" name="mz"  code="SYS003"/> 
				    			<input type="text"  label="政治面貌" name="zzmm"  code="SYS091"/>
				    			<input type="text"  label="人员编制" name="rybz"  code="SYS007"/>
				    			<input type="text"  label="学历" name="xl" code="SYS028"/>
				    			<input type="text"  label="专业" name="zy"  code="SYS095"/>
				    			<input type="text"  label="毕业院校" name="byyx"  maxlength="30"/>
				    			<input type="text"  label="联系电话" name="lxdh"  maxlength="18"/>
				    			<input type="text"  label="手机号码" name="sjhm"  maxlength="11" valid="{mobile:true}"/>
				    			<input type="text"  label="电子邮箱" name="dzyx"  maxlength="30" valid="{email:true}"/>
				    			<input type="text"  label="参加工作时间" name="cjgzsj" class="form_date" maxlength="18"/>
				    		</div>
				    	</div>
					</div>
				<div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" id="sfsgzry_submit">提交</button>
			    </div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
		
	</div>
</body>
</html>