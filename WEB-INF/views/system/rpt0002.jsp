<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<html>
<head>
 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta name="format-detection" content="telephone=no">
    <meta content="telephone=no" name="format-detection">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>实时满座率</title>
     <%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
	<script src="${ctx}/static/hcharts/highcharts.js"></script>
	<script src="${ctx}/static/js/utility.js"></script>
		<style type="text/css">
${demo.css}
		</style>
		<script type="text/javascript">

		
		</script>

  	<style type="text/css">
  	</style>
<title>实时满座率</title>
</head>
<body>
	<div style="high:20px;margin-top:20px;margin-bottom:20px;text-align:center;font-size:1.2em;">实时满座率</div>

<div>
	<form id="reportForm" name="reportForm" action="${ctx}/system/rpt0002" method="get" align="center">
	<select id="city" name="city" class="form-control" style="width:80px">
		<option value="0" >城市</option>
		<c:forEach var="city" items="${cityList}">     
		<option value="<c:out value="${city.id}"/>" <c:if test="${cityId==city.id}">selected</c:if>><c:out value="${city.name}"/></option>
		</c:forEach>     
	</select>
	<select id="store" name="store" class="form-control" style="width:80px">
		<option value="0" >门店</option>
		<c:forEach var="store" items="${storeList}">     
		<option value="<c:out value="${store.id}"/>" <c:if test="${store.id==storeId}">selected</c:if>><c:out value="${store.name}"/></option>
		</c:forEach>     
	</select>
	<input id="action" name="action" value="" type="hidden"/>
	<button id="go" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px">查</button>
	
	</div>
		
 	<div id="container" ></div>
 	<div id="tips" align="center" style="margin-top:50px;letter-spacing:4px;font-size:1.2em;">请选择报表查询条件</div>
 	<div align="center">
 	<button id="back" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px" onClick="javascript:window.location.href='${ctx}/front/manager/userLogin';">返回</button>
	</div>
 	</form>
 	
<script>
	var flag = false;
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
	var flag = getCookie('flag');//选择报表查询条件时，不初始化图表（保持无数据显示）
	var initOpened = getCookie('initOpened');
	$('#tips').css('height', $(window).height() - 200);
	$('#container').hide();
	if (initOpened == '1'){
	$('#tips').hide();
	$('#container').show();
	$('#container').css('height', $(window).height() - 150);
	if(flag == '1')//页面加载时，不初始化报表
	init();
	}
	setCookie('initOpened','1',null,'/');
});

$(document).ready(function(){
	  $("#city").change( function() {
			$("#action").val("cityChange");
		//	$("#store").val("0"); 
			$("#reportForm").submit();			
	  });	 
	
	   $("#go").click( function() {
			$("#action").val("showReport");
			$("#reportForm").submit();
			//查询时，初始化报表
			setCookie('flag','1',null,'/');
	  });

	  
	});
	
function init() {
var colors = Highcharts.getOptions().colors,

//categories = ['${aa}', '普通', 'VIP', '高级VIP'],
 categories = ${array},

//data = [${result},${typeResult1},${typeResult2},${typeResult3}];
 data = ${dat};

function setChart(name, categories, data, color) {
		chart.xAxis[0].setCategories(categories, false);
		chart.series[0].remove(false);
		chart.addSeries({
		name: name,
		data: data,
		color: color || 'white'
		}, false);
		chart.redraw();
		}
		
		var chart = $('#container').highcharts({
		chart: {
		    type: 'column'
		},
		title: {
		    text:null
		},
		subtitle: {
		    text:null
		},
		xAxis: {
		    categories: categories
		},
		yAxis: {
		    title: {
		        text:null
		    },
		labels: {
		    formatter: function() {
		               return this.value.toFixed(2) + '%';
		               },
		}
		},
		plotOptions: {
		    column: {
		        cursor: 'pointer',
		        colorByPoint:true,//设置主题颜色自动变化
		   
		        dataLabels: {
		            enabled: true,
		            color: colors[1],//柱顶百分比颜色
		            style: {
		                fontWeight: ''
		            },
		            formatter: function() {
		                return this.y +'%';
		            }
		        }
		    }
		},
		tooltip: {
		    valueSuffix: '%',
		    valueDecimals:2,
		    formatter: function() {
		        var point = this.point,
		            s = this.x +':<b>'+ this.y +'%满座率</b><br/>';
		        return s;
		    }
		},
		legend: {
		    layout: 'vertical',
		    align: 'right',
		    verticalAlign: 'middle',
		    borderWidth: 0,
		    enabled: false
		},
		series: [{
		    name: name,
		    data: data,
		   // colors: '#ff0000'//设置柱体颜色
		}],
		credits: {
		    enabled:false
		},  //隐藏 highchart.com
		legend:{
			enabled:false
		},  //隐藏图例title
		exporting: {
		    enabled: false
		}   //隐藏导出按钮
		
		})
		.highcharts(); // return chart
		}			
</script>
</body>
</html>