<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员基本信息表</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/XfzxService.js"></script>
        <style>
	        #form_jbxx table{
	        	border-collapse:collapse;
	        	width: 100%;
	        }
	        #form_jbxx .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #form_jbxx td{
		        	text-align:center;
		        	width:70px;
	
		        #form_jbxx .td3 {
		        	width:80px;
		        }
	            #form_jbxx .td4 div{
		            height:150px;
	            }
	            #form_jbxx .td5 div{
		            height:200px;
	            }
	             #form_jbxx .td6{
					height:35px;	
	            }
	            #form_jbxx .td6 div {
					text-align:center;
					
	            }
	            #form_jbxx .head1 .head2 .head3{
	             	text-align:center;
	            }
	             
	            #form_jbxx .foot{
	              	margin:0 0 0 10px;
	            }
	            .tr_data{
	            	height:15px;
	            }
	         </style>
        
    </head>
    <body>
    <div id="form_jbxx">
	   
		<table border="1" cellspacing="0" id="table_view" align="center">
			
				<tr>
					<td class="td1">是否调查评估</td>
					<td field="sfdcpg" code="sys001"></td>
					
					<td class="td1">调查评估意见</td>
					<td field="dcpgyj" code="sys033"></td>
					
					<td class="td1">调查意见采信情况</td>
					<td><div field="dcyjcxqk" code="sys034"></div></td>
					<td rowspan="3" style="width:90px"><div>
					<img id="zp" style="width:90px;height:120px" src="${localCtx}/image/RMIImageService?_table_name=SYS_FACE_IMG&imgid=${param.id}&icon=per"  alt="一寸免冠照片">
					</div>
					</td>
				</tr>
				<tr>
					<td class="td1">矫正类别</td>
					<td><div field="jzlb" code="SYS017"></div></td>
					<td class="td1">是否成年</td>
					<td><div field="sfcn" code="SYS001"></div></td>
					<td class="td1">未成年</td>
					<td colspan="1"><div field="wcn" code="sys035"></div></td>
				</tr>
				<tr>
					<td class="td1">人员编号</td>
					<td colspan="5"><div field="sqjzrybh"></div></td>
				</tr>
				<tr>	
					<td class="td1">姓名</td>
					<td colspan="2"><div field="xm"></div></td>
					<td class="td1">曾用名</td>
					<td><div field="cym" ></div></td>
					<td>性别</td>
					<td><div field="xb" code="sys000"></div></td>
				</tr>
				<tr>
					<td class="td1">民族</td>
					<td><div field="mz" code="SYS003"></div></td>
					<td>身份证号</td>
					<td><div field="sfzh"></div></td>
					<td>出生日期</td>
					<td colspan="2"><div field="csrq"></div></td>
				</tr>
				<tr>
					<td class="td1">有无港澳台身份证</td>
					<td><div field="ywgatsfz" code="SYS102"></div></td>
					<td class="td1">港澳台身份证类型</td>
					<td><div field="gatsfzlx" code="SYS046"></div></td>
					<td class="td1">港澳台身份证号码</td>
					<td colspan="2"><div field="gatsfzhm" ></div></td>
				</tr>
				<tr>
					<td class="td1">有无护照</td>
					<td><div field="ywhz" code="SYS102"></div></td>
					<td class="td1">护照保存状态</td>
					<td><div field="hzbczt" code="sys045"></div></td>
					<td class="td1">护照号码</td>
					<td colspan="2"><div field="hzhm" ></div></td>
				</tr>
				<tr>
					<td class="td1">有无港澳台通行证</td>
					<td><div field="ywgattxz" code="SYS102"></div></td>
					<td class="td1">港澳台通行证类型</td>
					<td><div field="gattxzlx" code="SYS047"></div></td>
					<td class="td1">港澳台通行证号码</td>
					<td colspan="2"><div field="gattxzhm" ></div></td>
				</tr>
				<tr>
					<td class="td1">港澳台通行证保存状态</td>
					<td><div field="gattxzbczt" code="SYS045"></div></td>
					<td class="td1">有无港澳居民往来内地通行证</td>
					<td><div field="ywgajmwlndtxz" code="SYS102"></div></td>
					<td class="td1">港澳居民往来内地通行证号码</td>
					<td colspan="2"><div field="gajmwlndtxz" ></div></td>
				</tr>
				<tr>
					<td class="td1">港澳居民往来内地通行证保存状态</td>
					<td><div field="gajmwlndtxzbczt" code="SYS045"></div></td>
					<td class="td1">有无台胞证</td>
					<td><div field="ywtbz" code="SYS102"></div></td>
					<td class="td1">台胞证号码</td>
					<td colspan="2"><div field="tbzhm" ></div></td>
				</tr>
				<tr>
					<td class="td1">台胞证保存状态</td>
					<td><div field="tbzbczt" code="SYS045"></div></td>
					<td class="td1">暂予监外执行人员身体状况</td>
					<td><div field="zyjwzxrystzk" code="SYS036"></div></td>
					<td class="td1">就诊医院</td>
					<td colspan="2"><div field="zhjzyy" ></div></td>
				</tr>
				<tr>
					<td class="td1">是否有精神病</td>
					<td><div field="sfyjsb" code="SYS102"></div></td>
					<td class="td1">鉴定机构</td>
					<td colspan="4"><div field="jdjg" ></div></td>
				</tr>
				<tr>
					<td class="td1">是否有传染病</td>
					<td colspan="1"><div field="zhjzyy" ></div></td>
					<td class="td1">是否有精神病</td>
					<td><div field="sfyjsb" code="SYS102"></div></td>
					<td class="td1">具体传染病</td>
					<td colspan="2"><div field="jtcrb" code="sys037"></div></td>
				</tr>
				<tr>
					<td class="td1">文化程度</td>
					<td colspan="1"><div field="whcd" code="sys028" ></div></td>
					<td class="td1">婚姻状况</td>
					<td><div field="hyzk" code="SYS030"></div></td>
					<td class="td1">捕前职业</td>
					<td colspan="2"><div field="pqzy" code="sys098"></div></td>
				</tr>
				<tr>
					<td class="td1">现政治面貌</td>
					<td colspan="1"><div field="xzzmm" code="sys091" ></div></td>
					<td class="td1">原政治面貌</td>
					<td><div field="yzzmm" code="SYS091"></div></td>
					<td class="td1">就业就学情况</td>
					<td colspan="2"><div field="jyjxqk" code="sys031"></div></td>
				</tr>
				<tr>
					<td class="td1">个人联系电话(手机号)</td>
					<td colspan="1"><div field="grlxdh"></div></td>
					<td class="td1">现工作单位</td>
					<td><div field="xgzdw" ></div></td>
					<td class="td1">单位联系电话</td>
					<td colspan="2"><div field="dwlxdh" ></div></td>
				</tr>
				<tr>
					<td class="td1">国籍</td>
					<td colspan="1"><div field="gj" code="sys051" ></div></td>
					<td class="td1">是否三无人员</td>
					<td colspan="1"><div field="sfswry" code="sys102" ></div></td>
					<td class="td1">户籍地是否与居住地相同</td>
					<td colspan="2"><div field="hjdsfyjzdxt" code="SYS001"></div></td>
				</tr>
				<tr>
					<td class="td1">固定居住地明细</td>
					<td colspan="6"><div field="gdjzdmx"></div></td>
				</tr>
				<tr>
					<td class="td1">户籍所在地明细</td>
					<td colspan="6"><div field="hjszdmx" ></div></td>
				</tr>
			<tbody id="grjl">
				<tr style="height: 20px">
					<td class="td5" valign="middle">个人简历</td>
					<td colspan="2">起止时间</td>
					<td colspan="2">所在单位</td>
					<td colspan="2">职务</td>
				</tr>
			</tbody>
			<tbody id="shgx" >
				<tr style="height:10px">
					<td  class="td5" valign="middle">家庭成员及主要社会关系</td>
					<td colspan="1" >姓名</td>
					<td colspan="1" >关系</td>
					<td colspan="3" >工作单位或家庭住址</td>
					<td colspan="1" >联系电话</td>
				</tr>
			</tbody>
			
				<tr>
					<td rowspan="3"><div>备注</div></td>
					<td colspan="7" rowspan="3"><div field="remark" id="remark"></div></td>
				</tr>
			
		</table>
		</div>
    </body>
<script type="text/javascript">
     $(function(){
		var service = new XfzxService();
		var form_jbxx = new Eht.View({selector:"#form_jbxx",
			fieldname:"field"});
		service.findDaxx("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
			success:function(data){//个人基本信息
				form_jbxx.fill(data["daxx"]);
				
			}
		}));  
		
		//添加个人简历信息
		service.findAllJl("${param.id}",new Eht.Responder({
				success:function(data){
					if(data.length>0){//个人简历信息
						var grjl = $("#form_jbxx #grjl");
						grjl.children().eq(0).find("td").eq(0).attr("rowspan",data.length+2);
						for(var i=0;i<data.length;i++){
							var d = data[i];
							var tr = $('<tr id="0">'+
							'<td colspan="2"><div>'+d.qs+'起<br>'+d.zr+'止</div></td>'+
							'<td colspan="2" class="td6"><div>'+d.szdw+'</div></td>'+
							'<td colspan="2" class="td6"><div>'+d.zw+'</div></td>'+
							'</tr>');
							grjl.append(tr);
						}
						for(var i=0;i<1;i++){//加一行空行
							var d = data[i];
							var tr = $('<tr id="0" style="height:10px">'+
							'<td colspan="2"><div></div></td>'+
							'<td colspan="2" class="td6"><div></div></td>'+
							'<td colspan="2" class="td6"><div></div></td>'+
							'</tr>');
							grjl.append(tr);
						}
					}else{
						var grjl = $("#form_jbxx #grjl");
						grjl.children().eq(0).find("td").eq(0).attr("rowspan",5);
						for(var i=0;i<4;i++){
							var tr = $('<tr id="0" style="height:15px;">'+
									'<td colspan="2"><div></div></td>'+
									'<td colspan="2" class="td6"><div></div></td>'+
									'<td colspan="2" class="td6"><div></div></td>'+
									'</tr>');
							grjl.append(tr);
						}
					};
				}
		}));
     //添加家庭及社会关系
      service.findJtcyjshgx("${param.id}",new Eht.Responder({
    		success:function(data){
    			
    			
    			  if(data.length>0){
					var shgx = $("#form_jbxx #shgx");
					shgx.children().eq(0).find("td").eq(0).attr("rowspan",data.length+2);
					for(var i=0;i<data.length;i++){
						var d = data[i];
						console.log(d);
						var tr = $('<tr id='+i+1+'>'+
						'<td colspan="1"><div field="xm"></div></td>'+
						'<td colspan="1"><div code="SYS103" field="gx"></div></td>'+
						'<td colspan="3" class="td6"><div field="jtzz"></div></td>'+
						'<td colspan="1" class="td6"><div field="lxdh"></div></td>'+
						'</tr>');
						shgx.append(tr);
						 var shgxMsg = new Eht.View({selector:"#form_jbxx #"+i+1,
							fieldname:"field"});
						shgxMsg.fill(d);  
					}
					 for(var i=0;i<1;i++){//加一行空行
						var tr = $('<tr id="1" style="height:10px">'+
						'<td colspan="1"><div></div></td>'+
						'<td colspan="1"><div></div></td>'+
						'<td colspan="3" class="td6"><div></div></td>'+
						'<td colspan="1" class="td6"><div></div></td>'+
						'</tr>');
						shgx.append(tr);
					}  
			 	}else{
					var shgx = $("#form_jbxx #shgx");
					shgx.children().eq(0).find("td").eq(0).attr("rowspan",4); 
						 for(var i=0;i<3;i++){ 
						var tr = $('<tr id="1" style="height:15px;">'+
								'<td colspan="1"><div></div></td>'+
								'<td colspan="1"><div></div></td>'+
								'<td colspan="3"><div></div></td>'+
								'<td colspan="1"><div></div></td>'+
								'</tr>');
						shgx.append(tr);
					 }  
			 	};
    		} 
    			
    		
     	}))  
     
     
     
     
     });
</script>
</html>
