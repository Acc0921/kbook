<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
<script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctx}/static/js/DateUtil.js" type="text/javascript"></script>
</head>
<body style="font-family: '微软雅黑'">
	<div id="tb" style="padding: 5px; height: auto">
		<form id="searchFrom" action="">
			<input type="text" name="filter_LIKES_orderNumber"
				class="easyui-validatebox" data-options="width:150,prompt: '订单编号'" />
			<input type="text" name="filter_EQD_orderDate" 
				class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt:'订单日期'"/>
			<input type="text" name="filter_LIKES_member.name"
				class="easyui-validatebox" data-options="width:150,prompt: '会员名称'" />
			
			
			<a href="javascript(0)" class="easyui-linkbutton"
				iconCls="icon-search" plain="true" onclick="cx()">查询</a>
			<span class="toolbar-item dialog-tool-separator"></span>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true" onclick="upd()">换位</a>
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-undo" plain="true" onclick="cxr()">清空</a> -->
		</form>
		

	</div>
	<table id="dg"></table>
	<div id="dlg"></div>
	<script type="text/javascript">
		var dg;
		$(function() {
			dg = $('#dg').datagrid(
					{
						url : '${ctx}/system/seatorder/json',
						fit : true,
						fitColumns : true,
						border : false,
						striped : true,
						singleSelect : true,
						idField : 'id',
						pagination : true,
						rownumbers : true,
						pageNumber : 1,
						pageSize : 30,
						pageList : [ 10, 20, 30, 40, 50 ],
						columns : [[
						    {field : 'ck',checkbox : true,hidden:true},
						    {field : 'id',title : 'id',hidden : true}, 
						    {field : 'orderNumber',title : '订单编号',sortable : true} , 
						    {field : 'memberName',title : '会员',sortable : false} , 
						    {field : 'orderDate',title : '订单日期',sortable : true}, 
						    {field : 'orderFromTime',title : '开始时间',sortable : true,formatter:function(value,row,index){
						    	return new Date(value).format("yyyy-MM-dd hh:mm:ss");
						    }}, 
						    {field : 'orderToTime',title : '结束时间',sortable : true,formatter:function(value,row,index){
						    	return new Date(value).format("yyyy-MM-dd hh:mm:ss");
						    }},
						    {field : 'seatPrice',title : '座位价格',sortable : true},
						    {field : "shopName",title : '门店名称',sortable : false},
						    {field : "seatName",title : '座位名称',sortable : false},
						    {field : "typeName",title : '座位类型',sortable : false,formatter:function(value,row,index){
						    	return row.seat.typeName;
						    }},
						    {field : "statusName",title : '状态',sortable : false}
						]],
						headerContextMenu : [
								{
									text : "冻结该列",
									disabled : function(e, field) {
										return dg.datagrid("getColumnFields",
												true).contains(field);
									},
									handler : function(e, field) {
										dg.datagrid("freezeColumn", field);
									}
								},
								{
									text : "取消冻结该列",
									disabled : function(e, field) {
										return dg.datagrid("getColumnFields",
												false).contains(field);
									},
									handler : function(e, field) {
										dg.datagrid("unfreezeColumn", field);
									}
								} ],
						enableHeaderClickMenu : false,
						enableHeaderContextMenu : false,
						enableRowContextMenu : false,
						rowTooltip : true,
						toolbar : '#tb'
					});
		});

		//弹窗修改
		function upd() {
			var row = dg.datagrid('getSelected');
			if (rowIsNull(row))
				return;
			
			/* if(row.status != 1){
				parent.$.messager.alert('提示','只有预定状态下才能更换');
				return ;
			} */
			d = $("#dlg").dialog({
				title : '更换位置',
				//width : 620,
				//height : 520,
                width : 800,
                height : 620,
				href : '${ctx}/system/seatorder/changepage/' + row.id+'/'+row.storeId,
				maximizable : true,
				modal : true,
				buttons : [ {
					text : '更换',
					handler : function() {
						changeCommit();
						//$('#mainform').submit();
					}
				}, {
					text : '取消',
					handler : function() {
						d.panel('close');
					}
				} ]
			});
		}

		//创建查询对象并查询
		function cx() {
			var obj = $("#searchFrom").serializeObject();

			dg.datagrid('load', obj);
		}
		// 清空
		function cxr() {
			var len = $("form>input").length;
			$("form input[name^='filter_']").each(function(i,obj){
			});
			$("form input[name^='filter_']").val('');
		}

		
		$(document).ready(function() {
			// 回车事件
			document.onkeydown = function(event) {
				if (event.keyCode == 13) { // enter 键
					cx();
					return false;
				}
			};

		});
	</script>
</body>
</html>