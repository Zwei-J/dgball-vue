<template>
    <div>
        <HeaderComponent></HeaderComponent>
        <!-- container -->
        <div class="top_banner">        <!-- 100% -->
            <div class="banner lf" style="width:100%">
                    <!-- 立体轮播图 -->
                    <div class="caroursel poster-main" style="margin: 0 auto" data-setting = '{
                        "width":1300,
                        "height":380,
                        "posterWidth":640,
                        "posterHeight":380,
                        "scale":0.9,
                        "dealy":"4000",
                        "algin":"middle"
                        }'>
                        <ul class="poster-list">
                            <li class = "poster-item" :key="index" v-for="(tmp,index) in carouselList">
                                <img :src="require('../assets/'+tmp.src)">
                            </li>
                        </ul>
                        <div class="poster-btn poster-prev-btn"></div>
                        <div class="poster-btn poster-next-btn"></div>
                    </div>
                </div>
            <!-- 按钮 -->
            <div class="banner-btn">
                <a href="javascript:;" class="prev"></a>
                <div class="icon">
                    <div>
                        <img src="../assets/image/index/banner1_icon.jpg">
                    </div>
                    <div>
                        <img src="../assets/image/index/banner2_icon.jpg">
                    </div>
                    <div>
                        <img src="../assets/image/index/banner3_icon.jpg">
                    </div>
                    <div>
                        <img src="../assets/image/index/banner4_icon.jpg">
                    </div>
                    <div>
                        <img src="../assets/image/index/banner5_icon.jpg">
                    </div>
                </div>
                <a href="javascript:;" class="next"></a>
            </div>
        </div>
        <div class="container">
            <div class="title">
                <h3>龙珠系列</h3>
            </div>
            <div class="media">
                <div class="banner clear" :key="index" v-for="(tmp,index) in mainList">
                    <div class="pic lf">
                        <router-link :to="'/detail/'+tmp.seriesId">
                            <img :src="require('../assets/'+ tmp.seriesLogo_lg)">
                        </router-link>
                    </div>
                    <div class="item lf">
                        <p class="title">
                            <router-link :to="'/detail/'+tmp.seriesId">{{tmp.seriesName}}</router-link>
                            <span>{{tmp.pTime}}</span>
                        </p>
                        <ul class="detail clear">
                            <li>地区：<span>{{tmp.area}}</span></li>
                            <li>类型：<span>{{tmp.type | join}}</span></li>
                            <li>语言：<span>{{tmp.lang}}</span></li>
                            <li>版本：<span>{{tmp.version}}</span></li>
                            <li>配音：<span>{{tmp.Akira | join}}</span></li>
                            <li>集数：<span>{{tmp.count}}集</span></li>
                            <li>总播放量：<span>{{tmp.playCount}}次</span></li>
                        </ul>
                        <div class="intro">
                            简介：
                            <span :title="tmp.introduce">{{tmp.introduce | slice}}</span>
                        </div>
                        <div class="playNow">
                            <router-link :to="'/play/'+tmp.seriesId+'/'+tmp.start">立即播放</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <FooterComponent></FooterComponent>
    </div>
</template>

<script>
    import header from '@/components/header';
    import footer from '@/components/footer'; 
    export default {
        data:function(){
            return{
                carouselList:[],
                mainList:[],
                $CAROUSEL:null
            }
        },

        beforeMount:function(){
            this.$http.get('http://127.0.0.1:3000/getCarousel')
                .then(function(res){
                    this.carouselList = res.data;
                }).then(function(){
                    this.$CAROUSEL = $(".caroursel");
                    Caroursel.init(this.$CAROUSEL);
                })
            this.$http.get('http://127.0.0.1:3000/getSeries')
                .then(function(res){
                    this.mainList = res.data;
                })
        },

        mounted:function(){
           document.title = "龙珠迷的世界";
        },

        filters:{
            slice:function(val){
                return val.slice(0,66)+'...';
            },
            join:function(val){
                val = val.replace(/_/ig," / ");
                return val;
            }
        },

        methods:{

        },

        components:{
            HeaderComponent:header,
            FooterComponent:footer
        }
    }
</script>

<style scoped>
    /* 主页 */

    .container .nav{
        height: 25px;
        border: 1px solid red;
        margin-bottom: 10px;
    }

    .top_banner{
        width: 100%;
        overflow: hidden;
        position: relative;
        height: 380px;
        margin: 30px 0 60px 0;
    }

    .carousel{
        margin: 0 auto;
        position: absolute;
    }

    .top_banner img{
        width: 100%;
        height: 100%;
    }

    .carousel a{
        float: left;
    }

    .top_banner>.banner-btn{
        text-align: center;
        position: relative;
        top: 380px;
    }

    .top_banner>.banner-btn>a{
        display: inline-block;
        width: 64px;
        height: 64px;
    }

    .top_banner>.banner-btn>.icon{
        padding: 5px 26px;
        display: inline-block;
        background: rgba(0,0,0,.7);
        position: relative;
        top: -11px;
    }

    .top_banner>.banner-btn>.icon>div{
        display: inline-block;
        box-sizing: border-box;
        border: 2px solid rgba(0,0,0,.7);
        opacity: 0.7;
        cursor: pointer;
    }

    .top_banner>.banner-btn>.icon img{
        vertical-align: bottom;
        display: inline-block;
        width: 84px;
        height: 50px;
    }

    .top_banner>.banner-btn>.icon div:hover{
        border: 2px solid #5aa700;
        opacity: 1;
    }

    .container>.title{
        margin-top: 30px;
    }

    .container>.title>h3{
        color: #699f00;
    }

    .container .media{
        margin: 20px 0 50px;
    }

    .media>.item{
        height: 300px;
        margin-bottom: 20px;
        border: 1px solid red;
    }

    .media>.banner>.pic{
        height: 260px;
        width: 450px;
        margin-right: 10px;
        overflow: hidden;
        position: relative;
    }

    .media>.banner>.pic img{
        width: 100%;
        height: 100%;
    }


    .container .banner{
        margin-top: 30px;
        padding: 0 15px;
    }

    .banner>.carousel{
        height: 260px;
        width: 450px;
        border: 1px solid red;
        margin-right: 10px;
        overflow: hidden;
        position: relative;
    }

    .banner>.carousel img{
        width: 280px;
        position: absolute;
        border: 10px solid #f2f2f2;
        box-sizing: border-box;
        border-radius: 2px;
        box-shadow: 2px 2px 2px #888;
    }

    .banner>.item{
        width: 460px;
        margin-left: 20px;
    }

    .banner>.item>.title{
        margin-bottom: 12px;
    }

    .banner>.item>.title a{
        font-size: 24px;
    }

    .banner>.item>.title span{
        font-size: 14px;
        color: #888;
    }

    .banner>.item>.detail li{
        float: left;
        width: 200px;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        font-size: 12px;
        color: #888;
        line-height: 26px;
    }

    .banner>.item>.detail li>span{
        color: #222;
    }

    .banner>.item>.intro{
        color: #888;
        font-size: 12px;
        line-height: 24px;
        height: 48px;
        margin-bottom: 8px;
    }

    .banner>.item>.intro>span{
        color:#555;
    }

    .banner>.item>.playNow a{
        width: 118px;
        height: 38px;
        line-height: 38px;
        text-align: center;
        display: block;
        color: #fff;
        background: rgb(119,180,0);
        transition: background .2s;
    }
    .banner>.item>.playNow a:hover {
        background: rgb(106, 161, 0);
    }
</style>
