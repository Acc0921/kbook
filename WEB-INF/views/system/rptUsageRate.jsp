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
   	<%@ include file="/WEB-INF/views/include/context.jsp"%>
	<script src="${ctx}/static/hcharts/highcharts.js"></script>
	<script src="${ctx}/static/hcharts/modules/exporting.js"></script>
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
<div>
	<form id="reportForm" name="reportForm" action="${ctx}/system/seatStatus/getSeatUsageRate" method="get" align="center">
	<select id="city" name="city" class="form-control" style="width:80px">
		<c:forEach var="city" items="${cityList}">     
		<option value="<c:out value="${city.id}"/>" <c:if test="${cityId==city.id}">selected</c:if>><c:out value="${city.name}"/></option>
		</c:forEach>     
	</select>
	<select id="store" name="store" class="form-control" style="width:80px">
		<c:forEach var="store" items="${storeList}">     
		<option value="<c:out value="${store.id}"/>" <c:if test="${store.id==storeId}">selected</c:if>><c:out value="${store.name}"/></option>
		</c:forEach>     
	</select>
	<input id="action" name="action" value="" type="hidden"/>
	<button id="go" type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" style="width:60px">查</button>
	
	</div>
		
 	<div id="container" style="min-width:310px;height:400px margin: 0 auto"></div>
 	</form>
 	
<script>
$('#container').height($(window).height()*0.9);
function show(bFlag) {
	if ( bFlag ) {
		
	}
}


$(document).ready(function(){
	  $("#city").change( function() {
			//var city = $("#city").val();
			$("#action").val("cityChange");
		//	$("#reportForm").submit();
	  });
	  $("#store").change( function(){
		  	$("#action").val("storeChange");
		//  	$("#reportForm").submit();
	  });
	  
	  $("#go").click( function() {
			$("#action").val("showReport");
			$("#reportForm").submit();
	  });

	  
	});
	
$(function () {
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
    formatter: function() {
        var point = this.point,
            s = this.x +':<b>'+ this.y +'%满座率</b><br/>';
        return s;
    }
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
});			
</script>
</body>
</html>