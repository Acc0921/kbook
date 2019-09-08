<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%
	String error = (String) request
			.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
	request.setAttribute("error", error);
%>
<!DOCTYPE html>
<html lang="zh-CN">


<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta name="HandheldFriendly" content="true"/>
<meta name="MobileOptimized" content="320"/>
<title>会员登录</title>

<!-- CSS -->
<%@ include file="/WEB-INF/views/include/context.jsp"%>
<link rel="stylesheet" href="${ctx}/static/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctx}/static/css/login/form-elements.css">
<link rel="stylesheet" href="${ctx}/static/css/login/style.css">


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
            <script src="${ctx}/static/js/html5shiv.js"></script>
            <script src="${ctx}/static/js/respond.min.js"></script>
        <![endif]-->


</head>

<body>
<form id="loginForm"  action="${ctx}/front/member/weChatLogin" method="post">
	<!-- Top content -->
	<div class="top-content">

		<div class="inner-bg">
			<div class="container">
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2 text">
						<h1>
							<strong>会员登录</strong> 
						</h1>
						
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							
							<div id="errormsg" style="color:red;">${info}</div>
						</div>
						<div class="form-bottom">
							<form role="form" action="" method="post" class="login-form requred">
							<input type="hidden" name="token" value="${token }">
								<div class="form-group">
									<label class="sr-only" for="account">Username</label> <input
										type="text" name="account" placeholder="请输入会员账号..."
										class="form-username form-control" id="form-username">
								</div>
								<div class="form-group">
									<label class="sr-only" for="password">Password</label> <input
										type="password" name="password" placeholder="请输入密码..."
										class="form-password form-control" id="form-password">
								</div>
								<button type="submit" class="btn btn-block">登 录</button>
								<button  class="btn btn-block" id="toRegister">注册</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</form>

	<script src="${ctx}/static/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctx}/static/bootstrap/js/bootstrapValidator.min.js"></script>
	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>

	<script type="text/javascript">
		$("#toRegister").click(function () {
			window.location.href="${ctx}/system/member/register";
        });
		$(function(){
		${empty info ? "$('#errormsg').hide();" : "$('#errormsg').show();"};
			$.backstretch("${ctx}/static/images/1.jpg");
		 setTimeout(function(){
		        hiddenmsg();
		    },3000);
		 function hiddenmsg(){
		 	$("#errormsg").fadeOut("slow");
		 }
		$('#loginForm').bootstrapValidator({
	        message: '输入不正确',
	        fields: {
	            account: {
	                message: '用户账号不正确',
	                validators: {
	                    notEmpty: {
	                        message: '请输入账号.'
	                    },
	                    stringLength: {
	                        min: 1,
	                        max: 30,
	                        message: '用户账号不能少于1个字符和超过30个字符。'
	                    }
	                }
	            },password: {
	            		message: '密码不正确',
                		validators: {
                    		notEmpty: {
                        		message: '请输入密码.'
                    		}
                		}
            		}
	            }
	            });

		});
	</script>
		<script src="${ctx}/static/js/scripts.js"></script>
	<!--[if lt IE 10]>
            <script src="${ctx}/static/js/placeholder.js"></script>
        <![endif]-->

</body>

</html>