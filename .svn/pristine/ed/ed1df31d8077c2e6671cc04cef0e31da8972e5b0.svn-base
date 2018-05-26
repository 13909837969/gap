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
	          //alert((ele.files[0].size).toFixed(2));
	         //返回Byte(B),保留小数点后两位
}

$(function(){
	var dagl = new DaglService();
	var dagl_xfzx = new XfzxService();
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
		var jbxx = new Eht.Form({selector:"#formSqjzryjbxx_jbxx"});
		var ws = new Eht.Form({selector:"#formSqjzryjbxx_ws"});
		var xfzx = new Eht.Form({selector:"#sqjzryxfzx_form_jbxx"});
		var jcjz=  new Eht.Form({selector:"#sqjzryxfzx_form_jzjc"});
		var form=new Eht.Form({selector:"#form_clly",autolayout:true});
		var clqd=new Eht.Form({selector:"#clqd",autolayout:true});
		var clqd_2=new Eht.Form({selector:"#clqd_2",autolayout:true});
		
		//文书附件上传地址
		var uuid = Eht.Utils.createUuid();
		$("#listDcpg_wtsfj_uploadForm").attr("action","${localCtx}/upload/RMIImageService?_table_name=JZ_JZRYFLWS_IMG&id="+uuid+"&f_aid="+id);
		
		//修改信息
		if(id!=""){
			
			dagl.findDaxx(id,new Eht.Responder({
				success:function(data){
					jbxx.fill(data.daxx);
					ws.fill(data.daws);
				}
			}));
			
		}
		 //模态框单击提交按钮提交数据到数据库 
		$("#dagl_list_btn_primary").unbind("click").bind("click",function() {//此按钮为父页-模态框【提交】按钮
				
						
						var grjldata = sqjzry_grjlForm.getGrjlData();
						var shgxdata = Sqjzry_jtcyjShgxForm.getJtcyData();
						
						
						
						dagl.saveDaxx(jbxx.getData(),ws.getData(),grjldata,shgxdata, new Eht.Responder({
							success : function() {
								$("#sqjz_listDagl_all #dagl_listtable").refreshTable();
								
								$("#Sqjz_bddj #listBddj_tableView").refreshTable();
								$("#sqjz_listDagl_all #myModalAdd").modal('hide');
								new Eht.Tips().show();
								
							}
						}));
						
					
						 
				
		});
		//-------------------------------------------填写逻辑-------------------------------------------------------------
		//
		$("#formSqjzryjbxx_ws .form_date").datetimepicker({
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
		
		$("#formSimple-body #jzlb").change(function(){
			if($("input[name='jzlb']:checked").val()=='04'){
				$("#zyjw").css("display","table-row");
			}else{
				$("#zyjw").css("display","none");
			}
		})
		
		
		
		
		//日期自动获取
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
		$("#formSimple-body #sfcn").change(function(){
			
				if($("input[name='sfcn']:checked").val()=='0'){
					$("#formSimple-body #xm").attr("disabled",true);
					$("#formSimple-body #xm").val($("#sqjzrybh").val());
					$("#formSimple-body #sfzh").attr("disabled",true);
					$("#formSimple-body #gdjzdmx").attr("disabled",true);
					$("#formSimple-body #gdjzdmx").attr("disabled",true);
					$("#grjl").attr("href","javascript:return false");
					$("#grjl").css("opacity",0.2);
					$("#jtcy").attr("href","javascript:return false");
					$("#jtcy").css("opacity",0.2);
					$("#wcn input[name='wcn']").attr("disabled",false);
				}else{
					$("#wcn input[name='wcn']:checked").attr("checked",false);
					$("#formSimple-body #xm").attr("disabled",false);
					$("#formSimple-body #xm").val("");
					$("#formSimple-body #sfzh").attr("disabled",false);
					$("#formSimple-body #gdjzdmx").attr("disabled",false);
					$("#formSimple-body #gdjzdmx").attr("disabled",false);
					$("#grjl").attr("href","#formSqjzryjbxx_Grjl");
					$("#grjl").css("opacity","");
					$("#jtcy").attr("href","#formSqjzryjbxx_JtcyjShgx");
					$("#jtcy").css("opacity","");
					$("#wcn input[name='wcn']").attr("disabled",true);
				}
			
		});
		
		//民族
		$("#formSimple-body #mz").change(function(){
			if($("input[name='mz']:checked").val()=='其他'){
				
			}
		})
		
		//身份判断
		$("#formSimple-body #ywgatsfz").change(function(){
			if($("#ywgatsfz input[name='ywgatsfz']:checked").val()=='1'){
				$("#gatsfzlx input[name='gatsfzlx']").attr("disabled",false);
				$("#gatsfzhm").attr("disabled",false);
			}else{
				$("#gatsfzlx input[name='gatsfzlx']").attr("disabled",true);
				$("#gatsfzhm").attr("disabled",true);
			}
		})
		
		$("#formSimple-body #ywhz").change(function(){
			if($("input[name='ywhz']:checked").val()=='1'){
				$("#hzbczt select[name='hzbczt']").attr("disabled",false);
				$("#hzhm").attr("disabled",false);
			}else{
				$("#hzbczt select[name='hzbczt']").attr("disabled",true);
				$("#hzhm").attr("disabled",true);
			}
		})
		
		$("#formSimple-body #ywgattxz").change(function(){
			if($("input[name='ywgattxz']:checked").val()=='1'){
				$("#gattxzlx input[name='gattxzlx']").attr("disabled",false);
				$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",false);
				$("#gattxzhm").attr("disabled",false);
			}else{
				$("#gattxzlx input[name='gattxzlx']").attr("disabled",true);
				$("#gattxzbczt select[name='gattxzbczt']").attr("disabled",true);
				$("#gattxzhm").attr("disabled",true);
			}
		})
		
		$("#formSimple-body #ywgajmwlndtxz").change(function(){
			if($("input[name='ywgajmwlndtxz']:checked").val()=='1'){
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",false);
				$("#gajmwlndtxz").attr("disabled",false);
			}else{
				$("#gajmwlndtxzbczt select[name='gajmwlndtxzbczt']").attr("disabled",true);
				$("#gajmwlndtxz").attr("disabled",true);
			}
		})
		
		$("#formSimple-body #ywtbz").change(function(){
			if($("input[name='ywtbz']:checked").val()=='1'){
				$("#tbzbczt select[name='tbzbczt']").attr("disabled",false);
				$("#tbzhm").attr("disabled",false);
			}else{
				$("#tbzbczt select[name='tbzbczt']").attr("disabled",true);
				$("#tbzhm").attr("disabled",true);
			}
		})
		
		//健康信息
		$("#formSimple-body #zyjwzxrystzk").change(function(){
			if($("input[name='zyjwzxrystzk']:checked").val()=='01'|| $("input[name='zyjwzxrystzk']:checked").val()=='02'){
				//就诊医院必填
			}else{
				
			}
			
		})
		
		$("#formSimple-body #sfyjsb").change(function(){
			if($("input[name='sfyjsb']:checked").val()=='1'){
				$("#jdjg").attr("disabled",false);
			}else{
				$("#jdjg").attr("disabled",true);
			}
			
		})
		
		$("#formSimple-body #sfycrb").change(function(){
			if($("input[name='sfycrb']:checked").val()=='1'){
				$("#jtcrb select[name='jtcrb']").attr("disabled",false);
			}else{
				$("#jtcrb select[name='jtcrb']").attr("disabled",true);
			}
			
		})
	/*	
		jbxx.loadSelectData("gdjzdszs",{valueField:"regionid",labelField:"region_name"},function(res){
			alert("OK")
			region.find(1,value,res);
		});*/
		//地址判断
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
	$("#gdjzdszs").change(function(){
		
		region.find(2,$("#gdjzdszs").val(),new Eht.Responder({
			success:function(data){
				$("#gdjzdszds").empty();
				for (var i = 0; i < data.length; i++) {
					$("#gdjzdszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
				}
				$("#gdjzdszds").change();
			}
		}))
	})
		$("#gdjzdszds").change(function(){	
			region.find(3,$("#gdjzdszds").val(),new Eht.Responder({
				success:function(data){
				$("#gdjzdszxq").empty();
					for (var i = 0; i < data.length; i++) {
						$("#gdjzdszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
				}	
			}));
			
		})
		$("#hjszs").change(function(){
		
			region.find(2,$("#hjszs").val(),new Eht.Responder({
				success:function(data){
					$("#hjszds").empty();
					for (var i = 0; i < data.length; i++) {
						$("#hjszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
					$("#hjszds").change();
				}
			}));
		})
		
		$("#hjszds").change(function(){	
			region.find(3,$("#hjszds").val(),new Eht.Responder({
				success:function(data){
				$("#hjszxq").empty();
					for (var i = 0; i < data.length; i++) {
						$("#hjszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
					}
				}	
			}));
			
		})
		$("#isSame").change(function(){
			if($("#isSame").is(':checked')){
				$("#hjszs").val($("#gdjzdszs").val());
				$("#hjszs").change();
				$("#hjszds").val($("#gdjzdszds").val());
				$("#hjszds").change();
				$("#hjszxq").val($("#gdjzdszxq").val());
				$("#hjszdmx").val($("#gdjzdmx").val());
				
			}
		})

		
		
		
		//前科
		$("#sfyqk").change(function(){
			if($("#sfyqk input[name='sfyqk']:checked").val()=="0"){
				$("#qklx input[name='qklx']").attr("disabled",true);
			}else{
				$("#qklx input[name='qklx']").attr("disabled",false);
			}
		})
				/*-----------------------刑罚执行--------------------------*/
		//矫正期限
		 $("#sqjzjsrq,#sqjzksrq").change(function() {
        var a = new Date($("#sqjzjsrq").val());
        var b = new Date($("#sqjzksrq").val());
        a = a.valueOf();
        b = b.valueOf();
        var c = a - b;
        c = new Date(c);
       if(c.getFullYear()-1970>0){
       	if(c.getMonth()!=0){
       		$("#sqjzqx").val(c.getFullYear()-1970 + '年' + (c.getMonth()) + '个月');
       	}else{
       		$("#sqjzqx").val(c.getFullYear()-1970 + '年');
       	}
       }else{
       	$("#sqjzqx").val((c.getMonth()) + '个月');
       }
       
	 })
	 if($("#jzlb input[name='jzlb']:checked").val()=='03'||$("#jzlb input[name='jzlb']:checked").val()=='04'){
			$("#ypxf input[name='ypxf']").attr("disabled",false);
			$("#ypxqksrq").attr("disabled",false);
			$("#ypxqjsrq").attr("disabled",false);
			$("#sfbxgjzl input").attr("disabled",true);
			$("#jzlnr").attr("disabled",true);
			$("#jzqxksrq").attr("disabled",true);
			$("#jzqxjsrq").attr("disabled",true);
		}else{
			$("#ypxf input[name='ypxf']").attr("disabled",true);
			$("#ypxqksrq").attr("disabled",true);
			$("#ypxqjsrq").attr("disabled",true);
			$("#sfbxgjzl input").attr("disabled",false);
			$("#jzlnr").attr("disabled",false);
			$("#jzqxksrq").attr("disabled",false);
			$("#jzqxjsrq").attr("disabled",false);
		}
		if($("#jzlb input[name='jzlb']:checked").val()=='02'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="01"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='03'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="02"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='04'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="03"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='99'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="04"){
					$(this).attr("checked",true);
				}
			})
		}
	//矫正类别
	$("#jzlb input").change(function(){
		if($("#jzlb input[name='jzlb']:checked").val()=='03'||$("#jzlb input[name='jzlb']:checked").val()=='04'){
			$("#ypxf input[name='ypxf']").attr("disabled",false);
			$("#ypxqksrq").attr("disabled",false);
			$("#ypxqjsrq").attr("disabled",false);
			$("#jzl").css("display","none");
		}else{
			$("#ypxf input[name='ypxf']").attr("disabled",true);
			$("#ypxqksrq").attr("disabled",true);
			$("#ypxqjsrq").attr("disabled",true);
			$("#jzl").css("display","table-row");
		}
		if($("#jzlb input[name='jzlb']:checked").val()=='02'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="01"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='03'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="02"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='04'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="03"){
					$(this).attr("checked",true);
				}
			})
		}else if($("#jzlb input[name='jzlb']:checked").val()=='99'){
			$("#sjzxlx input[name='sjzxlx']").each(function(){
				if($(this).val()=="04"){
					$(this).attr("checked",true);
				}
			})
		}
	})
	//原判刑期
	$("#ypxqjsrq,#ypxqksrq").change(function(){
		var a = new Date($("#ypxqjsrq").val());
       var b = new Date($("#ypxqksrq").val());
       a = a.valueOf();
       b = b.valueOf();
       var c = a - b;
       c = new Date(c);
       var d=c.getFullYear()
       debugger;
      if(c.getFullYear()-1970>0){
   	   	if(3<c.getFullYear()-1970<=5){
   	   		$("#yqtxqx input").val('04');
   	   	}else if(5<c.getFullYear()-1970<=7){
   	   		$("#yqtxqx input").val('03');
   	   	}else if(7<c.getFullYear()-1970<=10){
   	   		$("#yqtxqx input").val('02');
   	   	}else if(10<c.getFullYear()-1970<=25){
   	   		$("#yqtxqx input").val('01');
   	   	}
	       	if(c.getMonth()!=0){
	       		$("#ypxq").val(c.getFullYear()-1970 + '年' + (c.getMonth()) + '个月');
	       	}else{
	       		$("#ypxq").val(c.getFullYear()-1970 + '年');
	       	}
      }else{
   	   $("#ypxq").val((c.getMonth()) + '个月');
      }
	})
	
	//报道情况
	$("#bdqk").change(function(){
		if($("#bdqk input[name='bdqk']:checked").val()=='03'){
			$("#wasbdqksm").attr("disabled",false);
			$("#sqjs").css("display","none");
			$("#jzxz").css("display","none");
			$("#dwgl").css("display","none");
			/*$("#sqjzryjsfs input[name='sqjzryjsfs']").attr("disabled",true);
			$("#sqjzryjsrq").attr("disabled",true);
			$("#sfjljzxz input[name='sfjljzxz']").attr("disabled",true);
			$("#jzxzryzcqk input[name='jzxzryzcqk']").attr("disabled",true);
			$("#sfcqdzdwgl input[name='sfcqdzdwgl']").attr("disabled",true);
			$("#dzdwfs input[name='dzdwfs']").attr("disabled",true);
			$("#dwhm").attr("disabled",true);*/
		}else{
			$("#wasbdqksm").attr("disabled",true);
			$("#sqjs").css("display","table-row");
			$("#jzxz").css("display","table-row");
			$("#dwgl").css("display","table-row");
			/*$("#wasbdqksm").attr("disabled",true);
			$("#sqjzryjsfs input[name='sqjzryjsfs']").attr("disabled",false);
			$("#sqjzryjsrq").attr("disabled",false);
			$("#sfjljzxz input[name='sfjljzxz']").attr("disabled",false);
			$("#jzxzryzcqk input[name='jzxzryzcqk']").attr("disabled",false);
			$("#sfcqdzdwgl input[name='sfcqdzdwgl']").attr("disabled",false);
			$("#dzdwfs input[name='dzdwfs']").attr("disabled",false);
			$("#dwhm").attr("disabled",false);*/
		}
	})
	$("#sfjljzxz").change(function(){
		if($("#sfjljzxz input[name='sfjljzxz']:checked").val()=='0'){
			$("#jzxzryzcqk select[name='jzxzryzcqk']").attr("disabled",true);
		}else{
			$("#jzxzryzcqk select[name='jzxzryzcqk']").attr("disabled",false);
		}
	})	
	
	//是否被宣告禁止令
	$("#sfbxgjzl").change(function(){
		if($("#sfbxgjzl input[name='sfbxgjzl']:checked").val()=="0"){
			$("#jzlnr").attr("disabled",true);
			$("#jzqxksrq").attr("disabled",true);
			$("#jzqxjsrq").attr("disabled",true);
			$("#sjzxyy input").each(function(){
				$(this).show();
				if($(this).val()=="02"){
					$(this).hide();
				}
			})
		}else{
			$("#jzlnr").attr("disabled",false);
			$("#jzqxksrq").attr("disabled",false);
			$("#jzqxjsrq").attr("disabled",false);
		}
	})
	
	$("#sfcqdzdwgl").change(function(){
		if($("input[name='sfcqdzdwgl']:checked").val()=="0"){
			$("#dzdwfs input[name='dzdwfs']").attr("disabled",true);
		}else{
			$("#dzdwfs input[name='dzdwfs']").attr("disabled",false);
		}
	})
	//矫正解除
	$("#jzbx").hide();
	$("#sjzx,#sjzx_2").hide();
	$("#jjlx").change(function(){
		if($("#jjlx input[name='jjlx']:checked").val()=="01"){
			$("#jjrq").val($("#sqjzjsrq").val());
			$("#jzbx").show();
			$("#sjzxlx").val("");
			$("#sjzx,#sjzx_2").hide();
			$("#swsj").attr("disabled",true);
			$("#swyy input[name='swyy']").attr("disabled",true);
			$("#jtsy").attr("disabled",true);
			$("#jzdbgrq").attr("disabled",true);
			$("#xjzddz").attr("disabled",true);
		}else if($("#jjlx input[name='jjlx']:checked").val()=="02"){
			$("#sjzx,#sjzx_2").show();
			$("#jzbx").hide();
			$("#swsj").attr("disabled",true);
			$("#swyy input[name='swyy']").attr("disabled",true);
			$("#jtsy").attr("disabled",true);
			$("#jzdbgrq").attr("disabled",true);
			$("#xjzddz").attr("disabled",true);
			if($("#jjlx input[name='jjlx']:checked").val()=='02'){
				$("#sjzxlx").val("01");
			}else if($("#jjlx input[name='jjlx']:checked").val()=='03'){
				$("#sjzxlx").val("02");
			}else if($("#jjlx input[name='jjlx']:checked").val()=='04'){
				$("#sjzxlx").val("03");
			}else if($("#jjlx input[name='jjlx']:checked").val()=='99'){
				$("#sjzxlx").val("99");
			}
		}else if($("#jjlx input[name='jjlx']:checked").val()=="03"){
			$("#sjzxlx").val("");
			$("#sjzx,#sjzx_2").hide();
			$("#jzbx").hide();
			$("#swsj").attr("disabled",false);
			$("#swyy input[name='swyy']").attr("disabled",false);
			$("#jtsy").attr("disabled",false);
			$("#jzdbgrq").attr("disabled",true);
			$("#xjzddz").attr("disabled",true);
		}else if($("#jjlx input[name='jjlx']:checked").val()=="04"){
			$("#sjzxlx").val("");
			$("#sjzx,#sjzx_2").hide();
			$("#jzbx").hide();
			$("#swsj").attr("disabled",true);
			$("#swyy input[name='swyy']").attr("disabled",true);
			$("#jtsy").attr("disabled",true);
			$("#jzdbgrq").attr("disabled",false);
			$("#xjzddz").attr("disabled",false);
		}else{
			$("#swsj").attr("disabled",true);
			$("#swyy input[name='swyy']").attr("disabled",true);
			$("#jtsy").attr("disabled",true);
			$("#jzdbgrq").attr("disabled",true);
			$("#xjzddz").attr("disabled",true);
			$("#sjzx,#sjzx_2").hide();
			$("#jzbx").hide();
			
		}
	})	
	
	$("#sfcjzyjnpx").change(function(){
		if($("#sfcjzyjnpx input[name='sfcjzyjnpx']:checked").val()=="0"){
			$("#sfhdzyjnzs input[name='sfhdzyjnzs']").attr("disabled",true);
			$("#jstcjdj").attr("disabled",true);
		}else{
			$("#sfhdzyjnzs input[name='sfhdzyjnzs']").attr("disabled",false);
			$("#jstcjdj").attr("disabled",false);
		}
	})
	//附件上传
	$("#formSqjzryjbxx_cljs #clqd_2").hide();
	$("#formSqjzryjbxx_cljs #clly").change(function(){
		if($("#clly").val()=="01"){
			
			$("#formSqjzryjbxx_cljs #clqd").show();
			$("#formSqjzryjbxx_cljs #clqd_2").hide();
		}else{
			$("#formSqjzryjbxx_cljs #clqd").hide();
			$("#formSqjzryjbxx_cljs #clqd_2").show();
		}
	})
		
		
	}
});
