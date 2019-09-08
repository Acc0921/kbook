<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>订座记录</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
    
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >
    <script src="${ctx}/static/bootstrap3.0/js/bootstrap.min.js"></script>
    
    <script src="${ctx}/static/bootstrap3.0/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script src="${ctx}/static/bootstrap3.0/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
   
  	<style type="text/css">
  		table tr td{
  			padding:5px;
  			text-align:center;
  			height :auto;
  			width : auto;
  			border:solid 2px gray; 
  			background-Color : #EEE;
  		}
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
  	 <div class="container" align="center">
  	 	<div class="well center-block" style="max-width: 500px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
  	 	
		<c:if test="${solist.size() < 1}">
		<table id="seatOrdrTable" width="100%"  style="font-size:1.4em; border: none;">
			<tr>
				<td style="border: none;">亲,目前您还没有订座。</td>
			</tr>
		</table>
		</c:if>
		
		<table id="seatOrdrTable" width="100%"  style="font-size:1.2em;">
		<c:forEach var="so" items="${solist}" varStatus="status">     
		<tr>
			<td>
				${status.index + 1}
			</td>
			<td>
				<p align='left'>
				门店:<c:out value="${so.seat.store.name}"/><br/>
				座位号:<c:out value="${so.seat.name}"/><br/>
				开始时间:<fmt:formatDate value="${so.orderFromTime}" pattern="HH:mm"/><br/>
				结束时间:<fmt:formatDate value="${so.orderToTime}" pattern="HH:mm"/><br/>
				日期:<fmt:formatDate value="${so.orderDate}" type="date"/><br/>
				订单编号:<c:out value="${so.orderNumber}"/>
				</p>
			</td>
			<td>
			<c:choose>
				<c:when test="${so.status==1}">
				<a onclick="cancelOrderClick('${so.id}', '${so.orderNumber}')" data-toggle='modal' href='#myModal' >取消</a>
				</c:when>
				<c:otherwise>
				<c:out value="${so.statusName}"/>
				</c:otherwise>
			</c:choose>
			</td>
		</tr>
		</c:forEach>
	   	</table>

		  <!-- Modal -->
		  <div class="modal fade container" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
		    <div class="modal-dialog">
		      <div class="modal-content" style=" filter: alpha(opacity=100); opacity:1;">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">取消订单</h4>
		        </div>
		        <div id="cancelOrder" class="modal-body">
		         	
		        </div>
		        <div class="modal-footer">
		          <button id="confir" type="button" class="btn btn-success btn-lg btn-block btn-fontsize">是</button>
		          <button type="button" class="btn btn-success btn-lg btn-block btn-fontsize" data-dismiss="modal">否</button>
		        </div>
		      </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		  </div><!-- /.modal -->

	   	 <br/>
	 
 	  	 <br/>
		  <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/memberMenu';">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">返回</button>
			</a>
		  </div>
	    </div>
	</div>
  <br/>	
  <script type="text/javascript">   		
	function cancelOrderClick(id, orderNumber) { // 点击一个td的事件
		
		searchActualPayment(id,orderNumber);
			
	};

 	function cancelOrder(obj){
  		var now=new Date();
		var hour = now.getHours();
		var minute;
		if(now.getMinutes()<10){
			minute ="0"+ now.getMinutes();
		}else{
			minute = now.getMinutes();
		}			
		var nowTime = hour+":"+minute;
		var url = "${ctx}/front/member/updateStatus?id="+obj+"&nowTime="+nowTime;
		$.ajax({
		   type: "GET",
		   url: url,
		   dataType:"json",
		   success: function(json){
		    	window.location.href="${ctx}/front/member/seatOrder";
			 }//end func
		 });//end alax
   	} 
 	
 	function searchActualPayment(obj,orderNumber){
		var url = "${ctx}/front/member/searchSeatOrder?id="+obj;
		$.ajax({
		   type: "GET",
		   url: url,
		   dataType:"json",
		   success: function(json){
				var cancelOrder=document.getElementById("cancelOrder");
				cancelOrder.innerHTML="本次取消订单将扣点数："+json.actualPayment+"点";//<br/>是否取消订单:" + orderNumber
		   }//end func
		 });//end alax
		var confir = document.getElementById("confir");
		confir.setAttribute("onclick", "javascript:cancelOrder("+obj+");");	
   	} 
   		
  </script>
  <script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
  <script type="text/javascript">
    	$(function(){
    		$.backstretch("${ctx}/static/images/1.jpg");
    	});
  </script>
  </body>
</html>