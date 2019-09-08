<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/productOrder/${action}" method="post">
		<table class="formTable">
			<tr style="display: none;">
				<td>订单编号：</td>
				<td><input type="hidden" id='tid' name="id" value="${id }" /> 
					
					<input id="orderNumber" name="orderNumber" value="${productOrder.orderNumber}" class="easyui-validatebox" data-options="width: 138" readonly/>
				</td>
			</tr>
			<tr>
				<td>会员：</td>
				<td><input id="member" name="member.id"
					value="${productOrder.memberId}" class="easyui-combobox" required="true" missingMessage="请选择会员" data-options="width: 138"/>*
				</td>
			</tr>
			<tr>
				<td>会员账号：</td>
				<td><span id="account" >${productOrder.member.account}</span></td>
			</tr>
			<tr>
				<td>会员卡：</td>
				<td><span id="cardId" >${productOrder.cardId}</span></td>
			</tr>
			<tr>
				<td>产品：</td> 
				<td><input id="product" name="product.id"
					value="${productOrder.productId}" class="easyui-combobox" required="true" missingMessage="请选择产品" data-options="width: 138"/>*</td>
			</tr>
<%-- 			<c:if test="${!action.equals('create')} "> 
				<c:choose>
				<c:when test="${roleCode.equals('store_manager')}">
				<tr style="display: none">
					<td>门店：</td> 
					<td><input id="store" name="store.id"
						value="${storeId}" class="easyui-combobox" required="true" missingMessage="请选择门店" data-options="width: 138" />*</td>
				</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>门店：</td>
						<td><input id="store" name="store.id"
								   value="${productOrder.storeId}" class="easyui-combobox" required="true" missingMessage="请选择门店" data-options="width: 138" />*</td>
					</tr>
				</c:otherwise>
				</c:choose>
 			</c:if> --%>

			<tr>
				<td>门店：</td>
				<td><input id="store" name="store.id"
						   value="${productOrder.storeId}" class="easyui-combobox" required="true" missingMessage="请选择门店" data-options="width: 138" />*</td>
			</tr>

			<tr>
				<td>消费人群：</td>
				<td>
				<input id="consumerType" name="consumerType" value="${productOrder.consumerType}" class="easyui-validatebox" readonly/></td>
			</tr>
			<tr>
				<td>开始日期：</td>
				<td>
					<input id="effectiveFromDate" name="effectiveFromDate" type="text" class="easyui-datebox" 
					datefmt="yyyy-MM-dd" data-options="width: 138" value="<fmt:formatDate value="${productOrder.effectiveFromDate}"/>" required="true" missingMessage="请输入产品生效日期" validType="checkEffectiveFromDate['p1']" invalidMessage="生效日期必须大于等于今天" />
				<!--  &nbsp;*&nbsp;包日卡只需要选择开始时间 --></td>
			</tr>
			<tr>
				<td>结束日期：</td>
				<td>
					<input id="effectiveToDate" name="effectiveToDate" type="text" class="easyui-datebox" 
					datefmt="yyyy-MM-dd" data-options="width: 138" value="<fmt:formatDate value="${productOrder.effectiveToDate}"/>" required="true" missingMessage="请输入产品失效日期" />
				</td>
			</tr>
			<tr>
				<td>充值金额：</td>
				<td>
				 <input id="actualValue" name="actualValue" value="${productOrder.actualValue }" class="easyui-numberbox" required="true" missingMessage="请输入充值消费金额" data-options="width: 150, precision: 2, min: 0, max: 99999.00"/>元
				</td>
			</tr>
			<tr>
				<td>实际消费点数：</td>
				<td><input id="consumeValue" name="consumeValue" value="${productOrder.consumeValue}" class="easyui-numberbox" required="true" missingMessage="请输入实际消费点数"/>点</td>
			</tr>
			<tr>
				<td>打折：</td>
				<td>
				<input id="discount" name="discount" value="${productOrder.discount }" readonly class="easyui-numberbox" required="true" data-options="min:0,precision:2"/>
				</td>
			</tr>
			<tr style="display:none">
				<td >时间封顶数</td>
				<td>
				<input id="limitHour" name="limitHour" value="${productOrder.limitHour }" readonly/>
				</td>
			</tr>
			<tr style="display:none">
				<td>产品类型</td>
				<td>
				<input type="hidden" id="type" name="type" value="${productOrder.type }" readonly/>
				<input id="typeName"  value="" readonly/>
				</td>
			</tr>
			
			<tr style="display:none">
				<td>状态：</td>
				<td>
				<input id="status" name="status" value="${productOrder.status}" data-options="width: 150"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="pay" class="easyui-window" data-options="title:'微信支付',closed:true" style="width:580px;height:350px;">
	<!-- 按钮区域 -->
	<div class="datagrid-toolbar">
		<a id="sendPay" class="easyui-linkbutton" href="#" icon="icon-save">手动发送支付</a>
		<!-- <a id="nativePay" class="easyui-linkbutton" href="#" icon="icon-add">二维码支付</a> -->
	</div>
	<div>
	<form id="payFrom" action="${ctx}/system/productOrder/createPayLog" method="post" style="text-align: center;color: red;">
		<h1>温馨提示：请将扫码枪对准二维码，或手动输入付款码，扫码过后请勿移动鼠标，等待扫码结束。</h1>
		用户付款码：<input id="authcode" name="authcode" type="text" style="width: 100%;height: 150px;"/>
	</form>
	</div>
</div>
<script type="text/javascript">
	//对Date的扩展，将 Date 转化为指定格式的String 
	//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
	//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
	//例子： 
	//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
	//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
	Date.prototype.Format = function(fmt) 
	{ //author: meizz 
	var o = { 
	"M+" : this.getMonth()+1,                 //月份 
	"d+" : this.getDate(),                    //日 
	"h+" : this.getHours(),                   //小时 
	"m+" : this.getMinutes(),                 //分 
	"s+" : this.getSeconds(),                 //秒 
	"q+" : Math.floor((this.getMonth()+3)/3), //季度 
	"S"  : this.getMilliseconds()             //毫秒 
	}; 
	if(/(y+)/.test(fmt)) 
	fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	for(var k in o) 
	if(new RegExp("("+ k +")").test(fmt)) 
	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
	return fmt; 
	}


	//弹出加载层
 	function load() {
		
	    $("<div class=\"datagrid-mask\"></div>").css({ display: "block",height: "80%",'padding-top': "10%",'margin-top': "4%" }).appendTo("#pay");  
	    $("<div class=\"datagrid-mask-msg\"></div>").html("支付中，请稍候。。。").appendTo("#pay").css({ display: "block",width: "30%",height: "10%",'margin-left': "35%"});  
	}
	//取消加载层  
	function disLoad() {  
	    $(".datagrid-mask").remove();  
	    $(".datagrid-mask-msg").remove();  
	} 
	
	$(function() {
		$('#mainform').form({
			onSubmit : function() {
				var isValid = $("#mainform").form('validate');
				if(isValid){
					var r = confirm("请确认购买产品信息");
					if(r == false){
						isValid = false;
					}
				}
				if(!isValid){
					$("#b").linkbutton('enable');
				}
				return isValid; // 返回false终止表单提交
			},
			success : function(data) {
				/* if(data!="success"){
			    //add:yangzh by 2019-01-25 start 购买产品成功刷新产品列表
                var obj=$("#searchFrom").serializeObject();
                dg.datagrid('load',obj);//添加成功刷新产品列表。
                //add:yangzh by 2019-01-25 end 购买产品成功刷新产品列表
				$("#b").linkbutton('enable');
			}*/
			var isSubmit = false;
			if(data == 'success'){
				var obj = $("#searchFrom").serializeObject();
				if(d!=null)
					d.panel('close');

                //TODO:弹出支付的窗口
                $("#pay").window("open");
                //获取输入框焦点
                $("#authcode").focus(); 
                
                $('#authcode').bind('keyup', function(event) {
                    if (event.keyCode == "13") {
                    	if(isSubmit == false){
                    		isSubmit = true;
                    		//回车执行支付
                        	$("#payFrom").submit();
                        	
                            load();
                    	}
                    }
                });

                
                $("#payFrom").form({
                    onSubmit : function() {
                        var authcode = $("#authcode").val();
                        if (authcode == "" || authcode == null) {
                            return false;
                        }
                        return true;
                    },
                    success : function(data) {
						
		                    if (data == "success") {
				                disLoad();
				                $('#pay').dialog('close');
				                $("#authcode").val("");
				                $.messager.alert("提示","支付成功","info");
							} else {
								disLoad();
								$("#authcode").focus();
								$("#authcode").val("");
								$.messager.alert("提示",data,"info");
							}
				            	dg.datagrid('load', obj);
				          }
				     })
	                    isSubmit = false;
					}else if(data == 'free'){
						var obj = $("#searchFrom").serializeObject();
						if(data != null)
							d.panel('close');
						$.messager.alert("提示","购买成功","info");
						dg.datagrid('load', obj);
					}else{
						successTip(data,dg,d);
					}
				}
			});
		
		//Pass the high value to order number, for input only
		$("#orderNumber").val("99991231235959");
	});

 	$.extend($.fn.validatebox.defaults.rules,{
		checkEffectiveFromDate:{
			validator:function(value,param){     
		    	//var s = $("input[name="+param[0]+"]").val();
		     	var str = value + ' 23:59:59';
		     	str = str.replace(/-/g,"/");
		     	
		     	var date = new Date(str);
		     	var dtNow = new Date();
				
		     	
		     	var bRet = (date >= dtNow );
		     	return bRet;
		    },
		    message:'非法数据'
		}
 	});
	

	var memberRows;
	var cityId;
	var productRows;
    var flag = "${flag}";
    var memberId="${memberId}";
    var cardId="${cardId}";
    var cityId="${cityId}";
	//edit:yangzh by 2018-06-16 start
	var flag = "${flag}";// 1为直接购买
	var memberUrl = "";
	if(flag==1){
        memberUrl = "${ctx}/system/member/getMemberJson?memberId=" + memberId ;
        $("#member").combobox({disabled: true});
	}else {
        memberUrl = "${ctx}/system/member/getAllJson";
        $("#member").combobox({disabled: false});
	}
    //edit:yangzh by 2018-06-16 end
	//会员
	$.ajax({
		type : "GET",
		//url : "${ctx}/system/member/getAllJson",
        url : memberUrl,
        dataType : "json",
		success : function(json) {
			$("#member").combobox({
				data : json.rows,
				parentField : 'member',
				valueField : 'id',
				textField : 'name',
				iconCls : 'icon',
				animate : true
			});
			
			memberRows = (json.rows);
			
			if(true){
				var tid = $("#tid").val();
				if(tid && tid != ''){
					changeProAndSto("${productOrder.member.cityId}");
				}
			}
			
			//添加会员后直接购买产品
			if(flag =="1"){
				
				$("#member").combobox("setValue",memberId);
				$("#cardId").html(cardId);
				for ( var i = 0; i < memberRows.length; i++) {
					if ($("#member").combobox('getValue') == memberRows[i].id) {
						$("#account").html(memberRows[i].account);
						$("#cardId").html(memberRows[i].cardId);
					}
					
				}
				var url="${ctx}/system/product/effProduct?cityId="+cityId;
				if(cityId!=null||cityId!=""){
					//产品
					$.ajax({
						type : "GET",
						url : url,
						dataType : "json",
						success : function(json) {
							$("#product").combobox({
								data : json,
								parentField : 'product',
								valueField : 'id',
								textField : 'name',
								iconCls : 'icon',
								animate : true
							});
							productRows = (json);	
						}
					});
				}
			}
			
		}
	});
	
	$("#member").combobox({ // 用于当改变会员选择时刷新会员的卡号
		
		onChange : function(oldValue, newValue) {
			
			for ( var i = 0; i < memberRows.length; i++) {
				if ($("#member").combobox('getValue') == memberRows[i].id) {
					$("#cardId").html(memberRows[i].cardid);
					$("#account").html(memberRows[i].account);
					//A temp fix for performance issue
					//cityId=memberRows[i].city.id;
					cityId=memberRows[i].cityId;
				}
				
			}
			if(cityId==undefined){
				return
			}
			changeProAndSto(cityId);
		}
	});
	
	$("#store").combobox({
		editable:false,
		data : null,
		parentField : 'store',
		valueField : 'id',
		textField : 'name',
		iconCls : 'icon',
		animate : true
	}); 
	
	
	$("#product").combobox({ // 当产品下拉改变时自动将产品信息填充
		editable:false,
		onChange : function(oldValue, newValue) {	
			for ( var i = 0; i < productRows.length; i++) {			
				if ($("#product").combobox('getValue') == productRows[i].id) {
					$("#consumerType").val(productRows[i].consumertype);

					$("#actualValue").numberbox("setValue", productRows[i].actualValue);
					$("#consumeValue").numberbox("setValue", productRows[i].consumeValue);
					$("#discount").numberbox("setValue", productRows[i].discount);
					
					$("#type").val(productRows[i].type);
					if(productRows[i].type==1){
						$("#typeName").val("储值卡");
						$("#effectiveToDate").datebox({editable:true,disabled: false});
						//$("#effectiveFromDate").datebox("setValue",productRows[i].effectiveFromDate);						
						//$("#effectiveToDate").datebox("setValue",productRows[i].effectiveToDate);
					}else if(productRows[i].type==2){
						$("#typeName").val("包日卡");
						/*
						$("#effectiveFromDate").datebox({
							onSelect: function(date){
						
							var strDate = (date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate());
							var fromDate = new Date(strDate);
							var toDate = fromDate.getTime() + parseInt($("#limitHour").val()-1) * 86400000;
							var strToDate = new Date(toDate).format("yyyy-MM-dd");			
							$("#effectiveToDate").datebox("setValue",strToDate);
							}
						});
						$("#effectiveToDate").datebox({editable:false,disabled: true});
						*/
					}else{
						$("#typeName").val("其他");
					}
					
					//Automatic generate the effective from date
					$("#effectiveFromDate").datebox({
						onSelect: function(date){
					
						var strDate = (date.getFullYear()+"/"+(date.getMonth()+1)+"/"+date.getDate());
						var fromDate = new Date(strDate);
						var toDate = fromDate.getTime() + parseInt($("#limitHour").val()-1) * 86400000;
						var strToDate = new Date(toDate).format("yyyy-MM-dd");			
						$("#effectiveToDate").datebox("setValue",strToDate);
						}
					});
					$("#effectiveToDate").datebox({editable:false,disabled: true});
					
					//$("#limitHour").val(productRows[i].limitHour);
					$("#limitHour").val(productRows[i].effectivePeriod);
					
					$("#status").val("1");
				}				
			}				
		}
	});
	
	function changeProAndSto(cityId){
		var url="${ctx}/system/product/effProduct?cityId="+cityId;
		var storeurl="${ctx}/system/store/getStoreByCityId?cityId="+cityId;
		if(cityId!=null||cityId!=""){
			//产品
			$.ajax({
				type : "GET",
				url : url,
				dataType : "json",
				success : function(json) {
					$("#product").combobox({
						data : json,
						parentField : 'product',
						valueField : 'id',
						textField : 'name',
						iconCls : 'icon',
						animate : true
					});
					productRows = (json);	
				}
			});
			//门店
	 		$.ajax({
				type : "GET",
				url : storeurl,
				dataType : "json",
				success : function(json) {
					$("#store").combobox({
						data : json.rows,
						parentField : 'store',
						valueField : 'id',
						textField : 'name',
						iconCls : 'icon',
						animate : true
					});
					//productRows = (json.rows);	
				}
			}); 
		}	
	}
	
</script>
</body>
</html>