<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>
<%
	Object sessionValues=session.getAttribute(Constants.CURRENT_MEMBER);
	Member mbr = (Member)sessionValues;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<%@ include file="/WEB-INF/views/include/context.jsp"%>
	<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
	<script src="${ctx}/static/bootstrap3.0/js/bootstrap-responsive-nav.min.js"></script>
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
	<title>选择座位</title>
	<style type="text/css">
		table tr td{
			border:1px solid #dddddd;
		}
		a{
			text-decoration:none;
		}
		a:link{
			text-decoration:none;
		}
		a:visited{
			text-decoration:none;
		}
		a:hover{
			text-decoration:none;
		}
		a:active{
			text-decoration:none;
		}
		#loading img {
			/*设置图片垂直居中*/
			vertical-align:middle;
		}

		.selectColor{
		//选中行背景颜色
		background-color: #00DB00 ;
		}
		.mouseoverColor{
		//鼠标滑进背景颜色
		background-color: #E7DAFF ;
		}
		.mouseoutColor{
		//鼠标滑出背景颜色
		background-color: #FFFFFF ;
		}
	</style>
</head>

<script type="text/javascript">
    function init(){
        initSeatType();
        initProductOrder();

        $("#sub").click(function() {
            if($("#seatid").val()==""){
                alert("还没选择一个座位！");
                return
            }
            //会员产品数大于1时，显示产品列表
            if(productNum > 1 ) {
                showProductOrder();
            }else{
                $("#seatForm").submit();
            }
        });
        $("#back").click(function() {
            window.history.back();
        });
    }

    // 读取座位类型
    function initSeatType(){
        //初始化全部座位
        var typeId;
        var storeId="${storeid}";
        $.ajax({
            type: "GET",
            url: "${ctx}/front/seatOrder/getAllSeatTypeJson?storeid=${storeid}",
            dataType:"json",
            success: function(json){
                for(var i = 0; i < json.length;i++){
                    typeId=json[i].id;
                    typeName=json[i].name;
                    //if(json[i].seats.length > 0)
                    //genSeatTable(typeId, typeName, json[i].seats);
                    initSeatTable(storeId, typeId, typeName);
                }
                initFullSeat(); // 初始化满足记录
                $('#loading').hide();
            }
        });
    }

    // 初始化seat的物理表格
    function genSeatTable(typeId,typeName, seats){
        var seatTable = document.getElementById("seatTable");
        var tr = document.createElement("tr");
        var trhead = document.createElement("tr");
        var tdhead = document.createElement("td");
        var tdcolor;
        tdhead.innerHTML = typeName;
        tdhead.id="tdhead_"+typeId;
        tdhead.height = "50px";
        tdhead.width = "50px";
        if(typeId==1){
            tdcolor="#009be4";
        }else if(typeId==2){
            tdcolor="#fff211";
        }else if(typeId==3){
            tdcolor="#fc8f46";
        }else{
            tdcolor="#FFCCCC";
        }
        tdhead.style.backgroundColor =tdcolor;
        tdhead.style.display = "none";

        trhead.appendChild(tdhead); // 把td放到tr
        seatTable.appendChild(trhead); // 把trhead放到table
        for(var i = 0; i < seats.length;i++){

            if(i%6==0){ //每6个换下行
                seatTable.appendChild(tr); // 把tr放到table
                tr = document.createElement("tr");
            }
            var tid= seats[i].typeId;
            if(tid==typeId){
                var tdh=document.getElementById("tdhead_"+typeId);
                tdh.style.display = "";
                tdh.colSpan="6";
                tdh.title="座位类型";
                tdh.style.border="solid 5px gray";
            }
            var seatName = seats[i].name;
            var seatId = seats[i].id;
            var td = document.createElement("td");
            td.id = seatId;
            td.innerHTML = seatName;
            td.height = "50px";
            td.width = "50px";
            td.style.border="solid 5px gray";
            td.style.cursor = "pointer";
            td.style.backgroundColor = "PaleGreen";

            td.onclick = function() { // 点击一个td的事件

                //this.style.border="solid 5px blue";

                if(this.title!=""){
                    alert("对不起，该座位已经被占，请选择其他座位");
                    return;
                }else{
                    clearTableBgColor();
                    this.style.backgroundColor = "SkyBlue";
                }
                document.getElementById("seatid").value = this.id;
            };//end onclick func

            tr.appendChild(td); // 把td放到tr
        }//end for

        seatTable.appendChild(tr); // 把tr放到table

        initFullSeat(); // 初始化满足记录
    }

    function clearTableBgColor(){ //清楚seat表的所有颜色
        var seatTableTds = document.getElementById('seatTable').getElementsByTagName('td');
        for (var i = 0; i < seatTableTds.length; i ++) {
            if(seatTableTds[i].title==""){
                seatTableTds[i].style.backgroundColor = "PaleGreen";
            }
        };
    }



 	// 初始化seat的物理表格
    function initSeatTable(storeId, typeId, typeName) {
        //clearTable();
        url = "${ctx}/system/seatStatus/getAllSeatJson?storeid=" + storeId
            + "&typeId=" + typeId + "&rows=1000";
        //初始化全部座位
        $.ajax({
            type : "GET",
            url : url,
            dataType : "json",
            success : function(json) {
            	var seatTable = document.getElementById("seatTable");
                var tr = document.createElement("tr");
                var trhead = document.createElement("tr");
                var tdhead = document.createElement("td");
                var tdcolor;
                tdhead.innerHTML = typeName;
                tdhead.id="tdhead_"+typeId;
                tdhead.height = "50px";
                tdhead.width = "50px";
                if(typeId==1){
                    tdcolor="#009be4";
                }else if(typeId==2){
                    tdcolor="#fff211";
                }else if(typeId==3){
                    tdcolor="#fc8f46";
                }else{
                    tdcolor="#FFCCCC";
                }
                tdhead.style.backgroundColor =tdcolor;
                tdhead.style.display = "none";

                trhead.appendChild(tdhead); // 把td放到tr
                seatTable.appendChild(trhead); // 把trhead放到table
                
                for(var i = 0; i < json.rows.length;i++){

                    if(i%6==0){ //每6个换下行
                        seatTable.appendChild(tr); // 把tr放到table
                        tr = document.createElement("tr");
                    }
                    var tid= json.rows[i].typeId;
                    if(tid==typeId){
                        var tdh=document.getElementById("tdhead_"+typeId);
                        tdh.style.display = "";
                        tdh.colSpan="6";
                        tdh.title="座位类型";
                        tdh.style.border="solid 5px gray";
                    }
                    var seatName = json.rows[i].name;
                    var seatId = json.rows[i].id;
                    var td = document.createElement("td");
                    td.id = seatId;
                    td.innerHTML = seatName;
                    td.height = "50px";
                    td.width = "50px";
                    td.style.border="solid 5px gray";
                    td.style.cursor = "pointer";
                    td.style.backgroundColor = "PaleGreen";
                    
                    td.onclick = function() { // 点击一个td的事件

                        //this.style.border="solid 5px blue";

                        if(this.title != ""){
                            alert("对不起，该座位暂无满足筛选时间段的空闲时间，选择其他座位");
                            return;
                        }else{
                            clearTableBgColor();
                            this.style.backgroundColor = "SkyBlue";
                        }
                        document.getElementById("seatid").value = this.id;
                    };//end onclick func

                    tr.appendChild(td); // 把td放到tr
                  	//获取座位的状态
                    
                }//end for
                //2019-08-08 修改
                //initFullSeat(storeId, typeId); // 初始化满足记录
                seatTable.appendChild(tr); // 把tr放到table
                //alert("start>>>>>>");
            }
        });
        
    }

    function initFullSeat(){ // 初始化满座的记录
        var myDate = new Date();
        var mytime=myDate.toLocaleTimeString();
        var url = "${ctx}/front/seatOrder/getFullSeatJson";
        url+= "?orderDate=${orderDate}";
        url+="&fromTime=${fromTime}";
        url+="&toTime=${toTime}";
        url+="&storeid=${storeid}";
        url+="&"+mytime;
        var color;
        var title;

        $.ajax({
            type: "GET",
            url: url,
            dataType:"json",
            success: function(json){
                for(var i = 0; i < json.rows.length;i++){
                    var fullSeatId = json.rows[i].seat.id;
                    var status = json.rows[i].status;
                    var color;
                    var title;
                    if(status==1){
                        color="pink";
                        title="被预订";
                    }else if(status==2){
                        color="yellow";
                        title="使用中";
                    }else if(status==3){
                        color="orange";
                        title="请假中";
                    }else if(status==6){
                        color="blue";
                        title="不能预订";
                    }else{
                        color="PaleGreen";
                        title="可以预订";
                    }
                    //alert(document.getElementById(fullSeatId+""))
                    document.getElementById(fullSeatId+"").style.backgroundColor=color;
                    document.getElementById(fullSeatId+"").title = title;
                }//end for

            }//end func
        });//end alax
    }



    //初始化加载会员产品列表
    var productNum = 0;
    //var selectColor = "#00DB00";
    //var mouseoutColor = "#FFFFFF";
    //var mouseoverColor = "#E7DAFF";
    //var thColor = "#8E8E8E";
    function initProductOrder(){
        var url = "${ctx}/front/seatOrder/getMemberValidProduct?id=" + "<%=mbr.getId()%>";
        //var url = "${ctx}/front/seatOrder/findProductOrderByMemberAll?id=" + "<%=mbr.getId()%>";
        $.ajax({
            type: "GET",
            url: url,
            async: true,
            dataType:"json",
            success: function(json){
                if(json.rows.length > 0 ){
                    productNum = json.rows.length;


                    var productOrderList = document.getElementById("productOrderList");
                    var table = document.createElement("table");
                    table.style.textAlign="center";
                    var trhead = document.createElement("tr");
                    trhead.style.backgroundColor = "#8E8E8E";
                    trhead.style.textAlign="center";
                    trhead.style.fontSize = "14px";
                    var tdhead0 = document.createElement("th");
                    tdhead0.style.textAlign="center";
                    tdhead0.innerHTML = "选择";
                    var tdhead1 = document.createElement("th");
                    tdhead1.style.textAlign="center";
                    tdhead1.innerHTML = "产品名称";
                    var tdhead2 = document.createElement("th");
                    tdhead2.style.textAlign="center";
                    tdhead2.innerHTML = "产品类型";
                    var tdhead3 = document.createElement("th");
                    tdhead3.style.textAlign="center";
                    tdhead3.innerHTML = "可用点数";	//可用点数-未结算预支付总额
                    var tdhead4 = document.createElement("th");
                    tdhead4.style.textAlign="center";
                    tdhead4.innerHTML = "有效截止日期";
                    var tdhead5 = document.createElement("th");
                    tdhead5.style.textAlign="center";
                    tdhead5.innerHTML = "折扣";

                    //将td放在tr,再将tr放在table
                    trhead.appendChild(tdhead0);
                    trhead.appendChild(tdhead1);
                    trhead.appendChild(tdhead2);
                    trhead.appendChild(tdhead3);
                    trhead.appendChild(tdhead4);
                    trhead.appendChild(tdhead5);
                    table.appendChild(trhead);

                    var tbody = document.createElement("tbody");
                    $(json.rows).each(function (i, item) {
                        //初始化默认赋值产品ID为第一个产品ID
                        if(i==0){
                            $("#productId").val( item.id );
                        }
                        //alert("productId:" + item.productId);
                        //alert("productName:" + item.productName);
                        //alert("productType:" + item.type);
                        //alert("balance:" + item.balance);
                        //alert("effectiveToDate:" + item.effectiveToDate);

                        var tr = document.createElement("tr");
                        tr.style.fontSize = "14px";
                        tr.id = "tr_" + item.id ;
                        //设置第一行被选中赋背景颜色
                        if(i==0) {
                            tr.style.backgroundColor = "#00DB00";
                        }
                        tr.onmouseover = function() {
                            var checkVal = $(this).find(":radio").prop("checked");
                            if (checkVal) {
                                this.style.backgroundColor = "#00DB00";
                            }else{
                                this.style.backgroundColor = "#E7DAFF";
                            }
                        };
                        tr.onmouseout = function()
                        {
                            var checkVal = $(this).find(":radio").prop("checked");
                            if (checkVal ) {
                                this.style.backgroundColor = "#00DB00";
                            }else{
                                this.style.backgroundColor = "#FFFFFF";
                            }
                        };
                        tr.onclick = function()
                        {
                            var trEl = this;
                            var tbodyEl = this.parentElement;	//tr父节点为tbody节点
                            var trEls = tbodyEl.children;	//tbody下的所有tr节点
                            //alert("trEls.length" + trEls.length );
                            //$(this).addClass('bc').siblings().removeClass('bc');
                            //循环tbody下的tr
                            for (j = 0; j < trEls.length; j++) {
                                var oneTrEl = trEls[j];
                                //alert($(oneTrEl).attr('id') );
                                if (trEl != oneTrEl ) {
                                    oneTrEl.style.backgroundColor = "#FFFFFF";
                                } else {
                                    oneTrEl.style.backgroundColor = "#00DB00";
                                }
                            }
                            $(this).find(":radio").prop("checked", true);
                            var productName = $('input:radio[name="productName"]:checked').val();
                            if(productName != null || productName != undefined){
                                $("#productId").val( productName );
                            }
                            //alert( tbodyEl.innerHTML );
                        };
                        var td0 = document.createElement("td");
                        var td1 = document.createElement("td");
                        var td2 = document.createElement("td");
                        var td3 = document.createElement("td");
                        var td4 = document.createElement("td");
                        var td5 = document.createElement("td");
                        //td0.innerHTML = '<input id="productName" type="radio" value="' + item.productId + '" name="productName"></input>';
                        td0.innerHTML = '<input id="productName" type="radio" value="' + item.id + '" name="productName"></input>';
                        td1.innerHTML = item.productName;
                        //判断产品类型：1-储蓄卡，2-包天卡
                        if(item.type==1){
                            td2.innerHTML = "储蓄卡";
                            td3.innerHTML = Math.round(item.balance) + "点";
                        }else if(item.type==2){
                            td2.innerHTML = "包天卡";
                            td3.innerHTML = "-";
                        }else{
                            td2.innerHTML = "-";
                            td3.innerHTML = "-";
                        }
                        td4.innerHTML = item.effectiveFromDate + " ~ "+ item.effectiveToDate;
                        td5.innerHTML = item.discount;

                        //将td放在tr,再将tr放在table
                        tr.appendChild(td0);
                        tr.appendChild(td1);
                        tr.appendChild(td2);
                        tr.appendChild(td3);
                        tr.appendChild(td4);
                        tr.appendChild(td5);
                        tbody.appendChild(tr);
                    })
                    table.appendChild(tbody);

                    productOrderList.appendChild(table);
                    //设置第一个单选框选中
                    $('input:radio:first').prop('checked', true);
                }
            }
        });
    }

	//订单选择使用产品
    function showProductOrder() { // 点击一个td的事件
        var productOrderList = document.getElementById("productOrderList");
        productOrderList.style.display = ""; //显示表格
        $('#myModal').dialog();
        d=$('#myModal').dialog({
            title:"请选择订座使用产品",
            autoOpen: false,	//初始化是否打开
            resizable: false,
            height: "auto",
            //width: "580px",
            cache: false,   //禁用缓存
            close: true,
            //maximizable:true, //最大化按钮
            modal: true,
            buttons:[{
                text:'确认',
                handler:function(){
                    if($("#productId").val()!=""){
                        $("#seatForm").submit();
                    }
                    //d.panel('close');
                }
            },{
                text:'取消',
                handler:function(){
                    d.panel('close');
                }
            }]
        });
        //var url = "${ctx}/front/seatOrder/getMemberValidProduct?id=" + "<%=mbr.getId()%>";
        //$('#iframe_myModal').attr('src',url);

    }

</script>


<body onload="init()">
<br/>
<div class="container"  align="center">
	<div class="well center-block" style="max-width: 500px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
		<form id="seatForm" action="${ctx}/front/seatOrder/conf" class="form-horizontal" role="form" method="post" align="center">
			<br>

			<table id="seatTable" align="center">
				<div id="loading"><img alt="loading" src="${ctx }/static/images/loading.gif"> 正在获取座位信息，请稍候...</div>
			</table>
			<br>

			<div  style="margin-top:15px;margin-bottom:15px;letter-spacing:4px;">
				<a id="sub" >
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">确定</button>
				</a>
			</div>
			<div  style="margin-bottom:15px;letter-spacing:4px;">
				<a id="back">
					<button type="button" class="btn btn-success btn-lg btn-block  btn-fontsize">返回</button>
				</a>
			</div>


			<br><br>
			<table align="center" style="display:none">
				<tr>
					<td>
						<input id="orderDate" type="text" name="orderDate" value="${orderDate}" style="display:block;"/>
					</td>
					<td>
						<input id="fromTime" type="text" name="fromTime" value="${fromTime}" style="display:block;"/>
					</td>
					<td>
						<input id="toTime" type="text" name="toTime" value="${toTime}" style="display:block;"/>
					</td>
					<td>
						<input id="seatid" type="text" name="seatid" value="${seatid}" style="display:block;"/>
					</td>
					<td>
						<input id="storeid" type="text" name="storeid" value="${storeid}" style="display:block;"/>
					</td>
					<td>
						<input id="productId" type="text" name="productId" value="${productId}" style="display:block;"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>

<!-- 弹窗 -->
<!-- Modal -->
<div class="dialog" id="myModal" style="width:480px;">
	<div id="productOrderList" style="display: none"></div>
</div>

</body>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript">
    $(function(){
        $.backstretch("${ctx}/static/images/1.jpg");
    });
</script>
</html>    