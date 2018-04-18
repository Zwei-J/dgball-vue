<template>
    <div class="commentBox lf">
        <!--评论区-->
        <div class="commentInput">
            <h3 class="clear">
                <!--<p class="lf">珠迷评论 <span>(1条)</span></p>-->
                <p class="lf">最新评论</p>                
            </h3>
            <div class="toComment">
                <div class="inputBox">
                    <textarea id="commentInput" placeholder="我来说两句..." v-model="comment"></textarea>
                </div>
                <div class="control clear">
                    <div>
                        <!-- 表情 -->
                    </div>
                    <div class="rt">
                        <a href="javascript:;" class="send" @click="toComment">发布</a>
                    </div>
                </div>
                <!-- 遮布  -->
                <div class="cover" v-if="!isLogin">
                    您需要
                    <router-link to="/login">登录</router-link>
                    才能发表评论。没有账号？
                    <router-link to="/register">注册</router-link>
                    一个。
                </div>
            </div>
        </div>
        <!-- 评论内容 -->
        <div class="commentList">
            <ul>
                <li class="item clear" :key="index" v-for="(tmp,index) in commList">
                    <div class="avatar lf">
                        <a href="javascript:;">
                            <img :src="tmp.avatar.indexOf('http')!==-1?tmp.avatar:require('../assets/'+tmp.avatar)">
                        </a>
                    </div>
                    <div class="content lf">
                        <p><a href="javascript:;">{{tmp.name}}</a> <span>{{tmp.commTime | changeTime}}</span></p>
                        <div>{{tmp.content}}</div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    export default {
        data:function(){
            return{
                commList:[],
                comment:'',  //评论内容
            }
        },
        props:['videoId','isLogin','userId'],
        beforeMount:function(){
            this.loadList();
        },
        methods:{
            loadList:function(){
            var vid = this.videoId;
                this.$http.get("http://127.0.0.1:3000/getComment/"+vid)
                    .then(function(res){
                        this.commList = res.data;
                    });
            },
            toComment:function(){
                var input = this.comment;
                if(input.trim()==''||!this.userId){
                    return;
                }
                this.comment = '';
                this.$http.get("http://127.0.0.1:3000/comment/"+this.videoId+"/"+this.userId+"/"+input)
                    .then(function(res){
                        if(res.data.code==1){
                            this.loadList();    //评论成功
                        }else{
                            alert("网络错误");
                        }
                    })
            },
        },
        filters:{
            changeTime:function(date){
                var now = new Date().toLocaleString();
                var today = now.slice(0,now.indexOf(" "));
                var todayMs = new Date(today).getTime();    //当日00:00的毫秒数
                var show = new Date(date);
                var thatDayMs = show.getTime();     //评论时的毫秒数
                show = show.toLocaleString();//2018/1/31 下午11:03:07     2018/2/1 上午12:29:53
                var spaceNat = show.indexOf(" ");   //空格所在位置
                var date = show.slice(0,spaceNat); //2018/1/31
                date = date.replace(/\//g,"-");    //2018-1-31
                var time = show.slice(spaceNat+3);  //11:03:07
                var node = time.indexOf(":");   //第一个分号位置
                var hh = time.slice(0,node);
                var mm = time.slice(node+1,node+3);
                var ss = time.slice(time.lastIndexOf(":")+1);
                var apm = show.slice(spaceNat+1,spaceNat+3);
                if(apm=='下午'){
                    if(hh!='12'){
                        hh = (parseInt(hh)+12).toString();
                    }
                }else{
                    if(hh=='12'){
                        hh = '00';
                    }
                }
                var time24 = hh+":"+mm+":"+ss;
                if(todayMs<thatDayMs){
                    return time24;
                }else if(todayMs-thatDayMs<86400000){
                    return '昨天';
                }else{
                    return date+" "+time24;     //厉害了大兄弟，加油！！！
                }
            }
        }
    }
</script>

<style scoped>
   .bottom .commentBox{
        width: 880px;
    }

    .bottom .commentInput>h3{
        font-weight: normal;
        color: #333;
        font-size: 18px;
        border-bottom: 2px solid rgb(234, 234, 234);
        margin: 20px 0;
    }

    .bottom .commentInput>h3>p{
        padding: 7px 0;
        border-bottom: 2px solid #5aa700;
        position: relative;
        top: 2px;
    }

    .bottom .commentInput>h3 span{
        font-size: 14px;
        color: #8a8a8a;
    }

    .bottom .toComment{
        width: 100%;
        position: relative;
        margin-bottom: 20px;
    }

    .bottom .toComment>.cover{
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        background: rgba(204,204,204,.3);
        text-align: center;
        line-height: 160px;
        font-size: 14px;
        color: #444;
    }

    .bottom .toComment>.cover>a{
        color: #5aa700;
    }

    .bottom .inputBox{
        border: 1px solid #ddd;
        padding: 7px;
        border-radius: 2px 2px 0 0;
    }

    .bottom textarea{
        width: 100%;
        height: 118px;
        color: #999;
        resize: none;
        outline: none;
        border: none;
        font-size: 12px;
        font-family: inherit;
        overflow: hidden;
    }

    .bottom .control{
        padding: 6px;
        border-width: 0px 1px 1px;
        border-style: solid solid solid;
        border-color: rgb(221, 221, 221) rgb(221, 221, 221) rgb(221, 221, 221);
        border-image: initial;
        border-top: 0px;
        border-radius: 0px 0px 3px 3px;
    }

    .bottom .control .send{
        display: inline-block;
        width: 84px;
        height: 26px;
        line-height: 26px;
        text-align: center;
        margin-left: 20px;
        margin-top: 2px;
        color: rgb(255, 255, 255);
        background-color: rgb(90, 167, 0);
        font-size: 14px;
        border-radius: 3px;
        transition: all .2s;
    }

    .bottom .control .send:hover{
        background-color: #63B700;
    }

    .commentList .item{
        padding: 15px 0;
        border-bottom: 1px solid #ddd;
    }

    .commentList .item>.avatar img{
        width: 50px;
        height: 50px;
        border-radius: 50%;
    }

    .commentList .item>.content{
        margin-left: 10px;
        width: 820px;
    }

    .commentList .item>.content p{
        padding: 8px 0;
    }

    .commentList .item>.content p>a{
        font-size: 14px;
        color: #333;
    }

    .commentList .item>.content p>span{
        font-size: 12px;
        color: #999;
        margin-left: 5px;
    }

    .commentList .item>.content>div{
        font-size: 14px;
        padding: 10px 0;
    }
</style>