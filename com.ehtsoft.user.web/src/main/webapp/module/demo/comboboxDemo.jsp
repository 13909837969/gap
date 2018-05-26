<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>combobox</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript" src="../../json/MBasicService.js"></script>
<script type="text/javascript" src="../../json/AreaService.js"></script>
<script type="text/javascript">

$(function(){
	var as = new AreaService();
	var ds1 = [];
	for(var i=0;i<50;i++){
		ds1.push({label:"label_" + i,value:"value_" + i});
	}
	var cb1 = new Eht.ComboBox({selector:"#txt1",valueField:"value",readOnly:true});
	cb1.setReadOnly(false);
	cb1.loadData(ds1);
	
	var cb2 = new Eht.ComboBox({selector:"#txt2",valueField:"value"});	
	cb2.loadData(ds1);
	
	var mbs = new MBasicService();
	
	var a = new Eht.Datagrid({selector:"#comboboxdg"});
	a.loadData(function(page,res){
		mbs.find("ph_test",{},page,res);
	});
	
	var cb3 = new Eht.ComboBox({selector:"#txt3",labelField:"field2",valueField:"field1"});
	cb3.setFeature(a);
  	
 	var cb4 = new Eht.ComboBox({selector:"#txt4",labelField:"field2",valueField:"field1"});
 	cb4.setFeature(a);
	
	
	var cb5 = new Eht.ComboBox({selector:"#txt5"});
	cb5.setFeature(new Eht.DatePicker());
	
	var cb6 = new Eht.ComboBox({selector:"#txt6",labelField:"mc",valueField:"bm",
			feature:new Eht.Tree({labelField:"mc",css:{border:"1px solid #c3d8f9"}})}); 
	cb6.loadData(function(res){
		as.find({},res);
	});
	
	$("#setValue").click(function(){
		cb1.setValue($("#txtset").val());
		cb2.setValue($("#txtset").val());
		cb3.setValue("Value_8_1");
		cb4.setValue("210102001");
		cb5.setValue("20020303");
	});
	$("#enable").click(function(){
		cb1.enable();
	});
	$("#disable").click(function(){
		cb1.disable();
	});
	
	$("#getValue").click(function(){
		$("#value").html(cb1.getValue() + "," + cb3.getValue() + "," + cb4.getValue()  + "," + cb5.getValue());
	});
});
</script>
</head>
<body>
<div id="value"></div>
<input type="text" value="value_4" id="txtset"/>
<input type="button" value="setValue" id="setValue"/>
<input type="button" value="getValue" id="getValue"/>
<input type="button" value="disable" id="disable"/>
<input type="button" value="enable" id="enable"/>
<br/>
<input type='text' style="ime-mode:disabled;" name="name1" id="txt1"/>
<input type='text' name="name1" id="txt2" >

<input type='text' name="name1" id="txt3" >


<input type='text' name="name1" id="txt4" >
<input type="text"  name="name1"  id="txt5"/>
<input type="text"  name="name1"  id="txt6"/>
<input type="text"  name="name1"  id="txt7"/>
<div id="tree">

</div>

<table id="comboboxdg">
	<tr>
		<td field="field1">label1</td><td field="field2">label2</td>
	</tr>
</table>
</body>
</html>