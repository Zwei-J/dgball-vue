$(document).ready(function(){
    //播放列表滚动条
    $(".listCont>.detail").niceScroll({
        cursorcolor: "#313131",
        cursorwidth: "4px",
        cursorborder: "none",
        autohidemode: false		//不隐藏
    });

    //评论输入框
    $("#commentInput").focus(function(){
        $(this).parent().css("border","1px solid #5aa700");
    }).blur(function(){
        $(this).parent().css("border","1px solid #ddd");
    })

    var aaa = decodeURI("\ue415");
    $("#aaa").html(aaa);


    // var myPlayer = videojs('example_video_1');
    // console.log(myPlayer.controlBar.children());
    // console.log(myPlayer.controlBar.children()[0].el_.style);

    // videojs("example_video_1").ready(function(){
    //     var myPlayer = this;
    // });
});
