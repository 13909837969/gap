<%@ page language="java" contentType="text/html; charset= UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style type="text/css">
#form_table{
	 margin: auto;
	 margin-top: 2%;
}
#form_table tr td{
	padding-right: 10px;
	padding-bottom: 10px;
}
input{
	-web-kit-appearance:none;
  	-moz-appearance: none;
  	font-size:1.4em;
	height:2.7em;
	border-radius:4px;
	border:1px solid #c8cccf;
	color:#6a6f77;
	line-height: 20px;
  }
input[type="radio"] + label::before {
    content: "\a0"; /*不换行空格*/
    display: inline-block;
    vertical-align: middle;
    font-size: 18px;
    width: 1em;
    height: 1em;
    margin-right: .4em;
    border-radius: 50%;
    border: 1px solid #999;
    text-indent: .15em;
    line-height: 1; 
}
input[type="radio"]:checked + label::before {
    background-color:#999;
    background-clip: content-box;
    padding: .2em;
}
input[type="radio"] {
    position: absolute;
    clip: rect(0, 0, 0, 0);
}
 /* 滚动条样式 */
.test{
    width: 95%;
    height: 560px;
    float: left;
    border: none;
    overflow :yes
}
.activity-description{
    width: 100%;
    height: 200px;
    margin: 0 auto;
 
}
.test-1::-webkit-scrollbar {/*滚动条整体样式*/
        width: 10px;     /*高宽分别对应横竖滚动条的尺寸*/
        height: 1px;
    }
.test-1::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
        border-radius: 10px;
         -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        background: #535353;
    }
.test-1::-webkit-scrollbar-track {/*滚动条里面轨道*/
        -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        border-radius: 10px;
        background: #EDEDED;
    }
</style>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript"  src="${localCtx}/json/SqlcService.js"></script>
<script type="text/javascript">
var list;
var tree;
var name;
var orgid;
//添加子节点 id
var divid;
var splc = new SqlcService();
	$(function() {
		
		//顶部单选列表
		splc.findDocument(new Eht.Responder({success:function(data){
			if (data.length > 0 ) {
				for (var i = 0; i < data.length; i++) {
					$("#djlx").append('<option  value="'+ data[i].f_id+'">' + data[i].f_name +'</option>');
				}
			}
		}}));
		
		//机构树
		 tree = new Eht.BootTree({selector:"#sqlc_form_add #tree",labelField:"jgmc"});
		var sqlc_add = new SqlcService();
		tree.loadData(function(res){
			sqlc_add.findTree(res);
		});
		//获取点击的li
		 var data = tree.clickItem(function(ds){
			 /* 
			 	id:"NM0000000000-0000-0000-0000000-01144" //检索 子集司法所的主键
				jgbm:"150400030101010001"
				jgmc:"巴林左旗司法局"
				nodeId:1
				parentid:"NM0000000000-0000-0000-0000000-01143"
				regionid:"150422"
			 */
			 var id = ds.id; //检索子集司法所
			  name = ds.jgmc;
			//添加子节点 id
			 divid = ds.nodeId;
			 //司法所的select
			 splc.findJudiciary(id,new Eht.Responder({success:function(data){
					if (data.length > 0 ) {
						$("#sfsselect").html('');
						for (var i = 0; i < data.length; i++) {
							$("#sfsselect").append('<option  value="'+ data[i].id+'">'+"["+ name +"]" + data[i].jgmc +'</option>');
							//隐藏Tree
							$(".list-group").hide();
							$("#tree").append('<div id="treediv" > <a style="text-decoration:none;cursor: pointer;" href="javascript:void(0);" id="th"><img src="mapimg/backk.png"/>返回 </a> <div><ul id="treeul" style="margin-top: 14px;margin-left: -10px;"></ul>');
							$("#treeul").append('<a style="text-decoration:none;cursor: pointer;"><li id="'+divid+'" style="list-style-type:none;" onclick="sel('+"'"+data[i].id+"'"+')">' +data[i].jgmc+'</li></a>');
							orgid = data[i].id;//orgid;
						}
					}
				}}));
		}); 
		
		$("#splc_save").click(function(){
			addAll();
		});
		$("#splc_add_team_save").click(function(){
			add();
		});
		$("#splc_addteam").click(function(){
			addxzz();
		});
		/* 返回按钮 */
		$("#th").click(function() {
			th();
		});
			/* 返回按钮 */
			function th() {
				$("#treediv").hide();
				$("#treeul").html('');
				$(".list-group").show();
			}
			/* 新增组别 */
			function addxzz() {
				if ($("#djlx").val() == '') {
					alert("请选择单据类型！");
				}else{
					$("#gzzpz").val('ok');
					$("#table1").hide();
					$("#table2").show();
				}
			}
			/* 保存新增工作组 */
			function add(){
				/* sys_audit_team */
				var datas = {
							"f_teamname":$("#gzzmc").val(),
							"f_flag":$("input[type='radio']:checked").val(),
							"f_billid":$("#djlx").val(),
							"orgid":orgid};
				/* SYS_AUDIT_APPROVER  */
				var datass = {
						"f_approver":$("#ryid2").val(),
						"orgid":orgid};
				splc.save(datas,datass,new Eht.Responder({success:function(data){
					debugger;
					$("#table2").hide();
					$("#table1").show();
				//反显系统同工作组
				if(data.length > 0){
					for (var i = 0; i < data.length; i++) {
						$("#gzzxx").html('');
						$("#gzzxx").append('<tbody><tr>'+'<td id="table2_jg"><input id="'+data[i].f_teamid+'" name="checkbox_n" type="checkbox" value="'+data[i].f_teamname+'"><span>'+data[i].f_teamname+'</span></td><td id="table2_tr_ry">'+data[i].f_approver+'</td></tr></tbody>');
					}
				}
				}}));
			}
			
			/* 保存所有 */
			function addAll() {
				/* sys_audit_team */
				 obj = document.getElementsByName("checkbox_n");
				    check_val = [];
				    for(k in obj){
				        if(obj[k].checked)
				            check_val.push(obj[k].value);
				    }
				  var f_teamid = check_val;
				var datas = {
							"f_bsid":$("input[type='radio']:checked").text(),
							"f_approver":$("#ryid1").val(),
							"f_billid":$("#djlx").val(),
							"F_TEAMID":f_teamid, //协同小组
							"f_lvl":$("#ryid1").val(),
							"orgid":orgid};
				splc.saveAll(datas,new Eht.Responder({success:function(){
					$("#table2").hide();
					$("#table1").show();
					window.parent.location.reload();//关闭iframe
					self.window.opener.locaction.reload();//刷新父级窗口
				}}));
			}
	});
	/* 拖拽部分 */
	/* 点击添加 */
	/* 选择人员 */
	function choose(id,username) {
		var i = 0;
		j=i+1;
		var t = $("#gzzpz").val();
		if (t == '') {
			$("#table1_tr").append('<tbody><tr>'+'<td id="table1_tr_jg"><input id="ryid1" type="hidden" value="'+id+'">'+name+'</td><td id="table1_tr_ry">'+username+'</td><td id="table1_tr_jb">'+j+'</td></tr></tbody>');
		}else{
			$("#table2_tr").append('<tbody><tr>'+'<td id="table2_jg"><input id="ryid2" type="hidden" value="'+id+'">'+name+'</td><td id="table2_tr_ry">'+username+'</td></tr></tbody>');
		}
		
	}
	 function sel(orgid) {
			//异步加载司法所的工作人员
			 splc.findJudiciaryUser(orgid,new Eht.Responder({success:function(data){
				 $("#treeul").append('<div class="test test-1"  style="position:absolute; height:80%;width: 88px; overflow:auto"><div class="activity-zhuangt">'+
					       '<div class="activity-description" id="treeuldiv" ></div>'+
							'</div></div>');
				if (data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						$("#treeuldiv").append('<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>'+
						'<a style="text-decoration:none;cursor: pointer;">'+
						'<li style="list-style-type:none;margin-left: 20px;" onclick="choose('+"'"+data[i].id +"',"+"'"+ data[i].xm+"'"+')" id="'+data[i].id+'">'+ data[i].xm+'</li></a>');
					}
				}
			 }}));
		}
</script>

</head>
<body>
<div id="sqlc_form_add" class="container-fluid">
	<!-- 机构Tree -->
	<div id="tree" style="float: left;margin-right: 20px;"></div>
	<!--  -->
	<div>单据类型 
		<span>&nbsp;&nbsp;</span>
		<select id="djlx" style="border-radius: 5px;height: 24px;margin-right: 12px;">
			<option value="">请选择</option>
		</select>
			<span>司法所</span>
			<span>&nbsp;&nbsp;</span>
		<select id="sfsselect" style="border-radius: 5px;height: 24px;margin-right: 12px;width: 30%;">
			<option value="">请先选择司法局/司法所</option>
		</select>
	</div>
	
	<!--  -->
	<!-- 表单部分 -->
		<div style="float:  left;width: 100%;">
			<div style="margin-top: 10%;margin-left: 15%;">
			<div style="margin-left: 7%;">
			<input type="button" style="border-radius: 5px;width: 9%;margin-right: 10px;" value="降级">
			<input type="button" style="border-radius: 5px;width: 9%;margin-right: 10px;" value="升级">
			<input type="button" style="border-radius: 5px;width: 9%;" value="移除">
			<div style="height: 5px;"></div>
			<div >
				<div class="test test-1"  style="position:absolute; height:80%;width: 33%; overflow:auto">
					<div class="activity-zhuangt">
						<div class="activity-description">
							<table id="table1_tr" class="table table-striped table-hover ltrhao-table table-bordered" style="width: 100%;">
								<thead>
									<tr>
										<th>机构名称</th><th>审核人</th><th>级别</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		</div>
		
		<div style="float: right;margin-top: -15.5%;">
		<input type="button" id="splc_addteam" style="border-radius: 5px;width: 50%;" value="新增组">
		<div style="height: 5px;"></div>
		<div>
			<div  id="table1" style="width: 100%;">
			<table id="gzzxx" class="table table-striped table-hover ltrhao-table table-bordered" style="width: 100%;">
					<thead>
						<tr>
							<th>审批工作组</th><th>组员</th>
						</tr>
					</thead>
			</table>
			</div>
			<!-- 新增组别 -->
			<div  id="table2" style="display: none;">
			<input type="hidden" id="gzzpz" value=""><!-- 工作组的新增判断 -->
			<div>
			<div>工作组名称 <input type="text" id="gzzmc" value="" placeholder="请输入工作组名称..."/> </div>
			<div>协调标记 </br>
				<div style="margin-left: 15%;">
					<input type="radio" name="radio1" id="one" value="0"/>
					<label for="one">有一个通过，就走下一个流程</label>
				</div>
				<div style="margin-left: 15%;">
					<input type="radio" name="radio1" id="full" value="1"/>
					<label for="full">全部通过后，就走下一个流程</label>
				</div>
			</div>
			<table id="table2_tr" class="table table-striped table-hover ltrhao-table table-bordered" style="width: 100%;">
					<thead>
						<tr>
							<th>机构名称</th><th>组员</th>
						</tr>
					</thead>
			</table>
			</div>
			<input style="margin-left: 176px;margin-top: 17px;" type="button" id="splc_add_team_save" value="确定">
			</div>
		</div>
	</div>
</div>
<div style="margin-top: 46%;margin-left: 72%;">
	<input style="margin-left: 176px;margin-top: 17px;" type="button" value="保存" id="splc_save">
</div>

</body>
</html>