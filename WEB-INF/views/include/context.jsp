<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<script src="${ctx}/static/plugins/jquery/jquery-2.1.4.min.js"></script>
<script>
//全局的AJAX访问，处理AJAX清求时SESSION超时
$.ajaxSetup({
	cache: false,
    contentType:"application/x-www-form-urlencoded;charset=utf-8",
    complete:function(XMLHttpRequest,textStatus){
    }
});

/** 
  * 在页面中任何嵌套层次的窗口中获取顶层窗口 
  * @return 当前页面的顶层窗口对象 
  */
function getTopWinow(){  
    var p = window;  
    while(p != p.parent){  
        p = p.parent;  
    }  
    return p;  
}  
</script>
