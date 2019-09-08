<% 
//Amendment by Gavin
//Amendment Date: 2015110
//Fix Tag: 20151110
//Desc: add new attribute "职业"
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serverpath" value="${pageContext.request.serverName}:${pageContext.request.serverPort}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>

</head>
<body >
<div>
	<form id="mainform" action="${ctx}/system/member/${action}" method="post"  enctype="multipart/form-data">
	<table  class="formTable">
		<tr>
			<td>会员名称：</td>
			<td>
			<input  type="hidden" name="id" value="${id }" />
			<input id="name" name="name" type="text" value="${member.name }" class="easyui-validatebox" required="required" data-options="width: 138"/>*
			</td>
			<td rowspan=15 width="120px" valign="top" align="center">
			   <br/>	<br/>
				  <div align="center" style="text-align:center;">
				   <label for="Attachment_GUID">当前头像</label><br/>
				   	<c:if test="${empty member.imageurl}">
				   	<img border=1 src="${ctx }/static/images/user_72.png" id="img0" width="106px" height="106px" style="cursor:pointer;border-color:#eee"/><br/>
				   	</c:if>
				   	<c:if test="${!empty member.imageurl}">
				  	<img border=1 src="${ctx }/resources/userphoto/${member.imageurl}" id="img0" width="106px" height="106px" style="cursor:pointer;border-color:#eee"/><br/>
				  	</c:if>
				    <br/>
                    <input class="easyui-validatebox" type="hidden" id="Attachment_GUID" name="Attachment_GUID" />
                    <br/>
                    	选择文件修改头像：
                    	<br/><input id="imageurl" name="imageurl" type="file" multiple="multiple" accept="image/gif, image/jpeg, image/png"/>
                    <br />
                </div>
			</td>
		</tr>
		<tr>
			<td>帐号：</td>
			<td>
			<input id="account" name="account" value="${member.account }"  class="easyui-validatebox" required="required"  ${action eq "update"?"readonly":""} data-options="width: 138" />*
			</td>
		</tr>
		<tr>
			<td>密码：</td>
			<td>
			<!-- dawson修改，使用明文密码  -->
			<input id="password" name="password" type="password" value="${member.plainPassword}" class="easyui-validatebox" data-options="width: 138,"${action eq"update"?"":""}/>*
			</td>
		</tr>
		
		<tr>
			<td>性别：</td>
			<td>
			<input type="radio" id="man" name="sex" value="1"/><label for="man">男</label>
			<input type="radio" id="woman" name="sex" value="0"/><label for="woman">女</label>
			</td>
		</tr>
		<tr>
			<td>手机：</td>
			<td>
			<input id="tel" name="tel" type="text" value="${member.tel}" class="easyui-validatebox" required="required" data-options="validType:'customMoblie',width:138" />*
			</td>
		</tr>
		<tr>
			<td>微信：</td>
			<td>
			<input id="wechat" name="wechat" type="text" value="${member.wechat }" class="easyui-validatebox" data-options="width: 138"/>
			</td>
		</tr>

		<tr>
			<td>紧急联系人电话：</td>
			<td>
			<input id="emgergencycontact" name="emgergencycontact" type="text" value="${member.emgergencycontact }" class="easyui-validatebox" data-options="validType:'telOrMobile',width: 138"/>
			</td>
		</tr>
		<tr>
			<td>身份证：</td>
			<td>
			<input id="iddocument" name="iddocument" type="text" value="${member.iddocument }" class="easyui-validatebox" data-options="validType:'idCard',width: 138"/>
			</td>
		</tr>
		<tr>
			<td>会员卡：</td>
			<td>
			<input id="cardid" name="cardid" value="${member.cardid }"  class="easyui-validatebox" required="required" data-options="validType:'cardRex',width: 138"  />*
			</td>
		</tr>
		<tr id="trBalance">
			<td>剩余点数：</td>
			<td>
			<input id="balance" name="balance" value="${productOrder.balance}" class="easyui-validatebox" data-options="width: 138" readonly/>点
			</td>
		</tr>
		<tr>
			<td>联系地址：</td>
			<td>
			<input id="address" name="address" type="text" value="${member.address }" class="easyui-validatebox" data-options="width: 138"/>
			</td>
		</tr>
		<tr>
			<td>所属城市:</td>
			<td><input id="city" name="city.id" value="${member.cityId}" required="required" data-options="width: 138"/>*</td>
		</tr>
		<tr>
			<td>所属门店:</td>
			<td><select id="store" name="store.id" required="required"  data-options="width: 138">
					<option value=""></option>
				</select>*
			</td>
			<td style="display:none;" id="test">${member.storeId}</td>
		</tr>
		<!--fix tag 2015年11月10日 by Gavin ---begin -->
		<tr>
			<td>职业：</td>
			<td>
			<select id="career" name="career" required="required" data-options="width: 138">
				<option value="1" >自由</option>
				<option value="2" >学生</option>
				<option value="3" >在职</option>
			</select>
			</td>
		</tr>
		<!--fix tag 2015年11月10日 by Gavin ---end -->
		<tr id = "schoolTR"> <!--fix tag 20151110 by Gavin ---update for new attribute "职业"  -->
			<td>所在学校：</td>
			<td>
			<input id="school" name="school" type="text" value="${member.school }" class="easyui-validatebox" data-options="width: 138"/>
			</td>
		</tr>
		<tr id = "gradeTR"> <!--fix tag 20151110 by Gavin ---update for new attribute "职业"  -->
			<td>年级：</td>
			<td>
			<select id="grade" name="grade"  data-options="width: 138">
					<option value="初一" >初一</option>
					<option value="初二">初二</option>
					<option value="初三">初三</option>
					<option value="高一">高一</option>
					<option value="高二">高二</option>
					<option value="高三">高三</option>
					<option value="大一">大一</option>
					<option value="大二">大二</option>
					<option value="大三">大三</option>
					<option value="大四">大四</option>
					<option value="研一">研一</option>
					<option value="研二">研二</option>
					<option value="研三">研三</option>
					<option value="研四">研四</option>
					<option value="研五">研五</option>
					<option value="博士">博士</option>
					<option value="博士后">博士后</option>
					<option value="小一">小一</option>
					<option value="小二">小二</option>
					<option value="小三">小三</option>
					<option value="小四">小四</option>
					<option value="小五">小五</option>
					<option value="小六">小六</option>
			</select>
			</td>
		</tr>
		<tr id = "companyTR"> <!--fix tag 20151110 by Gavin ---update for new attribute "职业"  -->
			<td>公司：</td>
			<td>
			<input id="company" name="company" type="text" value="${member.company}" class="easyui-validatebox" data-options="width: 138"/>
			</td>
		</tr>
		<tr id = "positionTR"> <!--fix tag 20151110 by Gavin ---update for new attribute "职业"  -->
			<td>职位：</td>
			<td>
			<input id="position" name="position" type="text" value="${member.position }" class="easyui-validatebox" data-options="width: 138"/>
			</td>
		</tr>
		<tr>
			<td>目标：</td>
			<td>
			<input id="target" name="target" type="text" value="${member.target}" class="easyui-validatebox" required="required"  data-options="width: 138"/>*
			</td>
		</tr>
		<tr>
			<td>用户来源：</td>
			<td>
			<select id="channel" name="channel" required="required"  data-options="width: 138">
					<option value="网站" >网站</option>
					<option value="微信公众号">微信公众号</option>
					<option value="朋友推荐">朋友推荐</option>
					<option value="自己看见">自己看见</option>
					<option value="百度">百度</option>
					<option value="知乎">知乎</option>
					<option value="美团大众点评">美团大众点评</option>
					<option value="微信朋友圈">微信朋友圈</option>
					<option value="其他">其他</option>
			</select>*
			
			</td>
		</tr>
		<tr>
			<td>备注：</td>
			<td>
			<input id="remark" name="remark" type="text" value="${member.remark}" class="easyui-validatebox" data-options="width: 138"/>
			</td>
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
<script src="${ctx}/static/plugins/easyui/jeasyui-extensions/jeasyui.extensions.validatebox.js"></script>
<script type="text/javascript">

var action="${action}";
//用户 添加修改区分
if(action=='create'){
	$("input[name='sex'][value=1]").attr("checked",true);
	$("#password").attr('required','required');
	$("#trBalance").css('display','none');
}else if(action=='update'){
	$("input[name='sex'][value=${member.sex}]").attr("checked",true);
	$("#account").attr('readonly',true); /* fix tag 2015年12月21日 by Gavin --- 改为true-不能修改账号 */
	var balance=$("#balance").val();
	if(balance==""){
		$("#balance").val("尚未购买产品");
		$("#balance").attr('readonly',true);
		
	}
}


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

 //自定义验证
 $.extend($.fn.validatebox.defaults.rules, {

 	cardRex: {
	    validator: function(value){
		  	var account =$("#account").val();
		    if(value!=account){
		      return true;
		    }else{
		       return false;
		    } 
	    },
   		 message:'卡号与帐号不能相同'
 	 },

}); 




 var memberId;
$(function(){
 
	
	$('#mainform').form({    
	    onSubmit: function(){    	    	
	    	var isValid = $(this).form('validate');
	    	if(isValid){
				var r = confirm("请确认会员信息");
				if(r == false){
					isValid = false;
				}
			}
	    	return isValid;	// 返回false终止表单提交
	    },    
	    success:function(data){   
	    	var successforId="success:";
	    	var memberId;
	    	if(data.indexOf(successforId)!= -1){
	    		memberId=data.substring(8,data.lenght);
	    		data = "success";
	    		successTip("success",dg,d);
	    	}else{
	    		successTip(data,dg,d);
	    	}
	    	
			if(action=="create"&&data=="success"){
			
	    	ask =$('#ask').dialog({
	    		title: '亲，是否直接购买产品？', 
	    		width: 200,    
	    	    height: 150,  
	    	    maximizable:true,
	    	    closed: false,   
	            cache: false,
	    	    modal:true,
	    	    buttons:[{
	    			text:'马上购买产品',
	    			handler:function(){
	    				dbuy = $("#dlg").dialog({   
	    		    	    title: '购买产品',    
	    		    	    width: 580,    
	    		    	    height: 350,    
	    		    	    href:'${ctx}/system/productOrder/create?'
	    		    	    		+'memberId='+memberId+'&flag=1' ,
	    		    	    maximizable:true,
	    		    	    modal:true,
	    		    	    buttons:[{
	    		    			text:'确认',
	    		    			handler:function(){
	    		    				ask.panel('close');
	    		    				$("#mainform").submit(); 
	    		    			}
	    		    		},{
	    		    			text:'取消',
	    		    			handler:function(){
	    		    				dbuy.panel('close');
	    		    				ask.panel('close');
	    		    				}
	    		    		}]
	    		    	});
	    			}
	    		},{
	    			text:'取消',
	    			handler:function(){
	    				ask.panel('close');
	    				}
	    		}]
	    	})
		  }
	    }    
	}); 
	
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
	 

/* fix tag 2015年11月10日 by Gavin --- begin */
if(action=='create'){
	$('#career').combobox({
	   	 onLoadSuccess:function(){
	        $('#career').combobox("setValue","2"); //这里写设置默认值，
	        setLayout("2");		
	    },
	
		onChange : function(newValue, oldValue) {
		setLayout(newValue);
		}
	    
	});
	
	$('#grade').combobox({
	   	 onLoadSuccess:function(){
	        $('#grade').combobox("setValue","初一");//这里写设置默认值
	    }
	});
	
	$('#channel').combobox({
	   	 onLoadSuccess:function(){
	        $('#channel').combobox("setValue","网站");//这里写设置默认值，
	       
	    }
	});

	
} else if ( action=='update') {
	
	 $('#career').combobox({
	  	 onLoadSuccess:function(){
	  		 var careerValue = "${member.career}";
	  		 if(careerValue ==null || careerValue == ""){
	  			careerValue = '1';
	  		 } 
	  		$('#career').combobox({ editable:false });
	  		$('#career').combobox("setValue",careerValue);	
	 		 setLayout(careerValue); 		 
	   },
		onChange : function(newValue, oldValue) {
			setLayout(newValue);
		}
	});
	
	$('#grade').combobox({
	   	 onLoadSuccess:function(){
			$('#grade').combobox({ editable:false });
	        $('#grade').combobox("setValue","${member.grade}");//这里写设置默认值
	    }
	});

	$('#channel').combobox({
	   	 onLoadSuccess:function(){
			$('#channel').combobox({ editable:false });
	        $('#channel').combobox("setValue","${member.channel}");//这里写设置默认值，
	       
	    }
	});
	
}	

function setLayout(career){
	if (career == '1'){//自由
		$("#schoolTR").hide();
		$("#gradeTR").hide();
		$("#companyTR").hide();
		$("#positionTR").hide();
	}	
	if (career == '2'){//学生
		$("#schoolTR").show();
		$("#gradeTR").show();
		$("#companyTR").hide();
		$("#positionTR").hide();
	}
	if (career == '3'){//在职
		$("#schoolTR").hide();
		$("#gradeTR").hide();
		$("#companyTR").show();
		$("#positionTR").show();
	}	
}
/* fix tag 2015年11月10日 by Gavin --- end */

$('#img0').click(function(){
	$('#imageurl').click();
});
	
$("#imageurl").change(function(){
	var objUrl = getObjectURL(this.files[0]);
	if (objUrl) {
		$("#img0").attr("src", objUrl) ;
	}
}) ;
//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null ; 
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}

</script>
</body>
</html>