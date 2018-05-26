<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../ltrhao-common.jsp"></jsp:include>
<title>辅助分析</title>
<script type="text/javascript">
$(function() {
	$("#open_pdf").click(function() {
		/* obj = document.getElementsByName("check");
	    check_val = [];
	    for(k in obj){
	        if(obj[k].checked)
	            check_val.push(obj[k].value);
	    } */
	    var check_val = "";
	     $('input:checkbox').each(function(){
	    	 check_val +="," + $(this).val();
	     });
	     
	    if (check_val.search("1")>0) {
	    	document.getElementById("open_pdf").href="${localCtx}/module/pdf/新 分析报告一.pdf";
		}
	    if (check_val.search("2")>0) {
	    	document.getElementById("open_pdf").href="${localCtx}/module/pdf/新 分析报告二.pdf";
		}
	});
});
	
</script>
</head>
<body>
	<!-- iframe S -->
	 <div id="main_popopen_menu_func" class="modal fade" tabindex="-1" role="dialog">
		 <div  class="modal-dialog" style="width:900px;" role="document">
		    <div class="modal-content" style="top:200px;">
		      	 <div class="modal-header">
			         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			         <h5 class="modal-title" id="myModalLabel">分析报告</h5>
			      </div>
			      <div class="modal-body" style="height:600px;">
			      	<iframe id="func_open_pdf" style="border:0px;width:100%;height:98%;" frameborder="0"></iframe>
			      </div>
		    </div>
		  </div>
	  </div>
	<!-- iframe E -->
	<div style="margin:45px;">
		<div style="margin-top:15px;">
			<h5>根据以下指标分析生成数据研判报告</h5>
			<div><input type="checkbox" name="radio" id="tjr" value="1" /><label for="tjr">全区第一季度各地区人民调解员数量统计</label></div>
			<div><input type="checkbox" name="radio" id="aj_zsa" value="2" /><label for="aj_zs">A.2018年第一季度全区人民调解案件类型数量统计</label></div>
			<div><input type="checkbox" name="radio" id="aj_tjb" value="3" /><label for="aj_tj">B.2017年第一季度全区人民调解案件类型数量统计</label></div>
			<div><input type="checkbox" name="radio" id="aj_tblc" value="4" /><label for="aj_tbl">C.2018年第一季度人民调解案件类型数量统计同比增长率</label></div>
			<div><input type="checkbox" name="radio" id="aj_zs" value="5" /><label for="aj_zs">全区第一季度纠纷案件数量走势</label></div>
			<div><input type="checkbox" name="radio" id="aj_tj" value="6" /><label for="aj_tj">全区第一季度各类案件纠纷统计</label></div>
			<div><input type="checkbox" name="radio" id="aj_tbl" value="7" /><label for="aj_tbl">全区第一季度各类案件同比增长率</label></div>
		</div>
		<Button type="button" style="margin:auto auto;cursor:pointer; color: black;" class="btn btn-primary btn-sm"><a id="open_pdf"  href="" style="list-style: none;color: white;list-style-type: none;">分析预览</a></Button>
	</div>
</body>
</html>