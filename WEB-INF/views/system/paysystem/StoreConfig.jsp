<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>门店信息</title>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">门店信息配置</h2>
			<form class="layui-form" action="${ctx}/system/store/setUnionPayFee" method="post" id="storeConfigForm">
              <div class="layui-form-item">
                <label class="layui-form-label">门店名称：</label>
                <div class="layui-input-block">
                  <h2 class="textIpt">${StoreConfig.name}</h2>
                </div>
                </div>
                <div class="layui-form-item">
                  <input type="hidden" id="id" name="id" value="${StoreConfig.unionPay.id}"/>
                  <label class="layui-form-label">门店类型：</label>
                  <div class="layui-input-block">
                  	<c:if test="${StoreConfig.unionPay.type == 2}">
                  		企业

                  	</c:if>
                  	<c:if test="${StoreConfig.unionPay.type == 3}">
                  		个人
                  	</c:if>
					<c:if test="${empty StoreConfig.unionPay.type}">
						未注册
                  	</c:if>
                  </div>
                </div>
<!--                 <div class="layui-form-item">
                  <label class="layui-form-label">手续费率：</label>
                  <div class="layui-input-block feeRate">
                    <input type="radio" value="按比例" title="按比例" checked="">
                    <input type="radio" name="feeRate" value="按交易次数" title="按交易次数">
                  </div>
                </div> -->
                <div class="layui-form-item rateBox">
                  <div class="layui-inline">
                    <label class="layui-form-label">交易手续费：</label>
                    <div class="layui-input-inline">
                      <input type="text" name="fee" id="fee" lay-verify="required" autocomplete="off" class="layui-input" value ="${StoreConfig.unionPay.fee}">
                    </div>
                    <div class="layui-form-mid textRed">%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;例：每笔1%</div>
                  </div>
                </div>
                <div class="layui-form-item rateBox">
                  <div class="layui-inline">
                    <label class="layui-form-label">提现手续费：</label>
                    <div class="layui-input-inline">
                      <input type="text" name="withdrawFee" id="withdrawFee" lay-verify="required" autocomplete="off" class="layui-input" value ="${StoreConfig.unionPay.withdrawFee}">
                    </div>
                    <div class="layui-form-mid textRed">元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;例：每笔1元</div>
                  </div>
                </div>
               <!--  <div class="layui-form-item intBox hide">
                  <div class="layui-inline">
                    <label class="layui-form-label">手续费：</label>
                    <div class="layui-input-inline">
                      <input type="number" lay-verify="required" autocomplete="off" class="layui-input payFor">元
                    </div>
                    <div class="layui-form-mid textRed">例：每笔1元</div>
                  </div>
                </div> -->
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">注册状态：</label>
                  <div class="layui-input-block">
                    <h2 class="textIpt">
                    	<c:if test="${StoreConfig.unionPay.type == 2}">
                    		<c:choose>
                    			<c:when test="${not empty StoreConfig.unionPay.isSignContract}">已注册</c:when>
                    			<c:otherwise><span class="textRed">未注册：先注册银联，再配置门店信息</span></c:otherwise>
                    		</c:choose>
	                  	</c:if>
	                  	<c:if test="${StoreConfig.unionPay.type == 3}">
	                  		<c:choose>
                    			<c:when test="${not empty StoreConfig.unionPay.ucid}">已注册</c:when>
                    			<c:otherwise><span class="textRed">未注册：先注册银联，再配置门店信息</span></c:otherwise>
                    		</c:choose>
	                  	</c:if>
	                  	<c:if test="${empty StoreConfig.unionPay}">
	                  		<span class="textRed">未注册：先注册银联，再配置门店信息</span>
	                  	</c:if>
                    </h2>
                  </div>
                </div>
<!--                 <div class="layui-inline">
                  <span class="textRed">说明：先要向系统注册成为会员，再配置门店信息</span>
                </div> -->
              </div>
            </form>
              <div class="layui-form-item">
                 <label class="layui-form-label"></label>
                 <div class="layui-form-item twoBtnBox">
                 	 <button class="layui-btn layui-btn-danger" onclick="self.location=document.referrer;">返回门店</button>
				 	 <button class="layui-btn" onclick="submitForm()">提交设置</button>
				 </div>
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

          $('.feeRate .layui-form-radio:nth-child(2)').click(function(event) {
              $('.rateBox').removeClass('hide');
              $('.intBox').addClass('hide');
          });
          $('.feeRate .layui-form-radio:nth-child(4)').click(function(event) {
              $('.intBox').removeClass('hide');
               $('.rateBox').addClass('hide');
          });

        });
        
        function submitForm() {
    		var fee = $("#fee").val();
    		if (fee == '' || fee > 99) {
    			layer.open({
    				title : [ '提示' ],
    				content : '手续费请输入0或者其他数字！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		
    		var withdrawFee = $("#withdrawFee").val();
    		if (withdrawFee == '' || withdrawFee > 99) {
    			layer.open({
    				title : [ '提示' ],
    				content : '手续费请输入0或者其他数字！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		
    		$("#storeConfigForm").submit();
        };
    </script>
</html>