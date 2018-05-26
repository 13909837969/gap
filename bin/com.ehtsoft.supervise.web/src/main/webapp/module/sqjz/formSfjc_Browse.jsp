<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>司法奖惩-操作页</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx}/json/JzrySfjcService.js"></script>
<script type="text/javascript">

	$(function() {
		var service = new JzrySfjcService();
		var jclb = Eht.DataCode["sys082"];//获取奖惩类别字典-数组
		var jcyy = Eht.DataCode["sys083"];//获取奖惩原因字典-数组
		var addressJclb = $("#sqjz_fromSfjc_Browse #jclb");//奖惩类别插入地址
		var addressJcyy = $("#sqjz_fromSfjc_Browse #jcyy");//奖惩原因插入地址
		var jcid = "${param.jcid}";
		var form = new Eht.Form({selector:'#sqjz_fromSfjc_Browse #form'});
		/****给奖惩类别插入下拉选项*****/
		for(var i=0;i<jclb.length;i++){
			if(jclb[i].f_code != 02){
				if(jclb[i].f_code == "0201"){
					var option = '<option value="' +jclb[i].f_code + '">治安处罚-依社区矫正机构提请</option>';
				}else if(jclb[i].f_code == "0202"){
					var option = '<option value="' +jclb[i].f_code + '">治安处罚-公安机关依法给予</option>';
				}else{
					var option = '<option value="' +jclb[i].f_code + '">'+ jclb[i].f_name + '</option>';
				}
			}else{
				continue;
			}
			addressJclb.append(option);
		};
		/****当矫正类别发生变化时，奖惩原因跟随其变化，需调如下方法做判断****/
		function decideJcyy(lb){
			if(lb == "01"){//当矫正类别选择“01”-警告时，奖惩原因选择
				addressJcyy.empty();
				for(var j=0;j<6;j++){
					inputJcyy(j);
				}
			}
			if(lb == "02"||lb == "0201"||lb == "0202"){
				addressJcyy.empty();
				for(var j=6;j<8;j++){
					inputJcyy(j);
				}
			}
			if(lb == "03"){
				addressJcyy.empty();
				for(var j=8;j<jcyy.length;j++){
					inputJcyy(j);
				}
			}
		};
		
		/****当矫正类别发生变化时，奖惩原因跟随其变化，需调如下方法动态插入****/
		function inputJcyy(j){
			var input = '<input type="checkbox" name="jcyy" disabled="disabled"; value="'+jcyy[j].f_code+'">'+jcyy[j].f_name+'<br>';
			addressJcyy.append(input);
		};
		
		if(jcid != ""){
			/* 当父页选中个人信息并单击修改按钮时，给该页填充数据 */
			service.findOne(jcid,new Eht.Responder({
				success:function(data){
					var lb = data.jclb;
					decideJcyy(lb);
					form.fill(data);
				}
			}));
		}
	});
</script>
<style type="text/css">
	#sqjz_fromSfjc_Browse{
		scrollTop:100px;
	}
	#sqjz_fromSfjc_Browse #tableaaa{
		z-index:999;
		width:73%;
		height:300px;
		background-color: #FFFFFF;
		margin:auto; 
		position: absolute;
		top: -20px; left: 98px; bottom: 0; right: 0;  
		overflow-y:auto;
	    overflow-x:auto;
	}
	#sqjz_fromSfjc_Browse #tableaaa .table>thead>tr>th{
		background:#EEE9E9;
	}
 	#sqjz_fromSfjc_Browse #jcyy{
	    overflow-y:auto;
	    overflow-x:auto;
	    width:100%;
	    height:180px;
	}  
	#sqjz_fromSfjc_Browse #floor{
		width:100%;
		height:180px;
	} 
</style>
</head>
<body>
	<div id="sqjz_fromSfjc_Browse">
		<form class="form-horizontal" role="form" id="form">
			<div id="head">
				<div hidden>
					<input name="f_aid" type="hidden">
					<input name="sqjzrybh" type="hidden"  placeholder="社区服刑人员编号">
				</div>
				<div class="form-group">
					<label for="xuanze" class="col-sm-2 control-label">选择服刑对象:</label>
					<div class="col-sm-10">
						<input name="xm" type="text" class="form-control"  readonly="readonly" id="xuanze" autocomplete="off" placeholder="请输入汉字">
					</div>
				</div>
				<div class="form-group">
					<label for="lastname" class="col-sm-2 control-label">身份证号:</label>
					<div class="col-sm-10">
						<input name="sfzh" type="text" readonly="readonly" class="form-control" id="lastname"   placeholder="身份证号">
					</div>
				</div>
				<div class="form-group">
					<label for="time" class="col-sm-2 control-label">奖惩时间:</label>  
					<div class="col-sm-10">
					    <input id="time" name="jcsj" type="text" readonly="readonly" class="form_date_time form-control" data-date-format="yyyy-MM-dd">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">奖惩类别:</label>
					<div class="col-sm-10">
						<select id="jclb" name="jclb" readonly="readonly"  disabled="disabled"; class="form-control">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group"  style="margin-left:15px">
				<label for="floor" class="col-sm-2 control-label">奖惩原因:</label>
				<div class="col-sm-10" >
					<div id="jcyy"  class="form-control" readonly="readonly">
						<input name="jcyy" type="hidden">
					</div>
				</div>		
			</div>
			<div class="form-group"  style="margin-left:15px">
				<label for="floor" class="col-sm-2 control-label">备注:</label>
				<div class="col-sm-10">
					<textarea name="remark"  id="floor" type="text" readonly="readonly" maxlength="250" class="form-control"></textarea>
				</div>
			</div>		
		</form>			
	</div>
</body>
</html>