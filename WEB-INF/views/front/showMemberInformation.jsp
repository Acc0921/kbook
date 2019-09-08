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
    <title>我的信息</title>
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
  	 	 <form action="" method="post">
			 <table  id="seatOrdrTable" align="center" border="0" style="font-size:1.2em;">
					<tr>
						<td style="width: 30%; textAlign: center;">姓名：</td>
						<td style="width: 60%; textAlign: left;">${mbr.name}</td>
					</tr>
					<tr>
						<td>性别：</td>
						<td><c:choose><c:when test="${mbr.sex == 1}">男</c:when><c:otherwise>女</c:otherwise></c:choose></td>
					</tr>
					<tr>
						<td>职业：</td>
						<td><c:if test="${mbr.career == 1}">自由</c:if><c:if test="${mbr.career == 2}">学生</c:if><c:if test="${mbr.career == 3}">在职</c:if></td>
					</tr>
					<c:if test="${mbr.career == 2}">
						<tr>
							<td>年级：</td>
							<td>${mbr.grade}</td>
						</tr>
					</c:if>
					<tr>
						<td>目标：</td>
						<td>${mbr.target}</td>
					</tr>
					<tr>
						<td>来源：</td>
						<td>${mbr.channel}</td>
					</tr>
					<tr>
						<td>期望门店：</td>
						<td>${mbr.cityName}>${mbr.storeName}</td>
					</tr>
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
    </script>
  </body>
</html>