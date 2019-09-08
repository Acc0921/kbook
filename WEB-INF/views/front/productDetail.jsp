<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	 <!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>产品详情</title>
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
  			border:solid 0px gray; 
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
			 <table id="productDetail" width="100%"  style="font-size:1.2em;">
		
		   	 </table>
	   	 </form>
	   	 <br/>
	 
 	 	<div align="center" style="display:none">
			<input id="productId" type="text" name="productId" value="${productId}" style="display:block;"/>
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
   		initProductDetail();
   	}
   	
   // 初始化seatOrder的物理表格
   		function initProductDetail(){
   			var id=$('#productId').val();
   			var url = "${ctx}/front/member/getProductDetail?id="+id;
			$.ajax({
			   type: "GET",
			   url: url,
			   dataType:"json",
			   success: function(json){
			    	var tab = document.getElementById("productDetail");
			    	var tr = document.createElement("tr");
			    	if(json.rows.length>0){
			   				for(var i = 0; i < json.rows.length;i++){
				    		if(i%2==0){ //每1个换下行
				    			tab.appendChild(tr); // 把tr放到table
				    			tr0 = document.createElement("tr");
				    			tr1 = document.createElement("tr");
				    			tr2 = document.createElement("tr");
				    			tr3= document.createElement("tr");
				    			tr4 = document.createElement("tr");
				    			tr5 = document.createElement("tr");
				    			
				    		}
				    		var id = json.rows[i].id;
				    		var productName=json.rows[i].product.name;
				    		var actualValue=json.rows[i].actualValue;
				    		var consumerType=json.rows[i].consumerType;
				    		var effectiveFromDate=json.rows[i].effectiveFromDate;
				    		var effectiveToDate = json.rows[i].effectiveToDate;
				    		var discount=json.rows[i].discount;
				    		var balance=json.rows[i].balance;
				    		var cityName=json.rows[i].product.city.name;
				    		
				    		var td0= document.createElement("td");
				    		var td1= document.createElement("td");
				    		var td2= document.createElement("td");
				    		var td3= document.createElement("td");
				    		var td4= document.createElement("td");
				    		var td5= document.createElement("td");
				    		var td6= document.createElement("td");
				    		var td7= document.createElement("td");
				    		var td8= document.createElement("td");
				    		var td9= document.createElement("td");
				    		var td10= document.createElement("td");
				    		var td11= document.createElement("td");
				    		
				    		
				    		
				    		td0.id=id;
				    		td0.innerHTML="产品名称:";
				    		td0.style.width="30%";
				    		td0.style.textAlign="center";
				    		td1.innerHTML=productName;
				    		td1.style.width="60%";
				    		td1.style.textAlign="left";
				    		tr0.appendChild(td0); 
				    		tr0.appendChild(td1);
				    		
				    		
				    		td2.innerHTML="消费点数:";
				    		td2.style.width="30%";
				    		td2.style.textAlign="center";
				    		td3.innerHTML=balance + " 点";
				    		td3.style.width="60%";
				    		td3.style.textAlign="left";
				    		tr1.appendChild(td2); 
				    		tr1.appendChild(td3);
				    		
				    		td4.innerHTML="消费人群:";
				    		td4.style.width="30%";
				    		td4.style.textAlign="center";
				    		td5.innerHTML=consumerType;
				    		td5.style.width="60%";
				    		td5.style.textAlign="left";
				    		tr2.appendChild(td4); 
				    		tr2.appendChild(td5);
				    		
				    		td6.innerHTML="产品折扣:";
				    		td6.style.width="30%";
				    		td6.style.textAlign="center";
				    		td7.innerHTML=discount;
				    		td7.style.width="60%";
				    		td7.style.textAlign="left";
				    		tr3.appendChild(td6); 
				    		tr3.appendChild(td7);
				    		
				    		td8.innerHTML="适用城市:";
				    		td8.style.width="30%";
				    		td8.style.textAlign="center";
				    		td9.innerHTML=cityName;
				    		td9.style.width="60%";
				    		td9.style.textAlign="left";
				    		tr4.appendChild(td8); 
				    		tr4.appendChild(td9);
				    		
				    		td10.innerHTML="有效日期:";
				    		td10.style.width="30%";
				    		td10.style.textAlign="center";
				    		td11.innerHTML=effectiveFromDate+"至"+effectiveToDate;
				    		td11.style.width="60%";
				    		td11.style.textAlign="left";
				    		tr5.appendChild(td10); 
				    		tr5.appendChild(td11);
		    					
				    	}//end for
				    	tab.appendChild(tr0);
				    	tab.appendChild(tr1);
				    	tab.appendChild(tr2);
				    	tab.appendChild(tr3);
				    	tab.appendChild(tr4);
				    	tab.appendChild(tr5);
				   	}else{
				   		var tr0 = document.createElement("tr");
				   		var td1= document.createElement("td");
			    		td1.style.textAlign = "left";
			    		td1.style.fontSize="1.4em";
			    		td1.style.borderStyle="none";
			    		td1.innerHTML ="亲，您没有生效的产品";
			    		tr0.appendChild(td1); 
			    		tab.appendChild(tr0);
				   	}
			   	}
			 });
   		}
		
   		 //删除行
    function deleterow(){
     	//得到table对象
    	var productDetail = document.getElementById("productDetail");
    	//获取行的第一个单元格
    	var tr = productDetail.getElementsByTagName("tr")[0]; 
     	//得到table中的行对象数组
    	 var arr=productDetail.rows;
	     if(arr.length>1){
    	 tr.parentNode.removeChild(tr); 
	    }
    }	
   	 $("#back").click(function() {  
       	window.history.back();
    });	
	</script>
  	<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$.backstretch("${ctx}/static/images/1.jpg");
    	});
    </script>
  </body>
</html>