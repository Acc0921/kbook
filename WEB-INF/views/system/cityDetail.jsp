<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="" method="post">
	<table  class="formTable">
		<tr>
			<td>城市名：</td>
			<td>
			<input type="hidden" name="id" value="${city.id }" />
			<input id="name" name="name" type="text" value="${city.name }" class="easyui-validatebox"  data-options="width: 150,required:'required'"/>
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>