<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>绑定手机号</title>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">绑定手机号</h2>

		<div class="centerBox">
			<form class="layui-form" action="${ctx}/system/store/bingPhone" method="post" id="codeForm">
				<div class="layui-form-item">
					<label class="layui-form-label">手机号码：</label>
					<div class="layui-input-inline">
						<input type="text" placeholder="请输入手机号" maxlength="11" id="phone"
							name="phone" class="layui-input" />
					</div>
					<div class="layui-form-mid layui-word-aux yzcode">
						<button class="layui-btn" type="button" onclick="time(this);">获取验证码</button>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">手机验证码：</label>
					<div class="layui-input-inline">
						<input type="text" placeholder="请输入验证码" maxlength="6" id="code"
							name="code" class="layui-input" /> <span
							style="color: red; font-weight: bold;" id="messBox">${Message}</span>
					</div>
				</div>
			</form>
			<div class="layui-form-item twoBtnBox">
				<!-- <button class="layui-btn changePhone" type="button">修改绑定</button> -->
				<button class="layui-btn" onclick="submitForm()">提交</button>
			</div>
		</div>

		<%-- <div class="layerSecond">
              <h2 class="pagetitle">绑定手机号修改</h2>
              <form class="layui-form"  action="${ctx}/system/store/bingPhone" method="post" id="codeForm1">
                <div class="centerBox">
                  <div class="layui-form-item">
                    <label class="layui-form-label">旧手机号码：</label>
                    <div class="layui-input-inline">
                      <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">
                    </div>
                  </div>
                   <div class="layui-form-item">
                    <label class="layui-form-label">新手机验证码：</label>
                    <div class="layui-input-inline">
                      <input type="tel" name="yzcode" lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux yzcode">
                      <button class="layui-btn" type="button">获取验证码</button>
                    </div>
                  </div>

                  <div class="layui-form-item twoBtnBox">
                      <button class="layui-btn" lay-submit="" type="button">提交</button>
                  </div>
                </div>
              </form>
            </div> --%>
        </div>
    </body>
    <script type="text/javascript">
    
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
            var phone = $('#phone').val();
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
                        url : '${ctx}/system/store/getCode?phone=' + phone,
                        dataType : "json",
                        success : function(res) {
							if(res.Code == 0){
								var wait = 60;
								setTime(t, wait);
							}else{
								alert(res.Message+",发送失败！");
							}
                        }
                    });
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
        
        function submitForm() {
    		var phone = $("#phone").val();
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
    		if (code == '' || code.length > 6) {
    			layer.open({
    				title : [ '提示' ],
    				content : '验证码错误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		
    		$("#codeForm").submit();
        };
    </script>
</html>