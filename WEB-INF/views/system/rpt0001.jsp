<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta name="format-detection" content="telephone=no">
    <meta content="telephone=no" name="format-detection">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>满座率统计表</title>
    <%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
	<script src="${ctx}/static/hcharts/highcharts.js"></script>
	<script src="${ctx}/static/js/utility.js"></script>

  	<style type="text/css"> 
  	</style>
  </head>
<body>
<div>
	<div style="high:20px;margin-top:20px;margin-bottom:20px;text-align:center;font-size:1.2em;">满座率统计表</div>
	<form id="reportForm" name="reportForm" action="${ctx}/system/rpt0001" method="get" align="center">
	<select id="period" name="period" class="form-control" style="width:50px">
		<option value="M" <c:if test="${period=='M'}">selected</c:if>>年</option>
		<option value="D" <c:if test="${period=='D'}">selected</c:if>>月</option>
	</select>
	<input id="periodDate" name="periodDate" value="${periodDate}" type="hidden"/>
	<input id="periodOffset" name="periodOffset" value="${periodOffset}" type="hidden"/>
	<select id="city" name="city" class="form-control" style="width:80px">
		<option value="0" >所有城市</option>
		<c:forEach var="city" items="${cityList}">     
		<option value="<c:out value="${city.id}"/>" <c:if test="${cityId==city.id}">selected</c:if>><c:out value="${city.name}"/></option>
		</c:forEach>     
	</select>
	<select id="store" name="store" class="form-control" style="width:80px">
		<option value="0" >所有门店</option>
		<c:forEach var="store" items="${storeList}">     
		<option value="<c:out value="${store.id}"/>" <c:if test="${store.id==storeId}">selected</c:if>><c:out value="${store.name}"/></option>
		</c:forEach>     
	</select>
	<input id="action" name="action" value="" type="hidden"/>
	<button id="go" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px">查</button>
	</div>
    	<c:if test="${rptList.size() < 1}">
			<div class="list-text">
				<h1 align="center">没有记录</h1>
			</div>
		</c:if>
		<c:forEach var="rptData" items="${rptList}">     
			<div >
				<div>
				<table>
					<tr>
						<td width="120"><c:out value="${rptData.id}"/></td>
						<td width="120"><c:out value="${rptData.city.name}"/></td>
						<td width="120"><c:out value="${rptData.store.name}"/></td>
						<td width="120"><fmt:formatDate value="${rptData.date}" type="date"/></td>
						<td width="120"><fmt:formatNumber value="${rptData.percentage}" type="number" pattern="#0个"/></td>
					</tr>
				</table>
				</div>
			</div>
		</c:forEach>

<div id="container" ></div>
<div id="tips" align="center" style="margin-top:50px;letter-spacing:4px;font-size:1.2em;">请选择报表查询条件</div>

	<div align="center">
	<button id="previous" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px">前</button>
 	<button id="back" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px" onClick="javascript:window.location.href='${ctx}/front/manager/userLogin';">返回</button>
	<button id="next" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px">后</button>
	</div>
	
	</form>
  	
	<script type="text/javascript"> 

	function show(bFlag) {
		if ( bFlag ) {
			
		}
	}
	
	$(window).resize(function() {
		$('#container').css('height', $(window).height() - 150);
		$('#tips').css('height', $(window).height() - 200);

	}); 
	
	//页面加载时调用
	$(function() {
			var initOpened = getCookie('initOpened');
			$('#tips').css('height', $(window).height() - 200);
			$('#container').hide();
			if (initOpened == '1'){
			$('#tips').hide();
			$('#container').show();
			$('#container').css('height', $(window).height() - 150);
			init();
			}
			setCookie('initOpened','1',null,'/');

	});
	

	$(document).ready(function(){
		  $("#city").change( function() {
				//var city = $("#city").val();
				$("#action").val("cityChange");
				$("#periodOffset").val("0");
				$("#reportForm").submit();
		  });
		  
		  $("#go").click( function() {
				$("#action").val("showReport");
				$("#periodOffset").val("0");
				//$("#periodDate").val("");
				$("#reportForm").submit();
		  });

		  $("#previous").click( function() {
				$("#action").val("showReport");
				$("#periodOffset").val("-1");
				$("#reportForm").submit();
		  });

		  $("#next").click( function() {
				$("#action").val("showReport");
				$("#periodOffset").val("1");
				$("#reportForm").submit();
		  });

		  
		});

		
	function init(){	
		var mbnum = '${hcSeries}';
		var totalmembers = mbnum.substr(mbnum.lastIndexOf(",")+1);
	    $('#container').highcharts({
	        title: {
	            //text: '满座率统计表',
	            text: '',
	            align: 'center'
	        },
	        subtitle: {
	        	useHTML:true,
	            text: '<p>汇报时期: ${reportDating} </p>',
	            align: 'center'
	            },
	        xAxis: {
	            categories: [${hcCategories}]
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels: {
                    formatter: function() {
                               return this.value.toFixed(2) + '%';
                               },
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: '%',
	            valueDecimals:2
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0,
	            enabled: false
	        },
	        plotOptions: {
	            column: {
	                pointPadding: 0.1,
	                groupPadding: 0.1,
	                pointWidth: 40,
	                borderWidth: 0,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.y}%'
	                }
	            }
	        },
	        series: [{
	            name: '满座率',
	            data: [${hcSeries}]
	        }],
	        credits: {
	            enabled: false
	        },
	        exporting: {
	            enabled: false
	        }
	    });
	}
	</script>
</html>