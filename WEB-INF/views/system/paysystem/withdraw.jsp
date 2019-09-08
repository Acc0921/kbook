<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
	<head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>提现</title>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">提现</h2>
            <form class="layui-form" action="${ctx}/system/store/toWithdraw" method="post" id="withdrawForm">
                <div class="layui-form-item">
                  <label class="layui-form-label">账户余额：</label>
                  <div class="layui-input-block">
                  	<input type="hidden" id="money" value="${money}"/>
                  	<input type="hidden" id="storeId" name="storeId" value="${storeId}"/>
                    <h2 class="textIpt textRed">${allMoney}元</h2>
                  </div>
                  <label class="layui-form-label">可提现余额：</label>
                  <div class="layui-input-block">
                    <h2 class="textIpt textRed">${money}元</h2>
                  </div>
                </div>
                 <div class="layui-form-item">
                  <label class="layui-form-label">提取金额：</label>
                  <div class="layui-input-inline">
                    <input name="withdrawMoney" id="withdrawMoney" lay-verify="required" autocomplete="off" class="layui-input" placeholder="请输入金额（单位：元）">
                  </div>
                </div>
                <div style="margin-left: 8%"> 
               	 1、提现功能开放时间周一至周五（非节假日）每天10点至16点。</br> 
               	 2、按T+3交易规则，只能提取3天前的余额。</br>
               	 3、每天只能提现一次。</br>
               	 4、每笔提现收取<span style="color: red; font-weight: bold;" id="messBox">${fee}</span>元手续费。
               	 </div>
                <div class="layui-form-item">
              </div>
            </form>
<!--             <div>
            	  <button class="layui-btn layui-btn-danger" style="display:block;margin:0 auto" onclick="self.location=document.referrer;">返回门店</button>
                  <button class="layui-btn" style="display:block;margin:0 auto" onclick="submitForm()">提交申请</button>
            </div> -->
            <div class="layui-form-item twoBtnBox">
            		 <c:if test="${isTrue != true}">
                 	 	<button class="layui-btn layui-btn-danger" onclick="self.location=document.referrer;">返回门店</button>
                 	 </c:if>
				 	 <button class="layui-btn" onclick="submitForm()">提交申请</button>
			</div>
        </div>
    </body>
    <script>
        layui.use(['form', 'layedit', 'laydate'], function(){
           var $ = layui.jquery
          ,form = layui.form
          ,layer = layui.layer
          ,layedit = layui.layedit
          ,laydate = layui.laydate

          $('.changePhone').click(function(event) {
              $('.layerSecond').show();
          });
        });
        
        function submitForm() {
        	
        	  var date = new Date();
        	  console.log(date.getDay())
         	  if(date.getDay() == 6 || date.getDay() == 7 || !(date.getHours() >= 10 && date.getHours() < 16)){
        		layer.open({
    				title : [ '提示' ],
    				content : '提现功能开放时间周一至周五（非节假日）每天10点至16点。!',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
              }   
        	
    		var money = parseFloat($("#money").val());
    		var withdrawMoney = parseFloat($("#withdrawMoney").val());
    		if (withdrawMoney > money || withdrawMoney == 0 || withdrawMoney == '') {
    			layer.open({
    				title : [ '提示' ],
    				content : '提现金额不能比可提现金额大或为空！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		
    		$("#withdrawForm").submit();
    		
    		var layerMsg = layer.load(1,{ // 此处1没有意义，随便写个东西
    		    icon: 0, // 0~2 ,0比较好看
    		    content: '加载中...',
    		    shade: [0.5,'black'] // 黑色透明度0.5背景
    		});
        };
    </script>
</html>