<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serverpath"
	value="${pageContext.request.serverName}:${pageContext.request.serverPort}" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String wspath = "ws://" + request.getServerName() + ":"
			+ request.getServerPort() + path + "/websck";
	System.out.println(wspath);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>显示卡号</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="<%=basePath%>static/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/clock.css" rel="stylesheet">
<style type="text/css">
.juzhong {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-left: -350px;
	margin-top: -100px;
	width: 600px;
	height: 200px;
	text-align: center;
	font-size: 25px;
	font-weight: bold;
}
</style>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/js/sockjs-0.3.min.js"></script>
<script src="<%=basePath%>static/js/moment.min.js"></script>
<script src="<%=basePath%>static/plugins/jquery/jquery-2.1.4.min.js"></script>


</head>

<body>



	<div class="juzhong">
		当前刷卡的卡号是：<span id="cardid">请刷卡</span>
	</div>

	<script type="text/javascript">
		var msginfo;
		var ws;
		$(document).ready(function() {
			connect();
		});

		function connect() {
			ws = new WebSocket('ws://${serverpath}${ctx}/websck');
			ws.onopen = function() {
				setConnected(true);
			};
			ws.onmessage = function(event) {
				//alert(event.data);
				var rdata = event.data.split(':');
				if (rdata.length > 0) {
					if (rdata[0] == 'showcar')
						$('#cardid').html(rdata[1]);
				}

			};
			ws.onclose = function(e) {
				console.log("close:" + e.wasClean/**e.code,e.error*/
				);//连接是否顺利关闭  
				//ws.close(1000,"正常关闭");  
				ws.close();
				$('p').removeClass().addClass('vertical-center hidden');
				$('#clock').show();
				connect();
			};
		}
	</script>
</body>
</html>
