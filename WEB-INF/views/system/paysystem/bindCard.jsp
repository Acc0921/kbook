<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>绑定银行卡</title>
        <%@ include file="/WEB-INF/views/include/easyui.jsp"%>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">绑定银行卡&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red; font-weight: bold;" id="messBox">${Message}</span></h2>
            <form class="layui-form" action="${ctx}/system/store/bingCardForm" method="post" id="bingCardForm">
              <div class="layui-form-item">
                <label class="layui-form-label">银行卡号：</label>
                <div class="layui-input-block">
                  <input type="text" oninput="value=value.replace(/[^\d]/g,'')" lay-verify="required" autocomplete="off" placeholder="请输入银行卡号" class="layui-input" id="cardNo" name="cardNo">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">银行预留手机号：</label>
                <div class="layui-input-inline">
                    <input type="text" placeholder="请输入银行预留手机号" maxlength="11" id="phone" name="phone" class="layui-input" />
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">姓名：</label>
                  <div class="layui-input-inline">
                    <input type="text" name="nickName" id="nickName" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                  </div>
                  <div class="layui-form-mid textRed">如果是企业会员，请填写法人姓名</div>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">证件类型：</label>
                  <div class="layui-input-block">
                    <select lay-filter="aihao" id="type" name="type">
                       <option value="1">身份证</option>
                      <!-- <option value="2">护照</option>
                      <option value="3">军官证</option>
                      <option value="4">回乡证</option>
                      <option value="5">台胞证</option>
                      <option value="6">警官证</option>
                      <option value="7">士兵证</option>
                      <option value="99">其他证件</option> -->
                    </select>
                  </div>
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">证件号码：</label>
                <div class="layui-input-block">
                  <input type="tel" id="identityNo" name="identityNo" lay-verify="required" autocomplete="off" placeholder="请输入证件号码" class="layui-input">
                </div>
              </div>
              <!-- <div class="layui-form-item">
                <label class="layui-form-label">支付行号：</label>
                <div class="layui-input-block">
                  <input type="tel" lay-verify="required" autocomplete="off" placeholder="请输入支付行号" class="layui-input">
                </div>
              </div> -->
             <!--  <div class="layui-form-item">
                <label class="layui-form-label">绑定状态：</label>
                <div class="layui-input-block">
                  <h2 class="textIpt">未绑定/绑定中/绑定成功</h2>
                </div>
              </div> -->
              <!-- <div class="layui-form-item">
                <label class="layui-form-label">手机验证码：</label>
                <div class="layui-input-inline">
                  <input type="tel" name="code" id="code" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid textRed">如果未绑定，先点击绑定…收到手机验证码后，填写验证码后，再点击确认绑定.</div>
              </div> -->
            </form>
            <div class="layui-form-item twoBtnBox">
                <!-- <button class="layui-btn" type="button">绑定</button> -->
                <button class="layui-btn" onclick="submitForm()">绑定</button>
            </div>
        </div>
    </body>
    <script>
        layui.use(['form', 'layedit', 'laydate','upload'], function(){
          var $ = layui.jquery
          ,form = layui.form
          ,layer = layui.layer
          ,layedit = layui.layedit
          ,laydate = layui.laydate
          ,upload = layui.upload;

        });
        
        function submitForm() {
        	var cardNo = $("#cardNo").val();
        	var phone = $("#phone").val();
    		var nickName = $("#nickName").val();
    		var identityNo = $("#identityNo").val();
    		//var code = $("#code").val();
    		//校验姓名 
    		/* if(!(/^[\u4e00-\u9fa5]{2,4}$/.test(nickName))){  
    			layer.open({
    				title : [ '提示' ],
    				content : '真实姓名填写有误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		} 
    		//校验手机号
    		if (!(/^1[34578]\d{9}$/.test(phone))) {
    			layer.open({
    				title : [ '提示' ],
    				content : '请输入正确的手机号码！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		//校验身份证信息
    		var regIdNo = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
    		if(!(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(identityNo))){   
    		    layer.open({
    				title : [ '提示' ],
    				content : '身份证号填写有误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return; 
    		}   */
    		
    		$("#bingCardForm").submit();
        };
    </script>
</html>