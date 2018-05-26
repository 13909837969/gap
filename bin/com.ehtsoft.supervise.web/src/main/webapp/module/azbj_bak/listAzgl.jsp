<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>安置管理</title>
	<jsp:include page="../ltrhao-common.jsp"></jsp:include>
	<script type="text/javascript" src="${localCtx}/json/AzbjRyxjService.js"></script>
	<script type="text/javascript">
	$(function(){
		//Form表单的使用范围
			var form=new Eht.Form({
				selector : "#container-Azglid  #querypanel"
			});
		
			var tableView = new Eht.TableView({
				multable:false,
				selector : "#container-Azglid",
				valueCodeField:"f_code",
				labelCodeField:"f_name"
				});
			
			//数据查询
			var service = new AzbjRyxjService();
			tableView.loadData(function(page, res) {
				service.findAllRy(form.getData(),page,res);
			});	
			
			//定义单机事件
			$("#container-Azglid #querybtn").click(function() {
				tableView.refresh();
			})

			
		});
		
	</script>
	
		<style type="text/css">
			.table-bordered>thead>tr>th{
				text-align: center;
			}
			.table-bordered>tbody>tr>td{
			    text-align: center
			}	
		</style>
	</head>	
	<body>
		<div id="container-Azglid"	 class="panel panel-default" >		
				<fieldset id="querypanel" class="panel-heading">
					姓名：<input type="text" name="xm[like]" class="btn btn-default" placeholder="请输入姓名"/>					
					 <input id="querybtn" class="btn btn-default" type="button" value="查询">
				</fieldset>
			<div class="panel-body" style="padding:3px 0 0 0;" >
				<div field='op' 		label="选择" 	checkbox="true"></div>
				<div field="xm"  		label="姓名" ></div>
				<div field="bh" 		label="编号"></div>
				<div field="xsrq"  	label="刑事日期"></div>
				<div field="bjlb"		label="帮教类别"></div>
				<div field="sfyaz"	label="是否已安置"></div>
				<div field="azrq"		label="安置日期"></div>
				<div field="azfs"		label="安置方式"></div>
				<div field="cz"		label="操作"></div>
			</div>
		</div>
	</body>
	</html>
	