<template>
    <div>
        <HeaderComponent @isLogin="isLogin" @userId="getUserId"/>
        <!-- 中间播放主体界面 -->
        <div class="container">
            <div class="main-box runoff clear">
                <div class="main clear">
                    <div class="clear">
                        <div class="video-player lf" id="videoBox">
                            <!-- 弹幕面板 -->
                            <canvas id="barrage" :width="videoBoxWidth" :height="videoBoxHeight-56" ref="barrage">
                                您的浏览器版本太低，不支持弹幕功能
                            </canvas>
                            <!-- 播放器 -->
                            <video id="video" volume="0.5" width="100%" height="100%" preload="metadata" v-if="videoCanPlay">
                                <!--<source src="../assets/video/media/00_001.mp4"></source>-->
                                <source :src="videoSrc"></source>
                            </video>
                            <!-- 遮盖层 -->
                            <div class="videoCover"><span>{{videoMsg}}</span></div>
                            <!-- 控制器 -->
                            <div class="controller" v-if="videoCanPlay">
                                <div class="program-bar" @mousedown="progPress">
                                    <div class="loaded" :style="{width:loaded}"></div>	<!--缓存进度-->
                                    <div class="current" :style="{width:playedBar}"></div>
                                    <i :style="{left:playIconLeft}" id="controlBall"></i>		<!--小球-->
                                    <div class="cover"></div>   <!--覆盖层-->
                                </div>
                                <div :class="hidCtrl?'control hide clear':'control clear'">
                                    <div class="lf clear">
                                        <a href="javascript:;" @click="controlPlay" class="btn lf">
                                            <!--<span class="stopIcon"></span>-->
                                            <span :class="isOnPlay?'stopIcon':'playIcon'"></span>
                                        </a>
                                        <p class="play-time lf">
                                            <span class="currentTime">{{currentTime?currentTime:"00:00"}}</span>/<span>{{duration}}</span>
                                        </p>
                                    </div>
                                    <div class="rt clear">
                                        <span class="clarity">高清</span>
                                        <span class="volume">
                                            <!--  class="noVol" 没声音 -->
                                            <i @click="controlOpenVolume"></i><span class="vol-ctrl" @mousedown="volPress">
                                                <span class="currentVol" :style="{width:currentVolWidth}"></span>
                                                <b :style="{left:volIconLeft}"></b>
                                                <span class="cover"></span>
                                            </span>
                                        </span>
                                        <span class="screen">
                                            <i @click="fullScreen"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 右侧列表 -->
                        <div class="video-list rt">
                            <!-- 列表头部 -->
                            <div class="brand clear">
                                <div class="head lf">
                                    <router-link :to="'/detail/'+videoTit.seriesId">
                                        <img :src="titLogo">
                                    </router-link>
                                </div>
                                <div class="dName lf">
                                    <router-link :to="'/detail/'+videoTit.seriesId">{{videoTit.seriesName}}</router-link>
                                </div>
                            </div>
                            <!-- 列表主体 -->
                            <div class="listCont">
                                <!-- Tab -->
                                <p>选集</p>
                                <div class="detail">
                                    <p class="title">
                                        <router-link :to="'/detail/'+videoTit.seriesId">{{videoTit.seriesName}}</router-link>
                                    </p>
                                    <p class="count">
                                        <span>{{videoTit.count}}</span>集全
                                    </p>
                                    <div class="movieList">
                                        <!-- 列表内容 -->
                                        <ul class="clear">
                                            <li :key="index" v-for="(tmp,index) in videoList" :class="currentVideo.num==tmp.num?'current':''">
                                                <a href="javascript:;" @click="jumpVideo(tmp.vid)" :title="tmp.title">第<span>{{tmp.num}}</span>集&nbsp;&nbsp;<span>{{tmp.title}}</span></a>
                                            </li>
                                            <!--...-->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- 分页按钮 -->
                            <div class="page">
                                <ul class="pageBtn clear">
                                    <!--<li class="active">
                                        <a href="javascript:;">1-50</a>
                                    </li>-->
                                    <li :class="vPno==index+1?'active':''" :key="index" @click="loadVideoList(index+1)" v-for="(tmp,index) in listPageBtn.slice(0,3)">
                                        <a href="javascript:;">{{tmp}}</a>
                                    </li>
                                    <li v-if="listPageBtn.length>3">
                                        <a href="javascript:;" @click="loadMoreJi">更多选集</a>
                                    </li>
                                </ul>
                                <ul class="more clear" v-if="moreJi">
                                    <li :class="vPno==index+4?'active':''" :key="index" @click="loadVideoList(index+4)" v-for="(tmp,index) in listPageBtn.slice(3)">
                                        <a href="javascript:;">{{tmp}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- 下部点赞一行 -->
                    <div class="newCol">
                        <ul class="clear">
                            <li class="good">
                                <a href="javascript:;" @click="toGood" class="goods" title="顶">
                                    <i></i>
                                    <span>{{currentVideo.thumbUp}}</span>
                                </a>
                            </li>
                            <li>
                                <a class="clear">
                                    <span class="lf">弹幕</span>
                                    <span :class="barrageOn?'lf switch on':'lf switch off'" @click="ctrlBarrage"></span>
                                </a>
                            </li>
                            <li>
                                <div class="inputBox clear">
                                    <input @input="checkInput" :class="barrageHasVal?'danMuInput hasVal lf':'danMuInput lf'" v-model="barrageInput" type="text" placeholder="发弹幕一起high">
                                    <span :class="barrageHasVal?'send canSend lf':'send lf'" @click="sendBarrage">发送</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- 下部详情 -->
                    <div class="bottomDetail clear">
                        <div class="bottomLeft lf">
                            <p>
                                <span>{{videoTit.seriesName}}</span>
                                第<span>{{currentVideo.num}}</span>集
                            </p>
                            <div class="clear">
                                <p class="bread lf">
                                    <router-link to="/index">首页</router-link>
                                    >
                                    <router-link :to="'/detail/'+videoTit.seriesId">{{videoTit.seriesName}}</router-link>
                                </p>
                                <p class="rt detailMore">
                                    <!--<a href="javascript:;" class="active">剧情简介 <b></b></a>-->
                                    <a href="javascript:;" @click="showInt" :class="introHeight==0?'':'active'">剧情简介 <b></b></a>
                                    <a href="javascript:;">播放 : <span>{{currentVideo.playCount}}</span></a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- 下拉内容 -->
                    <div class="slide clear" :style="{height:introHeight}">
                        <div class="slideImg lf">
                            <router-link :to="'/detail/'+videoTit.seriesId">
                                <img :src="titLogo">
                            </router-link>
                            <router-link :to="'/detail/'+videoTit.seriesId">查看详情></router-link>
                        </div>
                        <div class="slideIntro rt">
                            <a>本作简介 :</a>
                            <span>{{videoTit.introduce}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 下边评论区和侧边 -->
        <div class="bottom">
            <div class="bottomBox clear">
                <!--评论组件-->
                <commentComponent :videoId="vid" :isLogin="isUserLogin" :userId="uid"/>
                <div class="rec rt">
                    <!--相关推荐-->
                    <h3 class="clear">
                        <p class="lf">龙珠系列</p>
                    </h3>
                    <div class="rec-right rt">
                        <div class="recList">
                            <div class="item clear" :key="index" v-for="(tmp,index) in recList">
                                <div class="img lf">
                                    <router-link :to="'/detail/'+tmp.seriesId" :title="tmp.seriesName">
                                        <img :src="require('../assets/'+tmp.seriesLogo_sm)">
                                    </router-link>
                                </div>
                                <div class="detail lf">
                                    <p class="title"><router-link :to="'/detail/'+tmp.seriesId">{{tmp.seriesName}}</router-link></p>
                                    <div class="playCount"><i></i>共播放{{tmp.playCount}}次</div>
                                    <div class="numCount"><span>{{tmp.count}}</span>集全</div>
                                </div>
                            </div>
                            <!---->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <FooterComponent/>    
    </div>
</template>

<script>
    import header from '@/components/header';
    import footer from '@/components/footer';
    import comment from '@/components/comment';
    export default {
        data:function(){
            return{
                vid:0,      //当前视频的vid
                videoTit:{},    //
                titLogo:'#',    //logo图
                videoList:[],   //右侧视频播放列表
                recList:[],     //推荐列表
                listPageBtn:[],     //列表分页按钮
                moreJi:false,   //更多选集
                vPno:0,     //当前列表页码
                currentVideo:{},   //当前页视频对象 
                videoSrc:'#',
                videoCanPlay:true,   //视频可否播放
                videoMsg:'',        //视频可否播放信息
                videoBox:null,     //视频大盒子
                videoBoxWidth:null, //大盒子宽度
                videoBoxHeight:null,//大盒子高度
                isOnPlay:false,     //视频是否在播放
                $SCROLL:null,       //要绑定滚动条的元素
                video:null,         //video对象
                vol:0.6,            //音量 默认0.6
                duration:null,      //总时间 00:00
                currentTime:null,   //当前时间
                programBarWidth:null,   //进度条宽度
                volBarWidth:null,   //音量条宽度
                volCanMove:false,   //音量条是否可拖动
                progCanMove:false,  //进度条是否可拖动
                playedBar:null,     //已播放区域宽度(px)
                playIconLeft:null,  //视频小圆球left偏移量
                loaded:null,        //缓存进度(px)
                timer:null,         //缓存定时器
                volRangeMin:null,   //声音可调范围
                volRangeMax:null,
                progRangeMin:null,  //进度条可调范围
                progRangeMax:null,  
                currentVolWidth:null,   //当前音量条宽(px)
                volIconLeft:null,    //音量小圆球left偏移量(px)
                hidCtrl:false,      //是否隐藏控制栏
                mouseInVideo:false,  //鼠标是否在video上
                ctx:null,           //canvas画笔
                barrageOn:true,     //弹幕开
                barrageInput:'',    //用户输入弹幕
                barrageHasVal:false,//弹幕输入框是否有内容
                barrageTimer:null,  //弹幕定时器
                colorArr:[],        //随机颜色
                jsonArr:[],         //测试数组
                introHeight:0,
                isUserLogin:false,
                uid:null,
                good:true      //赞
            }
        },

        watch:{
            '$route':['initLoad']
        },

        beforeMount:function(){
            this.initLoad();
        },

        mounted:function(){
            this.loadData();
            // this.barrage();
           // setInterval(()=>{this.test()},1000);
        },

        beforeDestroy:function(){
            $(".nicescroll-rails").remove();
            this.removeEventListeners();
            clearInterval(this.timer);
            this.timer = null;
        },

        methods:{
            isLogin:function(bool){
                this.isUserLogin = bool;
            },
            getUserId:function(uid){
                this.uid = uid;
            },
            jumpVideo:function(vid){
                //this.$route.params.vid = vid;
                this.$router.push('/play/'+this.videoTit.seriesId+'/'+vid);
                //应付之策
                location.reload();
            },
            paramsChange:function(){
                this.initLoad();
                this.loadData();
            },
            //加载页面
            initLoad:function(){
                var vid = this.$route.params.vid;
                this.vid = vid;
                //播放次数+1
                this.$http.get("http://127.0.0.1:3000/playCount/"+vid);
                
                var sid = this.$route.params.sid;
                this.$http.get("http://127.0.0.1:3000/loadTit/"+sid)
                    .then(function(res){
                        this.videoTit = res.data;
                        document.title = res.data.seriesName + "在线播放";
                    }).then(function(){
                        var pageCount = Math.ceil(this.videoTit.count/50);
                        for(var i=1;i<=pageCount;i++){
                            if(i==pageCount){
                                this.listPageBtn.push(50*(i-1)+1+'-'+this.videoTit.count);
                                break;
                            }
                            this.listPageBtn.push(50*(i-1)+1+"-"+i*50);
                        }
                        //console.log(this.listPageBtn);
                        this.titLogo = require('../assets/'+this.videoTit.logo);
                    })
                this.$http.get("http://127.0.0.1:3000/getRec")
                    .then(function(res){
                        this.recList = res.data;
                    })
                this.$http.get("http://127.0.0.1:3000/loadVideo/"+vid)
                    .then(function(res){
                        this.currentVideo = res.data;   //当前视频对象
                        if(res.data.videoSrc){
                            //有视频
                            this.videoCanPlay = true;
                            this.videoSrc = require('@/assets/'+res.data.videoSrc);                        
                            this.videoMsg = '';
                        }else{
                            //没视频
                            this.videoCanPlay = false;
                            clearInterval(this.barrageTimer);
                            this.barrageTimer = null;
                            this.videoSrc = '#';
                            this.videoMsg = '杯具了~找不到视频，网站管理员正在努力抢修中...';
                        }
                    }).then(function(){
                        this.loadVideoList();
                    })
                this.$http.get("http://127.0.0.1:3000/getBarrage/"+vid)
                    .then(function(res){
                        this.jsonArr = res.data;
                    })
            },
            //加载数据
            loadData:function(){
                this.videoBox = document.getElementById("videoBox");
                this.$SCROLL = $(".listCont>.detail");
                this.$SCROLL.niceScroll({
                    cursorcolor: "#313131",
                    cursorwidth: "4px",
                    cursorborder: "none",
                    autohidemode: false,	//不隐藏
                });
                this.programBarWidth = parseInt($("div.program-bar").css("width"));//获取进度条长度
                this.volBarWidth = parseInt($("span.vol-ctrl").css("width"));//获取音量条长度
                this.video = document.getElementById("video");
                this.video.volume = this.vol;
                this.currentVolWidth = this.volBarWidth*this.vol+"px";
                this.volIconLeft = parseInt(this.currentVolWidth)-5+"px";
                this.videoBoxWidth = parseInt($("#videoBox").css("width"));
                this.videoBoxHeight = parseInt($("#videoBox").css("height"));
                //避免操作DOM
                this.ctx = this.$refs.barrage.getContext("2d");
                
                
                this.colorArr = ['#ffffff','#00ffff','#fcff00','#00ff42','#ff5400','#b0ff00'];
                
                this.addEventListeners();
            },
            loadVideoList:function(index){      //列表页分页
                var sid = this.$route.params.sid;
                this.vPno = index || parseInt(this.currentVideo.num/50+1);
                //console.log(vPno);
                //待优化
                this.$http.get("http://127.0.0.1:3000/getVideoList/"+sid+"/"+this.vPno)
                    .then(function(res){
                        this.videoList = res.data;
                    })
            },
            loadMoreJi:function(){   //加载更多选集
                this.moreJi = !this.moreJi;
            },
            controlPlay:function(){     //播放暂停
                if(!this.videoCanPlay){
                    return;
                }
                var _this = this;
                this.timer = setInterval(function(){
                    var loadSec = _this.video.buffered.end(_this.video.buffered.length-1);//加载的秒数
                    var totalSec = _this.video.duration;
                                    //调用将秒数转为长度的函数
                    _this.loaded = _this.changeSecToLength(loadSec,totalSec)+"px";
                    //console.log(_this.loaded);
                    if(parseInt(_this.loaded)==_this.programBarWidth){
                        clearInterval(_this.timer);
                        _this.timer = null;
                    }
                },500)

                if(this.video.paused){
                    //$("#playStopBtn").attr("class","stopIcon");   避免DOM操作
                    this.video.play();
                    this.isOnPlay = true;                
                }else{
                    //$("#playStopBtn").attr("class","playIcon");    
                    this.video.pause();
                    this.isOnPlay = false;                                        
                }
            },
            fullScreen:function(){      //全屏
                if(!this.videoCanPlay){
                    return;
                }
                var el = this.video;
                if (el.requestFullscreen) {
                    el.requestFullscreen();
                } else if (el.mozRequestFullScreen) {
                    el.mozRequestFullScreen();
                } else if (el.webkitRequestFullScreen) {
                    el.webkitRequestFullScreen();
                }
            },
            controlOpenVolume:function(){   //开关声音
                if(!this.videoCanPlay){
                    return;
                }
                var vol = this.vol;
                if(this.video.volume>0){
                    this.video.volume = 0;
                    this.currentVolWidth = "0px";
                    this.volIconLeft = "-5px";
                    $(".volume>i").attr("class","noVol");
                }else{
                    this.video.volume = vol;
                    this.currentVolWidth = vol*this.volBarWidth+"px";
                    this.volIconLeft = parseInt(this.currentVolWidth)-5+"px";
                    $(".volume>i").removeClass();
                }
            },
            //封装函数 实现传入秒钟数，返回电子表格式  00:00
            changeTimeFormat:function(seconds){
                var finalTime = "";
                var newSec = "";
                if(seconds<60){
                    newSec = seconds>=10?seconds:"0"+seconds;
                    finalTime = "00:"+newSec;
                }else{
                    var mins = parseInt(seconds/60);
                    mins = mins>=10?mins:"0"+mins;
                    newSec = seconds%60;
                    newSec = newSec>=10?newSec:"0"+newSec;
                    finalTime = mins+":"+newSec;
                }
                return finalTime;
            },
            //封装函数 实现传入秒钟数，返回对应秒数的长度(没有px)
            changeSecToLength:function(currentSecond,totalSeconds){ //当前秒 总秒数
                var totalWidth = this.programBarWidth;
                return parseInt(totalWidth*parseInt(currentSecond)/parseInt(totalSeconds));
            },
            //封装函数 实现传入宽度，设置对应宽度的进度/音量
            widthToVol:function(width,isVol){
                var currentWidth = parseInt(width);    //当前宽度                
                if(isVol){
                    this.vol = currentWidth/this.volBarWidth;
                    if(this.vol<0){
                        this.vol=0;
                    }else if(this.vol>1){
                        this.vol=1;
                    }
                    this.video.volume = this.vol;
                }else{
                    this.video.currentTime = parseInt(this.video.duration)*currentWidth/this.programBarWidth;
                }
            },
            //获取总时间
            getDuration:function(){
                var seconds = parseInt(this.video.duration);
                                //调用转换格式函数
                this.duration = this.changeTimeFormat(seconds);
            },
            //获取播放时间
            getPlayTime:function(){
                var seconds = parseInt(this.video.currentTime);     //当前时间
                this.currentTime = this.changeTimeFormat(seconds);  //当前时间00:00
                var total = this.video.duration;  //总时间
                var currentWidth = this.changeSecToLength(seconds,total);
                //console.log(currentWidth);
                this.playedBar = currentWidth+"px";
                this.playIconLeft = currentWidth-8+"px";
            },
            progPress:function(e){
                if(!this.videoCanPlay){
                    return;
                }
                e.preventDefault();
                this.progCanMove = true;
                this.progRangeMin = e.clientX - e.offsetX;
                this.progRangeMax = this.progRangeMin + this.programBarWidth;
                this.playedBar = e.clientX - this.progRangeMin + "px";
                this.playIconLeft = parseInt(this.playedBar)-8+"px";
                this.widthToVol(this.playedBar);
            },
            volPress:function(e){
                if(!this.videoCanPlay){
                    return;
                }
                e.preventDefault();                
                this.volCanMove = true;
                //点击时offsetX=10 获取cover开始和结束的位置 --clientX-10、clientX+(总-10);
                this.volRangeMin = e.clientX - e.offsetX;
                this.volRangeMax = this.volRangeMin + this.volBarWidth;
                this.currentVolWidth = e.clientX-this.volRangeMin+"px"; //改变进度条 
                this.volIconLeft = parseInt(this.currentVolWidth)-5+"px";   //改变小圆球                
                this.widthToVol(this.currentVolWidth,true);  //设置音量
            },
            volProgMove:function(e){
                if(!this.videoCanPlay){
                    return;
                }
                if(this.volCanMove){
                    //console.log("进度条在拖动");
                    //移动时如果在范围 clientX-10~clientX+(总-10) 内 通过 moveClientX-(clientX+10)计算宽度
                    if(e.clientX>=this.volRangeMin&&e.clientX<=this.volRangeMax){
                        //console.log("在范围内啦"+(e.clientX-this.volRangeMin));
                        this.currentVolWidth = e.clientX-this.volRangeMin+"px";
                    }else if(e.clientX<this.volRangeMin){
                        //如果小于clientX-10,vol=0;
                        this.currentVolWidth = "0px";
                    }else{
                        //否则大于clientX+(总-10)，vol=1
                        this.currentVolWidth = this.volBarWidth+"px";
                    }
                    this.volIconLeft = parseInt(this.currentVolWidth)-5+"px";                    
                    this.widthToVol(this.currentVolWidth,true);
                }else if(this.progCanMove){
                    //console.log("视频进度条在拖动");
                    if(e.clientX>=this.progRangeMin&&e.clientX<=this.progRangeMax){
                        this.playedBar = e.clientX-this.progRangeMin+"px";
                    }else if(e.clientX<this.progRangeMin){
                        this.playedBar = "0px";
                    }else{
                        this.playedBar = this.programBarWidth+"px";
                    }
                    this.playIconLeft = parseInt(this.playedBar)-8+"px";
                    this.widthToVol(this.playedBar);
                }
            },
            volUp:function(){
                //console.log("放开了，进度条不可移动");
                this.volCanMove = false;
                this.progCanMove = false;
            },
            //视频播放结束处理
            isPlayed:function(){
                this.isOnPlay = false;
            },
            //视频没声音处理
            closeVol:function(){
                if(this.video.volume<=0){
                    $(".volume>i").attr("class","noVol");
                }else{
                    $(".volume>i").removeClass();
                }
            },
            //视频播放处理
            hideCtrl:function(){
                if(!this.videoCanPlay){
                    return;
                }
                if(this.mouseInVideo){
                    this.hidCtrl = false;
                }else{
                    this.hidCtrl = true;
                }
                clearInterval(this.barrageTimer);
                this.barrageTimer = null;
                this.barrage();
            },
            //视频暂停处理
            showCtrl:function(){
                if(!this.videoCanPlay){
                    return;
                }
                this.hidCtrl = false;
                this.barrage();
            },
            //鼠标移到视频上
            mouseOverVideo:function(){
                if(!this.videoCanPlay){
                    return;
                }
                this.mouseInVideo = true;
                this.hidCtrl = false;
            },
            //鼠标离开视频
            mouseOutVideo:function(){
                if(!this.videoCanPlay){
                    return;
                }
                this.mouseInVideo = false;
                if(this.isOnPlay){
                    this.hidCtrl = true;
                }else{
                    this.hidCtrl = false;
                }
            },

            //弹幕功能
            barrage:function(){
                //...{msg:"Hello World4",color:"#123",speed:5,top:90,showTime:15,left:880}
                if(!this.videoCanPlay){
                    return;
                }
                var ctx = this.ctx;
				ctx.textBaseline = "top";
                var arr = this.jsonArr;
                if(this.barrageOn&&this.isOnPlay){
                    this.barrageTimer = setInterval(function(){
                        ctx.clearRect(0,0,880,440);
                        for(var i=0;i<arr.length;i++){
                            if(arr[i]!=null){
                                if(arr[i].leftOffset<-200){
                                    arr[i] = null;
                                }else{
                                    if(this.video.currentTime>=arr[i].showTime){
                                        ctx.font = "bold 20px microsoft Yahei";                                
                                        arr[i].leftOffset = arr[i].leftOffset - arr[i].speed;
                                        ctx.fillStyle = arr[i].color;
                                        ctx.fillText(arr[i].msg,arr[i].leftOffset,arr[i].top);
                                    }
                                }
                            }
                        }
                    },20)
                }else{
                    clearInterval(this.barrageTimer);
                    this.barrageTimer = null;
                }
            },

            //发送弹幕
            sendBarrage:function(){
                //console.log(this.jsonArr);
                if(!this.videoCanPlay){
                    return;
                }
                var msg = this.barrageInput;
                if(msg.trim()==""){
                    return;
                }
                //...{msg:"Hello World4",color:"#123",speed:5,top:90,showTime:15,left:880}
                // 255,0,0 - 0,255,255
                var nowVideoTime = this.video.currentTime;
                var color = this.colorArr[parseInt(Math.random()*6)];
                var speed = parseInt(Math.random()*5+2);    //生成2-7之间的随机数
                var top = parseInt(Math.random()*(350-10+1)+10);    //生成10-350之间的随机数
                this.jsonArr.push({msg:msg,color:color,speed:speed,top:top,showTime:nowVideoTime,leftOffset:880});
                color = color.slice(1);
                //console.log(this.jsonArr);
                var vid = this.$route.params.vid;
                this.$http.get("http://127.0.0.1:3000/sendBarrage/"+vid+"/"+msg+"/"+color+"/"+speed+"/"+top+"/"+nowVideoTime+"/880");
                this.barrageInput = '';
                this.barrageHasVal = false;
            },
            //弹幕控制
            ctrlBarrage:function(){
                if(!this.videoCanPlay){
                    return;
                }
                this.barrageOn = !this.barrageOn;
                if(!this.barrageOn){
                    //关闭弹幕
                    clearInterval(this.barrageTimer);
                    this.barrageTimer = null;
                    this.ctx.clearRect(0,0,880,440);
                }else{
                    //开启弹幕
                    //将在播放时间之前的弹幕清空
                    var nowArr = this.jsonArr;
                    var nowTime = parseInt(this.video.currentTime);
                    for(var i=0;i<nowArr.length;i++){
                        if(nowArr[i]!=null){
                            if(nowArr[i].showTime<nowTime){
                                nowArr[i] = null;
                            }
                        }
                    }
                    this.barrage();
                }
            },

            //用户输入监控
            checkInput:function(){
                if(this.barrageInput.trim()==""){
                    this.barrageHasVal = false;
                }else{
                    this.barrageHasVal = true;
                }
            },

            showInt:function(){
                if(this.introHeight==0){
                    this.introHeight = "172px";
                }else{
                    this.introHeight = 0;
                }
            },
            //点赞功能
            toGood:function(){
                var vid = this.$route.params.vid;
                if(this.good&&vid){
                    this.currentVideo.thumbUp++;
                    this.$http.get("http://127.0.0.1:3000/thumbUp/"+vid);
                    this.good = false;
                }
            },

            addEventListeners:function(){
                var _this = this;
                this.video.addEventListener("canplay",this.getDuration);
                this.video.addEventListener("timeupdate",this.getPlayTime);
                this.video.addEventListener("ended",this.isPlayed);
                this.video.addEventListener("volumechange",this.closeVol); //音量改变触发
                window.addEventListener("mouseup",this.volUp);
                window.addEventListener("mousemove",this.volProgMove);
                this.videoBox.addEventListener("mouseover",this.mouseOverVideo);
                this.videoBox.addEventListener("mouseout",this.mouseOutVideo);
                this.video.addEventListener("pause",this.showCtrl);
                this.video.addEventListener("play",this.hideCtrl);
            },
            removeEventListeners:function(){
                this.video.removeEventListener("canplay",this.getDuration);
                this.video.removeEventListener("timeupdate",this.getPlayTime);
                this.video.removeEventListener("ended",this.isPlayed);
                this.video.removeEventListener("volumechange",this.closeVol);
                window.removeEventListener("mouseup",this.volUp);
                window.removeEventListener("mousemove",this.volMove);
                this.videoBox.removeEventListener("mouseover",this.mouseOverVideo);
                this.videoBox.removeEventListener("mouseout",this.mouseOutVideo);
                this.video.removeEventListener("pause",this.showCtrl);
                this.video.removeEventListener("play",this.hideCtrl);
            }
        },

        components:{
            HeaderComponent:header,
            FooterComponent:footer,
            commentComponent:comment
        }
    }
</script>

<style scoped>
    #header{
        min-width: 1180px;
    }

    #footer{
        min-width: 1180px;
    }

    .container{
        margin:0;
        width: 100%;
        min-width: 1180px;
    }

    .container>.main-box{
        background: #292929;
    }

    .main-box>.main{
        width:1180px;
        margin: 10px auto 0;
        background: #1F1F1F;
    }

    .main-box .video-player{
        width: 880px;
        height: 496px;
        background: #000;
        position: relative;
    }

    /* 播放器 */
    .video-player .videoCover{
        position: absolute;
        top: 0;
        left: 0;
        width: 880px;
        height: 440px;
        text-align: center;
        line-height: 440px;
        color: #fff;
        font-size: 14px;
    }

    .video-player .controller{
        position: absolute;
        width: 880px;
        overflow: hidden;
        transition: all .2s;
        bottom: 0;
        left: 0;
        height: auto;
    }

    .video-player .program-bar{
        height: 2px;		/*可变*/
        position: relative;
        background: rgba(0,0,0,.2);
        opacity: 0.9;
        cursor: pointer;
        transition: all .2s;
    }

    .video-player .program-bar:hover{
        height: 16px;
    }


    .video-player .program-bar>.loaded{
        background: #828282;
        height: 100%;
        position: absolute;
        top:0;
        transition: all .5s;
    }

    .video-player .program-bar>.current{
        background-image: -webkit-linear-gradient(left,#57a900,#97ff00 80%,#dee2da);
        height: 100%;
        position: absolute;
        top: 0;
    }

    .video-player .program-bar>.cover{
        width: 100%;
        height: 16px;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 10;
    }

    .video-player .program-bar:hover i{
        opacity: 1;
    }

    .video-player .program-bar>i{
        background-color: #fff;
        border-radius: 50%;
        position: absolute;
        z-index: 5;
        cursor: pointer;
        display: block;
        height: 16px;
        width: 16px;
        box-shadow: -1px 0 5px #626262;
        -webkit-box-shadow: -1px 0 5px #626262;
        opacity: 0;
    }

    .video-player .control{
        position: relative;
        background: rgba(0, 0, 0, 0.9);
        height: 40px;
        overflow:hidden;
        transition: all .2s;
    }

    .video-player .control.hide{
        height: 0;
    }

    .video-player .control .btn{
        height: 40px;
        display: inline-block;
        position: relative;
        width: 48px;
    }

    .video-player .control .btn>.playIcon{
        border: 10px dashed transparent;
        border-left: 15px solid #ababab;
        display: inline-block;
        left: 20px;
        top: 10px;
        position: absolute;
        outline: 0;
    }

    .video-player .control .btn:hover .playIcon{
        border-left-color: #6cc900;
    }

    .video-player .control .btn>.stopIcon{
        width: 8px;
        height: 16px;
        border-left: 2px solid #ababab;
        border-right: 2px solid #ababab;
        display: inline-block;
        left: 20px;
        top: 10px;
        position: absolute;
        outline: 0;
    }

    .video-player .control .btn:hover .stopIcon{
        border-color: #6cc900;
    }

    .video-player .control .play-time{
        color: #aaa;
        line-height: 40px;
        font-size: 12px;
        margin-left: 23px;
    }

    .video-player .control .play-time>.currentTime{
        color: #f4f4f4;
    }

    .video-player .control>.rt{
        height: 40px;
    }

    .video-player .control>.rt>span{
        float: left;
        width: 43px;
        height: 100%;
        text-align: center;
        line-height: 40px;
        cursor: pointer;
        position: relative;
    }

    .video-player .control>.rt>span.clarity{		/*清晰度*/
        font-size: 12px;
        color: #aaa;
    }

    .video-player .control>.rt>span.clarity:hover{
        color: #6cc900;
    }

    .video-player .control>.rt>span i{
        width: 18px;
        height: 17px;
        display: inline-block;
        position: relative;
        top: 4px;
    }

    .video-player .control>.rt>span.volume{
        width: auto;
        text-align: left;
        margin: 0 15px;
    }

    .video-player .control>.rt>span.volume .vol-ctrl{
        display: inline-block;
        height: 2px;
        width: 50px;
        background: #828282;
        position: relative;
        top: -4px;
        margin-left: 10px;
    }

    .vol-ctrl>.currentVol{
        position: absolute;
        /*width: 30px;*/
        height: 100%;
        background: #6cc900;
    }

    .vol-ctrl>b{
        position: absolute;
        width: 10px;
        height: 10px;
        background: #f4f4f4;
        border-radius: 50%;
        top: -4px;
        /*left: 25px;	*/
    }

    .vol-ctrl>span.cover{
        width: 100%;
        position: absolute;
        /*background: rgba(0, 0, 0, 0.6);*/
        top: -4px;
        height: 10px;
    }

    .video-player .control>.rt>span.volume i.noVol{
        height: 20px;
        background-position: 0 4px;
    }

    .video-player .control>.rt>span.volume i.noVol:hover{
        background-position: 0 -176px;
    }

    .video-player .control>.rt>span.volume i{
        background: url(../assets/image/play/icon-all.png) no-repeat -73px 4px;
        height: 20px;
    }

    .video-player .control>.rt>span.volume i:hover{
        background-position: -65px -176px;
    }

    .video-player .control>.rt>span.screen i{
        background: url(../assets/image/play/screenExit_icon.png) no-repeat;
    }

    .video-player .control>.rt>span.screen i:hover{
        background: url(../assets/image/play/screenExit_hicon.png) no-repeat;
    }

    .main-box .video-list{
        width: 278px;
        height: 496px;
        position: relative;
    }

    /* 右侧列表 */

    .main-box .video-list>.brand{
        background: url(../assets/image/play/dyDs_bg_v2.png) no-repeat;
        padding: 15px;
        box-sizing: border-box;
    }

    .main-box .video-list .head img{
        width: 50px;
        height: 50px;
        border-radius: 50%;
        border: 2px solid #8c8d8c;
    }

    .main-box .video-list .dName{
        line-height: 46px;
        margin-left: 15px;
    }

    .main-box .video-list .dName>a{
        color: #fff;
        font-size: 14px;
    }

    .main-box .video-list .dName>a:hover{
        color: #57a900;
    }

    .main-box .video-list>.listCont>p{
        color: #fff;
        font-size: 14px;
        padding-left: 5px;
        height: 38px;
        line-height: 38px;
        border-bottom: 2px solid #272727;
    }

    .main-box .video-list>.listCont>.detail>p{
        line-height: 27px;
    }

    .main-box .video-list>.listCont>.detail>.title a{
        color: #fff;
        font-size: 14px;
    }

    .main-box .video-list>.listCont>.detail>.count{
        color: #999;
        font-size: 12px;
    }

    .main-box .video-list>.page{
        background: #3e3e3e;
        width: 292px;
        height: 32px;
        position: absolute;
        bottom: 0;
        right: 5px;
    }

    .main-box .video-list>.page>.pageBtn>li{
        float: left;
        width: 69px;
        border: 2px solid #3e3e3e;
        font-size: 12px;
    }

    .main-box .video-list>.page>.pageBtn>li.active{
        background-color: #2d2d2d;
    }

    .main-box .video-list>.page>.pageBtn>li.active>a{
        color: #67a100;	
    }

    .main-box .video-list>.page>.pageBtn>li>a{
        display: block;
        width: 69px;
        height: 28px;
        line-height: 28px;
        text-align: center;
        color:#c3c3c3;
    }

    .main-box .video-list>.page>.pageBtn>li>a:hover{
        color: #67a100;
    }

    .main-box .more{
        position: absolute;
        width: 282px;
        bottom: 32px;
        background: #272727;
        padding: 12px 0 12px 10px;
    }

    .main-box .more>li{
        width: 70px;
        float: left;
    }

    .main-box .more>li.active a{
        color: #bbb;
    }

    .main-box .more a{
        color: #5d5d5d;
        font-size: 12px;
        height: 30px;
        line-height: 30px;
        float: left;
    }

    .main-box .more a:hover{
        color: #c3c3c3;
    }

    .main-box .newCol{
        height: 46px;
        font-size: 12px;
    }

    .main-box .newCol a{
        color: #999;
        float: left;
        padding: 6px 10px;
        border-radius: 5px;
        margin-top: 7px;
    }

    .main-box .newCol li.good>a:hover{
        background-color: #444;
    }

    .main-box .newCol li .inputBox{
        margin-top: 7px;
        border-radius: 4px;
        overflow: hidden;
    }

    .main-box .newCol li .inputBox>.send{
        background: #666;	/*#63B700*/
        color: #aaa;	
        height: 27px;
        width: 50px;
        text-align: center;
        line-height: 27px;
        cursor: pointer;
    }

    .main-box .newCol li .inputBox>.send.canSend{
        color: #fff;
        background: #63B700;
    }

    .main-box .newCol li .switch{
        background: url(../assets/image/play/site-icons-play.png) no-repeat;
        width: 40px;
        height: 28px;
        display: inline-block;
        margin: -4px 12px 0 6px;
        cursor: pointer;
    }

    .main-box .newCol li .switch.off{
        background-position: 0 -60px;
    }

    .main-box .newCol li .switch.on{
        background-position: -40px -60px;
    }

    .main-box .newCol li .danMuInput{
        color: #999;
        background: #444;
        border: none;
        outline: none;
        padding: 6px 10px;
    }

    .main-box .newCol li .danMuInput.hasVal{
        background: #fff;
        color: #444;
    }

    .main-box .newCol a:hover i{
        background-position: -20px -40px;
    }

    .main-box .newCol li{
        float: left;
        margin-left: 20px;
    }

    .main-box .newCol a>i{
        display: inline-block;
        width: 15px;
        height: 20px;
        background: url(../assets/image/play/site-icons-play.png) no-repeat 0 -20px;
        vertical-align: middle;
        margin-right: 4px;
    }

    .main-box .bottomDetail{
        background: #292929;
        padding:15px 0;
    }

    .main-box .bottomDetail>.bottomLeft{
        width: 880px;
    }

    .main-box .bottomDetail>.bottomLeft>p{
        color: #ddd;
        font-size: 22px;
        margin-bottom: 8px;
    }

    .main-box .bottomDetail .bread{
        color: #666;
        font-size: 12px;
    }

    .main-box .bottomDetail .bread a{
        color: #999;
    }

    .main-box .bottomDetail .bread a:hover{
        color: #67a100;
    }

    .main-box .bottomDetail .detailMore{
        font-size: 12px;
    }

    .main-box .bottomDetail .detailMore a{
        color: #999;
        margin-left: 20px;
    }

    .main-box .bottomDetail .detailMore a>b{
        border: 4px solid transparent;
        border-top: 4px solid #fff;
        display: inline-block;
        position: relative;
        top: 2px;
    }

    .main-box .bottomDetail .detailMore a:hover{
        color: #67a100;
    }

    .main-box .bottomDetail .detailMore a>span{
        color: #ddd;
    }

    .main-box .bottomDetail .detailMore a:hover span{
        color: #67a100;
    }

    .main-box .bottomDetail .detailMore a:hover b{
        border-top-color: #67a100;
    }

    .main-box .bottomDetail .detailMore a.active{
        color: #67a100;
    }

    .main-box .bottomDetail .detailMore a.active b{
        border: 4px solid transparent;
        border-bottom: 4px solid #67a100;
        display: inline-block;
        position: relative;
        top: -1px;
    }

    .main-box .slide{
        border-top: 1px solid #393939;
        background-color: #292929;
        font-size: 12px;
        overflow: hidden;
        box-sizing: border-box;
        height: 172px;
        position: relative;
        transition:all .2s;
    }

    .main-box .slide>.slideImg{
        width: 90px;
        text-align: center;
        margin-top: 15px;
    }

    .main-box .slide img{
        width: 90px;
        height: 120px;
        margin-bottom: 5px;
    }

    .main-box .slide>.slideIntro{
        width: 1075px;
        padding: 5px 0;
        line-height: 20px;
        color: #999;
        margin-top: 15px;
    }

    .main-box .slide>.slideIntro>a{
        color: #666;
    }

    /* 右侧列表内容 */
    .listCont{
        margin-right: 1px;	
    }

    .listCont>.detail{
        height: 372px;
        overflow: hidden;
    }

    .movieList{
        font-size: 12px;
    }

    .movieList ul{
        padding-bottom: 40px;
    }

    .movieList li{
        float: left;
        margin-bottom: 2px;
    }

    .movieList li a{
        color: #999;
        display: block;
        width: 236px;
        height: 43px;
        line-height: 43px;
        padding: 0 12px;
        background-color: #2f2f2f;
        border: 2px solid #2f2f2f;
    }

    .movieList li.current a{
        color: #67a100;
        border: 2px solid #6b9603;
        background-color: #272728;
    }

    .movieList li.current a:hover{
        border: 2px solid #6b9603;
    }

    .movieList li a:hover{
        background-color: #272728;
        border: 2px solid #272728;
    }

    .bottom>.bottomBox{
        width: 1180px;
        margin: 0 auto;
    }

    /* 右侧推荐 */
    .rec>h3{
        font-weight: normal;
        color: #333;
        font-size: 18px;
        border-bottom: 2px solid rgb(234, 234, 234);
        margin: 20px 0;
    }

    .rec>h3>p{
        padding: 7px 0;
        border-bottom: 2px solid #5aa700;
        position: relative;
        top: 2px;
    }

    .rec-right{
        width: 280px;
        background-color: #f2f2f2;
    }

    .rec-right>p{
        color: #699f00;
        padding:6px 0;
    }

    .rec-right>.recList{
        width: 260px;
    }

    .rec-right>.recList>.item{
        margin-top: 10px;
        padding-bottom: 10px;
        border-bottom: 1px dotted #aaa;
    }

    .rec-right>.recList img{
        width: 123px;
    }

    .rec-right>.recList .detail{
        margin-left: 10px;
    }

    .rec-right>.recList .detail>div{
        font-size: 12px;
        color: #bbb;
        margin-top: 6px;
    }

    .rec-right>.recList .detail>.title{
        font-size: 14px;
    }

    #barrage{
        position: absolute;
        top:0;
        left: 0;
    }
</style>