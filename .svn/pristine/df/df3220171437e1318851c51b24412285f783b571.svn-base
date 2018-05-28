<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>解除矫正信息(司法所)</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<script type="text/javascript">
$(function() {
	//连接后台
	var service = new JzJzryjbxxService();
	//填写from表单
	var form = new Eht.Form({selector : "#listJcjzxx #modal-body-div",autolayout:true});
	//主界面表头
	var formJc = new Eht.Form({selector :"#listJcjzxx #querypanel"});
	//查看from表单
	var formCk = new Eht.Form({selector :"#listJcjzxx #modal-body-divck",autolayout:true});
	//页面格式
	var tableView = new Eht.TableView({selector : "#listJcjzxx #tableview"});
	//页面展示数据
	tableView.loadData(function(page, res) {
		service.findYffjczmList(query, page, res);
	});
	//声明全局变量
	var query ={};
	//单击一行获取该行信息
	var json = {};
	//双击事件
	tableView.clickRow(function(data) {
		json = data;
		if(data.jcjz == '1'){
			$("#jcbtn").attr("disabled",true);
		}else{
			$("#jcbtn").attr("disabled",false);
		}
		
	});
	
	//提示框div初始状态为隐藏
	$('#listJcjzxx #hideDiv').hide();
	$('#listJcjzxx #hideScDiv').hide();
	//关闭按钮
	$('#listJcjzxx #guanbibtn').click(function(){
		$('#listJcjzxx #hideDiv').hide();
	});
	//取消按钮
	$('#listJcjzxx #quxiaobtn').click(function(){
		$('#listJcjzxx #hideDiv').hide();
		tableView.refresh();
	})
	$('#listJcjzxx #quxiaobtn1').click(function(){
		$("#listJcjzxx #hideScDiv").hide();
		tableView.refresh();
	})
	//关闭按钮事件 清除未选择的数据
	$('#listJcjzxx #close').click(function(){
		json={};
		tableView.refresh();
	});
	//关闭按钮事件 清除未选择的数据
	$('#listJcjzxx #xxx').click(function(){
		json={};
		tableView.refresh();
	});
	//查询按钮事件
	$("#listJcjzxx #querybtn").click(function() {
		query["xm[like]"]=$("#listJcjzxx #selectXM").val();
		query["jcjz[like]"] =$("#listJcjzxx #sfjc").val();
		tableView.refresh();
	});
	/*解除按钮  */
	$("#listJcjzxx #jcbtn").click(function(){
		form.clear();
		form.setValue("xm",json.xm);
		form.setValue("sfzh",json.sfzh);
		$("#id").val(json.id);
		$("#modal-body").show(function(){
			$('#listJcjzxx #btn-primary').unbind('click').bind('click',function(){
				service.save(form.getData(),new Eht.Responder({
					success:function(data){new Eht.Tips().show();
						tableView.refresh();
						$('#listJcjzxx #myModal').modal('hide');
					}
				}));
				
			});
		})
		$("#myModal").modal({
			backdrop : 'static',
			keyboard : false
		}); 
	});
	
	/* **双击某条数据，弹出人员详情页********* */
	tableView.dblclickRow(function(data){
		formCk.fill(json);
		$("#modal-body").show(function(){
			formCk.disable();
		})
		$("#listJcjzxx #ckmyModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		formCk.fill(json);
	});
	tableView.transColumn("audit",function(data) {
		if(data.audit == 0){
			return "未解除"
		}
		if(data.audit == 1){
			return "已解除"
		}
		if(data.audit== 2){
			return "待解除"
		}
	})
	tableView.transColumn("cz",function(data) {
		if(data.zmsid){
			var button=$('<button  class="btn btn-default btn-sm" style="border-color:#128ef6;color:#128ef6;"><span class="glyphicon glyphicon-list-alt"></span>&nbsp;生成通知书</button>');
			return button;
		}
		
	})
	
	//
	var textareaName1 = "#listJcjzxx #floor1";//备注输入框id
	var spanName1 = "#listJcjzxx #count1";//计数span的id
	$(textareaName1).click(function(){
		countChar(textareaName1,spanName1);
	});
	$(textareaName1).keyup(function(){
		countChar(textareaName1,spanName1);
	});
	$(textareaName1).keydown(function(){
		countChar(textareaName1,spanName1);
	});
	//
	var textareaName2 = "#listJcjzxx #floor2";//备注输入框id
	var spanName2 = "#listJcjzxx #count2";//计数span的id
	$(textareaName2).click(function(){
		countChar(textareaName2,spanName2);
	});
	$(textareaName2).keyup(function(){
		countChar(textareaName2,spanName2);
	});
	$(textareaName2).keydown(function(){
		countChar(textareaName2,spanName2);
	});
	//
	var textareaName3 = "#listJcjzxx #floor3";//备注输入框id
	var spanName3 = "#listJcjzxx #count3";//计数span的id
	$(textareaName3).click(function(){
		countChar(textareaName3,spanName3);
	});
	$(textareaName3).keyup(function(){
		countChar(textareaName3,spanName3);
	});
	$(textareaName3).keydown(function(){
		countChar(textareaName3,spanName3);
	});
	function countChar(textareaName,spanName){ 
	   if($(textareaName).val() != ""){
			$(spanName).text("已输入：" + $(textareaName).val().length + "/250");			
			if($(textareaName).val().length>0){
					$(spanName).css("color","#3F51B5");
			};
			if($(textareaName).val().length>240){
					$(spanName).css("color","#FF0000");
				};
		}else{
			$(spanName).text("已输入：0/250");
		}
	};
	//判断选择内容
	$("#listJcjzxx #jjlx").change(function(){
		if($("#listJcjzxx #jjlx").val() == "01"){
			$("#listJcjzxx #sjzxyy").disable();
			$("#listJcjzxx #sjzxlx").disable();
			$("#listJcjzxx #sjzxrq").disable();
			$("#listJcjzxx #swsj").disable();
			$("#listJcjzxx #swyy").disable();
			$("#listJcjzxx #floor1").disable();//具体死因
		}else if($("#listJcjzxx #jjlx").val() == "02"){
			$("#listJcjzxx #swsj").disable();
			$("#listJcjzxx #swyy").disable();
			$("#listJcjzxx #floor1").disable();//具体死因
			$("#listJcjzxx #sjzxyy").enable();
			$("#listJcjzxx #sjzxlx").enable();
			$("#listJcjzxx #sjzxrq").enable();
		}else if($("#listJcjzxx #jjlx").val() == "03"){
			$("#listJcjzxx #sjzxyy").disable();
			$("#listJcjzxx #sjzxlx").disable();
			$("#listJcjzxx #sjzxrq").disable();
			$("#listJcjzxx #swsj").enable();
			$("#listJcjzxx #swyy").enable();
			$("#listJcjzxx #floor1").enable();//具体死因
		}else if($("#listJcjzxx #jjlx").val() == "04"){
			$("#listJcjzxx #sjzxyy").disable();
			$("#listJcjzxx #sjzxlx").disable();
			$("#listJcjzxx #sjzxrq").disable();
			$("#listJcjzxx #swsj").disable();
			$("#listJcjzxx #swyy").disable();
			$("#listJcjzxx #floor1").disable();//具体死因
		}else if($("#listJcjzxx #jjlx").val() == "99"){
			$("#listJcjzxx #sjzxyy").disable();
			$("#listJcjzxx #sjzxlx").disable();
			$("#listJcjzxx #sjzxrq").disable();
			$("#listJcjzxx #swsj").disable();
			$("#listJcjzxx #swyy").disable();
			$("#listJcjzxx #floor1").disable();//具体死因
		}
	})
	
});

</script>
</head>
<body>
<div id="listJcjzxx">
	<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
					姓名：<input class="btn btn-default" type="text" name="xm[like]" id="selectXM" placeholder="请输入姓名" style="margin-left: 10px" /> 
					<label style="margin-left: 10px">是否解除矫正:</label> 
					<select type="text"  id="sfjc"  style="width: 120px;background-color: #fff;" class="input-group-addon">
						<option value="">全部</option>
						<option value="1">是</option>
						<option value="0">否</option>
					</select> 
					<input class="btn btn-default" type="button" id="querybtn" value="查询">
					<input id="jcbtn" name="jc" class="btn btn-default" type="button" value="解除" disabled>
				</fieldset>
			</div>
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideDiv" style="text-align:center;font-size:17px">
				    <strong>警告!</strong> 请先选择一条信息！
				    <input id="quxiaobtn" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="alert alert-warning alert-dismissible" role="alert" id="hideScDiv" style="text-align:center;font-size:17px">
				    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				    <strong>警告!</strong> 确定删除？
				    <input id="shanchubtn" class="btn btn-default" type="button" value="确定" >
				    <input id="quxiaobtn1" class="btn btn-default" type="button" value="取消" >
			</div>	
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别" code="sys000"></div>
					<div field="sfzh" label="身份证号"></div>
					<div field="jglx" label="矫管类型" code="sys114"></div>
					<div field="grlxdh" label="联系电话"></div>
					<div field="jjlx" label="矫正解除（终止）类型" code="sys018"></div>
					<div field="jjrq" label="矫正解除（终止）日期"></div>
					<div field="audit" label="解除状态"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
<!-- 模态框(填写) -->
	<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">解除(终止)矫正信息</h4>
					</div>
					<div class="modal-body" id="modal-body" style="height: 480px; overflow: auto">
						<div id="modal-body-div">
							<input name="id" id="id" type="hidden">
							<input name="xm" type="text"  id="xm"  label="矫正人员姓名" readonly="readonly"/>
							<input name="sfzh" type="text"  id="sfzh"  label="身份证号" readonly="readonly"/>
							<input  name="jjrq" type="text" label="矫正解除日期"  class="form_date" data-date-format="yyyy-MM-dd" placeholder="请输入矫正解除日期"  valid="{date:true,required:true}"/>
							<input  name="jjlx" type="text" id="jjlx" label="矫正解除类型" placeholder="请选择矫正解除类型" code="sys018">
							<input name="sjzxyy" type="text" id="sjzxyy" label="收监执行原因" placeholder="请选择收监执行原因" code="sys010">
							<input name="sjzxlx" type="text" id="sjzxlx" label="收监执行类型" placeholder="请选择收监执行类型" code="sys011">
							<input  name="sjzxrq" type="text" id="sjzxrq" label="收监执行日期"  class="form_date" data-date-format="yyyy-MM-dd" placeholder="请输入收监执行日期">
							<input  name="swsj" type="text" id="swsj" label="死亡日期" placeholder="请输入死亡日期" data-date-format="yyyy-MM-dd">
							<input name="swyy" type="text" id="swyy" label="死亡原因" placeholder="请选择死亡原因" code="sys019">
							<textarea label="具体死因" rows="8" name="jtsy" id="floor1" type="text" maxlength="250" placeholder="请输入具体死因"></textarea>
							<div class="text-right"><span id="count1" style="margin-left:420px;color:#3F51B5"></span></div>
							<input  name="jzqjbx" type="text" label="矫正期间表现" class="form_date_time form-control" code="sys024" placeholder="请选择矫正期间表现">
							<input  name="rztd" type="text" label="认罪态度" placeholder="请选择认罪态度" code="sys042">
							<input name="sfcjzyjnpx" type="text" label="是否参与职业技能培训" placeholder="请选择是否参与职业技能培训" code="sys001">
							<input name="sfhdzyjnzs" type="text" label="是否获得职业技能证书" placeholder="请选择是否获得职业技能证书" code="sys001">
							<textarea label="技术特长及等级" rows="8" name="jstcjdj" id="floor2" type="text" maxlength="250" placeholder="请输入技术特长及等级" valid="{required:true}"></textarea>
							<div class="text-right"><span id="count2" style="margin-left:420px;color:#3F51B5"></span></div>
							<input  name="wxxpg" type="text" label="危险性评估" placeholder="请选择危险性评估" code="sys043">
							<input name="jtlxqk" type="text" label="家庭关系情况" placeholder="请选择家庭关系情况" code="sys044">
							<textarea label="特殊情况备注及帮教建议" rows="8" name="tsqkbzjbjjy" id="floor3" type="text" maxlength="250" placeholder="请输入特殊情况备注及帮教建议" valid="{required:true}"></textarea>
							<div class="text-right"><span id="count3" style="margin-left:420px;color:#3F51B5"></span></div>
							<input name="sfsjcr" type="text" label="司法所解除人" placeholder="请输入司法所解除人" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="btn-primary">提交</button>
					</div>
				</div>
			</div>
		</div>
<!-- 查看模态框（Modal） -->
	<div class="modal fade" id="ckmyModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"aria-hidden="false" >×</button>
						<h4 class="modal-title" >解除矫正信息</h4>
					</div>
					<div class="modal-body" id="modal-bodyck" style="height: 480px; overflow: auto">
						<div id="modal-body-divck">
							<input name="id"  type="hidden">
							<input name="xm" type="text"   label="矫正人员姓名" disabled/>
							<input name="sfzh" type="text"    label="身份证号" disabled/>
							<input  name="jjrq" type="text"  label="矫正解除日期"   class="form_date" data-date-format="yyyy-MM-dd" >
							<input  name="jjlx" type="text"  label="矫正解除类型"   code="sys018">
							<input name="sjzxyy" type="text"  label="收监执行原因"   code="sys010">
							<input name="sjzxlx" type="text"  label="收监执行类型" 	 code="sys011">
							<input  name="sjzxrq" type="text"  label="收监执行日期" 	 class="form_date" data-date-format="yyyy-MM-dd" >
							<input  name="swsj" type="text"  label="死亡日期"  	data-date-format="yyyy-MM-dd">
							<input name="swyy" type="text"  label="死亡原因" 	  code="sys019">
							<textarea label="具体死因" rows="8" name="jtsy" type="text" maxlength="250" ></textarea>
							<div class="text-right"><span  style="margin-left:420px;color:#3F51B5"></span></div>
							<input  name="jzqjbx" type="text" label="矫正期间表现" class="form_date_time form-control" code="sys024" //>
							<input  name="rztd" type="text" label="认罪态度"  code="sys042" id="" />
							<input name="sfcjzyjnpx" type="text" label="是否参与职业技能培训"  code="sys001" />
							<input name="sfhdzyjnzs" type="text" label="是否获得职业技能证书" code="sys001" />
							<textarea label="技术特长及等级" rows="8" name="jstcjdj"  type="text" maxlength="250" ></textarea>
							<div class="text-right"><span  style="margin-left:420px;color:#3F51B5"></span></div>
							<input  name="wxxpg" type="text" label="危险性评估"  code="sys043" />
							<input name="jtlxqk" type="text" label="家庭关系情况"  code="sys044" />
							<textarea label="特殊情况备注及帮教建议" rows="8" name="tsqkbzjbjjy"  type="text" maxlength="250" ></textarea>
							<div class="text-right"><span  style="margin-right:4200px;color:#3F51B5"></span></div>
							<input name="sfsjcr" type="text" label="司法所解除人"  value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
</div>
</body>
</html>