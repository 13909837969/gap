<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
<title>矫正人员信息管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/YwglJzryxxService.js"></script>
<script type="text/javascript">
$(function(){
	var ywgl = new YwglJzryxxService();
	var query_jg = new Eht.Form({selector:"#ywgl_jg_query"});  //机构查询条件
	var query_ry = new Eht.Form({selector:"#ywgl_query"});     //人员信息查询条件
	var table_jg = new Eht.TableView({selector:"#ywgl_table_jg"});   //机构table
	var table_ry = new Eht.TableView({selector:"#ywgl_table_ry"});   //人员table
	table_jg.loadData(function(page,res){  //机构数据
		ywgl.find_jg(query_jg.getData(),page,res);
	});
	//是否采集
	table_ry.transColumn("sfcj",function(data,rowIndex,cell,field){
		var div = $("<div></div>");
		var vs = Eht.DataCode.sys001;
		var vn = data.sfcj;
		for(var i=0;i<vs.length;i++){
			if(vs[i].f_code==data.sfcj){
				vn = vs[i].f_name;
				break;
			}
		}
		div.append("<font>" + data.sfcj + "," + vn + "</font>");
		return div;
	});
	//是否转派
	table_ry.transColumn("sfzp",function(data,rowIndex,cell,field){
		var div = $("<div></div>");
		if(data.sfzp == '0'){
			div.append("<font>" + data.sfzp + ",否" + "</font>");
		}
		else if(data.sfzp == '1'){
			div.append("<font>" + data.sfzp + ",是" + "</font>");
		}
		return div;
	});
	//是否解除
	table_ry.transColumn("jcjz",function(data,rowIndex,cell,field){
		var div = $("<div></div>");
		if(data.jcjz == '0'){
			div.append("<font>" + data.jcjz + ",否" + "</font>");
		}
		else if(data.jcjz == '1'){
			div.append("<font>" + data.jcjz + ",解除社区矫正" + "</font>");
		}
		else if(data.jcjz == '2'){
			div.append("<font>" + data.jcjz + ",监狱刑满释放" + "</font>");
		}
		else if(data.jcjz == '3'){
			div.append("<font>" + data.jcjz + ",看守所刑满释放" + "</font>");
		}
		else if(data.jcjz == '4'){
			div.append("<font>" + data.jcjz + ",公安机关落实管控" + "</font>");
		}
		return div;
	});

	table_ry.loadData(function(page,res){    //人员数据
		var q = query_ry.getData();
		var query = {};
		var sd = table_jg.getSelectedData();
		if(sd.length==1){
			query["A.orgid[eq]"] = sd[0].id;
		}
	    for(var p in q){
	    	query[p] = q[p];
	    }
		ywgl.find_ry(query,page,res);
	});
	
	$("#ywgl_jg_btn").click(function(){  //机构查询按钮
		table_jg.refresh();   //table更新
		query_jg.clear();
	});
	
	table_jg.clickRow(function(data){  //选中某一个机构
	    table_ry.refresh();
	});
	
	$("#ywgl_query_btn").click(function(){   //人员查询按钮
		table_ry.refresh();
		//query_ry.clear();
	});
	
	$("#ywgl_delete_btn").click(function(){   //人员删除按钮
		var sd_ry = table_ry.getSelectedData();
		if(sd_ry.length==1){
			var c = new Eht.Confirm();
			c.show("请确认是否删除！");
			c.onOk(function(){
				ywgl.deleteOne({"id":sd_ry[0].id},new Eht.Responder({
					success:function(){
						table_ry.refresh();
						//query_ry.clear();
						c.close();
						new Eht.Tips().show();
					}
				}));
			});
		}
	});

});
</script>
</head>
<body>
<div style="width:100%;padding:10px;">
	<div id="ywgl_query" >
		姓名：<input name="A.xm[like]">
		身份证号：<input name="A.sfzh[like]">
		个人联系电话：<input name="A.grlxdh[like]">
		<!-- <input id="id_hid" type="hidden"></input> -->
		<button id="ywgl_query_btn" class="btn">查询</button>
		
		<button id="ywgl_delete_btn" class="btn" style="float:right;">删除</button>
	</div>
</div>
<div>
	<div style="width:25%;float:left;margin-left:10px;margin-top:10px;">
		<div id="ywgl_jg_query" style="margin-left:32%;">  <!-- 160px -->
			<input name="jgmc[like]" placeholder="请输入机构名称...">
			<button id="ywgl_jg_btn" class="but">查询</button>
		</div>
		<div id="ywgl_table_jg" style="margin-top:-30px;">
			<div field="region_name" label="行政区" width="100"></div>
			<div name="jgmc" field="jgmc" ></div>			
		</div>
	</div>
	
	<div id="ywgl_table_ry" style="width:73%;float:right;margin-right:10px;margin-top:6px;">
		<div field="id" label="选项" checkbox="true" width="60"></div>
		<div field="xm" label="姓名" width="100"></div>
		<div field="xb" label="性别" code="SYS000"></div>
		<div field="sfzh" label="身份证号"></div>
		<div field="grlxdh" label="个人联系电话"></div>
		<div field="sfcj" label="是否采集" code="SYS001"></div>
		<div field="sfzp" label="是否转派" code="SYS001"></div>
		<div field="jcjz" label="是否解除" code="SYS001"></div>
		<div field="jgmc" label="机构名称"></div>
	</div>
</div>

</body>
</html>