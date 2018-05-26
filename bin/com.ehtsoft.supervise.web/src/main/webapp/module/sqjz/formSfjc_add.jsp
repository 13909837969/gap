<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>司法奖惩-操作页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzrySfjcService.js"></script>
<script type="text/javascript">

	$(function() {
		/****** 矫正人员信息div初始化隐藏 ******/
		$("#sqjz_fromSfjc_add #tableaaa").hide(); 
		var service = new JzrySfjcService();
		var jclb = Eht.DataCode["sys082"];//获取奖惩类别字典-数组
		var jcyy = Eht.DataCode["sys083"];//获取奖惩原因字典-数组
		var addressJclb = $("#sqjz_fromSfjc_add #jclb");//奖惩类别插入地址
		var addressJcyy = $("#sqjz_fromSfjc_add #jcyy");//奖惩原因插入地址
		/*****给矫正人员信息div内插入数据*****/
		var table = new Eht.TableView({selector:"#sqjz_fromSfjc_add #tableaaa",
			valueCodeField:"f_code",labelCodeField:"f_name",paginate:null});//此处为无页码信息的数据
		var jcid = "${param.jcid}";
		var query = {};
		var form = new Eht.Form({selector:'#sqjz_fromSfjc_add #form'});
		var state = "0";//状态符  0:新增 ；   1：修改
		var sw = [0,0,0,0];//空字段状态 若字段为空，改为1；
		
		//若是修改页面，则矫正人员信息不可变
		if(jcid != ""){
			state = "1";
			$("#sqjz_fromSfjc_add #xuanze").attr("readonly","readonly");
		};
		/* 单击提交按钮提交数据到数据库 */
		$("#sqjz_listSfjc_all #btn-primary").unbind("click").bind("click",function() {
			var formData = form.getData();
			var flag = "0";
			if(formData.xm != "" && sw[0] == "1"){
				sw[0] = "0";
				$("#sqjz_fromSfjc_add #jzdxC").removeClass("has-error");
				$("#sqjz_fromSfjc_add #jzdxC").find("span")[0].style.display="none";
			}
			if(formData.xm == "" && sw[0] == "0"){
				flag = "1";
				sw[0] = "1";
				$("#sqjz_fromSfjc_add #jzdxC").addClass("has-error");
				$("#sqjz_fromSfjc_add #jzdxC").find("span")[0].style.display="inline";
			}
			if(formData.jcsj != ""&& sw[1] == "1"){
				sw[1] = "0";
				$("#sqjz_fromSfjc_add #jcssC").removeClass("has-error");
				$("#sqjz_fromSfjc_add #jcssC").find("span")[0].style.display="none";
			}
			if(formData.jcsj == ""&& sw[1] == "0"){
				flag = "1";
				sw[1] = "1";
				$("#sqjz_fromSfjc_add #jcssC").addClass("has-error");
				$("#sqjz_fromSfjc_add #jcssC").find("span")[0].style.display="inline";
			}
			if((formData.jclb != ""&& sw[2] == "1")||(formData.jclb != "00"&& sw[2] == "1")){
				sw[2] = "0";
				$("#sqjz_fromSfjc_add #jclbC").removeClass("has-error");
				$("#sqjz_fromSfjc_add #jclbC").find("span")[0].style.display="none";
			}
			if((formData.jclb == ""&& sw[2] == "0")||(formData.jclb == "00"&& sw[2] == "0")){
				flag = "1";
				sw[2] = "1";
				$("#sqjz_fromSfjc_add #jclbC").addClass("has-error");
				$("#sqjz_fromSfjc_add #jclbC").find("span")[0].style.display="inline";
			}
			if((formData.jcyy != "" && sw[3] == "1") || (("jcyy" in formData) && sw[3] == "1")){
				sw[3] = "0";
				$("#sqjz_fromSfjc_add #jcyyC").removeClass("has-error");
				$("#sqjz_fromSfjc_add #jcyyC").find("span")[0].style.display="none";
			}
			if((formData.jcyy == ""&& sw[3] == "0") || (!("jcyy" in formData)&& sw[3] == "0")){
				flag = "1";
				sw[3] = "1";
				$("#sqjz_fromSfjc_add #jcyyC").addClass("has-error");
				$("#sqjz_fromSfjc_add #jcyyC").find("span")[0].style.display="inline";
			}
			
			if(flag == "0"){
				primary();//执行提交数据
			}
		});
		/* 将经过验证的数据提交到数据库内 */
		function primary() {//此按钮为父页-模态框【提交】按钮
			service.save(form.getData(), new Eht.Responder({
				success : function() {
					$("#sqjz_listSfjc_all #tableaaa").refreshTable();
					$('#sqjz_listSfjc_all #myModal').modal('hide');
				}
			}));
		};
		
		/****给奖惩类别插入下拉选项*****/
		for(var i=0;i<jclb.length;i++){
			if(jclb[i].f_code != 02){
				if(jclb[i].f_code == "0201"){
					var option = '<option value="' +jclb[i].f_code + '">治安处罚-依社区矫正机构提请</option>';
				}else if(jclb[i].f_code == "0202"){
					var option = '<option value="' +jclb[i].f_code + '">治安处罚-公安机关依法给予</option>';
				}else{
					var option = '<option value="' +jclb[i].f_code + '">'+ jclb[i].f_name + '</option>';
				}
			}else{
				continue;
			}
			addressJclb.append(option);
		};
		
		/***当奖惩类别内容change时触发***/
		addressJclb.change(function(){
			var lb = addressJclb.val();
			decideJcyy(lb);
		});
		/* 单击某条数据隐藏人员信息表 */
		table.clickRow(function(data){
			/* 数据输入 */
			data.f_aid = data.id;
			form.fill(data);
			$("#sqjz_fromSfjc_add #floor").val("");
			/* 人员信息表隐藏 */
			$("#sqjz_fromSfjc_add #tableaaa").hide(); 
		});
		
		/*****给矫正人员信息div内插入数据*****/
		table.loadData(function(page,res){service.findA(query,page,res);});
		
		/* 当矫正人员输入框内容change时，弹出div框及所有矫正人员信息，选择人员进行新增 */
		$("#sqjz_fromSfjc_add #xuanze").bind("onchange",function(){
			if($("#sqjz_fromSfjc_add #xuanze").val() !=""){
				query["xm[like]"]=$("#sqjz_fromSfjc_add #xuanze").val();
				table.refresh();
				$("#sqjz_fromSfjc_add #tableaaa").show();//矫正人员基本信息div弹出
				$("#sqjz_fromSfjc_add #tableaaa").focus();
				$("#sqjz_fromSfjc_add #xuanze").focus();
			}else{
				$("#sqjz_fromSfjc_add #tableaaa").hide();//矫正人员基本信息div隐藏 
			}
		})
		
		/* 当矫正人员输入框内输入内容时，触发查询 */
		$("#sqjz_fromSfjc_add #xuanze").keyup(function(){
			if(state == "0"){
				$("#sqjz_fromSfjc_add #xuanze").change();
			}
		});
		
		/****当矫正类别发生变化时，奖惩原因跟随其变化，需调如下方法做判断****/
		function decideJcyy(lb){
			if(lb == "00"){//当矫正类别选择"00"时
				addressJcyy.empty();
			};
			if(lb == "01"){//当矫正类别选择“01”-警告时，奖惩原因选择
				addressJcyy.empty();
				for(var j=0;j<6;j++){
					inputJcyy(j);
				}
			};
			if(lb == "02"||lb == "0201"||lb == "0202"){
				addressJcyy.empty();
				for(var j=6;j<8;j++){
					inputJcyy(j);
				}
			};
			if(lb == "03"){
				addressJcyy.empty();
				for(var j=8;j<jcyy.length;j++){
					inputJcyy(j);
				}
			};
		};
		
		/* ******************以下为包含【日、时间】视图的********************** */
		$(".form_date_time").datetimepicker({
			format: 'yyyy-mm-dd hh:ii', 
			language:  'zh-CN',
			autoclose: true,
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			minView: 0,
			forceParse: 0	
		});
		/* 单击时间框选择时间 */
		$(".calendar_time").click(function(){
			$(this).parent().find(".form_date_time").datetimepicker("show");
		});
		if(jcid != ""){
			/* 当父页选中个人信息并单击修改按钮时，给该页填充需要修改的数据 */
			service.findOne(jcid,new Eht.Responder({
				success:function(data){
					var lb = data.jclb;
					decideJcyy(lb);
					form.fill(data);
				}
			}));
		}
		var textareaName = "#sqjz_fromSfjc_add #floor";//备注输入框id
		var spanName = "#sqjz_fromSfjc_add #count";//计数span的id
		$(textareaName).click(function(){
			countChar(textareaName,spanName);
		});
		$(textareaName).keyup(function(){
			countChar(textareaName,spanName);
		});
		$(textareaName).keydown(function(){
			countChar(textareaName,spanName);
		});
		/* ***************textarea输入框字数判断******************* */
		function countChar(textareaName,spanName){ 
			if($(textareaName).val() != ""){
				$(spanName).text("已输入：" + $(textareaName).val().length + "/250");
			}else{
				$(spanName).text("已输入：0/250");
			}
		};
		/****当矫正类别发生变化时，奖惩原因跟随其变化，需调如下方法动态插入****/
		function inputJcyy(j){
			var input = '<input type="checkbox" name="jcyy" value="'+jcyy[j].f_code+'">'+jcyy[j].f_name+'<br>';
			addressJcyy.append(input);
		};
		
	});
	
</script>
<style type="text/css">
	#sqjz_fromSfjc_add{
		scrollTop:100px;
	}
	#sqjz_fromSfjc_add #tableaaa{
		
		width:73%;
		height:300px;
		background-color: #FFFFFF;
		margin:auto; 
		position: absolute;
		top: -20px; left: 98px; bottom: 0; right: 0;  
		overflow-y:auto;
	    overflow-x:auto;
	}
	#sqjz_fromSfjc_add #tableaaa .table>thead>tr>th{
		background:#EEE9E9;
	}
 	#sqjz_fromSfjc_add #jcyy{
	    overflow-y:auto;
	    overflow-x:auto;
	    width:100%;
	    height:180px;
	}  
	#sqjz_fromSfjc_add #floor{
		width:100%;
		height:180px;
	} 
</style>
</head>
<body>
	<div id="sqjz_fromSfjc_add">
		<form class="form-horizontal" role="form" id="form">
			<div id="head">
				<div hidden>
					<input name="f_aid" type="hidden">
					<input name="sqjzrybh" type="hidden"  placeholder="社区服刑人员编号">
				</div>
				<div class="form-group" id="jzdxC">
					<label for="xuanze" class="col-sm-2 control-label">选择服刑对象:</label>
					<div class="col-sm-10">
						<input name="xm" type="text" class="form-control" id="xuanze" autocomplete="off" placeholder="请输入汉字">
						<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
					</div>
				</div>
				<div class="form-group">
					<label for="lastname" class="col-sm-2 control-label">身份证号:</label>
					<div class="col-sm-10">
						<input name="sfzh" type="text" readonly="readonly" class="form-control" id="lastname"   placeholder="身份证号">
					</div>
				</div>
				<!-- ******************************初始状态为隐藏，单击矫正对象框时弹出********************************************** -->
							<div id="tableaaa" style="z-index:999;">
								<div field="xm" label="姓名" style="color:#fff"></div>
								<div field="xb" label="性别" code="SYS000"></div>
								<div field="sfzh" label="身份证号"></div>
							</div>	
				<!-- **************************************************************************** -->
				<div class="form-group" id="jcssC">
					<label for="time" class="col-sm-2 control-label">奖惩时间:</label>  
					<div class="col-sm-10">
					    <input id="time" name="jcsj" type="text" class="form_date_time form-control" autocomplete="off" data-date-format="yyyy-MM-dd">
						<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
					</div>
				</div>
				<div class="form-group" id="jclbC">
					<label class="col-sm-2 control-label">奖惩类别:</label>
					<div class="col-sm-10">
						<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
						<select id="jclb" name="jclb" class="form-control">
							<option selected value="00">请选择</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group" id="jcyyC"  style="margin-left:15px">
				<label for="floor" class="col-sm-2 control-label">奖惩原因:</label>
				<div class="col-sm-10" >
					<div id="jcyy"  class="form-control">
						<input name="jcyy" type="hidden" id="xgjcyy">
						<span class="glyphicon glyphicon-warning-sign form-control-feedback" aria-invalid="true" style="right:20px;display:none;"></span>
					</div>
				</div>		
			</div>
			<div class="form-group"  style="margin-left:15px">
				<label for="floor" class="col-sm-2 control-label">备注:</label>
				<div class="col-sm-10">
					<textarea name="remark"  id="floor" type="text" maxlength="250" class="form-control"></textarea>
					<span id="count" style="margin-left:310px;color:#3A5FCD"></span>
				</div>
			</div>		
		</form>			
	</div>
</body>
</html>