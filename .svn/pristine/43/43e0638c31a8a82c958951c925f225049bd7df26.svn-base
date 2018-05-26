<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--孙海龙  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<script type="text/javascript" src="${localCtx }/json/SqjzryztService.js"></script>
<title>社区矫正人员状态</title>
<script type="text/javascript">
$(function(){
	var json_data = {};
	var query = {};
	var service = new SqjzryztService();
	var form = new Eht.Form({selector:'#listSqjzryzt #jcflfwsForm',autolayout:true});
	var tableview = new Eht.TableView({selector:'#listSqjzryzt #tableview'});
	//展示页面信息
	tableview.loadData(function(page,res){
		service.findAll(query,page,res);
	});
	//单击一行获取该行的信息
	tableview.clickRow(function(data){
		json_data = data;
	});
	//新增按钮触发事件
	$('#listSqjzryzt #add').click(function(){
		form.clear();
		$("#listSqjzryzt #cjsj").val(nowTime);
		$('#myModal').modal({backdrop:'static'});
	});
	//初始提示信息为隐藏状态
	$('#listSqjzryzt #close_alert_div').hide();
	$('#listSqjzryzt #delete_alert_div').hide();
	//查询按钮事件
	$('#listSqjzryzt #search').click(function(){
		query["xm[like]"] = $('#search-xm').val();
		tableview.refresh();
	});	
	//修改按钮事件
	$('#listSqjzryzt #edit').click(function(){
		if(json_data.id==null){
			$('#listSqjzryzt #close_alert_div').show();
		}else{
			form.fill(json_data);
			$('#listSqjzryzt #myModal').modal({backdrop:'static'});
		}
	});
	$('#listSqjzryzt #delete').click(function(){
		if(json_data.id==null){
			$('#listSqjzryzt #close_alert_div').show();
		}else{
			$('#listSqjzryzt #delete_alert_div').show();
		}
	});
	$('#listSqjzryzt #no').click(function(){
		$('#listSqjzryzt #delete_alert_div').hide();
	});
	$('#listSqjzryzt #yes').click(function(){
		service.removeOne(json_data.id,new Eht.Responder({
			success:function(){
				tableview.refresh();
				$('#listSqjzryzt #delete_alert_div').hide();
			}
		}));
	});
	//提示框关闭按钮
	$('#listSqjzryzt #close_alert').click(function(){
		$('#listSqjzryzt #close_alert_div').hide();
	});
	
	//模态框保存并且隐藏
	$('#listSqjzryzt #submit').click(function(){
		if(form.validate()){
			service.saveOne(form.getData(),new Eht.Responder({
				success:function(data){
					$('#myModal').modal('hide');
					tableview.refresh();
				}
			}));
		}
	});
	//模态框查询矫正人员信息事件
	service.findJz(new Eht.Responder({
		success:function(data){
			$("#jzryxx_xmajglx").empty();
			$("#jzryxx_xmajglx").append('<option selected="selected"></option>');
			for(var i=0;i<data.length;i++){
				$("#jzryxx_xmajglx").append("<option value="+data[i].id+">"+data[i].xm + "</option>");
			}
			$("#jzryxx_xmajglx").comboSelect();
		}
	}))
	
	//获取当前日期
    Date.prototype.Format = function (fmt) {    
    var o = {    
        "M+": this.getMonth() + 1, //月份     
        "d+": this.getDate(), //日     
    };    
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));    
    for (var k in o)    
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));    
    return fmt;    
    }    
	var nowTime=new Date().Format("yyyy-MM-dd");
});
</script>
</head>
<body>
	<div id="listSqjzryzt">
		<div class="panel panel-default">
			<div class="panel-heading">
				<fieldset>
					<input type="text" id="search-xm" class="btn btn-default" placeholder="请输入姓名"/>
					<input type="button" id="search" class="btn btn-default" value="查询"/>
					<input type="button" id="add" class="btn btn-default" value="新增"/>
					<input type="button" id="edit" class="btn btn-default" value="修改"/>
					<input type="button" id="delete" class="btn btn-default" value="删除"/>
				</fieldset>
			</div>
			<div class="alert alert-warning alert_dismissible" id="close_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 请选择一条信息!
				<input type="button" class="btn btn-default" id="close_alert" value="取消"/>
			</div>
			<div class="alert alert-info alert-dissmissible" id="delete_alert_div" role="alert" style="text-align:center;font-size:17px">
				<strong>提示</strong> 确定删除？
				<input id="yes" class="btn btn-default" type="button" value="确定" >
				<input id="no" class="btn btn-default" type="button" value="取消" >
			</div>
			<div class="panel-body">
				<div id="tableview" class="table-responsive">
					<div field='op' label="选择" checkbox="true"></div>
					<div field="xm" label="姓名"></div>
					<div field="xb" label="性别"></div>
					<div field="sfzh" label="身份证号"></div>
					<div field="gljb" label="管理级别" code="sys114"></div>
					<div field="zknl" label="自控能力" code="sys064"></div>
					<div field="jyzk" label="交友状况" code="sys067"></div>
					<div field="rzfftd" label="认罪服法态度" code="sys078"></div>
					<div field="cjr" label="采集人"></div>
					<div field="cjsj" label="采集日期"></div>
				</div>
			</div>
		</div>
		<!-- 新增服刑人员状态信息(Modal) -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">新增服刑人员状态信息</h4>
					</div>
					<div class="modal-body" style="overflow: auto;height:450px;">
						<div class="modal-body-div">
							<div id="jcflfwsForm">
								<select id="jzryxx_xmajglx" name="f_aid" label="服刑人员">
								</select>
								<input type="text" name="gljb" label="管理级别" placeholder="请选择管理级别" code="sys114"/>
								<input type="text" name="jztj" label="居住条件"  placeholder="请选择居住条件" code="sys061" />
								<input type="text" name="shly" label="生活来源"  placeholder="请选择生活来源" code="sys062"/>
								<input type="text" name="jynl" label="就业能力"  placeholder="请选择就业能力" code="sys063"/>
								<input type="text" name="zknl" label="自控能力"  placeholder="请选择自控能力" code="sys064"/>
								<input type="text" name="hyjtgx" label="婚姻家庭关系" placeholder="请选择婚姻家庭关系" code="sys065"/>
								<input type="text" name="jtcyhjzqk" label="家庭成员配合矫正情况"  placeholder="请选择家庭成员配合矫正情况"  code="sys066"/>
								<input type="text" name="jyzk" label="交友状况" placeholder="请选择交友状况" code="sys067"/>
								<input type="text" name="shllgx" label="社会邻里关系"  placeholder="请选择社会邻里关系" code="sys068"/>
								<input type="text" name="dsqjzdrshjscd" label="对社区矫正的认识和接受程度"  placeholder="请选择对社区矫正的认识和接受程度" code="sys069"/>
								<input type="text" name="fxgljzjsfqk" label="服从日常管理及遵纪守法情况" placeholder="请选择服从日常管理及遵纪守法情况" code="sys070"/>
								<input type="text" name="jsjyqk" label="接受教育情况"  placeholder="请选择接受教育情况" getdis="true" code="sys071"/>
								<input type="text" name="zsqxjzdqk" label="遵守请销假制度情况" placeholder="请选择遵守请销假制度情况" code="sys072"/>
								<input type="text" name="wcsqfwqk" label="完成社区服务情况" placeholder="请选择完成社区服务情况" code="sys073"/>
								<input type="text" name="sxhbjgt" label="思想汇报及沟通"  placeholder="请选择思想汇报及沟通" code="sys074" />
								<input type="text" name="cjjyjnpx" label="参加就业技能培训"  placeholder="请选择参加就业技能培训" code="sys075"/>
								<input type="text" name="jzcjqk" label="矫正惩戒情况"  placeholder="请选择矫正惩戒情况" code="sys076"/>
								<input type="text" name="jtrybgxx" label="家庭人员变故信息"  placeholder="请选择家庭人员变故信息" code="sys077"/>
								<input type="text" name="rzfftd" label="认罪服法态度" placeholder="请选择认罪服法态度" code="sys078"/>
								<input type="text" name="dshdxt" label="对社会的心态"  placeholder="请选择对社会的心态"  code="sys079"/>
								<input type="text" name="dshsfyxx" label="对生活是否有信心" placeholder="请选择对生活是否有信心" code="sys080"/>
								<input type="text" name="xljkzk" label="心理健康状况"  placeholder="请选择心理健康状况" code="sys081"/>
								<input type="text" name="cjr" label="采集人"  placeholder="请输入采集人" value="${CURRENT_USER_SESSION.name}" readonly="true" fixedValue="true"/>
								<input type="text" name="cjsj" id="cjsj" label="采集日期" placeholder="请输入采集日期"  class="form_date" data-date-formate="yyyy-MM-dd" readonly="true" fixedValue="true"/>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" type="button" data-dismiss="modal">关闭</button>
						<button id="submit" class="btn btn-primary" type="button">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>