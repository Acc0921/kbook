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
     	    <input type="text" name="filter_LIKES_name" class="easyui-validatebox" data-options="width:150,prompt: '产品名称'"/>
     	    
     	    <input id="selectCity" type="text" name="filter_EQI_city.id" data-options="width:150,prompt: '城市名称'"  class="easyui-combobox"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
		</form>
		
        <shiro:hasPermission name="sys:product:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:product:update">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">修改</a>
	    <span class="toolbar-item dialog-tool-separator"></span>
        </shiro:hasPermission>
    </div>
<table id="dg"></table> 
<div id="dlg"></div>  
<script type="text/javascript">
var dg;
$(function(){   
	dg=$('#dg').datagrid({    
    url:'${ctx}/system/product/json', 
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
		{field:'name',title:'产品名称',sortable:true},
		{field:'salesChannel',title:'消费渠道',sortable:true,formatter:function(value,rowData,rowIndex){   
			
			if(rowData.salesChannel==0){
			   		return "临时下架";
			   } else if(rowData.salesChannel==1){
			   		return "线下销售";
			   } else if(rowData.salesChannel==2){
			   		return "线上销售";
			   }else if(rowData.salesChannel==3){
				   return "线下线上销售";
			   }else{
				   return "无消费渠道";
			   }
			}}, 
		{field:'consumertype',title:'消费人群',sortable:true},
		{field:'actualValue',title:'储值金额',sortable:true},
		{field:'consumeValue',title:'实际消费点数',sortable:true},
		{field:'discount',title:'折扣',sortable:true},
		{field:'type',title:'产品类型',sortable:true,formatter:function(value,rowData,rowIndex){   
		   if(rowData.type==1){
		   		return "储值卡";
		   } else if(rowData.type==2){
		   		return "包天卡";
		   } else if(rowData.type==3){
               return "注册即送卡";
           }  else if(rowData.type==4){
               return "完善资料送卡";
           } else{
		   		return "无类型";
		   }
		}},   
		{field:'limitHour',title:'N小时封顶',sortable:true},
		{field:'cityName',title:'适用城市',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.city.name;  
		}},   
		{field:'effectiveFromDate',title:'有效日期 ',sortable:true},
		{field:'effectiveToDate',title:'失效日期',sortable:true},
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
	//$("#selectCity").combotree('select','选项的valueField');
});



//弹窗增加
function add() {
	
	d=$("#dlg").dialog({   
	    title: '添加产品',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/product/create',
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
	    title: '修改产品',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/product/update/'+row.id,
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

//适用城市
$.ajax({
   type: "GET",
   url: "${ctx}/system/city/getAllJson",
   dataType:"json",
   success: function(json){
     $("#selectCity").combobox({
 		data:json.rows,
 		parentField : 'city',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
    	animate:true
 	});
   }
 });
 
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