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
     	    <input type="text" name="filter_LIKES_cardid" class="easyui-validatebox" data-options="width:150,prompt: '实体会员卡号'"/>
     	    <input type="text" name="filter_LIKES_wxcode" class="easyui-validatebox" data-options="width:150,prompt: '微信会员卡号'"/>
     	    <input type="text" name="filter_LIKES_wechat" class="easyui-validatebox" data-options="width:150,prompt: '微信号'"/>
	       	<input type="text" name="filter_LIKES_school" class="easyui-validatebox" data-options="width:150,prompt:'所属学校'"/>
	       	<br />
			<input type="text" name="filter_LIKES_account" class="easyui-validatebox" data-options="width:150,prompt: '会员账号'"/>
	       	<input type="text" name="filter_LIKES_position" class="easyui-validatebox" data-options="width:150,prompt: '职位'"/>
	       	<input type="text" name="filter_LIKES_target" class="easyui-validatebox" data-options="width:150,prompt:'主要目标'"/>
	       	<input type="text" name="filter_GED_createdTs" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width:150,prompt:'建档日期'"/>
	       	
	        <a href="javascript(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="cx()">查询</a>
	         <!-- <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-standard-page-excel" onclick="exportExcel(0)">导出本页到Excel</a> -->
	        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-standard-page-excel" onclick="exportExcel(1)">导出到Excel</a>
		</form>
		
        <shiro:hasPermission name="sys:member:add">
       		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add()">添加</a>
       		<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
       	
       	<shiro:hasPermission name="sys:member:update">
        	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="upd()">修改</a>
	    	<span class="toolbar-item dialog-tool-separator"></span>
        </shiro:hasPermission>
        
        <shiro:hasPermission name="sys:productOrder:add">
       		<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="buy()">购买</a>
       		<span class="toolbar-item dialog-tool-separator"></span>
       	</shiro:hasPermission>
		<shiro:hasPermission name="sys:memberProduct:view">
			<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="viewProductOrder()">产品信息</a>
			<span class="toolbar-item dialog-tool-separator"></span>
		</shiro:hasPermission>
    </div>
<table id="dg"></table> 
<div id="dlg"></div>
<div id="ask" style="padding:10px" ><h3>亲，是否直接购买产品？</h3></div>  
<script type="text/javascript">
var enterEvent = false;
var dg;
$(function(){   
	dg=$('#dg').datagrid({    
    url:'${ctx}/system/member/json', 
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
		{field:'name',title:'会员名称',sortable:true},
		{field:'account',title:'会员账号',sortable:true},
		{field:'balance',title:'点数',sortable:false},
		{field:'productName',title:'产品名称',sortable:false},
		{field:'sex',title:'性别',sortable:true,
        	formatter : function(value, row, index) {
       			return value==1?'男':'女';
        	}
        },
		{field:'wechat',title:'微信',sortable:true},
		{field:'tel',title:'联系电话',sortable:true},
		{field:'emgergencycontact',title:'紧急联系人',sortable:true},
		{field:'bizUserId', title: '会员银联ID', sortable: true},
		{field:'cardid',title:'实体会员卡号',sortable:true},
		{field:'wxcode',title:'微信会员卡号',sortable:true},
		{field:'code',title:'微信会员卡号激活状态',sortable:true,
			formatter : function(value, row, index) {
				var operatorname;
				if(row.code == null){
					operatorname = "未激活";
				}else{
					operatorname = "已激活";
				}
   			return operatorname;
			}
    	},
		{field:'address',title:'联系地址',sortable:true},
		/* fix tag 2015年11月10日 by Gavin --- begin */
		{field:'career',title:'职业',sortable:true,
			formatter: function(value, row, index){
					if(value =="1"){
						return '自由';
					}
					if(value =="2"){
						return '学生';
					}
					if(value =="3"){
						return '在职';
					}
					return '自由';
			}	
		
		},
		{field:'grade',title:'年级',sortable:true,
			formatter: function(value,row, index){
				if(row.career =="1" || row.career =="3"){
					return "";
				}
				else if(row.career =="2"){
					return row.grade;
				}else{
                    return row.grade;
				}
				
			}		
		},
		{field:'company',title:'公司',sortable:true,
			formatter: function(value,row, index){
				if(row.career =="1" || row.career =="2"){
					return "";
				}
				else if(row.career =="3"){
					return row.company;
				}else{
                    return row.company;
				}
				
			}		
		},
		{field:'position',title:'职位',sortable:true,
			formatter: function(value,row, index){
				if(row.career =="1" || row.career =="2"){
					return "";
				}
				else if(row.career =="3"){
					return row.position;
				}else{
                    return row.position;
				}
			}
		},
		{field:'target',title:'主要目标',sortable:true},
		{field:'channel',title:'用户来源',sortable:true},
	 	/* fix tag 2015年10月29日 by Gavin --- begin */
		{field:'operatorname',title:'操作员',sortable:true,
			formatter : function(value, row, index) {
				var operatorname;
				if(row.updatedBy == null){
					operatorname = null;
				}else{
					operatorname = row.updatedBy.name;
				}
   			return operatorname;
			}
    	},
		{field:'createdTs',title:'建档日期',sortable:true,formatter:function(value,rowData,rowIndex){   
			return value.split(" ",1);
		
		} },
		/* fix tag 2015年10月29日 by Gavin --- end */
		{field:'remark',title:'备注',sortable:true},
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
	enterEvent = true;
	d=$("#dlg").dialog({   
	    title: '添加会员',    
	    width: 550,    
	    height: 480,    
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
		}],
		onClose:function(){
     		enterEvent = false;
    	}
	});
}

//弹窗修改
function upd(){
	enterEvent = true;
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '修改会员',    
	    width: 550,    
	    height: 480,    
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
		}],
		onClose:function(){
     		enterEvent = false;
    	}
	});
}

//购买
function buy() {
	var row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '购买产品',    
	    width: 580,    
	    height: 350,    
	    href:'${ctx}/system/productOrder/create?flag=1&memberId='+row.id,
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

//产品信息
function viewProductOrder(){
    var row = dg.datagrid('getSelected');
    if(rowIsNull(row)) return;

    var parent$ = self.parent.$;
    //判断是否重复，如果重复，则跳转到当前tab
    var t = parent.$('#mainTabs');
    var title = "产品信息";
    var href= '${ctx}/system/memberProduct/doList/'+row.id ;
    var  tabs = t.tabs("tabs");
    var array = $.array.map(tabs, function(val) {
        return val.panel("options");
    });
    var list = $.array.filter(array, function(val) {
        return val.title == title;
    });
    var ret = list.length ? 1 : 0;
    if (ret && $.array.some(list, function(val) {
            return val.href == href;
        })) {
        ret = 2;
    }

    if(ret != 0) {
        t.tabs("close", title);
    }

    if (parent$('#mainTabs').tabs('exists', title)){
        parent$('#mainTabs').tabs('select', title);
    } else {
		parent$('#mainTabs').tabs('add',{
			title: title,
			href: href ,
			closable:true,
            cache:false
		})
	}
}

var searchDatas;
//创建查询对象并查询
function cx(){
	searchDatas = [];
	var obj=$("#searchFrom").serializeObject();
	
	dg.datagrid('load',obj); 
	dg.datagrid({url:'${ctx}/system/member/json'});
	searchDatas = JSON.stringify($("#searchFrom").serializeArray());	
}

$(document).ready(function (){
	searchDatas = JSON.stringify($("#searchFrom").serializeArray());
	document.onkeydown=function(event){ 
     	if(event.keyCode == 13 && enterEvent == false){ // enter 键
     		cx();
     		return false;
    	}
	}; 

});

//导出excel
function exportExcel(type){
		
		try{
		var pageNo = 1;
		var pageSize = 30;
		var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
		pageNo = pageopt.pageNumber;
		pageSize = pageopt.pageSize;
	
		var opts = $('#dg').datagrid('getColumnFields'); //这是获取到所有的FIELD
		var colName=[];
		var colField=[];
		var currDatas=[];
		for(i=0;i<opts.length;i++)
		{
			var col = $('#dg').datagrid( "getColumnOption" , opts[i] );
			var headField = col.title;
			if(headField != undefined){
				colName.push(col.title);//把TITLEPUSH到数组里去
				colField.push(col.field);

			}
		}
		var rows = $('#dg').datagrid('getRows');
		for(var key in rows){
			if(rows[key].id != undefined){
            	currDatas.push(rows[key]);
            }
        }  
        
        var searchDatas = JSON.stringify($("#searchFrom").serializeArray());
        
			 var form = $("<form>");
	 			form.attr('style','display:none');
	 			form.attr('target','');
	 			form.attr('method','post');
	 			form.attr('action','${ctx}/system/member/exportExcel');
	 			
	 			var input0 = $('<input>');
	 				input0.attr('type','hidden');
					 input0.attr('name','title');
					 input0.attr('value', '会员信息');	 
	 
	 			var input1 = $('<input>');
	 				input1.attr('type','hidden');
	 				input1.attr('name','headers');
	 				input1.attr('value',colName);

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