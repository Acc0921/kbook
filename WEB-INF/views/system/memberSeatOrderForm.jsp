<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body onload="init();">
<div>
	<form id="mainform" action="${ctx}/system/memberSeatOrder/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>订单号：</td>
			<td>
			<input type="hidden" name="id" value="${id }" />
			${seatOrder.orderNumber }
			</td>
		</tr>
		<tr>
			<td>会员ID：</td>
			<td>
			${seatOrder.member.name }
			</td>
		</tr>
		<!-- 
		<tr>
			<td>订单日期：</td>
			<td>
			${seatOrder.orderDate }
			</td>
		</tr>
		 -->
		<tr>
			<td>开始时间：</td>
			<td>
			${seatOrder.orderFromTime }
			</td>
		</tr>
		<tr>
			<td>结束时间：</td>
			<td>
			${seatOrder.orderToTime }
			</td>
		</tr>
		<tr>
			<td>门店：</td>
			<td>
			${seatOrder.seat.store.name }
			</td>
		</tr>
		<tr>
			<td>座位：</td>
			<td>
			${seatOrder.seat.name }
			</td>
		</tr>
		<tr>
			<td>座位单价：</td>
			<td>
			${seatOrder.seatPrice }
			</td>
		</tr>
		<tr>
			<td>产品折扣：</td>
			<td>
			${seatOrder.productDiscount }
			</td>
		</tr>
		<tr>
			<td>门店折扣：</td>
			<td>
			${seatOrder.storeDiscount }
			</td>
		</tr>
		<tr>
			<td>实际签到时间：</td>
			<td>
			${seatOrder.actualCheckInTime }
			</td>
		</tr>
		<tr>
			<td>实际结帐时间：</td>
			<td>
			${seatOrder.actualCheckOutTime }
			</td>
		</tr>
		<c:forEach var="sol" items="${seatOrder.leaves}">   
      	<tr >   
      		<td>	请假开始时间：</td>
        		<td >${sol.askForLeaveFromTime}</td>
        </tr>   
        <tr >   
      		<td>	请假结束时间：</td>
        		<td >${sol.askForLeaveToTime}</td>
        </tr> 
		</c:forEach>
		<tr>
			<td>预计支付点数：</td>
			<td>
			${seatOrder.estimatedPayment }点
			</td>
		</tr>
		<tr>
			<td>实际支付点数：</td>
			<td>
			${seatOrder.actualPayment }点
			</td>
		</tr>
		<tr>
			<td>状态：</td>
			<td>
			<input id="status" type="hidden" name="status" value="${seatOrder.status }" />
			<div id="statusText"></div>
			</td>
		</tr>
		<tr>
			<td>备注：</td>
			<td>
				<textarea name="remark" rows="5" cols="40"> ${seatOrder.remark}</textarea>
			</td>
		</tr>
	</table>
	</form>
</div>
<script type="text/javascript">
$(function(){
	$('#mainform').form({    
	    onSubmit: function(){    
	    	var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
	    },    
	    success:function(data){   
	    	successTip(data,dg,d);
	    }    
	}); 
});

$(document).ready( 
	function() { 
		
		var status = document.getElementById("status").value;
		var intVal = parseInt(status);
		switch (intVal) {
		case 1:
			retVal = "下单"
			break;
		case 2:
			retVal = "签到"
			break;
		case 3:
			retVal = "请假"
			break;
		case 4:
			retVal = "完成"
			break;
		case 5:
			retVal = "取消"
			break;
		case 6:
			retVal = "缺席"
			break;
		default:
			break;
		} 
		
		document.getElementById("statusText").innerText = retVal;

	} 
); 
		




</script>
</body>
</html>