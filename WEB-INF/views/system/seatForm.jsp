<%-- 添加和修改座位 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/seat/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td align="right">座位：</td>
			<td>
			<input type="hidden" name="id" value="${id }" />
			<input id="name" name="name" type="text" value="${seat.name }" class="easyui-validatebox" data-options="width: 200,required:'required'"/>*
			</td>
		</tr>
		<tr>
			<td align="right">所属城市：</td>
			<td><input id="city" name="city.id" value="${seat.cityId}" data-options="width: 200, required:'required'"/>*</td>
		</tr>
		<tr>
			<td align="right">所属门店：</td>
			<td><input id="store" name="store.id" value="${seat.storeId}" data-options="width: 200, required:'required'"/>*</td>
			<td style="display:none;" id="test">${seat.storeId}</td>
		</tr>
		<tr>
			<td align="right">座位类别：</td>
			<td><input id="seattype" name="type.id" value="${seat.typeId}" data-options="width: 200, required:'required'"/>*</td>
		</tr>
		<tr>
			<td align="right" valign="top">说明：</td>
			<td>
				<textarea name="description" rows="10" cols="30"> ${seat.description}</textarea>
			</td>
		</tr>
		<tr style="display:none">
			<td>状态:</td>
			<td><input id="status" name="status" value="1" data-options="width: 200"/></td>
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

//edit:yangzh 2018-04-28 strat
/**
//所属门店
$.ajax({
   type: "GET",
   url: "${ctx}/system/store/getAllJson",
   dataType:"json",
   success: function(json){
     $("#store").combobox({
 		data:json.rows,
 		parentField : 'city',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
    	animate:true,
    	onLoadSuccess: function () { //加载完成后,设置选中第一项
            
             if(action=="update"){           	
            	 $(this).combobox("select", "${seat.storeId}");
             }else{
            	 var val = $(this).combobox("getData");
                 for (var item in val[0]) {
                 	if (item == "id") {
                    	 $(this).combobox("select", val[0].id);
                    }
                 }
             }
        }
 	});
   }
 });
 
 //座位类别
$.ajax({
   type: "GET",
   url: "${ctx}/system/seattype/allSeatTypeJson",
   dataType:"json",
   success: function(json){
     $("#seattype").combobox({
 		data:json,
 		parentField : 'city',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
    	animate:true,
    	onLoadSuccess: function () { //加载完成后,设置选中第一项
             if(action=="update"){           	
            	 $(this).combobox("select", "${seat.typeId}");
             }else{
            	 var val = $(this).combobox("getData");
                 for (var item in val[0]) {
                 	if (item == "id") {
                    	 $(this).combobox("select", val[0].id);
                    }
                 }
             }
    	
        }
 	});
   }
 });
**/

var sID=$("#test").html();
$(document).ready(function(){
    var city=$("#city").val();
    var typeId = "${seat.typeId}";
    $("#store").combobox();
    if(city!=""){
        if(sID!=""){
            storeAdd(city,sID);
            if(typeId!=""){
                seattypeAdd(city,sID, typeId);
            }else{
                //seattypeAdd(city,sID, "请选择");
                seattypeAdd(city,sID, "");
            }
        }else{
            //storeAdd(city,"请选择");
            storeAdd(city,"");
        }
        seattypeAdd(city, "", typeId);
    }else{
        //selectCity("请选择");
        selectCity("");
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

function selectCity(val){
    var url= "${ctx}/system/city/getAllJson";
    var cityId  = val;
    //城市加载
    $.ajax({
        type: "GET",
        url: url,
        dataType:"json",
        success: function(json){
            $("#city").combobox({
                data:json.rows,
                parentField : 'city',
                valueField:'id',
                value:cityId,
                textField:'name',
                iconCls: 'icon',
                editable:false ,
                animate:true
            });
            storeRows = (json.rows);
        }
    });
}

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
        seattypeAdd(cityId, "", "");
    }
});

var storeRows;
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
                storeRows = (json.rows);
            }
        });
    }
}

var storeId;
$("#store").combobox({ //选择城市和门店的时候带座位类型出来\
    onChange : function(oldValue, newValue) {
        for ( var i = 0; i < storeRows.length; i++) {
            if ($("#store").combobox('getValue') == storeRows[i].id) {
                storeId=storeRows[i].id;
            }
        }
        //seattypeAdd(cityId,storeId,"请选择");
        //seattypeAdd(cityId,storeId,"");
    }
});



//座位类别
function seattypeAdd(cityId,storeId,value){
    //var url="${ctx}/system/seattype/getSeatTypeByCityIdAndStoreId?cityId="+cityId + "&storeId=" + storeId;
    var url="${ctx}/system/seattype/getSeatTypeByCityId?cityId="+cityId ;
    var seattypeId=value;
    if(storeId!=null||storeId!=""){
        //座位类型加载
        $.ajax({
            type: "GET",
            url: url,
            dataType:"json",
            success: function(json){
                $("#seattype").combobox({
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

    }
}
//edit:yangzh 2018-04-28 end
 

</script>
</body>
</html>