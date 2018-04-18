<template>
    <div>
        <HeaderComponent></HeaderComponent>
        <div class="container runoff">
            <div class="searchContainer">
                <div class="container-searchBox clear">
                    <div class="lf">
                        <input id="innerInput" v-model="inKw" type="text" placeholder="搜你想搜的">
                    </div>
                    <div class="lf">
                        <a href="javascript:;" @click="inSearch" id="innerSearchBtn">搜 索</a>
                    </div>
                </div>
            </div>
            <!--列表-->
            <div class="list-container">
                <!--会隐藏-->
                <div class="result" v-if="searchList.length>0">搜索“<span>{{kw}}</span>”，共找到 <span>{{pageMsg.totalCount}}</span> 个结果</div>
                <div class="result" v-if="searchList.length==0">抱歉，未找到你搜索的结果~</div>                
                <div class="resultList">
                    <!-- 未找到 -->
                    <div class="notFound" v-if="searchList.length==0">
                        <img src="../assets/image/list/notFound.gif" alt="">
                    </div>
                    <ul style="display:block" v-if="searchList.length>0">
                        <li class="title clear">
                            <span class="number">序号</span>
                            <span class="pTitle">标题</span>
                            <span>所属片名</span>
                            <span>播放次数</span>
                        </li>
                        <li :key="index" v-for="(tmp,index) in searchList">
                            <span class="num">{{index+1+(pageMsg.pno-1)*15}}</span>
                            <router-link :to="'/play/'+tmp.sid+'/'+tmp.vid" class="resTitle">{{tmp.title}}</router-link>
                            <router-link :to="/detail/+tmp.sid" class="resAll">{{tmp.sName}}</router-link>
                            <span class="count">{{tmp.playCount}}</span>
                        </li>
                    </ul>
                </div>
                <div class="pageBtn" v-if="searchList.length>0">
                    <a href="javascript:;" class="effect">上一页</a>
                    <!--<a href="javascript:;" class="active">1</a>
                    <a href="javascript:;">2</a>-->
                    <a href="javascript:;" @click="search(tmp)" :class="pageMsg.pno==tmp?'active':''" :key="index" v-for="(tmp,index) in pageMsg.pageCount">{{tmp}}</a>
                    <a href="javascript:;">下一页</a>
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
            searchList:[],
            inKw:'',
            pageMsg:{}
        }
    },
    beforeMount(){
        this.search();
    },
    watch:{
        '$route':'reload'
    },
    methods:{
        search:function(pno){
            this.kw = this.$route.params.kw;
            var pno = pno || 1;
            this.$http.get("http://127.0.0.1:3000/search/"+this.kw+"/"+pno)
                .then(function(res){
                    this.pageMsg = res.data;
                    this.searchList = res.data.content;
                })
        },
        reload:function(){
            this.search();
        },
        inSearch:function(){
            var newKw = this.inKw.trim();
            if(newKw==''){
                return;
            }
            this.$router.push('/list/kw/'+newKw);
            this.search();
        }
    },
    components:{
        HeaderComponent: header,
        FooterComponent: footer
    }
}
</script>

<style scoped>
    .container>.searchContainer{
        margin: 30px 0;
    }

    .container-searchBox{
        width: 588px;
        margin: 0 auto;
    }

    #innerInput{
        width: 450px;
        border: 1px solid #6fa800;
        outline: 0;
        height: 38px;
        padding: 0 10px;
        border-radius: 5px 0 0 5px;
    }

    #innerSearchBtn{
        display: inline-block;
        width: 116px;
        background: #6EA700;
        height: 40px;
        line-height: 40px;
        text-align: center;
        color: #fff;
        border-radius: 0 5px 5px 0;
    }

    .list-container{
        margin-bottom: 30px;
    }

    .list-container>.result{
        font-size: 14px;
        color: #666;
    }

    .list-container>.result>span{
        color: #222;
        font-weight: bold;
    }

    .list-container>.resultList{
        width: 680px;
        margin: 40px auto;
        font-size: 14px;
    }

    .list-container>.resultList li{
        height: 40px;
        line-height: 40px;
    }

    .list-container>.resultList .title{
        background: #F4F4F4;
        color: #888;
    }

    .list-container>.resultList .title>span{
        float: left;
        width: 170px;
        text-align: center;
        color: #666;
    }

    .list-container>.resultList .title .pTitle{
        width: 240px;
    }

    .list-container>.resultList .title .number{
        width: 100px;
    }

    .list-container>.resultList li:after{
        content:"";
        clear: both;
        display: block;
    }

    .list-container>.resultList a{
        float: left;
        color: #111;
    }

    .list-container>.resultList span{
        text-align: center;
        float: left;
        color: #aaa;
    }

    .list-container>.resultList span.num{
        width: 100px;
    }

    .list-container>.resultList span.count{
        width: 170px;
    }

    .list-container>.resultList a{
        text-align: center; 
    }

    .list-container>.resultList a.resTitle{
        width: 240px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .list-container>.resultList a.resAll{
        width: 170px;
    }

    .list-container .pageBtn{
        width: 680px;
        margin: 0 auto;
        text-align: center;
    }

    .list-container .pageBtn>a{
        display: inline-block;
        height: 28px;
        line-height: 28px;
        padding: 0 10px;
        font-size: 14px;
        text-align: center;
        color: #555;
        border: 1px solid #aaa;
    }

    .list-container .pageBtn>a.active{
        background: #63B700;
        color: #fff;
        border-color: #63B700;
    }

    .list-container .pageBtn>a:hover{
        border-color: #63B700;
    }

    .list-container .pageBtn>a.effect{
        color:#aaa;
        border: 1px solid #ddd;
        cursor: default;
    }

    /*未找到*/
    .list-container>.resultList .notFound{
        text-align: center;
        margin: 60px 0;
    }

    .list-container>.resultList .notFound>img{
        width: 300px;
        opacity: 0.3;
    }
</style>
