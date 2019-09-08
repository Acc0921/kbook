<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的产品</title>
    <%@ include file="/WEB-INF/views/include/context.jsp"%>
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css" rel="stylesheet" type="text/css"  >
    
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-buttons.css" rel="stylesheet" type="text/css"  >
    <link href="${ctx}/static/bootstrap3.0/css/bootstrap-datetimepicker.min.css" rel="stylesheet"  type="text/css" >
    <script src="${ctx}/static/bootstrap3.0/js/bootstrap.min.js"></script>
    
    <script src="${ctx}/static/bootstrap3.0/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script src="${ctx}/static/bootstrap3.0/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
   
  	<style type="text/css">
  		table tr td{
  			padding:5px;
  			border:solid 2px gray; 
  			text-align:center;
  			height :auto;
  			width : auto;
  			background-Color : #EEE;
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
  	</style>
  </head>
  <body onload="init()">
  <br/>
  	 <div class="container" align="center">
  	 	<div class="well center-block" style="max-width: 500px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
  	 	 <form action="" method="post">	 
			 <table id="productList" width="100%"  style="font-size:1.2em;">
			 	<tr>
			 		<td>产品名称</td>
			 		<td>剩余可消费点数</td>
			 	</tr>
		   	 </table>
	   	 </form>
	   	 <br/>		
 	  	  <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="buy" onclick="buy()">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">我要购买</button>
			</a>
			<br/>
		
			<a id="goProductHistory" onclick="window.location.href='${ctx}/front/member/history'">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">产品购买记录</button>
			</a>
		  </div>
	      <div  style="margin-bottom:15px;letter-spacing:4px;">
			<a id="back" onclick="window.location.href='${ctx}/front/member/memberMenu';">
			<button type="button" class="btn btn-success btn-lg btn-block btn-fontsize">知道了</button>
			</a>
		  </div>
	    </div>
	</div>
  <br/>	
  	<script type="text/javascript">
 		function init(){
	   		initMyProductTable();
	   	}
		// 初始化我的产品
   		function initMyProductTable(){
			$.ajax({
			   type: "GET",
			   url: "${ctx}/front/member/myProductJson",
			   dataType:"json",
			   success: function(json){
			   		var productList = document.getElementById("productList");
				    var tr = document.createElement("tr");
			   		if(json.rows.length>0){
			   			
				    	for(var i = 0; i < json.rows.length;i++){
				    		if(i%1==0){ //每3个换下行
				    			productList.appendChild(tr); // 把tr放到table
				    			tr = document.createElement("tr");
				    		}
				    		var id = json.rows[i].id;
				    		
				    		var productName=json.rows[i].product.name;
				    		var balance=json.rows[i].balance;
				    	
				    		var td1= document.createElement("td");
				    		var td2= document.createElement("td");
				    		
				    		td1.innerHTML=productName;
				    		td2.innerHTML=balance;
				    		
				    		tr.appendChild(td1);
				    		tr.appendChild(td2);
				    		tr.id=id;
				    		tr.onclick=function(){
 								window.location.href='${ctx}/front/member/productDetail?productId='+this.id;
							}
							
				    	}//end for
				    	productList.appendChild(tr);
				   	}else{
				   		var tr0 = document.createElement("tr");
				   		var td1= document.createElement("td");
			    		td1.style.textAlign = "left";
			    		td1.style.fontSize="1.4em";
			    		td1.style.borderStyle="none";
			    		td1.innerHTML ="亲，您没有生效的产品";
			    		tr0.appendChild(td1); 
			    		productList.appendChild(tr0);
				   	}
				   deleterow();
			   	}
			    
			 });
   		}
   		
   		 //删除行
    function deleterow(){
     	//得到table对象
    	var productList = document.getElementById("productList");
    	//获取行的第一个单元格
    	var tr = productList.getElementsByTagName("tr")[1]; 
     	//得到table中的行对象数组
    	 var arr=productList.rows;
	     if(arr.length>1){
    	 tr.parentNode.removeChild(tr); 
	    }
    }	
   		
		function buy(){
			alert("此功能暂未开放,敬请期待");
		}
	</script>
  	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$.backstretch("${ctx}/static/images/1.jpg");
    	});
    </script>
  </body>
</html>