<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<title>判决信息</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/LoginService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzryPjxxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">
	$(function(){
		var service = new JzryPjxxService();
		var form = new Eht.Form({
			selector:"#formPjxx-border",
			autolayout:true
			//formCol:2
		});
		var form1 = new Eht.Form({
			selector:"#listPjxx",
		});
		var tableView = new Eht.TableView({
			selector : "#listPjxx_table",
			paginate:null,
			multable:true,
			valueCodeField:"f_code",
			labelCodeField:"f_name"
		});
		tableView.loadData(function(page,res){
			service.findAll(form1.getData(),page,res);
		})
		var json = {};
		tableView.clickRow(function(data){json=data});
		//查询按钮触发事件
		$("#listPjxx #querybtn").click(function(){
			tableView.refresh();
		});
		//新增按钮触发事件
		$("#listPjxx #addbtn").click(function(){
			$("#listPjxx #modal-body").load("${localCtx}/module/sqjz/formPjxx.jsp?load=load",function(){
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
			$("#listPjxx #myModal").modal({
				backdrop : 'static',
				keyboard : false
			}); 
		}); 
		//修改按钮触发事件
		$("#listPjxx #updatebtn").click(function(){
			$("#listPjxx #modal-body").load("${localCtx}/module/sqjz/formPjxx.jsp?load=load",function(){
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
					$("#listPjxx #myModal").modal({
						backdrop : 'static',
						keyboard : false
					}); 
				}
			})
		});
		//删除信息
		$("#listPjxx #deletebtn").click(function(){
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
		$("#listPjxx #quxiaobtn").click(function(){
			$("#hideDiv").hide();
			tableView.refresh();
		});
		$("#listPjxx #quxiaobtn1").click(function(){
			$("#hideScDiv").hide();
			tableView.refresh();
		});
		//关闭按钮
		$("#listPjxx #close").click(function(){
			form.clear();
		});
		$("#listPjxx #xxx").click(function(){
			form.clear();
		});
		
	})
</script>
</head>
<body>
	<%out.print("<input type='hidden' value='0' id='form-edit-flag'>"); %>
	<div class="panel panel-default" id="listPjxx" style="margin-top:10px">
		<div class="panel-heading" style="padding-left:10px;">
			<fieldset id="querypanel">
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
		<div id="listPjxx_table" class="panel-body" style="padding:3px;">
			<div field="xzk" label="选择" checkbox="true"></div>
			<div field="xm" label="姓名"></div>
			<div field="sfzh" label="身份证号"></div>
			<div field="sqjzjdjg" label="社区矫正决定机关"></div>
			<div field="yjzfjg" label="移交罪犯机关"></div>
			<div field="pjsbh" label="判决书编号"></div>
			<div field="pjrq" label="判决日期"></div>
			<div field="wssxrq" label="文书生效日期"></div>
			<div field="ypxqksrq" label="原判刑期开始日期"></div>
			<div field="ypxqjsrq" label="原判刑期结束日期"></div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog ">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">判决信息</h4>
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