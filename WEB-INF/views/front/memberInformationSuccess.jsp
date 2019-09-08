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
    <title>修改成功</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/public.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/need/layer.css" />
    <link rel="stylesheet" href="${ctx}/static/css/pcstyle.css"  media="handheld and (max-width:480px), screen and (min-width:500px)"/>
    <script type="text/javascript" src="${ctx}/static/js/layer.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/reservation.js"></script>
    </head>
    <header>注册成功</header>
    <body>
        <div class="imgBox orderSec" style="margin-top:15%;">
            <img src="${ctx}/static/img/logo.png" style="width:1rem;"/>
            <div class="font18 tc" style="padding:0.2rem;line-height:25px;">
                <h2 class="pdfing">资料修改成功！</h2>
                <p class="font14">非常感谢您的支持，赠送您<em class="font24 blue">${update}</em>点消费点数</p>
            </div>
            <div class="BoxNew tc clearfix">
                <a href="${ctx}/front/member" class="checkBtn">返回菜单</a>
            </div>
        </div>
        
    </body>
</html>
