var common = $(function($){
	new Eht.Layout({center:{selector:"#center",title:"聊天内容"},right:{selector:"#right",title:"聊天对象",titleSelector:"#right-title"}});
	new Eht.Layout({center:{selector:"#center_center",border:true},bottom:{selector:"#center_bottom",border:true}});
	new Eht.Layout({center:{selector:"#c_center"},bottom:{selector:"#c_bottom"}});
	//新政区划tree
	var tree = new Eht.Tree({selector:"#tree",labelField:"orgname"});
	var ws =new WebCommunicationService();
	//tree载入数据
	//树加载数据
	tree.loadData(function(res){
		ws.getOrgTree({},res);
		console.log(ws);
	});
	tree.clickRow(function(data){
		
	});
});