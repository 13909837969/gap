var callbackJzryjbxxImg=function(msg){
	new Eht.Tips().show(msg);
	var src = $("#jzryjbxx_photo").attr("osrc")+"&"+Math.random();
	$("#jzryjbxx_photo").attr("src",src);
	return false;
}; 

$(function(){
	var dagl = new XfzxService();
	/*var region = new RegionService();//省市区后台
*/	var count = 0;
	var tabCnt = $("#fromXfzx").children().size();
	$("#fromXfzx").children().each(function(){
		$(this).load($(this).attr("load"),function(){
			count++;
			initJzryjbxxForm();
		});
	});
	
	 var initJzryjbxxForm = function(){
		if(count!=tabCnt){
			return;
		}
		var id=$("#form_sqjzryxfzx_param_id").val();
		var xfzx = new Eht.Form({selector:"#sqjzryxfzx_form_jbxx"});
		var jcjz=  new Eht.Form({selector:"#sqjzryxfzx_form_jzjc"});
		//修改信息
		if(id!=""){
			
			dagl_xfzx.findXfzx(id,new Eht.Responder({
				success:function(data){
					xfzx.fill(data.xfzx);
					jcjz.fill(data.jcjz);
					
				}
			}));
		}
		 //模态框单击提交按钮提交数据到数据库 
		$("#Xfzx_btn").unbind("click").bind("click",function() {//此按钮为父页-模态框【提交】按钮
					var id = $("#sqjzryxfzx_form_jbxx #id").val();
					
					
						var jcxxdata=sqjzry_jcqkForm.getJcqkData();
						var yzqk=sqjzry_yzqkForm.getYzqkData();
						var dataxfzx=xfzx.getData();
						var datajcjz=jcjz.getData();
						debugger;
						dagl_xfzx.saveXfzx(dataxfzx,datajcjz,yzqk,jcxxdata,new Eht.Responder({
							success : function() {
								$("#sqjz_listDagl_all #dagl_listtable").refreshTable();
								$("#sqjz_listDagl_all #myModalAdd").modal('hide');
							}
						}));
					
				
		});
		//-------------------------------------------填写逻辑-------------------------------------------------------------
		$("#xb input[name='xb']").attr("disabled","disabled");
		$("#mz select[name='mz']").attr("disabled","disabled");
		$("#sqjzryxfzx_form_jbxx .form_date").datetimepicker({
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
		
		
		//上传照片
		$("#jbxxfile").change(function(){
			$("#jzryjbxxuploadForm").submit();
		});
		//日期自动获取
		$("#formSimple-body #sfzh").change(function(){
			var csrq = $("#formSimple-body #sfzh").val().substring(6,14);
			var csrqyyyy = csrq.substring(0,4);
			var csrqMM = csrq.substring(4,6);
			var csrqdd = csrq.substring(6);
			$("#formSimple-body #csrq").val(csrqyyyy+"-"+csrqMM+"-"+csrqdd);
		})
		
		//矫正期限
		 $("#sqjzjsrq,#sqjzksrq").change(function() {
         var a = new Date($("#sqjzjsrq").val());
         var b = new Date($("#sqjzksrq").val());
         a = a.valueOf();
         b = b.valueOf();
         if(b>=a){
	  		   new Eht.Alert().show("结束日期必须大于开始日期");
	  		 $("#ypxqjsrq").val("")
         }else{
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
        if(b>=a){
	  		   new Eht.Alert().show("结束日期必须大于开始日期");
	  		 $("#ypxqjsrq").val("")
	  		 
        }else{
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
	
	//矫正期间表现
	
	
	
	
	
	
	
	
		//地址判断
		/*
		 * JS内容分区以以下方式分区
		 *  ---------------------xx区-开始-------------------------------------------- 
		 
		var service = new DaglService();
		var serviceDagl = new DaglService();
		var region = new RegionService();//省市区后台
		 省区联动  
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
		formSqjzryjbxx_dz.change(function(name,value,combo,parent){
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
						for (var i = 0; i < data.length; i++) {
							$("#hjszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
						$("#hjszds").change();
					}
				}));
			}else if(name == "hjszds"){//户籍所在地区
				region.find(null,value,new Eht.Responder({
					success:function(data){
						$("#hjszxq").empty();
						for (var i = 0; i < data.length; i++) {
							$("#hjszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
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
			}
		})
		
		 ---------------------操作区-开始-------------------------------------------- 
		
		formJbxx.change(function(name,value,combo,parent){
			if(name == "sfdcpg"){//调查评估意见
				if(value == 0){
					this.disable("dcpgyj");
					this.disable("dcyjcxqk");
				}else{
					this.enable("dcpgyj");
					this.enable("dcyjcxqk");
				}
			}else if(name="sfzh"){
				//出身日期
				if($("sfzh").val()!=0){
					this.disable("csrq");
				}
			}else if(name == "sfcn"){//是否成年
				if(value==0){
					this.disable("wcn");
					this.disable("hyzk");
				}else{
					this.enable("wcn");
					this.enable("hyzk");
				}
			}else if(name == "ywhz"){//有无护照
				if(value == 0 ){
					this.disable("hzhm");
					this.disable("hzbczt");
				}else{
					this.enable("hzhm");
					this.enable("hzbczt");
				}
			}else if(name == "ywgatsfz"){//有无港澳台身份证
				if(value==0){
					this.disable("gatsfzlx");
					this.disable("gatsfzhm");
				}else{
					this.enable("gatsfzlx");
					this.enable("gatsfzhm");
				}
			}else if(name == "ywgattxz"){//有无港台通行证			
				if(value == 0 ){
					this.disable("gattxzlx");
					this.disable("gattxzhm");
					this.disable("gattxzbczt");
				}else{
					this.enable("gattxzlx");
					this.enable("gattxzhm");
					this.enable("gattxzbczt");
				}
			}else if(name == "ywgajmwlndtxz"){//有无港澳居民往来内地通
				if(value == 0 ){
					this.disable("gajmwlndtxz");
					this.disable("gajmwlndtxzbczt");
				}else{
					this.enable("gajmwlndtxz");
					this.enable("gajmwlndtxzbczt");
				}
			}else if(name == "ywtbz"){//有无台胞证
				if(value == 0 ){
					this.disable("tbzhm");
					this.disable("tbzbczt");
					
				}else{
					this.enable("tbzhm");
					this.enable("tbzbczt");
				}
			}else if(name == "sfyjsb"){//是否有精神病
				if(value==0){
					this.disable("jdjg");
				}else{
					this.enable("jdjg");
				}
			}else if(name == "sfycrb"){//是否有传染病
				if(value == 0 ){
					this.disable("jtcrb");
				}else{
					this.enable("jtcrb");
				}
			}else if(name == "sfyqk"){//是否有前科
				if(value == 0 ){
					this.disable("qklx");
					this.disable("sflf");
				}else{
					this.enable("qklx");
					this.enable("sflf");
				}
			}else if(name == "sfszbf"){//是否数罪并罚
				if(value == 0 ){  
					this.disable("ypxf");
					this.disable("ypxq");
					this.disable("ypxqksrq");
					this.disable("ypxqjsrq");
				}else{
					this.enable("ypxf");
					this.enable("ypxq");
					this.enable("ypxqksrq");
					this.enable("ypxqjsrq");
				}
			}else if(name == "sfjljzxz"){//是否建立矫正小组
				if(value == 0 ){
					this.disable("jzxzryzcqk");
				}else{
					this.enable("jzxzryzcqk");
				}
			}else if(name == "sfcydzdwgl"){//是否采用电子定位方式
				if(value == 0){
					this.disable("dzdwfs");
					this.disable("dwhm");
				}else{
					this.enable("dzdwfs");
					this.enable("dwhm");
				}
				
			}
			
		});
		//
		//formJbxx.tiggerChange();
		//标识判断编辑和提交按钮是隐藏还是显示 
		var i = $("#form-edit-flag1").val();
		if($("#form-edit-flag1").val() == 1){
			$("#formSqjzryjbxx-bj").show();
			$("#formSqjzryjbxx-tj").show();
			formJbxx.tiggerChange();
			changeInput(true);
		}else{
			$("#formSqjzryjbxx-bj").hide();
			$("#formSqjzryjbxx-tj").hide();
		};

		//单击编辑按钮触发事件
		$("#formSqjzryjbxx-bj").click(function(){
			changeInput(false);
		});
		//选择input事件的状态  disable
		function changeInput(ifBoolean){
			if(ifBoolean){
				formJbxx.disable();
			}else{
				formJbxx.enable();
			}
		};
		*//**
		 * 
		 *//*
	 	 模态框单击提交按钮提交数据到数据库 
		$("#dagl_list_btn_primary").unbind("click").bind("click",function() {//此按钮为父页-模态框【提交】按钮
			//单击提交按钮 
			if($("#formSimple-body #xm").val() == ""){
				setTimeout(function(){
					$("#formSimple-body #xm").focus();
				},200);
				setTimeout(function(){
					$("#formSimple-body #jglx").focus();
				},400);
			}else{
				var id = $("#sqjzryjbxx_form_jbxx #id").val();
				var jsonJbxx = formJbxx.getData();
				var grjldata = sqjzry_grjlForm.getGrjlData();
				var shgxdata = Sqjzry_jtcyjShgxForm.getJtcyData();
				var dataWs = formSqjzryjbxx_ws.getData();
				var dataDz = formSqjzryjbxx_dz.getData();
				var dataFz = formSqjzryjbxx_fz.getData();
				var dataJk = formSqjzryjbxx_jk.getData();
				var dataJz = formSqjzryjbxx_jz.getData();
				var dataSf = formSqjzryjbxx_sf.getData();
				var dataJzfa = fromJzryjbxx_Jzfaxx.getData();
				var dz_view=formSqjzryjbxx_dz_View.getData();
				if(formJbxx.validate()){
					serviceDagl.saveOne(jsonJbxx,grjldata,shgxdata,dataWs,dataDz,dataFz,dataJk,dataJz,dataSf,dataJzfa, new Eht.Responder({
						success : function() {
							debugger;
							$("#sqjz_listDagl_all #dagl_listtable").refreshTable();
							$("#sqjz_listDagl_all #myModalAdd").modal('hide');
						}
					}));
				}
			}
		});
		$(".form_date").datetimepicker({
			format: 'yyyy-mm-dd', 
			language:  'zh-CN',
			autoclose: true,
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			minView: 2,
			forceParse: 0	
		});
		
		setTimeout(function(){
			$("#formSimple-body #sqjzrybh").focus();
		},200);
		
	}*/
	 }
	 
});
