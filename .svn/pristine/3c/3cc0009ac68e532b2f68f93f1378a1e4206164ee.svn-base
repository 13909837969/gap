<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<html>
	<head>
		 <title>社区服刑对象走访笔录</title>
		<jsp:include page="../ltrhao-common.jsp"></jsp:include>
		<script type="text/javascript" src="${localCtx}/json/JzsfService.js"></script>
		<script type="text/javascript">
		$(function() {
			var form = new Eht.Form({
				selector : '#sqjz_formJzsfb_body'
			});
			//提交保存
			$("#listJzsf #btn-primary").click(function() {
				var service = new JzsfService();
				service.save(form.getData(), new Eht.Responder({
					success : function() {
						$("#listJzsf_table").refreshTable();
						$('#listJzsf #myModal').modal('hide');
					}
				}));
			});
		});
		</script>
		<style>
              #sqjz_formDcpg_body{
	            	position: relative;
	            	margin:0 auto;
              }
              .div_h{
              	text-align:center;
              }
              .input{  
                outline:none;
                border-bottom: 1px solid #dbdbdb;  
				border-top:0px;  
				border-left:0px;  
				border-right:0px; 
				word-break:break-all;
				text-align:center;
            } 
        </style>
	</head>
	<body>
		<div id="sqjz_formJzsfb_body" >
			<div class="content">
				<div class="div_h">
					<h2>社区服刑对象走访笔录</h2>
				</div>
				时间:<input name="f_cts" class="input" type="text"  style="width:220;"/>
				地点:<input name="f_dz" class="input" type="text" style="width:240;"/><br>
				谈话人:<input name="f_thr" class="input" type="text" style="width:220;"/>
				记录人:<input name="f_jlr" class="input" type="text" style="width:230;"/>
				<div class="div_h">
					<span style="font-size:25px">被谈话人信息</span><br>
				</div>
				姓名:<input name="xm" class="input" type="text" style="width:240;"/>
				性别:<input name="xb" class="input" type="text" style="width:240;"/><br>
				出生日期:<input name="csrq" class="input" type="text" style="width:210;"/>
				文化:<input name="whcd" class="input" type="text" style="width:230;"/><br>
				家庭住址:<input name="hjszdmx" class="input" type="text" style="width:210px;"/>
				电话:<input name="grlxdh" class="input" type="text" style="width:230;"/><br>
				&nbsp;&nbsp;&nbsp;&nbsp;		
				我们是***司法所的司法助理员，今天，我们来家访，主要是为了解决你进来的思
				想状况、行为表现、是否存在生活工作等方面的困难，问你的有关问题请如实回答。
				<textarea name="f_blnr" rows="6" cols="88" 
				onpropertychange="if(this.scrollHeight>80) this.style.posHeight=this.scrollHeight+5">
				</textarea><br>
			</div>
		</div>
	</body>
</html>