<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>刑期变动情况</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/XqbdService.js"></script>
	<script type="text/javascript">	
	$(function(){
		$('list_xqbd #close_alert_div').hide();
		$('list_xqbd #delete_alert_div').hide();

		var json = {};
		var service = new XqbdService();	
    	var form = new Eht.Form({
    		selector:'#list_xqbd #formXqbdqkb',
    		autolayout:true});
    	var qform = new Eht.Form({selector:"#list_xqbd #xqbg_queryform"});
		var tableView_ry = new Eht.TableView({
			multable:false,
			selector : "#list_xqbd #jzryxx_list"
			});
		var tableView_bgxx = new Eht.TableView({
			multable:false,
			selector : "#list_xqbd #bgxx_list",
			paginate:null
			});
		
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
		
		changeInput(true);
		//单击人员信息表
		var aid;
		tableView_ry.clickRow(function(data){
			$("#bgxx_list").show();
			json = data;
			aid=json.id;
			changeInput(false);	
			tableView_bgxx.refresh();
			
			var res = Eht.Responder({success:function(data){
				tableView_right.refresh();
			}});
			
			tableView_bgxx.loadData(function(page, res) {
				if(json.id!=null){
					service.findXqbd(aid,res);
				}
			});
		});	
		
		//禁用
		$("#xqbd_add").attr('disabled',true);
		$("#xqbg_del").attr('disabled',true);
		
		tableView_bgxx.clickRow(function(data){
			$("#xqbg_add").attr('disabled',true);
			$("#xqbg_del").attr('disabled',false);
			json=data;
		});
		
		//数据查询
		tableView_ry.loadData(function(page, res) {
			service.findAllRy(qform.getData(),page,res);
		});
		

		//查询
		$("#list_xqbd #querybtn").click(function() {
			tableView_ry.refresh();
			$("#bgxx_list").hide();
		});
		//“增加”功能
		$("#list_xqbd #xqbg_add").click(function() {
				if(json.id!=null){
					$("#myModal").modal({backdrop : 'static',keyboard : false}); 
					var fdata = {};
					fdata.aid = json.id;
					fdata.xm = json.xm;
					fdata.sfzh  = json.sfzh;
					fdata.bdrq=nowTime;
					form.fill(fdata);
				}
			});
			//提交
			$('#xqbg_submit').click(function(){
				if(form.validate()){
					service.saveXq(form.getData(),new Eht.Responder({
						success:function(data){
							$('#xqbg_submit').disable();
							$('#myModal').modal('hide');
							$('#xqbg_submit').enable();
							tableView_bgxx.refresh();
						},
						error:function(msg){
							$('#xqbg_submit').enable();
						}
					}));
				}
				
			});
			//点击取消隐藏提示栏
			$('#list_xqbd #listXqbd #close_alert').click(function(){
				$('#list_xqbd #close_alert_div').hide();
				tableView_ry.refresh();
			});
			
			
			$('#list_xqbd #no').click(function(){
				$('#list_xqbd #delete_alert_div').hide();
			});		
			
			//选择input事件的状态  disable
			function changeInput(ifBoolean){
				if(ifBoolean){
					$("#xqbg_add").disable();
				}else{
					$("#xqbg_add").enable();
				}
			}; 
			//字数限制
			var textareaName = "#listXqbdqk #bdyy";//备注输入框id
			var spanName = "#listXqbdqk #count";//计数span的id
			$(textareaName).click(function(){
				countChar(textareaName,spanName);
			});
			$(textareaName).keyup(function(){
				countChar(textareaName,spanName);
			});
			$(textareaName).keydown(function(){
				countChar(textareaName,spanName);
			});
			
			function countChar(textareaName,spanName){ 
			   if($(textareaName).val() != ""){
					$(spanName).text("已输入：" + $(textareaName).val().length + "/500");			
					if($(textareaName).val().length>0){
							$(spanName).css("color","#3F51B5");
							
					};
					if($(textareaName).val().length>500){
							$(spanName).css("color","#FF0000");
							$("#bdyy").attr("readOnly","false");
						};
				}else{
					$(spanName).text("已输入：0/500");
				}
			}; 
			
			//删除
			$("#xqbg_del").click(function(data){
				var con; 
				con=confirm("确定要删除？");
				if(con==true){
					service.deleteOne(json);
					tableView_bgxx.loadData(function(page,res){
						service.findXqbd(aid,res);
					});
					 setTimeout(function () { 
						 tableView_bgxx.refresh();
						 }, 200);
					
					$("#xqbg_del").attr('disabled',true);
				}
			});
			
			
			$(document).ready(function(){
				var org="${CURRENT_USER_SESSION.orgType}";
		 		if(org==1){
				}
				if(org!=null&&org==2){
					var add=document.getElementById("xqbg_add"); 
					add.setAttribute("type","hidden");
					$("#xqbg_add").hide();
					
					var add=document.getElementById("xqbg_del"); 
					add.setAttribute("type","hidden");
					$('#xqbg_del').hide(); 
				}
				if(org==3){
		 			var add=document.getElementById("xqbg_add"); 
					add.setAttribute("type","hidden");
					
					var add=document.getElementById("xqbg_del"); 
					add.setAttribute("type","hidden"); 
				}
				if(org==4){
					//双击变更信息表
					tableView_bgxx.dblclickRow(function(data){
						$("#myModal").modal({backdrop : 'static',keyboard : false}); 
						data.sfzh  = json.sfzh;
						data.xm = json.xm;
						form.fill(data);
					});
				}
				})
			
			$("#xqbd_cz").click(function(){
				window.location.reload();
			});
			
			
			
		});
	</script>
	<style type="text/css">
		#listXqbdqk{
			padding-top:15px;
		}
		#listXqbdqk .mycol-md{
		    padding-right: 1px;
		    padding-left: 1px;
		}
		.ltrhao-table tr>td:nth-child(3){
		    white-space: pre-wrap;
		    word-wrap: break-word;
		    max-width: 400px;
		}
	</style>
</head>	
<body>
<div id="list_xqbd">
		<div class="alert alert-warning alert_dismissible" id="close_alert_div"  hidden role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
		</div>
		<div class="alert alert-info alert-dissmissible" id="delete_alert_div" hidden role="alert" style="text-align:center;font-size:17px">
			<strong>提示</strong> 确定删除？
			<input id="yes" class="btn btn-default" type="button" value="确定" />
			<input id="no" class="btn btn-default" type="button" value="取消" />
		</div>	
		
		<div id="listXqbdqk" class="container-fluid">
			<div class="row">
				<div class="panel panel-default">
					<fieldset id="xqbg_queryform" class="panel-heading">
						<label>姓名：</label><input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/>		
						<label>身份证号：</label><input type="text" name="sfzh[like]" class="btn btn-default" placeholder="请输入身份证号"/>				
						 <input id="querybtn" class="btn btn-default" type="button" value="查询">
						 <input id="xqbg_add" class="btn btn-default" type="button" value="增加变更">
						 <input type="button" id="xqbg_del" class="btn btn-default" value="删除"/>
						 <input type="button" id="xqbd_cz" class="btn btn-default" value="重置"/>
					</fieldset>
			  <div class="col-md-7 mycol-md">
				<div id="container-Azglid"class="panel panel-default">		
					<div class="panel-heading" ><center>人员信息</center></div>	
						<div class="panel-body" >
							<div id="jzryxx_list">
								<div field='op' 		label="选择" 	checkbox="true"></div>
								<div field="xm"  		label="姓名" ></div>
								<div field="sfzh" 		label="身份证号"></div>
								<div field="grlxdh"  	label="联系电话"></div>
								<div field="jglx"		label="教管类型" code="sys114"></div>
							</div>					
						</div>
					</div>	
				</div>
				<div class="col-md-5 mycol-md">
					<div id="tableView_bgxx"	 class="panel panel-default">	
						<div class="panel-heading"><center>变更信息</center></div>
						<div  id="formls">
						<div class="panel-body"  id="bgxx" >
							<div id="bgxx_list">
								<div field='bdrq' 		label="变动日期"></div>
								<div field="bdfd"  		label="变动幅度" ></div>
								<div field="bdyy" 		label="变动原因"></div>
							</div>		
						</div>		
						</div>	
					</div>	  
				</div>
			</div>
			<!-- 模态框（Modal） -->
			<div class="modal fade" id="myModal">
				<div class="modal-dialog ">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="false">×</button>
							<center><h4 class="modal-title" id="myModalLabel">刑期变动情况</h4></center>
						</div>
						<div class="modal-body" >
						    	<div  class="panel panel-default">
						    		<div class="panel-body" id="formXqbdqkb">
						    			<input type="text" label="姓名" name="xm"  disabled/>
						    			<input type="text"  label="身份证号" name="sfzh"  disabled  label="身份证号" maxlength="18"/>
						    			<input id="bdrq" type="text" label="变动日期" name="bdrq"  placeholder="起始日期"  valid="{required:true}"  class="form_date" data-date-format="yyyy-MM-dd" maxlength="20"/>   			
						    			<input id="bdfd" type="text" label="变动幅度" name="bdfd"  valid="{required:true}" maxlength="20" /> 
						    			<textarea id="bdyy" type="text"  label="变动原因" name="bdyy"  valid="{required:true}" maxlength="500"></textarea>
						    			<span id="count" style="margin-left:400px;color:#3F51B5"></span>
						    		</div>
						    	</div>
						</div>
						<div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					        <button type="button" class="btn btn-primary" id="xqbg_submit">提交</button>
					    </div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
		</div>
	</div>
</div>
</body>
</html>
	