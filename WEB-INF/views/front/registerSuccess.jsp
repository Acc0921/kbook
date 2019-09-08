<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>注册成功</title>
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
            <img src="${ctx}/static/img/qks_logo.jpg" style="width:1rem;"/>
            <div class="font14 tl" style="padding:0.2rem 0.25rem;line-height:25px;">
                <h2 class="tc font18 pdfing">恭喜您成为去K书的会员！</h2>
                <p>注册成功立即赠送您<em class="font24 blue">${consumeValue}</em>点消费点数，可立即去订座体验我们的服务。进一步完善详细资料可再得<em class="font24 blue">${update}</em>点消费点数。</p>
            </div>
            <div class="BoxNew clearfix">
                <a href="${ctx}/front/member" class="checkBtn">去订座</a>
                <a href="${ctx}/system/member/toUpdateMember" class="checkBtn">完善资料</a>
                <c:if test="${empty currentMember.code}">
                	<a href="${ctx}/front/member/getWXCode?type=1" class="checkBtn">领取微信会员卡</a>
                </c:if>
            </div>
        </div>
        
    </body>
</html>
