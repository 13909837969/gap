<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>日常报告信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzRchbService.js"></script>
<script type="text/javascript">
$(function(){
	//连接后台Service
	var  Service = new SqjzRchbService();
	//主界面演示引用Tablew
	var tableView = new Eht.TableView({
		selector:'#list_Rchb #list_Rchb_Interface',
		autolayout:true
	});
	//定义查询表单
	var form_query = new Eht.Form({selector:"#querypanel"});
	//使用后台方法给TableView主界面带入数据信息
	tableView.loadData(function(page,res){
		Service.find(form_query.getData(),page,res);
	});
	//模态框里面的可修改填写From表单
	var form = new Eht.Form({
		selector:"#list_Rchb #form_rcbg",
		autolayout:true
		});
	//查询按钮
	$("#list_Rchb #query").click(function(){
		tableView.refresh();
	});

	//模态框
	//动态添加人员
	var Jzry_json={};
	$('#Newly').click(function(){
		form.clear();
		Service.findJzry(Jzry_json,new Eht.Responder({
			success:function(data){
				$("#form_liheng").empty();
				
				for(var i=0;i<data.length;i++){
					$("#form_liheng").append("<option value="+data[i].id+">"+data[i].xm + "     " + data[i].sfzh +"</option>");
				}
				$("#form_liheng").comboSelect();
			}
		}));
		$('#myModal').modal('show');
	});
	//提交按钮
	$("#list_Rchb #submit").click(function(){
		if(form.validate()){
		Service.saveOne(form.getData(),new Eht.Responder({
			success:function(){new Eht.Tips().show();
				$('#myModal').modal('hide');
				tableView.refresh();
			}
		}))
		
		}
		
	});
	//新增模态框计数----备注
	form.charValid(function(name,min,max){
		if(name=="bgnr"){
			$("#count").html(min+"/"+max);
			if( min/max > 3/4 ){
				$("#count").css("color","#f00");
			}else{
				$("#count").css("color","#00f");
			}
		}});
	
	//查看模态框
	tableView.transColumn("ckxx",function(data) {
		var button = $('<button  class="btn btn-default btn-sm" style="border-color:#128ef6;color:#128ef6;"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看</button>');
		button.unbind("click").bind("click",function() {
			$('#myModal').modal();
			
			$("#form_liheng").attr("disabled",true);
			$("#bgsj_jy").attr("disabled",true);
			$("#bgfs_jy").attr("disabled",true);
			$("#bgnr_jy").attr("disabled",true);
			$("#jlr_jy").attr("disabled",true);
			$("#jlsj_jy").attr("disabled",true);
			$("#form_liheng").attr("disabled",true);
			
			form.fill(data);			
			$('#form_liheng').append('<option selected>'+data.xm+'</option>');
			$("#submit").attr("disabled",true);
		});
		return button;
	});
});
</script>
</head>
<body>
<div id="list_Rchb">
	<div class="panel panel-default">
		<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<fieldset id="querypanel">
				 矫正人员查询:<input  class="btn btn-default" 	type="text" 	placeholder="请输入矫正人员姓名"  name="xm[like]"	style="margin-left: 10px;"/>
						  <input class="btn btn-default" 	type="button" 	id="query" 	value="查询" 	style="margin-left: 10px;"/>
						  <input class="btn btn-default" 	type="button" 	id="Newly" 	value="新增" 	style="margin-left: 10px;"/>
			</fieldset>
		</div>
		<!-- 主界面展示数据 -->
		<div id="list_Rchb_Interface">
			<div	field='op' 		label="选择" 	checkbox="true"></div>
			<div	field="xm"		label="社区矫正人员姓名"></div>
			<div	field="xb"		label="性别" code="sys000"></div>
			<div	field="sfzh"	label="身份证号" ></div>
			<div	field="grlxdh"	label="联系电话" ></div>
			<div	field="bgsj"	label="报告时间"></div>
			<div	field="bgfs"	label="报告方式" code="sys022"></div>
			<div	field="jlr"		label="记录人"></div>
			<div	field="jlsj"	label="记录时间"></div>
			<div 	field="ckxx" 	label="查看详细"></div>
		</div>    
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-lg ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
						<center><h4 class="modal-title" id="myModalLabel">新增日常报告信息</h4></center>
					</div>
					<div class="modal-body" id="form_rcbg">
					    			<select id="form_liheng" name="f_aid" label="服刑人员" style="max-width: none;" ></select> 
					    			<input type="text"  label="报告时间" name="bgsj" id="bgsj_jy"  valid="{required:true,date:true }" class="form_date" data-date-formate="yyyy-MM-dd" />
					    			<input type="text"  label="报告方式" name="bgfs"  id="bgfs_jy" valid="{required:true}" code="sys022"/>
					    			<textarea  id="bgnr_jy"  name="bgnr" label="报告内容"  maxlength="300" rows="3"  style="resize: none;" valid="{required:true}"></textarea>
										<div class="text-right"><span id="count"  style="color: #3F51B5"></span></div>
					    			<input type="text"  label="记录人"  name="jlr"  id="jlr_jy"  valid="{required:true,onlyChinese : true}"/>
					    			<input type="text"  label="记录时间" name="jlsj"  id="jlsj_jy" valid="{required:true,date:true}"  class="form_date" data-date-formate="yyyy-MM-dd"/>
					</div>
					<div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				        <button type="button" class="btn btn-primary" id="submit">提交</button>
				    </div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
	</div>
</div>
	
	
	
	

</body>
</html>