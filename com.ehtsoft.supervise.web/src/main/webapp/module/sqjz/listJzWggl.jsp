<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正人员违规信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzWgglService.js"></script>
<style>
#AzbjSqjzryjcxx-form #right-panel {
	background: #fff;
	border: 1px solid #aaa;
	position: absolute;
	top: 0px;
	right: 0px;
	bottom: 0px;
	filter: alpha(Opacity = 97);
	-moz-opacity: 0.97;
	opacity: 0.97;
	display: none;
	box-shadow: 0px 0px 10px #888888;
	width:0px;
}


#AzbjSqjzryjcxx-form #siderightbar {
	cursor: pointer;
}

#AzbjSqjzryjcxx-form #siderightbar:hover {
	color: #00f;
}


</style>

<script type="text/javascript">
		$(function(){
			var service = new JzWgglService();
			var json={};
			
			var qform = new Eht.Form({
				selector:"#AzbjSqjzryjcxx-form #querypanel"
				});
			
			var wg_view_form =  new Eht.Form({
				selector:"#wg_view_form",
				autolayout:true,
				colLabel:"col-sm-3 col-xs-3",
				colCombo:"col-sm-9 col-xs-9"
				});
			
			//右侧弹出基本信息布局
			var form_jcxx = new Eht.Form({
				selector:"#listSqjz_jcxxb_from",
				autolayout:true,
				colLabel:"col-sm-3 col-xs-3",
				colCombo:"col-sm-9 col-xs-9"
				});
			
			var tableview = new Eht.TableView({
				selector:"#listJzsf_table"
			});

			//右侧弹框底部
			var tableview_jcxxzs = new Eht.TableView({
				selector:"#listJcxxzs-table",
				paginate:null
			});
			
			tableview_jcxxzs.loadData(function(page,res){
				service.findWgqks(json.id,res);
			});
			//单击一行获取数据
			tableview.clickRow(function(data){
				json = data;
				$('#right-panel').show().animate({
					width : 555
				});
				$("#listTjdaxx_send").attr("disabled", false);
				form_jcxx.fill(data);
				form_jcxx.selector.hide();
				wg_view_form.fill(data);
				tableview_jcxxzs.refresh();
			});
			var query={};
			tableview.loadData(function(page,res){
				service.findAllRy2(query,page,res);
			});
			//关闭右侧面板
			 $("#right-panel #siderightbar").click(function() {
				$('#right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
			}); 
			/* 查询信息 */
			$("#AzbjSqjzryjcxx-form #listJzsf_find").click(function(){
				query["xm"] = $("#cxxm").val();
				query["grlxdh"] = $("#cxsjh").val();
				tableview.refresh();
			});
			//保存
			$('#AzbjSqjzryjcxx-form #submit').click(function(){
				if($().val("wglb")== null){
					setTimeout(function () {
						$("#wglb").focus();	
					},200);
				}else  {
				if(form_jcxx.validate()){
					service.saveJzry(form_jcxx.getData(),new Eht.Responder({
						success:function(data){
							new Eht.Tips().show("保存成功");
							tableview.refresh();
							tableview_jcxxzs.refresh();
						}
					}));
					}
				}
				
			});
			//默认隐藏
			function changeInput(ifBoolean){
				if(ifBoolean){
					//form_jcxx.disable();
				}else{
					form_jcxx.enable();
				}
			}
			//单击添加违规数据弹出模态框	
			$('#listTjdaxx_send').click(function(){	
				form_jcxx.selector.show();
				$('#right-panel').show().animate({
					width : 555
				});
				var o = {};
				for(var p in json){
					o[p] = json[p];
				}
				o.aid = json.id;
				delete o.id;
				form_jcxx.fill(o);
				wg_view_form.fill(o);
				$("form_jcxx #xm").html(o.xm);
				$('#wgsj').val(nowTime);
			});
			//获取当前时间成功
		 	Date.prototype.Format = function (fmt) {    
			    var o = {    
			        "M+": this.getMonth() + 1,
			        "d+": this.getDate(), 
			    };    
			    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
			    for (var k in o)    
			    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
			    return fmt;    
			}  
			var nowTime=new Date().Format("yyyy-MM-dd"); 
		});
		//Code编码设置为下拉选
		$("#wglx").comboSelect();
	</script>
</head>
<body>
	<!-- 整体表 -->
<div id="AzbjSqjzryjcxx-form">
<!-- 1-表头-查询添加 -->
	<div class="container-fluid">
		<fieldset id="querypanel" >
		姓名:<input class="btn btn-default" type="text" name="xm" id="cxxm" placeholder="请正确输入姓名" /> 
		手机号:<input class="btn btn-default" type="text" name="grlxdh" id="cxsjh" placeholder="请正确输入手机号" />
			<input class="btn btn-default "  type="button" id="listJzsf_find" value="查询">
			<input class="btn btn-default"   type="button" id="listTjdaxx_send" value="添加违规" disabled>
		</fieldset>
<!-- 2-列表 -->
		<div id="listJzsf_table" style="margin-top: 10px">
			<div field='op' label="选择" checkbox="true"></div>
			<div field="xm" label="姓名"></div>
			<div field="xb" label="性别" code="SYS000"></div>
			<div field="grlxdh" label="联系电话"></div>
			<div field="sfzh" label="身份证号"></div>
			<div field="gdjzdmx" label="居住地址"></div>
			<div field="wgcs" label="违规次数"></div>
			<div field="jglx" label="管教类型" code="SYS114"></div>
		</div>
	</div>
	
<!-- 右侧弹出表单 -->
	
		<div class="right-panel modal-body" id="right-panel" style="overflow: hidden;">
			<div class="panel panel-default">
<!-- 模态框的头部信息以及关闭 -->
				<div class="panel-heading">
					<span id="siderightbar" class="glyphicon glyphicon-remove "></span>&nbsp;&nbsp;服刑人员违规记录基本信息
				</div>
<!-- 未隐藏的信息，根据点击任务对应基本信息 -->				
				<div id="wg_view_form" style="margin-top:8px;">
					<input type="text" label="姓名" name="xm" disabled id="xm"/>
					<input type="text" label="联系电话" name="grlxdh" id="grlxdh" disabled/>
				</div>
<!-- 隐藏内容，点击添加才弹出 -->				
				<div class="panel-body text-left" id = "listSqjz_jcxxb_from"  style="cursor:hand">
					<input type="text" label="违规类别" name="wglx"  code="sys082" valid="{required:true}"/>
					 <input type="text" label="违规时间" name="wgsj" id="wgsj" class="form_date" data-date-formate="yyyy-MM-dd" valid="{required:true}" readonly="readonly"/>
					 <input type="text" label="违规详情" name="wgxq" valid="{required:true}" maxlength="500" />
					 <input type="text" label="扣分值 "  name="kfz"  valid="{required:true,int:true}" maxlength="3">
					<center>
						<button type="button" class="btn btn-baise" id="submit">保存</button>
					</center>
				 </div>
				
				<br>
<!-- 根据人ID信息调出历史信息，点击添加插入一条新数据 -->	
				<div id="listJcxxzs-table"  style="position:absolute; height:230px;width:522px;overflow:auto;bottom:14px">
	 				<div field="wglx" label="违规类型" code="sys082"></div>
					<div field="wgsj" label="违规时间" ></div>
					<div field="wgxq" label="违规详情"></div>
					<div field="kfz" label="扣分值"></div>
				</div>
				
			
		</div>
	
	</div>
		
</body>
</html>