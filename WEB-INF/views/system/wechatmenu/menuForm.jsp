<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/wechatmenu/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>菜单名：</td>
			<td>
			<c:if test="${not empty menu.parent.id }">
				<input type="hidden" name="parent.id" value="${menu.parent.id }"/>
			</c:if>
			<input type="hidden" name="id" value="${menu.id }" />
			<input name="name" type="text" value="${menu.name }" class="easyui-validatebox" required="required"/>
			</td>
		</tr>
		<tr>
			<td>类型：</td>
			<td>
			<select id="type" class="easyui-combobox" name="type" style="width:200px;">
				<option value="view" ${menu.type=="view"?"selected":"" }>跳转URL界面</option>
				<option value="click" ${menu.type=="click"?"selected":"" }>发送消息事件</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>key：</td>
			<td><input name="key" type="text" value="${menu.key}" class="easyui-validatebox"/></td>
		</tr>
		<tr>
			<td>URL：</td>
			<td><input id="url" name="url" type="text" value="${menu.url}" class="easyui-validatebox" style="width:100%"/></td>
		</tr>
	</table>
	</form>
</div>
<script type="text/javascript">
$(function(){
	$('#type').combobox({
	    onChange:function(newValue,oldValue){
	        //$('#url').attr("required","required");
	    }
	});

	$('#mainform').form({    
	    onSubmit: function(){    
	    	var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
	    },    
	    success:function(data){   
	    	if(successTip(data,menuDg,d)){
    			menuDg.datagrid('reload');
    			dg.datagrid('reload');
    		}
	    } 
	}); 
});

</script>
</body>
</html>