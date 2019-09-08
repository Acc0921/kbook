<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
<script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

</head>
<body style="font-family: '微软雅黑'">
	<div id="tb" style="padding: 5px; height: auto">
		<form id="searchFrom" action="">
<%-- 			<shiro:hasPermission name="sys:payLog:view">
				<a href="javascript(0)" class="easyui-linkbutton"
					iconCls="icon-search" plain="true" onclick="cx()">查询</a>
			</shiro:hasPermission> --%>
			<shiro:hasPermission name="sys:payLog:exportExcel">
				<a href="#" class="easyui-linkbutton" plain="true"
					iconCls="icon-standard-page-excel" onclick="exportExcel(1)">导出Excel</a>
			</shiro:hasPermission>
		</form>
	</div>
	<table id="dg"></table>
	<div id="dlg"></div>
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

		var dg;
		$(function() {
			dg = $('#dg').datagrid(
					{ 						
						url : '${ctx}/system/payLog/checkBillList/'+${storeId}+'/'+${checkBillDate}+'/'+${orderType},
					    sortOrder: 'desc',
					    sortName: 'id',
					    fit : true,
						fitColumns : true,
						border : false,
						singleSelect:true,
						striped:true,
						idField : 'id',
						pagination:true,
						rownumbers:true,
						pageNumber:1,
						pageSize : 30,
						pageList : [ 10, 20, 30, 40, 50 ],
						columns : [ [ {
							field : 'ck',
							checkbox : true
						},{
							field : 'bizOrderNo',
							title : '订单号',
							sortable : true
						},{
                            field : 'storeName',
                            title : '门店名称',
                            sortable : true
                        },{
                            field : 'goodsName',
                            title : '产品名称',
                            sortable : true
                        }, {
                            field : 'username',
                            title : '会员名称',
                            sortable : true
                        }, {
                            field : 'doubleAmount',
                            title : '支付金额',
                            sortable : true
                        }, {
                            field : 'doubleFee',
                            title : '手续费',
                            sortable : true
                        }, {
                            field: 'sysStatus',
                            title: '对账状态',
                            sortable: true,
                            formatter : function(value, row, index) {
	                				var operatorname;
	                				if(row.sysStatus == 0){
	                					operatorname = "对账符合";
	                				}else if(row.sysStatus == 1){
	                					operatorname = "未对账";
	                				}else if(row.sysStatus == 2){
	                					operatorname = "对账不符合";
	                				}
	                   			return operatorname;
	            			}
                        }, {
                            field: 'i41',
                            title: '对账前支付状态',
                            sortable: true,
                            formatter : function(value, row, index) {
                				var operatorname;
                				//1未支付  3交易失败  4交易成功  5交易成功发生退款   6关闭  99进行中
                				if(row.i41 == 1){
                					operatorname = "未支付";
                				}else if(row.i41 == 3){
                					operatorname = "交易失败";
                				}else if(row.i41 == 4){
                					operatorname = "交易成功";
                				}else if(row.i41 == 5){
                					operatorname = "交易成功发生退款";
                				}else if(row.i41 == 6){
                					operatorname = "关闭";
                				}else if(row.i41 == 99){
                					operatorname = "进行中";
                				}else{
                					operatorname = row.statusName;
                				}
                   			return operatorname;
            			}
                        }, {
                            field: 'statusName',
                            title: '对账后支付状态',
                            sortable: true
                        }, {
                            field: 'createDatetime',
                            title: '创建订单时间',
                            sortable: true
                        }, {
                            field: 'updateDatetime',
                            title: '最后更新时间',
                            sortable: true
                        } ] ],
						headerContextMenu : [
								{
									text : "冻结该列",
									disabled : function(e, field) {
										return dg.datagrid("getColumnFields",
												true).contains(field);
									},
									handler : function(e, field) {
										dg.datagrid("freezeColumn", field);
									}
								},
								{
									text : "取消冻结该列",
									disabled : function(e, field) {
										return dg.datagrid("getColumnFields",
												false).contains(field);
									},
									handler : function(e, field) {
										dg.datagrid("unfreezeColumn", field);
									}
								} ],
						enableHeaderClickMenu : true,
						enableHeaderContextMenu : true,
						enableRowContextMenu : false,
						rowTooltip : true,
						toolbar : '#tb'
					});
		});

		//弹窗增加
		/*function add() {
			d = $("#dlg").dialog({
				title : '添加城市',
				width : 380,
				height : 250,
				href : '/system/city/create',
				maximizable : true,
				modal : true,
				buttons : [ {
					text : '确认',
					handler : function() {
						$("#mainform").submit();
					}
				}, {
					text : '取消',
					handler : function() {
						d.panel('close');
					}
				} ]
			});
		}*/
		
		//add:yangzh by 2018-04-16 start
		var sID=$("#test").html();
		$(document).ready(function(){
		    var city=$("#selectCity").val();
		    $("#selectStore").combobox();
		    if(city!=""){
		        if(sID!=""){
		            storeAdd(city,sID);
		        }else{
		            storeAdd(city,1);
		        }
		    }
		});

		var cityRows;
		//所属城市
		$.ajax({
		    type: "GET",
		    url: "${ctx}/system/city/getAllJson",
		    dataType:"json",
		    success: function(json){
		        $("#selectCity").combobox({
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

		//所属门店
		var cityId;
		$("#selectCity").combobox({ //选择城市的时候带门店出来\
		    onChange : function(oldValue, newValue) {
		        for ( var i = 0; i < cityRows.length; i++) {
		            if ($("#selectCity").combobox('getValue') == cityRows[i].id) {
		                cityId=cityRows[i].id;
		            }
		        }
		        //storeAdd(cityId,"请选择");
		        storeAdd(cityId,"");
		    }
		});

		//add:yangzh by 019-01-25 start

		//所属门店
		$.ajax({
		    type: "GET",
		    url: "${ctx}/system/store/getAllJson",
		    dataType:"json",
		    success: function(json){
		        $("#selectStore").combobox({
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

		/* if(${roleCode.equals("store_manager")}){
		    if(${cityId!=null && !cityId.equals("")}){
		        $("#selectCity").combobox('setValue','${cityId}');
		        storeAdd("${cityId}", "");
		        if(${storeId!=null && !storeId.equals("")}){
		            $("#selectStore").css("display","none");
		            storeAdd("${cityId}", "${storeId}");
		        }else{
		            $("#selectStore").css("display","block");
		        }
		    }else{
		        $("#selectCity").css("display","block");
		    }
		} */
		//add:yangzh by 019-01-25 end

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
		                $("#selectStore").combobox({
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


		//弹窗修改
		function upd() {
			var row = dg.datagrid('getSelected');
			if (rowIsNull(row))
				return;
			d = $("#dlg").dialog({
				title : '修改交易日志',
				width : 380,
				height : 340,
				href : '${ctx}/system/payLog/update/' + row.id,
				maximizable : true,
				modal : true,
				buttons : [ {
					text : '修改',
					handler : function() {
						$('#mainform').submit();
					}
				}, {
					text : '取消',
					handler : function() {
						d.panel('close');
					}
				} ]
			});
		}

		//创建查询对象并查询
/*  		function cx(){
			var obj = $("#searchFrom").serializeObject();
			dg.datagrid('load',obj); 
			dg.datagrid({url:'${ctx}/system/payLog/json'});
		}  */

		$(document).ready(function() {
			document.onkeydown = function(event) {
				if (event.keyCode == 13) { // enter 键
					//cx();
					return false;
				}
			};
		});
		
		//导出excel
		function exportExcel(type){
				
				try{
				var pageNo = 1;
				var pageSize = 30;
				var pageopt = $('#dg').datagrid('getPager').data("pagination").options;
				pageNo = pageopt.pageNumber;
				pageSize = pageopt.pageSize;
			
				var opts = $('#dg').datagrid('getColumnFields'); //这是获取到所有的FIELD
				var colName=[];
				var colField=[];
				var currDatas=[];
				for(i=0;i<opts.length;i++)
				{
					var col = $('#dg').datagrid( "getColumnOption" , opts[i] );
					var headField = col.title;
					if(headField != undefined){
						colName.push(col.title);//把TITLEPUSH到数组里去
						colField.push(col.field);

					}
				}
				var rows = $('#dg').datagrid('getRows');
				for(var key in rows){
					if(rows[key].id != undefined){
		            	currDatas.push(rows[key]);
		            }
		        }  
		        
		        var searchDatas = JSON.stringify($("#searchFrom").serializeArray());
		        
					 var form = $("<form>");
			 			form.attr('style','display:none');
			 			form.attr('target','');
			 			form.attr('method','post');
			 			form.attr('action','${ctx}/system/payLog/exportExcel');
			 			
			 			var input0 = $('<input>');
			 				input0.attr('type','hidden');
							 input0.attr('name','title');
							 input0.attr('value', '支付订单信息');	 
			 
			 			var input1 = $('<input>');
			 				input1.attr('type','hidden');
			 				input1.attr('name','headers');
			 				input1.attr('value',colName);

			 			var input2 = $('<input>');
			 				input2.attr('type','hidden');
							 input2.attr('name','fields');
							 input2.attr('value',colField);
						
						var input3 = $('<input>');
			 				input3.attr('type','hidden');
							 input3.attr('name','datas');
							 input3.attr('value', JSON.stringify(rows));
							console.log(rows);
						var input4 = $('<input>');
			 				input4.attr('type','hidden');
							 input4.attr('name','searchDatas');
							 input4.attr('value', searchDatas);	 				

						var input5 = $('<input>');
			 				input5.attr('type','hidden');
							 input5.attr('name','all');
							 input5.attr('value', type);
							 
						 $('body').append(form);
						 form.append(input0);
						 form.append(input1);
						 form.append(input2);
						 form.append(input3);
						 form.append(input4);
						 form.append(input5);
			 
						 form.submit();
						 form.remove();   
				}catch(e){
					alert(e);
				}
		}
	</script>
</body>
</html>