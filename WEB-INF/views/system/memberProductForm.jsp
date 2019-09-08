<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title></title>
	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
<div>
	<form id="mainform" action="${ctx}/system/memberProduct/${action}" method="post">
		<table class="formTable"> 
			<tr style="display: none;"> 
				<td>订单编号：</td>
				<td><input type="hidden" id='tid' name="id" value="${productOrder.id }" />
					<input id="orderNumber" name="orderNumber" value="${productOrder.orderNumber}" class="easyui-validatebox" data-options="width: 138" readonly/>
				</td>
			</tr>
			<tr>
				<td>会员：</td>
				<td>
                    <input id="member" name="member.id"
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
				<td>
                    <input id="product" name="product.id"
                           value="${productOrder.productId}" class="easyui-combobox" required="true" missingMessage="请选择产品" data-options="width: 138"/>*</td>
				</td>
			</tr>
			<tr>
				<td>门店：</td>
				<td>
                    <input id="store" name="store.id"
                           value="${productOrder.storeId}" class="easyui-combobox" required="true" missingMessage="请选择门店" data-options="width: 138" />*
				</td>
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
			<tr id = "actualValueTR">
				<td>充值金额：</td>
				<td>
					<input id="actualValue" name="actualValue" value="${productOrder.actualValue }" class="easyui-numberbox" required="true" missingMessage="请输入充值金额" data-options="precision: 2, min: 0"/>元
				</td>
			</tr>
			<tr id = "consumeValueTR">
				<td>实际消费点数：</td>
				<td><input id="consumeValue" name="consumeValue" value="${productOrder.consumeValue}" class="easyui-numberbox" required="true" missingMessage="请输入实际消费点数" data-options="precision: 2, min: 0"/>点</td>
			</tr>
			<tr id = "balanceTR">
				<td>可用点数：</td>
				<td><input id="balance" name="balance" value="${productOrder.balance}" class="easyui-numberbox" required="true" missingMessage="请输入可用点数" data-options="precision: 2, min: 0" />点</td>
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
<script type="text/javascript">
	var action = "${action}";
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


    //修改点数提交
    function editBalanceCommit(){
        var formLen=$("#mainform").length;
        var mainform = $("#mainform");
        if(formLen>1){
            for(var i=1; i<formLen;i++){
                $(mainform[i]).remove();
            }
        }
        var isValid = $("#mainform").form('validate');
        if(!isValid){
            return false;
        }

        parent.$.messager.confirm('提示', '确认修改点数吗？',function(data){
            if(data){
                $.ajax({
                    //type:'get',
                    //url:'${ctx}/system/seatorder/change?seatorderid='+seatorderid+'&seatid=' + selectSeatId + '&storeId=' + storeId ,
                    type:'POST',
                    url:'${ctx}/system/memberProduct/${action}',
                    data : $("#mainform").serialize(),
                    success:function(r){
                        if(r=='success'){
                            successTip("success",dg,d1);
                            //dg1.treegrid('reload');
                        }else{
                            parent.$.messager.alert('提示',r);
                        }
                    }
                });

            }
        });
    }

    //购买产品提交
    function buyProductOrderCommit(){
        var formLen=$("#mainform").length;
        var mainform = $("#mainform");
        if(formLen>1){
            for(var i=1; i<formLen;i++){
                $(mainform[i]).remove();
            }
        }
        var isValid = $("#mainform").form('validate');
        if(!isValid){
            return false;
        }

        parent.$.messager.confirm('提示', '确认购买产品吗？',function(data){
            if(data){
                $.ajax({
                    //type:'get',
                    //url:'${ctx}/system/seatorder/change?seatorderid='+seatorderid+'&seatid=' + selectSeatId + '&storeId=' + storeId ,
                    type:'POST',
                    url:'${ctx}/system/memberProduct/${action}',
                    data : $("#mainform").serialize(),
                    success:function(r){
                        if(r=='success'){
                            successTip("success",dg1,d1);
                            //dg1.treegrid('reload');
                        }else{
                            parent.$.messager.alert('提示',r);
                        }
                    }
                });

            }
        });
        //$("#orderNumber").val("99991231235959");
    }

    $.extend($.fn.validatebox.defaults.rules,{
        checkEffectiveFromDate:{
            validator:function(value,param){
                if(action == "update"){
                    return true;
                }
                //var s = $("input[name="+param[0]+"]").val();
                var str = value + ' 23:59:59';
                str = str.replace(/-/g,"/");

                var date = new Date(str);
                var dtNow = new Date();


                var bRet = (date >= dtNow );
                return bRet;
            },
            message:'非法数据'
        },
        /**
         * 扩展combox验证，easyui原始只验证select text的值，不支持value验证
         */
        comboxValidate : {
            validator : function(value, param, missingMessage) {
                if($('#'+param).combobox('getValue')!='' && $('#'+param).combobox('getValue')!=null){
                    return true;
                }
                return false;
            },
            message : "{1}"
        }
    });


    var memberRows;
    var productRows;
    var storeRows;
    var memberId = "${memberId}";		//会员ID
    //var memberId = "${productOrder.memberId}";	//会员ID
    var cardId="${cardId}"; //卡号
    var cityId = "${cityId}";   //城市ID
    var flag = "${flag}";// 1为直接购买
	var productName = "${productOrder.productName}";	//会员购买的历史产品名称

    //会员
    $.ajax({
        type : "GET",
        //url : "${ctx}/system/member/getAllJson",
        url : "${ctx}/system/member/getMemberJson?memberId=" + memberId ,
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
            for ( var i = 0; i < memberRows.length; i++) {
                if ($("#member").combobox('getValue') == memberRows[i].id) {
                    $("#cardId").html(memberRows[i].cardid);
                    $("#account").html(memberRows[i].account);
                    //A temp fix for performance issue
                    //cityId=memberRows[i].city.id;
                    cityId=memberRows[i].cityId;
                }

            }

            if(true){
                var tid = $("#tid").val();
                if(tid && tid != ''){
                    //changeProAndSto("${productOrder.member.cityId}");

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
								value : productName,
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

        }
    });

    //选择产品时，根据产品ID获取产品信息并赋值给相关项
    $("#product").combobox({ // 当产品下拉改变时自动将产品信息填充
        editable:false,
        onChange : function(oldValue, newValue) {
            for ( var i = 0; i < productRows.length; i++) {
                if ($("#product").combobox('getValue') == productRows[i].id) {
                    $("#product").val(productRows[i].id);	//产品ID重新赋值
                    $("#consumerType").val(productRows[i].consumertype);

                    $("#actualValue").numberbox("setValue", productRows[i].actualValue);
                    $("#consumeValue").numberbox("setValue", productRows[i].consumeValue);
                    $("#discount").numberbox("setValue", productRows[i].discount);
                    //$("#actualValue").val(productRows[i].actualValue);
                    //$("#consumeValue").val(productRows[i].consumeValue);
                    //$("#discount").val(productRows[i].discount);

                    $("#type").val(productRows[i].type);
                    if(productRows[i].type==1){
                        $("#typeName").val("储值卡");
                        $("#effectiveToDate").datebox({editable:true,disabled: false});
                        //$("#effectiveFromDate").datebox("setValue",productRows[i].effectiveFromDate);
                        //$("#effectiveToDate").datebox("setValue",productRows[i].effectiveToDate);
                    }else if(productRows[i].type==2){
                        $("#typeName").val("包日卡");
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


    function changeProAndSto(){
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


    //当修改点数
     if(action == "update" ){
        $("#member").combobox({disabled: true});
        $("#product").combobox({disabled: true});
        $("#store").combobox({disabled: true});
        $("#actualValueTR").hide();
        $("#consumeValueTR").hide();
        $("#balanceTR").show();
    }
     //购买产品（充值）
     else if(action == "create"){
        $("#member").combobox({disabled: true});
        $("#product").combobox({disabled: false});
        $("#store").combobox({disabled: false});
        $("#actualValueTR").show();
        $("#consumeValueTR").show();
        $("#balanceTR").hide();
    }


</script>
</body>
</html>