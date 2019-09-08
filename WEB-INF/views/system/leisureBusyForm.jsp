<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/leisureBusy/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>闲时忙时标志：</td>
			<td>
			    <input type="hidden" name="id" value="${id}" />
				<select id="leisureBusyFlag" name="leisureBusyFlag" required="required" data-options="width: 150">
					<option value="1" >闲时</option>
					<option value="2" >忙时</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>所属城市:</td>
			<td><input id="city" name="city.id" value="${leisureBusy.cityId}" required="required" data-options="width: 150"/>*</td>
		</tr>
		<tr>
			<td>所属门店:</td>
			<td><select id="store" name="store.id" required="required"  data-options="width: 150">
				<option value=""></option>
			</select>*
			</td>
			<td style="display:none;" id="test">${leisureBusy.storeId}</td>
		</tr>
        <td>开始时间：</td>
        <td><input id="startTime" name="startTime" type="text" class="easyui-my97"
                   datefmt="HH:mm" data-options="width: 150"
                   value="${leisureBusy.startTime}"
				   required="required"
                   missingMessage="请输入开始时间" validType="checkstartTime['startTime','endTime']"
				   invalidMessage="开始时间不能超出营业时间范围内：08:00~23:00"/>&nbsp;*</td>
        <td>至</td>
        <td>截止时间：</td>
        <td><input id="endTime" name="endTime" type="text" class="easyui-my97"
                   datefmt="HH:mm" data-options="width: 150"
                   value="${leisureBusy.endTime}"
                   required="required"
                   missingMessage="请输入截止时间" validType="checkendTime['startTime','endTime']"
                   invalidMessage="截止时间应该大于开始时间，且不能超出营业时间范围内：08:00~23:00"/>&nbsp;*</td>
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
            storeAdd(city,1);
        }
    }

});

//闲时忙时标志控制
var action="${action}";
if(action=='create'){
    $('#leisureBusyFlag').combobox({
        onLoadSuccess:function(){
            $('#leisureBusyFlag').combobox("setValue","1"); //这里写设置默认值"闲时"，
        }

    });
}else if ( action=='update') {
    $('#leisureBusyFlag').combobox({
        onLoadSuccess:function(){
            var leisureBusyFlagVal = "${leisureBusy.leisureBusyFlag}";
            if(leisureBusyFlagVal ==null || leisureBusyFlagVal == ""){
                leisureBusyFlagVal = '1';
            }
            $('#leisureBusyFlag').combobox({ editable:false });
            $('#leisureBusyFlag').combobox("setValue",leisureBusyFlagVal);
        }
    });
}

$.extend($.fn.validatebox.defaults.rules,{
    checkendTime:{
        validator:function(value,param){
            var startTime = $("#"+param[0]).datebox('getValue');
            var endTime = $("#"+param[1]).datebox('getValue');
            //下班时间
            var endWorkTime = "23:00";
            var startTimeS = startTime.split(":");
            var endTimeS = endTime.split(":");
            var endWorkTimeS = endWorkTime.split(":");
            var bRet = false;

            //判断比较截止时间与下班时间
            if(endTimeS[0]<endWorkTimeS[0]){
                bRet = true;
            }
            else if(endTimeS[0]>=endWorkTimeS[0]){
                if(endTimeS[1]>endWorkTimeS[1]){
                    //alert("截止时间不能超出营业时间范围内：08:00~23:00");
                    return false;
                }else if(endTimeS[1]<endWorkTimeS[1]){
                    bRet = true;
                }else{
                    //alert("截止时间不能超出营业时间范围内：08:00~23:00");
                    bRet = false;
                }
            }
            //判断比较开始时间与截止时间
            if(startTimeS[0]>endTimeS[0]){
                bRet = false;
            }
            else if(startTimeS[0]<endTimeS[0]){
                bRet = true;
            }else{
                if(startTimeS[1]>endTimeS[1]){
                    bRet = false;
                }else if(startTimeS[1]<endTimeS[1]){
                    bRet = true;
                }else{
                    bRet = false;
                }
            }
            return bRet;
        },
        message:'非法数据'
    },
    checkstartTime:{
        validator:function(value,param){
            var startTime = $("#"+param[0]).datebox('getValue');
            //上班时间
            var startWorkTime = "08:00";
            var endWorkTime = "23:00";
            var startTimeS = startTime.split(":");
            var startWorkTimeS = startWorkTime.split(":");
            var endWorkTimeS = endWorkTime.split(":");
            var bRet = false;
            //判断比较开始时间与上班时间
            if(startTimeS[0]>=startWorkTimeS[0] && startTimeS[0]<endWorkTimeS[0]){
                bRet = true;
            }
            else{
                //alert("开始时间超出营业时间范围内：08:00~23:00");
                bRet = false;
            }
            return bRet;

        },
        message:'非法数据'
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

/**
//根据城市和门店和开始时间和截止时间判断闲忙参数时间范围是否存在
function isExistLeisureBusy(){
    var cityId = $("#city").combobox('getValue');
    var storeId = $("#store").combobox('getValue');
    var startTime = $("#startTime").combobox('getValue');
    var endTime = $("#endTime").combobox('getValue');
    var url="${ctx}/system/leisureBusy/isExistLeisureBusy?cityId="+cityId + "&storeId=" + cityId + "&startTime=" + startTime + "&endTime=" + endTime ;
    if(""!= cityId && ""!=storeId && ""!=startTime && ""!=endTime ) {
        $.ajax({
            type: "GET",
            url: url,
            dataType: "json",
            success: function (json) {
                if (json != null && json.length() > 0) {
                    alert(json);
                    alert(json.length());
                    alert("开始时间或截止时间范围间已定义，请重新设定时间范围！");
                    return false;
                }
            }
        });
    }
}**/


</script>
</body>
</html>