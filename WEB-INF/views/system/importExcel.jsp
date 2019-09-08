<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title></title>
<%@ include file="/WEB-INF/views/include/easyui.jsp"%>
<script src="${ctx}/static/plugins/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
	
	function add(){
		$('#mainform').form({    
		    onSubmit: function(){    
		    	var isValid = $(this).form('validate');
				return isValid;	// 返回false终止表单提交
		    },    
		    success:function(data){   
				$.messager.alert("操作提示", "上传成功！");
		    }    
		}); 
	}
	
</script>
</head>
<body style="font-family: '微软雅黑'">
	<form id="mainform" action="${ctx}/system/import/create" method="post" enctype="multipart/form-data">
		<table class="formTable">
			<tr>
				<td colspan=4 width="120px" valign="top" align="center">
				  <div align="center">
	                    <input class="easyui-validatebox" type="hidden" id="Attachment_GUID" name="Attachment_GUID" />
	                    <br/>
	                    	<input id="fileurl" name="fileurl" type="file" multiple="multiple"/>
	                    <br />
                	</div>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="上传+导入" onclick="add()"/>
				</td>
				
			</tr>
		</table>
	</form>

</body>
</html>