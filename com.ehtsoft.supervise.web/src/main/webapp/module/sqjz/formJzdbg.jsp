<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>社区服刑人员居住地变更审批表</title>
		<link rel="stylesheet" href="../../resources/bootstrap/css/bootstrap.min.css">
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/JzryJzdbgspService.js"></script>
        <script type="text/javascript">
		     $(function(){
				var service = new JzryJzdbgspService();
				var view = "";
				//e70d4c49-7a7b-4416-b4d4-91d7d03e805b
				//${param.id}
				//alert("${param.id}");
				service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
					success:function(data){
						view = new Eht.View({selector:"#sqjz_formJzdbg_all",fieldname:"field"});
						view.fill(data);//个人基本信息
						if(data.jzdbg.length){
							view =  new Eht.View({selector:"#sqjz_formJzdbg_all #jzdbg",fieldname:"field"});
							view.fill(data.jzdbg[0]);
							$("#sqjz_formJzdbg_all #qrdmx").text(data.jzdbg[0].qrdmx);
						}
						
					}
				}))
		     })
		</script>
        <style>
        	#sqjz_formJzdbg_all .all{
        		width:520px;
        		margin:0 auto;
        	}
              #sqjz_formJzdbg_all td{
              	text-align:center;
              	width:70px;
              	height:60px;
              	
              }
              #sqjz_formJzdbg_all .right{
              	text-align:right;
              	margin:0 10px 1px 0;
              	padding-bottom:1px;
              }
        </style>
    </head>
    <body>
    	<div id="sqjz_formJzdbg_all">
	    	<div class="all">
	    	社区矫正人员编号:<span field="sqjzrybh" label="社区矫正人员编号"></span>
	    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;申请日期:<span field="sqsj" label="社区矫正人员编号"></span>
				<div style="font-size:20px;text-align:center"><b>社区服刑人员居住地变更审批信息表</b></div>
				<table border="1" cellspacing="0" align="center" style="border-collapse:collapse;"><br>
					<tr>
						<td>姓名</td>
						<td field="xm"></td>
						<td>性别</td>
						<td><div field="xb" code="SYS000"></div></td>
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
					<tr>
						<td>现居<br>住地</td>
						<td colspan="3"><div field="gdjzdmx"></div></td>
						<td>拟迁往地</td>
						<td colspan="3"><div id="qrdmx"></div></td>
					</tr>
					<tr>
						<td>户籍地</td>
						<td colspan="3"><div field="hjszdmx"></div></td>
						<td>身份证号码</td>
						<td colspan="3"><div field="sfzh"></div></td>
					</tr>
					<tbody id="jzdbg">
						<tr>
							<td>居住地变更理由</td>
							<td colspan="7"><div><span field="jzdbgsy"></span></div></td>
						</tr>
						<tr>
							<td>司法所<br>意&nbsp;&nbsp;&nbsp;见</td>
							<td colspan="7"><div><span field="sfsshyj"></span><div class="right" field="sfsshsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
						</tr>
						<tr>
							<td>现居住地县级司法行政机关意见</td>
							<td colspan="7"><div><span field="xsfjspyj"></span><div class="right" field="xsfjspsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
						</tr>
					</tbody>
					<tr>
						<td>备注</td>
						<td colspan="7"><div><span field="remark"></span></div></td>
					</tr>
				</table>
				<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：用于居住地变更时，抄送现居住地县级人民检察院、公安(分)局；变更后，复印送新居住地县级人民检察院、公安(分)局。
				</div>
			</div>
		</div>
    </body>
</html>