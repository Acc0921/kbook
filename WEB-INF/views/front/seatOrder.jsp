<%
	//Amendment by Gavin
//Amendment Date: 20151116
//Fix Tag: 20151116
//Desc:
// 	在一体机上选择时间较为麻烦且困难，所以建议增加按钮的形式选择开始、结束时间：
//	开始时间：马上、2分钟后、5分钟后
//	结束时间：1小时、2小时、3小时
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>

<%
	Object sessionValues=session.getAttribute(Constants.CURRENT_MEMBER);
	//add:yangzh by 2018-09-14 start 获取门店订座机所在门店ID
	Object sessionStoreId=session.getAttribute(Constants.CURRENT_STORE_ID);
	System.out.println("=========sessionStoreId:" + sessionStoreId);
	//add:yangzh by 2018-09-14 end 获取门店订座机所在门店ID
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
	<title>订座</title>
	<%@ include file="/WEB-INF/views/include/context.jsp"%>
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >
	<link href="${ctx}/static/clockpicker/bootstrap-clockpicker.min.css" rel="stylesheet"  type="text/css" >

	<script src="${ctx}/static/bootstrap3.0/js/bootstrap.min.js"></script>
	<script src="${ctx}/static/bootstrap3.0/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script src="${ctx}/static/bootstrap3.0/js/bootstrap-responsive-nav.min.js"></script>
	<script src="${ctx}/static/bootstrap3.0/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
	<script src="${ctx}/static/clockpicker/bootstrap-clockpicker.min.js" charset="UTF-8"></script>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		a:link{
			text-decoration:none;
		}
		a:visited{
			text-decoration:none;
		}
		a:hover{
			text-decoration:none;
		}
		a:active{
			text-decoration:none;
		}
	</style>
</head>
<body>
<br/>
<div class="container" align="center" style="margin-top:20px; " >
	<div class="well center-block" style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
		<form id="seatForm" action="${ctx}/front/seatOrder/conf" class="form-horizontal" role="form" method="post" align="center">
			<h3 align="center">请选择订座信息</h3>
			<div class="container" style="margin-top: 15px; margin-bottom: 15px; letter-spacing: 4px;float: left;">
				<h4>可订座时间如下:</h4>
				<c:forEach var="time" items="${bookableMap}" varStatus="b">
								<font style="color: red;font-size: 18px;"><fmt:formatDate value="${time.startTime}" pattern="HH:mm"/>---<fmt:formatDate value="${time.endTime}" pattern="HH:mm"/></font>
				</c:forEach>
			</div>
			<table border="0" style="margin-left: 45px;">
				<tr>
					<td valign="top" style="height:50px"> <!--fix tag 20151116 by Gavin: add rowspan;update valign  -->
						<h4>预订签到时间:</h4>
					</td>
					<td valign="middle" align="center">
						<div id="form_fromtime" class="input-group clockpicker" style="width:195px;">
							<input id="begin" name="fromTime" class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
						</div>
					</td>
				</tr>
				<tr>
					<td  valign="top" style="height:50px">  <!--fix tag 20151116 by Gavin: add rowspan;update valign  -->
						<h4>预订签退时间:</h4>
					</td>
					<td valign="middle" align="center">
						<div id="form_totime" class="input-group clockpicker" style="width:195px;">
							<input id="end" name="toTime" class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
						</div>
					</td>
				</tr>
			</table>
			<div class="container"
				style="margin-top: 15px; margin-bottom: 15px; letter-spacing: 4px;">
				<a id="sub">
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">确定</button>
				</a>
			</div>
			<div class="container"
				style="margin-bottom: 15px; letter-spacing: 4px;">
				<a id="back">
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">返回</button>
				</a>
			</div>
			<br><br>
			<table align="center" style="display:none">
				<tr>
					<td>
						<input id="orderDate" type="text" name="orderDate" value="${orderDate}" style="display:block;"/>
					</td>
					<td>
						<input id="seatid" type="text" name="seatid" value="${seatid}" style="display:block;"/>
					</td>
					<td>
						<input id="storeid" type="text" name="storeid" value="${storeid}" style="display:block;"/>
					</td>
					<td>
						<input id="productId" type="text" name="productId" value="${productId}" style="display:block;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript">
    $(function(){
        $.backstretch("${ctx}/static/images/1.jpg");
/*         var nowTime = new Date();
        var b = 2; //分钟数
        nowTime.setMinutes(nowTime.getMinutes() + b, nowTime.getSeconds(), 0);
        var hour = nowTime.getHours()<10?'0'+nowTime.getHours():nowTime.getHours();
        var minutes = nowTime.getMinutes()<10?'0'+nowTime.getMinutes():nowTime.getMinutes();
        var seconds = nowTime.getSeconds()<10?'0'+nowTime.getSeconds():nowTime.getSeconds();
        var currentTime = hour+':'+minutes;
        $("#begin").val(currentTime); */
    });
</script>
<script type="text/javascript">

    $(document).ready(function(){
    	console.log("${bookableMap}");
        var productOrderId=$('#productOrder').val();

        $("#back").click(function() {
            window.history.back();
            //window.location.href="${ctx}/front/seatOrder/seatTimeCondition";
        });

        $("#sub").click(function() {
            check();
        });

    });


    function check(){
    	var now=new Date();
        var fromTime=$('#begin').val();
        var toTime=$('#end').val();

        var date = "${orderDate}";
        var strFromDateTime = date + " " + fromTime;
        strFromDateTime = strFromDateTime.replace(/-/g,"/");
        var fromDateTime = new Date(strFromDateTime);
        
        var strToDateTime = date + " " + toTime;
        strToDateTime = strToDateTime.replace(/-/g,"/");
        var toDateTime = new Date(strToDateTime);
        var bValidFlag = true;
        
        if(fromTime==""){
            alert("开始时间不能为空");
            bValidFlag = false;
        }else if(toTime==""){
            alert("结束时间不能为空");
            bValidFlag = false;
        } else if (fromDateTime>toDateTime){
            alert("开始时间不能大于结束时间");
            bValidFlag = false;
        } else if ( toDateTime - fromDateTime < 3600000) {
            alert("开始时间与结束时间至少相隔一个小时");
            bValidFlag = false;
        }else if(fromDateTime < now){
            alert("您选择的开始时间已过,请重新选择");
            bValidFlag = false;
        }
        
        if (bValidFlag) {
            $("#seatForm").submit();
        }
    }

    $('.clockpicker').clockpicker();

</script>
<br/>
</body>
</html>