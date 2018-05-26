$(function(){
	var service = new FormSimpleServise();
	var form = new Eht.Form({selector:'#JzTaf-Form',autolayout:true});
	var query = {};
	var f_aid = "${param.id}";
	query.f_aid = f_aid;
	
	if(f_aid == ""){
		changeInput(false);
		$('#submit').attr('disabled',false);
		$('#edit').hide();
	}else{
		service.findOne(f_aid,new Eht.Responder({
			success:function(data){
				form.fill(data);
			}
		}));
		changeInput(true);
	}
	$('#submit').click(function(){
		if(form.validate()){
			service.save(form.getData(),new Eht.Responder({
				success:function(data){
					changeInput(true);
					$('#submit').attr('disabled',true);
					form.clearValidStyle();
					new Eht.Tips().show();
				}
			}));
		}
	});
	$('#edit').click(function(){
		changeInput(false);
		$('#submit').attr('disabled',false);
	});
	function changeInput(ifboolean){
		if(ifboolean){
			form.disable();
		}else{
			form.enable();
		}
		
	}
	//点击展开更多事件
	$("#formSimple-djgd").click(function(){
		setTimeout(function(){
			$("#formSimple-gdlb-wsxx").focus()},350);
		$("#formSimple-gdlb").css("height","0px").show().animate({height:300});
	});
	//点击收起按钮事件
	$("#formSimple-sq").click(function(){
		$("#formSimple-gdlb").animate({heihgt:0},function(){
			$(this).hide();
		});
	});
	//单击添加矫正人员-附加身份信息按钮事件
	$("#formSimple-gdlb-fjsf").click(function(){
		$("#formSimple-body #modal-body").load("formSqjzryjbxx_sf.jsp?load=load",function(){
			$(".form_date").datetimepicker({
				format: 'yyyy-mm-dd', 
				language:  'zh-CN',
				autoclose: true,
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				//todayHighlight: 1,
				//startView: 2,
				minView: 2,
				forceParse: 0	
			});
		})
		$("#formSimple-body #myModal").modal({
			backdrop : 'static',
			keyboard : false
		}); 
	});
	//单击单击添加矫正人员-矫正信息按钮事件
	$("#formSimple-gdlb-jzxx").click(function(){
		$("#formSimple-body #modal-body").load("formSqjzryjbxx_jz.jsp?load=load",function(){
			$(".form_date").datetimepicker({
				format: 'yyyy-mm-dd', 
				language:  'zh-CN',
				autoclose: true,
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				//todayHighlight: 1,
				//startView: 2,
				minView: 2,
				forceParse: 0	
			});
		});
		$("#formSimple-body #myModal").modal({
			backdrop : 'static',
			keyboard : false
		});
	});
	
});