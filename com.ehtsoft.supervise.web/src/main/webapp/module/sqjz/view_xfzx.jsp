<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员刑罚执行信息表</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
        <style>
	        #form_xfzx table{
	        	border-collapse:collapse;
	        	width:100%;
	        }
	        #form_xfzx .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #form_xfzx td{
		        	text-align:center;
		        	width:70px;
	
		        #form_xfzx .td3 {
		        	width:80px;
		        }
	            #form_xfzx .td4 div{
		            height:150px;
	            }
	            #form_xfzx .td5 div{
		            height:200px;
	            }
	             #form_xfzx .td6{
					height:35px;	
	            }
	            #form_xfzx .td6 div {
					text-align:center;
					
	            }
	            #form_xfzx .head1 .head2 .head3{
	             	text-align:center;
	            }
	             
	            #form_xfzx .foot{
	              	margin:0 0 0 10px;
	            }
	            .tr_data{
	            	height:15px;
	            }
	         </style>
        
    </head>
    <body>
    <div id="form_xfzx">
    	
		<table border="1" cellspacing="0" id="table_view" align="center">
				 <tr>
					<td class="td3">矫正类别</td>
					<td><div field="jzlb" code="sys017"></div></td> 
					<td>起止日</td>
					<td><div>自&nbsp;&nbsp;<span field="sqjzksrq"></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="sqjzjsrq"></span>&nbsp;&nbsp;止</div></td>
					<td>矫正期限</td>
					<td><div field="sqjzqx" id="sqjzqx"></div></td>
				</tr>
				<tr>
					<td class="td1">罪名</td>
					<td><div field="zm" ></div></td>
					<td class="td1">犯罪类型</td>
					<td><div field="fzlx" code="SYS014"></div></td>
					<td class="td1">管制期限</td>
					<td ><div field="gzqx" code="sys058"></div></td>
				</tr>
				<tr>
					<td class="td1">缓刑考验期限</td>
					<td><div field="hxkyqx" code="SYS059"></div></td>
					<td class="td1">是否数罪并罚</td>
					<td><div field="sfszbf" code="sys001"></div></td>
					<!--  field="jkzk" code="sys125" -->
					<td class="td1">原判刑罚</td>
					<td><div field="ypxf" code="SYS012"></div></td>
				</tr>
				<tr>
					<td class="td2" >原判刑期起止日</td>
					<td><div>自&nbsp;&nbsp;<span field="ypxqksrq"></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="ypxqjsrq"></span>&nbsp;&nbsp;止</div></td>
					<td class="td1">原判刑期</td>
					<td><div field="ypxq" ></div></td>
					<td class="td1">有期徒刑期限</td>
					<td><div field="yqtxqx" ></div></td>
				</tr>
				<tr>
					<td class="td1">附加刑</td>
					<td><div field="fjx" code="SYS013"></div></td>
					<td class="td1">是否“五独”</td>
					<td><div field="sfwd" code="SYS040"></div></td>
					<td class="td1">是否“五涉”</td>
					<td><div field="sfws" code="SYS041"></div></td>
				</tr>
				<tr>
					<td class="td1">是否有“四史”</td>
					<td><div field="sfyss" code="SYS038"></div></td>
					<td class="td1">是否被宣告禁止令</td>
					<td><div field="sfbxgjzl" code="SYS001"></div></td>
					<td class="td1">禁止令内容</td>
					<td><div field="jzlnr" ></div></td>
				</tr>
				<tr>
					<td class="td1">禁止期限起止日</td>
					<td><div>自&nbsp;&nbsp;<span field="jzksrq"></span>&nbsp;&nbsp;起<br>到&nbsp;&nbsp;<span field="jzjsrq"></span>&nbsp;&nbsp;止</div></td>
					<td class="td1">报道情况</td>
					<td><div field="bdqk" code="SYS016"></div></td>
					<td class="td1">未按时报到情况说明</td>
					<td><div field="wasbdqksm"></div></td>
				</tr>
				<tr>
					<td class="td1">社区矫正人员接收方式</td>
					<td><div field="sqjzryjsfs" code="sys015"></div></td>
					<td class="td1">社区矫正人员接收日期</td>
					<td><div field="sqjzryjsrq"></div></td>
					<td class="td1">是否建立矫正小组</td>
					<td><div field="sfjljzxz" code="SYS001"></div></td>
				</tr>
				<tr>
					<td class="td1">矫正小组人员组成情况</td>
					<td><div field="jzxzryzcqk" code="SYS020"></div></td>
					<td class="td1">是否采取电子定位管理</td>
					<td><div field="sfcqdzdwgl" code="SYS001"></div></td>
					<td class="td1">电子定位方式</td>
					<td><div field="dzdwfs" code="SYS060"></div></td>
				</tr>
				<tr>
					<td class="td1">电子定位方式</td>
					<td><div field="dzdwfs" code="SYS060"></div></td>
					<td class="td1">电子定位方式</td>
					<td><div field="dzdwfs" code="SYS060"></div></td>
					<td class="td1">电子定位方式</td>
					<td><div field="dzdwfs" code="SYS060"></div></td>
				</tr>
			
			<tbody id="tgqk">
				<tr style="height: 20px">
					<td class="td5" valign="middle">脱管情况</td>
					<td colspan="1">发现脱管时间</td>
					<td colspan="1">组织查找情况</td>
					<td colspan="1">查找结果</td>
					<td colspan="2">提请收监建议日期</td>
				</tr>
			</tbody>
			<tbody id="jcqk">
				<tr style="height: 20px">
					<td class="td5" valign="middle">奖惩情况</td>
					<td colspan="1">奖惩类别</td>
					<td colspan="1">奖惩时间</td>
					<td colspan="3">奖惩原因</td>
				</tr>
			</tbody>
				<tr>
					<td colspan="1" rowspan="3"><div>备注</div></td>
					<td colspan="5" rowspan="3"><div field="remark" id="remark"></div></td>
				</tr>
		</table>
		</div>
    </body>
<script type="text/javascript">

     $(function(){
		var service=new XfzxService();
		var xfzx = new Eht.View({selector:"#form_xfzx",
			fieldname:"field"});
		service.findXfzx("${param.id}",new Eht.Responder({
			success:function(data){
			
				xfzx.fill(data["xfzx"]);
				
			}
		}))
		service.findjcxx("${param.id}",new Eht.Responder({
				success:function(data){
					if(data.length>0){//个人简历信息
						var jcxx = $("#form_xfzx #jcqk");
						jcxx.children().eq(0).find("td").eq(0).attr("rowspan",data.length+2);
						for(var i=0;i<data.length;i++){
							var d = data[i];
							var tr = $('<tr id='+i+'>'+
							'<td colspan="1"><div code="sys082" field="jclb"></div></td>'+
							'<td colspan="1" class="td6"><div field="jcsj"></div></td>'+
							'<td colspan="3" class="td6"><div field="jcyy" code="sys083"></div></td>'+
							'</tr>');
							jcxx.append(tr);
							 var jcxxMsg = new Eht.View({selector:"#form_xfzx #"+i,
									fieldname:"field"});
								jcxxMsg.fill(d);  
						}
						
						for(var i=0;i<1;i++){//加一行空行
							var d = data[i];
							var tr = $('<tr id="0" style="height:10px">'+
							'<td colspan="1"><div></div></td>'+
							'<td colspan="1" class="td6"><div></div></td>'+
							'<td colspan="3" class="td6"><div></div></td>'+
							'</tr>');
							jcxx.append(tr);
						}
					}else{
						var jbxx = $("#form_xfzx #jcqk");
						jbxx.children().eq(0).find("td").eq(0).attr("rowspan",4);
						for(var i=0;i<3;i++){
							var tr = $('<tr id="0" style="height:15px">'+
									'<td colspan="1"><div></div></td>'+
									'<td colspan="1" class="td6"><div></div></td>'+
									'<td colspan="3" class="td6"><div></div></td>'+
									'</tr>');
							jbxx.append(tr);
						}
					};
				}
		}));
		
      /////添加家庭及社会关系
      service.findtgqk("${param.id}",new Eht.Responder({
    		success:function(data){
    			
    			
    			  if(data.length>0){
					var tgqk = $("#form_xfzx #tgqk");
					tgqk.children().eq(0).find("td").eq(0).attr("rowspan",data.length+2);
					for(var i=0;i<data.length;i++){
						var d = data[i];
						
						var tr = $('<tr id='+i+1+'>'+
						'<td colspan="1"><div field="fxtgsj"></div></td>'+
						'<td colspan="1"><div  field="zzczqk"></div></td>'+
						'<td colspan="1" class="td6"><div field="czjg"></div></td>'+
						'<td colspan="2" class="td6"><div field="tqsjjyrq"></div></td>'+
						'</tr>');
						tgqk.append(tr);
						 var tgqkMsg = new Eht.View({selector:"#form_xfzx #"+i+1,
							fieldname:"field"});
						tgqkMsg.fill(d);  
					}
					 for(var i=0;i<1;i++){//加一行空行
						var tr = $('<tr id="1" style="height:10px">'+
						'<td colspan="1"><div></div></td>'+
						'<td colspan="1"><div></div></td>'+
						'<td colspan="1" class="td6"><div></div></td>'+
						'<td colspan="2" class="td6"><div></div></td>'+
						'</tr>');
						tgqk.append(tr);
					}  
			 	}else{
					var tgqk = $("#form_xfzx #tgqk");
					tgqk.children().eq(0).find("td").eq(0).attr("rowspan",4); 
						 for(var i=0;i<3;i++){ 
						var tr = $('<tr id="1" style="height:15px;">'+
								'<td colspan="1"><div></div></td>'+
								'<td colspan="1"><div></div></td>'+
								'<td colspan="1"><div></div></td>'+
								'<td colspan="2"><div></div></td>'+
								'</tr>');
						tgqk.append(tr);
					 }  
			 	};
    		} 
    			
    		
     	}))   
     
     
     
     
     });
</script>
</html>