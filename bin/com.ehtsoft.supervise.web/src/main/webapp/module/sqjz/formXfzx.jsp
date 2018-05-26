<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>刑罚执行信息</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzJzryJzlxxService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	#sqjz_formXfzx_all{
		width:500px;
		margin:0 auto;
	}
	#sqjz_formXfzx_all #table td{
		width:18px;
		text-align:center;
	}
	#sqjz_formXfzx_all #table div{
		text-align:center;
		line-height:100%;
	}
</style>
<script type="text/javascript">
		$(function(){
			var service = new JzJzryJzlxxService();
			var view = "";
 			service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
 	 			success:function(data){
 	 				if(data.xb==1){
 	 					data.xb = "男"
 	 				}else if(data.xb==2){
 	 					data.xb = "女"
 	 				}
 	 				/*将个人基本信息存入表中*/
 	 				view = new Eht.View({selector:"#sqjz_formXfzx_all #table",fieldname:"field"});
 	 				view.fill(data);
 	 				/*将禁止令信息存入表中*/
 	 				view = new Eht.View({selector:"#sqjz_formXfzx_all #table #jzl",fieldname:"field"});
 	 				view.fill(data.jzl[0]);
 	 				
 	 				/*将托管信息存入表中*/
 	 				if(data.tgxx.length>0){
 						var tgxx = $("#sqjz_formXfzx_all #tgxx");
 						tgxx.children().eq(0).find("td").eq(0).attr("rowspan",data.tgxx.length+2);
 						tgxx.children().eq(0).find("td").eq(1).attr("rowspan",data.tgxx.length+2);
 						tgxx.children().eq(0).find("td").eq(2).attr("rowspan",data.tgxx.length+2);
 						for(var i=0;i<data.tgxx.length;i++){
 							var d = data.tgxx[i];
 							var tr = $('<tr id="0">'+
 							'<td><div>'+d.fxtgsj+'</div></td>'+
 							'<td><div>'+d.zzczqk+'</div></td>'+
 							'<td><div>'+d.czjg+'</div></td>'+
 							'<td><div>'+d.tqsjjyrq+'</div></td>'+
 							'</tr>');
 							tgxx.append(tr);
 						}
 					}else{
 						var tgxx = $("#sqjz_formXfzx_all #tgxx");
 						tgxx.children().eq(0).find("td").eq(0).attr("rowspan",3);
 						tgxx.children().eq(0).find("td").eq(1).attr("rowspan",3);
 						tgxx.children().eq(0).find("td").eq(2).attr("rowspan",3); 
 						for(var i=0;i<2;i++){
 							var tr = $('<tr id="0">'+
 									'<td><div style="height:20px"></div></td>'+
		 							'<td><div></div></td>'+
		 							'<td><div></div></td>'+
		 							'<td><div></div></td>'+
 									'</tr>');
 							tgxx.append(tr);
 						}
 					};
 					/*将奖惩情况存入表中*/
 					if(data.jcxx.length>0){
 						var jcxx = $("#sqjz_formXfzx_all #jcxx");
 						var a = 1;//用于警告信息-计数
						var b = 1;//用于治安处罚-计数
						var c = 1;//用于减刑信息-计数
 						jcxx.children().eq(0).find("td").eq(0).attr("rowspan",data.jcxx.length+20);
 						jcxx.children().eq(0).find("td").eq(1).attr("rowspan",data.jcxx.length+20);
 						jcxx.children().eq(0).find("td").eq(2).attr("rowspan",data.jcxx.length+20);
 						for(var i=0;i<data.jcxx.length;i++){
 							var d = data.jcxx[i];
 							if(data.jcxx[i].jclb == "01"){
 								var tr = $('<tr>'+
 			 							'<td colspan="2"><div>第'+ a +'次警告</div></td>'+
 			 							'<td><div>'+d.jcsj+'</div></td>'+
 			 							'<td><div code="SYS083" style="width:18px;text-align:center;">'+d.jcyy+'</div></td>'+
 			 							'</tr>');
 								a = a+1;
 								$("#sqjz_formXfzx_all #jg").empty();
 								$("#sqjz_formXfzx_all #cr").before(tr);
 							}
 							if(data.jcxx[i].jclb == "0201"){
 								var tr = $('<tr>'+
 			 							'<td><div>第'+b+'次治安处罚</div></td>'+
 			 							'<td><div>依社区矫正机构提请</div></td>'+
 			 							'<td><div>'+d.jcsj+'</div></td>'+
 			 							'<td><div code="SYS083" style="width:18px;text-align:center;">'+d.jcyy+'</div></td>'+
 			 							'</tr>');
 								b = b+1;
 								$("#sqjz_formXfzx_all #zacf").empty();
 								$("#sqjz_formXfzx_all #cr").before(tr);
 							}
 							if(data.jcxx[i].jclb == "0202"){
 								var tr = $('<tr>'+
 										'<td><div>第'+b+'次治安处罚</div></td>'+
 			 							'<td><div>公安机关依法给予</div></td>'+
 			 							'<td><div>'+d.jcsj+'</div></td>'+
 			 							'<td><div code="SYS083" style="width:18px;text-align:center;">'+d.jcyy+'</div></td>'+
 			 							'</tr>');
 								b = b+1;
 								$("#sqjz_formXfzx_all #zacf").empty();
 								$("#sqjz_formXfzx_all #cr").before(tr);
 							}
 							if(data.jcxx[i].jclb == "03"){
 								var tr = $('<tr>'+
 			 							'<td colspan="2"><div code="SYS082">第'+c+'次减刑</div></td>'+
 			 							'<td><div>'+d.jcsj+'</div></td>'+
 			 							'<td><div code="SYS083" style="width:18px;text-align:center;">'+d.jcyy+'</div></td>'+
 			 							'</tr>');
 								c = c+1;
 								$("#sqjz_formXfzx_all #jx").empty();
 								$("#sqjz_formXfzx_all #cr").before(tr);
 							}
 						}
 					};
 	 			}
 	 		}))
		})
	</script>
</head>
<body>
	<div id="sqjz_formXfzx_all">	
		<div style="text-align:center;font-size:20px; ">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b>刑罚执行信息</b>
			<span style="font-size:10px">(司法所填写)</span>
		</div>
		<table  id="table" border="1" cellspacing="0" align="center" style="border-collapse:collapse;width:100%">
			<tr>
				<td><div>矫正类别</div></td>
				<td colspan="2">
					<div field="jzlb" code="SYS017">
						<input type="radio" name="jzlb" value="01">管制
						<input type="radio" name="jzlb" value="02">缓刑
						<input type="radio" name="jzlb" value="03">假释<br>
						<input type="radio" name="jzlb" value="01">暂予监外执行
						<input type="radio" name="jzlb" value="02">其他
					</div>
				</td>
				<td><div>矫正起止日</div></td>
				<td><div><span field="sqjzksrq"></span>(起)<br><span field="sqjzjsrq"></span>(止)</div></td>
				<td><div>矫正期限</div></td>
				<td><div field="sqjzqx"></div></td>
			</tr>
			<tr>
				<td><div>罪名</div></td>
				<td><div field="jtzm"></div></td>
				<td><div>犯罪类型</div></td>
				<td colspan="4">
					<div field="fzlx" code="SYS014">
						<input type="radio" name="fzlx" value="01">危害国家安全
						<input type="radio" name="fzlx" value="02">危害公共安全
						<input type="radio" name="fzlx" value="03">破坏社会主义市场经济秩序
						<input type="radio" name="fzlx" value="01">侵犯公民人身权利、民主权利
						<input type="radio" name="fzlx" value="02">侵犯财产
						<input type="radio" name="fzlx" value="02">妨害社会管理秩序
						<input type="radio" name="fzlx" value="03">危害国防利益
						<input type="radio" name="fzlx" value="01">贪污受贿
						<input type="radio" name="fzlx" value="02">渎职
						<input type="radio" name="fzlx" value="02">其他
					</div>
				</td>
			</tr>
			<tr>
				<td><div>管制期限</div></td>
				<td colspan="2">
					<div field="gzqx" code="SYS058">
						<input type="radio" name="gzqx" value="01">6 个月以下&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="gzqx" value="02">1 年以下<br>
						<input type="radio" name="gzqx" value="03">2 年以下&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="gzqx" value="04">3 年以下<br>
					</div>
				</td>
				<td><div>缓刑考验期限</div></td>
				<td colspan="3">
					<div field="hxkyqx" code="SYS059">
						<input type="radio" name="hxkyqx" value="02">1 年以下
						<input type="radio" name="hxkyqx" value="03">2 年以下
						<input type="radio" name="hxkyqx" value="03">3 年以下
						<input type="radio" name="hxkyqx" value="03">4 年以下
						<input type="radio" name="hxkyqx" value="03">5 年以下
					</div>
				</td>
			</tr>
			<tr>
				<td><div>是否数罪并罚</div></td>
				<td>
					<div field="sfszbf" code="SYS001">
						<input type="radio" name="sfszbf" value="02">是<br>
						<input type="radio" name="sfszbf" value="03">否
					</div>
				</td>
				<td><div>原判刑罚</div></td>
				<td>
					<div field="ypxf" code="SYS012">
						<input type="radio" name="ypxq" value="02">死刑缓期二年执行&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="ypxq" value="03">无期&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="ypxq" value="02">有期徒刑&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="ypxq" value="03">拘役&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
				<td><div>原判刑期起止日</div></td>
				<td colspan="2"><div><span field="ypxqksrq"></span>(起)<br><span field="ypxqjsrq"></span>(止)</div></td>
			</tr>
			<tr>
				<td><div>原判刑期</div></td>
				<td><div field="ypxq"></div></td>
				<td><div>有期徒刑期限</div></td>
				<td>
					<div field="yqtxqx" code="SYS032">
						<input type="radio" name="yqtxqx" value="02">3 年以下
						<input type="radio" name="yqtxqx" value="03">5 年以下
						<input type="radio" name="yqtxqx" value="03">10 年以下
						<input type="radio" name="yqtxqx" value="03">15 年以下
						<input type="radio" name="yqtxqx" value="03">20 年以下
						<input type="radio" name="yqtxqx" value="03">25 年以下
					</div>
				</td>
				<td><div>附加刑</div></td>
				<td colspan="2" id="fjx">
					<div field="fjx" code="SYS013">
						<input id="fjx_radio" type="radio" name="fjx" value="01">无&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="fjx" value="02">罚金
						<input type="checkbox" name="fjx" value="01">剥夺政治权利
						<input type="checkbox" name="fjx" value="02">没收财产
						<input type="checkbox" name="fjx" value="02">驱逐出境
					</div>
				</td>
			</tr>
			<tr>
				<td><div>是否“五独”</div></td>
					<td colspan="2" id="sfwd">
						<div field="sfwd" code="SYS040">
							<input id="sfwd_radio" type="radio" name="sfwd" value="01">否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="checkbox" name="sfwd" value="02">疆独
							<input type="checkbox" name="sfwd" value="01">藏独
							<input type="checkbox" name="sfwd" value="02">蒙独
							<input type="checkbox" name="sfwd" value="02">台独
							<input type="checkbox" name="sfwd" value="02">港独
						</div>
					</td>
					<td><div>是否“五涉”</div></td>
					<td colspan="3" id="sfws">
						<div field="sfws" code="SYS041">
							<input id="sfws_radio" type="radio" name="sfws" value="01">否&nbsp;&nbsp;
							<input type="checkbox" name="sfws" value="02">涉恐
							<input type="checkbox" name="sfws" value="01">涉邪
							<input type="checkbox" name="sfws" value="02">涉毒
							<input type="checkbox" name="sfws" value="02">涉黑
							<input type="checkbox" name="sfws" value="02">涉枪
						</div>
					</td>
			</tr>
			<tr>
				<td><div>是否有“四史”</div></td>
				<td colspan="6" id="sfyss">
					<div field="sfyss" code="SYS038">
						<input id="sfyss_radio" type="radio" name="sfyss" value="01">否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="sfyss" value="02">吸毒史
						<input type="checkbox" name="sfyss" value="01">脱逃史
						<input type="checkbox" name="sfyss" value="02">自杀史
						<input type="checkbox" name="sfyss" value="02">袭警史
					</div>
				</td>
			</tr>
		<!-- <tbody id="jzl">
			<tr>
				<td><div>是否被宣告<br>禁止令</div></td>
				<td>
					<div field="sfbxgjzl" code="SYS001">
						<input type="radio" name="sfbxgjzl" value="01">是<br>
						<input type="radio" name="sfbxgjzl" value="01">否
					</div>
				</td>
				<td><div>禁止令内容</div></td>
				<td colspan="2"><div field="jzlnr"></div></td>
				<td><div>禁止期限<br>起止日</div></td>
				<td><div><span field="jzqxksrq"></span>(起)<br><span field="jzqxjsrq"></span>(止)</div></td>
			</tr>
		</tbody> -->
			<tr>
				<td><div>报到情况</div></td>
				<td colspan="3">
					<div field="bdqk" code="SYS016">
						<input type="radio" name="bdqk" value="01">在规定时限内报到
						<input type="radio" name="bdqk" value="01">超出规定时限报到
						<input type="radio" name="bdqk" value="01">未报到且下落不明
					</div>
				</td>
				<td><div>未按时报到情况说明</div></td>
				<td colspan="2"><div field="wasbdqksm"></div></td>
			</tr>
			<tr>
				<td><div>社区服刑人员接收方式</div></td>
				<td colspan="3">
				<div field="sqjzryjsfs" code="SYS015">
					<input type="radio" name="bdqk" value="01">自行报到
					<input type="radio" name="bdqk" value="01">狱所押送
					<input type="radio" name="bdqk" value="01">司法局接回
					<input type="radio" name="bdqk" value="01">其他
				</td>
				<td><div>社区服刑人员接收日期</div></td>
				<td colspan="2"><div field="sqjzryjsrq"></div></td>
			</tr>
			<tr>
				<td><div>是否建立矫正小组</div></td>
				<td colspan="1">
					<div field="sfjljzxz" code="SYS001">
						<input type="radio" name="sfjljzxz" value="01">是<br>
						<input type="radio" name="sfjljzxz" value="01">否
					</div>
				</td>
				<td><div>矫正小组人员组成情况</div></td>
				<td colspan="4">
					<div field="jzxzryzcqk" code="SYS020">
						<input type="checkbox" name="jzxzryzcqk" value="01">司法所工作人员
						<input type="checkbox" name="jzxzryzcqk" value="01">公安派出所民警
						<input type="checkbox" name="jzxzryzcqk" value="01">社会工作者
						<input type="checkbox" name="jzxzryzcqk" value="01">志愿者
						<input type="checkbox" name="jzxzryzcqk" value="01">村（居）委会人员
						<input type="checkbox" name="jzxzryzcqk" value="01">所在单位人员
						<input type="checkbox" name="jzxzryzcqk" value="01">就读学校人员
						<input type="checkbox" name="jzxzryzcqk" value="01">家庭成员或监护人
						<input type="checkbox" name="jzxzryzcqk" value="01">保证人
						<input type="checkbox" name="jzxzryzcqk" value="01">其他
					</div>
				</td>
			</tr>
			<tr>
				<td><div>是否采取电子定位管理</div></td>
				<td colspan="1">
					<div field="sfcydzdwgl" code="SYS001">
						<input type="radio" name="sfcqdzdwgl" value="01">是<br>
						<input type="radio" name="sfcqdzdwgl" value="01">否
					</div>
				</td>
				<td><div>电子定位方式</div></td>
				<td colspan="1">
					<div>	<!--  field="dzdwfs" -->
						手机
					</div>
				</td>
				<td><div>定位号码</div></td>
				<td colspan="2"><div field="dwhm"></div></td>
			</tr>
		<tbody id="tgxx">
			<tr>
				<td><div>是否脱管</div></td>
				<td>
					<div field="sftk" code="SYS001">
						<input type="radio" name="sftg" value="01">是<br>
						<input type="radio" name="sftg" value="01">否
					</div>
				</td>
				<td><div>脱管情况</div></td>
				<td><div>发现脱管时间</div></td>
				<td><div>组织查找情况</div></td>
				<td><div>查找结果</div></td>
				<td><div>提请收监建议日期</div></td>
			</tr>
		</tbody>	
		<tbody id="jcxx">	
			<tr>
				<td rowspan="5"><div>奖惩情况</div></td>
				<td rowspan="5">
					<div field="jcqk" code="SYS001">
						<input type="radio" name="sftg" value="01">是
						<input type="radio" name="sftg" value="01">否
					</div>
				</td>
				<td rowspan="5"><div>奖惩信息</div></td>
				<td colspan="2"><div>奖惩类别</div></td>
				<td><div>奖惩时间</div></td>
				<td><div>奖惩原因</div></td>
			</tr>
			<tr id="cr"></tr>
			<tr id="jg">
				<td colspan="2"><div>警告</div></td>
				<td><div></div></td>
				<td><div>无</div></td>
			</tr>
			<tr id="zacf">
				<td colspan="2"><div>治安处罚</div></td>
				<td><div></div></td>
				<td><div>无</div></td>
			</tr>
			<tr id="jx">
				<td colspan="2"><div>减刑</div></td>
				<td><div></div></td>
				<td><div>无</div></td>
			</tr>
		</tbody>
			<tr>
				<td><div>备注</div></td>
				<td colspan="6"><div field="remark"></div></td>
			</tr>
		</table>
	
	</div>
</body>
</html>