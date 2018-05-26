<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>基层法律服务工作者</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/FlfwGzzService.js"></script>
<script type="text/javascript">
var  service = new FlfwGzzService();
	$(function() {
		//区域树
		var tree = new Eht.BootTree({
			selector : "#jcflfw_form #tree",
			labelField : "region_name"
		});
		//连接servise
		var jcflfw = new FlfwGzzService();

		//从servise里面获取数据填充到列表
		var tableview = new Eht.TableView({
			selector : "#jcflfw_form #list"
		});

		/* 查询信息  from.fill();*/ 
		$("#jcflfw_form #querybtn").click(function(){
			query["jgmc[like]"] = $("#dosearch").val();
			tableview.refresh();
		});
		//模态框里面的点击事件，自适应布局
		var form = new Eht.Form({
			selector:'#jcflfw_form #modal-body',
			autolayout:true,
			formCol:2,
			});
		//模态框头部关闭按钮事件 清除未选择的数据
		$('#jcflfw_form #xxx').click(function(){
			json={};
			tableview.refresh();
		});
		//模态框底部关闭按钮事件 清除未选择的数据
		$('#jcflfw_form #close').click(function(){
			json={};
			tableview.refresh();
		});
		//模态框保存并且隐藏
		$('#Flfw-btn-primary').click(function(){
			if(form.validate()){
				jcflfw.save(form.getData(),new Eht.Responder({
					success:function(data){
						$('#myModal').modal('hide');
						tableview.refresh();
					}
				}));
			}
		});
		tableview.refresh();
		//连接Service获取数据
		var query = {};
		$("#jcflfw_form #addbtn").disable();
		var json = null;
		//获取点击的li
		tree.clickItem(function(ds) {
			$("#jcflfw_form #addbtn").disable();
			json = null;
			if (ds.lvl == 3) { //旗县
				json = ds;
				if (ds.nodes != null && ds.nodes.length > 0) {
					var orgids = [];
					for (var i = 0; i < ds.nodes.length; i++) {
						orgids.push(ds.nodes[i].orgid);
					}
					query.orgid = orgids;
				}
				$("#jcflfw_form #addbtn").enable();
			}
			if (ds.lvl == null) { //法律服务所
				json = ds;
				query.orgid = ds.orgid;
				$("#jcflfw_form #addbtn").enable();
			}
			tableview.refresh();
		});
		tree.loadData(function(res) {
			jcflfw.findTree(res);
		});

		tableview.loadData(function(page, res) {
			jcflfw.findAll(query, page, res);
		});
//区域树
		$("#jcflfw_form #addbtn")
				.click(
						function() {
							form.clear();
							if (json != null) {
								$("#jcflfw_form #myModal").modal();
								jcflfw.findFlfws(json.regionid,
									new Eht.Responder({
											success : function(data) {
												$("#jcflfw_form #orgid").empty();
												$("#jcflfw_form #orgid").append(
													"<option></option>");
																for (var i = 0; i < data.length; i++) {
																	var opt = $("<option value='"+data[i].orgid+"'>"
																			+ data[i].orgname
																			+ "</option>");
																	if (json.orgid == data[i].orgid) {
																		opt
																				.attr(
																						"selected",
																						true);
																	}
																	$(
																			"#jcflfw_form #orgid")
																			.append(
																					opt);
																}
															}
														}));
							}
						});
						
						
		//提示框div初始状态为隐藏
	 	$('#jcflfw_form #hideDiv').hide();
		$('#jcflfw_form #hideScDiv').hide();
		//取消按钮
		$('#jcflfw_form #quxiaobtn').click(function(){
			$('#jcflfw_form #hideDiv').hide();
			tableview.refresh();
		})
		$('#jcflfw_form #quxiaobtn1').click(function(){
			$("#jcflfw_form #hideScDiv").hide();
			tableview.refresh();
		})
		var a ={}
		tableview.clickRow(function(data) {
			a = data;
		}); 
		
		/*修改一条信息  */
	 $("#jcflfw_form #updatebtn").click(function() {
			if(a.id==null){
				$('#jcflfw_form #hideDiv').show();
			}else{
				$("#myModal").show(function(){
					$('#jcflfw_form #hideDiv').hide();
					/* var form = new Eht.Form({selector:"#jcflfw_form #modal-body"}); */
					form.fill(a);
					$('#jcflfw_form #btn-primary').unbind('click').bind('click',function(){
						service.saveFocusService(form.getData(),new Eht.Responder({
							success:function(data){
								
								tableView.refresh();
								$('#jcflfw_form #myModal').modal('hide');
							}
						}))
					})
				})
				$("#myModal").modal({
					backdrop : 'static',
					keyboard : false
				});
			};
		}); 
	 /* 删除信息 */
		$("#jcflfw_form #deletebtn").click(function() {
			var array = tableview.getSelectedData();
			if(array.length==0){
				$('#jcflfw_form #hideDiv').show();
			}else{
					$('#jcflfw_form #hideScDiv').show();
					$('#jcflfw_form #hideDiv').hide();
					//确定按钮
					$('#jcflfw_form #shanchubtn').unbind('click').bind('click',function(){
						$('#jcflfw_form #hideScDiv').hide();
						var id = a.id;
						service.deleteFocusService(id);
						tableview.refresh();
					})
			}
		});
		$("#xl").comboSelect();
		$("#mz").comboSelect();
		$("#zzmm").comboSelect();
		//获取当前时间成功，赋值到模态框失败
	/* 	Date.prototype.Format = function (fmt) {    
		    var o = {    
		        "M+": this.getMonth() + 1,
		        "d+": this.getDate(), 
		    };    
		    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
		    for (var k in o)    
		    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
		    return fmt;    
		}  
		var nowTime=new Date().Format("yyyy-MM-dd"); */
		
		
	});

	
</script>

</head>
<body>
	<!-- 1-表单：查询，新增 -->
	<div id="jcflfw_form" class="container-fluid">
		<div class="row">
			<div id="query_id" style="margin-top: 21px; margin-bottom: 12px; margin-left: 31px;">
				服务所名称： <input style="border-radius: 3px; border: 1px solid #b3b0b0;" name="orgid" id="dosearch" type="text" placeholder="请输入机构名称..." />
					<button id="querybtn" style="border-radius: 3px; border: 1px solid #b3b0b0; margin-right: 10px;">查询</button>
					<button id="addbtn" class="btn btn-default btn-sm">新增人员</button>
					<button id="updatebtn" class="btn btn-default btn-sm">修改信息</button>
					<button id="deletebtn" class="btn btn-default btn-sm">删除信息</button>
			</div>
		</div>
		<!-- 警告信息 -->			
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
<!--2：表单：点击左侧树状图事件弹出信息  -->
		<div class="row">
			<div class="col-md-3">
				<div id="tree"></div>
			</div>
<!-- 主界面列表 -->
			<div class="col-md-9">
				<div id="list">
					<div field="jgmc" name ='jgmc' label="机构名称"></div>
					<div field="xm" name='xm' label="姓名" ></div>
					<div field="xb" name='xb' label="性别" code="SYS000" ></div>
					<div field="xl" label="学历"  code="sys093"></div>
					<div field="bzsj" label="办证时间" ></div>
					<div field="zyzh" label="执业证号" ></div>
					<div field="zhnjsj" label="最后年检时间 "></div>
				</div>
			</div>
		</div>
<!-- 新增基层法律事务所模态框 -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
<!-- 模态框里面的头 -->			
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="false" id="xxx">×</button>
						<h4 class="modal-title" id="myModalLabel">新增基层律服务工作人员</h4>
					</div>
<!-- 模态框里面的内容 -->
					<div class="modal-body" id="modal-body" >
						<input type="text" id="xm"	 name="xm" label="姓名"  maxlength="30" valid="{required:true}" />
						<input type="text" id="xb" 	name="xb" label="性别"  valid="{required:true}" code="SYS000" maxlength="2"/>
						<input type="text" id="xl" 	name="xl" label="学历"  maxlength="20" code="sys093"  valid="{required:true}" />
						<input type="text" id="mz" 	name="mz" label="民族"  valid="{required:true}" code="SYS003" maxlength="20"/>
						<input type="text" id="zyzh" 	name="zyzh" label="执业证号" valid="{number:true,required:true}" maxlength="20" />
						<input type="text" id="zzmm"	 name="zzmm" label="政治面貌" valid="{required:true,required:true}"  code="sys091" "/>
						<select id="orgid" name="orgid" label="机构名称" valid="{required:true}" valid="{onlyChinese:true,required:true}"></select>
						<input type="text" id="qsnd"	name="qsnd" label="起始年度" valid="{date:true,required:true }" class="form_date" data-date-format="yyyy-MM-dd" maxlength="20" dateISO="true"  />
						<input type="text"	id="bzsj"	 name="bzsj" label="颁证时间" valid="{date:true,required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"  />
						<input type="text" id="zhnjsj"	 name="zhnjsj" label="最后年检时间" valid="{date:true,required:true}"   class="form_date" data-date-format="yyyy-MM-dd" maxlength="20" />
						<input type="text" id="ywzc"  name="ywzc" label="业务专长" maxlength="30"  valid="{required:true}"/>
						<textarea type="text" name="grjj" label="个人简介" id="grjj"  valid="{required:true}" maxlength="1000" ></textarea>
					</div>
<!-- 模态框底部的关闭，保存按钮 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
						<button type="button" class="btn btn-primary" id="Flfw-btn-primary">提交</button>
					</div>
			</div>
		</div>
	</div>
	
	</div>
</body>
</html>