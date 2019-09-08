function sizeChange(){
  var htmlEl=document.documentElement;
  var momentWith=0;
  function setHtmlFontSize(designWidth,maxWidth){
    momentWith =  htmlEl.clientWidth>maxWidth?maxWidth:htmlEl.clientWidth;
    htmlEl.style.fontSize=momentWith/designWidth*100+'px';
  }
  setHtmlFontSize(375,750);
  window.addEventListener('resize',function(){
    setHtmlFontSize(375,750);
  },false)
}


$(document).ready(function(){
    sizeChange();//监听屏幕设置文本自动缩放
    var winHeight = $(window).height();
    var bdWidth = $('body').width();
    // $("body").cssheight(winHeight);
    $("body").each(function(index, el) {
        $(this).css("min-height",winHeight)
    });
    // $('.footBox').width(bdWidth);
    $(".resChList input").click(function(event) {
        $(this).blur();
    });

    window.addEventListener('resize', function () { 
        if($(window).height() < winHeight){ 
            $('.footBox,.fixBtnBox').hide(); 
        }else{ 
            $('.footBox,.fixBtnBox').show(); 
        } 
    });

    //登录输入框校验  
    $('.inputBox>input').bind('input onpropertychange', function(){
        var emLength = $(this).parent('.inputBox').find('.clearVal').length;        
        if(emLength != 0 && $(this).val() != ''){
            $(this).siblings('.clearVal').show();
            $(this).siblings('.clearVal').click(function(event) {
                $(this).siblings('input').val('') && $(this).hide();
            });
        }
    });

    $('.inputBox>input').on('focus',function(){
        var emLength = $(this).parent('.inputBox').find('.clearVal').length;
        console.log(emLength);
        if (emLength != 0 && $(this).val() != '') {
            $(this).siblings('.clearVal').show();
        }else if (emLength == 0) {
            $(this).after('<em class="clearVal"></em>')
        }
    });

    $('.inputBox>input').on('blur',function(){
        if ($(this).val()=='') {
            $(this).siblings('.clearVal').hide();
        };
        
    })
    

    //遮罩层方法
    function layerBg(){ 
        $('.layerBg').toggle();
    }

    //选中位置将值放入右上角
    $('.restBox li>em:not(.selected)').click(function(event) {
        var selectingVal = $(this).parents('.restBox').siblings('.resHead').find('i').text();
        var selectingVal_a = selectingVal.substring(0,2)
        $(this).addClass('selecting').parents('.pdrem').siblings().find('em').removeClass('selecting');
        $(this).addClass('selecting').parent('li').siblings().find('em').removeClass('selecting');
        $('.selectingVal').text("选中 (" + selectingVal_a + $(this).siblings('p').text()+")");
    });

    //时间筛选
    $('#chooseTime').click(function(event) {
        layerBg();
        $(this).parent('h5').siblings('.recordTime').slideToggle();
    });

    //时间点选
    $('.recordTime>span').click(function(event) {
        $(this).parent('.recordTime').slideToggle();
        $('#clickTime').text($(this).text());
        $(this).addClass('active').siblings().removeClass('active');
        layerBg();
    });

    //详情
    $('.detail').click(function(event) {
        layer.open({
            title:['消费记录详情','height:'],
            shadeClose:false,
            content: '<div class="orderList orderListLayer">'+
                        '<div class="resTop"> '+
                            '<span class="resTopL">'+
                                '<img src="img/icon_11.png">'+
                            '</span>'+
                            '<span class="resTopC">'+
                                '<h5>东山图书馆(舒适V5)</h5>'+
                                '<p>时间：2018-01-15</p>'+
                                '<p class="fgray font12">消费点数：30点</p>'+
                            '</span>'+
                        '</div>'+
                        '<h2 class="fgray6">订单编号：<span>201901029485996</span><span class="success fr">已完成</span></h2>'+
                        '<ul class="fgray6 font13 pdremhalve">'+
                            '<li>预定开始时间：10:36</li>'+
                            '<li>预定开始时间：10:36</li>'+
                        '</ul>'+
                        '<ul class="fgray6 font13 pdremhalve">'+
                            '<li>预定开始时间：10:36</li>'+
                            '<li>预定开始时间：10:36</li>'+
                        '</ul>'+
                    '</div>'
        ,btn: ['确定']
       
        });
    });
    
    //会员注册页面勾选须知
    $('#agree').click(function(event) {        
        if ($(this).is(':checked')) {
            $('.registerBtn').removeClass('disabled');
            $('.registerBtn').attr("disabled",false); 
        }else{
            $('.registerBtn').addClass('disabled');
            $('.registerBtn').attr("disabled",true); 
        }
    });
    
    

});

//弹窗
function layer_a(){
    layer.open({
        title:['提示']
       ,content: '您确定要取消吗？'
       ,shadeClose:false
       ,btn: ['确定', '不要']
       ,yes: function(index){
         //此处可添加取消方法
         layer.close(index);//关闭弹窗
       }
    });
}

