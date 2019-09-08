<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<%@ include file="/WEB-INF/views/include/context.jsp"%>
		<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css">
	 	<title>订单状态</title>
	 	<style type="text/css">
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
		<br/><br/>
	   	<div class="container" align="center" >
	   		<div class="well center-block" style="max-width: 400px;font-size:1.4em;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
	   			<form id="" class="form-horizontal" role="form" method="post" align="center">
			  		<div class="container form-group" align="center" style="margin-top:20px;" >
			 			预订成功
			 		</div>
			    	<div class="container form-group" align="center"> 						
						订单编号
			    	</div>
					<!--
			    	<div class="container form-group" align="center" >
						${orderNumber}
			    	</div>
			    	-->
					<div id="orderNumber" class="container form-group" align="center" ></div>
	    		</form>
	    		<br/>
			     <div class="container" style="margin-bottom:15px;letter-spacing:4px;">
					<a id="confir">
					<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">确认</button>
					</a>
				 </div>
	    	</div>
	    </div> 
	    <script type="text/javascript">
	     	function init(){
	     		var confir=document.getElementById("confir");
	   			confir.setAttribute("onclick", "javascript:clickUrl()");
	   		}
	   		
	   		function clickUrl(){
	   			window.location.href="${ctx}/front/member/memberMenu";
	   		}
	     	
	    </script>
	    <script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
	    <script type="text/javascript">
	    	$(function(){
	    		$.backstretch("${ctx}/static/images/1.jpg");
	    	});

	    	//add:yangzh by 2018-05-17 start
	    	var orderNumberStr = "${orderNumber}";
	    	if(orderNumberStr != null && orderNumberStr != "" ){
                var orderNumberS = orderNumberStr.split("|");
                var orderNumber = "";
                $(orderNumberS).each(function (i, item) {
                    orderNumber += item + "<br/>";
                });
                document.getElementById("orderNumber").innerHTML = orderNumber;
				//console.log(orderNumber)
			}

            //add:yangzh by 2018-05-17 end
	    </script> 
	</body>
</html>    