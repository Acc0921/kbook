<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>

<%
    Object sessionValues=session.getAttribute(Constants.CURRENT_MEMBER);
    Member mbr = (Member)sessionValues;
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="HandheldFriendly" content="true"/>
    <meta name="MobileOptimized" content="320"/>
    <title>我的资料</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/public.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/need/layer.css" />
    <link rel="stylesheet" href="${ctx}/static/css/pcstyle.css"  media="handheld and (max-width:480px), screen and (min-width:500px)"/>
    <script type="text/javascript" src="${ctx}/static/js/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/reservation.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.9.1.min.js"></script>
    </head>
    <header>填写资料</header>
    <body>
        <form class="loginBox"  action="${ctx}/front/member/updateMember" method="post" id="memberForm">
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p>姓名：</p>
                <input type="text" placeholder="请输入姓名" maxlength="30" name="name" id="name" />
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p>性别：</p>
                <div class="inputR">
                    <span><input type="radio" class="wap_radio" name="sex" id="man" value="1"/><label for="man">男</label></span>
                    <span><input type="radio" class="wap_radio" name="sex" id="woman" value="0" /><label for="woman">女</label></span>
                </div>
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p>职业：</p>
                <div class="inputR">
                    <select name="career" id="profession">
                        <option value ="1">自由</option>
                        <option value ="2" selected="selected">学生</option>
                        <option value ="3">在职</option>
                    </select>
                </div>
            </div>
             <div class="inputBox inputBoxNew inputBoxNew02" id="nianji">
                <p>年级：</p>
                <div class="inputR">
                    <select name="grade" id="grade">
                        <option value ="小一">小一</option>
                        <option value ="小二">小二</option>
                        <option value ="小三">小三</option>
                        <option value ="小四">小四</option>
                        <option value ="小五">小五</option>
                        <option value ="小六">小六</option>
                        <option value ="初一">初一</option>
                        <option value ="初二">初二</option>
                        <option value ="初三">初三</option>
                        <option value ="高一">高一</option>
                        <option value ="高二">高二</option>
                        <option value ="高三">高三</option>
                        <option value ="大一">大一</option>
                        <option value ="大二">大二</option>
                        <option value ="大三">大三</option>
                        <option value ="大四">大四</option>
                        <option value ="研一">研一</option>
                        <option value ="研二">研二</option>
                        <option value ="研三">研三</option>
                        <option value ="研四">研四</option>
                        <option value ="研五">研五</option>
                        <option value ="博士">博士</option>
                        <option value ="博士后">博士后</option>
                    </select>
                </div>
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p>目标：</p>
                <div class="inputR">
                    <select name="target" id="target">
                        <option value ="法考">法考</option>
                        <option value ="CPA">CPA</option>
                        <option value ="考研">考研</option>
                        <option value ="雅思">雅思</option>
                        <option value ="托福">托福</option>
                        <option value ="中考">中考</option>
                        <option value ="高考">高考</option>
                        <option value ="自我提升">自我提升</option>
                        <option value ="其他">其他</option>
                    </select>
                </div>
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02" id="targetDiv" style="display: none;">
                <p>目标：</p> 
                <input type="text" placeholder="请输入你的目标" maxlength="30" name="target1" id="target1" />
            </div>
            <div class="inputBox inputBoxNew inputBoxNew02">
                <p>来源：</p>
                <div class="inputR">
                    <select name="channel" id="source">
                        <option value="网站" >网站</option>
                        <option value="微信公众号">微信公众号</option>
                        <option value="朋友推荐">朋友推荐</option>
                        <option value="自己看见">自己看见</option>
                        <option value="百度">百度</option>
                        <option value="知乎">知乎</option>
                        <option value="美团大众点评">美团大众点评</option>
                        <option value="微信朋友圈">微信朋友圈</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>
           <!--  <div class="inputBox inputBoxNew inputBoxNew02">
                <p style="width:24%;">期望门店：</p>
                <div class="inputR selectTwo">
                	<select name="cityId" id="storeCity">
                    <select name="cityId" id="storeCity" onchange="test(this)">
                        <option value ="city">城市</option>
                    </select>
                    <select name="storeId" id="storeName">
                        <option value ="store">门店名称</option>
                    </select>
                </div>
            </div> -->
            <div class="fixBtnBox fixBtnBoxTwo">
                <button type="button" class="checkBtn" id="submitForm">提交</button>
                <button type="button" class="checkBtn" id="cancleBtn">取消</button>
            </div>
        </form>
    </body>

    <script type="text/javascript">
       /*  $(function () {
           //动态拼接城市和门店名称
            $.ajax({
                type: "GET",
                url:"${ctx}/system/city/getAllJson",
                dataType:"json",
                success: function(json) {
                    //$("#storeCity").empty();
                    //alert("验证码是:"+json.rows);
                    var op = "";
                    for (var i=0;i<json.rows.length;i++){
                        var cityName = json.rows[i].name;
                        //alert("城市名称:"+cityName+"---"+cityid);
                        //根据城市id获取门店名称
                        var cityid = json.rows[i].id;

                        op += '<option value ="'+cityid+'">'+cityName+'</option>';
                    }
                    $("#storeCity").append(op);
                }
            });

            $("#storeCity").change(function(){
                //$("#storeCity").empty().append('<option value ="+cityName+">'+cityName+'</option>');
                var cityid = $("#storeCity").val();
                //alert("城市id:"+cityid);
                $.ajax({
                    type: "GET",
                    url:"${ctx}/system/store/getStoreByCityId?cityId="+cityid,
                    dataType:"json",
                    success: function(data) {
                        var options = '<option value ="store">门店名称</option>';
                        for (var j=0;j<data.rows.length;j++){
                            var storeName = data.rows[j].name;
                            var storeid = data.rows[j].id;
                            //alert("门店名称："+storeName);
                            options += '<option value ="'+storeid+'">'+storeName+'</option>';
                            //$("#storeName").empty().append('<option value ="+storeName+">'+storeName+'</option>');
                        }
                        $("#storeName").empty().append(options);
                    }
                });
            });

        }); */
        
        
        $(function () {
             $("#profession").change(function(){
                 //$("#storeCity").empty().append('<option value ="+cityName+">'+cityName+'</option>');
                 var cityid = $("#profession").val();
                 if(cityid == 2 || cityid == '2'){
                	 document.getElementById("nianji").style.display="";//显示
                 }else{
                	 document.getElementById("nianji").style.display="none";//隐藏
                 }
             });
             $("#target").change(function(){
                 //$("#storeCity").empty().append('<option value ="+cityName+">'+cityName+'</option>');
                 var text = $("#target").val();
                 if(text == '其他'){
                	 document.getElementById("targetDiv").style.display="";//显示
                 }else{
                	 document.getElementById("targetDiv").style.display="none";//隐藏
                 }
             });
         });
        
    $("#submitForm").click(function () {
        //校验是否都填了值

        var flag = true;
        if($("#name").val() == '') {
            layer.open({
                title:['提示']
                ,content: '姓名不能为空'
                ,shadeClose:false
                ,btn: ['确定']
            });
            flag = false;
        }
        
        var val=$('input:radio[name="sex"]:checked').val();
        if(val == null){
        	layer.open({
                title:['提示']
                ,content: '请选择姓别'
                ,shadeClose:false
                ,btn: ['确定']
            });
            flag = false;
        }

/*         var cs = 1;
        if ($("#storeCity").val() == 'city' || $("#storeCity").val() == 'undefined' || $("#storeCity").val() == null) {
        	if(cs == 1){
        		layer.open({
                    title:['提示']
                    ,content: '请选择城市'
                    ,shadeClose:false
                    ,btn: ['确定']
                });
                flag = false;
                cs == 0;
        	}
        } */

/*         if ($("#target").val() == '' || $("#target").val() == null) {
    		layer.open({
                title:['提示']
                ,content: '请输入你的目标'
                ,shadeClose:false
                ,btn: ['确定']
            });
            flag = false;
        } */
        
        var text = $("#target").val();
        if(text == '其他'){
        	var text1 = $("#target1").val();
        	if(text1 == '' || text1 == null){
        		layer.open({
                    title:['提示']
                    ,content: '请输入你的目标'
                    ,shadeClose:false
                    ,btn: ['确定']
                });
                flag = false;
        	}
        }
        
       /*  if ($("#storeName").val() == 'store' || $("#storeName").val() == null) {
        		layer.open({
                    title:['提示']
                    ,content: '请选择门店'
                    ,shadeClose:false
                    ,btn: ['确定']
                });
                flag = false;
        } */

        if (flag) {
            $("#memberForm").submit();
        }

    });

    //点击取消按钮操作
    $("#cancleBtn").click(function(){
        window.location.href = "${ctx}/front/member";
    });
    </script>
</html>
