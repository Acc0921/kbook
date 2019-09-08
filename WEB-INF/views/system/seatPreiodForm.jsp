<%-- 座位价格管理 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/seatPreiod/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td align="right">基准价钱:</td>
			<td>
			<input type="hidden" name="id" value="${id }" />
			<input id="baseprice" name="baseprice" type="text" value="${seatPreiod.baseprice}" class="easyui-validatebox" required="required" data-options="width: 150"/>&nbsp;*
			</td>
		</tr>
		<tr>
			<td align="right">所属城市:</td>
			<td><input id="city" name="city.id" value="${seatPreiod.cityId}" required="required" data-options="width: 150"/>*</td>
		</tr>
		<!--edit:yangzh by 2018-04-18 strat -->
		<tr>
			<td align="right">所属门店:</td>
			<td><input id="store" name="store.id" value="${seatPreiod.storeId}" data-options="width: 150"/></td>
			<!--
			<td><select id="store" name="store.id" required="required"  data-options="width: 150">
				<option value=""></option>
			</select>*
			</td>
			<td style="display:none;" id="test">${seatPreiod.storeId}</td>
			-->
			<td style="display:none;" id="test">${seatPreiod.storeId}</td>
		</tr>
		<!--edit:yangzh by 2018-04-18 end -->
		<tr>
			<td align="right">座位类别:</td>
			<td><input id="seattype" name="seattype.id" value="${seatPreiod.seattypeId}" data-options="width: 150" required="required"/>&nbsp;*</td>
		</tr>
		<!--edit:yangzh by 2018-04-16 -->
		<tr style="display: none">
			<td align="right">是否节假日:</td>
			<td>
				<select id="isHoliday" name="isHoliday"  class="easyui-combobox" data-options="width: 150" required="true">
					<option value="1">是</option>
					<option value="0" >否</option>
				</select>&nbsp;*
			</td>
		</tr>
        <!--
        <tr>
            <td align="right">节假日/闲时、忙时:</td>
            <td>
                <select id="isHoliday" name="isHoliday"  class="easyui-combobox" data-options="width: 150" required="required">
                    <option value="1">节假日</option>
                    <option value="2" >闲时</option>
                    <option value="3" >忙时</option>
                </select>&nbsp;*
            </td>
        </tr>
        -->
		<tr>
			<td align="right">节假日费率:</td>
			<td>
				<input id="holidayRate" name="holidayRate" type="text" value="${seatPreiod.holidayRate}" class="easyui-validatebox" required="true" data-options="width: 150"/>&nbsp;*<span style="color:red;">(例:0.8)</span>
			</td>
		</tr>
		<tr>
			<td align="right">闲时费率:</td>
			<td>
				<input id="leisureRate" name="leisureRate" type="text" value="${seatPreiod.leisureRate}" class="easyui-validatebox" required="true" data-options="width: 150"/>&nbsp;*<span style="color:red;">(例:0.8)</span>
			</td>
		</tr>
		<tr>
			<td align="right">忙时费率:</td>
			<td>
				<input id="busyRate" name="busyRate" type="text" value="${seatPreiod.busyRate}" class="easyui-validatebox" required="true" data-options="width: 150"/>&nbsp;*<span style="color:red;">(例:0.8)</span>
			</td>
		</tr>
		
	</table>
	</form>
</div>
<script type="text/javascript">

var  action = "${action}";
//add:yangzh by 2018-04-18 start
//初始化:节假日费率=1、闲时费率=1、忙时费率=1
$('#holidayRate').val(1.0);
$('#leisureRate').val(1.0);
$('#busyRate').val(1.0);
//add:yangzh by 2018-04-18 end

$(function(){
	$('#mainform').form({    
	    onSubmit: function(){
            //add:yangzh by 2018-04-18 start
            var baseprice=$('#baseprice').val();
            if(baseprice == 0){
                alert("基准价必输大于0");
                return false;
            }
            //add:yangzh by 2018-04-18 end
            var isValid = $(this).form('validate');
			return isValid;	// 返回false终止表单提交
	    },    
	    success:function(data){   
	    	successTip(data,dg,d);
	    }    
	}); 

});

/*  function validateForm(){
	var bol=true;
	var baseprice=$('#baseprice').val();
	var city=$("#city").combobox('getValue'); 
	var seattype=$("#seattype").combobox('getValue'); 
	if(baseprice=="0.0"){
		alert("基准价不能为空");
		bol=false;
	}
	
	if(city==""||city==undefined){
		alert("城市不能为空");
		bol=false;
	}
	
	if(seattype==""||seattype==undefined){
		alert("座位类型不能为空");
		bol=false;
	}
	
	return bol;
} */

/**
//所属城市
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
    	animate:true,
    	onLoadSuccess: function () { //加载完成后,设置选中第一项                          
             if(action=="update"){           	
            	 $(this).combobox("select", "${seatPreiod.cityId}");
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


//add:yangzh by 2018-04-18 strat
/** **/
var sID=$("#test").html();
$(document).ready(function(){
    var city=$("#city").val();
    var seattypeId = "${seatPreiod.seattypeId}";
    $("#store").combobox();
    if(city!=""){
        if(sID!=""){
            storeAdd(city,sID);
            if(seattypeId!=""){
                seattypeAdd(city,sID, seattypeId);
            }else{
                //seattypeAdd(city,sID, "请选择");
                seattypeAdd(city,sID, "");
            }
        }else{
            //storeAdd(city,"请选择");
            storeAdd(city,"");
        }
        seattypeAdd(city,sID, seattypeId);
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
        seattypeAdd(cityId,storeId,"");
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


//add:yangzh by 2018-04-18 end

/**
 //座位类别
$.ajax({
	type: "GET",
	//url: "${ctx}/system/seattype/allSeatTypeJson",
    url: "${ctx}/system/seattype/getSeatTypeByCityIdAndStoreId?cityId=" + ${seatPreiod.cityId} + "&storeId=" + ${seatPreiod.storeId},
	dataType:"json",
	success: function(json){
		$("#seattype").combobox({
			data:json,
			parentField : 'seattype',
			valueField:'id',
			textField:'name',
			iconCls: 'icon',
			animate:true,
			onLoadSuccess: function () { //加载完成后,设置选中第一项

				 if(action=="update"){
					 $(this).combobox("select", "${seatPreiod.seattypeId}");
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

 
	var isHoliday = "${seatPreiod.isHoliday}";
	if((isHoliday!=undefined)&&(isHoliday!="")){
		$("#isHoliday").val(isHoliday);
	}
 **/

</script>
</body>
</html>