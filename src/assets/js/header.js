$(document).ready(function(){
	$.ajax({
	    type:"get",
	    url:"header.html",
	    success:function(html){
	    	//console.log(html)	//字符串
	    	$("#header").html(html);
	    	//搜索
	    	$(".searchBox>.searchBtn").click(function(){
				console.log(111);
				location.href = "list.html";
			})
	    }
	})
})