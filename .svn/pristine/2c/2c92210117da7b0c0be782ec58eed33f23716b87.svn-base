/**
 * 《应用配置管理》页面的css文件
 * @author 王宝
 * @since 2014-04-02
 */

var common = $(function(){
	var as = new ApplicationService();
	//封装按钮调用
	var toolbar=new Eht.Toolbar({selector:"#toolbar"});
	toolbar.disable("#savebut,#delbut");
	toolbar.click(function(id){
		switch(id){
		case "addbut":
			form.enable();
			form.clear("project","reqaddress");
			form.clearData(); //清空数据
			toolbar.enable("#savebut");
			break;
		case "savebut":
			as.save(form.getData(),new Eht.Responder({success:function(){
				new Eht.Tips().show("保存成功");
				form.clear();
				form.disable();
				toolbar.disable("#savebut");
				dg.refresh();
			}
			}));
			break;
		case "delbut":
			if(dg.getSelectedData().length==0){
				new Eht.Alert("请选择要卸载的应用");
				return;
			}
			var cf = new Eht.Confirm("确认要卸载应用吗？卸载之后，应用相关用户无法使用");
			cf.clickOk(function(){
				as.remove(dg.getSelectedData(),new Eht.Responder({success:function(){
					new Eht.Tips().show("删除成功");
					dg.refresh();
				}}));
			});
			
		}
	});
	
	//布局调用
	new Eht.Layout({top:{selector:"#top",border:false},center:{selector:"#center",border:false}});
	new Eht.Layout({top:{selector:"#centerTop",title:"应用管理"},center:{selector:"#centerBom",border:false}});
	
	//表单控制
	var form = new Eht.Form({selector:"#appform"});
	form.disable();
	
	
	//表格调用
	var dg = new Eht.Datagrid({selector:"#Information",multable:false,hasFooter:"true"});
	dg.transColumn("frule", function(data){
		var rtn = "机构用户";
		if(data.frule=="PSA"){
			rtn = "平台管理员";
		}
		return rtn;
	});
	dg.loadData(function(page,res){
		as.find({},page,res);
	});
	
	
	
	dg.clickRow(function(data,selected){
		if(selected){
			form.fill(data);
			form.enable();
			toolbar.enable("#savebut,#delbut");
		}else{
			toolbar.disable("#savebut,#delbut");
		}

	});
	
	$(".eht-toolbar-file").change(function(){
		if($(this).val()!=""){
			setTimeout(function(){
				$("#uploadForm").submit();
			},200);
		}
	});
	$.fn.refresh=function(){
		dg.refresh();
	};
});
function uploadSuccess(v){
	common.refresh();
};