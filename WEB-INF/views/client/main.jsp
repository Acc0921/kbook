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

<title>签到</title>

<meta http-equiv="refresh" content="60">
<!-- 60秒刷新一次 -->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<link href="<%=basePath%>static/bootstrap/css/bootstrap.css"
	rel="stylesheet">
<link href="<%=basePath%>static/css/clock.css" rel="stylesheet">
<style type="text/css">
.h-center {
	position: absolute;
	left: 50%;
}

.btn-wh {
	height: 80px;
	margin-bottom: 20px;
	font-size: 23px;
}

.title-font{font-size:180%}
</style>
<script src="<%=basePath%>static/plugins/jquery/jquery-2.1.4.min.js"></script>
<script src="<%=basePath%>static/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/js/sockjs-0.3.min.js"></script>
<script src="<%=basePath%>static/js/moment.min.js"></script>

<link href="<%=basePath%>static/bootstrap/css/bootstrap-dialog.min.css"
	rel="stylesheet" type="text/css" />
<script src="<%=basePath%>static/bootstrap/js/bootstrap-dialog.min.js"></script>
</head>
<script type="text/javascript">
	function showMsg(msg) {
		BootstrapDialog.show({
			title: '提示',
			message : "<b>"+ msg +"</b>\n\n",
			closable : true,
			
			closeByBackdrop : false,
			closeByKeyboard : false,
			buttons : [ {
				label : ' 确 定',
				cssClass: 'btn-primary btn-large',
				action : function(dialogRef) {
					dialogRef.close();
				}
			} ]
		});

	}
</script>
<body>

	<div class="container">
		<div class="row ">

			<div id="clock" class="light">
			
				<div id="welcomemsg">
					欢迎光临K书吧，<span class="red">结账或请假请刷卡</span>，当前时间是
				</div>
				<div class="display">
					<div class="date"></div>
					<div class="digits"></div>
				</div>
				<div></div>
			</div>

			<div id="opdiv" class="hidden" style="margin-top:100px;">
				<div class="text-center" style="font-size:20px;margin-bottom:20px;">
					<span id="username"></span>（<span id="accout"></span>），欢迎访问K书吧。
				</div>
				<button id="leave" type="button"
					class="btn btn-info btn-lg btn-block btn-wh">请 假</button>
				<button id="invoicing" type="button"
					class="btn btn-primary btn-lg btn-block btn-wh">结 账</button>
				<button id="cancelbtn" type="button"
					class="btn btn-lg btn-block btn-wh">取 消</button>
			</div>

		</div>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$.backstretch("${ctx}/static/images/2.jpg");
    	});

			var ws = null;
			var carid;
			var memberid;
			var showleave = 1;

			$(document).ready(function() {
				connect();
				$('#leave').click(function() {
					try {
						ws.send('leave:' + carid + ':' + memberid);
					} catch (e) {
						showMsg(e);
					}
				});
				$('#invoicing').click(function() {
					try {
						ws.send('invoicing:' + carid + ':' + memberid);
					} catch (e) {
						showMsg(e);
					}
				});
				$('#cancelbtn').click(function() {
					showClock();
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
						//如果是消费
						if (rdata[0] == 'consume') {
							if (rdata[1] == 'error') {
								showMsg(rdata[2]);
								return;
							}
							try {
								carid = rdata[1];
								memberid = rdata[2];
								showleave = rdata[3];
								if (showleave == 1) {
									$('#leave').show();
								} else {
									$('#leave').hide();
								}
								$('#username').html(rdata[4]);
								$('#accout').html(rdata[5]);
								hideClock();
							} catch (e) {
								showMsg(e);
							}
						}
						if (rdata[0] == 'leave-result') {
							if (rdata[1] == '1')
								showMsg("已经办理请假！");
							showClock();
						}
						if (rdata[0] == 'error') {
							//showMsg("出错了，请与管理员联系！");
							showMsg(rdata[1]);
							showClock();
						}
						if (rdata[0] == 'success') {
							showMsg('已成功结账！使用时间：' + rdata[1] + '小时， 共消费点数：'
									+ rdata[2] + '点');
							showClock();
						}
						if (rdata[0] == 'preferential') {
							showMsg("您好！您的产品还剩" + rdata[1] + "天，到" + rdata[2]
									+ "结束");
							showClock();
						}
					}

				};
				ws.onclose = function(e) {
					console.log("close:" + e.wasClean/**e.code,e.error*/
					);//连接是否顺利关闭  
					//ws.close(1000,"正常关闭");  
					ws.close();
					connect();
					showClock();
				};
			}
			function hideClock() {
				$('#clock').hide();
				$('#opdiv').removeClass().addClass('vertical-center');
			}
			function showClock() {
				$('#clock').show();
				$('#opdiv').removeClass().addClass('vertical-center hidden');
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
