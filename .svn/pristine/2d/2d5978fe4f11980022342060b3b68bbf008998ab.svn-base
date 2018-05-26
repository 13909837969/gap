<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>法律文书信息</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/JzFlwsService.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
	#sqjz_formFlws_all{
		width:500px;
		margin:0 auto;
	}
	#sqjz_formFlws_all #table td{
		width:18px;
		text-align:center;
	}
	
	#sqjz_formFlws_all #table div{
		/* height:80px; */
		text-align:center;
		/*line-height:40px;*/
	}
</style>
<script type="text/javascript">
     $(function(){
    	var service = new JzFlwsService();
 		var view = "";
 			service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
 	 			success:function(data){
	 	 				view = new Eht.View({selector:"#sqjz_formFlws_all #table",fieldname:"field"});
	 	 				view.fill(data);//个人基本信息填入表格
 	 			}
 	 		}))
 		
     })
</script>
</head>
<body>
	<div id="sqjz_formFlws_all">	
		<div style="text-align:center;font-size:20px; ">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<b>法律文书信息</b>
			<span style="font-size:10px">(县级司法局填写)</span>
		</div>
		<table  id="table" border="1" cellspacing="0" align="center" style="border-collapse:collapse;width:100%">
			<tr>
				<td><div>社区矫正决定机关</div></td>
				<td colspan="2">
					<div field="sqjzjdjg" code="SYS055">
						<input type="radio" name="jdjg" value="01">人民法院<br>
						<input type="radio" name="jdjg" value="02">公安机关<br>
						<input type="radio" name="jdjg" value="03">监狱管理机关<br>
					</div>
						
				</td>
				<td><div>社区矫正决定机关名称</div></td>
				<td colspan="2"><div field="sqjzjdjgmc"></div></td>
			</tr>
			<tr>
					<td><div>执行通知书文号</div></td>
					<td colspan="2"><div field="zxtzswh"></div></td>
					<td><div></div>执行通知书日期</td>
					<td colspan="3"><div field="zxtzsrq"></div></td>
			</tr>
			<tr>
				<td><div>交付执行日期</div></td>
				<td colspan="2"><div field="jfzxrq"></div></td>
				<td><div>移交罪犯机关</div></td>
				<td colspan="2">
					<div field="yjzfjg" code="SYS056">
						<input type="radio" name="yjzfjg" value="01">监狱<br>
						<input type="radio" name="yjzfjg" value="02">看守所<br>
						<input type="radio" name="yjzfjg" value="03">公安局<br>
					</div>
				</td>
			</tr>
			<tr>
				<td><div>移交罪犯机关名称</div></td>
				<td colspan="5"><div field="yjzfjgmc"></div></td>
			</tr>
			<tr>
				<td><div>是否有前科</div></td>
				<td>
					<div field="sfyqk" code="SYS001">
						<input type="radio" name="sfyqk" value="01">有<br>
						<input type="radio" name="sfyqk" value="02">无<br>
					</div>
				</td>
				<td><div>是否累犯</div></td>
				<td>
					<div field="sflf" code="SYS001">
						<input type="radio" name="sflz" value="01">是<br>
						<input type="radio" name="sflz" value="02">否<br>
					</div>
				</td>
				<td><div>前科类型</div></td>
				<td>
					<div field="qklx" code="SYS057">
						<input type="checkbox" name="qklx" value="01">行政处罚<br>
						<input type="checkbox" name="qklx" value="02">刑事处罚<br>
					</div>
				</td>
			</tr>
			<tr>
				<td><div>主要犯罪事实</div></td>
				<td colspan="5">
					<div style="font-size:5px" field="zyfzss">
						<span>（主要犯罪事实应当包括犯罪主体、时间、地点、手段、经过和后果等）</span>
					</div>
				</td>
			</tr>
		</table>
	
	</div>
</body>
</html>