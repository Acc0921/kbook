<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css">
    <title>信息提示</title>
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
	   		<div class="well center-block" style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
	   			<form id="seatForm" class="form-horizontal" role="form" method="post" align="center">
			  		<div class="container" align="left" style="font-size:1.4em" >
			 			${msg}
			 		</div>
			 		<br/>
			    	<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
						<a id="back">
							<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">返回</button>
						</a>
				 	</div>
		    	</form>
	   		</div>
	   	</div>	
   		
	 
	     <script type="text/javascript">
	     	function init(){
	     		var confir=document.getElementById("back");
	   			confir.setAttribute("onclick", "javascript:clickUrl()");
	   		}
	   		
	   		function clickUrl(){
	   			window.location.href="${ctx}/front/member";
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