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
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>签到</title>

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
<body>
	<div class="container">
		<div class="row ">

			<div id="clock" class="light">
				<div id="welcomemsg">
					欢迎光临<span style="font-size:1.5em;color:#4B8A08"> 去K书 </span>，<div style="color:#0174DF">结账或请假请刷卡，当前时间是</div>
				</div>
				<div class="display">
					<div class="date"></div>
					<div class="digits"></div>
				</div>
				<div></div>
			</div>

			<div id="opdiv" class="hidden" style="margin-top:100px;">
				<div class="text-center" style="font-size:20px;margin-bottom:20px;">
					<span id="username">${member.name }</span>（<span id="accout">${member.cardid
						}</span>），欢迎访问K书吧。
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

			var ws = null;
			var carid;
			var memberid;
			var seatstatus = 0;
			var showleave = 1;
			var errormsg = "";

			window.alert = function(text) { 
				showMsg(text);
			}
			$(document).ready(function() {
				$.backstretch("${ctx}/static/images/2.jpg");
				if(${errormsg != null}){
					alert('${errormsg}');
					return;
				}
				$('#leave').click(function() {
					showClock();
					$.get('<%=basePath%>front/settlement','leave=1&t=' + Math.random(),function(data){
						var obj = jQuery.parseJSON(data);
						alert(obj.msg); 
					}); 
				});
				$('#invoicing').click(function() {
					showClock();
					try{
					$.get('<%=basePath%>front/settlement','leave=0&t=' + Math.random(),function(data){
						var obj = jQuery.parseJSON(data);
						alert(obj.msg); 
					});
					}catch(e){
						alert(e);
					}
					
				});
				$('#cancelbtn').click(function() {
					showClock();
				});
				
				if(${logined}){
					showleave = ${showleave};
					seatstatus = ${seatstatus};
					if(seatstatus == 1){
						alert("您好！订单库中没有找到您的订单，请与管理员联系！");
						return;
					}
					if(seatstatus == 2){
						alert("您好！你还没有签到，必须签到后才能进行本操作。\n 请遵守K书吧的系统操作流程，如有问题，请与管理员联系！");
						return ;
					}
	
					hideClock();	
				}else{
					showMsg("系统没有本会员卡卡号资料，请与管理员联系。");
				}
			});

			function hideClock() {
				$('#clock').hide();
				$('#opdiv').removeClass().addClass('vertical-center');
			}
			function showClock() {
				$('#clock').show();
				$('#opdiv').removeClass().addClass('vertical-center hidden');
			}

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
