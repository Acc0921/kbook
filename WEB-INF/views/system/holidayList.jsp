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
     	   
		</form>
		
        <shiro:hasPermission name="sys:holiday:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:holiday:update">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">修改</a>
	    <span class="toolbar-item dialog-tool-separator"></span>
        </shiro:hasPermission>
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
    url:'${ctx}/system/holiday/json', 
    fit : true,
	fitColumns : true,
	border : false,
	singleSelect:true,
	striped:true,
	idField : 'id',
	pagination:true,
	rownumbers:true,
	pageNumber:1,
	pageSize : 30,
	pageList : [ 10, 20, 30, 40, 50 ],
    columns:[[    
		{field:'ck',checkbox:true},  
		{field:'id',title:'id',hidden:true}, 
		{field:'date',title:'节假日期',sortable:true, formatter:function(value,rowData,rowIndex){   
			return new Date(value).format("yyyy-MM-dd"); 
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



//弹窗增加
function add() {
	
	d=$("#dlg").dialog({   
	    title: '添加节假日',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/holiday/create',
	    maximizable:true,
	    modal:true,
	    buttons:[{
			text:'确认',
			handler:function(){
				$("#mainform").submit(); 
			}
		},{
			text:'取消',
			handler:function(){
					d.panel('close');
				}
		}]
	});
}

//弹窗修改
function upd(){
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '修改节假日',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/holiday/update/'+row.id,
	    maximizable:true,
	    modal:true,
	    buttons:[{
			text:'修改',
			handler:function(){
				$('#mainform').submit(); 
			}
		},{
			text:'取消',
			handler:function(){
					d.panel('close');
				}
		}]
	});
}

//创建查询对象并查询
function cx(){
	var obj=$("#searchFrom").serializeObject();
	dg.datagrid('load',obj); 
}


$(document).ready(function (){
	document.onkeydown=function(event){ 
     	if(event.keyCode == 13){ // enter 键
     		cx();
     		return false;
    	}
	}; 

});


 
</script>
</body>
</html>