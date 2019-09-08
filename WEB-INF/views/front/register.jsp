<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>

<%
    Object sessionValues=session.getAttribute(Constants.CURRENT_MEMBER);
    Member mbr = (Member)sessionValues;
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
    <title>会员注册</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/public.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/need/layer.css" />
    <link rel="stylesheet" href="${ctx}/static/css/pcstyle.css"  media="handheld and (max-width:480px), screen and (min-width:500px)"/>
    <script type="text/javascript" src="${ctx}/static/js/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/reservation.js?v=123"></script>
    </head>
    <header><a onClick="javascript :history.back(-1);"><em></em></a>会员注册</header>
    <body>         
        <form class="loginBox"  action="${ctx}/front/member/registerMember" method="post" id="codeForm">
            <div class="loginTop loginTopNew font16">
                <p>去K书会员注册</p>
            </div>
            <div class="inputBox inputBoxNew clearfix">
                <p>手机号码：</p>
                <input type="text" placeholder="请输入手机号" maxlength="11" id="phoneNumber" name="tel"/>
                <button type="button" class="resbtn yzBtn" onclick="time(this);">获取验证码</button>
            </div>
            <div class="inputBox inputBoxNew clearfix">
                <p>验证码：</p>
                <input type="text" placeholder="请输入验证码" maxlength="6" id="code" name="mes"/>
                <span style="color:red;font-weight:bold;" id="messBox">${msg}</span>
            </div>
            <div class="inputBox inputBoxNew clearfix">
                <p>密码：</p>
                <input type="password" placeholder="请输入密码" name="password" id="password"/>
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p style="padding-left: 32px;">门店：</p>
                <div class="inputR selectTwo">
                	<select name="cityId" id="storeCity">
                        <option value ="city">城市</option>
                    </select>
                    <select name="storeId" id="storeName">
                        <option value ="store">门店名称</option>
                    </select>
                </div>
            </div>
            </br>
            <div class="agreement">
                <input type="checkbox" name="agree" id="agree" checked="checked" />
                <label for="agree">我已阅读<a href="javascript:;" onclick="notice();">《会员须知》</a>，同意会员规则</label> 
            </div>
            <button type="button" class="checkBtn registerBtn" onclick="submitForm()" style="margin-top : 20px">注册</button>
        </form>
        
    </body>
<script type="text/javascript">

	$(function() {
		//动态拼接城市和门店名称
		$.ajax({
			type : "GET",
			url : "${ctx}/system/city/getAllJson",
			dataType : "json",
			success : function(json) {
				//$("#storeCity").empty();
				//alert("验证码是:"+json.rows);
				var op = "";
				for (var i = 0; i < json.rows.length; i++) {
					var cityName = json.rows[i].name;
					//alert("城市名称:"+cityName+"---"+cityid);
					//根据城市id获取门店名称
					var cityid = json.rows[i].id;

					op += '<option value ="'+cityid+'">' + cityName
							+ '</option>';
				}
				$("#storeCity").append(op);
			}
		});

		$("#storeCity")
				.change(
						function() {
							//$("#storeCity").empty().append('<option value ="+cityName+">'+cityName+'</option>');
							var cityid = $("#storeCity").val();
							//alert("城市id:"+cityid);
							$
									.ajax({
										type : "GET",
										url : "${ctx}/system/store/getStoreByCityId?cityId="
												+ cityid,
										dataType : "json",
										success : function(data) {
											var options = '<option value ="store">门店名称</option>';
											for (var j = 0; j < data.rows.length; j++) {
												var storeName = data.rows[j].name;
												var storeid = data.rows[j].id;
												//alert("门店名称："+storeName);
												options += '<option value ="'+storeid+'">'
														+ storeName
														+ '</option>';
												//$("#storeName").empty().append('<option value ="+storeName+">'+storeName+'</option>');
											}
											$("#storeName").empty().append(
													options);
										}
									});
						});

	});

	//获取校验码
	function layer_getYz() {
		layer.open({
			title : [ '提示' ],
			content : '请先输入手机号码',
			shadeClose : false,
			btn : [ '确定' ]
		});
	};

	//获取验证码倒计时
	function time(t) {
		var phone = $('#phoneNumber').val();
		if (phone == '') {
			layer_getYz();
		} else {
			//校验手机号
			if (!(/^[1][3,4,5,6,7,8,9][0-9]{9}$/.test(phone))) {
				layer.open({
					title : [ '提示' ],
					content : '请输入正确的手机号码',
					shadeClose : false,
					btn : [ '确定' ]
				});
			} else {
				//发送验证码到用户手机
				$.ajax({
					type : "GET",
					url : "${ctx}/system/code/getCode?tel=" + phone,
					dataType : "json",
					success : function(json) {
						//alert("验证码是:"+json);
					}
				});
				var wait = 60;
				setTime(t, wait);

			}

		}
	};

	function setTime(t, wait) {

		if (wait == 0) {
			t.removeAttribute("disabled");
			t.innerHTML = "获取验证码";
			t.style.background = 'linear-gradient(#4850E8, #447EEC)';
			wait = 60;
			return;
		} else {
			t.setAttribute("disabled", true);
			t.innerHTML = '已发送(' + wait + 's)';
			t.style.background = '#999999';
			wait--;
			/*setTimeout(function() {
			        setTime(t);
			    },
			    1000)*/
		}

		window.setTimeout(function() {
			setTime(t, wait);
		}, 1000);
	};

	//会员须知 （注：内容的段落请用p标签）
	function notice() {
		layer.open({
					title : false,
					content : '<h1>会员须知条款</h1>'
							+ '<div class="tl" style="max-height:350px;overflow-y:auto;">'
							+ '<h2>尊敬的去K书会员：</h2>'
							+ '<p style="text-indent:2em">欢迎您成为去K书专业自习中心会员，为了给您提供优质的会员服务，我们诚挚地请您仔细阅读以下注意事项：</p>'
							+ '<p style="text-indent:2em">1.请您严格遵守馆内会员守则中的条款，如有违反我们将按照条款内容进行处理,见馆内《会员规则》</p>'
							+ '<p style="text-indent:2em">2.请您在正式开始使用会员卡前详细了解系统订座相关规则,见馆内《订座规则》</p>'
							+ '<p style="text-indent:2em">3.会员卡分为包时卡、自由储值卡。实名包时储值段消费卡，自购卡之日起7日内可无理由退款，超过7日门店有权不办理退卡手续，会员卡如需转让必须转让双方到门店现场进行实名转让。如会员卡丢失，可线上与店小二联系冻结卡内余额，重新补卡需本人到店实名办理。</p>'
							+ '<p style="text-indent:2em">4.包时卡，可在指定有效日期内连续生效（中途间断将不会顺延）、指定座位类型区域内消费使用，不可霸座，期满清零，清零后需重新购买会员卡使用</p>'
							+ '<p style="text-indent:2em">5.自由储值卡，在会员卡使用有效期内可自由选择不同K书位类型区域，不可霸座，满期清零，如不想清零需在会员卡使用有效期内续费顺延使用</p>'
							+ '<p style="text-indent:2em">6.去K书免费提供：无线WiFi、免费纯净饮用水、茶水、咖啡、糖果小食等能量补充</p>'
							+ '<p style="text-indent:2em">7.去K书价格体系的解释权归属广州趣垦投资管理有限公司所有，公司有权根据市场状态随时调整价格体系</p>'
							+ '</div>',
					shadeClose : false,
					btn : [ '关闭' ]
				});
	};

	function submitForm() {
		var phone = $('#phoneNumber').val();
		var password = $("#password").val();
		var code = $("#code").val();
		if (phone == '') {
			layer_getYz();
			return;
		}
		//校验手机号
		if (!(/^[1][3,4,5,6,7,8,9][0-9]{9}$/.test(phone))) {
			layer.open({
				title : [ '提示' ],
				content : '请输入正确的手机号码！',
				shadeClose : false,
				btn : [ '确定' ]
			});
			return;
		}
		if (password == '') {
			layer.open({
				title : [ '提示' ],
				content : '密码不能为空！',
				shadeClose : false,
				btn : [ '确定' ]
			});
			return;
		}
		if (code == '' || code.length > 6) {
			layer.open({
				title : [ '提示' ],
				content : '验证码错误！',
				shadeClose : false,
				btn : [ '确定' ]
			});
			return;
		}
		
		if ($("#storeName").val() == 'store' || $("#storeName").val() == null) {
			layer.open({
				title : [ '提示' ],
				content : '请选择门店！',
				shadeClose : false,
				btn : [ '确定' ]
			});
			return;
		}
		
		$("#codeForm").submit();
	};
</script>
</html>
