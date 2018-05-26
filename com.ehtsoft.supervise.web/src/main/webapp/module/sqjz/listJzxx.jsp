<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>矫正信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/LoginService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzryJzxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">
	$(function(){
		var service = new JzryJzxxService();
		var form1 = new Eht.Form({selector:"#querypanel"});
		var form = new Eht.Form({
			selector:"#formJzxx-border",
			autolayout:true
			//formCol:2
		});
		var tableView = new Eht.TableView({
			selector : "#listJzxx_table",
			paginate:null,
			multable:true
		});
		tableView.loadData(function(page,res){
			service.findAll(form1.getData(),page,res)
		});
		var json = {};
		tableView.clickRow(function(data){json=data});
		//查询按钮触发事件
		$("#listJzxx #querybtn").click(function(){
			tableView.refresh();
		});
		//新增按钮触发事件
		$("#listJzxx #addbtn").click(function(){
			$("#listJzxx #modal-body").load("${localCtx}/module/sqjz/formJzxx.jsp?load=load",function(){
				$(".form_date").datetimepicker({
					format: 'yyyy-mm-dd', 
					language:  'zh-CN',
					autoclose: true,
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					//todayHighlight: 1,
					//startView: 2,
					minView: 2,
					forceParse: 0	
				});
			})
			$("#listJzxx #myModal").modal({
				backdrop : 'static',
				keyboard : false
			}); 
		}); 
		//修改按钮触发事件
		$("#listJzxx #updatebtn").click(function(){
			$("#listJzxx #modal-body").load("${localCtx}/module/sqjz/formJzxx.jsp?load=load",function(){
				$(".form_date").datetimepicker({
					format: 'yyyy-mm-dd', 
					language:  'zh-CN',
					autoclose: true,
			        weekStart: 1,
			        todayBtn:  1,
					autoclose: 1,
					//todayHighlight: 1,
					//startView: 2,
					minView: 2,
					forceParse: 0	
				});
				var array = tableView.getSelectedData();
				if(array.length == 0){
					$("#hideDiv").show();
				}else{
					form.fill(json);
					$("#listJzxx #myModal").modal({
						backdrop : 'static',
						keyboard : false
					});
				}
			})
		});
		//删除信息
		$("#listJzxx #deletebtn").click(function(){
			var array = tableView.getSelectedData();
			if(array == 0){
				$("#hideDiv").show();
			}else{
				$("#hideScDiv").show();
				$("#shanchubtn").unbind("click").bind("click",function(){
					$("#hideScDiv").hide();
					service.remove(array);
					tableView.refresh();
				})
			}
			tableView.refresh();
		}); 
		//取消关闭按钮
		$("#listJzxx #quxiaobtn").click(function(){
			$("#hideDiv").hide();
			tableView.refresh();
		});
		$("#listJzxx #quxiaobtn1").click(function(){
			$("#hideScDiv").hide();
			tableView.refresh();
		});
		//关闭按钮
		$("#listJzxx #close").click(function(){
			form.clear();
		});
		$("#listJzxx #xxx").click(function(){
			form.clear();
		});
		
	})
</script>
</head>
<body>
	<%out.print("<input type='hidden' value='0' id='form-edit-flag'>"); %>
	<div class="panel panel-default" id="listJzxx" style="margin-top:10px">
		<div class="panel-heading">
			<fieldset id="querypanel" style="margin-left:10px;">
				姓名：<input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/> 
				<input id="querybtn" class="btn btn-default" type="button" value="查询">
				<input id="addbtn" class="btn btn-default" type="button" value="新增">
				<input id="updatebtn" class="btn btn-default" type="button" value="修改">
			    <input id="deletebtn" class="btn btn-default" type="button" value="删除"> 
			</fieldset>
		</div>
		<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px;display:none;">
		    <strong>警告!</strong> 请先选择一条信息！
		    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
		</div>	
		<div class="alert alert-warning alert-dismissible" role="alert" id="hideScDiv" style="text-align:center;font-size:17px;display:none">
		    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		    <strong>警告!</strong> 确定删除？
		    <input id="shanchubtn" class="btn btn-default" type="button" value="确定" >
		    <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消" >
		</div>
		<div id="listJzxx_table" class="panel-body" style="padding:3px;">
			<div field="xzk" label="选择" checkbox="true"></div>
			<div field="xm" label="姓名"></div>
			<div field="sfzh" label="身份证号"></div>
			<div field="jzjg" label="矫正机构"></div>
			<div field="bdqk" label="报到情况"></div>
			<div field="dzdwfs" label="电子定位方式"></div>
			<div field="jfzxrq" label="交付执行日期"></div>
			<div field="sqjzryjsrq" label="服刑人员接收日期"></div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">矫正信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 400px; overflow: auto">
						
					</div>
					<div class="modal-footer">
				        <button type="button" class="btn btn-default" id="close" data-dismiss="modal">关闭</button>
				        <button type="button" class="btn btn-primary" id="btn-primary">提交</button>
				    </div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>		
		
	</div>
</body>
</html>