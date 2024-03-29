<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!-- easyui皮肤 -->
<link href="${ctx}/static/plugins/easyui/jquery-easyui-theme/<c:out value="${cookie.themeName.value}" default="default"/>/easyui.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/plugins/easyui/jquery-easyui-theme/icon.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/static/plugins/easyui/icons/icon-all.css" rel="stylesheet" type="text/css" />

<script src="${ctx}/static/plugins/easyui/jquery/jquery-1.11.1.min.js"></script>

<script src="${ctx}/static/plugins/easyui/jquery-easyui-1.3.6/jquery.easyui.min.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jquery-easyui-1.3.6/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

<!-- jquery扩展 -->
<script src="${ctx}/static/plugins/easyui/release/jquery.jdirk.min.js"></script>

<!-- easyui扩展 -->
<link href="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.css" rel="stylesheet" type="text/css" />

<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.progressbar.js"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.slider.js"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.linkbutton.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.validatebox.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.combo.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.combobox.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.menu.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.searchbox.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.panel.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.window.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.dialog.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.layout.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.tree.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.datagrid.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.treegrid.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.combogrid.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.combotree.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.tabs.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.theme.js" type="text/javascript"></script>

<!--<script src="${ctx}/static/plugins/easyui/release/jeasyui.extensions.all.min.js"></script>-->

<script src="${ctx}/static/plugins/easyui/icons/jeasyui.icons.all.js" type="text/javascript"></script>
<!--<script src="${ctx}/static/plugins/easyui/release/jeasyui.icons.all.min.js"></script>-->
    
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.icons.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.gridselector.js" type="text/javascript"></script>

<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jquery.toolbar.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jquery.comboicons.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jquery.comboselector.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jquery.portal.js" type="text/javascript"></script>
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jquery.my97.js" type="text/javascript"></script>    
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.ty.js"></script>

<link rel="stylesheet" href="${ctx }/static/plugins/easyui/common/other.css"></link>

<!-- layui js&css -->
<link rel="stylesheet" href="${ctx}/static/layui/css/layui.css"  media="all">
<link rel="stylesheet" type="text/css" href="${ctx}/static/layui/css/style.css" />
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/static/layui/layui.js"></script>

<script>
//全局的AJAX访问，处理AJAX清求时SESSION超时
$.ajaxSetup({
	cache: false,
	beforeSend: function (xhr) {
		xhr.setRequestHeader("X-Admin-Header", "admin");
	},
    contentType:"application/x-www-form-urlencoded;charset=utf-8",
    complete:function(XMLHttpRequest,textStatus){
          //通过XMLHttpRequest取得响应头，sessionstatus           
          var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); 
          if(sessionstatus=="timeout"){
          		var top = getTopWinow(); //获取当前页面的顶层窗口对象
          		alert('会话超时, 请重新登录.'); 
               	//跳转的登录页面
               	top.window.location.replace('${ctx}/a/login');
       		}	
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
