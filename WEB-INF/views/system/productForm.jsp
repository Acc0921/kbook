<%@ page language="java" import="com.kbook.common.utils.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/product/${action}" method="post">
	<table  class="formTable">
		<tr>
			<td>产品名称：</td>
			<td>
			<input type="hidden" name="id" value="${id}" />	
			<input id="name" name="name" type="text" value="${product.name}" class="easyui-validatebox" required="true" missingMessage="请输入产品名称" data-options="width: 150"/>&nbsp;*
			</td>
		</tr>
		<tr>
			<td>销售渠道：</td>
			<td>
				<select id="salesChannel" name="salesChannel"  class="easyui-combobox" required="true" missingMessage="请选择销售渠道" data-options="width: 150">
					<option value="${Constants.SALES_CHANNEL_OFF_SALE}" <c:if test="${product.salesChannel == Constants.SALES_CHANNEL_OFF_SALE}">selected</c:if>>临时下架</option>
					<option value="${Constants.SALES_CHANNEL_OFFLINE}" <c:if test="${product.salesChannel == Constants.SALES_CHANNEL_OFFLINE}">selected</c:if>>线下销售</option>
					<option value="${Constants.SALES_CHANNEL_ONLINE}" <c:if test="${product.salesChannel == Constants.SALES_CHANNEL_ONLINE}">selected</c:if>>线上销售</option>
					<option value="${Constants.SALES_CHANNEL_OFF_AND_ON}" <c:if test="${product.salesChannel == Constants.SALES_CHANNEL_OFF_AND_ON}">selected</c:if>>线下线上销售</option>
				</select>&nbsp;*
			</td>
		</tr>
		<tr>
			<td>所属城市:</td>
			<td>
				<input id="city" name="city.id" value="${product.cityId}" class="easyui-combobox" required="true" missingMessage="请输入所属城市" data-options="width: 150"/>&nbsp;*  
				<!-- 
				<select id="city" name="city.id" value="${product.cityId}"  class="easyui-combobox" required="true" missingMessage="请输入所属城市" data-options="width: 150" >
				</select>&nbsp;*
				 -->
			</td>
		</tr>
<%--  		<tr>
			<td>所属门店:</td>
			<td>
				<input id="store" name="store.id" value="${product.storeId}" class="easyui-combobox" missingMessage="请输入专用门店" data-options="width: 150"/>&nbsp; <td colspan=2><span style="color:red;">非必选：选中后的产品只能用于专用门店</span></td> 
				<!-- 
				<select id="city" name="city.id" value="${product.cityId}"  class="easyui-combobox" required="true" missingMessage="请输入所属城市" data-options="width: 150" >
				</select>&nbsp;*
				 -->
			</td>
		</tr> --%>
		<tr>
			<td>消费人群：</td>
			<td>
				<select id="consumertype" name="consumertype"  class="easyui-combobox" required="true" missingMessage="请选择消费人群" data-options="width: 150">
					<option value="学生" <c:if test="${product.consumertype == '学生'}">selected</c:if>>学生</option>
					<option value="非学生" <c:if test="${product.consumertype == '非学生'}">selected</c:if>>非学生</option>
				</select>&nbsp;*
			</td>
		</tr>
		<tr>
			<td>储值金额：</td>
			<td><input id="actualValue" name="actualValue" type="text" value="${product.actualValue}" class="easyui-numberbox" required="true" missingMessage="请输入储值金额" data-options="width: 150, precision: 2, min: 0, max: 99999.00"/>元&nbsp;*</td>
			<td colspan=2><span style="color:red;">(例:1500 | 100 | 10.0)</span></td>
		</tr>
		<tr>
			<td>实际可消费点数：</td>
			<td><input id="consumeValue" name="consumeValue" type="text" value="${product.consumeValue}" class="easyui-numberbox"  missingMessage="请输入实际可消费点数" data-options="width: 150, required:'required', precision: 2, min: 0, max: 99999.00"/>点&nbsp;*</td>
			<td colspan=2><span style="color:red;">(例:1500 | 100 | 10.0)</span></td>
		</tr>
		<tr>
			<td>折扣：</td>
			<td><input id="discount" name="discount" type="text" value="${product.discount}" class="easyui-numberbox" missingMessage="请输入折扣" data-options="width: 150, required:'required', precision: 2, min: 0, max: 1.00"/>&nbsp;*</td>
			<td colspan=2><span style="color:red;">(例:0.8)</span></td>
		</tr>
		<tr>
			<td>产品类型：</td>
			<td>
				<input id="type" name="type" value="${product.type}" data-options="width: 150"/>
			</td >
			<td id="seatTypeCell" colspan ="3">
			<table id="selectSeatTypeTable" border="0">
			<tr>
			<td>座位类型：</td>
			<td>	
				<input id="selectseattype" name="seattypeId" value="${product.seattype.id}" class="easyui-combobox" required="true" missingMessage="请输入座位类型" data-options="width: 150"/> &nbsp;*
			</td>
			</tr>
			</table>
			</td>
			<td id="limitTypeCell" colspan ="3">
			<table id="selectLimitTypeTable" border="0">
			<tr>
			<td>封顶类型：</td>
			<td>	
				<select id="selectlimittype" name="limitType" class="easyui-combobox" required="true" missingMessage="请选择封顶类型" data-options="width:150">
				    <option value="1">按小时封顶</option>
				    <option value="2">按点数封顶</option>
				</select>
			</td>
			</tr>
			</table>
			</td>
		</tr>
		
		<tr id = "limitHourCell">
			<td id="ltext"></td>
			<td><input id="limitHour" name="limitHour" type="text" value="${product.limitHour}" class="easyui-numberbox" missingMessage="请输入天数或小时数" data-options="width: 150, required:'required', precision: 0, min: 1, max: 9999" validType="checkLimit['type', 'selectlimittype']" invalidMessage="封顶时间应小于等于24小时"/>&nbsp;*</td>
			<td colspan=2><span style="color:red;">(包天数字代表天数.储值卡数字代表小时数)</span></td>
		</tr>
		<tr id = "limitFeeCell">
			<td>封顶价格：</td>
			<td colspan="3">
				<table id="seatTypeTable" border="0" class="formTable">
				</table>
			</td>
		</tr>
		<tr id="effectivePeriodCell">
			<td>产品有效天数：</td>
			<td><input id="effectivePeriod" name="effectivePeriod" type="text" value="${product.effectivePeriod}" class="easyui-numberbox" missingMessage="请输入产品有效天数" data-options="width: 150, required:'required', precision: 0, min: 1, max: 9999"/>&nbsp;*</td>
		</tr>
		<tr>
			<td>产品销售周期：</td>
			<td><input id="effectiveFromDate" name="effectiveFromDate" type="text" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width: 150" value="<fmt:formatDate value="${product.effectiveFromDate}"/>" required="true" missingMessage="请输入产品销周期开始日期" />&nbsp;*</td>
			<td>至</td>
			<td><input id="effectiveToDate" name="effectiveToDate" type="text" class="easyui-my97" datefmt="yyyy-MM-dd" data-options="width: 150" value="<fmt:formatDate value="${product.effectiveToDate}"/>" required="true" missingMessage="请输入产品销周期结束日期" validType="checkEffectiveToDate['effectiveFromDate']" invalidMessage="产品销周期结束日期应该大于产品销周期开始日期"/>&nbsp;*</td>
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

$(function(){
	$('#mainform').form({    
	    onSubmit: function(){    
	    	//var isValid = validateForm();
			//return isValid;	// 返回false终止表单提交
			//return false;
			return $("#mainform").form('validate');
	    },    
	    success:function(data){   
	    	successTip(data,dg,d);
	    }    
	});

});

//Additional validation
$.extend($.fn.validatebox.defaults.rules,{
	checkEffectiveToDate:{
		validator:function(value,param){     
	    	var effectiveFromDate = $("#"+param[0]).datebox('getValue');
			var effectiveToDate = value;
	     	var bRet = ( effectiveToDate >= effectiveFromDate );
	     	return bRet;
	    },
	    message:'非法数据'
	},
	checkLimit:{
		validator:function(value,param){
	    	var type = $("#"+param[0]).combobox('getValue');
	    	var limitType = $("#"+param[1]).combobox('getValue');
			var limit = parseInt(value);		     	
			bRet = true;
			if ( type == "1" && limitType == "1" && limit > 24 ) {
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
			editable:false,
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
        storeAdd(cityId,"");
        seatTypeAdd(cityId,"","");
    }
});

//所属门店
$.ajax({
    type: "GET",
    url: "${ctx}/system/store/getAllJson",
    dataType:"json",
    success: function(json){
        $("#store").combobox({
            data:json.rows,
            parentField : 'store',
            valueField:'id',
            textField:'name',
            iconCls: 'icon',
            editable:false ,
            animate:true
        });
        storeRows = (json.rows);
    }
});

//add:yangzh by 2018-06-16 start
//修改时，根据城市ID获取座位类型
if($("#city").val() != ""){
	//add:yangzh by 2019-01-23 start
  if($("#store").val() != ""){
      storeAdd($("#city").val(), $("#store").val());
      seatTypeAdd($("#city").val(),$("#store").val(), "");
  }else{
      storeAdd($("#city").val(), "");
      seatTypeAdd($("#city").val(), "", "");
	}
	//add:yangzh by 2019-01-23 end
}
//add:yangzh by 2018-06-16 end

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
        //seatTypeAdd(cityId,storeId,"请选择");
        seatTypeAdd(cityId,storeId,"");
    }
});

//座位类型
function seatTypeAdd(cityId,storeId,value){
    var url="${ctx}/system/seattype/getSeatTypeByCityIdAndStoreId?cityId="+cityId + "&storeId=" + storeId;
    var seattypeId=value;
    //加载座位类型
    $.ajax({
        type: "GET",
        url: url,
        dataType:"json",
        success: function(json){
            $("#selectseattype").combobox({
                //data:json,
                data:json.rows,
                parentField :'seatTypeId',
                valueField:'id',
                textField:'name',
                iconCls: 'icon',
                editable:false,
                animate:true
            });

        }
    });

}

//产品类型
$.ajax({
   type: "GET",
   url: "${ctx}/static/json/productType.json",
   dataType:"json",
   success: function(json){
     $("#type").combobox({
 		data:json.rows,
 		parentField : 'type',
 		valueField:'id',
    	textField:'name',
		iconCls: 'icon',
		editable:false,
    	animate:true
 	});
   }
 });



//封顶价格
if(action=='create'){
$.ajax({
   type: "GET",
   url: "${ctx}/system/seattype/allSeatTypeJson",
   dataType:"json",
   success: function(json){

 	//Get the JSON object
 	var objJson = eval(json);
 	var objSeatTypeTable = $("#seatTypeTable");
 	var objTr = null;
 	var objTd = null;

	//Generate the limit fee input table
 	var tableHtml = "";
 	for (var i = 0; i < objJson.length; i++ ) {
	 	tableHtml += "<tr>"; 
	 	tableHtml += "<td><input type='hidden' name='seatTypeId' value='"+ objJson[i].id + "'/>" + objJson[i].name;
	 	tableHtml += "</td>";
	 	tableHtml += "<td><input id='limitFee" + i + "' name='limitFee' type='text' value='' class='easyui-numberbox' data-options=\"width: 150, precision: 2, min: 0.00, max: 999.00\"/>&nbsp;*";
	 	tableHtml += "</td>";
	 	tableHtml += "</tr>";
 	}
	
 	objSeatTypeTable.html(tableHtml);
 	//alert("${productSeatTypes}");
   }
 });

}

//当新增产品时
if(action=='update'){
	$.ajax({
		   type: "GET",
		   url: "${ctx}/system/productSeatType/getAllPstByProdIdJson?productId=${product.id}",
		   dataType:"json",
		   success: function(json){
			   
		 	//Get the JSON object
		 	var objJson = eval(json);
		 	var objSeatTypeTable = $("#seatTypeTable");
		 	var objTr = null;
		 	var objTd = null;

			//Generate the limit fee input table
		 	var tableHtml = "";
		 	for (var i = 0; i < objJson.length; i++ ) {
			 	tableHtml += "<tr>"; 
			 	tableHtml += "    <td>";
			 	tableHtml += "        <input type='hidden' name='seatTypeId' value='"+ objJson[i].seatTypeId + "'/>" + objJson[i].seatTypeName;
			 	tableHtml += "        <input type='hidden' name='productSeatTypeId' value='"+ objJson[i].id + "'/>";
			 	tableHtml += "    </td>";
			 	tableHtml += "    <td>";
			 	tableHtml += "        <input id='limitFee" + i + "' name='limitFee' type='text' value='" + objJson[i].limitFee + "' class='easyui-numberbox' data-options=\"width: 150, precision: 2, min: 0.00, max: 999.00\"/>&nbsp;*";
			 	tableHtml += "    </td>";
			 	tableHtml += "</tr>";
		 	}
		 	objSeatTypeTable.html(tableHtml);

		   }
		 });
	}


//当新增产品时
if(action=='create'){
	$('#type').combobox({
   	 onLoadSuccess:function(){
        $('#type').combobox("setValue",'1');//这里写设置默认值，
        $('#selectlimittype').combobox("setValue",'1');//这里写设置默认值，
	 	adjustLayout(1,1);
		
    }
});
}

//当修改产品时
if(action=='update'){
 $('#type').combobox({
  	 onLoadSuccess:function(){$('#selectlimittype').combobox('setValue','${product.limitType}');
   		 var type=$("#type").combobox('getValue');
  		 var limitType=$("#selectlimittype").combobox('getValue');
	 	adjustLayout(type,limitType); 
		
   }
});

} 

//产品类别改变时
$("#type").combobox({ 
	onChange : function(oldValue, newValue) {
		   var limitType=$("#selectlimittype").combobox('getValue');
			 adjustLayout(oldValue,limitType);
	}
}); 
//限制输入
$("#salesChannel").combobox({
	editable:false
});

$("#consumertype").combobox({
	editable:false
});

$("#selectlimittype").combobox({
	editable:false
});

//限制时间改变时
$("#selectlimittype").combobox({ 
	onChange : function(oldValue, newValue) {
		var type = $("#type").combobox('getValue');
		adjustLayout(type,oldValue);
	}
});


function adjustLayout(type, limitType) {
	//alert(type + '-' + limitType);
	
	if(type == "1"){//储值卡
		//隐藏座位类型
		$("#seatTypeCell").hide();
		$("#selectseattype").combobox({
			required:false
		});
		//$("#selectseattype").combobox('setValue', "");
		
		//显示封顶类型
		$("#limitTypeCell").show();
		//$("#selectlimittype").combobox({
		//	required: true
		//});

		//显示有效天数
		$("#effectivePeriodCell").show();
		$("#effectivePeriod").numberbox({
			required: true
		});
		     
		if(limitType == "1" ){//按小时封顶
			//隐藏点数封顶信息
			$("#limitFeeCell").hide();
			//Add validations
			var objLimitFees = $("input[name='limitFee']");
			for(var i = 0; i<objLimitFees.length; i++){
				$('#limitFee'+ i).numberbox({ 
					width: 150,
					required:false,
					precision: 2, 
					min: 0.00, 
					max: 999.00,
					missingMessage: "请输入封顶点数"
				});
			}
			//显示N小时封顶
			$("#limitHourCell").show();
			$("#limitHour").numberbox({
				required: true
			});
			//更新标签			
			$("#ltext").html("N小时封顶");
		}
		
			
		if(limitType == "2" ){//按点数封顶
			$("#limitHourCell").hide();	
			$("#limitHour").numberbox({
				required: false
			});

			$("#limitFeeCell").show();
			//Add validations
			var objLimitFees = $("input[name='limitFee']");
			for(var i = 0; i<objLimitFees.length; i++){
				$('#limitFee'+ i).numberbox({ 
					width: 150,
					required:true,
					precision: 2, 
					min: 0.00, 
					max: 999.00,
					missingMessage: "请输入封顶点数"
				});
			}
		}   
	}
	   	
	if(type == "2"){//包天卡
		//隐藏封顶价格
		$("#limitFeeCell").hide();
		//Add validations
		var objLimitFees = $("input[name='limitFee']");
		for(var i = 0; i<objLimitFees.length; i++){
			$('#limitFee'+ i).numberbox({ 
				width: 150,
				required:false,
				precision: 2, 
				min: 0.00, 
				max: 999.00,
				missingMessage: "请输入封顶点数"
			});
		}

		//隐藏封顶类型
		$("#limitTypeCell").hide();
		//$("#selectlimittype").combobox({
		//	required: false
		//});
		
		//隐藏有效天数
		$("#effectivePeriodCell").hide();
		$("#effectivePeriod").numberbox({
			required: false
		});

		//显示座位类型
		$("#seatTypeCell").show();
		$("#selectseattype").combobox({
			required:true
		});
		
		//显示N天封顶
		$("#limitHourCell").show();
		$("#limitHour").numberbox({
			required: true
		});
		
		//更新标签
		$("#ltext").html("N天封顶");
	}
}

</script>
</body>
</html>