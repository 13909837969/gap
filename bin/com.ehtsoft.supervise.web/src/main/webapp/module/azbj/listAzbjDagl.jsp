<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>安置帮教档案管理</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/AzbjDaglService.js"></script>
<script type="text/javascript">
$(function() {
	var azbj = new AzbjDaglService();
	var form = new Eht.Form({
		formCol:2,
		selector : "#azbjJbxxForm",
		autolayout : true
	});
	var moed = new Eht.Form({
		selector : "#myModal",
		autolayout : true,
		
	});	
	var formx = new Eht.Form({
		formCol:2,
		selector : "#azbjFxxxForm",
		autolayout : true
	});
	var qf = new Eht.Form({
		selector : "#query_form",
		codeEmptyLabel:"全部"
	});
	//表格
	var table = new Eht.TableView({
		selector : "#azbj_table",
		multable : false
	});
	table.loadData(function(page, res) {
		azbj.findFxry(qf.getData(), page, res);
	});
	//查詢刷新列表
	$("#querybtn").click(function() {
		table.refresh();
	});
	//查看事件
	$('#btn_chakan').click(function() {
		var sd_ry = table.getSelectedData();
		if (sd_ry.length == 1) {
		$('#myModal').modal();
		moed.fill($(":checkbox:checked").data());
		form.disable();
		formx.disable();}
		else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}
	});		
	//新增编辑事件
	$('#btn_bianji').click(function() {
		var sd_ry = table.getSelectedData();
		if (sd_ry.length == 1) {
		$('#myModal').modal({backdrop:'static'});
		moed.fill($(":checkbox:checked").data());
		form.disable();
		formx.enable();} 
		else{
			var ale = new Eht.Alert();
			ale.show("请选中一条数据进行操作!");
		}

	});		
	//保存按鈕事件
	$("#btn_submit").click(function() {
		if(formx.validate()){
			 var data_a = formx.getData(); 
			 azbj.saveFxxx(data_a, new Eht.Responder({
				success : function() {
					$("#myModal").modal("hide");
					new Eht.Tips().show("保存成功");
					table.refresh();
					}
				}))
			}
		})
	});	
</script>
</head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" class="btn btn-default" style="margin-left:10px;" id="btn_chakan">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" class="btn btn-default" style="margin-left:10px;" id="btn_bianji">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>		
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="query_form">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]"  placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="sfzh">身份证号</label>
			<input type="text" class="form-control" name="sfzh[like]"  placeholder="身份证号">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="xb">性别</label>
			<input type="text" class="form-control" name="xb[eq]"  placeholder="性别" code="sys000">
		</div>
		<button type="button" class="btn btn-primary"  id="querybtn" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>
<div id="azbj_table">
	<div field="xx1" label="选项" width="80" checkbox=true></div>
	<div field="xm" label="姓名"></div>
	<div field="xb" label="性别" code="sys000"></div>
	<div field="csrq" label="出生日期"></div>
	<div field="whcd" label="文化水平" code="sys028"></div>
	<div field="xzzmm" label="现政治面貌" code="sys091"></div>
	<div field="hyzk" label="婚姻状况" code="sys030"></div>
	<div field="wcn" label="未成年" code="sys035"></div>
	<div field="jyjxqk" label="就业就学情况" code="sys031"></div>
</div>
<!-- 新增安置帮教档案管理(Modal) -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content" >
			<div class="modal-header" >
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<!-- 切换卡 人员与服刑人员切换 -->	
				<ul class="nav nav-tabs">
					<li class="active"><a href="#azbjJbxxForm" data-toggle="tab"
						id="jbry"> 人员基本信息</a></li>
					<li><a href="#azbjFxxxForm" data-toggle="tab" id="fxry">服刑人员服刑信息</a></li>
				</ul>
			</div>
			<div class="modal-body" style="overflow: auto; height: 470px;">
				<div class="tab-content" style="height: 100%;">
					<div id="azbjJbxxForm" class="tab-pane active" >							
						<input type="text" name="xm" label="姓名" valid="{required:true}" />
						<input type="text" name="xb" label="性别" code="sys000" />
						<input type="text" name="mz" label="民族" code="sys003" />
						<input type="text" name="sfzh" label="身份证号" /> 
						<input	type="text" name="jglx" label="矫管类型" code="sys001" />
						<input type="text" name="csrq" label="出生日期" class="form_date" data-date-formate="yyyy-MM-dd" /> 
						<input type="text" name="sfcn" label="是否成年" code="sys001" />
						<input type="text" name="wcn" label="未成年" 	code="sys035" />
						<input type="text" name="pqzy" label="捕前职业" code="sys098" />
						<input type="text" name="hyzk" label="婚姻状况" code="sys030" />
						<input type="text" name="grlxdh" label="个人联系电话(手机号)"/>
						<input type="text" name="whcd" label="文化程度" code="sys028"/>
						<input type="text" name="jyjxqk" label="就业就学情况" code="sys031" />
						<input type="text" name="xzzmm" label="现政治面貌" code="sys091" />
						<input type="text" name="yzzmm" label="原政治面貌" code="sys091" />
						<input type="text" name="ygzdw" label="原工作单位" />
						<input type="text" name="xgzdw" label="现工作单位" />
						<input type="text" name="dwlxdh" label="单位联系电话" />
						<input type="text" name="qtlxfs" label="其他联系方式" />
					</div>
					<div id="azbjFxxxForm" class="tab-pane">
					<div>
						<input type="hidden" name="id" />
						<input type="hidden" name="azbjryid"/>							
					</div>
						<input type="text" name="tiqian"   label="是否减刑提前释放" valid="{required:true}"  code="sys247" />						
						<input type="text" name="tq_reason" label="减刑提前释放原因"  /> 
						<input type="text" name="critype" label="罪名"   code="sys096"   valid="{required:true}"/>
						<input type="text" name="pritime" label="刑期"   code="sys220" />
						<input type="text" name="drughis" label="吸毒史"   code="sys222" />
						<input type="text" name="precri" label="是否累犯"   code="sys221" />
						<input type="text" name="addition" label="附加刑"   code="sys013" />
						<input type="text" name="peixun" label="是否参加职业技能培训"   code="sys223" />
						<input type="text" name="jineng" label="是否获得职业技能证书"   code="sys224" />
						<input type="text" name="xinli" label="是否心理健康"   code="sys225" />
						<input type="text" name="lianxi" label="家庭联系情况"   code="sys044" />
						<input type="text" name="sanwu" label="是否三无人员"   code="sys226" />
						<input type="text" name="pinggu" label="危险性评估"   code="sys043" />
						<input type="text" name="gaizao" label="改造表现"   code="sys165" />
						
						<input type="text" name="renzui" label="认罪态度"   code="sys042" />
						
						<!-- <input type="text" name="remark" label="服刑期间特殊情况备注及帮教建议"    /> -->
						<input type="text" name="jiuyi" label="是否办理保外就医"   code="sys247" />
						<input type="text" name="siwang" label="是否死亡"   code="sys247" />
						
						<input type="text" name="sw_reason" label="死亡原因"   code="sys248" />
						<textarea  rows="8" name="remark"  id="remark" type="text" maxlength="250" label="服刑期间特殊情况备注及帮教建议" ></textarea>
												<textarea  rows="8" name="sw_shuoming"  id="sw_shuoming" type="text" maxlength="250" label="死亡说明" ></textarea>
						<!-- <input type="text" name="" label=""    /> -->
						
						<!-- <input type="text" name="tongzhishu" label="刑满释放（解除社区矫正）人员通知书"    />	 -->	
					  
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
				<button class="btn btn-default" type="button" data-dismiss="modal">取消</button>
				
			</div>
		</div>
	</div>
</div>
</body>
</html>