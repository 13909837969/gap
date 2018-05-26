var callbackJzryjbxxImg=function(msg){
	new Eht.Tips().show(msg);
	var src = $("#jzryjbxx_photo").attr("osrc")+"&"+Math.random();
	$("#jzryjbxx_photo").attr("src",src);
	return false;
};

$(function(){
	var count = 0;
	var localCtx = $("#form_sqjzryjbxx_localctx").val();
	var __id = $("#form_sqjzryjbxx_param_id").val();
	$("#formSqjzryjbxx_jbxx").load(localCtx + "/module/sqjz/formSqjzryjbxx_jbxx.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_ws").load(localCtx + "/module/sqjz/formSqjzryjbxx_ws.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_dz").load(localCtx + "/module/sqjz/formSqjzryjbxx_dz.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_fz").load(localCtx + "/module/sqjz/formSqjzryjbxx_fz.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_jk").load(localCtx + "/module/sqjz/formSqjzryjbxx_jk.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_jz").load(localCtx + "/module/sqjz/formSqjzryjbxx_jz.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#_formSqjzryjbxx_sf").load(localCtx + "/module/sqjz/formSqjzryjbxx_sf.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#formSqjzryjbxx_Grjl").load(localCtx + "/module/sqjz/formSqjzryjbxx_Grjl.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#formSqjzryjbxx_JtcyjShgx").load(localCtx + "/module/sqjz/formSqjzryjbxx_JtcyjShgx.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	$("#fromJzryjbxx_Jzfaxx").load(localCtx + "/module/sqjz/fromJzryjbxx_Jzfaxx.jsp?load=load&id=" + __id,function(){
		count++;
		initJzryjbxxForm();
	});
	//$("#listJzTaf").load(localCtx + "/module/sqjz/listJzTaf.jsp?load=load&id=" + __id);
	//$("#listJzXnsfxx").load(localCtx + "/module/sqjz/JzXnsfxx.jsp?load=load&id=" + __id);
	//$("#listJzJzlxx").load(localCtx + "/module/sqjz/listJzJzlxx.jsp?load=load&id=" + __id);
	//$("#formJrtdqy").load(localCtx + "/module/sqjz/formJrtdqy.jsp?load=load&id=" + __id); 
	
	var initJzryjbxxForm = function(){
		if(count!=10){
			return;
		}
		//矫正人员基本信息
		var formJbxx = new Eht.Form({
			selector :'#sqjzryjbxx_form_jbxx',
			autolayout:true,
			formCol:2
		});
		$().initDatetimepicker();
		//基本信息文书
		var formSqjzryjbxx_ws = new Eht.Form({selector:'#formSqjzryjbxx_ws',autolayout:true});
		//基本信息地址
		var formSqjzryjbxx_dz = new Eht.Form({selector:'#formSqjzryjbxx_dz',autolayout:true});
		//基本信息犯罪
		var formSqjzryjbxx_fz = new Eht.Form({selector:'#formSqjzryjbxx_fz',autolayout:true});
		//基本信息健康
		var formSqjzryjbxx_jk = new Eht.Form({selector:'#formSqjzryjbxx_jk',autolayout:true});
		//基本信息矫正
		var formSqjzryjbxx_jz = new Eht.Form({selector:'#formSqjzryjbxx_jz',autolayout:true});
		//基本信息身份
		var formSqjzryjbxx_sf = new Eht.Form({selector:'#formSqjzryjbxx_sf',autolayout:true});
		//矫正方案信息采集表
		var fromJzryjbxx_Jzfaxx = new Eht.Form({selector:"#fromJbxxjzfaxx_form",autolayout:true});
		/*
		 * JS内容分区以以下方式分区
		 *  ---------------------xx区-开始-------------------------------------------- 
		 */
		var service = new DaglService();
		var serviceDagl = new DaglService();
		var servicePro = new RegionService();//省市区后台
		/* 省区联动  */
		servicePro.find(1,null,new Eht.Responder({//省份初始化
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
				servicePro.find(null,value,new Eht.Responder({
					success:function(data){
						$("#gdjzdszxq").empty();
						for (var i = 0; i < data.length; i++) {
							$("#gdjzdszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}
				}));
			}else if(name == "hjszs"){//户籍所在地市
				servicePro.find(null,value,new Eht.Responder({
					success:function(data){
						$("#hjszds").empty();
						for (var i = 0; i < data.length; i++) {
							$("#hjszds").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
						$("#hjszds").change();
					}
				}));
			}else if(name == "hjszds"){//户籍所在地区
				servicePro.find(null,value,new Eht.Responder({
					success:function(data){
						$("#hjszxq").empty();
						for (var i = 0; i < data.length; i++) {
							$("#hjszxq").append('<option value="'+data[i].regionid+'">'+data[i].region_name+'</option>');
						}
					}
				}));
			}else if(name == "gdjzdszs"){//固定住址市
				servicePro.find(null,value,new Eht.Responder({
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
		//修改数据
		if(formJbxx.getValue("id") != ""){
			service.findOne(formJbxx.getValue("id"),new Eht.Responder({
				success:function(data){
					formJbxx.fill(data["jzryjbxx"]);
					formSqjzryjbxx_ws.fill(data["jzrywsxx"]);
					formSqjzryjbxx_dz.fill(data["jzrydzxx"]);
					formSqjzryjbxx_fz.fill(data["jzryfzxx"]);
					formSqjzryjbxx_jk.fill(data["jzryjkxx"]);
					formSqjzryjbxx_jz.fill(data["jzryjzxx"]);
					formSqjzryjbxx_sf.fill(data["jzrysfxx"]);
					fromJzryjbxx_Jzfaxx.fill(data["jzryfaxx"]);
				}
			}));
		}
		/* ---------------------操作区-开始-------------------------------------------- */
		//上传照片
		$("#jbxxfile").change(function(){
			$("#jzryjbxxuploadForm").submit();
		});
		if($("#form-edit-flag1").val()=="0"){// 0 表示新增  1 表示修改
			//$("#jzryjbxx_photo").attr("src","../../image/RMIImageService?_table_name=JZ_JZRYJBXX_IMG&imgid=a&icon=per");
		};
		$("#formSimple-body #sfzh").change(function(){
			var csrq = $("#formSimple-body #sfzh").val().substring(6,14);
			var csrqyyyy = csrq.substring(0,4);
			var csrqMM = csrq.substring(4,6);
			var csrqdd = csrq.substring(6);
			$("#formSimple-body #csrq").val(csrqyyyy+"-"+csrqMM+"-"+csrqdd);
		})
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
	/*	var i = $("#form-edit-flag1").val();
		if($("#form-edit-flag1").val() == 1){
			$("#formSqjzryjbxx-bj").show();
			$("#formSqjzryjbxx-tj").show();
			formJbxx.tiggerChange();
			changeInput(true);
		}else{
			$("#formSqjzryjbxx-bj").hide();
			$("#formSqjzryjbxx-tj").hide();
		};*/

		//单击编辑按钮触发事件
		/*$("#formSqjzryjbxx-bj").click(function(){
			changeInput(false);
		});*/
		//选择input事件的状态  disable
		/*function changeInput(ifBoolean){
			if(ifBoolean){
				formJbxx.disable();
			}else{
				formJbxx.enable();
			}
		};*/
		/**
		 * 
		 */
	 	/* 模态框单击提交按钮提交数据到数据库 */
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
				if(formJbxx.validate()){
					serviceDagl.saveOne(jsonJbxx,grjldata,shgxdata,dataWs,dataDz,dataFz,dataJk,dataJz,dataSf,dataJzfa, new Eht.Responder({
						success : function() {
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
		
	}
});
