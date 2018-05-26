<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${localCtx}/json/SqjzOverviewService.js"></script>
<title>责任人工作区</title>
<style type="text/css">
	.row div{
	border-color: black;
	
	}
	.tabsel {
    cursor: pointer;
    text-align: center;
    background-color: #FFFFFF;
    border: 1px solid #C6C6C6;
    border-top: 0px;
    border-bottom: 1px solid #FFFFFF !important;
    width: 45px;
    height: 25px;
    line-height: 25px;
    margin-left: 3px;
   
}

</style>
<script type="text/javascript">
	$(function(){
		var table = new Eht.TableView({selector:"#modal_zrrgzq"});
		var service=new SqjzOverviewService();
		service.findXb(new Eht.Responder({
			success : function(data) {
				console.log(data);	
			}
		}))
	
	
	
	})



</script>
</head>
<body>
	<div class="panel panel-default row">
			<div  class="panel-heading col-md-8">
				<div class="content_top">
					<span id="remind" class="tabsel">提醒</span>
					<span id="backlog" class="tabsel">待办</span>
				</div>
				<div class="row">
					<div class="col-md-5">
						<img alt="" src="">
						<p>本月未进行</p>
						<p>【月报到】<span name=""></span>人</p>
						
					</div>
					<div class="col-md-5">
						<img alt="" src="">
						<p>上季度未进行</p>
						<p>【季度考核】<span name=""></span>人</p>
					</div>
					<div class="col-md-5">
						<img alt="" src="">
						<p>本月未进行</p>
						<p>【教育学习】<span name=""></span>人</p>
					</div>
					<div class="col-md-5">
						<img alt="" src="">
						<p>未进行</p>
						<p>【期满预警提醒】<span name=""></span>人</p>
					</div>
				</div>
			</div>
			<div class="panel-heading right col-md-3 col-md-offset-1">
				<div class="content_top"><span>业务操作</span></div>
				<div>
					<h6>矫正接收</h6>
					<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  		<li>
				  			<a href="" data-toggle="tab" >报到登记</a>
				 		 </li>
		          		<li>
		           			 <a href="" data-toggle="tab" >等级评估</a>
		           		</li>
		           		<li>
		           			 <a href="z" data-toggle="tab" >矫正小组</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >矫正方案</a>
		           		</li>
					</ul>
				</div>
				<div>
					<h6>矫正执行</h6>
					<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  		<li>
				  			<a href="" data-toggle="tab" >监督管理</a>
				 		 </li>
		          		<li>
		           			 <a href="" data-toggle="tab" >教育矫治</a>
		           		</li>
		           		<li>
		           			 <a href="z" data-toggle="tab" >帮困扶助</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >矫正考核</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >矫正风险评估</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >矫正小组工作记录</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >违反禁止令记录</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >违规记录</a>
		           		</li>
					</ul>
				</div>
				<div>
					<h6>奖励惩处</h6>
					<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  		<li>
				  			<a href="" data-toggle="tab" >提请减刑</a>
				 		 </li>
		          		<li>
		           			 <a href="" data-toggle="tab" >警告</a>
		           		</li>
		           		<li>
		           			 <a href="z" data-toggle="tab" >提请治安处罚</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >提请撤销缓刑（假释）</a>
		           		</li>
		           		<li>
		           			 <a href="" data-toggle="tab" >提请收监</a>
		           		</li>
					</ul>
				</div>
				<div>
					<h6>解除矫正(终止)</h6>
					<ul class="nav nav-tabs  style="color:black;font-size:15px">
				  		<li>
				  			<a href="" data-toggle="tab" >矫正质量评估</a>
				 		 </li>
		          		<li>
		           			 <a href="" data-toggle="tab" >期满解矫</a>
		           		</li>
		           		<li>
		           			 <a href="z" data-toggle="tab" >矫正终止</a>
		           		</li>
					</ul>
				</div>
			</div>
			<div class="panel-body col-md-8" id="modal_zrrgzq" style="margin-top: -330px; padding: 0px;">
				<div class="content_top"><span>社区服刑人员</span></div>
				<div  id="modal-body">
						<div field="op" checkbox=true label="选择"></div>
						<div field="xm" label="姓名"></div>
						<div field="dj" label="等级" code=""></div>
						<div field="zt" label="状态" code=""></div>
						<div field="cz" label="操作"></div>
				</div>
			</div>
			
	</div>		
</body>
</html>