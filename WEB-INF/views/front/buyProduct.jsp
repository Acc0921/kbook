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
				 <c:choose>
					 <c:when test="${!empty products && products.size()>0}">
						 <c:forEach var="product" items="${products}" varStatus="st">
							 <c:if test="${st.index<products.size()}">
								 <tr>
									 <td style="font-size: 20px;">${product.name}</td> 
								 </tr> 
							 	<c:if test="${product.type ==1 }"> 
									 <tr>
										 <td style="font-size: 15px;">此卡为储值卡，充值点数<fmt:formatNumber value="${product.consumeValue}" type="currency" pattern="#0点"/>   <button style="float: right;margin-left: 50px;" class="btn btn-success" type="button" onclick="getProduct(${product.id})">购买</button></td>
									 </tr>  
								</c:if> 
								<c:if test="${product.type ==2 }"> 
									 <tr>  
										 <td style="font-size: 15px;">此卡为包时卡，连续${product.limitHour}天  <button style="float: right;margin-left: 50px;" class="btn btn-success" type="button" onclick="getProduct(${product.id})">购买</button></td>
									 </tr>
								</c:if>   
								<tr> 
									<td>
										<div style="text-align: right;color: red;">${product.actualValue}元</div>
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr style="border:2px solid #FF0033" width="100%" size="1"></td>
								</tr>
							 </c:if>
						 </c:forEach>
					 </c:when>
					 <c:otherwise>
						 <tr>
							 <td style="textAlign:left; fontSize:1.4em; borderStyle:none;">没有可购买产品！</td>
						 </tr>
					 </c:otherwise>
				 </c:choose>

		   	 </table>
	   	 </form>
	   	  <br/>
		   <div class="container" style="margin-bottom:15px;letter-spacing:4px;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/memberMenu';">
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
    	
    	//获取用户点击购买产品方法
		function getProduct(productId) {
	
		    var url ="${ctx}/system/product/getProductById?productId="+productId;
		    window.location=url;
	
	    };
    </script>
  </body>
</html>