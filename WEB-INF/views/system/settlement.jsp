<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
	<div>
		<form id="mainform" action="${ctx}/system/memberSeatOrder/settlement"
			method="post">
			<table class="formTable" style="padding:20px;">
				<tr>
					<td>结算时间:</td>
					<td><input type="text" id="cotime" name="cotime"
						class="easyui-my97" datefmt="H:mm:ss" minDate="${startTime }" maxDate="23:00:00"
						data-options="width:200,prompt: '选择结算时间'" required="required" />
						<div style="margin-top:10px;font-size:9px;color:blue;font-style: italic">*只能设置订单当天的时间，不能跨天进行结算。</div>
						<input type="hidden" name="id" id="id" value="${id }"/>
					</td>
				</tr>
				<%-- <tr>
					<td>结账金额：</td>
					<td><input type="hidden" name="id" value="${id }" /> <input
						id="name" name="name" type="text" value="${product.name }"
						 data-options="width: 200,prompt: '结算金额，只能是数字和小数点'"  class="easyui-numberbox" precision="2" max="99999.99" size="8" maxlength="8" /></td>
					
				</tr> --%>
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
	    	var cd;
	    	if( data == 0)cd = '没有订单数据，请检查是否已经删除。';
	    	else if(data == -1) cd = '请输入结账时间';
	    	else if(data == -2) cd = '结账失败，请与技术人员联系。';
	    	else if(data == -3) cd = '开始时间不能小于订单时间和大于营业结束时间.';
	    	else if(data == -4) cd = '产品订单已经删除，不能进行结账操作.';
	    	else if(data == 'success') cd = data;
	    	successTip(cd,dg,d);
	    }    
	}); 
});
</script>
</body>
</html>