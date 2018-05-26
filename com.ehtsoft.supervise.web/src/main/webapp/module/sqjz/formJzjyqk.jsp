<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JypxService.js"></script>
<script type="text/javascript">
	$(function() {
		var form = new Eht.Form({
			selector : '#Jzjyqk_form',
			autolayout:true
		});
		//培训内容
		var textareaName = "#Jzjyqk_form #floor";//备注输入框id
		var spanName = "#Jzjyqk_form #count";//计数span的id
		$(textareaName).click(function(){
			countChar(textareaName,spanName);
		});
		$(textareaName).keyup(function(){
			countChar(textareaName,spanName);
		});
		$(textareaName).keydown(function(){
			countChar(textareaName,spanName);
		});
		function countChar(textareaName,spanName){ 
		   if($(textareaName).val() != ""){
				$(spanName).text($(textareaName).val().length + "/250");			
				if($(textareaName).val().length>0){
						$(spanName).css("color","#3F51B5");
				};
				if($(textareaName).val().length>240){
						$(spanName).css("color","#FF0000");
					};
			}else{
				$(spanName).text("0/250");
			}
		};
		//考试分析情况
		var textareaName2 = "#Jzjyqk_form #floor2";//备注输入框id
		var spanName2 = "#Jzjyqk_form #count2";//计数span的id
		$(textareaName2).click(function(){
			countChar(textareaName2,spanName2);
		});
		$(textareaName2).keyup(function(){
			countChar(textareaName2,spanName2);
		});
		$(textareaName2).keydown(function(){
			countChar(textareaName2,spanName2);
		});
		function countChar(textareaName2,spanName2){ 
		   if($(textareaName2).val() != ""){
				$(spanName2).text($(textareaName2).val().length + "/250");			
				if($(textareaName2).val().length>0){
						$(spanName2).css("color","#3F51B5");
				};
				if($(textareaName2).val().length>240){
						$(spanName2).css("color","#FF0000");
					};
			}else{
				$(spanName2).text("0/250");
			}
		};
		//培训结果分析
		var textareaName3 = "#Jzjyqk_form #floor3";//备注输入框id
		var spanName3 = "#Jzjyqk_form #count3";//计数span的id
		$(textareaName3).click(function(){
			countChar(textareaName3,spanName3);
		});
		$(textareaName3).keyup(function(){
			countChar(textareaName3,spanName3);
		});
		$(textareaName3).keydown(function(){
			countChar(textareaName3,spanName3);
		});
		function countChar(textareaName3,spanName3){ 
		   if($(textareaName3).val() != ""){
				$(spanName3).text($(textareaName3).val().length + "/250");			
				if($(textareaName3).val().length>0){
						$(spanName3).css("color","#3F51B5");
				};
				if($(textareaName3).val().length>240){
						$(spanName3).css("color","#FF0000");
					};
			}else{
				$(spanName3).text("0/250");
			}
		};
		

		$("#sqjz_listJypx #btn-primary").unbind("click").bind("click",
				function() {
					//if(form.validate()){
						var service = new JypxService();
						service.saveOrUpdateFocusEducation(form.getData(),
								new Eht.Responder({
									success : function() {
										$("#sqjz_listJypx #tableview").refreshTable();
										$('#sqjz_listJypx #myModal').modal('hide');
									}
						}));
					//}
				});
	});
</script>
</head>
<body>
	<div id="Jzjyqk_form">
		<div hidden>
			<input name="pxqkid" type="hidden">
		</div>
		<input name="pxztmc" type="text"  label="培训标题" placeholder="培训标题" valid="{required:true}">
		<input name="ycjrs" type="text" label="应参加人数" placeholder="应参加人数" valid="{required:true,int:true}">
		<input name="sjcjrs" type="text" label="实际参加人数" placeholder="实际参加人数" valid="{required:true,int:true}">
		<input name="pxlsmc" type="text" label="授课人" placeholder="授课人" valid="{required:true,onlyChinese : true}">
		<input id="time" name="pxksj" type="text"  class="form_date_time form-control" data-date-format="yyyy-MM-dd" placeholder="培训时间" label="培训时间"    valid="{required:true,datetime : true }"                       >
		<input name="pxdz" type="text" label="培训地点" placeholder="培训地点" valid="{required:true,onlyChinese:true}">
		<textarea  rows="8" name="f_hbnr"  id="floor" type="text" maxlength="250" label="培训内容" valid="{required:true}"></textarea>
		<div class="text-right"><span id="count"></span></div>
		<textarea rows="8" name="ksqkfx"  id="floor2" type="text" maxlength="250" label="考试情况分析" valid="{required:true}"></textarea>
		<div class="text-right"><span id="count2"></span></div>
		<textarea rows="8" name="pxjgpj" id="floor3" type="text" maxlength="250" label="培训结果分析" valid="{required:true}"></textarea>
		<div class="text-right"><span id="count3"></span></div>
	</div>
</body>
</html>