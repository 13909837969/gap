<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<title>警告信息采集表</title>
</head>
<body>		
	<table class="table table-bordered" >
<!-- 表格 -->
	<thead>
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
			<td style="background-color: #E6E6E6" class="text-center">警告理由</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">警告依据</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">司法所申请人</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">司法所申请时间</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">司法所审核人</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">司法所审核时间</td>
			<td>
			<input type="text" class="form-control">
			</td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">县(市、区)司法局审批人</td>
			<td>
			<input type="text" class="form-control">
			</td>
			<td style="background-color: #E6E6E6" class="text-center">县(市、区)司法局审批时间</td>
			<td>
			<input type="text" class="form-control">
			</td>
			
		</tr>
	</tbody>
	<tbody>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">司法所审核意见</td>
			<td width="1000px" colspan="3" ><textarea style="height: 120px" class="form-control" rows="2"></textarea></td>
		</tr>
		<tr>
			<td style="background-color: #E6E6E6" class="text-center">县(市、区)司法局审批意见</td>
			<td width="1000px" colspan="3" ><textarea style="height: 120px" class="form-control" rows="2"></textarea></td>
		</tr>
	</tbody>
	
</table>
	<div class="text-center">
		<button type="submit" class="btn btn-default" class="text-center">提交</button>
	</div>
</body>
</html>