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
	        
	        <input type="text" name="filter_LIKES_member.name" class="easyui-validatebox" data-options="width:150,prompt: '会员名'"/>
	        <input id="selectStore" type="text" name="filter_EQI_seat.store.id" data-options="width:150,prompt: '所属门店'"  class="easyui-combobox"/>
		     
		    <input type="text" name="filter_GED_orderDate" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt: '订单日期（范围开始）'"/>
		  - <input type="text" name="filter_LED_orderDate" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt: '订单日期（范围结束）'"/>
		 	<input type="text" name="filter_LIKES_orderNumber" class="easyui-validatebox" data-options="width:150,prompt: '订单号'"/>
		 	<input type="text" name="filter_EQS_seat.name" class="easyui-validatebox" data-options="width:150,prompt: '座位号'"/>
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a> 
		</form>      
		 
		<shiro:hasPermission name="sys:memberSeatOrder:update">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">备注</a>
	    <span class="toolbar-item dialog-tool-separator"></span> 
        </shiro:hasPermission>
		<shiro:hasPermission name="sys:memberSeatOrder:update">
        	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-standard-page-white-edit" plain="true" id="settlement">结账</a>
	    <span class="toolbar-item dialog-tool-separator"></span>
        </shiro:hasPermission>
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-standard-page-excel" onclick="exportExcel(1)">导出Excel</a>
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
    url:'', 
    fit : true,
	fitColumns : true,
	border : false,
	striped:true,
	singleSelect:true,
	idField : 'id',
	pagination:true,
	rownumbers:true,
	/* fix tag 20151027 by Gavin --- begin */	
	sortName:'actualCheckInTime',
	sortOrder:'desc',
	/* fix tag 20151027 by Gavin --- end */
	pageNumber:1,
	pageSize : 30,
	pageList : [ 10, 20, 30, 40, 50 ],
    columns:[[    
		{field:'id',title:'id',hidden:true},  
		
		{field:'memberName',title:'会员名',sortable:false, formatter:function(value,rowData,rowIndex){
			return rowData.member.name; 
		}},
		{field:'memberAccount',title:'会员账号',sortable:false, formatter:function(value,rowData,rowIndex){
			return rowData.member.account; 
		}},
		{field:'orderDate',title:'订单日期',sortable:true, formatter:function(value,rowData,rowIndex){   
			return new Date(value).format("yyyy-MM-dd"); 
		}},
		{field:'orderFromTime',title:'开始时间',sortable:true, formatter:function(value,rowData,rowIndex){   
			return new Date(value).format("HH:mm:ss"); 
		}},
		{field:'orderToTime',title:'结束时间',sortable:true, formatter:function(value,rowData,rowIndex){   
			return new Date(value).format("HH:mm:ss"); 
		}},
		{field:'shopName',title:'门店',sortable:true, formatter:function(value,rowData,rowIndex){
			//return rowData.seat.store.name;
			if(value != null)
				return value;
		}},
		{field:'seat',title:'座位',sortable:true,formatter: function(value,row,index){
           if (value.name){
            	return value.name;
           } else {
            	return value;
           }
		}},  
		{field:'seatPrice',title:'座位单价',sortable:true},
		{field:'productDiscount',title:'产品折扣',sortable:true},
		{field:'storeDiscount',title:'门店折扣',sortable:true},
		{field:'actualCheckInTime',title:'实际签到时间',sortable:true, formatter:function(value,rowData,rowIndex){   
			if(rowData.actualCheckInTime!=null){
				return new Date(value).format("yyyy-MM-dd HH:mm:ss"); 
			}else{
				return '--';
			}
			
		}},
		{field:'actualCheckOutTime',title:'实际结帐时间',sortable:true, formatter:function(value,rowData,rowIndex){   
			
			if(rowData.actualCheckOutTime!=null){
				return new Date(value).format("yyyy-MM-dd HH:mm:ss"); 
			}else{
				return '--';
			}
			
		}},
		{field:'estimatedPayment',title:'预计支付点数',sortable:true},
		{field:'actualPayment',title:'实际支付点数',sortable:true},
		{field:'status',title:'状态',sortable:true, formatter:function(value,rowData,rowIndex){   
			var retVal = "";
			var intVal = parseInt(value);
			switch (intVal) {
			case 1:
				retVal = "下单"
				break;
			case 2:
				retVal = "签到"
				break;
			case 3:
				retVal = "请假"
				break;
			case 4:
				retVal = "完成"
				break;
			case 5:
				retVal = "取消"
				break;
			case 6:
				retVal = "缺席"
				break;
			default:
				break;
			} 
			
			return retVal;
		}},
		{field:'remark',title:'备注',sortable:true},
		{field:'orderNumber',title:'订单号',sortable:true},
		{field:'updatedBy',title:'更新操作员',sortable:true, formatter:function(value,rowData,rowIndex){   
			if(value != null)
				return value.name; 
		}},
		{field:'updatedTs',title:'更新时间',sortable:false, formatter:function(value,rowData,rowIndex){   
			
			if(rowData.updatedTs!=null){
				return new Date(value).format("yyyy-MM-dd HH:mm:ss"); 
			}else{
				return '--';
			}
			
		}}
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
 
//弹窗修改
function upd(){
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '备注订单',    
	    width: 380,    
	    height: 400,    
	    href:'${ctx}/system/memberSeatOrder/update/'+row.id,
	    maximizable:true,
	    modal:true,
	    buttons:[{
			text:'备注',
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
	dg.datagrid({url:'${ctx}/system/memberSeatOrder/json'});
}


$(document).ready(function (){
	document.onkeydown=function(event){ 
     	if(event.keyCode == 13){ // enter 键
     		cx();
     		return false;
    	}
	}; 

	$('#settlement').click(function(){
			var row = dg.datagrid('getSelected');
			if(rowIsNull(row)) return;
			if(row.status == 2 || row.status == 3){
				d=$("#dlg").dialog({   
				    title: '结账',    
				    width: 380,    
				    height: 300,    
				    href:'${ctx}/system/memberSeatOrder/settlementop/'+row.id +'/'+ row.orderFromTime ,
				    maximizable:false,
				    modal:true,
				    buttons:[{
						text:'结账',
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
			}else{
				$.messager.alert("提示", "只能对入座未结账的订单进行操作。","warning");
			}
	});
});

//导出excel
function exportExcel(type){
		
		try{
		var pageNo = 1;
		var pageSize = 30;
		var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
		pageNo = pageopt.pageNumber;
		pageSize = pageopt.pageSize;
		
		//alert(pageNo +" - "+ pageSize);

		var opts = $('#dg').datagrid('getColumnFields'); //这是获取到所有的FIELD
		var colName=[];
		var colField=[];
		var currDatas=[];
		for(i=0;i<opts.length;i++)
		{
			var col = $('#dg').datagrid( "getColumnOption" , opts[i] );
			var headField = col.title;
			if(headField != undefined){
				//alert(col.field);
				colName.push(col.title);//把TITLEPUSH到数组里去
				colField.push(col.field);

			}
		}
		var rows = $('#dg').datagrid('getRows');
		//alert(JSON.stringify(rows));
		for(var key in rows){
			if(rows[key].id != undefined){
            	currDatas.push(rows[key]);
            }
        }  
        
        var searchDatas = JSON.stringify($("#searchFrom").serializeArray());
		 //var url = "${ctx}/system/members/exportExcel?hearders='"+ colName +"'&fields=''"+colField +"'";
		  //window.location.href = url;
			 var form = $("<form>");
	 			form.attr('style','display:none');
	 			form.attr('target','');
	 			form.attr('method','post');
	 			form.attr('action','${ctx}/system/memberSeatOrder/exportExcel');
	 			
	 			var input0 = $('<input>');
	 				input0.attr('type','hidden');
					 input0.attr('name','title');
					 input0.attr('value', '会员消费报表');	 
	 
	 			var input1 = $('<input>');
	 				input1.attr('type','hidden');
	 				input1.attr('name','headers');
	 				input1.attr('value',colName);

				//alert(colField);
	 			var input2 = $('<input>');
	 				input2.attr('type','hidden');
					 input2.attr('name','fields');
					 input2.attr('value',colField);
				
				var input3 = $('<input>');
	 				input3.attr('type','hidden');
					 input3.attr('name','datas');
					 input3.attr('value', JSON.stringify(rows));
					
				var input4 = $('<input>');
	 				input4.attr('type','hidden');
					 input4.attr('name','searchDatas');
					 input4.attr('value', searchDatas);	 				

				var input5 = $('<input>');
	 				input5.attr('type','hidden');
					 input5.attr('name','all');
					 input5.attr('value', type); 				

				 $('body').append(form);
				 form.append(input0);
				 form.append(input1);
				 form.append(input2);
				 form.append(input3);
				 form.append(input4);
				 form.append(input5);

				 form.submit();
				 form.remove();   
		}catch(e){
			alert(e);
		}
}
</script>
</body>
</html>