<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>案件查询</title>
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
		selector : "#rmtj_listQbajcx",
		autolayout:true
	});
	var tableView = new Eht.TableView({
		selector : "#rmtj_listQbajcx #tableview",
		//一次选择多个数据
		multable : true
	});
	
	
	

	
})
</script>
</head>
<body>
	<div id="rmtj_listQbajcx" class="container-fluid">
		<div class="panel panel-default">
			<div id="query_id" class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			<!-- <input style="border-radius: 3px; border: 1px solid #b3b0b0;" name="orgid" id="dosearch" type="text" placeholder="请输入机构名称..." />
					<button id="querybtn" style="border-radius: 3px; border: 1px solid #b3b0b0; margin-right: 10px;">查询</button> -->
				<label>案件种类：</label>
				<select id="ajzl" name="ajzl" label="案件种类" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>口头调解案件</option>
					<option>书面调解案件</option>
				</select>
				<label>纠纷类型：</label>
				<select id="jflx" name="jflx" label="纠纷类型" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>其他劳动</option>
					<option>拖欠工资</option>
					<option>电子商务纠纷</option>
					<option>...</option>
				</select>
				<label>
				受理单位：
				</label>
				<select id="sldw" name="sldw" label="纠纷类型" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>双河镇光明镇</option>
					<option>双河镇昌平区</option>
					<option>你是想个啥</option>
					<option>...</option>
				</select>
				<label>
				案件状态：
				</label>
				<select id="ajzt" name="ajzt" label="案件状态" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>调解中</option>
					<option>调解不成功</option>
					<option>达成协议</option>
					<option>...</option>
				</select>
				<label>
				满意度：
				</label>
				<select id="myd" name="myd" label="满意度" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>全部</option>
					<option>满意</option>
					<option>不满意</option>
				</select>
				<label>
				是否诉讼：
				</label>
				<select id="sfss" name="sfss" label="是否诉讼" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>全部</option>
					<option>无诉讼</option>
					<option>撤销诉讼然后变更</option>
					<option>...</option>
				</select>
				<label>
			
				<div>
			<label>当事人：</label>
			<input type="text" id="dsr" name="dsr" style="height: 25px;width:80px;border-radius: 3px; border: 1px solid #b3b0b0;" />	
			<label>受理人：</label>
				<select id="slr" name="slr" label="纠纷类型" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>张三哦</option>
					<option>大梁哦</option>
				</select>
				<label>
				受理日期：
				</label>
				<input id="slrq1" name="slrq1" label="受理日期" getdis="true" style="border-radius: 3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
				<label>至</label>
				<input id="slrq2" name="slrq2" label="受理日期" getdis="true" style="border-radius: 3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
				<label>是否司法确认：</label>
				<select id="sfsfqr" name="sfsfqr" label="是否司法确认" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>是</option>
					<option>否</option>
				</select>
				
				<label>案件难易程度：</label>
				<select id="ajnycd" name="ajnycd" label="案件难易程度" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>是</option>
					<option>否</option>
				</select>
				<label>是否发放补助：</label>
				<select id="sfffbz" name="sfffbz" label="是否发放补助" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>是</option>
					<option>否</option>
				</select>
				
						<button id="querybtn" class="btn btn-primary" style="border-radius: 3px; border: 1px solid #b3b0b0; margin-right: 10px;">查询</button>
			</div>
				
			</div>
			
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="序号"></div>
					<div field="sldw" label="受理单位"></div>
					<div field="slsj" label="受理时间"></div>
					<div field="tjy" label="调解员"></div>
					<div field="jflb" label="纠纷类别"></div>					
					<div field="tjjg" label="调解结果"></div>
					<div field="ajzt" label="案件状态"></div>
					<div field="jarq" label="结案日期"></div>
					<div field="cz" label="操作"></div>
				</div>
			</div>
		
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
	</div>
	</div>
</body>
</html>