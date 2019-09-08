<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- <%@page import="com.alibaba.druid.Constants"%>
<%@page import="org.apache.bcel.classfile.Constant"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="com.kbook.system.entity.Member" %>
<%@ page language="java" import="com.kbook.common.utils.Constants" %>
<%@ page import="org.apache.logging.log4j.LogManager,org.apache.logging.log4j.Logger" %>
<%
	Object sessionValues = session.getAttribute(Constants.CURRENT_MEMBER);
	Member mbr = (Member) sessionValues;
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<!--3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="HandheldFriendly" content="true" />
<meta name="MobileOptimized" content="320" />
<%@ include file="/WEB-INF/views/include/context.jsp"%>
<link href="${ctx}/static/bootstrap3.0/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">


<title>首页</title>
<style type="text/css">
.btn-fontsize {
	font-size: 180%
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
<body>
	<br />
	<div class="container" align="center" style="color:white;">
		<table id="memberMsg"
			style="text-align:center;letter-spacing:2px;font-size:22px;">
		</table>
	</div>
	<div class="container" align="center" style="margin-top:20px; ">
		<div class="well center-block"
			style="max-width: 400px;background:#eee;filter: alpha(opacity=75); opacity: 0.85;">
			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a id="toSeatOrder"><button type="button"
						class="btn btn-success btn-lg btn-block btn-fontsize">订座</button>
				</a>
			</div>
			
<!--  			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a id="toSeatOrderCondition"><button type="button"
						class="btn btn-warning btn-lg btn-block btn-fontsize">筛选订座</button>
				</a>
			</div>  -->

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/front/member/seatOrder"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">订座记录</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/front/member/successOrder"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">消费记录</button>
				</a>
			</div>
			<c:if test="${inWeChat == 1}">
				<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
					<a href="${ctx}/system/product/buyProduct"><button type="button"
							class="btn btn-primary btn-lg btn-block btn-fontsize">购买产品</button>
					</a>
				</div> 
 			</c:if> 
			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/front/member/myProduct"><button type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">我的产品</button>
				</a>
			</div>

			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/front/member/changePassword"><button
						type="button"
						class="btn btn-primary btn-lg btn-block btn-fontsize">修改密码</button>
				</a>
			</div>
			<c:choose>
				<c:when test="${currentMember.isUpdate == 0}">
					<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
						<a href="${ctx}/system/member/toUpdateMember"><button
								type="button"
								class="btn btn-primary btn-lg btn-block btn-fontsize">完善信息赠30点</button>
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
						<a href="${ctx}/system/member/toShowMember"><button
								type="button"
								class="btn btn-primary btn-lg btn-block btn-fontsize">会员信息</button>
						</a>
					</div>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${inWeChat == 1}"> 
				<c:if test="${not empty currentMember.wxcode}">
				<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
					<a href="${ctx}/system/member/qrCode"><button
							type="button"
							class="btn btn-primary btn-lg btn-block btn-fontsize">我的二维码</button>
					</a>
				</div>
				</c:if>
				<c:if test="${empty currentMember.code}">
					<div class="container"
						style="margin-bottom: 15px; letter-spacing: 4px;">
						<a href="${ctx}/front/member/getWXCode?type=1"><button type="button"
								class="btn btn-primary btn-lg btn-block btn-fontsize">领取会员卡</button>
						</a>
					</div>
				</c:if>
			</c:if>
			<div class="container" style="margin-bottom:15px;letter-spacing:4px;">
				<a href="${ctx}/front/member/memberLogout"><button
						type="button" class="btn btn-danger btn-lg btn-block btn-fontsize">登出</button>
				</a>
			</div>
		</div>

	</div>
</body>
<script src="${ctx}/static/plugins/jquery/jquery.backstretch.min.js"></script>
<script type="text/javascript">
   		$(function() {
   			$.backstretch("${ctx}/static/images/1.jpg");
   			 var balance = "";
   			 var productName = "";
   			 var status;
   			 //edit:yangzh by 2018-04-27 strat
			 //var url="${ctx}/system/productOrder/getMemberProductJson?id="+<%=mbr.getId()%>+"&t=" + Math.random();
			//查询会员有效日期大于当前日期的所有有效订单，按卡类型降序、有效截止日期升序
            var url="${ctx}/system/productOrder/getMemberValidProduct?id="+<%=mbr.getId()%>+"&t=" + Math.random();
            //edit:yangzh by 2018-04-27 strat
				$.ajax({
				   type: "GET",
				   url: url,
				   cache:false,
				   async: false,
				   dataType:"json",
                    success: function(json){
                        //alert("<%=mbr.getName()%>");
						if(null != json.rows && json.rows.length > 0){
						    //设置订座按钮可操作
                            $("#toSeatOrder").click(function(){
                                $("#toSeatOrder").attr("href","${ctx}/front/seatOrder");
                            });
                            //设置订座按钮可操作
/*                             $("#toSeatOrderCondition").click(function(){
                                $("#toSeatOrderCondition").attr("href","${ctx}/front/seatOrder/seatTimeCondition");
                            });   */

						    if(json.rows.length == 1 ){
                                //alert("1#:" + json.rows[0].id);
                                //alert("1#:" + json.rows[0].productName);
                                //alert("1#:" + json.rows[0].type);
                                productName = json.rows[0].productName;
                                //1-储蓄卡，2-包天卡
                                if(json.rows[0].type == 1 ){
                                    balance = "剩余点数:"+ Math.round(json.rows[0].balance )+ "点";	//显示可用金额

                                }else{
                                    balance = "有效期:"+ json.rows[0].effectiveToDate ;	//显示有效截止日期
                                }

                            }else {
						        /**
                                productName += ' <select name="productName" >';
                                for(var i=0; i<json.rows.length; i++){
                                    alert("2#:" + json.rows[i].id);
                                    alert("2#:" + json.rows[i].productName);
                                    //alert(json.rows[i].effectiveToDate);
                                    productName += ' <option value="' + json.rows[i].product.id + '">' + json.rows[i].productName + '</option>';
                                }
                                productName += '</select>';
								 **/
						        //不止一种产品,遍历所有储蓄卡的
								var sum = 0;
								var count = 0;
								for(var i=0;i<json.rows.length;i++) {
									if (json.rows[i].type != 1) {
									    //只要有一种产品不是储蓄卡就跳出循环
										balance = "有效期:"+ json.rows[i].effectiveToDate ;
										break;
									} else {
									    sum += Math.round(json.rows[i].balance);
									    count++;
									}
								}

								if (count == json.rows.length) {
								    //都是储蓄卡
									balance = "剩余点数:"+ sum + "点";
								} else {
                                    balance = "有效期:"+ json.rows[0].effectiveToDate ;
								}

                                /*productName = json.rows[0].productName;
                                //1-储蓄卡，2-包天卡
                                if(json.rows[0].type == 1 ){
                                    balance = "剩余点数:"+ Math.round(json.rows[0].balance) + "点";	//显示可用金额
                                }else{
                                    balance = "有效期:"+ json.rows[0].effectiveToDate ;	//显示有效截止日期
                                }*/
                            }

                        }else{
                            //设置订座按钮未操作
                            $("#toSeatOrder").removeAttr('href');
                            //$("#toSeatOrderCondition").removeAttr('href');
                            balance="亲,您未购买任何产品";
                            alert("亲,您未购买产品或者产品已过期,无法订座");
                        }

                        var memberMsg = document.getElementById("memberMsg");
                        var tr = document.createElement("tr");
                        var td = document.createElement("td");
                        var memberName='<%=mbr.getName()%>';
                        /**td.innerHTML = '<img src="${ctx}/static/images/front_member.png" alt=""  width="22px;"height="22px;"/>&nbsp;'
                            + memberName + "&nbsp;&nbsp;"
                            + productName + "&nbsp;&nbsp;"
                            + balance;*/
                        if(productName != null && productName != ''){
                        	td.innerHTML = '<img src="${ctx}/static/images/front_member.png" alt=""  width="22px;"height="22px;"/>&nbsp;'
                        		 + memberName + "&nbsp;&nbsp;"
                                 + productName + "&nbsp;&nbsp;"
                                 + balance;
                        }else{
                        	td.innerHTML = '<img src="${ctx}/static/images/front_member.png" alt=""  width="22px;"height="22px;"/>&nbsp;'
                                + memberName + "&nbsp;&nbsp;" + balance;
                        }
                        
                        tr.appendChild(td);
                        memberMsg.appendChild(tr);

                    }
				});
	});
</script>
</html>