<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员基本信息</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/SqjzZpgService.js"></script>
        <style>
	        #form_zpg table{
	        	border-collapse:collapse;
	        	width: 100%;
	        }
	        #form_zpg .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #form_zpg td{
		        	text-align:center;
		        	width:70px;
	
		        #form_zpg .td3 {
		        	width:80px;
		        }
	         </style>
        
    </head>
    <script type="text/javascript">
     $(function(){
		var service=new SqjzZpgService();
		var view=new Eht.View({selector:"#form_zpg",fieldname:"field"});
		service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
			success:function(data){//个人基本信息)
				view.fill(data);
			}
		}));
     
     });
</script>
    <body>
    <div id="form_zpg">
		<table border="1" cellspacing="0" id="table_view" align="center">
				<tr>
					<td>人员编号</td>
					<td colspan="5"><div field="sqjzrybh"></div></td>
					<td rowspan="3" style="width:90px"><div>
					<img id="zp" style="width:90px;height:120px" src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per"  alt="一寸免冠照片">
					</div>
					</td>
				</tr>
				<tr>
					<td class="td1"><div >姓名</div></td>
					<td field="xm"></td>
					
					<td class="td1"><div>曾用名</div></td>
					<td name="cym" field="cym"></td>
					
					<td class="td1"><div>身份证</div>号码</td>
					<td colspan="1"><div field="sfzh"></div></td>
				</tr>
				<tr>
					<td class="td1"><div>性别</div></td>
					<td><div field="xb" code="SYS000"></div></td>
					
					<td class="td1"><div>民族</div></td>
					<td><div field="mz" code="SYS003"></div></td>
					
					<td class="td1"><div>出生年月日</div></td>
					<td colspan="1"><div field="csrq"></div></td>
				</tr>
				<tr>
					<td class="td1">文化程度</td>
					<td><div field="whcd" code="SYS028"></div></td>
					<td class="td1"><div>原政治面貌</div></td>
					<td><div field="yzzmm" code="SYS091"></div></td>
					<td class="td1"><div>婚姻状况</div></td>
					<td colspan="2"><div field="hyzk" code="SYS030"></div></td>
				</tr>
			
				<tr>
					<td class="td3"><div>罪名</div></td>
					<td colspan="3"><div field="jtzm" id="jtzm"></div></td>
				
					<td><div>原判刑期</div></td>
					<td colspan="2"><div field="ypxq" id="ypxq"></div></td>
				</tr>
				<tr>
					<td colspan="1" class="td3">矫正类别</td>
					<td colspan="2"><div field="jzlb" code="SYS017" id="jzlb"></div></td>
					
					
					<td><div>矫正起止日期</div></td>
					<td colspan="3"><div>自&nbsp;&nbsp;<span field="sqjzksrq"></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="sqjzjsrq"></span>&nbsp;&nbsp;止</div></td>
				</tr>
		</table>
		
		</div>
    </body>

</html>
