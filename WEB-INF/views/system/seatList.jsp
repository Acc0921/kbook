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
     	    <input type="text" name="filter_LIKES_name" class="easyui-validatebox" data-options="width:150,prompt: '座位名称'"/>
			<input id="selectCity" type="text" name="filter_EQI_city.id" data-options="width:150,prompt: '所属城市'"  class="easyui-combobox"/>
	        <input id="selectStore" type="text" name="filter_EQI_store.id" data-options="width:150,prompt: '所属门店'"  class="easyui-combobox"/>
			<input id="selectSeattype" type="text" name="filter_EQI_type.id" data-options="width:150,prompt: '座位类型'"  class="easyui-combobox"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
		</form>
		
        <shiro:hasPermission name="sys:seat:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:seat:update">
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
    url:'${ctx}/system/seat/json', 
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
		{field:'name',title:'座位名称',sortable:true},
		{field:'typeName',title:'座位类型',sortable:false},
		{field:'cityName',title:'所属城市',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.city.name;
		}},
        {field:'storeName',title:'所属门店',sortable:true,formatter:function(value,rowData,rowIndex){
                return rowData.store.name;
            }},
		{field:'description',title:'描述',sortable:true},
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
    rowTooltip: false,
    toolbar:'#tb'
	});
});



//弹窗增加
function add() {
	
	d=$("#dlg").dialog({   
	    title: '添加座位',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/seat/create',
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
	    href:'${ctx}/system/seat/update/'+row.id,
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

//edit:yangzh by 2018-04-29 start
/**
//座位类别
$.ajax({
   type: "GET",
   url: "${ctx}/system/seattype/json",
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
 **/

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
        //storeAdd(cityId,"请选择");
        storeAddList(cityId,"");
        seattypeAddList(cityId,"","");
    }
});

var storeRows;
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
                storeRows = (json.rows);
            }
        });
    }
}

var storeId;
$("#selectStore").combobox({ //选择城市和门店的时候带座位类型出来\
    onChange : function(oldValue, newValue) {
        for ( var i = 0; i < storeRows.length; i++) {
            if ($("#selectStore").combobox('getValue') == storeRows[i].id) {
                storeId=storeRows[i].id;
            }
        }
        //seattypeAddList(cityId,storeId,"");
    }
});


//座位类别
function seattypeAddList(cityId,storeId,value){
    //var url="${ctx}/system/seattype/getSeatTypeByCityIdAndStoreId?cityId="+cityId + "&storeId=" + storeId;
    var url="${ctx}/system/seattype/getSeatTypeByCityId?cityId="+cityId ;
    var seattypeId=value;
    //if(storeId!=null||storeId!=""){
        //座位类型加载
        $.ajax({
            type: "GET",
            url: url,
            dataType:"json",
            success: function(json){
                $("#selectSeattype").combobox({
                    data:json.rows,
                    parentField : 'seattype',
                    valueField:'id',
                    value:seattypeId,
                    textField:'name',
                    iconCls: 'icon',
                    editable:false ,
                    animate:true
                });
            }
        });

    //}
}

//edit:yangzh by 2018-04-29 end
 
 
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