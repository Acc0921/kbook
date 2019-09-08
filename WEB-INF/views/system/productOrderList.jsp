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
     	    
     	    <input id="selectMembers" type="text" name="filter_LIKES_member.name" data-options="width:150,prompt: '会员名称'"  class="easyui-validatebox"/>
     	    <input id="selectMemberAccount" type="text" name="filter_LIKES_member.account" data-options="width:150,prompt: '会员账号'"  class="easyui-validatebox"/>
     	    <input type="text" name="filter_LIKES_productName" class="easyui-validatebox" data-options="width:150,prompt: '产品名称'"/>
     	    <input id="producttype" type="text" name="filter_EQI_type" class="easyui-combobox" data-options="width:150,prompt: '产品类别'  "/>
     	    
     	    <input type="text" name="filter_GED_effectiveFromDate" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt: '生效日期(范围之内)'"/>
     	    <br />
     	    <input type="text" name="filter_GED_effectiveToDate" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt: '失效日期(范围之内)'"/>
     	    <input id ="selcetstatue" type="text" name="filter_EQI_status" class="easyui-combobox" data-options="width:150,prompt: '状态'"/>
     	    <input type="text" name="filter_LIKES_orderNumber" class="easyui-validatebox" data-options="width:150,prompt: '订单编号'"/>

     	    <input type="text" style="display:none;" name="filter_LED_effectiveToDate" class="easyui-validatebox" data-options="width:150,prompt: '失效日期  yyyy-MM-dd'"/>
			<!--add:yangzh by 2018-04-16 start -->
			<td><select id="selectCity" name="filter_EQI_city.id" data-options="width:150,prompt: '城市名称'">
				<option value=""></option>
			</select>
			</td>
			<td style="display:none;" id="test">${store.storeId}</td>
			<input id="selectStore" type="text" name="filter_EQI_store.id" class="easyui-validatebox" data-options="width:150,prompt: '门店名称'"/>
			<!--add:yangzh by 2018-04-16 end -->
			<a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
	        
	        <!-- <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-standard-page-excel" onclick="exportExcel(0)">导出本页到Excel</a> -->
	        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-standard-page-excel" onclick="exportExcel(1)">导出到Excel</a>
		</form>
		
        <shiro:hasPermission name="sys:productOrder:add">
       	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">购买</a>
       	<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:productOrder:update">
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
    url:'', 
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
    toolbar:'#tb'
	});
});



//弹窗增加
function add() {
	
	d=$("#dlg").dialog({   
	    title: '购买产品',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/productOrder/create?flag=0',
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

//弹窗修改
function upd(){
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '修改订单',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/productOrder/update/'+row.id,
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
	dg.datagrid({url:'${ctx}/system/productOrder/json'});
}


$(document).ready(function (){
	document.onkeydown=function(event){ 
     	if(event.keyCode == 13){ // enter 键
     		cx();
     		return false;
    	}
	}; 

});

/*//会员
$.ajax({
   type: "GET",
   url: "${ctx}/system/members/getAllJson",
   dataType:"json",
   success: function(json){
     $("#selectMembers").combobox({
 		data:json.rows,
 		parentField : 'memebrs',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
    	animate:true
 	});
   }
 });*/

 //状态
$("#selcetstatue").append("<option value=1>订单生效</option>");
$("#selcetstatue").append("<option value=0>订单失效</option>");
//产品类别
$("#producttype").append("<option value=1>储值卡</option>");
$("#producttype").append("<option value=2>包天卡</option>");

//add:yangzh by 2018-04-16 start
var sID=$("#test").html();
$(document).ready(function(){
    var city=$("#selectCity").val();
    $("#selectStore").combobox();
    if(city!=""){
        if(sID!=""){
            storeAdd(city,sID);
        }else{
            storeAdd(city,1);
        }
    }

});

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
        storeAdd(cityId,"");
    }
});

function storeAdd(obj,value){
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

//add:yangzh by 2018-04-16 end

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
	 			form.attr('action','${ctx}/system/productOrder/exportExcel');
	 			
	 			var input0 = $('<input>');
	 				input0.attr('type','hidden');
					 input0.attr('name','title');
					 input0.attr('value', '产品订单信息');	 
	 
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