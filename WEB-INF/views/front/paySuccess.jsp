<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>
<%
    Object sessionValues=session.getAttribute(Constants.CURRENT_MEMBER);
    Member mbr = (Member)sessionValues;
%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${Message}</title>
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
				<table id="seatOrdrTable" align="center" border="0"
					style="font-size: 1.2em;">
					<c:choose> 
						<c:when test="${Message == '支付成功！'}">
							<tr>
								<td style="width: 30%; textAlign: center;"><p>产品名称：${payProductOrder.productName}</p></td>
							</tr>
							<tr>
								<td><p>支付金额：${payProductOrder.actualValue}</p></td>
							</tr>
							<tr>
								<td><p>商品类型：${payProductOrder.type == 1 ? '储值卡' : '包天卡'}</p></td>
							</tr>
							<tr>
								<td><p>
										有效日期：
										<fmt:formatDate value="${payProductOrder.effectiveFromDate}"
											pattern="yyyy-MM-dd" />
									</p></td>
							</tr>
							<tr>
								<td><p>
										失效日期：
										<fmt:formatDate value="${payProductOrder.effectiveToDate}"
											pattern="yyyy-MM-dd" />
									</p></td>
							</tr>
							<tr>
								<td><p>适用城市：${payProductOrder.city.name}</p></td>
							</tr>
							<tr>
								<td colspan="2"><hr style="border: 2px solid #FF0033"
										width="100%" size="1"></td>
							</tr>
						</c:when>
						<c:otherwise>
							</br>
							</br>
							</br>
							</br>
							</br>
							</br>
							<p style="color: red; font-weight: bold;">${Message}</p>
							</br>
							</br>
							</br>
							</br>
							</br>
							</br>
						</c:otherwise>
					</c:choose>
				</table>
			</form>
	   	  <br/>
		   <div class="container" style="margin-bottom:15px;letter-spacing:4px;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member';">
				<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">去订座</button>
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