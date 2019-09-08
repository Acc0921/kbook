<%-- <%@page import="com.alibaba.druid.Constants"%>
<%@page import="org.apache.bcel.classfile.Constant"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>
<%@ page import="org.apache.logging.log4j.LogManager,org.apache.logging.log4j.Logger" %>
<%
	Object sessionValues = session.getAttribute(Constants.CURRENT_MEMBER);
	Member mbr = (Member) sessionValues;
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="HandheldFriendly" content="true" />
<meta name="MobileOptimized" content="320" />
<%@ include file="/WEB-INF/views/include/context.jsp"%>
<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<title>首页</title>
<style type="text/css">
.btn-fontsize {
	font-size: 180%
}
a{
	text-decoration:none;
}
a:link{
	text-decoration:none;
}
a:visited{
	text-decoration:none;
}
a:hover{
	text-decoration:none;
}
a:active{
	text-decoration:none;
}
</style>
</head>
<body>
	<br />
	<div class="container" align="center" style="color:white;">
		<table id="memberMsg"
			style="text-align:center;letter-spacing:2px;font-size:22px;">
		</table>
	</div>
	<div class="container" align="center" style="margin-top:20px; ">
		<div class="well center-block"
			style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<span style="font-size:16pt;">系统维护</span>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="javascript:history.back();"><button
						type="button" class="btn btn-danger btn-lg btn-block btn-fontsize">返回</button>
				</a>

			</div>
		</div>

	</div>
</body>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript">
   		$(function() {
   			$.backstretch("${ctx}/static/images/1.jpg");
   			 var balance; var productName;var status;
			 var url="${ctx}/system/productOrder/getMemberProductJson?id="+<%=mbr.getId()%>+"&t=" + Math.random();
				$.ajax({
				   type: "GET",
				   url: url,
				   cache:false,
				   async: false,
				   dataType:"json",
				   success: function(json){
				   		if(json.productOrder!=null){
							balance=":"+json.productOrder.balance+"点";
							productName=json.productOrder.product.name;
							status=	json.productOrder.status;
							
							var pnReg1 = !!productName.match(/^包周卡/);
							var pnReg2 = !!productName.match(/^包月卡/);
							if(pnReg1==true){
								balance=productName;
							}
							if(pnReg2==true){
								balance=productName;
							}			
						}else{
							balance="亲,您未购买任何产品";
						}
						
						if(status!=undefined){
							if(status==0){
								$("#toSeatOrder").removeAttr('href');
								$("#toSeatOrder").click(function(){ 
									alert("亲,您未购买产品或者产品已过期,无法订座");
								});
							}else{
								$("#toSeatOrder").click(function(){ 
									$("#toSeatOrder").attr("href","${ctx}/front/seatOrder");
								});
							}
						}else{
							$("#toSeatOrder").removeAttr('href');
							$("#toSeatOrder").click(function(){ 
								alert("亲,您未购买产品或者产品已过期,无法订座");
							});
						}
						
				   		var memberMsg = document.getElementById("memberMsg");
			    		var tr = document.createElement("tr");
				   		var td = document.createElement("td");
				   		var memberName='<%=mbr.getName()%>';
						td.innerHTML = '<img src="${ctx}/static/images/front_member.png" alt=""  width="22px;"height="22px;"/>&nbsp;'
								+ memberName + "&nbsp;&nbsp;" + balance;
						tr.appendChild(td);
						memberMsg.appendChild(tr);
					}
				});
	});
</script>
</html>