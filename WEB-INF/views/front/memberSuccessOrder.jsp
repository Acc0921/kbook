<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>消费记录</title>
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
  			border:solid 2px gray; 
  			text-align:center;
  			height :auto;
  			width : auto;
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
  <body onload="init()">
  <br/>
  	 <div class="container" align="center">
  	 	<div class="well center-block" style="max-width: 500px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
  	 	 <form action="" method="post">
			<c:if test="${solist.size() < 1}">
			<table id="seatOrdrTable" width="100%"  style="font-size:1.2em;" border="0">
				<tr>
					<td style="font-size: 1.4em; border: none;">
					<!-- <c:out value="${currentMonthYear}"/> -->
					亲,您本月没有消费记录
					</td>
				</tr>		
			</table>
			</c:if>
			<table id="seatOrdrTable" width="100%"  style="font-size:1.2em;">
    		<c:forEach var="so" items="${solist}" varStatus="status">     
				<tr>
					<td>${status.index + 1}</td>
					<td>
						<p align='left'>
						门店:<c:out value="${so.seat.store.name}"/><br/>
						座位号:<c:out value="${so.seat.name}"/><br/>
						状态:<c:out value="${so.statusName}"/><br/>
						<c:choose>
						<c:when test="${so.type=='1'}">
						<!-- 实收点数:<fmt:formatNumber value="${Math.round(so.actualPayment)}" type="currency" pattern="#0.00点数"/><br/> -->
						消费点数:<fmt:formatNumber value="${Math.round(so.actualPayment)}" type="currency" pattern="#0点"/><br/>
						</c:when>
						<c:when test="${so.type=='2'}">
						</c:when>
						<c:otherwise>
						<!-- 未知产品类型 -->
						<!-- 实收点数:<fmt:formatNumber value="${so.actualPayment}" type="currency" pattern="#0.00点数"/><br/> -->
						消费点数:<fmt:formatNumber value="${Math.round(so.actualPayment)}" type="currency" pattern="#0点"/><br/>
						</c:otherwise>
						</c:choose>
						日期:<fmt:formatDate value="${so.orderDate}" type="date"/><br/>
						订单编号:<c:out value="${so.orderNumber}"/>
						</p>
					</td>
					<td>
					<a data-toggle='modal' href='#myModal' onclick="showOrderDetail('${so.id}');">详情</a>
					</td>
				</tr>
			</c:forEach>

		   	 </table>
			
		
		   	 <!-- 弹窗 -->
			 <!-- Modal -->
			  <div class="modal fade container" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			      <div class="modal-content"  style=" filter: alpha(opacity=100); opacity:1;">
			        <div class="modal-header">
			          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			          <h4 class="modal-title">消费记录详情</h4>
			        </div>
			        <div id="orderDetail" class="modal-body" style="text-align:left;">
			         	
			        </div>
			        <div class="modal-footer" style="text-align:center;">
		
			          <button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize" data-dismiss="modal">确定</button>
			        </div>
			      </div><!-- /.modal-content -->
			    </div><!-- /.modal-dialog -->
			  </div><!-- /.modal -->
	   	 </form>
	   	 <br/>
	 
 	  	  <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="search" onclick="showMonth('-1');">
				<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">上月</button>
			</a>
		  </div> 
		   <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="search" onclick="showMonth('1');">
				<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">下月</button>
			</a>
		  </div>
		  
		  <input type="hidden" id="monthOffset" name="monthOffset" value="${monthOffset}"/>
		  
	      <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="toSeatOrder" onclick="window.location.href='${ctx}/front/member/memberMenu';">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">返回</button>
			</a>
		  </div>
	    </div>
	</div>
  <br/>	
  	<script type="text/javascript">
	function showMonth(monthOffset) {
		var currentMonthOffset = parseInt(document.getElementById("monthOffset").value);
		currentMonthOffset += parseInt(monthOffset);
		window.location = "${ctx}/front/member/successOrder?monthOffset=" + currentMonthOffset;
	}
    	
	function init(){
   		//Do nothing
   	}
				   
   function showOrderDetail(id) { // 点击一个td的事件
	   //clean up first
	   document.getElementById("orderDetail").innerHTML = "读取信息中...";
   		//根据ID获取 订单详情
   		var url = "${ctx}/front/member/getOrderbyId?id="+id;
		$.ajax({
		   type: "GET",
		   url: url,
		   async: true,
		   dataType:"json",
		   success: function(json){
		   		var orderDetail=document.getElementById("orderDetail");
		   		
		   		var orderDate =json.orderDate;
				var id =json.id;
				var seatName =json.seatName;
				var orderFromTime=json.orderFromTime;
	    		var orderToTime=json.orderToTime;
	    		var actualPayment=json.actualPayment;
	    		var actualCheckInTime =json.actualCheckInTime ;
	    		var actualCheckOutTime=json.actualCheckOutTime;
	    		var type=json.type;
				orderDetail.innerHTML="日期:"+orderDate+"<br/>";
				orderDetail.innerHTML+="座位号:"+seatName+"<br/>";
				if(type!=2){
					orderDetail.innerHTML+="消费点数:"+Math.round(actualPayment)+"点<br/><br/>";
				}else{
					orderDetail.innerHTML+="<br/>";
				}
					
		   		orderDetail.innerHTML+="预订开始时间:"+timeChange(orderFromTime)+"<br/>";
		   		orderDetail.innerHTML+="预订结束时间:"+timeChange(orderToTime)+"<br/><br/>";
		   		orderDetail.innerHTML+="实际签到时间:"+timeChange(actualCheckInTime)+"<br/>";
		   		orderDetail.innerHTML+="实际结束时间:"+timeChange(actualCheckOutTime)+"<br/><br/>";
		   		
		   		for(var i = 0; i < json.leaves.length;i++){
		   			orderDetail.innerHTML+="开始请假时间:"+timeChange(json.leaves[i].askForLeaveFromTime)+"<br/>";
   					orderDetail.innerHTML+="请假结束时间:"+timeChange(json.leaves[i].askForLeaveToTime)+"<br/><br/>";
		   		}		   		

			   }
			});
   		}
   		
    	
   	function timeChange(time){
   		var actTime="";
   		
   		if(time!=null){
    		var ct = new Date();
			ct.setTime(time);

 			var m; 
 			if(ct.getMinutes()<10){
 			    m="0"+ct.getMinutes();
 			}else{
 				m=ct.getMinutes();
 			}
 			 actTime = ct.getHours() + ":" +m ;
 		}else{
 			actTime="无";
 		}
		return actTime;
			
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