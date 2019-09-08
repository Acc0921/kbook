<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
<script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

</head>
<body style="font-family: '微软雅黑'">
<div id="tb1" style="padding:5px;height:auto">
		<form id="searchFrom" action="">
            <!--
			<a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
			--> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editBalance()">修改点数</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="buy()">购买产品</a>
		</form>
    </div> 
<table id="dg"></table>
<div id="dlg"></div>
<script type="text/javascript">
var dg;
$(function(){
	dg=$('#dg').datagrid({
    url: '${ctx}/system/memberProduct/json/' + ${memberId} ,
    sortOrder: 'desc',
    sortName: 'id',
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
		
		{field:'memberName',title:'会员名称',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.member.name;  
		}},  
		{field:'memberAccount',title:'会员账号',sortable:true,formatter:function(value,rowData,rowIndex){
		    return rowData.member.account;  
		}},  
		{field:'productName',title:'产品名称',sortable:true},
		{field:'type',title:'产品类型',sortable:true,formatter:function(value,rowData,rowIndex){   
		   if(rowData.type==1){
		   		return "储值卡";
		   } else if(rowData.type==2){
		   		return "包天卡";
		   } else{
		   		return "其他";
		   }
		}},     
		{field:'consumerType',title:'消费类型',sortable:true},
		{field:'effectiveFromDate',title:'有效日期',sortable:true},
		{field:'effectiveToDate',title:'失效日期',sortable:true},
		{field:'actualValue',title:'储值金额',sortable:true},
		{field:'consumeValue',title:'实际消费点数',sortable:true},
		{field:'balance',title:'可用点数',sortable:true},
		{field:'discount',title:'折扣',sortable:true},
		{field:'limitHour',title:'N小时封顶',sortable:true},
		<!-- edit:yangzh by 2018-04-16 start-->
    	<!-- {field:'status',title:'状态',sortable:true},-->
        {field:'status',title:'状态',sortable:true, formatter: function(value, row, index){
                if(value =="1"){
                    return '订单生效';
                }
                if(value =="0"){
                    return '订单失效';
                }
                return '未定义';
            }
		},
        {
            field: 'storeName', title: '所属门店', sortable: true, formatter: function (value, rowData, rowIndex) {
                return rowData.storeName;
            }
        },
        {
            field: 'cityName', title: '所属城市', sortable: true, formatter: function (value, rowData, rowIndex) {
                return rowData.cityName;
            }
        },
        <!-- edit:yangzh by 2018-04-16 end-->

		{field:'orderNumber',title:'订单编号',sortable:true},
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
    toolbar:'#tb1'
	});
});


//弹窗修改
function editBalance(){
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d1=$("#dlg").dialog({
	    title: '修改余额',
	    width: 580,    
	    height: 350,
        href:'${ctx}/system/memberProduct/update?flag=1&memberId='+row.memberId + '&productOrderId=' + row.id,
	    maximizable:true,
	    modal:true,
        cache: false,
	    buttons:[{
            id:'b',
			text:'修改',
			handler:function(){
				//$('#mainform').submit();
                editBalanceCommit();
			}
		},{
			text:'取消',
			handler:function(){
					d1.panel('close');
				}
		}],
        onClose: function () {
            var formLen=$("#mainform").length;
            var mainform = $("#mainform");
            if(formLen>0){
                for(var i=0; i<formLen;i++){
                    $(mainform[i]).remove();
                }
            }
        }
	});
}

//购买
function buyProductOrder() {
    //edit:yangzh by 2018-08-26 start 产品信息功能中不需要选中会员产品记录就可以购买产品
    //var row = dg.datagrid('getSelected');
    //if(rowIsNull(row)) return;
	console.log("${memberId}");
    //var hrefUrl='${ctx}/system/memberProduct/create?flag=1&memberId='+row.memberId + '&productOrderId=' + row.id;
    var hrefUrl='${ctx}/system/memberProduct/create?flag=1&memberId='+${memberId};
    //edit:yangzh by 2018-08-26 end 产品信息功能中不需要选中会员产品记录就可以购买产品
    d1=$("#dlg").dialog({
        title: '购买产品',
        width: 580,
        height: 350,
        href:hrefUrl,
        maximizable:true,
        modal:true,
        cache: false,
        buttons:[{
            id:'b',
            text:'购买',
            handler:function(){
                //$('#mainform').submit();
                buyProductOrderCommit();
            }
        },{
            text:'取消',
            handler:function(){
                d1.panel('close');
            }
        }],
        onClose: function () {
            var formLen=$("#mainform").length;
            var mainform = $("#mainform");
            if(formLen>0){
                for(var i=0; i<formLen;i++){
                    $(mainform[i]).remove();
                }
            }
        }
    });
    //$('#dlg').dialog('refresh',hrefUrl);
}

//购买
function buy() {
	d=$("#dlg").dialog({   
	    title: '购买产品',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/productOrder/create?flag=1&memberId='+${memberId},
	    maximizable:true,
	    modal:true,
	    buttons:[{
	    		id:'b',
			text:'确认',
			handler:function(){
				$("#mainform").submit(); 
				$("#b").linkbutton('disable');
			}
		},{
			text:'取消',
			handler:function(){
					d.panel('close');
				}
		}]
	});
}

$(document).ready(function (){
	document.onkeydown=function(event){ 
     	if(event.keyCode == 13){ // enter 键
     		//cx();
     		return false;
    	}
	}; 

});

</script>
</body>
</html>