<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>注册银联会员</title>
    </head>
    <body> 
        <div class="layui-container">
                <div class="layui-form-item twoBtnBox">
                     <button class="layui-btn Merchant" type="button">商户会员</button>
                     <button class="layui-btn Personal" type="button">个人会员</button>
                </div>
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
		//商业会员
		$('.Merchant').click(function(event) {
			$.ajax({
				type : "GET",
				url : '${ctx}/system/store/registerPay?type=2',
				dataType : "json",
				success : function(res) {
					if(res.Code == 0){
						//alert(res.Message);
						//跳转页面
						window.location = '${ctx}/system/store/certification';
					}else{
						layer.open({
							title : [ '错误提示' ],
							content : res.Message,
							shadeClose : false,
							btn : [ '确定' ]
						});
					}
				}
			});
        });
		
		//个人会员
		$('.Personal').click(function(event) {
			$.ajax({
				type : "GET",
				url : '${ctx}/system/store/registerPay?type=3',
				dataType : "json",
				success : function(res) {
					if(res.Code == 0){
						//alert(res.Message);
						//跳转页面
						window.location = '${ctx}/system/store/phoneNum';
					}else{
						layer.open({
							title : [ '错误提示' ],
							content : res.Message,
							shadeClose : false,
							btn : [ '确定' ]
						});
					}
				}
			});
        });
		
    </script>
</html>