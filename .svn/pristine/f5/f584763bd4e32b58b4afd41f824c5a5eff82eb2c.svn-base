<%@page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>社区服刑人员警告审批表</title>
        <link rel="stylesheet" href="../../resources/bootstrap/css/bootstrap.min.css">
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/JzryJgspService.js"></script>
        <style>
        	#sqjz_formSqjzryjgspb_all
        	 .all{
        		width:520px;
        		margin:0 auto;
        	}
              #sqjz_formSqjzryjgspb_all td{
              	text-align:center;
              	width:70px;
              	height:60px;
              	
              }
              #sqjz_formSqjzryjgspb_all .right{
              	text-align:right;
              	margin:60px 0 0 0;
              }
        </style>
        <script type="text/javascript">
        	$(function(){
        		var service = new JzryJgspService();
        		var view = "";
        		//e70d4c49-7a7b-4416-b4d4-91d7d03e805b
				//${param.id}
        		service.findOne("e70d4c49-7a7b-4416-b4d4-91d7d03e805b",new Eht.Responder({
        			success:function(data){
        				view = new Eht.View({selector:"#sqjz_formSqjzryjgspb_all",fieldname:"field"});
        				view.fill(data);//个人基本信息
						if(data.jg.length>0){
							view =  new Eht.View({selector:"#sqjz_formSqjzryjgspb_all #jg",fieldname:"field"});
							view.fill(data.jg[0]);//警告信息
						}
						if(data.jzl.length>0){
							view =  new Eht.View({selector:"#sqjz_formSqjzryjgspb_all #jzl",fieldname:"field"});
							view.fill(data.jzl[0]);//禁止令信息
						}
        			}
        		}))
        	})
        </script>
    </head>
    <body>
    	<div id="sqjz_formSqjzryjgspb_all">
	    	<div class="all">
				<div style="font-size:20px;text-align:center"><b>社区服刑人员警告审批表</b></div>
				<table border="1" cellspacing="0" align="center" style="border-collapse:collapse;width:100%"><br>
					<tr>
						<td>姓名</td>
						<td field="xm"></td>
						<td>性别</td>
						<td><div field="xb" code="SYS089"></div></td>
						<td>出生年月</td>
						<td colspan="2" field="csrq"></td>
					</tr>
					<tr>
						<td>居住地</td>
						<td colspan="3"><div field="gdjzdmx"></div></td>
						<td>户籍地</td>
						<td colspan="2"><div field="hjszdmx"></div></td>
					</tr>
					<tr>
						<td>罪名</td>
						<td colspan="2"><div field="jtzm"></div></td>
						<td>原判<br>刑期</td>
						<td><div field="ypxq"></div></td>
						<td style="width:15%">附加刑</td>
						<td style="width:20%" field="fjx" code="SYS013"></td>
					</tr>
					<tr id="jzl">
						<td>禁止令<br>内容</td>
						<td colspan="3" field="jzlnr"></td>
						<td>禁止期限<br>起止日</td>
						<td colspan="2">
							<span filed="jzqxksrq"></span>至<br>
							<span field="jzqxjsrq"></span>
						</td>
					</tr>
					<tr>
						<td>矫正<br>类别</td>
						<td field="jzlb" code="SYS017"></td>
						<td>矫正<br>期限</td>
						<td field="sqjzqx"></td>
						<td>起止日</td>
						<td colspan="2">
							<span field="sqjzksrq" ></span>至<br>
							<span field="sqjzjsrq"></span>
						</td>
					</tr>	
				<tbody id="jg">
					<tr>
						<td>事实及<br>依据</td>
						<td colspan="6" field="jgyj"></td>
					</tr>
					<tr>
						<td>司法所<br>意&nbsp;&nbsp;&nbsp;见</td>
						<td colspan="6"><div><span field="sfsspyj"></span><div class="right" field="sfsspsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
					</tr>
					<tr>
						<td>县级司法行政机关意见</td>
						<td colspan="6"><div><span field="xsfjspyj"></span><div class="right" field="xsfjspsj">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;</div></div></td>
					</tr>
					<tr>
						<td>备注</td>
						<td colspan="6" field="remark"></td>
					</tr>
				</tbody>
					
				</table>
				<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：用于撤销缓刑、撤销假释、收监执行时，应连同有关建议书、警告决定书等材料组卷一并报有关人民法院、公安机关、监狱管理机关。
				</div>
			</div>
		</div>
    </body>
</html>