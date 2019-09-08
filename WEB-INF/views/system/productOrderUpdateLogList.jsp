<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
<script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body style="font-family: '微软雅黑'">
<div id="tb" style="padding:5px;height:auto">
		<form id="searchFrom" action="">
	        
	        <input  type="hidden" name="filter_LIKES_productOrder.member.name" class="easyui-validatebox" data-options="width:150,prompt: '会员名'"/>
		     
		 	<input type="text" name="filter_LIKES_user.name" class="easyui-validatebox" data-options="width:150,prompt: '操作人'"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
		</form>     
		
		
       	
    </div>
<table id="dg"></table> 
<div id="dlg"></div>  
<script type="text/javascript">
//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: meizz 
var o = { 
"M+" : this.getMonth()+1,                 //月份 
"d+" : this.getDate(),                    //日 
"h+" : this.getHours(),                   //小时 
"m+" : this.getMinutes(),                 //分 
"s+" : this.getSeconds(),                 //秒 
"q+" : Math.floor((this.getMonth()+3)/3), //季度 
"S"  : this.getMilliseconds()             //毫秒 
}; 
if(/(y+)/.test(fmt)) 
fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
for(var k in o) 
if(new RegExp("("+ k +")").test(fmt)) 
fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
return fmt; 
}


var dg;
$(function(){   
	dg=$('#dg').datagrid({    
    url:'${ctx}/system/productOrder/banlacejson', 
    fit : true,
	fitColumns : true,
	border : false,
	striped:true,
	singleSelect:true,
	idField : 'id',
	pagination:true,
	rownumbers:true,
	sortName:'createdTs',
	sortOrder:'desc',
	pageNumber:1,
	pageSize : 30,
	pageList : [ 10, 20, 30, 40, 50 ],
    columns:[[    
		{field:'id',title:'id',hidden:true},  
		
		{field:'createdTs',title:'操作日期时间',sortable:true, formatter:function(value,rowData,rowIndex){  
			return new Date(value).format("yyyy-MM-dd HH:mm:ss"); 
			
		}},
		{field:'userName',title:'操作人',sortable:true, formatter:function(value,rowData,rowIndex){
			return rowData.user.name; 
		}},
		{field:'productOrderMemberName',title:'会员名字',sortable:true, formatter:function(value,rowData,rowIndex){
			return rowData.productOrder.member.name; 
		}},
		{field:'productOrderMemberAccount',title:'会员账号',sortable:true, formatter:function(value,rowData,rowIndex){
			return rowData.productOrder.member.account; 
		}},
		{field:'oldBalance',title:'原点数',sortable:true, formatter:function(value,rowData,rowIndex){
			
			return rowData.oldBalance; 
		}},
		{field:'newBalance',title:'更改后点数',sortable:true,formatter:function(value,rowData,rowIndex){
			
			return rowData.newBalance; 
		}},
		
    ]],
    headerContextMenu: [
        {
            text: "冻结该列", disabled: function (e, field) { return dg.datagrid("getColumnFields", true).contains(field); },
            handler: function (e, field) { dg.datagrid("freezeColumn", field); }
        },
        {
            text: "取消冻结该列", disabled: function (e, field) { return dg.datagrid("getColumnFields", false).contains(field); },
            handler: function (e, field) { dg.datagrid("unfreezeColumn", field); }
        }
    ],
    enableHeaderClickMenu: true,
    enableHeaderContextMenu: true,
    enableRowContextMenu: false,
    rowTooltip: true,
    toolbar:'#tb'
	});
});

//创建查询对象并查询
function cx(){
	var obj=$("#searchFrom").serializeObject();	
	
	dg.datagrid('load',obj); 	
}

</script>
</body>
</html>