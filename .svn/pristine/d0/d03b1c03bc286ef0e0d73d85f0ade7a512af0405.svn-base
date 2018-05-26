Eht.EmpiDialog=function(sfzh){
	var ed = this;
	var mzList=Eht.DataCode["gb0008"];
	var param = {
			service:"IntelligentService",
			method:"findEmpi",
			arguments:"['"+sfzh+"']"
	};
	
	jQuery.ajax({				
		type: 		"POST",
		url:  		"../../json/IntelligentService.js",
		data: 		param,
		dataType: 	"json",
		async: 		true,
		success: 	function(data){
			if(data.empi!=null){
			var msg = $("<table>"+
					"<tr><td colspan='4'><font color='#00f'>确认加载以下基本信息吗？</font></td></tr>"+
					"<tr>"+
						"<td colspan='4'>"+
							"个人主索引号：<span name='empi'>32344235432453254545</span>"+
						"</td>"+
					"</tr>"+
					"<tr>"+
						"<td>"+
							"姓名："+
						"</td>"+
						"<td>"+
						    "<span name='xm'>张三</span>"+
						"</td>"+
						"<td>"+
							"性别："+
						"</td>"+
						"<td>"+
							"<span name='xbStr'>男[1]</span>"+
						"</td>"+
					"</tr>"+
					"<tr>"+
						"<td>"+
							"出生日期："+
						"</td>"+
						"<td>"+
							"<span name='csrq'>2009-09-09</span>"+
						"</td>"+
						"<td>"+
							"民族："+
						"</td>" +
						"<td>"+
							"<span name='mzStr'>01 汉族</span>"+
						"</td>" +
					"</tr>"+
					"<tr>"+
						"<td>"+
							"联系电话："+
						"</td>"+
						"<td>"+
							"<span name='brdh'>12344433344</span>"+
						"</td>"+
						"<td>"+
							"常住类型："+
						"</td>"+
						"<td>"+
							"<span name='czlxStr'>1户籍</span>"+
						"</td>"+
					"</tr>"+
					"<tr>" +
						"<td>" +
							"血型：" + 
						"</td>"+
						"<td>" +
							"<span name='xxStr'>1 A型</span>" + 
						"</td>"+
						"<td>" +
							"rh血型："+
						"</td>" + 
						"<td>" +
							"<span name='rhStr'>1否</span>"+
						"</td>" + 
					"</tr>" + 
					"<tr>" +
						"<td>"+
							"个人档案号：" +
						"</td>"+
						"<td colspan='3'>"+
							"<span name='grdah'>21090009090909090</span>" +
						"</td>"+
					"</tr>"+
				 "</table>");
			data.xbStr=data.xb=='1'?"男["+data.xb+"]":(data.xb=='2'?"女["+data.xb+"]":(data.xb=='0'?"未知的性别["+data.xb+"]":(data.xb=='9'?"未说明的性别["+data.xb+"]":"")));
			data.czlxStr=data.czlx=='1'? "户籍["+data.czlx+"]":(data.czlx=='2'? "非户籍["+data.czlx+"]":"");
			//  (1 A型,2 B型,3 O型,4 AB型,5不详)"
			data.xxStr=data.xx=='1'?"A型["+data.xx+"]":(data.xx=='2'?"B型["+data.xx+"]":(data.xx=='3'?"O型["+data.xx+"]":(data.xx=='4'?"AB型["+data.xx+"]":(data.xx=='5'?"不详["+data.xx+"]":""))));
			//1否  2是  3不详 
			data.rhStr=data.rh=='1'?"否["+data.rh+"]":(data.rh=='2'?"是["+data.rh+"]":(data.rh=='3'?"不详["+data.rh+"]":""));
			for(var i=0;i<mzList.length;i++){
				if(data.mz==mzList[i].bm){
					data.mzStr = mzList[i].mc+"["+data.mz+"]";
					break;
				}
			}
			new Eht.View({selector:msg}).fill(data);
				 
				 
		var cf = new Eht.Confirm({width:400,height:220,padding:6,
			title:"数据交换平台已存在210222198009900989基本信息",message:msg});
		cf.data = data;
		cf.clickOk(function(){
			if(ed._clickOk){
				ed._clickOk(this.data);
			}
		});
		cf.clickNo(function(){
			if(ed._clickNo){
				ed._clickNo(this.data);
			}
		});
		}
		if(ed._loadComplete){
			ed._loadComplete(data);
		};
		},							
		error: function(request){
			new Eht.Alert({title:"错误信息",message:request.responseText});
		}
	});
};
Eht.EmpiDialog.prototype.loadComplete=function(func){
	//func(data);
	this._loadComplete = func;
};
Eht.EmpiDialog.prototype.clickOk=function(func){
	//func(data)
	this._clickOk = func;
};
Eht.EmpiDialog.prototype.clickNo=function(func){
	//func(data)
	this._clickNo = func;
};


Eht.Datagrid.prototype._transColumn = new Object();
Eht.Datagrid.prototype._transColumn.sfzh = function(data,rowIndex,cell){
	var rtn = "";
	if(data.sfzh && data.sfzh.length>8){
		rtn = data.sfzh.substring(0,10) + "*******" + data.sfzh.substring(data.sfzh.length-1);
	}
	return rtn;
};