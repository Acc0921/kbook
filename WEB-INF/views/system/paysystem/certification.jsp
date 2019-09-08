<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
    <head>
   		<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
        <!-- layui js&css -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>企业实名认证</title>
        <script src="${ctx}/static/js/cityjson.js"></script>
    </head>
    <body>
        <div class="layui-container">
            <h2 class="pagetitle">企业实名认证</h2>
            <span style="color: red; font-weight: bold;" id="messBox">${Message}</span>
            <form class="layui-form" action="${ctx}/system/store/setCompanyInfo" method="post" id="certificationForm">
              <div class="layui-form-item">
                <label class="layui-form-label">企业名称：</label>
                <div class="layui-input-block">
                  <input type="text" value="${upd.companyName}" name="companyName" id="companyName" lay-verify="required" autocomplete="off" placeholder="请输入企业名称" class="layui-input">
                </div>
              </div>
             <!--  <div class="layui-form-item">
                <label class="layui-form-label">企业注册地址：</label>
                <div class="layui-input-inline">
                  <input type="text" name="" lay-verify="required" autocomplete="off" placeholder="请输入企业名称" class="layui-input">
                </div>
              </div> -->
              <div class="layui-form-item">
                <label class="layui-form-label">统一社会信用：</label>
                <div class="layui-input-block">
                  <input type="text" value="${upd.uniCredit}" name="uniCredit" id="uniCredit" lay-verify="required" autocomplete="off" placeholder="请输入统一社会信用" class="layui-input">
                </div>
              </div>
              <input type="hidden" value="2" id="authType" name="authType"/>
              <!-- <div class="layui-form-item layui-upload">
                <label class="layui-form-label">营业执照(上传）:</label>
                <div class="layui-input-block">
                  <button type="button" class="layui-btn bgGreen" id="upload01"><i class="layui-icon">&#xe67c;</i>上传图片</button>
                  <div class="layui-upload-list">
                    <img class="layui-upload-img" id="demo01">
                    <p id="demoText01" class="errorText"></p>
                  </div>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">证件到期时间：</label>
                  <div class="layui-input-inline">
                    <input type="tel" name="date" lay-verify="required|date" autocomplete="off" placeholder="请输入证件到期时间" class="layui-input">
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-upload">
                <label class="layui-form-label">开户证明(上传)：</label>
                <div class="layui-input-block">
                  <button type="button" class="layui-btn bgGreen" id="upload02"><i class="layui-icon">&#xe67c;</i>上传图片</button>
                  <div class="layui-upload-list">
                    <img class="layui-upload-img" id="demo02">
                    <p id="demoText02" class="errorText"></p>
                  </div>
                </div>
              </div> -->
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">法人姓名：</label>
                  <div class="layui-input-inline">
                    <input type="text" value="${upd.legalName}" name="legalName" id="legalName" lay-verify="required" autocomplete="off" placeholder="请输入法人姓名" class="layui-input">
                  </div>
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">法人证件类型：</label>
                  <div class="layui-input-block">
                    <select name="identityType" id="identityType" lay-filter="aihao">
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
                <label class="layui-form-label">法人证件号码：</label>
                <div class="layui-input-block">
                  <input type="tel" value="${upd.legalIds}" id="legalIds" name="legalIds" lay-verify="required" autocomplete="off" placeholder="请输入法人证件号码" class="layui-input">
                </div>
              </div>
              <!-- <div class="layui-form-item">
                <div class="layui-inline verticalTop">
                  <label class="layui-form-label">法人身份证（正面）</label>
                  <div class="layui-input-inline">
                    <button type="button" class="layui-btn bgGreen" id="upload03"><i class="layui-icon">&#xe67c;</i>上传图片</button>
                    <div class="layui-upload-list">
                      <img class="layui-upload-img" id="demo03">
                      <p id="demoText03" class="errorText"></p>
                    </div>
                  </div>
                </div>
                <div class="layui-inline">
                  <label class="layui-form-label">法人身份证（反面）</label>
                  <div class="layui-input-inline">
                    <button type="button" class="layui-btn bgGreen" id="upload04"><i class="layui-icon">&#xe67c;</i>上传图片</button>
                    <div class="layui-upload-list">
                      <img class="layui-upload-img" id="demo04">
                      <p id="demoText04" class="errorText"></p>
                    </div>
                  </div>
                </div>
              </div> -->
              <div class="layui-form-item">
                <label class="layui-form-label">企业法人手机号：</label>
                <div class="layui-input-inline">
                  <input type="tel" value="${upd.legalPhone}" id="legalPhone" name="legalPhone" oninput="value=value.replace(/[^\d]/g,'')" lay-verify="required|phone" autocomplete="off" placeholder="请输入企业法人手机号" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">开户帐号:</label>
                <div class="layui-input-block">
                  <input type="tel" value="${upd.accountNo}" name="accountNo" id="accountNo" lay-verify="required" autocomplete="off" placeholder="请输入开户帐号" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">开户行名称：</label>
                  <div class="layui-input-inline">
                    <input type="text" value="${upd.parentBankName}" name="parentBankName" id="parentBankName" lay-verify="title" autocomplete="off" placeholder="开户行名称  如:工商银行" class="layui-input">
                  </div>
                </div>
                <div class="layui-inline">
                  <label class="layui-form-label">支付行号：</label>
                  <div class="layui-input-inline">
                    <input type="text" value="${upd.unionBank}" id="unionBank" name="unionBank" oninput="value=value.replace(/[^\d]/g,'')" lay-verify="title" autocomplete="off" placeholder="请输入开户行代码" class="layui-input">
                  </div>
                </div> 
              </div>
              <div class="layui-form-item">
                <div class="layui-inline">
                  <label class="layui-form-label">开户行所在省:</label>
                  <div class="layui-input-inline">
                    <select name="province" id="province" lay-filter="province">
                      <option value="" selected="selected">请选择省</option>
                    </select>
                  </div>
                </div>
                <div class="layui-inline">
                  <label class="layui-form-label">开户行所在市:</label>
                  <div class="layui-input-inline">
                    <select name="city" id="city">
                      <option value="" selected="selected">请选择市</option>
                    </select>
                  </div>
                </div>
              </div>
             <!--  <div class="layui-form-item">
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
    $(document).ready(function() {
		var options ="";
        $.each(citydata, function (key, value) {
            //根据数据创建option并追加到select上
            var option = "<option value=" + key + ">" + key + "</option>";
            options += option;
        });
        $("#province").append(options);
    });
 
    </script>
    <script>
        layui.use(['form', 'layedit', 'laydate','upload'], function(){
          var $ = layui.jquery
          ,form = layui.form
          ,layer = layui.layer
          ,layedit = layui.layedit
          ,laydate = layui.laydate
          ,upload = layui.upload;

          //日期
          laydate.render({
            elem: '#date01'
          });

          //选择省 change 事件
          form.on('select(province)', function(data){
            	console.log(data.value);
            	var options ="";
	            var province = data.value;
	            //找到市的信息
	            var citys = citydata[province];
	            //删除原来市的信息
	            $("#city").empty();
	            //添加option
	            $.each(citys, function (index, item) {
	            	//根据数据创建option并追加到select上
	                var option = "<option value=" + item + ">" + item + "</option>";
	                options += option;
	            });
	            console.log(options);
	            $("#city").append(options);
	            form.render();
          });
          
          /* //上传
          var uploadInst = upload.render({
            elem: '#upload01'
            ,url: '/upload/'
            ,before: function(obj){
              //预读本地文件示例，不支持ie8
              obj.preview(function(index, file, result){
                $('#demo01').attr('src', result); //图片链接（base64）
              });
            }
            ,done: function(res){
              //如果上传失败
              if(res.code > 0){
                return layer.msg('上传失败');
              }
              //上传成功
            }
            ,error: function(){
              //演示失败状态，并实现重传
              var demoText = $('#demoText01');
              demoText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-xs demo-reload">重试</a>');
              demoText.find('.demo-reload').on('click', function(){
                uploadInst.upload();
              });
            }
          });

          var uploadInst = upload.render({
            elem: '#upload02'
            ,url: '/upload/'
            ,before: function(obj){
              //预读本地文件示例，不支持ie8
              obj.preview(function(index, file, result){
                $('#demo02').attr('src', result); //图片链接（base64）
              });
            }
            ,done: function(res){
              //如果上传失败
              if(res.code > 0){
                return layer.msg('上传失败');
              }
              //上传成功
            }
            ,error: function(){
              //演示失败状态，并实现重传
              var demoText = $('#demoText02');
              demoText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-xs demo-reload">重试</a>');
              demoText.find('.demo-reload').on('click', function(){
                uploadInst.upload();
              });
            }
          });
          var uploadInst = upload.render({
            elem: '#upload03'
            ,url: '/upload/'
            ,before: function(obj){
              //预读本地文件示例，不支持ie8
              obj.preview(function(index, file, result){
                $('#demo03').attr('src', result); //图片链接（base64）
              });
            }
            ,done: function(res){
              //如果上传失败
              if(res.code > 0){
                return layer.msg('上传失败');
              }
              //上传成功
            }
            ,error: function(){
              //演示失败状态，并实现重传
              var demoText = $('#demoText03');
              demoText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-xs demo-reload">重试</a>');
              demoText.find('.demo-reload').on('click', function(){
                uploadInst.upload();
              });
            }
          });
          var uploadInst = upload.render({
            elem: '#upload04'
            ,url: '/upload/'
            ,before: function(obj){
              //预读本地文件示例，不支持ie8
              obj.preview(function(index, file, result){
                $('#demo04').attr('src', result); //图片链接（base64）
              });
            }
            ,done: function(res){
              //如果上传失败
              if(res.code > 0){
                return layer.msg('上传失败');
              }
              //上传成功
            }
            ,error: function(){
              //演示失败状态，并实现重传
              var demoText = $('#demoText04');
              demoText.html('<span style="color: #FF5722;">上传失败</span><a class="layui-btn layui-btn-xs demo-reload">重试</a>');
              demoText.find('.demo-reload').on('click', function(){
                uploadInst.upload();
              });
            }
          });*/
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
        
        function submitForm() {
    		var legalPhone = $("#legalPhone").val();
    		var legalName = $("#legalName").val();
    		var legalIds = $("#legalIds").val();
    		var city = $("#city").val();
    		
    		if (legalPhone == '') {
    			layer_getYz();
    			return;
    		}
    		//校验手机号
    		if (!(/^1[34578]\d{9}$/.test(legalPhone))) {
    			layer.open({
    				title : [ '提示' ],
    				content : '请输入正确的手机号码！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		//校验姓名 
    		if(!(/^[\u4e00-\u9fa5]{2,4}$/.test(legalName))){  
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
    		if(!(/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(legalIds))){   
    		    layer.open({
    				title : [ '提示' ],
    				content : '身份证号填写有误！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return; 
    		}  
    		
    		if (city == '' || city == null) {
    			layer.open({
    				title : [ '提示' ],
    				content : '请选择开户所在省市！',
    				shadeClose : false,
    				btn : [ '确定' ]
    			});
    			return;
    		}
    		
    		$("#certificationForm").submit();
        };
    </script>
</html>