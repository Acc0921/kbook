<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body>
	<div>
		<form id="mainform" action="${ctx }/system/user/${action}"
			method="post">
			<table class="formTable">
				<tr>
					<td>用户名：</td>
					<td><input type="hidden" name="id" value="${id }" /> <input
						id="loginName" name="loginName" class="easyui-validatebox"
						data-options="width: 150" value="${user.loginName }"></td>
				</tr>

				<tr>
					<td>密码：</td>
					<td><input id="plainPassword" name="plainPassword"
						type="password" class="easyui-validatebox"
						data-options="width: 150,${action != 'update'?" required:'required',":"" }validType:'length[6,20]'"/></td>
				</tr>
				<c:if test="${action != 'update'}">
					<tr>
						<td>确认密码：</td>
						<td><input id="confirmPassword" name="confirmPassword"
							type="password" class="easyui-validatebox"
							data-options="width: 150,required:'required',validType:'equals[$(\'#plainPassword\').val()]'" /></td>
					</tr>
				</c:if>
				<tr>
					<td>昵称：</td>
					<td><input name="name" type="text" value="${user.name }"
						class="easyui-validatebox"
						data-options="width: 150,required:'required',validType:'length[3,20]'" /></td>
				</tr>
				<tr>
					<td>出生日期：</td>
					<td><input name="birthday" type="text" class="easyui-my97"
						datefmt="yyyy-MM-dd" data-options="width: 150"
						value="<fmt:formatDate value="${user.birthday}"/>" /></td>
				</tr>
				<tr>
					<td>性别：</td>
					<td><input type="radio" id="man" name="gender" value="1" /><label
						for="man">男</label> <input type="radio" id="woman" name="gender"
						value="0" /><label for="woman">女</label></td>
				</tr>
				<tr>
					<td>Email：</td>
					<td><input type="text" name="email" value="${user.email}"
						class="easyui-validatebox"
						data-options="width: 150,validType:'email'" /></td>
				</tr>
				<tr>
					<td>Wechat：</td>
					<td><input type="text" name="wechat" value="${user.wechat}"
						class="easyui-validatebox" data-options="width: 150" /></td>
				</tr>
				<tr>
					<td>电话：</td>
					<td><input type="text" name="phone" value="${user.phone }"
						class="easyui-numberbox" data-options="width: 150" /></td>
				</tr>
				<tr>
					<td>描述：</td>
					<td><textarea rows="3" cols="41" name="description"
							style="font-size: 12px; font-family: '微软雅黑'">${user.description}</textarea></td>
				</tr>
				<tr>
					<td>所属城市:</td>
					<td><input id="city" name="cityid" value="${user.cityid}"
						data-options="width: 138" />*</td>
				</tr>
				<tr>
					<td>所属门店:</td>
					<td><select id="store" name="storeid"
						data-options="width: 138">
							<option value=""></option>
					</select>*</td>
					<td style="display: none;" id="test">${user.storeid}</td>
				</tr>
			</table>
		</form>
	</div>

	<script type="text/javascript">
		var action = "${action}";
		//用户 添加修改区分
		if (action == 'create') {
			$("input[name='gender'][value=1]").attr("checked", true);
			//用户名存在验证
			$('#loginName').validatebox(
					{
						required : true,
						validType : {
							length : [ 2, 20 ],
							remote : [ "${ctx}/system/user/checkLoginName",
									"loginName" ]
						}
					});
		} else if (action == 'update') {
			$("input[name='loginName']").attr('readonly', 'readonly');
			$("input[name='loginName']").css('background', '#eee')
			$("input[name='gender'][value=${user.gender}]").attr("checked",
					true);
		}

		//提交表单
		$('#mainform').form({
			onSubmit : function() {
				var isValid = $(this).form('validate');
				return isValid; // 返回false终止表单提交
			},
			success : function(data) {
				successTip(data, dg, d);
			}
		});

		$(document).ready(function(){
			var sID=$("#test").html();
			var city=$("#city").val();
			$("#store").combobox();
			if(city!=""){
				if(sID!=""){
					storeAdd(city,sID);
				}else{
					storeAdd(city,'');
					$("input[name='storeid']").val('');
				}
			}
			
		});
		/* Array.prototype.insert = function (index, item) {
		  this.splice(index, 0, item);
		}; */
		//适用城市
		$.ajax({
			type : "GET",
			url : "${ctx}/system/city/getAllJson",
			dataType : "json",
			success : function(json) {
				json.rows.splice(0,0,{"id":'',"name":"请选择"});
				console.log(JSON.stringify(json.rows));
				$("#city").combobox({
					data : json.rows,
					parentField : 'city',
					valueField : 'id',
					textField : 'name',
					iconCls : 'icon',
					editable : false,
					animate : true
				});
			}
		});

		var cityId;
		$("#city").combobox({ //选择城市的时候带门店出来\
			onChange : function(newValue,oldValue) {
				storeAdd(newValue, "");
			}
		});

		function storeAdd(obj, value) {
			var url = "${ctx}/system/store/getStoreByCityId?cityId=" + obj;
			var storeId = value;
			if (obj != null || obj != "") {
				//门店加载
				$.ajax({
					type : "POST",
					url : url,
					dataType : "json",
					success : function(json) {
						json.rows.splice(0,0,{"id":'',"name":"请选择"});
						$("#store").combobox({
							data : json.rows,
							parentField : 'store',
							valueField : 'id',
							value : storeId,
							textField : 'name',
							iconCls : 'icon',
							editable : false,
							animate : true
						});
					}
				});
			}
		}
	</script>
</body>
</html>