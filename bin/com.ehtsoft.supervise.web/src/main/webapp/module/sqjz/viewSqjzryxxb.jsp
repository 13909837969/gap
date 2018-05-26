<%@ page language="java" contentType="text/html; charset=UTF-8"  	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>社区服刑人员基本信息表</title>
        <jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
        <style>
	        #sqjz_formsqjzryxxb_body table{
	        	border-collapse:collapse;
	        }
	        #sqjz_formsqjzryxxb_body .all div{
	             	width:600px;
	             	display: inline;
	             	margin: 10px;
	             }
		        #sqjz_formsqjzryxxb_body td{
		        	text-align:center;
		        	width:70px;
	
		        #sqjz_formsqjzryxxb_body .td3 {
		        	width:80px;
		        }
	            #sqjz_formsqjzryxxb_body .td4 div{
		            height:150px;
	            }
	            #sqjz_formsqjzryxxb_body .td5 div{
		            height:200px;
	            }
	             #sqjz_formsqjzryxxb_body .td6{
					height:35px;	
	            }
	            #sqjz_formsqjzryxxb_body .td6 div {
					height:35px;
					line-height:35px;   
					text-align:center;
					
	            }
	            #sqjz_formsqjzryxxb_body .head1 .head2 .head3{
	             	text-align:center;
	            }
	             
	            #sqjz_formsqjzryxxb_body .foot{
	              	margin:0 0 0 10px;
	            }
	         </style>
        
    </head>
    <body>
    <div id="sqjz_formsqjzryxxb_body">
	    <div class="all" id="jbxx">
	    	<div class="head1" style="margin-left: 10px">单位:<span field="jzjg"></span></div>
	    	<div class="head2" style="margin-left: 120px">编号:<span field="sqjzrybh" code=""></span></div>
	    </div>
		<table border="1" cellspacing="0" id="table" align="center">
			<tbody id="jbxx">
				<tr>
					<td class="td1"><div >姓名</div></td>
					<td field="xm"></td>
					<td class="td1"><div>曾用名</div></td>
					<td field="cym"><div></div></td>
					<td class="td1"><div>身份证</div>号码</td>
					<td colspan="3"><div field="sfzh"></div></td>
					<td rowspan="3" style="width:90px"><div><img id="zp" style="width:90px;height:120px"  alt="一寸免冠照片"></div></td>
				</tr>
				<tr>
					<td class="td1"><div>性别</div></td>
					<td><div field="xb" code="SYS089"></div></td>
					<td class="td1"><div>民族</div></td>
					<td><div field="mz" code="SYS003"></div></td>
					<td class="td1"><div>出生年月日</div></td>
					<td colspan="3"><div field="csrq"></div></td>
				</tr>
				<tr>
					<td class="td1"><div>文化<br>程度</div></td>
					<td><div field="whcd" code="SYS028"></div></td>
					<td class="td1"><div>健康状况</div></td>
					<td><div field="jkzk"></div></td>
					<td class="td1"><div>原政治面貌</div></td>
					<td><div field="yzzmm" code="SYS091"></div></td>
					<td class="td1"><div>婚姻状况</div></td>
					<td><div field="hyzk" code="SYS030"></div></td>
				</tr>
				<tr>
					<td class="td2" colspan="2"><div>居住地</div></td>
					<td colspan="7"><div field="gdjzdmx"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td2"><div>户籍地</div></td>
					<td colspan="7"><div field="hjszdmx"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td2"><div>所在工作单位</br>(学校)</div></td>
					<td colspan="4"><div field="xgzdw"></div></td>
					<td colspan="2"><div>联系电话</div></td>
					<td><div field="dwlxdh"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td2"><div>个人联系电话</div></td>
					<td colspan="7"><div field="grlxdh"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td3"><div>罪名</div></td>
					<td><div field="jtzm"></div></td>
					<td><div>刑种</div></td>
					<td><div field="fzlx" code="SYS014"></div></td>
					<td><div>原判刑期</div></td>
					<td colspan="3"><div field="ypxq"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td3"><div>社区矫正</br>决定机关</div></td>
					<td colspan="3"><div field="sqjzjdjg" code="SYS055"></div></td>
					<td><div>原羁押场所</div></td>
					<td colspan="3"><div field="yjycs"></div></td>
				</tr>
			</tbody>
			<tbody id="jzl">
					<tr>
						<td colspan="2" class="td3"><div>禁止令</br>内容</div></td>
						<td colspan="3"><div field="jzlnr"></div></td>
						<td><div>禁止期限起止日</div></td>
						<td colspan="3"><div><span field="jzqxksrq"></span>(起)<br><span field="jzqxjsrq"></span>(止)</div></td>
					</tr>
			</tbody>
			<tbody id="jbxx">
				<tr>
					<td colspan="2" class="td3"><div>矫正</br>类别</div></td>
					<td colspan="2"><div field="jzlb" code="SYS017"></div></td>
					<td><div>矫正期限</div></td>
					<td><div field="sqjzqx"></div></td>
					<td><div>起止日</div></td>
					<td colspan="2"><div><span field="sqjzksrq"></span>(起)<br><span field="sqjzjsrq"></span>(止)</div></td>
				</tr>
				<tr>
					<td colspan="2" class="td3"><div>法律文书</br>收到时间</br>及种类</div></td>
					<td colspan="4"><div><span field="flwszl" code="SYS102"></span></div><div style="text-align:right;margin-bottom:-5px; margin-right:5px;"><span field="flwssdsj"></span></div></td>
					<td><div>接收方</br>式及报</br></div>到时间</td>
					<td colspan="2"><div><span field="sqjzryjsfs" code="SYS015"></span></div><div style="text-align:right;margin-bottom:-5px; margin-right:5px;"><span field="sqjzryjsrq"></span></div></td>
				</tr>
				<tr><!-- 根据个人基本信息表内的【报道情况】字段进行判断并在相应div内填：是 -->
					<td colspan="2" class="td3"><div>在规定时</br>限内报到</div></td>
					<td><div id="zgdsxnbd"></div></td>
					<td><div>超出规定</br>时限报到</div></td>
					<td><div id="ccgdsxbd"></div></td>
					<td><div>未报到且</br>下落不明</div></td>
					<td colspan="3"><div id="wbdqxlbm"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td4" valign="middle">主要犯</br>罪事实</td>
					<td colspan="7"><div field="zyfzss"></div></td>
				</tr>
				<tr>
					<td colspan="2" class="td4" valign="middle">本次犯</br>罪前的</br>违法犯</br>罪记录</td>
					<td colspan="7"><div field="bcfzqdwffzjl"></div></td>
				</tr>
			</tbody>
			<tbody id="grjl">
				<tr>
					<td colspan="2" class="td5" valign="middle">个<br>人<br>简<br>历</td>
					<td colspan="2"><div>起止时间</div></td>
					<td colspan="3"><div>所在单位</div></td>
					<td colspan="2"><div>职务</div></td>
				</tr>
			</tbody>
			<tbody id="shgx">
				<tr>
					<td colspan="2" class="td5" valign="middle">家庭成员</br>及主要社</br>会关系</td>
					<td><div>姓名</div></td>
					<td><div>关系</div></td>
					<td colspan="3"><div>工作单位或家庭住址</div></td>
					<td colspan="2"><div>联系电话</div></td>
				</tr>
			</tbody>
			<tr>
				<td colspan="2" rowspan="3"><div>备注</div></td>
				<td colspan="7" rowspan="3"><div field="remark"></div></td>
			</tr>
		</table>
		<span class="foot">注:此表抄报居住地公安(分)局。</span>
		</div>
    </body>
<script type="text/javascript">
     $(function(){
		var service = new JzJzryjbxxService();
		var view = "";
		service.findOne("${param.id}",new Eht.Responder({//根据ID查询个人基本信息
			success:function(data){
				view = new Eht.View({selector:"#sqjz_formsqjzryxxb_body #jbxx",fieldname:"field",valueCodeField:"f_code"});
				view.fill(data);//个人基本信息
				//照片信息
				$("#sqjz_formsqjzryxxb_body #zp").attr("src","${localCtx}/image/RMIImageService?_table_name=im_userinfo_IMG&imgid="+data.id);
				if(data.bdqk == "01"){//在规定时限内报到
					$("#sqjz_formsqjzryxxb_body #zgdsxnbd").text("是");
				}
				if(data.bdpk == "02"){//超出规定时限报到
					$("#sqjz_formsqjzryxxb_body #ccgdsxbd").text("是");
				}
				if(data.bdqk == "03"){//未报到且下落不明
					$("#sqjz_formsqjzryxxb_body #wbdqxlbm").text("是");
				}
				//禁止令信息
				if(data.jzl.length > 0){
					view = new Eht.View({selector:"#sqjz_formsqjzryxxb_body #jzl",fieldname:"field",valueCodeField:"f_code"});
					view.fill(data.jzl[0]);
				}
				if(data.grjl.length>0){//个人简历信息
					var grjl = $("#sqjz_formsqjzryxxb_body #grjl");
					grjl.children().eq(0).find("td").eq(0).attr("rowspan",data.grjl.length+2);
					for(var i=0;i<data.grjl.length;i++){
						var d = data.grjl[i];
						var tr = $('<tr id="0">'+
						'<td colspan="2"><div>'+d.qs+'起<br>'+d.zr+'止</div></td>'+
						'<td colspan="3" class="td6"><div>'+d.szdw+'</div></td>'+
						'<td colspan="2" class="td6"><div>'+d.zw+'</div></td>'+
						'</tr>');
						grjl.append(tr);
					}
					for(var i=0;i<1;i++){//加一行空行
						var d = data.grjl[i];
						var tr = $('<tr id="0">'+
						'<td colspan="2"><div></div></td>'+
						'<td colspan="3" class="td6"><div></div></td>'+
						'<td colspan="2" class="td6"><div></div></td>'+
						'</tr>');
						grjl.append(tr);
					}
				}else{
					var grjl = $("#sqjz_formsqjzryxxb_body #grjl");
					grjl.children().eq(0).find("td").eq(0).attr("rowspan",5);
					for(var i=0;i<4;i++){
						var tr = $('<tr id="0">'+
								'<td colspan="2"><div></div></td>'+
								'<td colspan="3" class="td6"><div></div></td>'+
								'<td colspan="2" class="td6"><div></div></td>'+
								'</tr>');
						grjl.append(tr);
					}
				};
				if(data.shgx.length>0){//社会关系信息
					var shgx = $("#sqjz_formsqjzryxxb_body #shgx");
					shgx.children().eq(0).find("td").eq(0).attr("rowspan",data.shgx.length+2);
					for(var i=0;i<data.shgx.length;i++){
						var d = data.shgx[i];
						var tr = $('<tr id="0">'+
						'<td><div>'+d.xm+'</div></td>'+
						'<td><div>'+d.gx+'</div></td>'+
						'<td colspan="3" class="td6"><div>'+d.szdw+d.jtzz+'</div></td>'+
						'<td colspan="2" class="td6"><div>'+d.lxdh+'</div></td>'+
						'</tr>');
						shgx.append(tr);
					}
					for(var i=0;i<1;i++){//加一行空行
						var d = data.shgx[i];
						var tr = $('<tr id="0">'+
						'<td><div></div></td>'+
						'<td><div></div></td>'+
						'<td colspan="3" class="td6"><div></div></td>'+
						'<td colspan="2" class="td6"><div></div></td>'+
						'</tr>');
						shgx.append(tr);
					}
					
				}else{
					var shgx = $("#sqjz_formsqjzryxxb_body #shgx");
					shgx.children().eq(0).find("td").eq(0).attr("rowspan",5);
					for(var i=0;i<3;i++){
						var tr = $('<tr id="0">'+
								'<td><div></div></td>'+
								'<td><div></div></td>'+
								'<td colspan="3" class="td6"><div></div></td>'+
								'<td colspan="2" class="td6"><div></div></td>'+
								'</tr>');
						shgx.append(tr);
					}
				};
			}
		})); 
     });
</script>
</html>
