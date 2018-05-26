<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员接除矫正信息表</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
        <style>
	        #form_jcjz table{
	        	border-collapse:collapse;
	        	width:100%;
	        }
	        #form_jcjz .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #form_jcjz td{
		        	text-align:center;
		        	width:70px;
	
		        #form_jcjz .td3 {
		        	width:80px;
		        }
	            #form_jcjz .td4 div{
		            height:150px;
	            }
	            #form_jcjz .td5 div{
		            height:200px;
	            }
	             #form_jcjz .td6{
					height:35px;	
	            }
	            #form_jcjz .td6 div {
					text-align:center;
					
	            }
	            #form_jcjz .head1 .head2 .head3{
	             	text-align:center;
	            }
	             
	            #form_jcjz .foot{
	              	margin:0 0 0 10px;
	            }
	            .tr_data{
	            	height:15px;
	            }
	         </style>
        
    </head>
    <body>
    <div id="form_jcjz">
    	
		<table border="1" cellspacing="0" id="table_view" align="center">
				<tr>
					<td  class="td3">解除/终止矫正原因</td>
					<td ><div field="jjlx" code="SYS018"></div></td>
					<td>解除矫正日期</td>
					<td><div field="jjrq"></div></td>
					<td>收监执行原因</td>
					<td colspan="2"><div field="sjzxyy" code="sys010"></div></td>
				</tr>
				<tr>
					<td class="td1">收监执行类型</td>
					<td><div field="sjzxlx" code="sys011" ></div></td>
					<td class="td1">收监执行日期</td>
					<td><div field="sjzxrq" ></div></td>
					<td class="td1">死亡日期</td>
					<td colspan="2"><div field="swsj" ></div></td>
				</tr>
				<tr>
					<td class="td1">死亡原因</td>
					<td><div field="swyy" code="SYS019"></div></td>
					<td class="td1">具体死因</td>
					<td><div field="jtsy" ></div></td>
					<!--  field="jkzk" code="sys125" -->
					<td class="td1">居住地变更日期</td>
					<td colspan="2"><div field="jzdbgrq" ></div></td>
				</tr>
				<tr>
					<td class="td2" >新居住地地址</td>
					<td><div field="xjzddz"></div></td>
					<td class="td1">矫正期间表现</td>
					<td><div field="jzqjbx" code="sys024" ></div></td>
					<td class="td1">认罪态度</td>
					<td colspan="2"><div field="rztd" code="sys042"></div></td>
				</tr>
				<tr>
					<td class="td1">矫正期间是否参加职业技能培训</td>
					<td><div field="sfcjzyjnpx" code="SYS001"></div></td>
					<td class="td1">矫正期间是否获得职业技能证书</td>
					<td><div field="sfhdzyjnzs" code="SYS001"></div></td>
					<td class="td1">技术特长及等级</td>
					<td colspan="2"><div field="jstcjdj" ></div></td>
				</tr>
				<tr>
					<td class="td1">危险性评估</td>
					<td colspan="2"><div field="wxxpg" code="SYS043"></div></td>
					<td class="td1">家庭联系情况</td>
					<td colspan="3"><div field="jtlxqk" code="SYS044"></div></td>
				</tr>
				<tr>
					<td class="td1">矫正期间特殊情况备注及帮教建议</td>
					<td colspan="6"><div field="tsqkbzjbjjy" ></div></td>
				</tr>
					
			<tbody id="yzqk">
				<tr style="height: 20px">
					<td class="td5" valign="middle">余罪或再罪有关情况</td>
					<td colspan="1">所涉罪名</td>
					<td colspan="1">侦查机关</td>
					<td colspan="1">被采取强制措施时间</td>
					<td colspan="1">审判机关</td>
					<td colspan="1">罪名</td>
					<td colspan="1">刑期</td>
				</tr>
			</tbody>
				<tr>
					<td colspan="1" rowspan="3"><div>备注</div></td>
					<td colspan="6" rowspan="3"><div field="remark" id="remark"></div></td>
				</tr>
		</table>
		</div>
    </body>
<script type="text/javascript">

     $(function(){
		var service=new XfzxService();
		var form_jcjz = new Eht.View({selector:"#form_jcjz",
			fieldname:"field"});
		service.findXfzx("${param.id}",new Eht.Responder({
			success:function(data){
				form_jcjz.fill(data["jcjz"]);	
			}
		}));

		
		
		
		service.findyzqk("${param.id}",new Eht.Responder({
				success:function(data){
					if(data.length>0){//个人简历信息
						var yzqk = $("#form_jcjz #yzqk");
						yzqk.children().eq(0).find("td").eq(0).attr("rowspan",data.length+2);
						for(var i=0;i<data.length;i++){
							var d = data[i];
							var tr = $('<tr id='+i+'>'+
							'<td colspan="1"><div  field="sszm"></div></td>'+
							'<td colspan="1" class="td6"><div field="zcjg"></div></td>'+
							'<td colspan="1" class="td6"><div field="bcqqzcssj"></div></td>'+
							'<td colspan="1" class="td6"><div field="spjg"></div></td>'+
							'<td colspan="1" class="td6"><div field="zm"></div></td>'+
							'<td colspan="1" class="td6"><div field="xq"></div></td>'+
							'</tr>');
							yzqk.append(tr);
							 var yzxxMsg = new Eht.View({selector:"#form_jcjz #"+i,
									fieldname:"field"});
								yzxxMsg.fill(d);  
						}
						
						for(var i=0;i<1;i++){//加一行空行
							var d = data[i];
							var tr = $('<tr id="0" style="height:15px">'+
							'<td colspan="1"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							
							'</tr>');
							yzqk.append(tr);
						}
					}else{
						var yzqk = $("#form_jcjz #yzqk");
						yzqk.children().eq(0).find("td").eq(0).attr("rowspan",4);
						for(var i=0;i<4;i++){
							var tr = $('<tr id="0" style="height:15px">'+
									'<td colspan="1"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'</tr>');
							yzqk.append(tr);
						}
					};
				}
		}));
		
      
     
     
     
     });
</script>
</html>
