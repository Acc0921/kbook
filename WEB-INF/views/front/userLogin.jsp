<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

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
<title>管理层登录</title>

<!-- CSS -->
<%@ include file="/WEB-INF/views/include/context.jsp"%>
<link href="${ctx}/static/bootstrap3.0/css/bootstrapSwitch.css" rel="stylesheet" type="text/css"  >
<link rel="stylesheet" href="${ctx}/static/css/login/form-elements.css">
<link rel="stylesheet" href="${ctx}/static/css/login/style.css">
<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
            <script src="${ctx}/static/js/html5shiv.js"></script>
            <script src="${ctx}/static/js/respond.min.js"></script>
        <![endif]-->
<script src="${ctx}/static/bootstrap3.0/js/bootstrapSwitch.js"></script>
<script>
	var captcha;
	function refreshCaptcha(){  
	    document.getElementById("img_captcha").src="${ctx}/static/images/kaptcha.jpg?t=" + Math.random();  
	}  
	</script>
</head>

<body >
<form id="loginForm"  action="${ctx}/a/login" method="post">
	<!-- Top content -->
	<input  id="checked" type="hidden" name="checked" style="width:65%;" value="${checked}"/>
	<div class="top-content">

		<div class="" >
			<div class="container" >
				<div class="row">
					<div class="col-sm-4 col-sm-offset-2 text">
						<h1 >
							<strong>管理层登录</strong> 
						</h1>
						
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							
							<div id="errormsg" style="color:red;">${info}</div>
							<div class="login_main_errortip"  style="color:red;">&nbsp;</div>
						</div>
						<div class="form-bottom">
							<form role="form" action="" method="post" class="login-form requred">
								<input id="rm" name="rememberMe" type="hidden" value="true"/>
								<div class="form-group">
									<label class="sr-only" for="username">Username</label> 
									<input type="text" name="username" placeholder="请输入管理层账号..."
										class="form-username form-control" id="form-username"  />
								</div>
								<div class="form-group" >
										<label class="sr-only" for="password">Password</label> 
										<input
											 type="password" name="password" placeholder="请输入密码..."
											class="form-password form-control"   id="form-password" >								
								</div>
								<div class="form-group">
								</div>
								<div class="form-group">
									<div>
										<input type="text" id="captcha" name="captcha" style="width:60%;"  placeholder="请输入验证码..." />
										<img alt="验证码" src="${ctx}/static/images/kaptcha.jpg" title="点击更换" id="img_captcha" onclick="javascript:refreshCaptcha();" style="height:45px;width:85px;float:right;margin-top:2px;"/>
									</div>
								</div>
								<button id="subBtn" type="submit" class="btn btn-block">登 录</button>
								
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
</form>
	<c:choose>
		<c:when test="${error eq 'com.kbook.system.utils.CaptchaException'}">
			<script>
				$(".login_main_errortip").html("验证码错误，请重试");
			</script>
		</c:when>
		<c:when test="${error eq 'org.apache.shiro.authc.UnknownAccountException'}">
			<script>
				$(".login_main_errortip").html("帐号或密码错误，请重试");
			</script>
		</c:when>
		<c:when test="${error eq 'org.apache.shiro.authc.IncorrectCredentialsException'}">
			<script>
				$(".login_main_errortip").html("用户名不存在，请重试");
			</script>
		</c:when>
	</c:choose>

	<script src="${ctx}/static/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctx}/static/bootstrap/js/bootstrapValidator.min.js"></script>
	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
	<script type="text/javascript">
	var isremember;
	$(document).ready(function(){
		
		${empty info ?"$('#errormsg').hide();":"$('#errormsg').show();"};
			$.backstretch("${ctx}/static/images/1.jpg");
		 setTimeout(function(){
		        hiddenmsg();
		    },3000);
		 function hiddenmsg(){
			 $("#errormsg").fadeOut("slow");
		 }
		
		 var account=getCookie("account");
		 var psd= getCookie("psd");
		
		 $("#form-username").val(account);
		 $("#form-password").val(psd);

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
            		},
            		captcha:{
            			message: '验证码错误，请重试',
                		validators: {
                    		notEmpty: {
                        		message: '请输入验证码.'
                    		}
                		}
            		}
	            }
	            });
		//存放信息到cookie
		$('#subBtn').click(function (){
			isremember=$('#isremember').bootstrapSwitch('status');
			$('#checked').val(isremember);
			
			if(isremember==true){
				var account= $("#form-username").val();
				var psd=$('#form-password').val();
				
				SetCookie("account",account);
				SetCookie("psd",psd);
			}else{
				SetCookie("account","");
				SetCookie("psd","");
			}
			
			
			});
		
		});
	
	//关于cookie的操作方法
	function SetCookie(name,value)//两个参数，一个是cookie的名子，一个是值
	{
	    document.cookie = name + "="+ escape (value);
	}
	function getCookie(name)//取cookies函数        
	{
	    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
	     if(arr != null) return unescape(arr[2]); return null;

	}
	function delCookie(name)//删除cookie
	{
	    var exp = new Date();
	    exp.setTime(exp.getTime() - 1);
	    var cval=getCookie(name);
	    if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString();
	}
	</script>
		<script src="${ctx}/static/js/scripts.js"></script>
	
</body>

</html>