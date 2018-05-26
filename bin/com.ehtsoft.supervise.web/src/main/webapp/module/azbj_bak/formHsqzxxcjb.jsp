<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<title>核实取证信息采集表</title>
</head>
<body>		
	<table class="table table-striped" >
<!-- 表格 -->
	<thead>
	<h3 class="text-center">核实取证信息采集表</h3>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">矫正人员id</td>
			 <td>
			  <input type="text" class="form-control">			
			 </td>
			<td style="background-color: #E6E6E6" class="text-center">社区矫正人员编号</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<tr/>
			<tr>	
			<td style="background-color: #E6E6E6" class="text-center">被核实取证人</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">核实取证事由</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">核实取证人</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">核实取证时间</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">核实取证地点</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">核实情况记录</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
	</tbody>
	<tbody>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">处理意见</td>
			<td width="1000px" colspan="3" ><textarea style="height: 120px" class="form-control" rows="2"></textarea></td>
		</tr>
	</tbody>
	
</table>
	<div class="text-center">
		<button type="submit" class="btn btn-default" class="text-center">提交</button>
	</div>
</body>
</html>