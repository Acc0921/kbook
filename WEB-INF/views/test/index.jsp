<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width initial-scale=1.0 maximum-scale=1.0 user-scalable=yes" />
<title>Demo</title>
<link href="<%=basePath%>static/bootstrap/css/bootstrap.css"
	rel="stylesheet">
</head>
<body>
	测试OPENID:${openid }

	<table class="table table-condensed">

		<caption>基本的表格布局</caption>
		<thead>
			<tr>
				<th>名称</th>
				<th>城市</th>
				<th>城市1</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Tanmay</td>
				<td>Bangalore</td>
				<td>Bangalore</td>
			</tr>
			<tr>
				<td>Sachin</td>
				<td>Mumbai</td>
				<td>Bangalore</td>
			</tr>

		</tbody>
	</table>
	<table class="table">
		<label for="meeting">选择日期：</label>
		<input id="meeting" type="date" value="2014-01-13" />
	</table>
</body>
</html>
