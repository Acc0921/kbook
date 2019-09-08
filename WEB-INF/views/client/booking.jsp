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

<title>订位</title>

<meta http-equiv="refresh" content="60">
<!-- 60秒刷新一次 -->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="<%=basePath%>static/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/clock.css" rel="stylesheet">
<script src="<%=basePath%>static/js/jquery.shCircleLoader.js"
	type="text/javascript"></script>
<style type="text/css">
.vertical-center {
	position: absolute;
	width: 90%;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	top: 50%;
}

.h-center {
	position: absolute;
	left: 50%;
}

.btn-wh {
	height: 80px;
	margin-bottom: 20px;
	font-size: 23px;
}
</style>
<script src="<%=basePath%>static/plugins/jquery/jquery-2.1.4.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/js/sockjs-0.3.min.js"></script>
<script src="<%=basePath%>static/js/moment.min.js"></script>

<link href="<%=basePath%>static/css/waitMe.min.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>static/bootstrap/css/bootstrap-dialog.min.css"
	rel="stylesheet" type="text/css" />
<script src="<%=basePath%>static/bootstrap/js/bootstrap-dialog.min.js"></script>
<script src="<%=basePath%>static/js/waitMe.min.js"></script>
<script>
	function run_waitMe() {
		$('.containerBlock').waitMe({
			effect : 'bounce',
			text : '正在登录，请稍候...',
			bg : 'rgba(255,255,255,0.7)',
			color : '#000',
			sizeW : '',
			sizeH : '',
			source : 'img.svg'
		});
	}

	function run_waitMe_body(effect) {
		$('body').addClass('waitMe_body');
		var img = '';
		var text = '';
		if (effect == 'img') {
			img = 'background:url(\'img.svg\')';
		} else if (effect == 'text') {
			text = 'Loading...';
		}
		var elem = $('<div class="waitMe_container ' + effect + '"><div style="' + img + '">'
				+ text + '</div></div>');
		$('body').prepend(elem);

		setTimeout(function() {
			$('body.waitMe_body').addClass('hideMe');
			setTimeout(function() {
				$('body.waitMe_body').find(
						'.waitMe_container:not([data-waitme_id])').remove();
				$('body.waitMe_body').removeClass('waitMe_body hideMe');
			}, 200);
		}, 4000);
	}

	function showMsg(msg) {
		BootstrapDialog.show({
			title : '提示',
			message : "<b>" + msg + "</b>\n\n",
			closable : true,

			closeByBackdrop : false,
			closeByKeyboard : false,
			buttons : [ {
				label : ' 确 定',
				cssClass : 'btn-primary btn-large',
				action : function(dialogRef) {
					dialogRef.close();
				}
			} ]
		});

	}
</script>

</head>

<body>
	<div class="containerBlock">
		<div class="container">
			<div class="row ">

				<div id="clock" class="light">

					<div id="welcomemsg">
						欢迎光临K书吧，<span class="red">需要订位请刷卡</span>，当前时间是
					</div>
					<div class="display">
						<div class="date"></div>
						<div class="digits"></div>
					</div>
					<div></div>
				</div>

			</div>
		</div>
	</div>
	
	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
	<script type="text/javascript">
		var msginfo;
		var ws;
		$(document).ready(function() {
			$.backstretch("${ctx}/static/images/2.jpg");
			connect();
			$('#leave').click(function() {
				try {
					ws.send('leave:' + carid);
				} catch (e) {
					showMsg(e);
				}
			});
		});

		function connect() {
			ws = new WebSocket('ws://${serverpath}${ctx}/websck');
			ws.onopen = function() {
				setConnected(true);
			};
			ws.onmessage = function(event) {
				//showMsg(event.data);
				var rdata = event.data.split(':');
				if (rdata.length > 0) {
					//如果是订位
					if (rdata[0] == 'booking') {
						if (rdata[1] == 'error') {
							showMsg(rdata[2]);
							return;
						} else {
							msginfo = rdata[1].split(',');
							//showMsg('现在进入订位系统，请稍后...');
							try {
								run_waitMe();
							} catch (e) {
								alert(e);
							}
							location.href = 'http://${serverpath}${ctx}/front/dynamicLogin?Account='
									+ msginfo[1] + '&DynPwd=' + msginfo[2];
						}
					}
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

	<script>
		$(function() {
			var clock = $('#clock');
			//定义数字数组0-9
			var digit_to_name = [ 'zero', 'one', 'two', 'three', 'four',
					'five', 'six', 'seven', 'eight', 'nine' ];
			//定义星期
			var weekday = [ '周日', '周一', '周二', '周三', '周四', '周五', '周六' ];

			var digits = {};

			//定义时分秒位置
			var positions = [ 'h1', 'h2', ':', 'm1', 'm2', ':', 's1', 's2' ];

			//构建数字时钟的时分秒

			var digit_holder = clock.find('.digits');

			$.each(positions, function() {

				if (this == ':') {
					digit_holder.append('<div class="dots">');
				} else {

					var pos = $('<div>');

					for ( var i = 1; i < 8; i++) {
						pos.append('<span class="d' + i + '">');
					}

					digits[this] = pos;

					digit_holder.append(pos);
				}

			});

			// 让时钟跑起来
			(function update_time() {

				//调用moment.js来格式化时间
				var now = moment().format("HHmmss");

				digits.h1.attr('class', digit_to_name[now[0]]);
				digits.h2.attr('class', digit_to_name[now[1]]);
				digits.m1.attr('class', digit_to_name[now[2]]);
				digits.m2.attr('class', digit_to_name[now[3]]);
				digits.s1.attr('class', digit_to_name[now[4]]);
				digits.s2.attr('class', digit_to_name[now[5]]);

				var date = moment().format("YYYY年MM月DD日");
				var week = weekday[moment().format('d')];
				$(".date").html(date + ' ' + week);

				// 每秒钟运行一次
				setTimeout(update_time, 1000);

			})();
		});
	</script>
</body>
</html>
