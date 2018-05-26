<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>社区矫正人员进入特定区域审批表</title>
        <link rel="stylesheet" href="../../resources/bootstrap/css/bootstrap.min.css">
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/JzryJrtsqyspService.js"></script>
        <script type="text/javascript">
		     $(function(){
				var service = new JzryJrtsqyspService();
				var view = "";
				service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
					success:function(data){
						view = new Eht.View({selector:"#sqjz_formJrtdqy_all",fieldname:"field"});
						view.fill(data);//个人基本信息
						if(data.jzl.size>0){
							view =  new Eht.View({selector:"#sqjz_formJrtdqy_all #jzl",fieldname:"field"});
							view.fill(data.jzl[0]);
						}
						if(data.jrtdqy.length>0){
							view =  new Eht.View({selector:"#sqjz_formJrtdqy_all #jrtdqy",fieldname:"field"});
							view.fill(data.jrtdqy[0]);
							$("#sqjz_formJrtdqy_all #sqjrcs").text(data.jrtdqy[0].sqjrcs);
							
						}
					}
				}))
		     })
		</script>
        <style>
        	#sqjz_formJrtdqy_all .all{
        		width:520px;
        		margin:0 auto;
        	}
              #sqjz_formJrtdqy_all td{
              	text-align:center;
              	width:60px;
              	height:60px;
              	
              }
              #sqjz_formJrtdqy_all .right{
              		text-align:right;
	              	margin:0 10px 1px 0;
	              	padding-bottom:1px;
              }
        </style>
    </head>
    <body>
    	<div id="sqjz_formJrtdqy_all">
	    	<div class="all">
				<div style="font-size:20px;text-align:center;"><b>社区服刑人员进入特定区域(场所)审批表</b></div>
				<table border="1" cellspacing="0" align="center" style="border-collapse:collapse;"><br>
					<tr>
						<td>姓名</td>
						<td field="xm"></td>
						<td>性别</td>
						<td><div field="xb" code="SYS089"></div></td>
						<td>罪名</td>
						<td><div field="jtzm"></div></td>
						<td>原判<br>刑期</td>
						<td><div field="ypxq"></div></td>
					</tr>
					<tr>
						<td>矫正<br>类别</td>
						<td><div field="jzlb" code="SYS017"></div></td>
						<td>矫正<br>期限</td>
						<td><div field="sqjzqx"></div></td>
						<td>起止日</td>
						<td colspan="3">
							<div><span field="sqjzksrq"></span>(起)<br><span field="sqjzjsrq"></span>(止)</div>
						</td>
					</tr>
					<tbody  id="jzl">
						<tr>
							<td>禁制令内容</td>
							<td colspan="3"><div field="jzlnr"></div></td>
							<td>禁止<br>期限<br>起止日</td>
							<td colspan="3"><div><span field="jzqxksrq"></span>至<span field="jzqxjsrq"></span></div></td>
						</tr>
					</tbody>
					<tr>
						<td>居住地</td>
						<td colspan="3"><div field="gdjzdmx"></div></td>
						<td>申请进入的区域(场所)</td>
						<td colspan="3"><div id="sqjrcs"></div></td>
					</tr>
					<tbody id="jrtdqy">
						<tr>
							<td>申请理由及时间起止</td>
							<td colspan="7"><div style="margin:0 auto"><span field="sqly"></span><div class="right"><span field="sqjrrq"></span>&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;<span field="sqjsrq"></span></div></div></td>
						</tr>
						<tr>
							<td>司法所意见</td>
							<td colspan="7"><div style="margin:0 auto"><span field="sfsshyj"></span><div class="right" field="sfsshsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
						</tr>
						<tr>
							<td>县级司法行政机关意见</td>
							<td colspan="7"><div style="margin:0 auto"><span field="xsfjspyj"></span><div class="right" field="xsfjspsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
						</tr>
					</tbody>
					<tr>
						<td>备注</td>
						<td colspan="7"></td>
					</tr>
				</table>
				<div style="margin:0 0 0 30px">注：抄送居住地县级人民检察院。</div>
			</div>
		</div>
    </body>
</html>