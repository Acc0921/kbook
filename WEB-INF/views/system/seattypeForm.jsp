<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/seattype/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>座位名称：</td>
			<td>
			<input type="hidden" name="id" value="${id }" />
			<input id="name" name="name" type="text" value="${seattype.name }" class="easyui-validatebox" data-options="width: 150,required:'required'"/>
			</td>
		</tr>
		<tr>
			<td>所属城市:</td>
			<td><input id="city" name="city.id" value="${seattype.cityId}" required="required" data-options="width: 150"/>*</td>
		</tr>
		<tr>
			<td>所属门店:</td>
			<td><!--<select id="store" name="store.id" required="required"  data-options="width: 150">-->
				<select id="store" name="store.id" data-options="width: 150">
				<option value=""></option>
			</select>
			</td>
			<td style="display:none;" id="test">${seattype.storeId}</td>
		</tr>
	</table>
	</form>
</div>
<script type="text/javascript">


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

var sID=$("#test").html();
$(document).ready(function(){
    var city=$("#city").val();
    $("#store").combobox();
    if(city!=""){
        if(sID!=""){
            storeAdd(city,sID);
        }else{
            storeAdd(city,"");
        }
    }

});

var cityRows;
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
            animate:true
        });
        cityRows = (json.rows);
    }
});

var cityId;
$("#city").combobox({ //选择城市的时候带门店出来\
    onChange : function(oldValue, newValue) {
        for ( var i = 0; i < cityRows.length; i++) {
            if ($("#city").combobox('getValue') == cityRows[i].id) {
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
                $("#store").combobox({
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