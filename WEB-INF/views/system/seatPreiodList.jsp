<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body style="font-family: '微软雅黑'">
<div id="tb" style="padding:5px;height:auto">
		<form id="searchFrom" action="">
     	  
		</form>
		
        <shiro:hasPermission name="sys:seatPreiod:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:seatPreiod:update">
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
    url:'${ctx}/system/seatPreiod/json', 
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
		{field:'baseprice',title:'基准价格',sortable:true},
		{field:'seattypeName',title:'座位类型',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.seattype.name;  
		}},
        {field:'storeName',title:'所属门店',sortable:true,formatter:function(value,rowData,rowIndex){
                return rowData.storeName;
            }},
		{field:'cityName',title:'适用城市',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.city.name;  
		}},
		/**
		{field:'isHoliday',title:'节假日/闲时、忙时',sortable:true, formatter : function(value, row, index) {
                if(value ==1){
                    return '节假日';
                }
                else if(value ==2){
                    return '闲时';
                }
                else if(value ==3){
                    return '忙时';
                }
                return '未定义';
        	}
        },**/
        {field:'holidayRate',title:'节假日费率',sortable:true},
        {field:'leisureRate',title:'闲时费率',sortable:true},
        {field:'busyRate',title:'忙时费率',sortable:true},
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
	    title: '添加座位',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/seatPreiod/create',
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
	    title: '修改座位',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/seatPreiod/update/'+row.id,
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

//座位类别
$.ajax({
   type: "GET",
   url: "${ctx}/system/seattype/allSeatTypeJson",
   dataType:"json",
   success: function(json){
     $("#selectSeattype").combobox({
 		data:json.rows,
 		parentField : 'seattype',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
    	animate:true
 	});
   }
 });
 
//所属门店
$.ajax({
   type: "GET",
   url: "${ctx}/system/store/getAllJson",
   dataType:"json",
   success: function(json){
     $("#selectStore").combobox({
 		data:json.rows,
 		parentField : 'store',
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