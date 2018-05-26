<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<!--王世凯  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/AzbjRyqjxxService.js"></script>
<script type="text/javascript" src="${localCtx }/json/RegionService.js"></script>
<title>人员迁居信息管理</title>
<script type="text/javascript">
	$(function() {
		var region = new RegionService();//省市区后台
		var query = {};
		var ryqj = new AzbjRyqjxxService();
		var form = new Eht.Form({selector : "#ryqjForm",autolayout : true});
		var tableview = new Eht.TableView({selector : "#tableview"});
		var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
		//展示页面信息
		tableview.loadData(function(page, res) {
			ryqj.findAll(qf.getData(), page, res);
		});
		
		//模糊查询
		$("#btn_cha").click(function() {
			tableview.refresh();
		});
		
		
		//新增按钮触发事件
		$("#btn_add").click(function() {
				form.enable();
				form.clear();
				$("#myModal").modal({
				backdrop : 'static'
			});
		});

		//点击查看时显示代码只读
		$("#btn_search").click(function(){
			if ($(":checkbox:checked").length == 1) {
				form.clear();
				$("#myModal").modal();
				form.disable();
				$("#btn_close").hide();
				$("#btn_submit").hide();
				form.fill($(":checkbox:checked").data());
				}else{
					var ale = new Eht.Alert();
					ale.show("请选中一条数据进行操作!");
				}
			});
		
		//修改按钮事件
		$("#btn_edit").click(function() {
			if ($(":checkbox:checked").length == 1) {
				form.enable();
				form.clear();
				$("#myModal").modal({backdrop : 'static'});
				form.fill($(":checkbox:checked").data());
				tableview.refresh();
			}else{
				var ale = new Eht.Alert();
				ale.show("请选中一条数据进行操作!");
			}
		});
		
		//删除按钮事件
		$("#btn_delete").click(
			function() {
				var sd_ry = tableview.getSelectedData();
				if (sd_ry.length == 1) {
				var c = new Eht.Confirm();
				c.show("请确认是否删除！");
				c.onOk(function() {
				ryqj.removeOne($(":checkbox:checked").data().id,
						new Eht.Responder({
						success : function() {
						c.close();
						new Eht.Tips().show("删除成功");
						tableview.refresh();
						}
						}));
					});
				}else{
					var ale = new Eht.Alert();
					ale.show("请选中一条数据进行操作!");
					tableview.refresh();
				}
			});
			
		//模态框保存并且隐藏
		$('#btn_submit').click(function() {
			if (form.validate()) {
				ryqj.saveOne(form.getData(), new Eht.Responder({
					success : function(data) {
						$('#myModal').modal('hide');
						tableview.refresh();
					}
				}));
			}
		});
		//模态框查询人员迁居信息事件
		ryqj.findJz(new Eht.Responder({
				success:function(data){
					$("#jzryxx_xmajglx").empty();
					$("#jzryxx_xmajglx").append('<option selected="selected"></option>');
					console.log(data);
					for(var i=0;i<data.length;i++){
						if(i==4){
							$("#jzryxx_xmajglx").append("<option value="+data[i].id+" selected>"+data[i].xm +    +data[i].grlxdh+"</option>");
						}else{
							$("#jzryxx_xmajglx").append("<option value="+data[i].id+">"+data[i].xm +    +data[i].grlxdh+"</option>");
						}
					}
					$("#jzryxx_xmajglx").comboSelect();
				}
			}))
		
		/* 省区联动  */
		region.find(1,null,new Eht.Responder({	//省份初始化
		success:function(data){
			for (var i = 0; i < data.length; i++) {
			$("#shengji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
			}
			$("#shengji").change();
		}
		}));  
		
		$("#shengji").change(function(){	//市初始化
		region.find(2,$("#shengji").val(),new Eht.Responder({
			success:function(data){
				$("#shiji").empty();
				for (var i = 0; i < data.length; i++) {
				$("#shiji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
				$("#shiji").change();
			}
		}));
		})
		
		$("#shiji").change(function(){	//县初始化
		region.find(3,$("#shiji").val(),new Eht.Responder({
			success:function(data){
			$("#xianji").empty();
				for (var i = 0; i < data.length; i++) {
				$("#xianji").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
			}
		}));
		})
	});
</script>
</head>
<body>
	<div id="ryqj_div">
			<div class="panel-heading">
				<fieldset>
					<div class="toolbar">
					<button type="button" id="btn_add" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
					<button type="button" id="btn_search" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
					<button type="button" id="btn_edit" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
					<button type="button" id="btn_delete" class="btn btn-default" style="margin-left:10px;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
					</div>
					<br/>
					<div id="query_form">
					<div class="form-group">
					姓名：<input type="text" id="search_xm" name="xm[like]" class="btn btn-default" placeholder="姓名" />
					时间：<input type="text" id="search_sj" name="sj[like]" class="form_date btn btn-default" data-date-formate="yyyy-MM-dd" placeholder="时间" > 
					原因：<input type="text" id="search-yy" name="yy[like]" class="btn btn-default" placeholder="原因"/>
					状态：<input type="text" id="search-zt" name="zt[like]" class="btn btn-default" placeholder="状态"/>
					<button type="button" class="btn btn-primary" id="btn_cha" style="margin-left:10px;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
					</div>
				</fieldset>
			</div>
					<div id="tableview" class="table-responsive">
					<div field="xzk" label="选择" checkbox=true></div>
					<div field="xm" label="姓名"></div>
					<div field="sj" label="时间"></div>
					<div field="yy" label="原因"></div>
					<div field="zt" label="状态"></div>
					<div field="shyj" label="审核意见"></div>
					</div>
		<!-- 新增迁居人员信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog" style="width:800px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">人员迁居信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto; height: 450px;">
							<div id="ryqjForm">
								<input type="hidden" name="id"/>
								<select id="jzryxx_xmajglx" name="azbjryid" label="迁居人员" style="max-width:none" valid="{required:true}"></select>
								<select name="qrds" type="text" id="shengji" getdis="true" label="选择省份" valid="{required:true}">
									<option value="" selected="selected">---选择省份---</option>
								</select>
								<select name="qrdsq" type="text" id="shiji" getdis="true" label="选择盟市" valid="{required:true}">
									<option value="" selected="selected">---选择盟市---</option>
								</select>
								<select name="qrdx" type="text" id="xianji" getdis="true" label="选择旗县" valid="{required:true}">
									<option value="" selected="selected">---选择旗县---</option>
								</select>
								<input type="text" id="qrdxz" name="qrdxz"  label="乡镇" placeholder="请填写乡镇" valid="{required:true}"/>
								<input type="text" id="qrdxxmph" name="qrdxxmph"  label="详细地址" placeholder="请填写详细地址" valid="{required:true}"/>
								<input type="date" id="sj" name="sj" type="text" label="时间" class="class_form" data-date-formate="yyyy-MM-dd" placeholder="时间" valid="{required:true}"/> 
								<input id="yy" name="yy" type="text" label="原因" placeholder="原因"/> 
								<input id="zt" name="zt" type="text" label="状态" placeholder="状态" code="SYS186"/>
								<input id="shyj" name="shyj" type="text" label="审核意见" placeholder ="审核意见"/>
							</div>
					</div>
					<div class="modal-footer">
						<button id="btn_submit" class="btn btn-primary" type="button">保存</button>
						<button id="btn_close" class="btn btn-default" type="button" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>