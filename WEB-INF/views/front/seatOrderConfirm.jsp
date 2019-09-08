<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>订单确认</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/WEB-INF/views/include/context.jsp"%>
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css">
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
<body class="login">
	<div role="main" class="main" align="center">
		<div class="container" align="center">
			<br>
			<div class="well center-block" style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;font-size:1.2em">
			
			<form id="seatForm" action="${ctx}/front/seatOrder/create" class="form-horizontal" role="form" method="post" align="center">
				
				<table align="center" >
					<tr>
						<td align="center" width="50%">订座时间:</td>
						<td align="right" width="50%"><input id="orderDate" type="text" style="border-style:none;background-color:transparent" name="orderDate" value="${orderDate}" readonly/></td>
					</tr>
					<!--
					<tr>
						<td align="center" width="50%">订座开始日期:</td>
						<td align="right" width="50%"><input id="orderDate1" type="text" style="border-style:none;background-color:transparent" name="orderDate1" value="${orderDate1}" readonly/></td>
					</tr>
					<tr>
						<td align="center" width="50%">截止日期:</td>
						<td align="right" width="50%"><input id="orderDate2" type="text" style="border-style:none;background-color:transparent" name="orderDate2" value="${orderDate2}" readonly/></td>
					</tr>
					-->
					<tr>
						<td align="center" width="50%">开始时间:</td>
						<td align="right" width="50%"><input id="orderFromTime" type="text" style="border-style:none;background-color:transparent" name="orderFromTime" value="${fromTime}" readonly/></td>
					</tr>
					<tr>
						<td align="center">结束时间:</td>
						<td align="right"><input id="orderToTime" type="text" style="border-style:none;background-color:transparent" name="orderToTime" value="${toTime}" readonly/></td>
					</tr>
					<tr>
						<td align="center">会员姓名:</td>
						<td align="right">
							<input id="memberName" type="text" style="border-style:none;background-color:transparent"	name="memberName" value="${memberName}" readonly/>
						</td>
                        <input id="memberId" type="text" name="memberId" value="${memberId}" readonly style="display:none;background-color:transparent"/>
                    </tr>
					<tr>
						<td align="center">座位编号:</td>
						<td align="right">
							<input id="seatName" type="text" name="seatName" style="border-style:none;background-color:transparent" value="${seatName}"  readonly/>
						</td>
                        <input id="seatId" type="text" name="seatId" value="${seatId}"  readonly style="display:none"/>
					</tr>
					<tr>
						<td align="center">订座门店:</td>
						<td align="right">
							<input id="storeName" type="text" name="storeName" style="border-style:none;background-color:transparent" value="${storeName}"  readonly/>
						</td>
					</tr>
					<tr style="display:none;">
						<!-- end:yangzh by 2018-05-01 start -->
						<td align="center">座位基本价钱:</td>
						<!--<td align="center">座位平均单价:</td>-->
						<!-- end:yangzh by 2018-05-01 end -->
						<td align="right"><input id="baseprice" type="text" style="border-style:none;background-color:transparent" name="baseprice" value="${baseprice}" readonly/></td>
					</tr>

					<tr id="t1">
						<td align="center">预算点数:</td>
						<!- 剩余点数展现给会员看时，进行四舍五入处理 ->
						<td align="left">${Math.round(estimatedPayment)}点</td>
						<!- 剩余点数不显示给会员看时，不进行四舍五入处理 ->
						<input id="estimatedPayment" type="text" style="background-color:transparent;display: none" name="estimatedPayment" value="${estimatedPayment}" readonly/>
					</tr>
					
					<tr id="t2">
						<td align="center">${limitType == 1?"封顶时间":"封顶点数"}:</td>
						<td align="right">
						<input id="limitHour" type="${limitType == 1?"text":"hidden"}" style="border-style:none;background-color:transparent" name="limitHour" value="${limitHour}" readonly/>
						<input id="limitFee" type="${limitType == 2?"text":"hidden"}" style="border-style:none;background-color:transparent" name="limitFee" value="${limitFee}" readonly/>
						</td>
					</tr>
					<input type="hidden" name="limitType" value="${limitType }" />
					<!--
					<tr id="t3">
						<td align="center" >剩余点数:</td>
						<td align="right"><input id="balance" type="text" style="border-style:none;background-color:transparent" name="balance" value="${Math.round(balance)}" readonly/>点</td>
					</tr>
					-->
					<!-- add:yangzh by 2018-05-01 start -->
					<tr id="t4">
						<td align="center" >剩余点数:</td>
						<!- 剩余点数展现给会员看时，进行四舍五入处理 ->
						<td align="left">${Math.round(consumptionLimit)}点</td>
						<!- 剩余点数不显示给会员看时，不进行四舍五入处理 ->
						<input id="consumptionLimit" type="text" style="border-style:none;background-color:transparent; display: none" name="consumptionLimit" value="${consumptionLimit}" readonly/>
					</tr>
					<!-- add:yangzh by 2018-05-01 end -->
					<tr style="display:none">  
						<td >
							<input id="effectiveFromDate" type="text" style="border-style:none" name="effectiveFromDate" value="${effectiveFromDate}" readonly/>
							<input id="effectiveToDate" type="text" style="border-style:none" name="effectiveToDate" value="${effectiveToDate}" readonly/>
							<input id="type" type="text" style="border-style:none" name="type" value="${type}" readonly/>
							<input id="productOrderId" type="text" style="border-style:none" name="productOrderId" value="${productOrderId}" readonly/>
						</td>
                        <td>&nbsp;</td>
					</tr>
					
				</table>
				
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
	</div>
</body>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$.backstretch("${ctx}/static/images/1.jpg");
  	});
  </script>
<script type="text/javascript">
		$(function() {
			var balance= $("#balance").val();
            var type = $("#type").val();	//产品类型
            var consumptionLimit= $("#consumptionLimit").val();	//可用点数
			var estimatedPayment= $("#estimatedPayment").val();	//预支付总额
			$("#sub").click(function() {
                if (type == 1) {	//储蓄卡
					if (consumptionLimit - estimatedPayment < 0) {
                        alert("金额不足,请充值");
                        return false;
					}
				}
                $("#seatForm").submit();
		        	         	 	
		     });
		     
		     
		       
		     $("#back").click(function() {  
		        	window.history.back(); 	
		     });  
		
		$('#seatForm').form({
				onSubmit : function() {
					var isValid = $(this).form('validate');
					return isValid; // 返回false终止表单提交
				},
				success : function(data) {				
					successTip(data, dg, d);
				}
			});
		});
		
		var type= $("#type").val();
	     if(type==2){
	     	$("#t1").css("display","none");
	     	$("#t2").css("display","none");
	     	//$("#t3").css("display","none");
             <!-- add:yangzh by 2018-05-01 start -->
	     	$("#t4").css("display","none");
             <!-- add:yangzh by 2018-05-01 end -->
	     }else{
             $("#t1").css("display","");
             $("#t2").css("display","");
             //$("#t3").css("display","");
             $("#t4").css("display","");
		 }
	</script>
</html>