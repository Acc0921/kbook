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
            <input id ="selcetLeisureBusyFlag" type="text" name="filter_EQI_leisureBusyFlag" class="easyui-combobox" data-options="width:150,prompt: '闲时忙时标志'"/>
            <td><select id="selectCity" name="filter_EQI_city.id" data-options="width:150,prompt: '城市名称'">
                <option value=""></option>
            </select>
            </td>
            <td style="display:none;" id="test">${store.storeId}</td>
            <input id="selectStore" type="text" name="filter_EQI_store.id" class="easyui-validatebox" data-options="width:150,prompt: '门店名称'"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
		</form>
		
        <shiro:hasPermission name="sys:leisureBusy:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:leisureBusy:update">
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
    url:'${ctx}/system/leisureBusy/json',
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
        {field:'leisureBusyFlag',title:'闲时忙时标志',sortable:true,formatter:function(value,rowData,rowIndex){
                if(rowData.leisureBusyFlag==1){
                    return "闲时";
                } else if(rowData.leisureBusyFlag==2){
                    return "忙时";
            	} else{
                    return "未定义";
                }
            }},
		{field:'cityName',title:'所属城市',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.cityName;
		}},
        {field:'storeName',title:'所属门店',sortable:true,formatter:function(value,rowData,rowIndex){
                return rowData.storeName;
         }},
        {field:'startTime',title:'开始时间',sortable:true},
        {field:'endTime',title:'截止时间',sortable:true},
        <!--{field:'remark',title:'备注',sortable:true},-->
    ]],
    headerContextMenu: false,
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
	    title: '添加闲时忙时参数',
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/leisureBusy/create',
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
	    title: '修改闲时忙时参数',
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/leisureBusy/update/'+row.id,
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


//闲时忙时标志
$("#selcetLeisureBusyFlag").append("<option value=1>闲时</option>");
$("#selcetLeisureBusyFlag").append("<option value=2>忙时</option>");

var cityRows;
//所属城市
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
            editable:false ,
            animate:true
        });
        cityRows = (json.rows);
    }
});

//所属门店
var cityId;
$("#selectCity").combobox({ //选择城市的时候带门店出来\
    onChange : function(oldValue, newValue) {
        for ( var i = 0; i < cityRows.length; i++) {
            if ($("#selectCity").combobox('getValue') == cityRows[i].id) {
                cityId=cityRows[i].id;
            }
        }
        //storeAddList(cityId,"请选择");
        storeAddList(cityId,"");
    }
});

function storeAddList(obj,value){
    var url="${ctx}/system/store/getStoreByCityId?cityId="+obj;
    var storeId=value;
    if(obj!=null||obj!=""){
        //门店加载
        $.ajax({
            type: "GET",
            url: url,
            dataType:"json",
            success: function(json){
                $("#selectStore").combobox({
                    data:json.rows,
                    parentField : 'store',
                    valueField:'id',
                    value:storeId,
                    textField:'name',
                    iconCls: 'icon',
                    editable:false ,
                    animate:true
                });
            }
        });
    }
}

 
</script>
</body>
</html>