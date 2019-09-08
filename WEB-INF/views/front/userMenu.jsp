<%@page import="com.kbook.system.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="HandheldFriendly" content="true" />
<meta name="MobileOptimized" content="320" />
<%@ include file="/WEB-INF/views/include/context.jsp"%>
<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
	
<title>首页</title>

<style type="text/css">
.btn-fontsize {
	font-size: 180%
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
<body>
	<br />
	<div class="container" align="center" style="color:white;">
		<shiro:principal property="name"/>
	</div>
	<div class="container" align="center" style="margin-top:20px; ">
		<div class="well center-block"
			style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0002"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">实时满座率</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0001"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">满座率统计表</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0003"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">预收货款报表</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0004?period=2"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize"> 收入报表(金额)</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0005?period=2"><button
						type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">收入报表(时间)</button>
				</a>
			</div>
			
			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/system/rpt0006"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">会员统计报表</button>
				</a>
			</div>
			
			<div class="container" style="margin-bottom:0px;letter-spacing:4px;">
				<a href="${ctx}/a/logout"><button
						type="button" class="btn btn-danger btn-lg btn-block btn-fontsize">登出</button>
				</a>

			</div>
		</div>

	</div>
</body>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script src="${ctx}/static/js/utility.js"></script>

<script type="text/javascript">
   		$(function() {
   			$.backstretch("${ctx}/static/images/1.jpg");
			setCookie('initOpened','0',null,'/');
	});
</script>
</html>