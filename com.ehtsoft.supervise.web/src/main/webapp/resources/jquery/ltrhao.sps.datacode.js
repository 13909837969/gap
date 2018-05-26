$(function(){
	var ps = location.pathname.split("/");
	var ctxPath = "/";
	if(ps.length>1){
		ctxPath = "/"+ps[1];
	}
	try{
		if(window.top.Eht==undefined){
			window.top.Eht = Eht;
		}
		Eht.DataCode = window.top.Eht.DataCode;
	}catch(e){
		try{
			Eht.DataCode = window.parent.Eht.DataCode;
		}catch(ex){}
	}
	if(Eht.DataCode==undefined){
		try{
			var param = {service:"DictionaryService",method:"findDetail",arguments:"['']"};
			jQuery.ajax({				
				type: 		"POST",
				url:  		ctxPath+"/json?debug=false",
				data: 		param,
				dataType: 	"json",
				async: 		false,
				success: 	function(data){
					Eht.DataCode = data;
					try{
						window.top.Eht.DataCode = Eht.DataCode;
					}catch(e){
						try{
							window.parent.Eht.DataCode = Eht.DataCode;
						}catch(e){}
					}
				},							
				error: function(request){
					console.log(request.responseText);
				}
			});
		}catch(e){}
	}
});