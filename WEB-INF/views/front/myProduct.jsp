<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的产品</title>
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
				 <%--
			 <c:choose>
			 	<c:when test="${!empty productOrder}">
			 	<tr>
			 		<td style="width:30%; textAlign:center;">产品名称:</td>
			 		<td style="width:60%; textAlign:left;">${productOrder.productName}</td>
			 	</tr>
			 		<td>消费点数:</td>
			 		<td>${productOrder.balance}</td>
				<tr>
				</tr>
			 		<td>消费人群:</td>
			 		<td>${productOrder.consumerType}</td>
				<tr>
			 		<td>产品折扣:</td>
			 		<td>${productOrder.discount}</td>
				</tr>
				<tr>
			 		<td>适用城市:</td>
			 		<td>${productOrder.product.cityName}</td>
				</tr>
				<tr>
			 		<td>生效日期:</td>
			 		<td>${productOrder.effectiveFromDate}</td>
				</tr>
				<tr>
			 		<td>失效日期:</td>
			 		<td>${productOrder.effectiveToDate}</td>
				</tr>
				</c:when>
				<c:otherwise>
				<tr>
					<td style="textAlign:left; fontSize:1.4em; borderStyle:none;">亲，您没有生效的产品</td>
				</tr>
				</c:otherwise>
			</c:choose>
				 --%>
				 <c:choose>
					 <c:when test="${!empty productOrderList && productOrderList.size()>0}">
						 <c:forEach var="productOrder" items="${productOrderList}" varStatus="st">
							 <c:if test="${st.index<productOrderList.size()}">
								 <tr>
									 <td style="width:30%; textAlign:center;">产品名称:</td>
									 <td style="width:60%; textAlign:left;">${productOrder.productName}</td>
								 </tr>
							 	<c:if test="${productOrder.type !=2 }">
									 <tr>
										 <td>剩余点数:</td>
										 <td>${Math.round(productOrder.balance)}点</td>
									 </tr>
								</c:if>
								<%--  <tr>
									 <td>消费人群:</td>
									 <td>${productOrder.consumerType}</td>
								 </tr>
								 <tr>
									 <td>产品折扣:</td>
									 <td>${productOrder.discount}</td>
								 </tr> --%>
								 <tr>
									 <td>适用城市:</td>
									 <td>${productOrder.product.cityName}</td>
								 </tr>
								 <%-- <tr>
									 <td>生效日期:</td>
									 <td>${productOrder.effectiveFromDate}</td>
								 </tr> --%>
								 <tr>
									 <td>失效日期:</td>
									 <td>${productOrder.effectiveToDate}</td>
								 </tr>
								 <tr>
									 <td colspan="2"><hr style="border:2px solid #FF0033" width="100%" size="1"></td>
								 </tr>

								 </c:if>

						 </c:forEach>
					 </c:when>
					 <c:otherwise>
						 <tr>
							 <td style="textAlign:left; fontSize:1.4em; borderStyle:none;">亲，您没有生效的产品</td>
						 </tr>
					 </c:otherwise>
				 </c:choose>

		   	 </table>
	   	 </form>
	   	  <br/>
	   	  <c:if test="${canbuy && wx == 1}"> <%-- wx=1为只能在微信客户端显示 --%>
	   	 <%--  <div id="buy" class="container" style="margin-bottom:15px;letter-spacing:4px; display:block;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/buyProduct';">
			<button type="button" class="btn btn-primary btn-lg btn-block btn-fontsize">我要购买</button>
			</a>
		  </div> --%>
		  </c:if>
			<%--
	   	  <c:if test="${!empty productOrder && false }">
			  --%>
			<c:if test="${!empty productOrderList && false }">
<%-- 		  <div id="del" class="container" type="hidden" style="margin-bottom:15px;letter-spacing:4px; display:block;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/delProductOrder';">
			<button type="button" class="btn btn-primary btn-lg btn-block btn-fontsize">删除(用于测试)</button>
			</a>
		  </div> --%>
		  </c:if>
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
    </script>
  </body>
</html>