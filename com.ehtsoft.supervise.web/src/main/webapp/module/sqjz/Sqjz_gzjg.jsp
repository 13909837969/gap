<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正-工作监管</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzYwjgService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SqjzYwjgSjbbService.js"></script>
<script type="text/javascript"
	src="${localCtx}/json/JzJzryjbxxService.js"></script>
<style type="text/css">
.modal-content {
	width: 800px
}
.bdstyle {
	border: 1px solid #f00;
}
</style>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : "#sqjz_gzzk",
			autolayout : true
		});
		
		var tableView = new Eht.TableView({
			selector : "#sqjz_gzzk #tableview",
			//一次选择多个数据
			multable : true
		});
		var service = new SqjzYwjgService();
		var query = {};
	 
		$("#querybtn").click(function(){
			service.findQueryData(form.getData(),new Eht.Responder({
				success:function(data){
					$("#tbdata").html('');
					for (var i = 0; i < data.length;i ++) {
					$("#tbdata").append("<tr>");
					$("#tbdata").append("<td colspan='2'>"+data[i].jgmc+"</td>");
					$("#tbdata").append("<td>"+data[i].zcsqjzrs+"</td>");
					$("#tbdata").append("<td>"+data[i].jzxz+"</td>");
					$("#tbdata").append("<td>"+data[i].bkfz+"</td>");
					$("#tbdata").append("<td>"+data[i].ksgl+"</td>");
					$("#tbdata").append("<td>"+data[i].ptgl+"</td>");
					$("#tbdata").append("<td>"+data[i].yggl+"</td>");
					$("#tbdata").append("<td>"+data[i].bdwg+"</td>");
					$("#tbdata").append("<td>"+data[i].tggl+"</td>");
					$("#tbdata").append("<td>"+data[i].zzjzjy+"</td>");
					$("#tbdata").append("<td>"+data[i].gbthjy+"</td>");
					$("#tbdata").append("<td>"+data[i].jxxlfd+"</td>");
					$("#tbdata").append("<td>"+data[i].zzsqfw+"</td>");
					$("#tbdata").append("<td>"+data[i].jx+"</td>");
					$("#tbdata").append("<td>"+data[i].jg+"</td>");
					$("#tbdata").append("<td>"+data[i].zacf+"</td>");
					$("#tbdata").append("<td>"+data[i].sjzz+"</td>");
					$("#tbdata").append("<td>"+data[i].zfz+"</td>");
					$("#tbdata").append("<td>"+data[i].jswt+"</td>");
					$("#tbdata").append("<td>"+data[i].wcpg+"</td>");
					$("#tbdata").append("<td>"+data[i].cx+"</td>");
					$("#tbdata").append("<td>"+data[i].zzgzry+"</td>");
					$("#tbdata").append("<td>"+data[i].zzshgzz+"</td>");
					$("#tbdata").append("<td>"+data[i].shzyz+"</td>");
					$("#tbdata").append("<td>"+data[i].yjljyjd+"</td>");
					$("#tbdata").append("<td>"+data[i].jyjdyjl+"</td>");
					$("#tbdata").append("<td>"+data[i].yjlsqfwjd+"</td>");
					$("#tbdata").append("<td>"+data[i].yjlsqjzzx+"</td>"); 
					$("#tbdata").append("</tr>");
					}
				}
			}));
		})
		
		//循环填充数据
		window.onload = function(){
			//获取当前登录机构的orgid
			var orgStyle="${CURRENT_USER_SESSION.orgType}";
			var	orgid = "${CURRENT_USER_SESSION.orgid}"
			
			//var tbdata = document.getElementById("#tbdata");
			service.findAllData(orgid,new Eht.Responder({
				success:function(data){
					for (var i = 0; i < data.length;i ++) {
					$("#tbdata").append("<tr>");
					$("#tbdata").append("<td colspan='2'>"+data[i].jgmc+"</td>");
					$("#tbdata").append("<td>"+data[i].zcsqjzrs+"</td>");
					$("#tbdata").append("<td>"+data[i].jzxz+"</td>");
					$("#tbdata").append("<td>"+data[i].bkfz+"</td>");
					$("#tbdata").append("<td>"+data[i].ksgl+"</td>");
					$("#tbdata").append("<td>"+data[i].ptgl+"</td>");
					$("#tbdata").append("<td>"+data[i].yggl+"</td>");
					$("#tbdata").append("<td>"+data[i].bdwg+"</td>");
					$("#tbdata").append("<td>"+data[i].tggl+"</td>");
					$("#tbdata").append("<td>"+data[i].zzjzjy+"</td>");
					$("#tbdata").append("<td>"+data[i].gbthjy+"</td>");
					$("#tbdata").append("<td>"+data[i].jxxlfd+"</td>");
					$("#tbdata").append("<td>"+data[i].zzsqfw+"</td>");
					$("#tbdata").append("<td>"+data[i].jx+"</td>");
					$("#tbdata").append("<td>"+data[i].jg+"</td>");
					$("#tbdata").append("<td>"+data[i].zacf+"</td>");
					$("#tbdata").append("<td>"+data[i].sjzz+"</td>");
					$("#tbdata").append("<td>"+data[i].zfz+"</td>");
					$("#tbdata").append("<td>"+data[i].jswt+"</td>");
					$("#tbdata").append("<td>"+data[i].wcpg+"</td>");
					$("#tbdata").append("<td>"+data[i].cx+"</td>");
					$("#tbdata").append("<td>"+data[i].zzgzry+"</td>");
					$("#tbdata").append("<td>"+data[i].zzshgzz+"</td>");
					$("#tbdata").append("<td>"+data[i].shzyz+"</td>");
					$("#tbdata").append("<td>"+data[i].yjljyjd+"</td>");
					$("#tbdata").append("<td>"+data[i].jyjdyjl+"</td>");
					$("#tbdata").append("<td>"+data[i].yjlsqfwjd+"</td>");
					$("#tbdata").append("<td>"+data[i].yjlsqjzzx+"</td>"); 
					$("#tbdata").append("</tr>");
					}
				}
			}));
		}
	})
</script>
</head>
<body>
	<div id="sqjz_gzzk">
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-default">
					<div class="panel-heading" class="panel-heading">
						<fieldset id="dataForm">
							<label> 受理日期 </label> 
							<input id="qssj" name="qssj" style="border-radius: 3px; border: 1px solid #b3b0b0;" placeholder="起始日期" class="form_date" data-date-formate="yyyyMMdd"   type="text"> 
							<label>至</label> 
							<input id="jssj" name="jssj" style="border-radius: 3px; border: 1px solid #b3b0b0;" placeholder="结束日期" class="form_date" data-date-formate="yyyyMMdd"  type="text">
							<button id="querybtn" class="btn btn-primary" style="border-radius: 3px; border: 1px solid #b3b0b0; margin-right: 10px;">查询</button>
							<input type="hidden" id="orgid" name = "orgid" value="${CURRENT_USER_SESSION.orgid}"/>
						</fieldset>
					</div>
					<div class="panel panel-default">
						<div class="panel-body">
							<div id="" class="table-responsive">
								<table class="dataTable1" id="dg1" cachesize="0" lazy="false" scroll="false" autofill="true" multiselect="true" size="0" page="false" sortstring="" afterdrag="sortMenu" align="center" width="100%" cellspacing="0" cellpadding="0" border="1" bgcolor="#DDDDDD">
									<tbody align="center">
										<tr>
											<td class="th_b1" colspan="36" height="40" align="center"><strong
												style="font-size: 25px">社&nbsp;区&nbsp;矫&nbsp;正&nbsp;工&nbsp;作&nbsp;监&nbsp;管</strong></td>
										</tr>
										<tr>
											<td rowspan="6" colspan="2" class="th_a" style="font-weight: 600;"
												align="center" width="13%">地区/项目</td>
											<td rowspan="4" class="" style="font-weight: 600;"
												align="center">在册<br>社区<br>矫正<br>人数
											</td>
											<td rowspan="4" class="" style="font-weight: 600;"
												align="center">矫正<br>小组
											</td>
											<td rowspan="4" class="" style="font-weight: 600;"
												align="center">帮困扶助</td>
											<td colspan="3" class="" style="font-weight: 600;"
												align="center">管理等级</td>
											<td colspan="2" class="" style="font-weight: 600;"
												align="center">监督管理</td>
											<td colspan="4" class="" style="font-weight: 600;"
												align="center">教育矫正</td>
											<td colspan="5" class="" style="font-weight: 600;"
												align="center">奖惩情况</td>
											<td colspan="3" class="" style="font-weight: 600;"
												align="center">适用社区影响评估</td>
											<td colspan="7" class="" style="font-weight: 600;"
												align="center">基础工作建设</td>
										</tr>
										<tr>
											<td rowspan="3" class="" align="center">宽松<br>管理
											</td>
											<td rowspan="3" class="" align="center">普通<br>管理
											</td>
											<td rowspan="3" class="" align="center">严格<br>管理
											</td>
											<td rowspan="3" class="" align="center">报到<br>违规
											</td>
											<td rowspan="3" class="" align="center">脱管<br>情况
											</td>
										
											</td>
											<td rowspan="3" class="" align="center">组织<br>集中<br>教育
											</td>
											<td rowspan="3" class="" align="center">个别<br>谈话<br>教育
											</td>
											<td rowspan="3" class="" align="center">进行<br>心理<br>辅导
											</td>
											<td rowspan="3" class="" align="center">组织<br>社区<br>服务
											</td>
									
									
											<td rowspan="3" class="" align="center">减刑</td>
											<td rowspan="3" class="" align="center">警告</td>
											<td rowspan="3" class="" align="center">治安<br>处罚
											</td>
											<td rowspan="3" class="" align="center">收监<br>执行
											</td>
											<td rowspan="3" class="" align="center">再犯罪</td>
											<td rowspan="3" class="" align="center">接受<br>委托
											</td>
											<td rowspan="3" class="" align="center">完成<br>评估
											</td>
											<td rowspan="3" class="" align="center">采信</td>
											<td colspan="3" class="" align="center">队伍建设</td>
											<td colspan="4" class="" align="center">基地建设</td>
										</tr>
										<tr>
											<td rowspan="2" class="" align="center">专职<br>工作<br>人员
											</td>
											<td rowspan="2" class="" align="center">专职<br>社会<br>工作<br>者
											</td>
											<td rowspan="2" class="" align="center">社会<br>志愿<br>者
											</td>
											<td rowspan="2" class="" align="center">已建立<br>就业基<br>地
											</td>
											<td rowspan="2" class="" align="center">已建立<br>教育基<br>地
											</td>
											<td rowspan="2" class="" align="center">已建立<br>社区服<br>务基地
											</td>
											<td rowspan="2" class="" align="center">已建立<br>社区矫<br>正中心
											</td>
										</tr>
										<tr>
										</tr>
										<tr>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人次</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">人</td>
											<td class="" align="center" width="50">个</td>
											<td class="" align="center" width="50">个</td>
											<td class="" align="center" width="50">个</td>
											<td class="" align="center" width="50">个</td>
											
										</tr>
										<tr>
											<td class="" align="center">1</td>
											<td class="" align="center">2</td>
											<td class="" align="center">3</td>
											<td class="" align="center">4</td>
											<td class="" align="center">5</td>
											<td class="" align="center">6</td>
											<td class="" align="center">7</td>
											<td class="" align="center">8</td>
											<td class="" align="center">9</td>
											<td class="" align="center">10</td>
											<td class="" align="center">11</td>
											<td class="" align="center">12</td>
											<td class="" align="center">13</td>
											<td class="" align="center">14</td>
											<td class="" align="center">15</td>
											<td class="" align="center">16</td>
											<td class="" align="center">17</td>
											<td class="" align="center">18</td>
											<td class="" align="center">19</td>
											<td class="" align="center">20</td>
											<td class="" align="center">21</td>
											<td class="" align="center">22</td>
											<td class="" align="center">23</td>
											<td class="" align="center">24</td>
											<td class="" align="center">25</td>
											<td class="" align="center">26</td>
											<td class="" align="center">27</td>
										</tr>
									</tbody>
									<tbody  id="tbdata" align="center"></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>