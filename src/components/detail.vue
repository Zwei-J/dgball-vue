<template>
    <div>
        <HeaderComponent/>
        <div class="container">
            <div class="nav">
                <p>
                    <router-link to="/index">首页</router-link> >
                    <router-link :to="'/detail/'+msgList.seriesId">{{msgList.seriesName}}</router-link>
                </p>
            </div>
            <div class="banners clear">
                <div class="banner lf">
                    <!-- 立体轮播图 -->
                    <div class="caroursel poster-main" data-setting = '{
                        "width":460,
                        "height":270,
                        "posterWidth":280,
                        "scale":0.9,
                        "dealy":"4000",
                        "algin":"middle"
                    }'>
                        <ul class="poster-list">
                            <li class="poster-item" :key="index" v-for="(tmp,index) in imgList">
                                <img :src="require('../assets/'+tmp.source)">
                            </li>
                        </ul>
                        <div class="poster-btn poster-prev-btn"></div>
                        <div class="poster-btn poster-next-btn"></div>
                    </div>
                </div>
                <div class="item lf">
                    <p class="title">
                        <router-link :to="'/detail/'+msgList.seriesId">{{msgList.seriesName}}</router-link>
                        <span>{{msgList.pTime}}</span>
                    </p>
                    <ul class="detail clear">
                        <li>地区：<span>{{msgList.area}}</span></li>
                        <li>类型：<span>{{msgList.type | join}}</span></li>
                        <li>语言：<span>{{msgList.lang}}</span></li>
                        <li>版本：<span>{{msgList.version}}</span></li>
                        <li>配音：<span>{{msgList.Akira | join}}</span></li>
                        <li>集数：<span>{{msgList.count}}集</span></li>
                        <li>总播放量：<span>{{msgList.playCount}}次</span></li>
                    </ul>
                    <div class="intro">
                        简介：
                        <span :title="msgList.introduce">{{msgList.introduce | slice}}</span>
                    </div>
                    <div class="playNow">
                        <router-link :to="'/play/'+msgList.seriesId+'/'+msgList.start">立即播放</router-link>
                    </div>
                </div>
            </div>
            <div class="play-main clear">
                <!-- 视频分页 -->
                <div class="main lf">
                    <ul class="title clear">
                        <li class="active"><a href="javascript:;">概览</a></li>
                    </ul>
                    <!-- 分页按钮 -->
                    <div class="page">
                        <a href="javascript:;" :class="pageNum==index+1?'disable':''" @click=changePage(index+1) :key="index" v-for="(tmp,index) in btnList">{{tmp}}</a>
                        <!--<a href="javascript:;" class="disable">1-50</a>
                        <a href="javascript:;">51-100</a>
                        <a href="javascript:;">101-150</a>
                        <a href="javascript:;">151-200</a>
                        <a href="javascript:;">201-250</a>
                        <a href="javascript:;">251-291</a>-->
                    </div>
                    <!-- TAB切换按钮 -->
                    <p class="typeSelect clear">
                        <span class="rt">
                            <a :class="showNumList?'left active':'left'" href="javascript:;" @click="changeNum">数字选集</a><a :class="showNumList?'right':'right active'" href="javascript:;" @click="changePic">图文选集</a>
                        </span>
                    </p>
                    <!-- 分页主体 这一部分要有过渡 溢出隐藏 -->
                    <div class="pageBox">
                        <!-- 大盒子 -->
                        <div class="page">
                            <!-- 数字选集 -->
                            <ul class="numPage" :style="{display: showNumList?'block':'none'}">
                                <li :key="index" v-for="(tmp,index) in detailList">
                                    <router-link :to="'/play/'+tmp.sid+'/'+tmp.vid" :title="tmp.title">{{tmp.num}}</router-link>
                                </li>
                            </ul>
                            <!-- 图文选集 -->
                            <div class="picPage clear" :style="{display: showNumList?'none':'block'}">
                                <div class="item" :key="index" v-for="(tmp,index) in detailList">
                                    <div class="img">
                                        <router-link :to="'/play/'+tmp.sid+'/'+tmp.vid" :title="tmp.title">
                                            <img :src="require('../assets/'+tmp.imgSrc)">
                                        </router-link>
                                        <span>
                                            {{tmp.vTime}}
                                        </span>
                                    </div>
                                    <p class="number">
                                        <router-link :to="'/play/'+tmp.sid+'/'+tmp.vid">第<span>{{tmp.num}}</span>集</router-link>
                                    </p>
                                    <p class="title">
                                        <router-link :to="'/play/'+tmp.sid+'/'+tmp.vid">{{tmp.title}}</router-link>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 右侧推荐 -->
                <div class="rec-right rt">
                    <p>相关推荐</p>
                    <div class="recList">
                        <div class="item clear" :key="index" v-for="(tmp,index) in recList">
                            <div class="img lf">
                                <router-link :to="'/detail/'+tmp.seriesId" :title="tmp.seriesName">
                                    <img :src="require('../assets/'+tmp.seriesLogo_sm)">
                                </router-link>
                            </div>
                            <div class="detail lf">
                                <p class="title"><router-link :to="'/detail/'+tmp.seriesId">{{tmp.seriesName}}</router-link></p>
                                <div class="playCount"><i></i>{{tmp.playCount}}次</div>
                                <div class="numCount"><span>{{tmp.count}}</span>集全</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <video id="video" width="100%" :src="videoSrc" loop autoplay>
        </video>
        <FooterComponent/>
    </div>
</template>

<script>
    import header from '@/components/header';
    import footer from '@/components/footer';
    export default {
        data:function(){
            return{
                $CAROUSEL:null,
                $VIDEO:null,
                $WINDOWHEIGHT:null,
                imgList:{}, //轮播列表
                msgList:{}, //信息列表
                videoSrc:'#',
                recList:[], //相关推荐
                detailList:[],  //分页列表
                btnList:[],
                pageNum:1,
                showNumList:false
            }
        },
        watch:{
            '$route':['paramChange']
        },
        beforeMount:function(){
            //挂载前加载整个页面
            this.$CAROUSEL = null;
            var sid = this.$route.params.sid;
            this.$http.get("http://127.0.0.1:3000/detailMsg/"+sid)
            .then(function(res){
               this.msgList = res.data[0];
               document.title = res.data[0].seriesName+' - 全集播放列表';               
               var btns = Math.ceil(this.msgList.count/50);
               this.btnList = [];
               for(var i=1;i<=btns;i++){
                  if(i==btns){
                     this.btnList.push(50*(i-1)+1+"-"+this.msgList.count);
                     break;
                  }
                  this.btnList.push(50*(i-1)+1+"-"+i*50);
               }
               //console.log(this.btnList);
               if(this.msgList){
                  this.videoSrc = require('@/assets/'+this.msgList.bgVideo);
               }
            })
            .then(function(){
                this.$VIDEO = $("#video");
                this.$WINDOWHEIGHT = $(window).height();
                this.$VIDEO.attr("height",this.$WINDOWHEIGHT+'px');
                document.getElementById("video").play();
                document.getElementById("video").volume = 0;
            });
            this.$http.get("http://127.0.0.1:3000/detailImg/"+sid)
                .then(function(res){
                    this.imgList = res.data;
                }).then(function(){
                    this.$CAROUSEL = $(".caroursel");
                    Caroursel.init(this.$CAROUSEL);
                });
            this.$http.get('http://127.0.0.1:3000/getRec')
                .then(function(res){
                    this.recList = res.data;
                });
            this.$http.get('http://127.0.0.1:3000/loadDetail/'+sid+'/'+this.pageNum)
                .then(function(res){
                    this.detailList = res.data;
                })
        },
        mounted:function(){
        },
        beforeDestroy:function(){
            this.$CAROUSEL = this.$VIDEO = this.$WINDOWHEIGHT = 
            this.imgList = this.msgList = this.videoSrc = this.recList = null;
        },
        filters:{
            slice:function(val){
                if(val){
                    return val.slice(0,66)+'...';
                }
            },
            join:function(val){
                if(val){
                    val = val.replace(/_/ig," / ");
                    return val;
                }
            }
        },
        methods:{
            loadAll:function(){
               //加载所有页面信息
               var sid = this.$route.params.sid;
               this.$http.get("http://127.0.0.1:3000/detailMsg/"+sid)
               .then(function(res){
                  this.msgList = res.data[0];
                  document.title = res.data[0].seriesName+' - 全集播放列表';
                  var btns = Math.ceil(this.msgList.count/50);
                  this.btnList = [];
                  for(var i=1;i<=btns;i++){
                     if(i==btns){
                           this.btnList.push(50*(i-1)+1+"-"+this.msgList.count);
                           break;
                     }
                     this.btnList.push(50*(i-1)+1+"-"+i*50);
                  }
                  //console.log(this.btnList);
                  if(this.msgList){
                     this.videoSrc = require('@/assets/'+this.msgList.bgVideo);
                  }
               })
               .then(function(){
                  this.$VIDEO = $("#video");
                  this.$WINDOWHEIGHT = $(window).height();
                  this.$VIDEO.attr("height",this.$WINDOWHEIGHT+'px');
                  document.getElementById("video").play();
                  document.getElementById("video").volume = 0;
               });
               this.$http.get("http://127.0.0.1:3000/detailImg/"+sid)
                  .then(function(res){
                     this.imgList = res.data;
                  })
               this.$http.get('http://127.0.0.1:3000/getRec')
                  .then(function(res){
                     this.recList = res.data;
                  });
               this.$http.get('http://127.0.0.1:3000/loadDetail/'+sid+'/1')
                  .then(function(res){
                     this.detailList = res.data;
                     this.pageNum = 1;
                  })
            },
            paramChange:function(){
                this.loadAll();
            },
            changeNum:function(){
                this.showNumList = true;
            },
            changePic:function(){
                this.showNumList = false;
            },
            changePage:function(val){
                if(val==this.pageNum){
                    return;
                }else{
                    this.pageNum = val;
                    var sid = this.$route.params.sid;
                    this.$http.get('http://127.0.0.1:3000/loadDetail/'+sid+'/'+this.pageNum)
                    .then(function(res){
                        this.detailList = res.data;
                    })
                }
            }
        },
        components:{
            HeaderComponent:header,
            FooterComponent:footer
        }
    }
</script>

<style scoped>
    .container{
        margin-top: 15px;
        background: rgba(255,255,255,0.8);
        padding: 20px 20px;
        margin: 0 auto;
        position: relative;
    }

    .container .nav{
        font-size: 14px;
    }

    .container .banners{
        margin-top: 30px;
        padding: 0 15px;
    }

    .banners>.banner{
        height: 260px;
        width: 450px;
        margin-right: 10px;
        overflow: hidden;
        position: relative;
    }

    .banners>.banner img{
        width: 100%;
        border: 10px solid #f2f2f2;
        box-sizing: border-box;
        border-radius: 2px;
        box-shadow: 2px 2px 2px #888;
    }

    .banners>.item{
        width: 460px;
        margin-left: 20px;
    }

    .banners>.item>.title{
        margin-bottom: 12px;
    }

    .banners>.item>.title a{
        font-size: 24px;
    }

    .banners>.item>.title span{
        font-size: 14px;
        color: #888;
    }

    .banners>.item>.detail li{
        float: left;
        width: 200px;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        font-size: 12px;
        color: #888;
        line-height: 26px;
    }

    .banners>.item>.detail li>span{
        color: #222;
    }

    .banners>.item>.intro{
        color: #888;
        font-size: 12px;
        line-height: 24px;
        height: 48px;
        margin-bottom: 8px;
    }

    .banners>.item>.intro>span{
        color:#555;
    }

    .banners>.item>.playNow a{
        width: 118px;
        height: 38px;
        line-height: 38px;
        text-align: center;
        display: block;
        color: #fff;
        background: rgb(119,180,0);
        transition: background .2s;
    }
    .banners>.item>.playNow a:hover {
        background: rgb(106, 161, 0);
    }

    /* 主体 */
    .play-main{
        margin:25px 0 40px;
    }

    /* 左侧 */
    .play-main>.main{
        width: 680px;
        padding-bottom: 10px;
        border-bottom: 1px solid #ddd;
    }

    .play-main>.main>.title{
        border-bottom: 2px solid #f0f0f0;
    }

    .play-main>.main>.title li{
        float: left;
        padding: 5px 15px;
        box-sizing: border-box;
        position: relative;
        top:2px;
        margin-right: 10px;
    }

    .play-main>.main>.title li.active{
        border-bottom: 2px solid #699f00;
    }

    .play-main>.main>.title li.active a{
        color: #6cc900;
    }

    .play-main>.main>.page{
        margin-top: 20px;
    }

    .play-main>.main>.page>a{
        width: 83px;
        height: 24px;
        border-radius: 3px;
        text-align: center;
        line-height: 24px;
        display: inline-block;
        border: 1px solid rgb(236,236,236);
        margin-right: 10px;
        font-size: 14px;
    }

    .play-main>.main>.page>a:hover{
        background: #F7F7F7;
    }

    .play-main>.main>.page>a.disable{
        background: #F7F7F7;
        color: #6cc900;
        cursor: default;
    }
    /* 数字选集和图文选集按钮 */
    .play-main .typeSelect{
        margin: 12px 0 20px;
    }

    .play-main .typeSelect a{
        display: inline-block;
        width: 68px;
        height: 24px;
        font-size: 12px;
        line-height: 24px;
        text-align: center;
        background: rgb(246, 246, 246);
        color: #6cc900;
        border: 1px solid rgb(236,236,236);
    }

    .play-main .typeSelect a.left{
        border-radius: 3px 0 0 3px;
    }

    .play-main .typeSelect a.right{
        border-radius: 0 3px 3px 0;
    }

    .play-main .typeSelect a.active{
        background-color: #699f00;
        color: #fff;
        border-color: #699f00;
    }

    /* 数字选集 */
    .play-main .numPage{
        padding-left: 14px;
    }

    .play-main .numPage li{
        float: left;
    }

    .play-main .numPage a{
        display: inline-block;
        width: 55px;
        height: 40px;
        border: 1px solid #e1e1e1;
        background: #fbfbfb;
        line-height: 40px;
        color: #333;
        font-size: 14px;
        text-align: center;
        font-family: arial;
        border-radius: 3px;
        transition: all .2s;
        margin: 0 0 12px 12px;
    }

    .play-main .numPage a:hover{
        color:#fff;
        background-color: #6CA500;
    }


    /* 图文选集 */
    .play-main .pageBox{
        width: 680px;
    }

    .play-main .pageBox>.page{
        width: 705px;
        position: relative;
        right: 25px;
    }

    .play-main .picPage>.item{
        float: left;
        width: 116px;
        padding-left: 25px;
        margin-bottom: 15px;
    }

    .play-main .picPage>.item .img{
        position: relative;
    }

    .play-main .picPage>.item .img>span{
        color: #fff;
        background-color: rgba(0,0,0,0.6);
        padding: 0 5px;
        position: absolute;
        bottom: 5px;
        right: 5px;
        font-size: 12px;
        line-height: 15px;
        border-radius: 3px;
    }

    .play-main .picPage>.item>.number{
        font-size: 14px;
        height: 24px;
        line-height: 24px;
    }

    .play-main .picPage>.item>.title{
        font-size: 12px;
        text-overflow:ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }





    /* 右侧推荐 */
    .play-main>.rec-right{
        width: 280px;
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

    #video{
        position: fixed;
        top:0;
        z-index: -999;
        object-fit:fill;
        opacity: 0.4;
    }
</style>