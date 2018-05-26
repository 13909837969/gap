<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员基本信息表</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
        <style>
	        #form_wsxx table{
	        	border-collapse:collapse;
	        	width: 100%;
	        }
	        #form_wsxx .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #form_wsxx td{
		        	text-align:center;
		        	width:70px;
	
		        #form_wsxx .td3 {
		        	width:80px;
		        }
	            #form_wsxx .td4 div{
		            height:150px;
	            }
	            #form_wsxx .td5 div{
		            height:200px;
	            }
	             #form_wsxx .td6{
					height:35px;	
	            }
	            #form_wsxx .td6 div {
					text-align:center;
					
	            }
	            #form_wsxx .head1 .head2 .head3{
	             	text-align:center;
	            }
	             
	            #form_wsxx .foot{
	              	margin:0 0 0 10px;
	            }
	            .tr_data{
	            	height:15px;
	            }
	         </style>
        
    </head>
    <body>
    <div id="form_wsxx">
		<table border="1" cellspacing="0" id="table_view" align="center">
				<tr>
					<td>社区矫正决定机关</td>
					<td colspan="2"><div field="sqjzjdjg" code="SYS055"></div>
					<td>社区矫正决定机关名称</td>
					<td colspan="2"><div field="sqjzjdjgmc"  code="SYS015"></div>
				</tr>
				<tr>
					<td>执行通知书文号</td>
					<td colspan="2"><div field="zxtzswh" ></div>
					<td>执行通知书日期</td>
					<td colspan="2"><div field="zxtzsrq" </div>
				</tr>
				<tr>
					<td>交付执行日期</td>
					<td colspan="1"><div field="jfzxrq" ></div>
					<td>移交罪犯机关</td>
					<td colspan="1"><div field="yjzfjg" code="sys056" </div>
					<td>移交罪犯机关名称</td>
					<td colspan="1"><div field="yjzfjgmc" </div>
				</tr>
				<tr>
					<td>是否有前科</td>
					<td colspan="1"><div field="sfyqk" code="sys001" ></div>
					<td>是否累犯</td>
					<td colspan="1"><div field="sflf" code="sys001" </div>
					<td>前科类型</td>
					<td colspan="1"><div field="qklx" code="sys057" </div>
				</tr>
				<tr>
					<td  class="td4" >主要犯罪事实</td>
					<td colspan="6"><div field="zyfzss" id="zyfzss"></div></td>
				</tr>
			</table>
		
		</div>
    </body>
<script type="text/javascript">
     $(function(){
		var service = new XfzxService();
		
		var form_wsxx = new Eht.View({selector:"#form_wsxx",
			fieldname:"field"});
		service.findDaxx("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
			success:function(data){//个人基本信息
				debugger;
				form_wsxx.fill(data["daws"]);
				
				
			}
		}));  
		
	
     
     
     
     
     });
</script>
</html>
