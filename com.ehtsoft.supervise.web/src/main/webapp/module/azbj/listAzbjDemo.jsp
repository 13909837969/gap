<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <title>矫正人员综合管理系统</title>
    <jsp:include page="../ltrhao-common.jsp"></jsp:include>
    <script type="text/javascript" src="${localCtx}/json/AzbjDemoService.js"></script>
    <script type="text/javascript">
    $(function(){
    	var azbj = new AzbjDemoService();
    	/**  
    	不针对任何组件封装的写法
    	var pg = new Eht.Paginate();
    	pg.indexPage = 3;
    	azbj.findSimple({xm:"张"},pg,new Eht.Responder({
    		success:function(data){
    			console.log(data);
    			//ResultList
    			//{rows:[{xm:""},{}],paginate:{indexPage:3}}
    			
    			//List
    			//[{},{},{}]
    			//BasicMap|javaBean
    			//{xm:"",xb:""}
    		},
    		error:function(msg){
    			
    		}
    	}));
    	
    	var res = new Eht.Resonder();
    	res.success=function(data){
    		
    	};
    	azbj.findOne1("",res);
    	*/
    	var form = new Eht.Form({selector:"#azbj_form",autolayout:true});
    	var qf = new Eht.Form({selector:"#query_form",codeEmpty:true,codeEmptyLabel:"全部"});
    	//表格
    	var table = new Eht.TableView({selector:"#azbj_table",multable:true});
    	table.transColumn("xb",function(data,rowIndex,cell,field){
    		var s = data.xb;
    		if(data.xb=="1"){
    			s = "男";
    		}else{
    			s = "女---";
    		}
    		return s;
    	});
    	table.transColumn("xh",function(data,rowIndex){
    		
    		return rowIndex + (this.opt.paginate.indexPage -1) * this.opt.paginate.pageCount + 1;
    	});
    	table.transColumn("an",function(data){
    		var div = $("<div></div>");
    		var btn = $("<input type='button' value='点获取数据'/>");
    		btn.data(data);
    		btn.click(function(){
    			//new Eht.Alert({title:"系统提示"}).show($(this).data().xm);
    			var c=new Eht.Confirm();
    			c.show("是否。。");
    			c.onOk(function(){
    				alert(1);
    				this.close();
    			});
    			return false;
    		});
    		div.append(btn);
    		var btn2 = $("<input type='button' value='aaa'>");
    		div.append(btn2);
    		btn2.data(data);
    		btn2.click(function(){
    			$("#azbj_demo").modal();
    			form.fill($(this).data());
    		});
    		return div;
    	});
    	table.loadData(function(page,res){
    		//{"xm[like]":"吴"}
    		azbj.findSimple(qf.getData(),page,res);
    	});
    	
    
    	$("#__save").click(function(){
    		if(form.validate()){
	    		var data = form.getData();
	    		console.log(data);
	    		azbj.saveDemo(data,new Eht.Responder({
	    			success:function(){
	    				$("#azbj_demo").modal("hide");
	    				new Eht.Tips().show("保存成功");
	    				table.refresh();
	    			}
	    		}));
    		}
    	});
    	
    	$("#querybtn").click(function(){
    		table.refresh();
    	});
    });
    </script>
 </head>
<body>
<!-- 操作按钮部分 -->
<div class="toolbar">
	<button type="button" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增</button>
	<button type="button" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>查看</button>
	<button type="button" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
	<button type="button" class="btn btn-default" style="margin-left:10px;">
			<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>			
</div>
<!-- 查询条件部分 -->
<form class="form-inline" style="margin:10px;">
	<div id="query_form">
		<div class="form-group">
			<label for="xm">姓名</label>
			<input type="text" class="form-control" name="xm[like]" id="xm" placeholder="姓名">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="xb">性别</label>
			<input type="text" class="form-control" name="xb[eq]" id="xb" placeholder="性别" code="sys000">
		</div>
		<div class="form-group" style="margin-left:10px;">
			<label for="xb2">性别2</label>
			<input type="text" class="form-control" name="xb[eq]" id="xb2" placeholder="性别2" code="sys000">
		</div>
		<button type="button" class="btn btn-primary" style="margin-left:10px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询</button>
	</div>
</form>

<div id="azbj_table">
	<div field="xx2" label="<input type='checkbox'>" width="80" checkbox=true></div>
	<div field="xx1" label="选项" width="80" checkbox=true></div>
    <div field="xh" label="序号" width="80"></div>
	<div field="xm" label="姓名"></div>
	<div field="sqjzrybh" label="人员编号"></div>
	<div field="xb" label="性别"></div>
	<div field="mz" label="民族" code="sys003"></div>
	<div field="an" label="按钮"></div>
</div>

<!-- Modal -->
<div class="modal fade" id="azbj_demo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
      	<div id="azbj_form">
         	<input type="text" name="xm" label="姓名" valid="{required:true}"/>
         	<input type="text" name="xb" label="性别" code="sys000"/>
         	<div>
         		<input type="text" name="xb2" label="性别" code="sys000"/>
         	</div>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" id="__save" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>