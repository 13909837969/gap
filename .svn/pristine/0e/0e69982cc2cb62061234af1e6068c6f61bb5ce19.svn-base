<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>社区矫正-人员监管</title>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/SqjzYwjgSjbbService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SqjzYwjgService.js"></script>
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
			selector : "#sqjz_ryjg",
			autolayout : true
		});
		var tableView = new Eht.TableView({
			selector : "#sqjz_ryjg #tableview",
			//一次选择多个数据
			multable : true
		});
		var service_ywjg = new SqjzYwjgSjbbService();
		
		var service = new SqjzYwjgService();
		//初始化
		$("#initbtn").click(function(){
			service_ywjg.saveIninRy();
			
		});
		//12点
		$("#twobtn").click(function(){
			service_ywjg.saveRyIncrement();
			
		});
		
		$("#init2btn").click(function(){
			service_ywjg.saveIncrement();
			
		});
		
		$("#querybtn").click(function(){
			service.findQueryRyData(form.getData(),new Eht.Responder({
				success:function(data){
					$("#tbdata").html('');
					for (var i = 0; i < data.length;i ++) {
						$("#tbdata").append("<tr>");
						$("#tbdata").append("<td>"+data[i].jgmc+"</td>");
						$("#tbdata").append("<td>"+data[i].zcsqjzrs+"</td>");
						$("#tbdata").append("<td>"+data[i].byzj+"</td>");
						$("#tbdata").append("<td>"+data[i].qmjc+"</td>");
						$("#tbdata").append("<td>"+data[i].cxhc+"</td>");
						$("#tbdata").append("<td>"+data[i].cxjs+"</td>");
						$("#tbdata").append("<td>"+data[i].jdsj+"</td>");
						$("#tbdata").append("<td>"+data[i].sjzxqt+"</td>");
						$("#tbdata").append("<td>"+data[i].zcsw+"</td>");
						$("#tbdata").append("<td>"+data[i].fzcsw+"</td>");
						$("#tbdata").append("<td>"+data[i].swqt+"</td>");
						$("#tbdata").append("<td>"+data[i].nan+"</td>");
						$("#tbdata").append("<td>"+data[i].nv+"</td>");
						$("#tbdata").append("<td>"+data[i].wcn+"</td>");
						$("#tbdata").append("<td>"+data[i].cntwo+"</td>");
						$("#tbdata").append("<td>"+data[i].cnthree+"</td>");
						$("#tbdata").append("<td>"+data[i].cnold+"</td>");
						$("#tbdata").append("<td>"+data[i].bshj+"</td>");
						$("#tbdata").append("<td>"+data[i].wshj+"</td>");
						$("#tbdata").append("<td>"+data[i].gatj+"</td>");
						$("#tbdata").append("<td>"+data[i].wgj+"</td>");
						$("#tbdata").append("<td>"+data[i].xxjyx+"</td>");
						$("#tbdata").append("<td>"+data[i].czxl+"</td>");
						$("#tbdata").append("<td>"+data[i].gzxl+"</td>");
						$("#tbdata").append("<td>"+data[i].dzjys+"</td>");
						$("#tbdata").append("<td>"+data[i].wh+"</td>");
						$("#tbdata").append("<td>"+data[i].yh+"</td>");
						$("#tbdata").append("<td>"+data[i].so+"</td>"); 
						$("#tbdata").append("<td>"+data[i].ly+"</td>");
						$("#tbdata").append("<td>"+data[i].zh+"</td>");
						$("#tbdata").append("<td>"+data[i].hz+"</td>");
						$("#tbdata").append("<td>"+data[i].shmz+"</td>");
						$("#tbdata").append("<td>"+data[i].jx+"</td>");
						$("#tbdata").append("<td>"+data[i].jy+"</td>");
						$("#tbdata").append("<td>"+data[i].wy+"</td>");
						$("#tbdata").append("<td>"+data[i].xiaoqx+"</td>");
						$("#tbdata").append("<td>"+data[i].zhongqx+"</td>");
						$("#tbdata").append("<td>"+data[i].xzqx+"</td>");
						$("#tbdata").append("<td>"+data[i].daqx+"</td>");
						$("#tbdata").append("<td>"+data[i].gz+"</td>");
						$("#tbdata").append("<td>"+data[i].hx+"</td>");
						$("#tbdata").append("<td>"+data[i].js+"</td>");
						$("#tbdata").append("<td>"+data[i].zyjwzx+"</td>");
						$("#tbdata").append("<td>"+data[i].bdzzql+"</td>");
						$("#tbdata").append("<td>"+data[i].whgjaq+"</td>");
						$("#tbdata").append("<td>"+data[i].whggaq+"</td>");
						$("#tbdata").append("<td>"+data[i].phjjzx+"</td>");
						$("#tbdata").append("<td>"+data[i].qfgmrsql+"</td>");
						$("#tbdata").append("<td>"+data[i].qfcc+"</td>");
						$("#tbdata").append("<td>"+data[i].fhshglzx+"</td>");
						$("#tbdata").append("<td>"+data[i].twsh+"</td>");
						$("#tbdata").append("<td>"+data[i].dz+"</td>");
						$("#tbdata").append("<td>"+data[i].qt+"</td>");
				
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
			service.findAllRyData(orgid,new Eht.Responder({
				success:function(data){
					for (var i = 0; i < data.length;i ++) {
					$("#tbdata").append("<tr>");
					$("#tbdata").append("<td>"+data[i].jgmc+"</td>");
					$("#tbdata").append("<td>"+data[i].zcsqjzrs+"</td>");
					$("#tbdata").append("<td>"+data[i].byzj+"</td>");
					$("#tbdata").append("<td>"+data[i].qmjc+"</td>");
					$("#tbdata").append("<td>"+data[i].cxhc+"</td>");
					$("#tbdata").append("<td>"+data[i].cxjs+"</td>");
					$("#tbdata").append("<td>"+data[i].jdsj+"</td>");
					$("#tbdata").append("<td>"+data[i].sjzxqt+"</td>");
					$("#tbdata").append("<td>"+data[i].zcsw+"</td>");
					$("#tbdata").append("<td>"+data[i].fzcsw+"</td>");
					$("#tbdata").append("<td>"+data[i].swqt+"</td>");
					$("#tbdata").append("<td>"+data[i].nan+"</td>");
					$("#tbdata").append("<td>"+data[i].nv+"</td>");
					$("#tbdata").append("<td>"+data[i].wcn+"</td>");
					$("#tbdata").append("<td>"+data[i].cntwo+"</td>");
					$("#tbdata").append("<td>"+data[i].cnthree+"</td>");
					$("#tbdata").append("<td>"+data[i].cnold+"</td>");
					$("#tbdata").append("<td>"+data[i].bshj+"</td>");
					$("#tbdata").append("<td>"+data[i].wshj+"</td>");
					$("#tbdata").append("<td>"+data[i].gatj+"</td>");
					$("#tbdata").append("<td>"+data[i].wgj+"</td>");
					$("#tbdata").append("<td>"+data[i].xxjyx+"</td>");
					$("#tbdata").append("<td>"+data[i].czxl+"</td>");
					$("#tbdata").append("<td>"+data[i].gzxl+"</td>");
					$("#tbdata").append("<td>"+data[i].dzjys+"</td>");
					$("#tbdata").append("<td>"+data[i].wh+"</td>");
					$("#tbdata").append("<td>"+data[i].yh+"</td>");
					$("#tbdata").append("<td>"+data[i].so+"</td>"); 
					$("#tbdata").append("<td>"+data[i].ly+"</td>");
					$("#tbdata").append("<td>"+data[i].zh+"</td>");
					$("#tbdata").append("<td>"+data[i].hz+"</td>");
					$("#tbdata").append("<td>"+data[i].shmz+"</td>");
					$("#tbdata").append("<td>"+data[i].jx+"</td>");
					$("#tbdata").append("<td>"+data[i].jy+"</td>");
					$("#tbdata").append("<td>"+data[i].wy+"</td>");
					$("#tbdata").append("<td>"+data[i].xiaoqx+"</td>");
					$("#tbdata").append("<td>"+data[i].zhongqx+"</td>");
					$("#tbdata").append("<td>"+data[i].xzqx+"</td>");
					$("#tbdata").append("<td>"+data[i].daqx+"</td>");
					$("#tbdata").append("<td>"+data[i].gz+"</td>");
					$("#tbdata").append("<td>"+data[i].hx+"</td>");
					$("#tbdata").append("<td>"+data[i].js+"</td>");
					$("#tbdata").append("<td>"+data[i].zyjwzx+"</td>");
					$("#tbdata").append("<td>"+data[i].bdzzql+"</td>");
					$("#tbdata").append("<td>"+data[i].whgjaq+"</td>");
					$("#tbdata").append("<td>"+data[i].whggaq+"</td>");
					$("#tbdata").append("<td>"+data[i].phjjzx+"</td>");
					$("#tbdata").append("<td>"+data[i].qfgmrsql+"</td>");
					$("#tbdata").append("<td>"+data[i].qfcc+"</td>");
					$("#tbdata").append("<td>"+data[i].fhshglzx+"</td>");
					$("#tbdata").append("<td>"+data[i].twsh+"</td>");
					$("#tbdata").append("<td>"+data[i].dz+"</td>");
					$("#tbdata").append("<td>"+data[i].qt+"</td>");
			
					$("#tbdata").append("</tr>");
					}
				}
			}));
		}
		
	})
</script>
</head>
<body>
	<div id="sqjz_ryjg">
		<div class="container-fluid">
			<div class="row">
				<div class="panel panel-default">
					<div class="panel-heading" class="panel-heading">
						<fieldset>
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
								<table class="" id="dg1" cachesize="0" lazy="false"
									scroll="false" autofill="true" multiselect="true" size="0"
									page="false" sortstring="" afterdrag="sortMenu" align="center"
									width="2700" cellspacing="0" cellpadding="0" border="1"
									bgcolor="#DDDDDD">
									<tbody>
										<tr>
											<td colspan="53" class="th_b1" height="40" align="center"><strong
												style="font-size: 25px">社&nbsp;区&nbsp;矫&nbsp;正&nbsp;人&nbsp;员&nbsp;监&nbsp;管</strong></td>
										</tr>
										<tr class="th_a">
											<td rowspan="6" class="th_b1" style="font-weight: 600;"
												align="center" width="7%">地区\项目</td>
											<td rowspan="4" class="th_b1" style="font-weight: 600;"
												align="center">在册<br>社区<br>矫正<br>人数
											</td>
											<td colspan="9" class="th_a" style="font-weight: 600;"
												align="center">变动情况</td>
											<td colspan="2" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">性别</td>
											<td colspan="4" rowspan="3" class="th_b1"
												style="font-weight: 60000;" align="center">年龄</td>
											<td colspan="4" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">户籍</td>
											<td colspan="4" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">文化程度</td>
											<td colspan="5" rowspan="3" class="th_b1" 
											style="font-weight: 600;" align="center">婚姻状况</td>
											<td colspan="2" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">民族</td>
											<td colspan="3" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">就业就学</td>
											<td colspan="4" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">矫正期限</td>
											<td colspan="5" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">矫正类别</td>
											<td colspan="9" rowspan="3" class="th_b1"
												style="font-weight: 600;" align="center">犯罪类型</td>
										</tr>
										<tr>
											<td rowspan="3" class="th_b1" align="center">本月<br>增加
											</td>
											<td colspan="8" class="th_a" align="center">本月减少</td>
										</tr>
										<tr>
											<td rowspan="2" class="th_b1" align="center">期满<br>解除
											</td>
											<td colspan="4" class="th_a" align="center">收监执行</td>
											<td colspan="2" class="th_a" align="center">死亡</td>
											<td rowspan="2" class="th_b1" align="center">其他</td>
										</tr>
										<tr>
											<td class="th_b1" align="center">撤销<br>缓刑
											</td>
											<td class="th_b1" align="center">撤销<br>假释
											</td>
											<td class="th_b1" align="center" width="58">对暂予<br>监外执<br>行罪犯<br>决定收<br>监执行
											</td>
											<td class="th_b1" align="center">其他</td>
											<td class="th_b1" align="center">正常<br>死亡
											</td>
											<td class="th_b1" align="center">非正<br>常死<br>亡
											</td>
											<td class="th_b1" align="center">男性</td>
											<td class="th_b1" align="center">女性</td>
											<td class="th_b1" align="center">未满<br>十八<br>周岁
											</td>
											<td class="th_b1" align="center">十八<br>至四<br>十五<br>周岁
											</td>
											<td class="th_b1" align="center">四十<br>六至<br>六十<br>周岁
											</td>
											<td class="th_b1" align="center">六十<br>一周<br>岁以<br>上
											</td>
											<td class="th_b1" align="center">本省<br>户籍
											</td>
											<td class="th_b1" align="center">外省<br>户籍
											</td>
											<td class="th_b1" align="center">港澳<br>台籍
											</td>
											<td class="th_b1" align="center">外国<br>及无<br>国籍
											</td>
											<td class="th_b1" align="center">小学<br>及以<br>下
											</td>
											<td class="th_b1" align="center">初中</td>
											<td class="th_b1" align="center">高中</td>
											<td class="th_b1" align="center">大专<br>以上
											</td>
											<td class="th_b1" align="center">未婚</td>
											<td class="th_b1" align="center">已婚</td>
											<td class="th_b1" align="center">丧偶</td>
											<td class="th_b1" align="center">离异</td>
											<td class="th_b1" align="center">未知</td>
											<td class="th_b1" align="center">汉族</td>
											<td class="th_b1" align="center">少数<br>民族
											</td>
											<td class="th_b1" align="center">就学</td>
											<td class="th_b1" align="center">就业</td>
											<td class="th_b1" align="center">无业</td>
											<td class="th_b1" align="center">不满<br>一年
											</td>
											<td class="th_b1" align="center">一年<br>以上<br>不满<br>三年
											</td>
											<td class="th_b1" align="center">三年<br>以上<br>不满<br>五年
											</td>
											<td class="th_b1" align="center">五年<br>以上
											</td>
											<td class="th_b1" align="center">管制</td>
											<td class="th_b1" align="center">缓刑</td>
											<td class="th_b1" align="center">假释</td>
											<td class="th_b1" align="center">暂予<br>监外<br>执行
											</td>
											<td class="th_b1" align="center">剥夺<br>政治<br>权利
											</td>
											<td class="th_b1" align="center">危害<br>国家<br>安全
											</td>
											<td class="th_b1" align="center">危害<br>公共<br>安全
											</td>
											<td class="th_b1" align="center">破坏<br>经济<br>秩序
											</td>
											<td class="th_b1" align="center">侵犯<br>公民<br>人身<br>权利
											</td>
											<td class="th_b1" align="center">侵犯<br>财产
											</td>
											<td class="th_b1" align="center">妨害<br>社会<br>管理<br>秩序
											</td>
											<td class="th_b1" align="center">贪污<br>受贿
											</td>
											<td class="th_b1" align="center">渎职</td>
											<td class="th_b1" align="center">其他</td>
										</tr>
										<tr>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
											<td class="th_a" align="center" width="40">人</td>
										</tr>
										<tr>
											<td class="th_a" align="center">1</td>
											<td class="th_a" align="center">2</td>
											<td class="th_a" align="center">3</td>
											<td class="th_a" align="center">4</td>
											<td class="th_a" align="center">5</td>
											<td class="th_a" align="center">6</td>
											<td class="th_a" align="center">7</td>
											<td class="th_a" align="center">8</td>
											<td class="th_a" align="center">9</td>
											<td class="th_a" align="center">10</td>
											<td class="th_a" align="center">11</td>
											<td class="th_a" align="center">12</td>
											<td class="th_a" align="center">13</td>
											<td class="th_a" align="center">14</td>
											<td class="th_a" align="center">15</td>
											<td class="th_a" align="center">16</td>
											<td class="th_a" align="center">17</td>
											<td class="th_a" align="center">18</td>
											<td class="th_a" align="center">19</td>
											<td class="th_a" align="center">20</td>
											<td class="th_a" align="center">21</td>
											<td class="th_a" align="center">22</td>
											<td class="th_a" align="center">23</td>
											<td class="th_a" align="center">24</td>
											<td class="th_a" align="center">25</td>
											<td class="th_a" align="center">26</td>
											<td class="th_a" align="center">27</td>
											<td class="th_a" align="center">28</td>
											<td class="th_a" align="center">29</td>
											<td class="th_a" align="center">30</td>
											<td class="th_a" align="center">31</td>
											<td class="th_a" align="center">32</td>
											<td class="th_a" align="center">33</td>
											<td class="th_a" align="center">34</td>
											<td class="th_a" align="center">35</td>
											<td class="th_a" align="center">36</td>
											<td class="th_a" align="center">37</td>
											<td class="th_a" align="center">38</td>
											<td class="th_a" align="center">39</td>
											<td class="th_a" align="center">40</td>
											<td class="th_a" align="center">41</td>
											<td class="th_a" align="center">42</td>
											<td class="th_a" align="center">43</td>
											<td class="th_a" align="center">44</td>
											<td class="th_a" align="center">45</td>
											<td class="th_a" align="center">46</td>
											<td class="th_a" align="center">47</td>
											<td class="th_a" align="center">48</td>
											<td class="th_a" align="center">49</td>
											<td class="th_a" align="center">50</td>
											<td class="th_a" align="center">51</td>
											<td class="th_a" align="center">52</td>
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