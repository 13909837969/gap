<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../comm-script.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${localCtx}/json/ParameterService.js"></script>
<script type="text/javascript" src="${localCtx}/json/SftsjjhService.js"></script>
<%-- <script type="text/javascript" src="${localCtx}/json/QtsjdrService.js"></script> --%>
<script type="text/javascript">
$(function(){
 //擎天数据导入
 //var QTService = new QtsjdrService();
 
 $("#QtdataImp").click(function(){
		$("#QtdataImp").attr("disabled",true);
	    var T="请等待";
	    $("#Qtdd").text(T);
	    var i=0;
	    var Qtdd = setInterval(function(){
	    	if(i >= 5 )T="请等待";
	    	$("#Qtdd").text(T);
	    	  T=T+".";
	    	  i++;
	    },500);
		/*
	    QTService.addDataImp(
				new Eht.Responder({
					success:function(){
						$("#QtdataImp").attr("disabled",false);
						clearInterval(Qtdd);
						$("#Qtdd").text("");
					}
		    })
		);
	    */
	});
 //民政系统数据导入
	var SfService = new SftsjjhService();
	$("#dataImp").click(function(){
		$("#dataImp").attr("disabled",true);
	    var T="请等待";
	    $("#dd").text(T);
	    var i=0;
	    var dd = setInterval(function(){
	    	if(i >= 5 )T="请等待";
	    	$("#dd").text(T);
	    	  T=T+".";
	    	  i++;
	    },500);
		
		SfService.addDataImp(
				new Eht.Responder({
					success:function(){
						$("#dataImp").attr("disabled",false);
						clearInterval(dd);
						$("#dd").text("");
					}
		    })
		);
	});
	
	initcode();
	//新建类
	var service = new ParameterService();
	//toolbar按钮
	var toolbar = new Eht.Toolbar({selector:"#toolbar",fixed:true});
	service.find( new Eht.Responder({
		success:function(list){
			for(var i=0;i<list.length;i++){
				if(list[i].enable=="1"){
					$("#form").find("input[key='"+list[i].id+"']:not(input[type='text'])").attr("checked",true);
				}
				if(list[i].value){
					$("#form").find("input[key='"+list[i].id+"'][type='text']").val(list[i].value);
					$("#form").find("input[key='"+list[i].id+"'][type='password']").val(list[i].value);
					$("#form").find("textarea[key='"+list[i].id+"']").val(list[i].value);
					var vvs = list[i].value;
					var vs=vvs.split(",");
					$("#form").find("input[grp='"+list[i].id+"']").each(function(){
						for(var n=0;n<vs.length;n++){
							if($(this).val()==vs[n]){
								this.checked =true;
								break;
							}
						}
					});
				}
			}
			groupController();
		}
	}));
	
	//点击保存时保存数据
	toolbar.click(function(id){
		switch(id){
			case"savebtn":
				toolbar.disable();
				var list=getFormData();
				service.save(list,new Eht.Responder({success:function(){
					toolbar.enable();
					new Eht.Tips().show();
				}}));
			break;
		}
	});
	function groupController(){
		$("#form").find("input[groupid]").each(function(){
			if($(this).attr("type")=="checkbox"){
				$(this).change(function(){
					var checked = this.checked;
					$("#form").find("input[groupid='"+$(this).attr("groupid")+"']").each(function(){
						checked = (checked==true || this.checked==true);
					});
					$("#"+$(this).attr("groupid")).find("input,select").attr("disabled",!checked);
					$("#form").find("input[groupid='"+$(this).attr("groupid")+"']").each(function(){
						$(this).enable();
					});
				});
				var checked = this.checked;
				$("#form").find("input[groupid='"+$(this).attr("groupid")+"']").each(function(){
					checked = (checked==true || this.checked==true);
				});
				$("#"+$(this).attr("groupid")).find("input,select").attr("disabled",!checked);
				$("#form").find("input[groupid='"+$(this).attr("groupid")+"']").each(function(){
					$(this).enable();
				});
			}
		});
	}
	function getFormData(){
		var data = new Array();
		var keyObj = {};
		$("#form").find("input[key],select[key],textarea[key]").each(function(){
			if(keyObj[$(this).attr("key")]){
				var o = keyObj[$(this).attr("key")];
				o.id = $(this).attr("key");
				o.desp = ($(this).attr("label")==undefined?o.desp:$(this).attr("label"));
				
				if($(this).attr("enable")!=null){
					o.enable = $(this).attr("enable");
				}
				
				if($(this).attr("type")!="checkbox" && $(this).attr("type")!="radio"){
					o[$(this).attr("name")] = $(this).val();
				}else{
					if($(this).is(":checked")){
						o.enable = $(this).val();
					}else{
						o.enable = "0";
					}
				}
			}else{
				var o = {};
				o.id = $(this).attr("key");
				o.desp = $(this).attr("label");
				
				if($(this).attr("enable")!=null){
					o.enable = $(this).attr("enable");
				}
				
				if($(this).attr("type")!="checkbox" && $(this).attr("type")!="radio"){
					o[$(this).attr("name")] = $(this).val();
				}else{
					if($(this).is(":checked")){
						o.enable = $(this).val();
					}else{
						o.enable = "0";
					}
				}
				keyObj[$(this).attr("key")] = o;
			}
		});
	    for(var p in keyObj){
	    	data.push(keyObj[p]);
	    }
	    return data;
	}
	
	function initcode(){
		$("#form").find("input[code][mult='true']").each(function(){
			var codestr = $(this).attr("code");
			if(codestr!=null){
				var ds = Eht.DataCode[codestr];
				for(var i=0;i<ds.length;i++){
					var cbox = $("<input type='checkbox' style='margin-left:5px;' value='"+ds[i].daaa02+"' grp='"+$(this).attr("key")+"'/>");
					var span = $("<span></span>");
					span.append(cbox);
					span.append("<span>"+ds[i].daaa03+"</span>");
					$(this).parent().append(span);
					cbox.data({"multinput":$(this)});
					cbox.change(function(){
						var cvalue= "";
						$("input[type='checkbox'][grp='"+$(this).attr("grp")+"']").each(function(){
							if(this.checked){
								cvalue += $(this).val()+",";
							}
						});
						if(cvalue.length>0){
							cvalue = cvalue.substring(0,cvalue.length-1);
						}
						cbox.data("multinput").val(cvalue);
					});
				}
				$(this).hide();
			}
		});
	}
	
});
</script>
<title>系统参数设置</title>
<style type="text/css">
#KEY_REFUND_005{
width:20px;
}
fieldset{
	width:700px;
}
.fieldset1{
	border:1px solid #aaa;
	margin:20px 10px;
	padding:10px;
}
.fieldset2{
	border:1px solid #aaa;
	display: inline;
	width:500px;
	margin-top:8px;
	margin-bottom:8px;
}
.hisconfig label{
   width:100px;
   display: inline-block;
}
fieldset div{
	padding:2px 0px !important;
}
</style>
</head>
<body>
	<div id="top">
		<div id="toolbar" style="vertical-align: middle;">
			<a id="savebtn" icon='eht-savebtn-icon'>保存</a>
		</div>
	</div>
	<div id="center">
		<div id="form">
			<fieldset class="fieldset1">
			 <legend>矫正人员客户端设置</legend>
			 <div>
			 	<div>
	       	        <label>轨迹采集频率设置（秒数)：
	       	        	<input id="KEY_SYSTEM_001" enable="1" type="text" name="value" key="KEY_SYSTEM_001" label="轨迹采集频率设置（秒数)" value="3" style="width:20px;"/>
	        		&nbsp;&nbsp;秒
	        		</label>
	        	</div>
	        	<div>
	       	        <label>定位位置误差范围(去重复点范围)：
	       	        	<input id="KEY_SYSTEM_004" enable="1" type="text" name="value" key="KEY_SYSTEM_004" label="定位位置误差范围(去重复点范围)" value="5" style="width:20px;"/>
	        			&nbsp;&nbsp;米
	        		</label>
	        	</div>
	        	<!-- 
	        	<div>
	        		<fieldset  class="fieldset2" >
	        			<legend>
	        		       <label>具备交互群的类型</label>
	        		     </legend>
	        			<div>
	        				<input type="text" label="具备交互群的类型" name="value" key="KEY_SYSTEM_005" style="width:60px;" code="csm001" mult="true"/>
	        			</div>
	        		</fieldset>
	        	</div>
	        	-->
			 </div>
			</fieldset>
			
			<fieldset class="fieldset1">
			 <legend>工作人员客户端设置</legend>
			 <div>
			 	<div>
	       	        <label>异常轨迹距离限制：
	       	        	<input id="KEY_SYSTEM_009" enable="1" type="text" name="value" key="KEY_SYSTEM_009" label="异常轨迹距离限制" value="30" style="width:70px;"/>
	        		&nbsp;&nbsp;米
	        		</label>
	        	</div>
			 </div>
			</fieldset>
			
		    <fieldset class="fieldset1">
		        <legend>服务器端参数设置</legend>
		        <div>
		        	<div>
		       	        <label>停留时间阀值设置（分钟）：
		       	        	<input id="KEY_SYSTEM_002" enable="1" type="text" name="value" key="KEY_SYSTEM_002" label="停留时间阀值设置（分钟）" value="10" style="width:40px;"/>
		        			&nbsp;&nbsp;分钟
		        		</label>
	        		</div>
		        	<div>
		       	        <label>停留范围半径（米）：
		       	        	<input id="KEY_SYSTEM_003" enable="1" type="text" name="value" key="KEY_SYSTEM_003" label="停留范围半径（米）" value="40" style="width:40px;"/>
		        			&nbsp;&nbsp;米
		        		</label>
	        		</div>
	        		<div>
		       	        <label>停留时间计算调度周期（秒）：
		       	        	<input id="KEY_SYSTEM_005" enable="1" type="text" name="value" key="KEY_SYSTEM_005" label="停留时间计算调度周期（秒）" value="600" style="width:40px;"/>
		        			&nbsp;&nbsp;秒
		        		</label>
	        		</div>
	        		<div>
		       	        <label>报警时间设置（分钟）（如关机多长时间报警）：
		       	        	<input id="KEY_SYSTEM_006" enable="1" type="text" name="value" key="KEY_SYSTEM_006" label="报警时间设置（分钟）（如关机多长时间报警）" value="10" style="width:40px;"/>
		        			&nbsp;&nbsp;分钟
		        		</label>
	        		</div>
	        		<div>
		       	        <label>
			       	        <input id="KEY_SYSTEM_007" type="checkbox" name="id"
		        		           key="KEY_SYSTEM_007" label="报到期限设置（天）" value="1" />
		       	        报到期限设置（天）：
		       	        	<input type="text" name="value" key="KEY_SYSTEM_007" label="报到期限设置（天）" value="7" style="width:40px;"/>
		        			&nbsp;&nbsp;天
		        		</label>
	        		</div>
	        		<hr style="border:1px solid #eee;height:0px;"/>
	        		<div>
		       	        <label>登记报到初始化推送信息：<br>
		       	        	<textarea id="KEY_SYSTEM_008" enable="1" 
		       	        	type="text" name="value" style="width:350px;height:60px;resize:none"
		       	        	key="KEY_SYSTEM_008" label="登记报到初始化推送信息"></textarea>
		        		</label>
	        		</div>
	        		
	        		<hr style="border:1px solid #eee;height:0px;"/>
	        		<div>
		       	        <label>初始化系统使用的省市编码信息：
		       	        	<input id="KEY_SYSTEM_017" enable="1" type="text" name="value" key="KEY_SYSTEM_017" label="省市编码信息" value="150000"/>
		        		</label>
	        		</div>
	        		
	        		<hr style="border:1px solid #eee;height:0px;"/>
	        		<div>
		       	        <label>轨迹查询最大间隔时间（天）：
		       	        	<input id="KEY_SYSTEM_018" enable="1" type="text" name="value" key="KEY_SYSTEM_018" label="轨迹查询最大间隔时间（天）" value="4"/>
		        		</label>
	        		</div>
		        </div>
		    </fieldset>
		    
		    <fieldset class="fieldset1">
			 <legend>网易云视频参数设置</legend>
			 <div>
			 	<div>
	       	        <label>网易视频云App Key：
	       	        	<input id="KEY_SYSTEM_014" enable="1" type="text" name="value" key="KEY_SYSTEM_014" label="网易视频云App Key" style="width:260px;" value="a312a929f038d2ddf7eff24d99c2235d"/>
	        		</label>
	        	</div>
	        	<div>
	       	        <label>网易视频云App Secret：
	       	        	<input id="KEY_SYSTEM_015" enable="1" type="text" name="value" key="KEY_SYSTEM_015" label="网易视频云App Secret" value="67bbb59fc6c1"/>
	        		</label>
	        	</div>
			 </div>
			</fieldset>
			
			  <fieldset class="fieldset1">
			  	 <legend>考核分数设置</legend>
			  	  <div>
			 	<div>
	       	        <label>考核分数：
	       	        	<input id="KEY_SYSTEM_016" enable="1" type="text" name="value" key="KEY_SYSTEM_016" label="考核分数" style="width:260px;" value="12"/>
	        		</label>
	        	</div>
			 </div>
			  </fieldset>
			  
			  <fieldset class="fieldset1">
			  	 <legend>外部系统数据导入</legend>
			  	 <div>
				 	<div>
		       	        <label>民政信息数据导入：
		       	        <input id="dataImp" class="btn btn-default" type="button" value="开始导入">
		       	        </label>
	                     <span id="dd"></span>
					</div>
			   </div>
			    <div>
				 	<div>
		       	        <label>法律援助信息数据导入：
		       	        <input id="QtdataImp" class="btn btn-default" type="button" value="开始导入">
		       	        </label>
	                     <span id="Qtdd"></span>
					</div>
			   </div>
			  </fieldset>
		 </div>
	</div>
	<br/>
</body>
</html>