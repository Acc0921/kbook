<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta name="HandheldFriendly" content="true"/>
	<meta name="MobileOptimized" content="320"/>
    <title>订单信息</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >

  </head>
  <body >
  <br/>	
  	<div class="container" >
  		
  		<div class="well center-block" style="max-width: 300px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">

  	 	 <form id="buyform" action="" method="post">
			 <div style="padding-bottom:10px;">产品名称：<span id="name">${product.name }</span></div>
			 <div style="padding-bottom:10px;">产品价格：<span id='price'>${product.actualValue }</span></div>
			 <div style="padding-bottom:10px;">支付方式：<span id='pay'>微信支付</span></div>
			 <input id="productid" name="productid" type="hidden" value="${product.id }" />
			 <input id="cityId" name="cityId" type="hidden" value="${cityid }" />
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
    			//$('#buyform').submit();
    			location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf1f1eb288ea3e6a1&redirect_uri=http://wechat.xxxxtech.com/kbookweb/wxpay/pay?productId=${product.id}&uid=${uid}&cityId=${cityid}&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
    		});
    	});
    </script>
  </body>
</html>