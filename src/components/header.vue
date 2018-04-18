<template>
    <div id="header">
        <div class="header clear">
            <div class="logo lf">
                <!--<a href="index.html">-->
                <router-link to="/index">
                    <img src="../assets/image/header/logo.png">
                </router-link>
                <!--</a>-->
            </div>
            <div class="searchBox lf">
                <input type="text" class="searchInput" placeholder="搜你想搜的" v-model="searchKw">
                <a href="javascript:;" class="searchBtn" @click="search"></a>
            </div>
            <div class="state rt">
                <div v-if="!isLogin">
                    <ul class="clear">
                        <li>
                            <router-link to="/login" class="login">登录</router-link>
                        </li>
                        <li>
                            <router-link to="/register" class="login">注册</router-link>
                        </li>
                        <!--<li>
                            <a href="#">开通VIP</a>
                        </li>-->
                    </ul>
                </div>
                <div class="isLogin" v-if="isLogin">
                    <ul class="clear">
                        <li class="userList"  @mouseover="changeMsgShow" @mouseout="changeMsgHide">
                            <a href="javascript:;" class="user rt">{{userName}}</a>
                            <div class="userMsg" v-if="showMsg">
                                <div class="userHead clear">
                                    <p class="lf avatar">
                                        <a href="javascript:;">
                                            <img :src="avatar">
                                        </a>
                                    </p>
                                    <p class="lf userName">
                                        <a href="javascript:;">{{userName}}</a>
                                        <i class="nVip"></i>
                                        <!--会员图标-->
                                    </p>
                                    <p class="rt">
                                        <a href="javascript:;" @click="logout">退出</a>
                                    </p>
                                </div>
                                <!--vip-->
                                <div class="vipIntro clear">
                                    <div class="vipBox">
                                        <div>
                                            <a href="#">VIP会员</a>
                                            <span>开通</span>
                                        </div>
                                        <p>
                                            全站跳广告 大片随便看
                                        </p>
                                    </div>
                                </div>
                                <!--个人中心-->
                                <div class="userCenter">
                                    <router-link to="/center">进入个人中心></router-link>
                                </div>
                                <b></b>
                            </div>
                            <i class="slide"></i>
                        </li>
                        <li class="move">
                            <a href="javascript:;">开通VIP</a>
                        </li>
                        <!-- <li>
                            <a href="#" class="user">消息</a>
                            <div>
                                msg
                                <div>
                                    <p>
                                        <a href="javascript:;">与我相关</a>
                                        <a href="javascript:;">系统通知</a>
                                    </p>
                                    <div>
                                        与我相关
                                        <div>
                                            <p>您还没收到新的动态</p>
                                        </div>
                                        系统通知
                                    </div>
                                </div>
                            </div>
                            <i class="slide"></i>
                        </li> -->
                        <li class="hist">
                            <a href="javascript:;">播放记录</a>
                            <!--history-->
                            <div class="history" style="display: none">
                                <div class="playHistory">
                                    <p>暂无播放记录</p>
                                    <!-- 有播放记录 -->
                                    <!-- <ul>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                        <li>
                                            <a href="#" class="lf">播放记录1</a>
                                            <span class="rt">2017.12.28</span>
                                        </li>
                                    </ul> -->
                                </div>
                                <div class="more">
                                    <a href="javascript:;">查看更多></a>
                                </div>
                                <b></b>
                            </div>
                            <i class="slide"></i> 
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data:function(){
            return{
                isLogin:false,
                searchKw:'',
                avatar:'#',
                userName:'',
                showMsg:false
            }
        },
        mounted:function(){
            this.loadUserState();
        },
        methods:{
            loadUserState:function(){
                this.$http.get("http://127.0.0.1:3000/isLogin",{credentials:true})
                    .then(function(res){
                        //console.log(res.data);
                        if(res.data.code==1){
                            this.isLogin = true;
                            if(res.data.data.avatar.indexOf("http")!==-1){
                               this.avatar = res.data.data.avatar;
                            }else{
                               this.avatar = require('../assets/'+res.data.data.avatar);
                            }
                            this.userName = res.data.data.name;
                            this.$emit("userId",res.data.data.uid);
                        }else{
                            this.isLogin = false;
                        }
                        this.$emit("isLogin",this.isLogin);
                    })
            },
            search:function(){
                if(this.searchKw.trim()!=''){
                    this.$router.push('/list/kw/'+this.searchKw);
                }
            },
            logout:function(){
                this.$http.get("http://127.0.0.1:3000/logout",{credentials:true})
                    .then(function(res){
                        if(res.data.code==1){
                            this.loadUserState();
                        }else{
                            alert("网络错误!");
                        }
                    })
            },
            changeMsgShow:function(){
                this.showMsg = true;
            },
            changeMsgHide:function(){
                this.showMsg = false;
            }
        }
    }
</script>
