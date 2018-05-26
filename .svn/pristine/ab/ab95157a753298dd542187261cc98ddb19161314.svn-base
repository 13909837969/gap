<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>tree demo</title>
<jsp:include page="../common.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var data=[{label:"label1",uuid:"1",
	          	children:[{label:"label1-1",selected:true,
	        	  				children:[{label:"label1-1-1"},{label:"label1-1-2"}]},
	                    {label:"label1-2"}]},
	          {label:"label2",_id:"2",
		       children:[{label:"label2-1"},{label:"label2-2"}]
	          }];
	for(var i=0;i<100;i++){
		var obj = {label:"label_" + i};
		data.push(obj);
		obj.children=[];
		for(var j=0;j<100;j++){
			var o = {label:"label_" +  i + "_" + j};
			obj.children.push(o);
			o.children=[];
			for(var k=0;k<2;k++){
				o.children.push({label:"label_" + k});
			}
		}
	}
	var tree = new Eht.Tree({selector:"#tree",multable:true,hideChildren:true});
	
	tree.clickRow(function(data){
		
	});
	tree.loadData(data);
	
	$("#hideChildren").click(function(){
		tree.hideChildren();
	});
	$("#showChildren").click(function(){
		tree.showChildren();
	});
	$("#getSelectedData").click(function(){
		console.log(tree.getSelectedData());

	});
});
</script>
</head>
<body>
<div>
	<input type="button" value="hideChildren" id="hideChildren"/>
	<input type="button" value="showChildren" id="showChildren"/>
	<input type="button" value="getSelectedData" id="getSelectedData"/>
 </div>
<div id="tree" style="overflow:auto;width:300px;">

</div>

<ul>
	<li>1</li>
	<li>2
		<ul>
			<li>2.1</li>
			<li>2.2</li>
		</ul>
	</li>
	
	<li>3
	</li>
	<ul>
		<li>3.1</li>
		<li>3.2</li>
	</ul>
	
</ul>
</body>
</html>