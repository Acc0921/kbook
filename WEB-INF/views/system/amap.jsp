<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page
	import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
request.setAttribute("error", error);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html> 
<head> 
	<title>地理位置设置</title> 
    <link rel="stylesheet" href="https://cache.amap.com/lbs/static/main1119.css"/>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=1.4.15&key=f83a930fe95691d00cbe407ff941a810&plugin=AMap.Autocomplete,AMap.PlaceSearch"></script>
 	<script src="${ctx}/static/plugins/easyui/jquery/jquery-1.11.1.min.js"></script>
 	
 	<script type="text/javascript" src='//webapi.amap.com/maps?v=1.4.15&key=f83a930fe95691d00cbe407ff941a810'></script>
    <!-- UI组件库 1.0 -->
    <script src="//webapi.amap.com/ui/1.0/main.js?v=1.0.11"></script>
 	<style>
 		html,
	    body,
	    #container {
	        width: 100%;
	        height: 100%;
	        margin: 0px;
	        font-size: 13px;
	    }
	    
	    #pickerBox {
	        position: absolute;
	        z-index: 9999;
	        top: 50px;
	        right: 30px;
	        width: 300px;
	    }
	    
	    #pickerInput {
	        width: 200px;
	        padding: 5px 5px;
	    }
	    
	    #poiInfo {
	        background: #fff;
	    }
	    
	    .amap_lib_placeSearch .poibox.highlight {
	        background-color: #CAE1FF;
	    }
	    
	    .amap_lib_placeSearch .poi-more {
	        display: none!important;
	    }
 		.button {
		    background-color: #4CAF50; /* Green */
		    border: none;
		    color: white;
		    padding: 5px 8px;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 4px;
		}
 	</style>
</head> 
<body> 
<div id="container" class="map" tabindex="0"></div>
<div id="pickerBox" style="left: 0;top: 0;height: 80px;margin-left: 150px;margin-top: 100px;">
    <input id="pickerInput" placeholder="输入关键字选取地点" />
    <div id="poiInfo"></div>
</div>
<div class="input-card" style="left: 0;top: 0;height: 80px;margin-left: 150px;margin-top: 150px;">
    <h4>左击获取经纬度：</h4>
    <div class="input-item"> 
      <input type="text" readonly="true" id="lnglat">
      &nbsp;&nbsp;  
      <input type="button" class="button" value="保存门店位置" onclick="saveAmap()"> 
    </div>
</div>
</div>

<script type="text/javascript">
	//地图加载
	var map = new AMap.Map('container', {
        //zoom: 10
		resizeEnable: true
    });
	
	//为地图注册click事件获取鼠标点击出的经纬度坐标
    map.on('click', function(e) {
        document.getElementById("lnglat").value = e.lnglat.getLng() + ',' + e.lnglat.getLat();
    });
	
	AMapUI.loadUI(['misc/PoiPicker'], function(PoiPicker) {

        var poiPicker = new PoiPicker({
            //city:'北京',
            input: 'pickerInput'
        });

        //初始化poiPicker
        poiPickerReady(poiPicker);
    });

    function poiPickerReady(poiPicker) {

        window.poiPicker = poiPicker;

        var marker = new AMap.Marker();

        var infoWindow = new AMap.InfoWindow({
            offset: new AMap.Pixel(0, -20)
        });

        //选取了某个POI
        poiPicker.on('poiPicked', function(poiResult) {

            var source = poiResult.source,
                poi = poiResult.item,
                info = {
                    source: source,
                    id: poi.id,
                    name: poi.name,
                    location: poi.location.toString(),
                    address: poi.address
                };

            marker.setMap(map);
            infoWindow.setMap(map);

            marker.setPosition(poi.location);
            infoWindow.setPosition(poi.location);

            infoWindow.setContent('POI信息: <pre>' + JSON.stringify(info, null, 2) + '</pre>');
/*             infoWindow.open(map, marker.getPosition());  */
            
            document.getElementById("lnglat").value = marker.getPosition();

            map.setCenter(marker.getPosition());
            
        });

        poiPicker.onCityReady(function() {
            poiPicker.suggest('去K书');
        });
    }
	
	 
	function saveAmap(){
		var xy = $('#lnglat').val();
		var url = "${ctx}/system/store/saveStoreAmap?storeId="+${AmapStore.id}+"&coordinate="+xy;
        $.ajax({
            type: "GET",
            url: url,
            success: function(res){
               if(res == 'success'){
            	   alert('门店地理位置设置成功！');
               }else{
            	   alert('门店地理位置设置失败！');
               }
               window.location = "${ctx}/system/store";
            }
        });
	}
</script> 
</body> 
</html>
