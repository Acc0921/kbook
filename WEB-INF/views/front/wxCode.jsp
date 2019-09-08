<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>领取微信会员卡</title>
<%@ include file="/WEB-INF/views/include/context.jsp"%>
</head>
<body>
</body>
<script src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script>
      wx.config({
          debug: false,
          appId: '${appId}',
          timestamp: '${timestamp}',
          nonceStr: '${nonceStr}',
          signature: '${signature}',
          jsApiList: ['addCard']
      });
      wx.ready(function(){
    	  var data = '{"code":"${code}","openid":"${openid}","card_id":"${cardId}","nonce_str":"${nonceStr}","timestamp":"${timestamp}","signature":"${signature}"}'
    	  //添加卡券
          wx.addCard({
            cardList: [
              {
                cardId: "${cardId}", 
                cardExt: data
              }
            ],
            success: function (res) {
              alert('已添加卡券：' + JSON.stringify(res.cardList));
            }
          });
    	  //返回会员卡界面时  关闭窗口
    	  WeixinJSBridge.call('closeWindow');
      });
</script>
</html>
