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
		<form id="timeForm" action="${ctx}/front/seatOrder/trans" class="form-horizontal" role="form" method="post">
			<h3 align="center">请选择订座信息</h3>
			<br>
			<table border="0">
				<tr>
					<td valign="middle" style="height:50px">
						<h4>订座日期:</h4>
					</td>
					<td valign="middle" align="center">
						<div class="input-group date form_datetime"  data-date-format="yyyy MM dd - HH:ii p" style="width:195px;" >
							<input id="theDate"  class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon">
								 	<span class="glyphicon glyphicon-th"></span>
								 </span>
						</div>
					</td>
				</tr>

				<tr>
					<td valign="top" style="height:50px"> <!--fix tag 20151116 by Gavin: add rowspan;update valign  -->
						<h4>开始时间:</h4>
					</td>
					<td valign="middle" align="center">
						<div id="form_fromtime" class="input-group clockpicker" style="width:195px;">
							<input id="begin" name="fromTime" class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
						</div>
					</td>
				</tr>
				<!--fix tag 20151116 by Gavin: add shortcut ---begin -->
				<tr style="display:none">
					<td><div id="shortcut_starttime"  style="width:195px;">
						<input name="starttime1" type="button" value="现在" style="width:62px;font-size:10px" onClick="clickShortcuttime(this)">
						<input name="starttime2" type="button" value="2分钟后" style="width:62px;font-size:10px" onClick="clickShortcuttime(this)">
						<input name="starttime3" type="button" value="3分钟后" style="width:62px;font-size:10px" onClick="clickShortcuttime(this)">
					</div>
					</td>
				</tr>
				<!--fix tag 20151116 by Gavin: add shortcut ---end -->
				<tr>
					<td  valign="top" style="height:50px">  <!--fix tag 20151116 by Gavin: add rowspan;update valign  -->
						<h4>结束时间:</h4>
					</td>
					<td valign="middle" align="center">
						<div id="form_totime" class="input-group clockpicker" style="width:195px;">
							<input id="end" name="toTime" class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
						</div>
					</td>
				</tr>
				<!--fix tag 20151116 by Gavin: add shortcut ---begin -->
				<tr style="display:none">
					<td><div id="shortcut_endtime"  style="width:195px;">
						<input name="endtime1"  type="button" value="1小时后" style="width:62px;font-size:10px;" onClick="clickShortcuttime(this)">
						<input name="endtime2" type="button" value="2小时后" style="width:62px;font-size:10px" onClick="clickShortcuttime(this)">
						<input name="endtime3" type="button" value="3小时后" style="width:62px;font-size:10px" onClick="clickShortcuttime(this)">
					</div>
					</td>
				</tr>
				<!--fix tag 20151116 by Gavin: add shortcut ---end -->
				<tr>
					<td valign="middle" style="height:50px">
						<h4>选择门店:</h4>
					</td>
					<td align="center">
						<select id="storeId" name="storeId" class="form-control" style="width:195px"></select>
					</td>
				</tr>
			</table>


			<div align="center"  style="display:none;">
				<input id="orderDate" type="text" name="orderDate" value="" style="display:block;"/>
				<input id="setStoreid" type="text" name="setStoreid" value="" style="display:block;"/>
				<input id="productOrder" type="text" name="productOrder" value="" style="display:block;"/>
			</div>
			<div class="container" style="margin-top:15px;margin-bottom:15px;letter-spacing:4px;">
				<a id="sub" >
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">确定</button>
				</a>
			</div>
			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a id="back">
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">返回</button>
				</a> 
			</div>     
		</form>  
	</div>  
</div>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript"> 
    $(function(){
        $.backstretch("${ctx}/static/images/1.jpg");
        var nowTime = new Date();
        var b = 2; //分钟数
        nowTime.setMinutes(nowTime.getMinutes() + b, nowTime.getSeconds(), 0);
        var hour = nowTime.getHours()<10?'0'+nowTime.getHours():nowTime.getHours(); 
        var minutes = nowTime.getMinutes()<10?'0'+nowTime.getMinutes():nowTime.getMinutes();
        var seconds = nowTime.getSeconds()<10?'0'+nowTime.getSeconds():nowTime.getSeconds();
        var currentTime = hour+':'+minutes;
        $("#begin").val(currentTime);
    });
</script>
<script type="text/javascript">
    function GetDateStr(AddDayCount) {
        var dd = getServerDate();
        dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
        var y = dd.getFullYear();
        var m = dd.getMonth()+1;//获取当前月份的日期
        var d = dd.getDate();
        var mStr = "";
        var dStr = "";
        //edit:yangzh by 2018-09-04 start 月份和日期都转换为2位
        if(m.toString().length < 2){
            mStr = "0" + m;
		}else{
            mStr = m;
        }
        if(d.toString().length < 2){
            dStr = "0" + d;
        }else{
            dStr = d;
        }
        //return y+"-"+m+"-"+d;
        console.log(y+"-"+mStr+"-"+dStr);
        return y+"-"+mStr+"-"+dStr;
        //edit:yangzh by 2018-09-04 end 月份和日期都转换为2位
    }
    
    function getServerDate(){
        return new Date($.ajax({async: false}).getResponseHeader("Date"));
    }

    $(document).ready(function(){
        initProductList();
        var productOrderId=$('#productOrder').val();
        //edit:yangzh by 2018-06-13 start
        //获取会员第一个产品
        //var url = "${ctx}/system/productOrder/getProductOrderJson?id="+productOrderId;
        //获取会员有效产品订单最小开始日期和最大截止日期
        var url = "${ctx}/system/productOrder/getProductOrderDate?memberId="+<%=mbr.getId()%>;
        //edit:yangzh by 2018-06-13 end
        var date=$('#theDate').val();
        var efTime;
        var etTime;
        var bol=true;
        $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                //获取客户产品有效时间
                efTime=data.rows.effectiveFromDate;
                etTime=data.rows.effectiveToDate;
                //控件时间
                var startDate=GetDateStr(0);
                //edit:yangzh by 2018-07-04 start
                //var endDate=GetDateStr(30);
                var endDate=GetDateStr(7);	//控制订座日期提前天数
                //edit:yangzh by 2018-07-04 end

                if(efTime>startDate){
                    startDate=efTime;
                    $('.form_datetime').datetimepicker({
                        minView: "month", //选择日期后，不会再跳转去选择时分秒
                        format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
                        language:'zh-CN',
                        weekStart: 1,
                        todayBtn:  0,
                        autoclose: 1,
                        todayHighlight: 1,
                        startView: 2,
                        forceParse: 0,
                        showMeridian: 1,
                    });
                }else{
                    $('.form_datetime').datetimepicker({
                        minView: "month", //选择日期后，不会再跳转去选择时分秒
                        format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
                        language:'zh-CN',
                        weekStart: 1,
                        todayBtn:  1,
                        autoclose: 1,
                        todayHighlight: 1,
                        startView: 2,
                        forceParse: 0,
                        showMeridian: 1,
                    });
                }

                if(etTime<endDate){
                    endDate=etTime;
                }
                
                //设置datetimepicker开始日期 结束日期
                $('.form_datetime').datetimepicker('setStartDate', startDate);
                $('.form_datetime').datetimepicker('setEndDate', endDate);
            }
        });
        $("#back").click(function() {
            //window.history.back();
            window.location.href="${ctx}/front/member/memberMenu";
        });

        initStoreList();


        $("#sub").click(function() {
            check();
        });

    });


    function initStoreList(){
        //add:yangzh by 2018-09-14 start
		var currentStoreId = <%=sessionStoreId%>;
        var storeIdLength = 0;
		if(currentStoreId == null){
            storeIdLength = 0;
		}else{
            storeIdLength = currentStoreId.toString().length;
        }
		//console.log("===========currentStoreId:" + currentStoreId);
		//alert("===========currentStoreId222:" + currentStoreId);
        //alert("===========currentStoreId222currentStoreId.length:" + storeIdLength );
        //add:yangzh by 2018-09-14 end
        var url = "${ctx}/system/store/getStoreByMemberJson";
        url+= "?memberId="+<%=mbr.getId()%>;
        $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                var storeid = "${storeid}";
                for (var i = 0; i < data.rows.length; i++) {
                    //edit:yangzh by 2018-09-14 start
                    //增加判断订座机所在门店ID是否存在，设置订座默认六店
                    //if (storeid == data.rows[i].id) {
                    //    $('#storeId').append("<option selected = 'selected' style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                    //} else {
                    //    $('#storeId').append("<option style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                    //}
                    if(currentStoreId != null && currentStoreId != ""){
                        if(currentStoreId==data.rows[i].id){
                            $('#storeId').append("<option selected = 'selected' style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                        }else{
                            $('#storeId').append("<option style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                        }
                    }else {
                        if (storeid == data.rows[i].id) {
                            $('#storeId').append("<option selected = 'selected' style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                        } else {
                            $('#storeId').append("<option style='font-size:38px;' value=" + data.rows[i].id + ">" + data.rows[i].name + "</option>");
                        }
                    }
                    //edit:yangzh by 2018-09-14 end
                }
            }
        });
    }

    function initProductList(){
        var url = "${ctx}/system/productOrder/getProductJson?memberId="+<%=mbr.getId()%>;
        $.ajax({
            url: url,
            async: false,
            dataType: "json",
            success: function (data) {
                $('#productOrder').val(data.id);
            }
        });
    }

    function check(){
        var now=new Date();
        var date=$('#theDate').val();
        var storeid=$('#storeId').val();
        var productOrderId=$('#productOrder').val();
        var fromTime=$('#begin').val();
        var toTime=$('#end').val();
        var orderDate=date.split(",");
        $('#orderDate').val(orderDate);
        $('#setStoreid').val(storeid);
        $('#setProductOrderId').val(productOrderId);
        //Convert the given from date & time to a Date object.
        var strFromDateTime = date + " " + fromTime;
        strFromDateTime = strFromDateTime.replace(/-/g,"/");
        var fromDateTime = new Date(strFromDateTime);
        //alert(fromDateTime);

        //Convert the given to date & time to a Date object.
        var strToDateTime = date + " " + toTime;
        strToDateTime = strToDateTime.replace(/-/g,"/");
        var toDateTime = new Date(strToDateTime);
        var bValidFlag = true;
        //Validate the input date/fromTime/toTime and etc


        if(date==""){
            alert("日期不能为空");
            bValidFlag = false;
        }else if(fromTime==""){
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
        } else if(fromDateTime<now){
            alert("您选择的开始时间已过,请重新选择");
            bValidFlag = false;
        } else if(fromTime<"08:00"){
            alert("营业时间为 8:00AM - 24:00PM, 请选择营业时间");
            bValidFlag = false;
        }else if(toTime>"24:00"){
            alert("营业时间为 8:00AM - 24:00PM, 请选择营业时间");
            bValidFlag = false;
        }else if(storeid==null||storeid==""){
            alert("您所在的城市没有相关门店");
            bValidFlag = false;
        }
        if (bValidFlag) {
            $("#timeForm").submit();
        }
    }

    $('.clockpicker').clockpicker();

    /*fix tag 20151116 by Gavin: add shortcut ---begin */

    function clickShortcuttime(obj){
        var dd = new Date();
        if(obj.name =="starttime1"){
            var h = dd.getHours();
            var m = dd.getMinutes();
            var setTime = h+":"+m;
            $("#begin").val(setTime);
        }
        if(obj.name =="starttime2"){
            dd.setMinutes(dd.getMinutes()+2);
            var h = dd.getHours();
            var m = dd.getMinutes();
            var setTime = h+":"+m;
            $("#begin").val(setTime);
        }
        if(obj.name =="starttime3"){
            dd.setMinutes(dd.getMinutes()+3);
            var h = dd.getHours();
            var m = dd.getMinutes();
            var setTime = h+":"+m;
            $("#begin").val(setTime);
        }
        if($("#begin").val() != ""){
            if(obj.name =="endtime1"){
                var startHM= $("#begin").val().split(":",2);
                dd.setMinutes(Number(startHM[1]));
                dd.setHours(Number(startHM[0]) + 1);
                var h = dd.getHours();
                var m = dd.getMinutes();
                var setTime = h+":"+m;
                $("#end").val(setTime);
            }
            if(obj.name =="endtime2"){
                var startHM= $("#begin").val().split(":",2);
                dd.setMinutes(Number(startHM[1]));
                dd.setHours(Number(startHM[0]) + 2);
                var h = dd.getHours();
                var m = dd.getMinutes();
                var setTime = h+":"+m;
                $("#end").val(setTime);
            }
            if(obj.name =="endtime3"){
                var startHM= $("#begin").val().split(":",2);
                dd.setMinutes(Number(startHM[1]));
                dd.setHours(Number(startHM[0]) + 3);
                var h = dd.getHours();
                var m = dd.getMinutes();
                var setTime = h+":"+m;
                $("#end").val(setTime);
            }
        }
    }


    /*fix tag 20151116 by Gavin: add shortcut ---end */

</script>
<br/>
</body>
</html>