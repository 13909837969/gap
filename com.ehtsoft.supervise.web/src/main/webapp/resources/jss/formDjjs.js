var callbackJzryjbxxImg=function(msg){
	new Eht.Tips().show(msg);
	var src = $("#jzryjbxx_photo").attr("osrc")+"&"+Math.random();
	$("#jzryjbxx_photo").attr("src",src);
	return false;
}; 

//上传照片
function validate_img(ele){
	      // 返回 KB，保留小数点后两位
	      //alert((ele.files[0].size/(1024*1024)).toFixed(2));
	     var file = ele.value;
	     var width;
	     var height;
	     if(!/.(jpg|jpeg|JPG)$/.test(file)){
	        new Eht.Alert().show("图片类型必须是.gif,jpeg,jpg,png,bmp中的一种");
	            return false;
	     }else{
	    	 var filePic = ele.files[0];  
	         var reader = new FileReader();  
	         reader.onload = function (e) {  
	             var data = e.target.result;  
	             //加载图片获取图片真实宽度和高度  
	             var image = new Image();  
	             image.onload=function(){  
	                 width = image.width;  
	                 height = image.height;
	                 if(width>295||height>413||(filePic.size).toFixed(2)>=102400){
	                	 
	                	 new Eht.Alert().show("请上传像素为295*413或者大小小于100KB的图片");
	                	 return false;
	                 }else{
	                	
	            	     $("#photo_remark").hide();
	            		 $("#jzryjbxxuploadForm").submit();
	                 }
	             };  
	             image.src= data;  
	         };  
	         reader.readAsDataURL(filePic);
	     }
}

$(function(){
	var djjs = new DjjsService();
	
	var region = new RegionService();//省市区后台
	var count = 0;
	var tabCnt = $("#form_dagl_tab").children().size();
	$("#form_dagl_tab").children().each(function(){
		$(this).load($(this).attr("load"),function(){
			count++;
			initJzryjbxxForm();
		});
	});
	var initJzryjbxxForm = function(){
		if(count!=tabCnt){
			return;
		}
		var id=$("#form_sqjzryjbxx_param_id").val();
		
		var jbxx = new Eht.Form({selector:"#sqjzryjbxx_form_jbxx"});
		var ws = new Eht.Form({selector:"#formSqjzryjbxx_ws"});
		var form=new Eht.Form({selector:"#form_clly",autolayout:true});
		var clqd=new Eht.Form({selector:"#clqd",autolayout:true});
		var clqd_2=new Eht.Form({selector:"#clqd_2",autolayout:true});
		
		
		//文书附件上传地址
		var uuid = Eht.Utils.createUuid();
		$("#listDcpg_wtsfj_uploadForm").attr("action","${localCtx}/upload/RMIImageService?_table_name=JZ_JZRYFLWS_IMG&id="+uuid+"&f_aid="+id);
		
		//修改信息
		if(id!=""){
			
			djjs.findDaxx(id,new Eht.Responder({
				success:function(data){
					jbxx.fill(data.daxx);
					ws.fill(data.daws);
					form.fill(data.daxx);
				}
			}));
			
		}
		 //模态框单击提交按钮提交数据到数据库 
		$("#dagl_list_btn_primary").unbind("click").bind("click",function() {//此按钮为父页-模态框【提交】按钮
			if(jbxx.validate()&&ws.validate()){	
						
						var grjldata = sqjzry_grjlForm.getGrjlData();
						var shgxdata = Sqjzry_jtcyjShgxForm.getJtcyData();
						
						
						djjs.saveDaxx(jbxx.getData(),ws.getData(),grjldata,shgxdata,new Eht.Responder({
							success : function() {
								$("#sqjz_listDjjs_all #dagl_listtable").refreshTable();
								$("#sqjz_listDjjs_all #myModalAdd").modal('hide');
								$(".modal-backdrop").remove();
								new Eht.Tips().show();
							}
						}));
						
			}	
						 
				
		});
		//-------------------------------------------填写逻辑-------------------------------------------------------------
		//
		$(".form_date").datetimepicker({
		       format: "yyyy-mm-dd",
		       autoclose: true,
		       todayBtn: true,
		       todayHighlight: true,
		       showMeridian: true,
		       pickerPosition: "bottom-left",
		       language: 'zh-CN',//中文，需要引用zh-CN.js包
		        startView: 2,//月视图
		        minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
		});
		
		 /* 单击指派机构输入框  弹出机构下拉选择框 */
	    
		 var json={};
		 djjs.findOrgid(json,new Eht.Responder({
				success:function(data){
					$("#jgmc").empty();
					$("#jgmc").append('<option selected="selected"></option>');
					for(var i=0;i<data.length;i++){
						$("#jgmc").append("<option value="+data[i].id+">"+data[i].jgmc+"</option>");
					}
				 $("#jgmc").comboSelect();
				}
		})); 
		//矫正类别
		 if($("input[name='jzlb']:checked").val()=='04'){
				$("#zyjw").css("display","table-row");
				$("#zhjzyy").css("display","table-row");
				$("#jw").attr("valid","{required:true}");
			}else{
				$("#zyjw").css("display","none");
				$("#zhjzyy").css("display","none");
				$("#jw").removeAttr("valid");
			}
		$("#formSimple-body #jzlb").change(function(){
			if($("input[name='jzlb']:checked").val()=='04'){
				$("#zyjw").css("display","table-row");
				$("#zhjzyy").css("display","table-row");
				$("#jw").attr("valid","{required:true}");
			}else{
				$("#zyjw").css("display","none");
				$("#zhjzyy").css("display","none");
				$("#jw").removeAttr("valid");
			}
		})
		$("#zyjwzxrystzk").change(function(){
			if($("input[name='zyjwzxrystzk']:checked").val()!="03"){
				$("#yy").removeAttr("valid");
				$("#yy").css("border","");
			}else{
				$("#yy").attr("valid","{required,true}");
			}
		})		//日期自动获取
		$("#formSimple-body #sfzh").change(function(){
			var csrq = $("#formSimple-body #sfzh").val().substring(6,14);
			var csrqyyyy = csrq.substring(0,4);
			var csrqMM = csrq.substring(4,6);
			var csrqdd = csrq.substring(6);
			$("#formSimple-body #csrq").val(csrqyyyy+"-"+csrqMM+"-"+csrqdd);
		})
		$("#sqjzryjbxx_form_jbxx #sqjzrybh").click(function(){
			if($("#sfcn input[name='sfcn']:checked").val()=='0'){
				$("#sqjzryjbxx_form_jbxx #xm").val($("#sqjzrybh").val());
			}
		})
		
		//是否成年
		if($("input[name='sfcn']:checked").val()=='0'){
			$("#formSimple-body #xm").attr("disabled",true);
			$("#formSimple-body #xm").val($("#sqjzrybh").val());
			$("#formSimple-body #sfzh").val("");
			$("#formSimple-body #sfzh").attr("disabled",true);
			$("#formSimple-body #sfzh").removeAttr("valid");
			$("#formSimple-body #sfzh").css("border","");
			$("#csrq").attr("class","form_date");
			$("#csrq").attr("disabled",false);
			$("#dzxx").hide();
			$("#grjl").css("display","none");
			$("#jtcy").css("display","none");
		
			$("#wcn input[name='wcn']").attr("disabled",false);
		}else{
			$("#wcn input[name='wcn']:checked").attr("checked",false);
			$("#formSimple-body #xm").attr("disabled",false);
			$("#formSimple-body #xm").val("");
			$("#formSimple-body #sfzh").attr("disabled",false);
			$("#formSimple-body #sfzh").attr("valid","{required:true,cardNo:true}");
			$("#csrq").attr("disabled",true);
			$("#csrq").css("border","");
			$("#dzxx").show();
			$("#grjl").css("display","block");
			$("#jtcy").css("display","block");
			$("#wcn input[name='wcn']").attr("disabled",true);
		}
		$("#formSimple-body #sfcn").change(function(){
			if($("input[name='sfcn']:checked").val()=='0'){
				$("#formSimple-body #xm").attr("disabled",true);
				$("#formSimple-body #xm").val($("#sqjzrybh").val());
				$("#formSimple-body #sfzh").val("");
				$("#formSimple-body #sfzh").attr("disabled",true);
				$("#formSimple-body #sfzh").removeAttr("valid");
				$("#formSimple-body #sfzh").css("border","");
				$("#csrq").attr("class","form_date");
				$("#csrq").attr("disabled",false);
				$("#dzxx").hide();
				$("#grjl").css("display","none");
				$("#jtcy").css("display","none");
			
				$("#wcn input[name='wcn']").attr("disabled",false);
			}else{
				$("#wcn input[name='wcn']:checked").attr("checked",false);
				$("#formSimple-body #xm").attr("disabled",false);
				$("#formSimple-body #xm").val("");
				$("#formSimple-body #sfzh").attr("disabled",false);
				$("#formSimple-body #sfzh").attr("valid","{required:true,cardNo:true}");
				$("#csrq").attr("disabled",true);
				$("#csrq").css("border","");
				$("#dzxx").show();
				$("#grjl").css("display","block");
				$("#jtcy").css("display","block");
				$("#wcn input[name='wcn']").attr("disabled",true);
			}
			
		});
		
		//民族
		$("#formSimple-body #mz").change(function(){
			if($("input[name='mz']:checked").val()=='其他'){
				
			}
		})
		
		//身份判断
		if($("#ywgatsfz input[name='ywgatsfz']:checked").val()=='1'){
			$("#gatsfzlx input[name='gatsfzlx']").attr("disabled",false);
			$("#gatsfzhm").attr("disabled",false);
		}else{
			$("#gatsfzhm").val("");
			$("#gatsfzhm").css("border","");
//		
			jbxx.disable("gatsfzlx");
			jbxx.disable("gatsfzhm");
		}
		$("#formSimple-body #ywgatsfz").change(function(){
			if($("#ywgatsfz input[name='ywgatsfz']:checked").val()=='1'){
				$("#gatsfzlx input[name='gatsfzlx']").attr("disabled",false);
				$("#gatsfzhm").attr("disabled",false);
			}else{
				$("#gatsfzhm").val("");
				$("#gatsfzhm").css("border","");
				$("#gatsfzlx input[name='gatsfzlx']:checked").attr("checked",false);
				$("#gatsfzlx input[name='gatsfzlx']").attr("disabled",true);
				$("#gatsfzhm").attr("disabled",true);
			}
		})
		
		if($("input[name='ywhz']:checked").val()=='1'){
			$("#hzbczt select[name='hzbczt']").attr("disabled",false);
			$("#hzhm").attr("disabled",false);
		}else{
			$("#hzhm").val("");
			$("#hzhm").css("border","");
			$("#hzbczt select[name='hzbczt']:selected").attr("selected",false);
			$("#hzbczt select[name='hzbczt']").append('<option selected></option>');
			$("#hzbczt select[name='hzbczt']").attr("disabled",true);
			$("#hzhm").attr("disabled",true);
		}
		$("#formSimple-body #ywhz").change(function(){
			debugger;
			if(jbxx.getValue('ywhz')=='1'){
//			
				jbxx.enable("hzbczt");
				jbxx.enable("hzhm");
				debugger;
				jbxx.attr("hzhm","valid","{required:true}");
			}else{
				jbxx.attr("hzhm","valid",null);
//			
				jbxx.disable("hzbczt");
				jbxx.setValue("hzbczt","");
//				$("#hzhm").attr("disabled",true);
				jbxx.disable("hzhm");
				jbxx.setValue("hzhm");
			}
		})
		if($("input[name='ywgattxz']:checked").val()=='1'){
			$("#gattxzlx input[name='gattxzlx']").attr("disabled",false);
			$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",false);
			$("#gattxzhm").attr("disabled",false);
		}else{
			$("#gattxzhm").val("");
			$("#gattxzhm").css("border","");
			$("#gattxzlx input[name='gattxzlx']:checked").attr("checked",false);
			$("#gattxzlx input[name='gattxzlx']").attr("disabled",true);
			$("#gattxzbczt select[name='gattxzbczt']:selected").attr("selected",false);
			$("#gattxzbczt select[name='gattxzbczt']").append('<option selected></option>');
			$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",true);
			$("#gattxzhm").attr("disabled",true);
		}
		$("#formSimple-body #ywgattxz").change(function(){
			if($("input[name='ywgattxz']:checked").val()=='1'){
				$("#gattxzlx input[name='gattxzlx']").attr("disabled",false);
				$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",false);
				$("#gattxzhm").attr("disabled",false);
			}else{
				$("#gattxzhm").val("");
				$("#gattxzhm").css("border","");
				$("#gattxzlx input[name='gattxzlx']:checked").attr("checked",false);
				$("#gattxzlx input[name='gattxzlx']").attr("disabled",true);
				$("#gattxzbczt select[name='gattxzbczt']:selected").attr("selected",false);
				$("#gattxzbczt select[name='gattxzbczt']").append('<option selected></option>');
				$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",true);
				$("#gattxzhm").attr("disabled",true);
			}
		})
		if($("input[name='ywgajmwlndtxz']:checked").val()=='1'){
			$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",false);
			$("#gajmwlndtxz").attr("disabled",false);
		}else{
			$("#gajmwlndtxz").val("");
			$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']:selected").attr("selected",false);
			$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").append('<option selected></option>');
			$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",true);
			$("#gajmwlndtxz").attr("disabled",true);
		}
		$("#formSimple-body #ywgajmwlndtxz").change(function(){
			if($("input[name='ywgajmwlndtxz']:checked").val()=='1'){
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",false);
				$("#gajmwlndtxz").attr("disabled",false);
			}else{
				$("#gajmwlndtxz").val("");
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']:selected").attr("selected",false);
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").append('<option selected></option>');
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",true);
				$("#gajmwlndtxz").attr("disabled",true);
			}
		})
		if($("input[name='ywtbz']:checked").val()=='1'){
			$("#tbzbczt select[name='tbzbczt']").attr("disabled",false);
			$("#tbzhm").attr("disabled",false);
		}else{
			$("#tbzhm").val("");
			$("#tbzhm").css("border","");
			$("#tbzbczt select[name='tbzbczt']:selected").attr("selected",false);
			$("#tbzbczt select[name='tbzbczt']").append('<option selected></option>');
			$("#tbzbczt select[name='tbzbczt']").attr("disabled",true);
			$("#tbzhm").attr("disabled",true);
		}
		$("#formSimple-body #ywtbz").change(function(){
			if($("input[name='ywtbz']:checked").val()=='1'){
				$("#tbzbczt select[name='tbzbczt']").attr("disabled",false);
				$("#tbzhm").attr("disabled",false);
			}else{
				$("#tbzhm").val("");
				$("#tbzhm").css("border","");
				$("#tbzbczt select[name='tbzbczt']:selected").attr("selected",false);
				$("#tbzbczt select[name='tbzbczt']").append('<option selected></option>');
				$("#tbzbczt select[name='tbzbczt']").attr("disabled",true);
				$("#tbzhm").attr("disabled",true);
			}
		})
		
		
		
		//健康信息
		if($("input[name='zyjwzxrystzk']:checked").val()=='01'||$("input[name='zyjwzxrystzk']:checked").val()=='02'){
			$("#yy").attr("valid","{required:true}");
		}else{
			$("#yy").removeAttr("valid");
		}
		$("#formSimple-body #zyjwzxrystzk").change(function(){
			debugger;
			if($("input[name='zyjwzxrystzk']:checked").val()=='01'||$("input[name='zyjwzxrystzk']:checked").val()=='02'){
				$("#yy").attr("valid","{required:true}");
				debugger;
			}else{
				$("#yy").removeAttr("valid");
			}
		})
		if($("input[name='sfyjsb']:checked").val()=='1'){
			$("#jdjg").attr("disabled",false);
		}else{
			$("#jdjg").attr("disabled",true);
			$("#jdjg").val("");
			$("#jdjg").css("border","");
		}
		$("#formSimple-body #sfyjsb").change(function(){
			if($("input[name='sfyjsb']:checked").val()=='1'){
				$("#jdjg").attr("disabled",false);
			}else{
				$("#jdjg").attr("disabled",true);
				$("#jdjg").val("");
				$("#jdjg").css("border","");
			}
			
		})
		if($("input[name='sfycrb']:checked").val()=='1'){
			$("#jtcrb select[name='jtcrb']").attr("disabled",false);
		}else{
			$("#jtcrb select[name='jtcrb']:selected").attr("selected",false);
			$("#jtcrb select[name='jtcrb']").append('<option selected></option>');
			$("#jtcrb select[name='jtcrb']").attr("disabled",true);
		}
		$("#formSimple-body #sfycrb").change(function(){
			if($("input[name='sfycrb']:checked").val()=='1'){
				$("#jtcrb select[name='jtcrb']").attr("disabled",false);
			}else{
				$("#jtcrb select[name='jtcrb']:selected").attr("selected",false);
				$("#jtcrb select[name='jtcrb']").append('<option selected></option>');
				$("#jtcrb select[name='jtcrb']").attr("disabled",true);
			}
			
		})
	
		/* 省区联动  */
		
			region.find(1,null,new Eht.Responder({//省份初始化
				success:function(data){
					for (var i = 0; i < data.length; i++) {
						$("#gdjzdszs").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						$("#hjszs").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
					$("#gdjzdszs").change();
					$("#hjszs").change();
				}
			})); 
		
	jbxx.change(function(name,value,combo,parent){
		if(name == "gdjzdszds"){//固定住址区
			region.find(null,value,new Eht.Responder({
				success:function(data){
					$("#gdjzdszxq").empty();
					for (var i = 0; i < data.length; i++) {
						$("#gdjzdszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
				}
			}));
		}else if(name == "hjszs"){//户籍所在地市
			region.find(null,value,new Eht.Responder({
				success:function(data){
					$("#hjszds").empty();
					var v = $("#hjszds").attr("currentValue");
					for (var i = 0; i < data.length; i++) {
						if(v == data[i].regionid){
							$("#hjszds").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
						}else{
							$("#hjszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}
					$("#hjszds").change();
				}
			}));
		}else if(name == "hjszds"){//户籍所在地区
			region.find(null,value,new Eht.Responder({
				success:function(data){
					$("#hjszxq").empty();
					var v = $("#hjszxq").attr("currentValue");
					for (var i = 0; i < data.length; i++) {
						if(v == data[i].regionid){
							$("#hjszxq").append('<option value="'+data[i].regionid+'" selected>'+data[i].region_name+'</option>');
						}else{
							$("#hjszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					
						}
					}
				}
			}));
		}else if(name == "gdjzdszs"){//固定住址市
			region.find(null,value,new Eht.Responder({
				success:function(data){
					$("#gdjzdszds").empty();
					for (var i = 0; i < data.length; i++) {
						$("#gdjzdszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
					$("#gdjzdszds").change();
				}
			}));
		}else if("isSame"==name){
			if(combo.get(0).checked){
				jbxx.setValue("hjszs",jbxx.getValue("gdjzdszs"),true);
				jbxx.setValue("hjszds",jbxx.getValue("gdjzdszds"));
				jbxx.setValue("hjszxq",jbxx.getValue("gdjzdszxq"));
				jbxx.setValue("hjszdmx",jbxx.getValue("gdjzdmx"));
			}
		}
		});
	}
});
