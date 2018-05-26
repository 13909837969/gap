<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>口头调解案件</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JypxService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<style type="text/css">
.modal-content{
width:800px

}

</style>
<script type="text/javascript">
$(function() {
	var form = new Eht.Form({
		selector : "#rmtj_listKttjaj #modal-body",
		autolayout:true,
		formCol:2
	});
	var tableView = new Eht.TableView({
		selector : "#rmtj_listKttjaj #tableview",
		//一次选择多个数据
		multable : true
	});
	$("#rmtj_listKttjaj #rmtj_id_djan").click(function(data){
		$("#rmtj_listKttjaj #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
	});
	
})
</script>
</head>
<body>
	<div id="rmtj_listKttjaj">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
				<fieldset id="querypanel">
				<label>
				<butten id="rmtj_id_djan" class="btn btn-primary ">登记案件</butten>
				</label>     
				<label>纠纷类型：</label>
				<select type="text"  id="jflx"  style="width: 120px;background-color: #fff;" class="input-group-addon">
					<option >全部</option>
					<option >合同纠纷</option>
					<option >土地纠纷</option>
				</select> 
				<label>受理单位：</label>
				<select type="text"  id="sldw"  style="width: 120px;background-color: #fff;" class="input-group-addon">
					<option>双河镇光明镇</option>
					<option>双河镇昌平区</option>
					<option>你是想个啥</option>
					<option>...</option>
				</select>
				<label>受理人：</label>
				<select type="text"  id="slr"  style="width: 120px;background-color: #fff;" class="input-group-addon">
					<option>张三</option>
					<option>李四</option>
					<option>王五</option>
					<option>...</option>        
				</select>
				<label>受理日期：</label>
				<input id="rq" name="slrq1" label="受理日期" getdis="true" style="border-radius:3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
				<label>至</label>
				<input id="rq1" name="slrq2" label="受理日期" getdis="true" style="border-radius:3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
						<button class="btn btn btn-primary btn-sm" type="button" id="querybtn">查询</button>
				</fieldset>
			</div>
			
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="序号"></div>
					<div field="sldw" label="受理单位"></div>
					<div field="tjy" label="调解员"></div>
					<div field="jflb" label="纠纷类别"></div>
					<div field="sqr" label="申请人"></div>
					<div field="bsqr" label="被申请人"></div>
					<div field="tjsj" label="调解时间"></div>
					<div field="tjdd" label="调解地点"></div>
					<div field="jfqk" label="纠纷情况"></div>
					<div field="tjjg" label="调解结果"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog" style="width:850px">
				<div class="modal-content" style="width:850px">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">案件登记</h4>
					</div>
					<div class="modal-body" id="modal-body" >
						<select id="sldw" name="sldw" label="受理单位" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<select id="slr" name="slr" label="受理人" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<select id="zrr" name="zrr" label="责任人" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<input type="text"	id="slrq"	 name="slrq" label="受理日期" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
						<input type="text" id="sqrxm"	 name="sqrxm" label="申请人姓名"  maxlength="30" valid="{required:true}" />
						<input type="text" id="sqrdz" 	name="sqrdz" label="申请人地址"  valid="{required:true}" code="SYS000" maxlength="2"/>
						<input type="text" id="bsqrxm"	 name="bsqrxm" label="被申请人姓名"  maxlength="30" valid="{required:true}" />
						<input type="text" id="bsqrdz"	 name="bsqrdz" label="被申请人地址"  maxlength="30" valid="{required:true}" />
						<input type="text" id="tjy"	 name="tjy" label="调解员"  maxlength="30" valid="{required:true}" />
						<input type="text"	id="tjrq"	 name="tjrq" label="调解日期" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
						<input type="text" id="tjdd"	 name="tjdd" label="调解地点"  maxlength="30" valid="{required:true}" />
						<select id="tjjg" name="tjjg" label="调解结果" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<select id="xylxfs" name="xylxfs" label="协议履行方式" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<input type="text" id="saje"	 name="saje" label="涉案金额"  maxlength="30" />
						<select id="xylxqk" name="xylxqk" label="协议履行情况"  valid="{onlyChinese:true,required:true}"></select>
						<textarea type="text" name="xynr" label="协议内容" id="xynr"   maxlength="1000" ></textarea>
						<input type="text"	id="xyrq"	 name="xyrq" label="协议日期"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
						<select id="sfmy" name="sfmy" label="是否满意" ></select>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="close">关闭</button>
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