<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>


<%
	String error = (String) request
			.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
	request.setAttribute("error", error);
%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
	<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta name="HandheldFriendly" content="true"/>
<meta name="MobileOptimized" content="320"/>
<%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${ctx}/static/bootstrap/js/bootstrapValidator.min.js"></script>
    <title >首页</title>
   	<style type="text/css">
		.btn-fontsize{font-size:140%}
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

<body>
  <div class="container"  >
	<br/>
    <div class="well center-block" style="max-width: 800px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
		<div class="row">
			<!-- form: -->

				<div class="col-lg-8 col-lg-offset-2 ">					
					<form id="defaultForm" method="post" class="form-horizontal"
						action="${ctx}/front/member/changePassword">


						<div class="form-group">
							<label class="col-lg-3 control-label btn-fontsize">密码：</label>
							<div class="col-lg-5">
								<input type="password" class="form-control" name="password" />
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-3 control-label btn-fontsize">确认密码：</label>
							<div class="col-lg-5">
								<input type="password" class="form-control"
									name="confirmPassword" />
							</div>
						</div>
						<button type="submit" class="btn btn-success btn-lg btn-block 	 btn-fontsize">提交修改</button>
						<br/>
						<button type="button" class="btn btn-success btn-lg btn-block 	 btn-fontsize" id="cancelBtn">返回</button>
						<br/>
						<div id="myAlert" class="alert alert-success center"
							style="width:90%;text-align:center;position:absolute;left:expression((body.clientWidth-50)/2);">
							<a href="#" class="close" data-dismiss="alert">×</a> <strong>修改成功</strong>。
						</div>
					</form>
				</div>

			<!-- :form -->
			
		</div>
		 
	</div>
  </div>

   <script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
   <script type="text/javascript">
   		$(function() {
   			$.backstretch("${ctx}/static/images/1.jpg");
   		});
   	</script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('#myAlert').hide();
					// Generate a simple captcha
					function randomNumber(min, max) {
						return Math
								.floor(Math.random() * (max - min + 1) + min);
					}
					;
					$('#captchaOperation').html(
							[ randomNumber(1, 100), '+', randomNumber(1, 200),
									'=' ].join(' '));

					$('#defaultForm').bootstrapValidator({
						//        live: 'disabled',
						message : 'This value is not valid',
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						fields : {

							password : {
								validators : {
									notEmpty : {
										message : '密码不能为空'
									},
									identical : {
										field : 'confirmPassword',
										message : '两次输入密码不相同.'
									}
								}
							},
							confirmPassword : {
								validators : {
									notEmpty : {
										message : '密码不能为空'
									},
									identical : {
										field : 'password',
										message : '两次输入密码不相同.'
									}
								}
							}
						}
					}).on(
							'success.form.bv',
							function(e) {
								// Prevent form submission
								e.preventDefault();

								// Get the form instance
								var $form = $(e.target);

								// Get the BootstrapValidator instance
								var bv = $form.data('bootstrapValidator');

								// Use Ajax to submit form data
								$.post($form.attr('action'), $form.serialize(),
										function(result) {
											if (result == 'success') {
												$('#myAlert').show();
												$form.bootstrapValidator(
														'disableSubmitButtons',
														false);
											}
										});
							});

					$('#resetBtn').click(
							function() {
								$('#defaultForm').data('bootstrapValidator')
										.resetForm(true);
							});
					$('#cancelBtn').click(
						function(){
							window.history.back();
						}
					);
				});
		$(".close").click(function() {
			$("#myAlert").hide();
		});
	</script>
</body>
</html>