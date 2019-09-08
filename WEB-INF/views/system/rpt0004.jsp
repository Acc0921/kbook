<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%    
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1    
response.setHeader("Pragma","no-cache"); //HTTP 1.0    
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server    
%>
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
    <meta http-equiv="pragma" content="no-cache" />
    <title>收入报表（金额）</title>
   	<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
	<script src="${ctx}/static/hcharts/highcharts.js"></script>
  	<script src="${ctx}/static/js/utility.js"></script>

  	<style type="text/css">
  	</style>
  </head>
<body>
	<div style="high:20px;margin-top:20px;margin-bottom:20px;text-align:center;font-size:1.2em;">收入报表（金额）</div>

<div>
	
	<form id="reportForm" name="reportForm" action="${ctx}/system/rpt0004" method="get" align="center">
	<input type="hidden" name="currdate" id="currdate" value="${curryear }" />
	<select id="period" name="period" class="form-control" style="width:50px">
		<option value="1" <c:if test="${period==1}">selected</c:if>>年</option>
		<option value="2" <c:if test="${period==2}">selected</c:if>>月</option>
	</select>
	<input id="periodDate" name="periodDate" value="${periodDate}" type="hidden"/>
	<input id="periodOffset" name="periodOffset" value="0" type="hidden"/>
	<select id="city" name="city" class="form-control" style="width:80px">
		<option value="0" >所有城市</option>
		<c:forEach var="city" items="${cityList}">     
		<option value="<c:out value="${city.id}"/>"><c:out value="${city.name}"/></option>
		</c:forEach>     
	</select>
	<select id="store" name="store" class="form-control" style="width:80px">
		<option value="0" >所有门店</option>
		
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
						<td width="120"><fmt:formatNumber value="${rptData.revenue}" type="currency" pattern="#0.00点数"/></td>
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
			//readReport();
			$('#tips').css('height', $(window).height() - 200);
			$('#container').hide();
			$('#container').css('height', $(window).height() - 150);
		});
	
	function changeStore(cityId){
		$('#store').append("<option value='0'>所有门店</option>");
		$.ajax({
            type: "get",//使用get方法访问后台
            dataType: "json",//返回json格式的数据
            url: "${ctx}/system/store/getStoreByCityId",//要访问的后台地址
            data: "cityId="+ cityId,//要发送的数据
            beforeSend: function (xhr) {
			   xhr.setRequestHeader("X-Custom-Header", "noUseSession");
			},
            //complete :function(){$("#load").hide();},//AJAX请求完成时隐藏loading提示
            success: function(data){//msg为返回的数据，在这里做数据绑定
                $.each(data.rows, function(i, item){
                	$('#store').append("<option value='"+ item.id +"'>"+ item.name +"</option>"); 
                });
			}, 
			error: function (xhr, textStatus, errorThrow) {
			   alert('error:'+ errorThrow);
			}
		});
	}


	function readReport(init){
		
		var cityId = $('#city').val();
		var storeId = $('#store').val();
		var periodOffset = $('#periodOffset').val();
		var period = $('#period').val();
		if(init == 'init'){
			initReport([], []);
			return;
		}
		$.ajax({
            type: "get",//使用get方法访问后台
            dataType: "json",//返回json格式的数据
            url: "${ctx}/system/rpt0004/report",//要访问的后台地址
            beforeSend: function (xhr) {
			   xhr.setRequestHeader("X-Custom-Header", "noUseSession");
			},
			data: {"city":cityId,"store":storeId, "period":period, "periodOffset":periodOffset}, 
            //complete :function(){$("#load").hide();},//AJAX请求完成时隐藏loading提示
            success: function(data){//msg为返回的数据，在这里做数据绑定
            	initReport(data.categories, data.datas);
			}, 
			error: function (xhr, textStatus, errorThrow) {
			   alert('error:'+ errorThrow);
			}
		});
	}
	function initReport(categories, datas){

			var year = $('#currdate').val();
			var now = new Date(year);
			var years = now.getFullYear();
			
			var period = $('#period').val();
			if(period == 2){
				var month = now.getMonth()+1;
				var day = now.getDate(); 
				
				years = years +"年"+ month +"月";
			}else{
				years = years + '年';
			}
			var initOpened = getCookie('initOpened');
			$('#container').hide();
			if (initOpened == '1'){
				$('#tips').hide();
				$('#container').show();
			}
			setCookie('initOpened','1',null,'/');

		    $('#container').highcharts({
		        title: {
		            text: '',
		            align: 'center'
		        },
		        subtitle: {
		            text: '汇报时期:' + years,
		            align: 'center'
		        },
		        xAxis: {
		            categories: categories
		        },
		        yAxis: {
					title : {
						text : '单位（点数）',
						align : 'high',
						margin: -50,
						rotation: 0,
						y: -15								
					},
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        tooltip: {
		            valueSuffix: ''
		        }, 
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0,
		            enabled: false
		        },
		        series: [{
		            name: '收入',
		            data: datas
		        }],
		        credits: {
		            enabled: false
		        },
		        exporting: {
		            enabled: false
		        }
		    });
	    }	
		$(document).ready(function(){
		  $('#reportForm')[0].reset();
		  readReport('init');
		  $("#city").change( function() {
		  		$('#store').empty();
		  		changeStore($('#city').val());
		  		readReport('init');
				//var city = $("#city").val();
				/* $("#action").val("cityChange");
				$("#periodOffset").val("0");
				$("#reportForm").submit(); */
		  });
		  
		  $('#period').change(function(){
		  		var period = $(this).val();
				location.href='${ctx}/system/rpt0004?period='+ period;
		  		//readReport();
		  });
		  
		  $("#go").click( function() {
				readReport();
		  });

		  var offset = 0;
		  $("#previous").click( function() {
		  		offset = offset - 1;
				$("#periodOffset").val(offset);				
				var year = $('#currdate').val();
				var now = new Date(year);
				var period = $('#period').val();
				if(period == 1){
					var years = now.getFullYear() - 1;
					$('#currdate').val(years);
				}else{
					var years = now.getFullYear();
					var month = now.getMonth()+1;
					month = month - 1;
					if(month == 0){
						month = 12;
						years = years - 1;
					}
					$('#currdate').val(years+'/'+month +'/1');
				}
				readReport();
		  });

		  $("#next").click( function() {
				offset = offset + 1;
				$("#periodOffset").val(offset);
				
				var year = $('#currdate').val();
				var now = new Date(year);
				var period = $('#period').val();
				if(period == 1){
					var years = now.getFullYear() + 1;
					$('#currdate').val(years);
				}else{
					var years = now.getFullYear();
					var month = now.getMonth()+1;
					month = month + 1;
					if(month == 13){
						month = 1;
						years = years + 1;
					}
					$('#currdate').val(years+'/'+month+'/1');
				}
				
				readReport();
		  });

		 $('#returnmenu').click(function(){
		 	location.href='${ctx}/front/userMenu';
		 });
		
	});
	</script>
</html>