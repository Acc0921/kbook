<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>提现结果</title>
    </head>
    <body> 
        <div class="layui-container">
                <div class="layui-form-item twoBtnBox">
                    ${Message }
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
    </script>
</html>