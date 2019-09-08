<%--
  Created by IntelliJ IDEA.
  User: 张文斗
  Date: 2019/4/21
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="//cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script type="text/javascript" src="//static.runoob.com/assets/qrcode/qrcode.min.js"></script>
    <style type="text/css">
        body{ text-align:center}
        #divcss{margin:0 auto;}
    </style>
    <title>微信会员卡二维码</title>
</head>
<body>
微信会员卡二维码：
<div id="qrcode" style="margin: 0 auto;width: 200px;height: 200px;margin-top: 30px;">
</div>
<input type="hidden" id="wxcode" value='${wxcode}'>
</body>
<script type="text/javascript">
    $(function () {
    	var code = $("#wxcode").val();
    	var qrcode = new QRCode("qrcode", {
    	    text: code,
    	    width: 200,
    	    height: 200,
    	    colorDark : "#000000",
    	    colorLight : "#ffffff",
    	    correctLevel : QRCode.CorrectLevel.H
    	});
    	
/*     	var qr = new QRious({
            element: document.getElementById('pic'),
            size:250,
            level:"H",
            value:code
        }); */
    })
    /*(function() {
        const qr = new QRious({
            element: document.getElementById('pic'),
            size:250,
            level:"H",
            value:""
        })
    })()*/
</script>
</html>
