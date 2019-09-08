<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.apache.logging.log4j.LogManager,org.apache.logging.log4j.Logger" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%response.setStatus(200);%>

<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");

	//记录日志
	Logger logger = LogManager.getLogger("com.kbook.500");
	/* logger.debug(" >>>>> "+ ex.getMessage()); */
	/* logger.error(ex.getMessage(), ex); */
	
%>

<!DOCTYPE html>
<html>
<head>
	<title>500 - 系统内部错误</title>
</head>

<body>
<%
	if(ex.getMessage().contains("anonymous")){
%>
<div id="content" style="width:100%;text-align:center;margin-top: 30px;margin-bottom:20px; font-size:18px;">
会话过期，请重新登录！
</div>

<% 		
	}else{
		System.err.println("xxxx>>: "+ ex.getMessage());
%>
	<%-- <h2>500 - 系统发生内部错误. <%=ex.getMessage() %></h2> --%>
	<h2>系统发生内部错误，请与管理员联系。</h2>
<%}%>
</body>
</html>
