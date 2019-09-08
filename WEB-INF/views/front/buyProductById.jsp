<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>产品购买</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >

    <script src="${ctx}/static/bootstrap3.0/js/bootstrap.min.js"></script>
  	<style type="text/css">
  		table tr td{
  		    padding:2px;
  			height :auto;
  			width :auto;
  			background-Color :  #EEE;
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
  <body onload="init()">
  <br/>	
  	<div class="container" align="center">
  		
  		<div class="well center-block" style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
  		
  		<div style="color:red;padding: 10px 0; display:${empty errorMsg?"none":"block"}">${errorMsg }</div>
  	 	 <form action="" method="post"> 
			 <table  id="seatOrdrTable" align="center" border="0" style="font-size:1.2em;">
						 		
								<tr>
									 <td style="font-size: 20px;">${product.name}</td> 
								</tr> 
							 	<c:if test="${product.type ==1 }"> 
									 <tr>
										 <td style="font-size: 12px;float:right">此卡为储值卡，充值点数<fmt:formatNumber value="${product.consumeValue}" type="currency" pattern="#0点"/></td>
									 </tr>  
								</c:if> 
								<c:if test="${product.type ==2 }"> 
									 <tr>   
										 <td style="font-size: 12px;">此卡为包时卡，连续${product.limitHour}天 </td>
									 </tr>
								</c:if>    
								<tr>
									<td>    
										<div class="pdrem discribt">
							                <p style="font-size: 18px;">卡种简介</p>   
							                <p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;适用城市&nbsp;:&nbsp;&nbsp;${product.city.name}</p>
							                <p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;产品有效期&nbsp;:&nbsp;&nbsp;${product.effectivePeriod}天</p>
							                <p style="font-size: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;销售周期&nbsp;:&nbsp;&nbsp;${product.effectiveFromDate}至${product.effectiveToDate}</p>
							            </div>
									</td>
								</tr>
<%-- 								<tr>  
									<td>
										<div style="text-align: right;color: red;">${product.actualValue}元</div>
									</td>
								</tr> --%>
								<tr>
									<td colspan="2"><hr style="border:2px solid #FF0033" width="100%" size="1"></td>
								</tr>
								<tr> 
									<td> 
										<p style="font-size: 18px;">支付方式</p>
					                    <div class="payList">
					                        <label for="wechat">
					                            <img src="${ctx}/static/img/icon_02.png" style="width: 30px;"/>
					                            <span>微信</span> 
					                        </label>
					                        <input style="float: right;" type="radio" name="paymode" id="wechat" checked="checked" class="wap_radio" />
					                    </div> 
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr style="border:2px solid #FF0033" width="100%" size="1"></td>
								</tr>
		   	 </table>
	   	 </form>
	   	  <br/>
		   <div class="container" style="margin-bottom:15px;letter-spacing:4px;">
		    <button class="btn btn-info btn-lg btn-block btn-fontsize" type="botton" id="prePay">支付<em>(${product.actualValue}元)</em></button>
			</br>   
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/system/product/buyProduct';">
				<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">返回</button>
			</a>
		  </div> 
	   	</div>    	
	</div>   	
	<script type="text/javascript">
  		function init(){
	   		//Do nothing
	   	}
	</script>
	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
  	<script type="text/javascript"> 
	  	$(function(){
			$.backstretch("${ctx}/static/images/1.jpg");
		});
   		 //点击支付按钮跳转到新增产品订单页面
        var productId = "${product.id}";
        //alert("productId"+productId);
		var bizOrderNo;
        $("#prePay").click(function () {
        	//禁用支付点击  防止重复
        	$("#prePay").prop('disabled', true);
            //提交到后台 调用银联获取支付信息
            //window.location.href = "${ctx}/system/productOrder/createOrder?memberId="+memberId+"&productId=${product.id}";
            //window.location.href = "${ctx}/wxpay/payTest?memberId="+memberId+"&productId="+productId;
			var url = "${ctx}/system/productOrder/createWechatPay?productId="+productId;
			var appId,timeStamp,nonceStr,package1,signType,paySign;
			$.ajax({
                url: url,
                type: 'get',
                dataType: 'json',
                success: function(res){
                	if(typeof(res.Message) != "undefined"){
                		alert(res.Message);
                	}else{
                		appId = res.appId;
                		timeStamp = res.timeStamp;
                		nonceStr = res.nonceStr;
                		package = res.package;
                		signType = res.signType;
                		paySign = res.paySign;
                		bizOrderNo = res.bizOrderNo;
                		if (typeof WeixinJSBridge == "undefined") {
        	        		if (document.addEventListener) {
        	        			document.addEventListener('WeixinJSBridgeReady',onBridgeReady, false);
        	        		} else if (document.attachEvent) {
        		        		document.attachEvent('WeixinJSBridgeReady',onBridgeReady); 
        		        		document.attachEvent('onWeixinJSBridgeReady',onBridgeReady);
        	        		}
                		} else {
                			onBridgeReady();
                		}
                	}
                	//恢复支付点击
                	$("#prePay").prop('disabled', false);
                }
            });
			
			/* $.getJSON(url,function(result) {
				console.log(result);
        		appId = result.appId;
        		timeStamp = result.timeStamp;
        		nonceStr = result.nonceStr;
        		package = result.package;
        		signType = result.signType;
        		paySign = result.paySign;
        		bizOrderNo = result.bizOrderNo;
        		if (typeof WeixinJSBridge == "undefined") {
	        		if (document.addEventListener) {
	        			document.addEventListener('WeixinJSBridgeReady',onBridgeReady, false);
	        		} else if (document.attachEvent) {
		        		document.attachEvent('WeixinJSBridgeReady',onBridgeReady); 
		        		document.attachEvent('onWeixinJSBridgeReady',onBridgeReady);
	        		}
        		} else {
        			onBridgeReady();
        		}
        	}); */
			
			function onBridgeReady(){
				WeixinJSBridge.invoke( 'getBrandWCPayRequest', {
						"appId":appId, //公众号名称,由商户传入
						"timeStamp":timeStamp, //时间戳,自1970年以来的秒数
						"nonceStr":nonceStr, //随机串
						"package":package,
						"signType":signType, //微信签名方式：
						"paySign":paySign //微信签名
					},
					function(res){
						
						window.location.href = "${ctx}/system/productOrder/toWechatPay?productId="+productId+"&bizOrderNo="+bizOrderNo;
						//使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok,但并不保证它绝对可靠。 
 						/*if(res.err_msg == "get_brand_wcpay_request:ok" ) {
							console.log('支付成功');
							//支付成功后跳转的页面
							
						}else if(res.err_msg == "get_brand_wcpay_request:cancel"){
							alert('支付取消');
						}else if(res.err_msg == "get_brand_wcpay_request:fail"){
							var msg='支付失败，请确认您的微信是否已经绑定银行卡，如果已经绑定，请重新支付.';
							alert(msg);
							//WeixinJSBridge.call('closeWindow');
						}  */
				});
			}
        });
    </script>
  </body>
</html>