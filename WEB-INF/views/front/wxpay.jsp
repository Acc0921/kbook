<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>订单信息</title>
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta name="HandheldFriendly" content="true"/>
	<meta name="MobileOptimized" content="320"/>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <c:set var="now" value="<%=new java.util.Date()%>" />
   
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
<script type="text/javascript">
var jsParam=${jsParam};
function wxpay(){
	WeixinJSBridge.invoke(
		'getBrandWCPayRequest'
		,jsParam
		,callback
	);
}

function callback(res){ 
	//  返回 res.err_msg,取值 
	// get_brand_wcpay_request:cancel   用户取消 
    // get_brand_wcpay_request:fail  发送失败 
    // get_brand_wcpay_request:ok 发送成功 
     WeixinJSBridge.log(res.err_msg); 	   	 
     if(res.err_msg=='get_brand_wcpay_request:ok')
     {
     	alert("支付成功。");
     	$('#buyform').submit();
     	showPayResult();
     }
	else if(res.err_msg=='get_brand_wcpay_request:cancel'){
		
	}else
	{
		var msg='支付失败，请确认您的微信是否已经绑定银行卡，如果已经绑定，请重新支付.';
		alert(msg);
		 //alert(res.err_code+" err_desc="+res.err_desc+" err_msg="+res.err_msg); 	
	}
};
</script>
</head>
<body>

<div class="container" style="margin-top:20px;" >
  		
  		<div class="well center-block" style="max-width: 300px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">

  	 	 <form id="buyform" action="${ctx }/front/member/buyProduct" method="post">
			 <div style="padding-bottom:10px;">产品名称：<span id="name">${product.name }</span></div>
			 <div style="padding-bottom:10px;">产品价格：<span id='price'>${product.actualValue }</span></div>
			 <div style="padding-bottom:10px;">支付方式：<span id='pay'>微信支付</span></div>
			 <input id="productid" name="productid" type="hidden" value="${product.id }" />
			 <input id="cityId" name="cityId" type="hidden" value="${cityId }" />
			 <input id="date" name="date" type="hidden" value="${date }" />
			 <input id="save" name="save" type="hidden" value="1" />
	   	 </form>
	   	  <br/>
	   	  <div style="margin-bottom:15px;letter-spacing:4px;">
			<button id='paybutton' type="button" class="btn btn-warning btn-lg btn-block btn-fontsize">支付</button>
		  </div>
		   <div style="margin-bottom:15px;letter-spacing:4px;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/buyProduct';">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">取消</button>
			</a>
		  </div>
	   	</div>    	
	</div>

	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
	<script type="text/javascript">
    	$(function(){
    		$.backstretch("${ctx}/static/images/1.jpg");
    		$('#paybutton').click(function(){
    			wxpay();
    		});
    	});
    </script>
</body>
</html>
