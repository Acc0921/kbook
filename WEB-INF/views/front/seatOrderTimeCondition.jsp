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
	<title>高级订座</title>
	<%@ include file="/WEB-INF/views/include/context.jsp"%>
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >
	<link href="${ctx}/static/clockpicker/bootstrap-clockpicker.min.css" rel="stylesheet"  type="text/css" >

	<script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=f83a930fe95691d00cbe407ff941a810&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script>
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
		<form id="timeForm" action="${ctx}/front/seatOrder/transCondition" class="form-horizontal" role="form" method="post">
			<h3 align="center">请选择订座信息</h3>
			<br>
			<table border="0">
				<!--fix tag 20151116 by Gavin: add shortcut ---end -->
				<tr>
					<td valign="middle" style="height:50px">
						<h4>选择门店:</h4> 
					</td>
					<td align="center">
						<select id="storeId" name="storeId" class="form-control" style="width:195px"></select>
					</td>
				</tr>
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
					<td valign="middle" style="height:50px">
						<h4>时段:</h4>
											</td>
					<td valign="middle" align="left">
						<div class="btn-group" data-toggle="buttons">
						    <label class="btn btn-info" style="width: 60px;">
						        <input type="checkbox" name="timeSlot" id="morning" value="0">上午
						    </label>
						    <label class="btn btn-info" style="width: 80px;">
						        <input type="checkbox" name="timeSlot" id="afternoon" value="1">下午
						    </label>
						    <label class="btn btn-info" style="width: 60px;">
						        <input type="checkbox" name="timeSlot" id="night" value="2">晚上
						    </label>
						</div>
					</td>
				</tr>
				<tr>
					<td valign="middle" style="height:50px">
						<h4>时长:</h4>
					</td>
					<td valign="middle" align="left">
						<div class="btn-group" data-toggle="buttons">
						    <label class="btn btn-info active" style="width: 60px;">
						        <input type="radio" name="options" id="option1" value="0" checked>2小时
						    </label>
						    <label class="btn btn-info" style="width: 80px;"> 
						        <input type="radio" name="options" id="option2" value="1">2至4小时
						    </label> 
						    <label class="btn btn-info" style="width: 60px;">
						        <input type="radio" name="options" id="option3" value="2">4小时
						    </label>
						    
						</div>
					</td>
				</tr>
			</table>


			<div align="center"  style="display:none;">
				<input id="orderDate" type="text" name="orderDate" value="" style="display:block;"/>
				<input id="setStoreid" type="text" name="setStoreid" value="" style="display:block;"/>
				<input id="productOrder" type="text" name="productOrder" value="" style="display:block;"/>
			</div>
			<div class="container" style="margin-top:15px;margin-bottom:15px;letter-spacing:4px;">
				<a id="sub"> 
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
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript"> 
	$(function(){
	    $.backstretch("${ctx}/static/images/1.jpg");
	});
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
        return y+"-"+mStr+"-"+dStr;
        //edit:yangzh by 2018-09-04 end 月份和日期都转换为2位
    }
/*     var lng = 0;
	var lat = 0; */

    function getServerDate(){
        return new Date($.ajax({async: false}).getResponseHeader("Date"));
    }
	
    var lng = 0;
	var lat = 0;
    //$(document).ready(function(){
     	$(window).load(function(){
    		console.log('${appId}');
      		console.log('${timestamp}');
      		console.log('${nonceStr}');
      		console.log('${signature}');
	
  			var isWechat = (function(){
      			return navigator.userAgent.toLowerCase().indexOf('micromessenger') !== -1
      		})();
	
      		//是否微信端  微信端采用定位获取位置距离 不是微信不采用位置距离
    		if(isWechat){
        		 wx.config({
            	     debug: false,
            	     appId: '${appId}',
            	     timestamp: '${timestamp}',
            	     nonceStr: '${nonceStr}',
            	     signature: '${signature}',
            	     jsApiList: ['getLocation']
            	 });
            	 wx.ready(function () {
            	    wx.checkJsApi({
            	        jsApiList: [
            	            'getLocation'
            	        ],
            	        success: function (res) {
            	            // alert(JSON.stringify(res));
            	            // alert(JSON.stringify(res.checkResult.getLocation));
            	            if (res.checkResult.getLocation == false) {
            	                alert('你的微信版本太低，不支持微信JS接口，请升级到最新的微信版本！');
            	                return;
            	            }
            	        }
            	    }); 
            	    wx.error(function(res){
            	        //alert("接口调取失败");
                      	//加载门店
                      	initStoreList();
            	    });
            	    wx.getLocation({
            	      success: function (res) {
            	        lng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
            	        lat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
            	      	//转换微信gps位置坐标
                        Conversion(lng,lat);
                        //加载门店
                        initStoreList();
            	      }, 
            	      cancel: function (res) {
            	        //alert('用户拒绝授权获取地理位置');
                      	//加载门店
                      	initStoreList();
            	      }
            	    });
            	});
	        }else {
	        	//加载门店
              	initStoreList();
	        }

        	//alert('微信获取经度:'+lng+'---微信获取纬度:'+lat);
            initProductList();
            var productOrderId = $('#productOrder').val();
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
            	//加载前 先清空旧记录
            	$('#storeId').empty();
                var storeid = "${storeid}";
                //排序
                var storeList = data.rows;
                var ret = storeList.sort(sortStore);
                var arr = JSON.stringify(ret);
                localStorage.setItem("seatStore",arr);
                console.log(ret);
                for (var i = 0; i < ret.length; i++) {
                    //edit:yangzh by 2018-09-14 start
                    if(currentStoreId != null && currentStoreId != ""){
                        if(currentStoreId == ret[i].id){
                            $('#storeId').append("<option selected = 'selected' style='font-size:38px;' value=" + ret[i].id + ">" + ret[i].name + showMi(ret[i].distance)  +  "</option>");
                        }else{
                            $('#storeId').append("<option style='font-size:38px;' value=" + ret[i].id + ">" + ret[i].name   + showMi(ret[i].distance) +  "</option>");
                        }
                    }else {

                        if (storeid == ret[i].id) {
                            $('#storeId').append("<option selected = 'selected' style='font-size:38px;' value=" + ret[i].id + ">" + ret[i].name  +  showMi(ret[i].distance) +  "</option>");
                        } else {
                            $('#storeId').append("<option style='font-size:38px;' value=" + ret[i].id + ">" + ret[i].name + showMi(ret[i].distance)  + "</option>");
                        }
                    }
                    //edit:yangzh by 2018-09-14 end
                } 
            }
        });
    }
    
    //排序
    function sortStore(storeA, storeB) {
    	//门店地理位置为空时
    	if(lng == 0 || lat == 0){
    		storeA.distance = 0;
    		storeB.distance = 0;
    		return null;
    	} 	
    	if(storeA.lng != null){
    		storeA.distance = getDistance(storeA.lng,storeA.lat);
    	}else if(storeB.lng != null){
    		storeB.distance = getDistance(storeB.lng,storeB.lat);
    	}

        return storeA.distance - storeB.distance;
    }

    //获取可用产品
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
	
    //微信gps坐标转换
    function Conversion(lng1,lat1){
    	var url = 'http://restapi.amap.com/v3/assistant/coordinate/convert?locations='+ lng1 + ',' + lat1 +'&coordsys=gps&output=json&key=f7bb0bc101d8ea81fbc66fb74e30ea04';
    	//console.log(url);
    	$.ajax({
			url : url,
			async : false,
			dataType : "json",
			success : function(data) {
				//console.log(data);
				//用户微信gps位置 转换为高德地图坐标
				lng = data.locations.split(",")[0];
				lat = data.locations.split(",")[1];
			}
		});
    }
    
    
    //计算距离-米
	function getDistance(storeLng, storeLat) {
		//计算距离
		var p1 = [ lng, lat ];
		var p2 = [ storeLng, storeLat ];
		dis = AMap.GeometryUtil.distance(p1, p2); 
		var result = parseInt(dis);
		return result;
	}

    //计算距离-米或千米
	function showMi(result) {
		//alert('高德地图经度:' + lat + '---高德地图纬度:' + lng);
		//没有地理位置
		if(result == 0 || result == undefined){
			return '';
		}
		//计算米跟千米
		if (result < 1000) {
			result = result + "米";
			result = '('+result+')';
		} else if (result > 1000) {
			result = (result / 1000).toFixed(1) + "千米";
			result = '('+result+')';
		}
		return result;
	}

	function check() {
		var now = new Date();
		var date = $('#theDate').val();
		var storeid = $('#storeId').val();
		var productOrderId = $('#productOrder').val();
		var orderDate = date.split(",");
		$('#orderDate').val(orderDate);
		$('#setStoreid').val(storeid);
		$('#setProductOrderId').val(productOrderId);

		var bValidFlag = true;
		//Validate the input date/fromTime/toTime and etc
		if (date == "") {
			alert("日期不能为空");
			bValidFlag = false;
		} else if ($("#morning").is(':checked') == false && $("#afternoon").is(':checked') == false && $("#night").is(':checked') == false) {
			alert('请选择时间段！');
			bValidFlag = false;
		} else if ($("#morning").is(':checked') == true) {
			if ($("#afternoon").is(':checked') == false) {
				if ($("#night").is(':checked') == true) {
					alert('请选择连续的时间段！');
					bValidFlag = false;
				}
			}
		} else if (storeid == null || storeid == "") {
			alert("您所在的城市没有相关门店");
			bValidFlag = false;
		}
		if (bValidFlag) {
			$("#timeForm").submit();
		}
	}
</script>
<br/>
</body>
</html>