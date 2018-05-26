<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>核实取证信息采集表</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzryHsqzxxService.js"></script>
 <style>
 #sqjz_Hsqzxxcjb .right-panel {
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
#siderightbar {
	cursor: pointer;
}
#siderightbar:hover {
	color: #00f;
}
 </style>
 <script type="text/javascript">
   $(function(){
	   var form = new Eht.Form({
		  selector:"#sqjz_Hsqzxxcjb #Hsqzxxcjb_form",
			autolayout:true,
		});
	  //查询表单
	   var hsryform = new Eht.Form({
		  selector:"#hsqz_ryxx",
		  autolayout:true,
	   });	 
	   var tableView = new Eht.TableView({
		   selector:"#sqjz_Hsqzxxcjb #Hsqzxxcjb_table",
	   }); 
	   	   //右侧表格
	  var rtable = new Eht.TableView({
			selector:"#tableview-shjl"
		});
	    
	    var service = new JzryHsqzxxService();
	    //将信息加载到页面
		   var query = {};	    
		    tableView.loadData(function(page,res){	 
		    	service.find(query,page,res);
		    });	 
	    //单机一行获取该行信息
	     var json={};
	     tableView.clickRow(function(data){
	    	 json = data;
	    	 $('#close_alert_div').hide();
	    	 if(!$("#sqjz_Hsqzxxcjb #right-panel").is(":hidden")){
	    		 hsryform.fill(json);
	    		 rtable.refresh();
	    	 }
	     });
	     tableView.dblclickRow(function(data){
	    	 json = data;
	    	 hsryform.fill(json);
         	 rtable.refresh();
	    	 $("#sqjz_Hsqzxxcjb #right-panel").show().animate({width:750});	 
	     });
	     //将核实信息添加到右侧栏
		 rtable.loadData(function(page,res){
			 if(json.id!=null){
			 	service.findHsqz(json.id,res);
			 }
		 }); 
	        
	     //关闭右侧面板
	     $("#siderightbar").click(function() {
				$('#sqjz_Hsqzxxcjb #right-panel').animate({
					width : 0
				}, function() {
					$(this).hide()
				});
			});
	     //查询按钮事件
		    $("#sqjz_Hsqzxxcjb #Hsqzxxcjb_cx").click(function(){			   
			 query["xm[like]"] = $("#search-xm").val(); 
			 tableView.refresh();
		   });
	     //点击添加取证弹出模态框
		   $("#sqjz_Hsqzxxcjb #Hsqzxxcjb_tjqz").click(function(){
				$("#hsqzsj").val(new Date().format("yyyy-MM-dd"));
			 //初始提示信息为隐藏状态
			   if(json.xm==null){
				   $('#close_alert_div').show();
			   }else{
				   $("#Hsqzxxcjb_myModal").modal({backdrop:'static'});	
				   form.clear();
				   form.setValue("xm",json.xm);  
				   form.setValue("sfzh",json.sfzh);  
				   form.setValue("gdjzdmx",json.gdjzdmx);  
			   }
		   });
	          //保存按钮
			$("#sqjz_Hsqzxxcjb #bchsxx").click(function(){		
				if(form.validate()){
					var ds = form.getData();
					ds.aid = json.id;
					service.save(ds,new Eht.Responder({
						success:function(){
							$('#Hsqzxxcjb_myModal').modal("hide");
							form.clear();
						}
				    }));

				}
		   });
		
		   //默认为不可编辑
		   function changeInput(ifBoolean){
				if(ifBoolean){
					hsryform.disable();
				}else{
					hsryform.enable();
				}
			}
            tableView.transColumn("audit",function(data){
		    	var rtn = "";
				if(data.audit==1){
					rtn="通过";
				}
				if(data.audit==2){
					rtn="未通过";
				}
				if(data.audit==0){
					rtn="待审核";
				}
		    	return rtn;
		    })
			//初始提示信息为隐藏状态
			$('#close_alert_div').hide();
			$('#close_alert').click(function(){
				$('#close_alert_div').hide();
			});							
         });  
 </script>
</head>
<body>
	<div id="sqjz_Hsqzxxcjb">
		<div id="Hsqzxxcjb_hsqz">
			<fieldset id="Hsqzxxcjb_mhcx">
				<label>姓名 <input class="btn btn-default" id="search-xm"
					name="xm" placeholder="请输入姓名" type="text"
					style="width: 170px; height: 28px;" />
				</label> <span> <input id="Hsqzxxcjb_cx" type="button" value="查询"
					class="btn btn-default btn-sm" /> <input id="Hsqzxxcjb_tjqz"
					type="button" value="添加取证" class="btn btn-default btn-sm" />
				</span>
			</fieldset>
			<div class="alert alert-warning alert_dismissible"
				id="close_alert_div" role="alert"
				style="text-align: center; font-size: 17px">
				<strong>提示</strong> 请选择一条信息! <input type="button"
					class="btn btn-default" id="close_alert" value="取消" />
			</div>
			<!-- 主页面 -->
			<div id="Hsqzxxcjb_table">
				<div field="xm" label="姓名"></div>
				<div field="xb" label="性别" code="SYS000"></div>
				<div field="grlxdh" label="联系方式"></div>
				<div field="sfzh" label="身份证号"></div>
				<div field="gdjzdmx" label="地址"></div>
				<div field="jglx" label="管教类型" code="SYS114"></div>
			</div>
			<!-- 右侧面板 -->
			<div class="right-panel" id="right-panel">
				<div class="panel panel-default">
					<div class="panel-heading" style="font-size: 18px;">
						<span id="siderightbar" class="glyphicon glyphicon-remove-sign"></span>&nbsp;治安处罚信息
					</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading" id="Hsqzryjbxx_ycxf">
						<div class="hsqz_ryxx" id="hsqz_ryxx">
							<input type="text" label="姓名" name="xm" getdis="true" disabled />
							<input type="text" label="联系电话" name="grlxdh" getdis="true"
								disabled /> <input type="text" label="地址" name="gdjzdmx"
								getdis="true" disabled />
						</div>
						<div id="tableview-shjl" class="table-responsive">
							<div field="bhsqzr" label="被核实取证人"></div>
							<div field="hsqzsy" label="核实取证事由"></div>
							<div field="hsqzr" label="核实取证人"></div>
							<div field="hsqzsj" label="取证时间"></div>
							<div field="hsqzdd" label="取证地点"></div>
							<div field="hsqkjl" label="核实情况"></div>
							<div field="clyj" label="处理意见"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 模态框 -->
		<div class="modal fade" id="Hsqzxxcjb_myModal" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">添加核实取证信息</h4>
					</div>
					<div class="modal-body">
						<div id="Hsqzxxcjb_form">
							<input id="xm" name="xm" label="服刑人员" disabled> 
							<input id="sfzh" name="sfzh" label="身份证号" disabled>
							<input id="gdjzdmx" name="gdjzdmx" label="地址" disabled>
							<input id="bhsqzr" name="bhsqzr" label="被核实取证人">
							<input id="hsqzsy" name="hsqzsy" label="核实取证事由">
							<input id="hsqzr" name="hsqzr" type="text" label="核实取证人" value="${CURRENT_USER_SESSION.name}">
							<input id="hsqzsj" name="hsqzsj" class="form_date" label="取证时间">
							<input id="hsqzdd" name="hsqzdd" label="取证地点">
							<input id="hsqkjl" name="hsqkjl" label="核实情况">
							<input id="clyj" name="clyj" label="处理意见">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" id="close"
								data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="bchsxx">保存</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal -->
			</div>
		</div>
	</div>
</body>
</html>