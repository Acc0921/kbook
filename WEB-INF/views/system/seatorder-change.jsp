
<%
	//Amendment by Gavin
	//Amendment Date: 20151116
	//Fix Tag: KBOOK-216
	//Desc: 
	//后台 – 门店管理员 – 座位状态
	//鼠标在座位上停留时，显示更多信息：
	//客户姓名、订单开始时间、订单结束时间、签到时间
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="${ctx}/static/plugins/easyui/jquery/jquery-1.11.1.min.js"></script>
	<script
			src="${ctx}/static/bootstrap3.0/js/bootstrap-responsive-nav.min.js"></script>
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css"
		  rel="stylesheet" type="text/css">
	<link
			href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css"
			rel="stylesheet" type="text/css">
	<link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css"
		  rel="stylesheet" type="text/css">
	<title>选择座位</title>
	<style type="text/css">
		table tr td {
			border: 1px solid #dddddd;
		}

		table tr td.choose{
			background-color:blue;
		}

		.tip {
			position: absolute;
			padding: 50px;
			border: 1px solid #000;
			border-radius: 10px;
		}

		.angle {
			width: 20px;
			height: 20px;
			line-height: 20px;
			overflow: hidden;
			font-size: 20px;
			position: absolute;
			font-family: "SimSun";
			bottom: 45px;
			left: -11px;
		}

		.angle i {
			position: absolute;
			top: 0;
			left: 0;
			font-style: normal;
		}

		.angle .b {
			color: #000;
			z-index: 1;
		}

		.angle .t {
			color: #fff;
			z-index: 2;
			left: 2px;
		}
	</style>
</head>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

<body onload="init()">
<div align="center">
	<div class="container" align="center">
		<form id="seatForm" action="${ctx}/front/seatOrder/conf"
			  class="form-horizontal" role="form" method="post" align="center">
			<div class="container" align="center" style='margin-top: -28px'>
				<table id="seatTable" align="center">

				</table>
			</div>
			<input id="sId" type="hidden" name="id" value="${storeid}" />
		</form>
	</div>
</div>
<script type="text/javascript">
    var url;
    var storeId = "${storeid}";
    var seatorderid = "${seatorderid}";
    initSeatType();
    // 读取座位类型
    function initSeatType() {
        //初始化全部座位
        var typeId;
        var typeName;
        $.ajax({
            type : "GET",
            url : "${ctx}/system/seatStatus/getAllSeatTypeJson",
            dataType : "json",
            success : function(json) {
                for (var i = 0; i < json.rows.length; i++) {
                    typeId = json.rows[i].id;
                    typeName = json.rows[i].name;
                    initSeatTable(storeId, typeId, typeName);
                }
                initFullSeat(storeId, typeId); // 初始化满足记录
            }
        });
    }

    // 初始化seat的物理表格
    function initSeatTable(storeId, typeId, typeName) {
        clearTable();
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
                tdhead.id = "tdhead_" + typeId;
                tdhead.height = "50px";
                tdhead.width = "50px";

                if (typeId == 1) {
                    tdcolor = "#009be4";
                } else if (typeId == 2) {
                    tdcolor = "#fff211";
                } else if (typeId == 3) {
                    tdcolor = "#fc8f46";
                } else {
                    tdcolor = "#FFCCCC";
                }
                tdhead.style.backgroundColor = tdcolor;

                //tdhead.style.backgroundColor = "#FFCCCC";
                tdhead.style.display = "none";
                tdhead.style.textAlign = "center";
                trhead.appendChild(tdhead); // 把td放到tr
                seatTable.appendChild(trhead); // 把trhead放到table
                for (var i = 0; i < json.rows.length; i++) {

                    if (i % 10 == 0) { //每10个换下行
                        seatTable.appendChild(tr); // 把tr放到table
                        tr = document.createElement("tr");
                    }
                    var tid = json.rows[i].typeId;
                    if (tid == typeId) {
                        var tdh = document.getElementById("tdhead_"
                            + typeId);
                        tdh.style.display = "";
                        tdh.colSpan = "10";
                        tdh.style.border = "solid 5px gray";
                    }

                    var seatName = json.rows[i].name;
                    var seatId = json.rows[i].id;

                    var td = document.createElement("td");
                    td.id = seatId;
                    //td.onmouseover=function (e){over(e,this);};  /*fxi tag KBOOK-216 by Gavin  */
                    //td.onmouseout=function (e){out(e,this);};  /*fxi tag KBOOK-216 by Gavin   */
                    //td.onmousemove=function (e){move(e,this);};  /*fxi tag KBOOK-216 by Gavin   */
                    td.innerHTML = seatName;
                    td.height = "50px";
                    td.width = "50px";
                    td.style.border = "solid 5px gray";
                    td.style.cursor = "pointer";
                    td.style.backgroundColor = "PaleGreen";
                    td.title = "可预订";
                    tr.appendChild(td); // 把td放到tr

                    /*fix tag KBOOK-216 by Gavin ---begin */
                    //add hidden td
                    var htd1 = document.createElement("td");
                    htd1.setAttribute("hidden", "true");
                    htd1.id = seatId + "ctn";
                    tr.appendChild(htd1); // 把td放到tr */

                    var htd2 = document.createElement("td");
                    htd2.setAttribute("hidden", "true");
                    htd2.id = seatId + "ost";
                    tr.appendChild(htd2); // 把td放到tr

                    var htd3 = document.createElement("td");
                    htd3.setAttribute("hidden", "true");
                    htd3.id = seatId + "oet";
                    tr.appendChild(htd3); // 把td放到tr

                    var htd4 = document.createElement("td");
                    htd4.setAttribute("hidden", "true");
                    htd4.id = seatId + "cit";
                    tr.appendChild(htd4); // 把td放到tr

                    var htd5 = document.createElement("td");
                    htd5.setAttribute("hidden", "true");
                    htd5.id = seatId + "sts";
                    tr.appendChild(htd5); // 把td放到tr
                    /*fix tag KBOOK-216 by Gavin ---end */

                }//end for

                seatTable.appendChild(tr); // 把tr放到table
                //alert("start>>>>>>");
            }
        });
    }

    function initFullSeat(storeId, typeId) { // 初始化满座的记录
        var myDate = new Date();
        var mytime = myDate.toLocaleTimeString();
        //var url = "${ctx}/system/seatStatus/getFullSeatJson?storeId="+ storeId + "&" + mytime;
        var url = "${ctx}/system/seatorder/getBookedSeatJson?"
            + "storeid="+ storeId
            + "&seatorderid="+seatorderid
            + "&orderFromTime=${seatOrder.orderFromTime}"
            + "&orderToTime=${seatOrder.orderToTime}"
            + "&orderDate=${seatOrder.orderDate}"
            +"&" + mytime;
        $
            .ajax({
                type : "GET",
                url : url,
                dataType : "json",
                success : function(json) {
                    for (var i = 0; i < json.rows.length; i++) {
                        var seatorderid = json.rows[i].id;
                        var fullSeatId = json.rows[i].seat.id;
                        var status = json.rows[i].status;
                        var color;
                        var title;
                        if(seatorderid== seatorderid){
                            color = "red";
                            title = "被预订";
                        }else{
                            if (status == 1) {
                                color = "pink";
                                title = "被预订";
                            } else if (status == 2) {
                                color = "yellow";
                                title = "使用中";
                            } else if (status == 3) {
                                color = "orange";
                                title = "请假中";
                            } else if (status == 6) {
                                color = "blue";
                                title = "不能预订";
                            } else {
                                color = "PaleGreen";
                                title = "可以预订";
                            }
                        }

                        document.getElementById(fullSeatId + "").style.backgroundColor = color;

                        document.getElementById(fullSeatId + "").title = title;

                        /*fxi tag KBOOK-216 by Gavin ---begin */
                        var customerName = json.rows[i].member.name;
                        var orderStartTime = json.rows[i].orderFromTime;
                        var orderEndTime = json.rows[i].orderToTime;
                        var checkInTime = json.rows[i].actualCheckInTime;
                        document.getElementById(fullSeatId + "ctn").innerHTML = customerName;
                        document.getElementById(fullSeatId + "ost").innerHTML = orderStartTime;
                        document.getElementById(fullSeatId + "oet").innerHTML = orderEndTime;
                        document.getElementById(fullSeatId + "cit").innerHTML = checkInTime;
                        document.getElementById(fullSeatId + "sts").innerHTML = status;

                        /*fxi tag KBOOK-216 by Gavin ---end */

                    }//end for
                }//end func
            });//end alax
    }

    //重新加载时清空一次table
    function clearTable() {
        var t1 = document.getElementById("seatTable");

        var rowNum = t1.rows.length;
        if (rowNum > 0) {
            for (var i = 0; i < rowNum; i++) {
                t1.deleteRow(i);
                rowNum = rowNum - 1;
                i = i - 1;
            }
        }
    }

    //转化日期
    function timeChange(time) {
        var actTime = "";

        if (time != null) {
            var ct = new Date();
            ct.setTime(time);

            var m;
            if (ct.getMinutes() < 10) {
                m = "0" + ct.getMinutes();
            } else {
                m = ct.getMinutes();
            }
            actTime = ct.getHours() + ":" + m;
        } else {
            actTime = "无";
        }
        return actTime;
    }
    //转化日期 yyyy-MM-dd hh :ss:mm
    function getLocalTime(nS) {
        return new Date(parseInt(nS) * 1000).toLocaleString().replace(
            /年|月/g, "-").replace(/日/g, " ");
    }

    function NowTime() {
        var nowDate = "";//当前时间
        var now = new Date();
        var hour = now.getHours();
        var minute = now.getMinutes();
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minute < 10) {
            minute = "0" + minute;
        }
        nowDate += now.getFullYear() + "-"; // 获取年份。
        nowDate += (now.getMonth() + 1) + "-"; // 获取月份。
        nowDate += now.getDate();
        nowDate += " " + hour + ":";
        nowDate += minute + ":";
        nowDate += "00";
        return nowDate;
    }

    function formatDate(now) {
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var date = now.getDate();
        var hour = now.getHours();
        var minute = now.getMinutes();
        var second = now.getSeconds();
        if (hour < 10) {
            hour = "0" + hour;
        }
        if (minute < 10) {
            minute = "0" + minute;
        }
        if (second < 10) {
            second = "0" + second;
        }

        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }

    /*fix tag KBOOK-216	by Gavin --- begin  */

    function over(e, obj) {
        var status = document.getElementById(obj.id + "sts").innerHTML;
        if (status != "") {
            showTip(e, obj);
        }

    }
    function out(obj) {
        $("#tooltip").remove();
    }

    function move() {
        $("#tooltip").css({
            "top" : (e.pageY + 5) + "px",
            "left" : (e.pageX + 2) + "px"
        });

    }
    function showTip(e, obj) {
        var seatId = obj.id
        var customerName = document.getElementById(seatId + "ctn").innerHTML;
        var orderStartTime = document.getElementById(seatId + "ost").innerHTML;
        if (orderStartTime != "") {
            orderStartTime = new Date(parseInt(orderStartTime))
                .format("yyyy-MM-dd HH:mm:ss");
        }
        var orderEndTime = document.getElementById(seatId + "oet").innerHTML;
        if (orderEndTime != "") {
            orderEndTime = new Date(parseInt(orderEndTime))
                .format("yyyy-MM-dd HH:mm:ss");
        }
        var checkInTime = document.getElementById(seatId + "cit").innerHTML;
        if (checkInTime != "") {
            checkInTime = new Date(parseInt(checkInTime))
                .format("yyyy-MM-dd HH:mm:ss");
        }
        var toolTip = "<div id='tooltip' class='tip' width='100px' height='12px' style='position:absolute;border:solid #aaa 1px;background-color:#F9F9F9'>";
        toolTip = toolTip
            + "<span class='angle'><i class='b'>◆</i><i class='t'>◆</i></span>";
        toolTip = toolTip + "<p> 客户姓名：" + customerName + "</p>";
        toolTip = toolTip + "<p> 订单开始时间:" + orderStartTime + "</p>";
        toolTip = toolTip + "<p> 订单结束时间:" + orderEndTime + "</p>";
        toolTip = toolTip + "<p> 签到时间:" + checkInTime + "</p>";
        toolTip = toolTip + "</div>";

        $("body").append(toolTip);
        $("#tooltip").css({
            "top" : (e.pageY - 160) + "px",
            "left" : (e.pageX + 20) + "px"
        });

    }

    //对Date的扩展，将 Date 转化为指定格式的String
    //月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    //年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    //例子：
    //(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
    //(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
    Date.prototype.Format = function(fmt) { //author: meizz
        var o = {
            "M+" : this.getMonth() + 1, //月份
            "d+" : this.getDate(), //日
            "h+" : this.getHours(), //小时
            "m+" : this.getMinutes(), //分
            "s+" : this.getSeconds(), //秒
            "q+" : Math.floor((this.getMonth() + 3) / 3), //季度
            "S" : this.getMilliseconds()
            //毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
                .substr(4 - RegExp.$1.length));
        for ( var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1,
                    (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k])
                        .substr(("" + o[k]).length)));
        return fmt;
    }

    // 更换提交
    function changeCommit(){
        var tid = $("td[class='choose']").attr("id");
        if(!tid || tid==undefined || tid==''){
            parent.$.messager.alert('提示',"请选择要更换的位置");
            return false;
        }

        parent.$.messager.confirm('提示', '确认更改吗？',function(data){
            if(data){
                $.ajax({
                    type:'get',
                    url:'${ctx}/system/seatorder/change?seatorderid='+seatorderid+'&seatid='+tid,
                    success:function(r){
                        if(r=='success'){
                            successTip("success",dg,d);
                            dg.treegrid('reload');
                        }else{
                            parent.$.messager.alert('提示',r);
                        }
                    }
                });

            }
        });
        console.log("${seatOrder}")
    }

    // 选中座位
    $("table[id='seatTable']").on("click","td:not([id^='tdhead_'])",function(){
        if(this.style.backgroundColor=='red'){
            parent.$.messager.alert('提示',"请选中请他座位");
            return false;
        }
        $("td[class='choose']").removeClass('choose').css("background-color","PaleGreen");
        $(this).addClass("choose");
        this.style.backgroundColor = "blue";
    });

</script>

</body>
</html>
