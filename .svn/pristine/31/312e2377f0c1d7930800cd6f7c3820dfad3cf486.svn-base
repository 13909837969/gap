<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<jsp:include page="module/ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/RegionService.js"></script>
<script type="text/javascript" src="${localCtx}/json/JzJzryjbxxService.js"></script>
<title>jQuery demo</title>
<script type="text/javascript">
$(function(){
	var rs = new RegionService();
	var ss = new JzJzryjbxxService();
	var form = new Eht.Form({selector:"#aaaaa #form",autolayout:true,formCol:2});
	form.fill({xm:"张三",xb:2});
	form.setValue("xm","李四");
	form.getValue("xm");
/* 	form.getData();
	form.validate(); */
	console.log(form.getValue("xm"));
	
	var tableveiw = new Eht.TableView({selector:"#tableview"});
	tableveiw.transColumn("xm4",function(data){
		return "<a href='http://www.baidu.com'>百度</a>";
	});
	tableveiw.loadData(function(page,res){//res -- Eht.Responder()
		ss.findList({},page,res);
		//String -> "",Integer -> 2,
		//BasicMap -> {},
		//JavaBean -> {},
		//List<BasicMap|JavaBean> -> [{}]
		//List<String> -> ["aaa"]
	});
	tableveiw.clickRow(function(data){
		console.log(data);
	});
	
/* 	form.customValid(function(name,value,combo,parent){
		if("xb"==name && (value=="1" ||value=="2")){
			return true;
		}else{
			parent.find(".help-block").text("性别只能为 1，2");
			return false;
		}
	}) */;
	form.change(function(name,value,combo,parent){
		console.log(name+"=" + value);
	});
	$("#submitbtn").click(function(){
		if(form.validate()){
			//验证通过的
			console.log(form.getData());
		}else{
			console.log("验证不通过");
			/// 验证不通过
		}
		
		console.log(form.getData());
	});
});
</script>
</head>
<body id="aaaaa">

<div class="form-group has-error has-feedback">
  <label class="control-label" for="inputSuccess1">Input with success</label>
  <input type="text" class="form-control" id="inputSuccess1" aria-describedby="helpBlock2">
  <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
  <span id="helpBlock2" class="help-block">A block of help text that breaks onto a new line and may extend beyond one line.</span>
</div>


<div id="form">
	<input type="text" name="xm" label="姓名1" valid="{required:true,onlyChinese:true}"/>
	<select name="xb" label="性别1" code="sys000"></select>
	<input type="text" name="nl" label="年龄1" valid="{int:true}"/>

	<input type="text" name="xm2" label="姓名" valid="{required:true,onlyChinese:true}"/>
	<select name="xb2" label="性别" code="sys000"></select>
	<input type="text" name="nl2" label="年龄" valid="{int:true}"/>
</div>
<div id="form2">
	<input type="text" name="xm" label="姓名1" valid="{required:true,onlyChinese:true}"/>
	<select name="xb" label="性别1" code="sys000"></select>
	<input type="text" name="nl" label="年龄1" valid="{int:true}"/>

	<input type="text" name="xm2" label="姓名" valid="{required:true,onlyChinese:true}"/>
	<select name="xb2" label="性别" code="sys000"></select>
	<input type="text" name="nl2" label="年龄" valid="{int:true}"/>
</div>
<input type="button" value="提交" id="submitbtn"/>

<div id="tableview">
		<div field="region_name" label="姓名"></div>
		<div field="id" label="姓名2"></div>
	<div field="xb" label="性别" code="sys000"></div>
	<div field="xm4" label="姓名4"></div>
</div>
</body>
</html>