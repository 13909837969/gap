<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Demo</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="/ph/json/MBasicService.js"></script>
<script type="text/javascript">
var testData = {
		validate1:"210202",
		bm:"210101",
		date:["2002-02-03","2003-03-06"],
		data:["2","22"],
		radio1:"2",
		radio2:"3",
		checkbox:["2","3"],
		data1:"数据1",
		data2:"数据2",
		data3:["数据3-1","数据3-2"],
		groupData:[{name:"张三",age:30,birthday:"1982-03-06",mz:"02",radio5:2,checkbox2:[1,2],other:["other1","other2"]},
		           {name:"李红",age:28,birthday:"1984-03-06",mz:"03",radio6:1,checkbox2:"2",other:"other1other2"}]
}
$(function(){
	var form = new Eht.Form({selector:"#form"});
	form.change(function(e){
		console.log("change :"+ $(e.target).val());
		if($(e.target).attr("name")=="ssyw"){
			form.setValue("ss",$(e.target).val());
		}
	});
	$("#button").click(function(){
		$("#getform").text(JSON.stringify(form.getData()));
	});
	$("#fill").click(function(){
		form.fill(testData);
	});
	$("#clear").click(function(){
		form.clear("date",true);
	});
	$("#disable").click(function(){
		form.disable();
	});
	$("#enable").click(function(){
		form.enable();
	});
	$("#validate").click(function(){
		alert(form.validate());
	});
	$("#setValue").click(function(){
		form.setValue("name2","2222");
		form.setValue("check1","check1-1");
		form.setValue("check1","check1-2");
		form.setValue("radio1","radio1-3");
		
	});
	$("#getValue").click(function(){
		console.log(form.getValue("name1"));
		console.log(form.getValue("radio1"));
		console.log(form.getValue("check1"));
		console.log(form.getValue("date"));
		console.log(form.getValue("date3"));
		alert("date3:" + 	form.getValue("date3"));
	});
	$("#setO2mObj").click(function(){
		form.setO2mObj("groupData",testData.groupData);
	});
	$("#getData").click(function(){
		console.log(form.getData());
	});
		
});
function s(){
	var mbs = new MBasicService();
	mbs.async = false;
	var r = mbs.find("ph_res_area",{"bm[eq]":$("#validate1").val()});
	if(r && r.length>0){
		return false;
	}else{
		return true;
	}
}

function extendfunc(form,flag){
	var rtn = {value:false,"message":"error-error"};
	alert(form.getValue("date3"));
	if(flag==1){
		rtn.message = "sssssss";
	}
	if(flag==2){
		rtn.message = "aaaaa";
	}
	form.change(function(){
		alert(44);
	});
	return rtn;
}
</script>
</head>
<body>
<input type="button" id="button" name="button1" value="get"/>
<input type="button" id="fill" name="button1" value="fill"/>
<input type="button" id="clear" name="button2" value="clear"/>
<input type="button" id="disable" value="disable"/>
<input type="button" id="enable" value="enable"/>
<input type="button" id="validate" value="validate"/>
<input type="button" id="setValue" value="setValue"/>
<input type="button" id="getValue" value="getValue"/>
<input type="button" id="setO2mObj" value="setO2mObj"/>
<input type="button" id="getData" value="getData"/>
<br/>
<div id="form" style="border:1px solid #aaa;width:600px;">
	<fieldset>
	<legend>验证(唯一性)</legend>
	<div>
		<!-- 验证方法1  -->
		验证方法1：<input id="validate1" name="validate1" validate="[{required:true},{unique:true,callback:'s()'}]"   oldvalue="21" value="name2">
		<!-- 验证方法2  -->
		验证方法2：<input  validate="[{required:true},{unique:true,type:'mongo',table:'ph_res_area'}]" name="bm" value="bm" oldvalue="2101">
		<br>验证扩展1：<input  validate="[{extend:true,callback:'extendfunc(form,1)'}]" name="ext1" value="bm" >
		<br>验证扩展2：<input  validate="[{extend:true,callback:extendfunc(form,2)}]" name="ext2" value="bm">
		<br>验证扩展3：<input  validate="[{extend:true,callback:extendfunc}]" name="ext3" value="bm">
	</div>
	</fieldset>
	
	<fieldset>
	<legend>字典数据</legend>
	<div>
		日期1：<input type="text" ehttype="date" name="date"/> 
		日期2：<input type="text" ehttype="date" name="date"/>
		日期3：<input type="text" ehttype="date" name="date3"/>
		<br/>
		数据1:<input type="text" code="GB0001" name="data"/>
		数据2:<input type="text" code="GB0002" ehttype="tree" name="data"/><br/>
		数据3：<input type="text" code="[{v:1,d:'label1'},{v:2,d:'label2'}]" name="data3"/>
	</div>
	</fieldset>
	<fieldset>
		<legend>数据正常录入</legend>
		<div>
		数据1：<input type="text" name="data1"/> 
		数据2：<input type="text" name="data2"/>
		<br/>
		数据3-1:<input type="text" name="data3"/>
		数据3-2:<input type="text" name="data3"/>
	</div>
	</fieldset>
	<fieldset>
		<legend>选择</legend>
		<div>
			<input type="radio" name="radio1" value="1"/>
			<input type="radio" name="radio1" value="2"/>
			<input type="radio" name="radio1" value="3"/>
			<hr/>
			<input type="radio" name="radio2" value="1"/>
			<input type="radio" name="radio2" value="2"/>
			<input type="radio" name="radio2" value="3"/>
			<hr/>
			<input type="checkbox" name="checkbox" value="1"/>
			<input type="checkbox" name="checkbox" value="2"/>
			<input type="checkbox" name="checkbox" value="3"/>
		</div>
	</fieldset>
	<fieldset>
		<legend>一对多分组数据</legend>
		<div>
			父亲信息:<br/>姓名<input type="text" parent="groupData" group="1" name="name"/> 
			     年龄<input type="text" parent="groupData" group="1" name="age"/>
			  出生日期 <input type="text" parent="groupData" group="1" name="birthday" ehttype="date"/>
			  民族<input type="text" parent="groupData" group="1" name="mz" code="GB0008" mult=true/>
			  <fieldset>
			  <input type="radio" parent="groupData" group="1"  name="radio5" value="1"/>
			  <input type="radio" parent="groupData" group="1"  name="radio5" value="2"/>
			  <input type="checkbox" parent="groupData" group="1"  name="checkbox2" value="1"/>
			  <input type="checkbox" parent="groupData" group="1"  name="checkbox2" value="2"/>
			  </fieldset>
			  <input type="text" parent="groupData" group="1"  name="other" validate="[{date:true}]"/>
			  <input type="text" parent="groupData" group="1"  name="other"/>
			  <input type="text" parent="groupData" group="1"  name="other"/>
			<br/>
			母亲信息:<br/>姓名<input type="text" parent="groupData" group="2" name="name"/> 
			     年龄<input type="text" parent="groupData" group="2" name="age"/>
			  出生日期 <input type="text" parent="groupData" group="2" name="birthday" ehttype="date"/>
			    民族<input type="text" parent="groupData" group="2" name="mz" code="GB0008" ehttype="tree"/>
			    <fieldset>
			    	<input type="radio" parent="groupData" group="2"  name="radio6" value="1"/>
			  		<input type="radio" parent="groupData" group="2"  name="radio6" value="2"/>
			  <input type="checkbox" parent="groupData" group="2"  name="checkbox2" value="1"/>
			  <input type="checkbox" parent="groupData" group="2"  name="checkbox2" value="2"/>
			  </fieldset>
			  <input type="text" parent="groupData" group="2"  name="other"/>
			  <input type="text" parent="groupData" group="2"  name="other"/>
			  <input type="text" parent="groupData" group="2"  name="other"/>
			<br>  整形数值为数补齐
			  <input type="text" name="int" validate="[{int:true,padded:0,maxNum:59,minNum:0}]" maxlength="2"/>
		</div>
	</fieldset>
	<input type="button" name="button1" value="button"/>
</div>

<div id="getform"></div>
</body>
</html>