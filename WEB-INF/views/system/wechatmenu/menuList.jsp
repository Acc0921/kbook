<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
</head>
<body class="easyui-layout" style="font-family: '微软雅黑'">
	<div data-options="region:'west',split:true,border:false,title:'第一级菜单列表'"  style="width: 600px">
		<table id="menuDg" style="padding:5px;height:auto">
		    <div>
		    	<shiro:hasPermission name="sys:perm:add">
		    	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add(0)">添加</a>
		    	<span class="toolbar-item dialog-tool-separator"></span>
		    	</shiro:hasPermission>
		        <shiro:hasPermission name="sys:perm:delete">
		        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="del()">删除</a>
		        <span class="toolbar-item dialog-tool-separator"></span>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:perm:update">
		        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="upd()">修改</a>
		        <span class="toolbar-item dialog-tool-separator"></span>
		        </shiro:hasPermission>
		    </div>
		</table>
    </div>   
    <div data-options="region:'center',split:true,border:false,title:'第二级菜单列表'">
    	<shiro:hasRole name="admin">
    	<div id="tg_tb" style="padding:5px;height:auto">
		    <div>
		    	<shiro:hasPermission name="sys:perm:add">
		    	<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="add(-1)">添加</a>
		    	<span class="toolbar-item dialog-tool-separator"></span>
		    	</shiro:hasPermission>
		        <shiro:hasPermission name="sys:perm:delete">
		        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="del(-1)">删除</a>
		        <span class="toolbar-item dialog-tool-separator"></span>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="sys:perm:update">
		        <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="upd(-1)">修改</a>
		        <span class="toolbar-item dialog-tool-separator"></span>
		        </shiro:hasPermission>
				<a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="pub()">发布</a>
		        
		    </div>
		</div>
		</shiro:hasRole>
    	<table id="dg"></table>
    </div>   
<div id="dlg"></div> 
<div id="icon_dlg"></div>  

<script type="text/javascript">
var dg;
var d;
var menuDg;
var menuId=0;
var parentPermId;
$(function(){   
	menuDg=$('#menuDg').datagrid({  
	method: "get",
    url:'${ctx}/system/wechatmenu/json', 
    fit : true,
	fitColumns : true,
	border : false,
	idField : 'id',
	treeField:'name',
	iconCls: 'icon',
	animate:true, 
	rownumbers:true,
	singleSelect:true,
	striped:true,
	nowrap:false,
	fitColumns:true,
    columns:[[    
        {field:'id',title:'id',hidden:true},    
        {field:'name',title:'名称',width:100},
        {field:'type',title:'类型',width:100,
        	formatter: function(value, rowData, rowIndex){
        		if(value == 'view')
        			return '跳转URL界面';
        		else
        			return '发送消息事件';
			}
		},
        {field:'url',title:'跳转URL',width:100},
        {field:'key',title:'消息事件',width:100}
    ]],
    enableHeaderClickMenu: false,
    enableHeaderContextMenu: false,
    enableRowContextMenu: false,
    dataPlain: true,
    onClickRow:function(index, row){
    	menuId=row.id;
    	parentPermId=row.id;
    	dg.datagrid('reload',{id:menuId});
    },
	});
	
	dg=$('#dg').datagrid({   
	method: "get",
	url:'${ctx}/system/wechatmenu/subs',
    fit : true,
	fitColumns : true,
	border : false,
	idField : 'id',
	iconCls: 'icon',
	animate:true, 
	rownumbers:true,
	singleSelect:true,
	striped:true,
    columns:[[    
        {field:'id',title:'id',hidden:true},    
        {field:'name',title:'名称',width:100},
        {field:'type',title:'类型',width:100,
        	formatter: function(value, rowData, rowIndex){
        		if(value == 'view')
        			return '跳转URL界面';
        		else
        			return '发送消息事件';
			}
		},
        {field:'url',title:'跳转URL',width:100},
        {field:'key',title:'消息事件',width:100}
    ]],
    toolbar:'#tg_tb',
    dataPlain: true
	});
	
});

//弹窗增加
function add(pid) {
	if(pid == -1 ){
		if(menuId == 0){
			parent.$.messager.show({ title : "提示",msg: "请选一级菜单数据！", position: "bottomRight" });
			return;
		}
		
		pid = menuId;
	}
	d=$('#dlg').dialog({    
	    title: '添加菜单',    
	    width: 450,    
	    height: 300,    
	    closed: false,    
	    cache: false,
	    maximizable:true,
	    resizable:true,
	    href:'${ctx}/system/wechatmenu/create?pid='+ pid,
	    modal: true,
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

//删除
function del(id){
	var row = menuDg.datagrid('getSelected');
	if(id == -1){
		row = dg.datagrid('getSelected');
	}
	if(rowIsNull(row)) return;
	parent.$.messager.confirm('提示', '删除后无法恢复您确定要删除？', function(data){
		if (data){
			$.ajax({
				type:'get',
				url:"${ctx}/system/wechatmenu/delete/"+row.id,
				success: function(data){
					
						if(id == -1){
						if(successTip(data,dg))
							dg.treegrid('reload');
						}else{
							if(successTip(data,menuDg)){
			    			menuDg.treegrid('reload');
			    		}
			    	}
				}
			});
			//dg.datagrid('reload'); //grid移除一行,不需要再刷新
		} 
	});

}

//修改
function upd(id){
	var row = menuDg.datagrid('getSelected');
	if(id == -1)
		row = dg.datagrid('getSelected');
	if(rowIsNull(row)) return;
	d=$("#dlg").dialog({   
	    title: '修改权限',    
	    width: 450,    
	    height: 300,    
	    href:'${ctx}/system/wechatmenu/update/'+row.id,
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

function ajaxLoading(){
    $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");
    $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
}
function ajaxLoadEnd(){ 
     $(".datagrid-mask").remove(); 
     $(".datagrid-mask-msg").remove();             
} 
//发布菜单到微信公众号
function pub(){
	$.ajax({
		type:'get',
		url:"${ctx}/system/wechatmenu/pub",
		beforeSend:ajaxLoading,
		success: function(data){
			ajaxLoadEnd();//任务执行成功，关闭进度条
			if(data=='success'){
				parent.$.messager.show({ title : "提示",msg: "操作成功！", position: "bottomRight" });
			} else{
				parent.$.messager.alert('提示',data);
			} 
		}
	});
}
</script>
</body>
</html>