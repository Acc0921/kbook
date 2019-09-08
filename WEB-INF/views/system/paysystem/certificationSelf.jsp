<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
    	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>个人实名认证</title>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">个人实名认证</h2>
            <span style="color: red; font-weight: bold;" id="messBox">${Message}</span>
            <form class="layui-form" action="${ctx}/system/store/setRealName" method="post" id="certifiForm">
              <div class="layui-form-item">
                <label class="layui-form-label">姓名：</label>
                <div class="layui-input-block">
                  <input type="text" name="nickName" id="nickName" placeholder="请输入姓名" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">证件类型：</label>
                  <div class="layui-input-block">
                    <select name="type" lay-filter="aihao" id="type">
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
                  <input type="tel" name="cardId" id="cardId" placeholder="请输入证件号码" class="layui-input">
                </div>
              </div>
              <!-- <div class="layui-form-item">
                <label class="layui-form-label">认证状态：</label>
                <div class="layui-input-block">
                  <h2 class="textIpt">已认证/未认证/认证中</h2>
                </div>
              </div> -->
			  </form>
              <div class="layui-form-item">
                <label class="layui-form-label"></label>
                <div class="layui-input-inline">
                  <button class="layui-btn" onclick="submitForm()">提交认证</button>
                </div>
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
    		var nickName = $("#nickName").val();
    		var cardId = $("#cardId").val();
    		//校验姓名 
    		if(!(/^[\u4e00-\u9fa5]{2,4}$/.test(nickName))){  
    			layer.open({
    				title : [ '提示' ],
    				content : '真实姓名填写有误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		} 
    		//校验身份证信息
    		var regIdNo = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;  
    		if(!(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(cardId))){   
    		    layer.open({
    				title : [ '提示' ],
    				content : '身份证号填写有误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return; 
    		}  
    		
    		$("#certifiForm").submit();
        };
        
    </script>
</html>