$(function() {
	//决策总览的二级界面
	var pad = new RepJszlService();
	//市级检索 【默认加载】
	pad.findBuilDing(new Eht.Responder({
		success:function(data){
			cra(data);
		}}));
});
//律师管理
function ls(id) {
	qy(id);
}
//司法鉴定
function sfjd(id) {
	qy(id);
}
//公证处
function gzzy(id) {
	qy(id);
}
//调委会
function rmtj(id) {
	qy(id);
}
//社区矫正资源
function sqjz(id) {
	qy(id);
}
//进去区域
function qy(id) {
	//决策总览的二级界面
	var pad = new RepJszlService();
	//市级检索 【默认加载】
	$("#list_main_beirong #lsul").html('');
	$("#list2 #sfjd").html('');
	$("#list3 #gzzy").html('');
	$("#list4 #rmtj").html('');
	$("#list5 #sqjz").html('');
	$("#lsgl-5").html('0');
	$("#lsgl-6").html('0');
	$("#sfjd-5").html('0');
	$("#sfjd-6").html('0');
	$("#gzzy-5").html('0');
	$("#gzzy-6").html('0');
	$("#rmtj-5").html('0');
	$("#rmtj-6").html('0');
	$("#sqjz-5").html('0');
	$("#sqjz-6").html('0');
	pad.findBuilDing_QY( id + "",new Eht.Responder({
		success:function(data){
			cra(data);
		}}));
}

//绘制界面
function cra(data) {
	//成功处理
	if (data.length > 0) {
		var k1 = 0;
		var k2 = 0;
		var k3 = 0;
		var k4 = 0;
		var k5 = 0;
		var total_jg1 = 0;
		var total_ry1 = 0;
		var total_jg2 = 0;
		var total_ry2 = 0;
		var total_jg3 = 0;
		var total_ry3 = 0;
		var total_jg4 = 0;
		var total_ry4 = 0;
		var total_jg5 = 0;
		var total_ry5 = 0;
		for (var i = 0; i < data.length; i++) {
			if (data[i].jglxmc == '律师事务所') {
				 k1 += 1;
				 var oli = $('<li style="list-style-type:none;cursor:pointer;" id = "'+ data[i].regionid +'" onclick = "ls('+ data[i].regionid +')">'+
							'<div class="row list_main_text">'+
							'<div class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-10">'+
								'<div class="xuhaoq list_main_text">'+ k1 +'</div>'+
							'</div>'+
						'<div  class="col-md-6 col-sm-6 col-xs-6 list_main_text" id="sfjd-11">'+ data[i].region_name +'</div>'+
						'<div  class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-12">'+ data[i].jgsl +'</div>'+
						'</div>'+
					'</li>');
				 oli.hover(function(){
					 $(this).addClass("mouseover_selected");
				 },function(){
					 $(this).removeClass("mouseover_selected");
				 });
				$("#list_main_beirong #lsul").append(oli);
				var t = data[i].jgsl;
				total_jg1 += t; 
				var r = data[i].gzrys;
				total_ry1 += r;
				$("#lsgl-5").html(total_jg1);
				$("#lsgl-6").html(total_ry1);
			}
			if (data[i].jglxmc == '司法鉴定机构') {
				 k2 += 1;
				 var oli = $('<li style="list-style-type:none;cursor:pointer;" id = "'+ data[i].regionid +'"  onclick = "sfjd('+ data[i].regionid +')">'+
							'<div class="row list_main_text">'+
							'<div class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-10">'+
								'<div class="xuhaoq list_main_text">'+ k2 +'</div>'+
							'</div>'+
						    '<div  class="col-md-6 col-sm-6 col-xs-6 list_main_text" id="sfjd-11">'+ data[i].region_name +'</div>'+
						    '<div  class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-12">'+ data[i].jgsl +'</div>'+
						'</div>'+
					'</li>');
					 oli.hover(function(){
						 $(this).addClass("mouseover_selected");
					 },function(){
						 $(this).removeClass("mouseover_selected");
					 });
					$("#list2 #sfjd").append(oli);
					var t = data[i].jgsl;
					total_jg2 += t; 
					var r = data[i].gzrys;
					total_ry2 += r;
					$("#sfjd-5").html(total_jg2);
					$("#sfjd-6").html(total_ry2);
			}
			if (data[i].jglxmc == '公证处') {
				 k3 += 1;
				 var oli=$('<li style="list-style-type:none;cursor:pointer;" id = "'+ data[i].regionid +'"  onclick = "gzzy('+ data[i].regionid +')">'+
							'<div class="row list_main_text">'+
							'<div class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-10">'+
								'<div class="xuhaoq list_main_text">'+ k3 +'</div>'+
							'</div>'+
						'<div  class="col-md-6 col-sm-6 col-xs-6 list_main_text" id="sfjd-11">'+ data[i].region_name +'</div>'+
						'<div  class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-12">'+ data[i].jgsl +'</div>'+
						'</div>'+
					'</li>');
				 oli.hover(function(){
					 $(this).addClass("mouseover_selected");
				 },function(){
					 $(this).removeClass("mouseover_selected");
				 });
					$("#list3 #gzzy").append(oli);
					var t = data[i].jgsl;
					total_jg3 += t; 
					var r = data[i].gzrys;
					total_ry3 += r;
					$("#gzzy-5").html(total_jg3);
					$("#gzzy-6").html(total_ry3);
			}
			if (data[i].jglxmc == '调委会') {
				 k4 += 1;
				 var oli=$('<li style="list-style-type:none;cursor:pointer;" id = "'+ data[i].regionid +'"  onclick = "rmtj('+ data[i].regionid +')">'+
							'<div class="row list_main_text">'+
							'<div class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-10">'+
								'<div class="xuhaoq list_main_text">'+ k4 +'</div>'+
							'</div>'+
						'<div  class="col-md-6 col-sm-6 col-xs-6 list_main_text" id="sfjd-11">'+ data[i].region_name +'</div>'+
						'<div  class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-12">'+ data[i].jgsl +'</div>'+
						'</div>'+
					'</li>');
				 oli.hover(function(){
					 $(this).addClass("mouseover_selected");
				 },function(){
					 $(this).removeClass("mouseover_selected");
				 });
					$("#list4 #rmtj").append(oli);
					var t = data[i].jgsl;
					total_jg4 += t; 
					var r = data[i].gzrys;
					total_ry4 += r;
					$("#rmtj-5").html(total_jg4);
					$("#rmtj-6").html(total_ry4);
			}
			/**/
			if (data[i].jglxmc == '基层法律服务所') {
				 k5 += 1;
				 var oli = $('<li style="list-style-type:none;cursor:pointer;" id = "'+ data[i].regionid +'"  onclick = "sqjz('+ data[i].regionid +')">'+
							'<div class="row list_main_text">'+
							'<div class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-10">'+
								'<div class="xuhaoq list_main_text">'+ k5 +'</div>'+
							'</div>'+
						'<div  class="col-md-6 col-sm-6 col-xs-6 list_main_text" id="sfjd-11">'+ data[i].region_name +'</div>'+
						'<div  class="col-md-3 col-sm-3 col-xs-3 list_main_text" id="sfjd-12">'+ data[i].jgsl +'</div>'+
						'</div>'+
					'</li>');
				 oli.hover(function(){
					 $(this).addClass("mouseover_selected");
				 },function(){
					 $(this).removeClass("mouseover_selected");
				 });
					$("#list5  #sqjz").append(oli);	
					var t = data[i].jgsl;
					total_jg5 += t; 
					var r = data[i].gzrys;
					total_ry5 += r;
					
					$("#sqjz-5").html(total_jg5);
					$("#sqjz-6").html(total_ry5);
			}
			
			
			
		}
		
	}else{
		$("#list_main_beirong #lsul").html('暂无数据！');
		$("#list2 #sfjd").html('暂无数据！');
		$("#list3 #gzzy").html('暂无数据！');
		$("#list4 #rmtj").html('暂无数据！');
		$("#list5 #sqjz").html('暂无数据！');
		return;
	}
}