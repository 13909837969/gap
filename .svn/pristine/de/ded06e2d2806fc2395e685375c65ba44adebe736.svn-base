$(function(){
	var div = $("<div class='sbox sbox_0' style='width:10px;height:20px;border:2px solid #ccc;margin-top:-5px;position:absolute;z-index:100;'></div>");
	$(document.body).append(div);
	div.hide();
	var div2 = $("<div class='sbox sbox_1' style='width:10px;height:20px;border:2px solid #ccc;margin-top:-5px;position:absolute;z-index:100;'></div>");
	$(document.body).append(div2);
	div2.hide();
	var div3 = $("<div class='sbox sbox_2' style='width:10px;height:20px;border:2px solid #ccc;margin-top:-5px;position:absolute;z-index:100;'></div>");
	$(document.body).append(div3);
	div3.hide();
	var div4 = $("<div class='sbox sbox_3' style='width:10px;height:20px;border:2px solid #ccc;margin-top:-5px;position:absolute;z-index:100;'></div>");
	$(document.body).append(div4);
	div4.hide();
	var t = 0;
	var down = false;
	$(document).mousemove(function(e){
		down = (e.clientY - t > 0);
		t = e.clientY;
	})
	$(".cityContent>p").hover(
	  function(){
		 var p = $(this).parent().children().eq(0).offset();
		 var pr =  $(this).parent().get(0);
		       var smark = $(this).parent().attr("smark");
		       var divs = $("div[smark='"+smark+"']");
		       divs.each(function(i,item){
		    		 var of =   $(this).children().eq(0).offset();
		    		 var b = $(".sbox_" + i);
		    		 b.css({top:(of.top - 3)+"px",left:of.left+"px",width:$(this).width(),height:$(this).children().outerHeight(true)});
		    		 if(down){
		    			 b.show().animateCss("slideInDown");
		    		 }else{
		    			 b.show().animateCss("slideInUp");
		    		 }
		       });
		return false;
	 },function(){
		 return false;
	 }		
	);
	$(".cityContent>p").click(function(){
		//alert($(this).html());
		console.log($(this).html());
	});
	

	$(".rangCity").mouseout(function(){
		//console.log("hello!");
		$(".sbox").hide();
		});
});