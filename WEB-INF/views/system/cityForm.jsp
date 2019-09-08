<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/city/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>城市名：</td>
			<td>
			<input type="hidden" name="id" value="${id }" />
			<input name="name" type="text" value="${city.name }" class="easyui-validatebox" required="required"/>
			</td>
		</tr>
		<tr style="display:none;">
			<td>禁用：</td>
			<td>
				<input type="radio" id="activated" name="activated" value="1" checked="checked"/><label for="activated">可用</label>
				<input type="radio" id="noactivate" name="activated" value="0"/><label for="noactivate">禁用</label>
				</td>
		</tr>
		<tr>
			<td>说明：</td>
			<td>
				<textarea name="description" rows="5" cols=""> ${city.description}</textarea>
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

</script>
</body>
</html>