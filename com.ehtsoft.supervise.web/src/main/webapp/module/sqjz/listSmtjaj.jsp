<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>书面调解案件</title>
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
		selector : "#rmtj_listSmtjaj #modal-body",
		autolayout:true,
		formCol:2
	});
	var tableView = new Eht.TableView({
		selector : "#rmtj_listSmtjaj #tableview",
		//一次选择多个数据
		multable : true
	});
	$("#rmtj_listSmtjaj #rmtj_id_djan").click(function(data){
		$("#rmtj_listSmtjaj #myModal").modal({backdrop: 'static', keyboard: false});//弹出模态框
		
	});
	
})
</script>
</head>
<body>
	<div id="rmtj_listSmtjaj">
		<div class="panel panel-default">
			<div class="panel-heading ltrhao-toolbar" style="padding-left: 20px;">
			
				<label>
				<butten id="rmtj_id_djan" class="btn btn-primary "  value="登记案件" >登记案件</butten>
				</label>
				<label>
				纠纷类型：
				</label>
				<select id="jflx" name="jflx" label="" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>其他劳动</option>
					<option>拖欠工资</option>
					<option>电子商务纠纷</option>
					<option>...</option>
				</select>
				<label>
				受理单位：
				</label>
				<select id="sldw" name="sldw" label="" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>双河镇光明镇</option>
					<option>双河镇昌平区</option>
					<option>你是想个啥</option>
					<option>...</option>
				</select>
				<label>
				受理人：
				</label>
				<select id="slr" name="slr" label="" style="border-radius: 3px; border: 1px solid #b3b0b0;">
					<option>张三</option>
					<option>李四</option>
					<option>王五</option>
					<option>...</option>
				</select>
				<label>
				受理日期：
				</label>
				<input id="slrq1" name="slrq1" label="" getdis="true" style="border-radius: 3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
				<label>
				至
				</label>
				<input id="slrq2" name="slrq2" label="" getdis="true" style="border-radius: 3px; border: 1px solid #b3b0b0;"
				placeholder="受理日期" class="form_date" data-date-formate="yyyy-MM-dd" value="" readonly="" tabindex="3" 
				type="text">
				
					<input class="btn btn-primary" type="button" id="querybtn" value="查询">
				
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
					<div field="cts" label="操作"></div>
				</div>
			</div>
		</div>
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog" style="width:1000px">
				<div class="modal-content" style="width:1000px">
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
							<select id="sqrlb" name="sqrlb" label="申请人类别" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>自然人</option>
										<option>法人/组织</option>
							</select>
							<select id="sqezjlx" name="sqrzjlx" label="申请人证件类型" valid="{required:true}" valid="{onlyChinese:true,required:true}">
									<option>1123233</option>
									<option>2</option>
									<option>3</option>
									<option>4</option>
							</select>
							<input type="text"	id="sqrzjhm"	 name="sqrzjhm" label="申请人证件号码" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="sqrlxdh"	 name="sqrlxdh" label="申请人联系电话" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="sqrdwmc"	 name="sqrdwmc" label="申请人单位名称" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="sqrdz"	 name="sqrdz" label="申请人地址" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="sqrbfdsrsl"	 name="sqrbfdsrsl" label="申请人本方当事人数量" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							
							
							
							<input type="text" id="bsqrxm"	 name="bsqrxm" label="被申请人姓名"  maxlength="30" valid="{required:true}" />
							<select id="bsqrlb" name="bsqrlb" label="被申请人类别" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>自然人</option>
										<option>法人/组织</option>
							</select>
							<select id="bsqrzjlx" name="bsqrzjlx" label="被申请人证件类型" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>1123233</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
							</select>
							<input type="text"	id="bsqrzjhm"	 name="bsqrzjhm" label="被申请人证件号码" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="bsqrlxdh"	 name="bsqrlxdh" label="被申请人联系电话" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="bsqrdwmc"	 name="bsqrdwmc" label="被申请人单位名称" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="bsqrdz"	 name="bsqrdz" label="被申请人地址" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text"	id="bsqrbfdsrsl"	 name="bsqrbfdsrsl" label="被申请人本方当事人数量" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							
							
							
							<input type="text"	id="fsrq"	 name="fsrq" label="发生日期" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
							<input type="text" id="fsdd" 	name="fsdd" label="发生地点"  valid="{required:true}" code="SYS000" maxlength="2"/>
							<select id="jflx" name="jflx" label="纠纷类型" valid="{required:true}" valid="{onlyChinese:true,required:true}">
									<option>123</option>
									<option>321</option>
									<option>213</option>
							</select>
							<select id="ajyc" name="ajyc" label="案件预测" valid="{required:true}" valid="{onlyChinese:true,required:true}">
									<option>正常</option>
									<option>一般</option>
									<option>良好</option>
							</select>
							<textarea type="text" id="jfjj" name="jfjj" label="纠纷简介" id="xynr"   maxlength="1000" ></textarea>
								<textarea type="text" id="sqsx" name="sqsx" label="申请事项" id="xynr"   maxlength="1000" ></textarea>
								
							<select id="tjy" name="tjy" label="调解员" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>张三三</option>
										<option>李四</option>
										<option>大梁</option>
								</select>
							<select id="ajly" name="ajly" label="案件来源" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>电话</option>
										<option>目击</option>
										<option>举报</option>
								</select>
							<input type="text"	id="tjrq"	 name="tjrq" label="调解日期" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
									
								<input type="text" id="tjdd"	 name="tjdd" label="调解地点"  maxlength="30" valid="{required:true}" />
							<select id="tjjg" name="tjjg" label="调解结果" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>协议未达成但有希望</option>
										<option>321</option>
										<option>213</option>
							</select>
							<select id="lxfs" name="lxfs" label="履行方式" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>按协议</option>
										<option>321</option>
										<option>213</option>
							</select>				
							<input type="text" id="saje"	 name="saje" label="涉案金额"  maxlength="30" valid="{required:true}" />
							<select id="xylxqk" name="xylxqk" label="协议履行情况" valid="{required:true}" valid="{onlyChinese:true,required:true}">
										<option>完全履行</option>
										<option>321</option>
										<option>213</option>
							</select>
							<textarea type="text" name="xynr" id="xynr" label="协议内容" id="xynr"   maxlength="1000" ></textarea>
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