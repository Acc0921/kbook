<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/qrious.min.js"></script>
    <style type="text/css">
        body{ text-align:center}
        #divcss{margin:0 auto;}
    </style>
    <title>微信会员卡激活失败</title>
</head>

<body onload="closeWindow();">
<h1>激活失败</h1>
<div id="show">  
  	将倒计时5秒后关闭当前窗口，<c:choose><c:when test="${CodeType == 1}">返回首页</c:when><c:otherwise>返回会员卡窗口</c:otherwise></c:choose>
</div>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script type="text/javascript">
	var time = 5;
	function closeWindow() {
		window.setTimeout('closeWindow()', 1000);
		if('${CodeType}' == 1){
			if (time > 0) {
				document.getElementById("show").innerHTML = " 将倒计时<font color=red>"
						+ time + "</font>秒后关闭当前窗口,返回首页";
				time--;
			} else {
				window.location.href='${ctx}/front/member';
			}
		}else{
			if (time > 0) {
				document.getElementById("show").innerHTML = " 将倒计时<font color=red>"
						+ time + "</font>秒后关闭当前窗口,返回会员卡窗口";
				time--;
			} else {
				WeixinJSBridge.call('closeWindow');
				//parent.WeixinJSBridge.call('closeWindow');
				//this.window.opener=null; //关闭窗口时不出现提示窗口  
				//window.close();  
			}
		}
		
		
	}
</script>
</html>
