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
     	    <input type="text" name="filter_LIKES_name" class="easyui-validatebox" data-options="width:150,prompt: '会员名称'"/>
     	    <input type="text" name="filter_LIKES_cardid" class="easyui-validatebox" data-options="width:150,prompt: '会员卡号'"/>
     	    <input type="text" name="filter_LIKES_wechat" class="easyui-validatebox" data-options="width:150,prompt: '微信号'"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
		</form>
		
        <shiro:hasPermission name="sys:member:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:member:update">
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
    url:'${ctx}/system/member/json', 
    fit : true,
	fitColumns : true,
	border : false,
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
		{field:'name',title:'会员名称',sortable:true},
		{field:'sex',title:'性别',sortable:true,
        	formatter : function(value, row, index) {
       			return value==1?'男':'女';
        	}
        },
		{field:'wechat',title:'微信',sortable:true},
		{field:'tel',title:'联系电话',sortable:true},
		{field:'emgergencycontact',title:'紧急联系人',sortable:true},
		{field:'cardid',title:'会员卡号',sortable:true},
		{field:'address',title:'联系地址',sortable:true},
		{field:'school',title:'所属学校',sortable:true},
		{field:'grade',title:'年级',sortable:true},
		{field:'company',title:'公司',sortable:true},
		{field:'position',title:'职位',sortable:true},
		{field:'target',title:'主要目标',sortable:true},
		{field:'channel',title:'用户来源',sortable:true},
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
	    title: '添加会员',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/member/create',
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
	    title: '修改会员',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/member/update/'+row.id,
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

 
</script>
</body>
</html>