<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/store/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>门店名称：</td>
			<td>
			<c:if test="${action.equals('update')}">
				<input type="hidden" name="bizUserId" value="${store.bizUserId}"/>
				<input type="hidden" name="unionId" value="${store.unionId}"/> 
				<input type="hidden" name="id" value="${store.id }" />
			</c:if>
			<input id="name" name="name" type="text" value="${store.name }" class="easyui-validatebox" data-options="width: 150,required:'required'"/>
			</td>
		</tr>
		<tr>
			<td>公用会员bizUserId：</td>
			<td>
			<input id="publicBizUserId" name="publicBizUserId" type="text" value="${store.publicBizUserId}" class="easyui-validatebox" data-options="width: 150"/>
			</td>
		</tr>
		<tr>
			<td>门店地址：</td>
			<td>
			<input id="address" name="address" type="text" value="${store.address}" class="easyui-validatebox" data-options="width: 150,required:'required'"/>
			</td>
		</tr>
		<tr>
			<td>所在城市:</td>
			<td>
				<input id="city" name="city.id" value="${store.cityId}" class="easyui-validatebox" data-options="width: 150"/>
			</td>
		</tr>
		<tr> 
			<td>门店标识:</td>
			<td>
				<select id="cc" class="easyui-combobox" name="property" style="width:150px;">
				    <option value="1" ${store.property == 1?"selected":"" }>实体店</option>
				    <option value="2" ${store.property == 2?"selected":"" }>网店</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>前台人员:</td>
			<td><input id="user" name="user.id" value="${store.userId}" data-options="width: 150" /></td>
		</tr>
<%-- 		<tr>
			<td>打折：</td>
			<td><input id="discount" name="discount" value="${store.discount}" class="easyui-validatebox" data-options="width: 150" />(例:0.8)</td>
		</tr> --%>
		<tr>
			<td>灯光控制器网关：</td>
			<td><input id="gatewayId" name="gatewayId" value="${store.gatewayId}" class="easyui-validatebox" data-options="width: 150" /></td>
			</tr>
		<tr style="display:none;">
			<td>禁用：</td>
			<td>
				<input type="radio" id="activated" name="activated" value="1" checked="checked"/><label for="activated">可用</label>
				<input type="radio" id="noactivate" name="activated" value="0"/><label for="noactivate">禁用</label>
			</td>
		</tr>
	</table>
	</form>
</div>
<script type="text/javascript">
var action="${action}";
//用户 添加修改区分
 if(action=='update'){
	$("input[name='name']").attr('readonly','readonly');
	$("input[name='name']").css('background','#eee');
	$("input[name='city']").attr('readonly','readonly');
	$("input[name='city']").css('background','#eee');
	
}


$(function(){
	$('#mainform').form({    
	    onSubmit: function(){    
	    	var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
	    },    
	    success:function(data){   
	    	successTip(data,dg,d);
	    }    
	}); 

});

//适用城市

 $.ajax({
   type: "GET",
   url: "${ctx}/system/city/getAllJson",
   dataType:"json",
   success: function(json){
	     $("#city").combobox({
	 		data:json.rows,
	 		parentField : 'city',
	 		valueField:'id',
	    	textField:'name',
			iconCls: 'icon',
			editable:false ,
	    	animate:true,
	    	onLoadSuccess: function () { //数据加载完毕事件
               if(action=="update"){
            	   $(this).combobox("select","${store.cityId}");
               }else{
            	   var val = $(this).combobox("getData");
   				for (var item in val[0]) {
   					$(this).combobox("select", val[0][item]);
   				}
               }

            }
	 	});

   	}
 }); 
 
/*  $("#city").combobox({
                        url: "${ctx}/system/city/getAllJson", //获取所有私有域
                        valueField: "id",
                        textField: "name",
                        panelHeight: "auto",
                        editable: false, //不允许手动输入
                        onLoadSuccess: function () { //数据加载完毕事件
                            var data = $('#city').combobox('getData');
                            if (data.length > 0) {
                                $("#city").combobox('select', data[0].value);
                            }
                        }
                    }); */
 
 //前台人员
$.ajax({
   type: "GET",
   url: "${ctx}/system/user/json",
   dataType:"json",
   success: function(json){
	     $("#user").combobox({
	 		data:json.rows,
	 		parentField : 'user',
	 		valueField:'id',
	    	textField:'name',
			iconCls: 'icon',
			editable:false ,
	    	animate:true
	 	});
   	}
 });
 



</script>
</body>
</html>