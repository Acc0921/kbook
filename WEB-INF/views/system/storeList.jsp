<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title></title>
    <%@ include file="/WEB-INF/views/include/easyui.jsp" %>
    <script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


</head>
<body style="font-family: '微软雅黑'">
<div id="tb" style="padding:5px;height:auto">
    <form id="searchFrom" action="">

        <input type="text" name="filter_LIKES_name" class="easyui-validatebox" data-options="width:150,prompt: '门店名称'"/>

        <input id="selectCity" type="text" class="easyui-combobox" name="filter_EQI_city.id"
               data-options="width:150,prompt: '城市名称'"/>

        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>


    </form>

    <shiro:hasPermission name="sys:store:add">
        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
        <span class="toolbar-item dialog-tool-separator"></span>
    </shiro:hasPermission>

    <shiro:hasPermission name="sys:store:update">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">修改</a>
        <span class="toolbar-item dialog-tool-separator"></span>
    </shiro:hasPermission> 

    <shiro:hasAnyRoles name="jituan_admin,admin">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="reg()">注册银联</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">门店配置</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="amap()">坐标配置</a>
	</shiro:hasAnyRoles >
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-standard-page-white-edit" plain="true" onclick="withdraw()">提现</a>
  
</div>
<table id="dg"></table>
<div id="dlg"></div>
<script type="text/javascript">
    var dg;
    $(function () {
        dg = $('#dg').datagrid({
            url: '${ctx}/system/store/json',
            fit: true,
            fitColumns: true,
            border: false,
            striped: true,
            singleSelect: true,
            idField: 'id',
            pagination: true,
            rownumbers: true,
            pageNumber: 1,
            pageSize: 30,
            pageList: [10, 20, 30, 40, 50],
            columns: [[
                {field: 'ck', checkbox: true},
                {field: 'id', title: 'id', hidden: true},
                {field: 'name', title: '门店名称', sortable: true},
                {field: 'address', title: '地址', sortable: true},
                {
                    field: 'city.name', title: '适用城市', sortable: true, formatter: function (value, rowData, rowIndex) {
                    return rowData.cityName;
                }
                },
                {
                    field: 'user.name', title: '前台人员', sortable: true, formatter: function (value, rowData, rowIndex) {
                    return rowData.userName;
                }
                },
                {field: 'discount', title: '打折', sortable: true},
                {
                    field: 'property', title: '标识', sortable: false, formatter: function (value, rowData, rowIndex) {
                    if (value == 2)
                        return "网店";
                    else
                        return "实体店";
                }
                },
                {field: 'gatewayId', title: '灯关光控制器网关', sortable: true},
                {field: 'bizUserId', title: '门店银联ID', sortable: true},
                {field: 'publicBizUserId', title: '公用会员银联ID', sortable: true},
                {field: 'lng', title: '经度', sortable: false},
                {field: 'lat', title: '纬度', sortable: false}
            ]],
            headerContextMenu: [
                {
                    text: "冻结该列", disabled: function (e, field) {
                    return dg.datagrid("getColumnFields", true).contains(field);
                },
                    handler: function (e, field) {
                        dg.datagrid("freezeColumn", field);
                    }
                },
                {
                    text: "取消冻结该列", disabled: function (e, field) {
                    return dg.datagrid("getColumnFields", false).contains(field);
                },
                    handler: function (e, field) {
                        dg.datagrid("unfreezeColumn", field);
                    }
                }
            ],
            enableHeaderClickMenu: true,
            enableHeaderContextMenu: true,
            enableRowContextMenu: false,
            rowTooltip: false,
            toolbar: '#tb'
        });
    });


    //弹窗增加
    function add() {

        d = $("#dlg").dialog({
            title: '添加门店',
            width: 580,
            height: 350,
            href: '${ctx}/system/store/create',
            maximizable: true,
            modal: true,
            buttons: [{
                text: '确认',
                handler: function () {
                    $("#mainform").submit();
                }
            }, {
                text: '取消',
                handler: function () {
                    d.panel('close');
                }
            }]
        });
    }

    //弹窗修改
    function upd() {
        var row = dg.datagrid('getSelected');
        if (rowIsNull(row)) return;

        d = $("#dlg").dialog({
            title: '修改门店',
            width: 580,
            height: 350,
            href: '${ctx}/system/store/update/' + row.id,
            maximizable: true,
            modal: true,
            buttons: [{
                text: '修改',
                handler: function () {
                    $('#mainform').submit();
                }
            }, {
                text: '取消',
                handler: function () {
                    d.panel('close');

                }
            }]
        });
    }

    //注册银联
    function reg() {
        var row = dg.datagrid('getSelected');
        if (rowIsNull(row)) return;
		
        //跳转页面
        window.location = '${ctx}/system/store/jumpRegisterType/' + row.id;
    }
    
  	//门店配置
    function edit() {
        var row = dg.datagrid('getSelected');
        if (rowIsNull(row)) return;
		
        //跳转页面
        window.location = '${ctx}/system/store/storeConfig/' + row.id;
    }
  	
  	//坐标配置
    function amap() {
        var row = dg.datagrid('getSelected');
        if (rowIsNull(row)) return;
		
        //跳转页面
        window.location = '${ctx}/system/store/setAmap/' + row.id;
    }
  	
  	//提现
    function withdraw(){
    	var row = dg.datagrid('getSelected');
        if (rowIsNull(row)) return;
        //跳转页面
        window.location = '${ctx}/system/store/withdraw?id=' + row.id;
  	}
    
    //创建查询对象并查询
    function cx() {
        var obj = $("#searchFrom").serializeObject();
        dg.datagrid('load', obj);
    }

    //适用城市
    $.ajax({
        type: "GET",
        url: "${ctx}/system/city/getAllJson",
        dataType: "json",
        success: function (json) {
            $("#selectCity").combobox({
                data: json.rows,
                parentField: 'city',
                valueField: 'id',
                textField: 'name',
                iconCls: 'icon',
                animate: true
            });
        }
    });

    $(document).ready(function () {
        document.onkeydown = function (event) {
            if (event.keyCode == 13) { // enter 键
                cx();
                return false;
            }
        };

    });


</script>
</body>
</html>