<template>
    <div class="box">
        <div class="header">
            <div>
                <div>
                    <router-link to="/index">
                        <img src="../assets/image/header/logo.png">
                    </router-link>
                </div>
            </div>
        </div>
        <div class="container">
            <div>
                <div class="loginBox">
                    <p>用户登录</p>
                    <div class="form">
                        <p>
                            <input type="text" placeholder="请输入手机号" @focus="clearPhoneMsg" @blur="checkPhone" v-model="phone">
                            <span id="phoneRes">{{phoneMsg}}</span>
                        </p>
                        <p>
                            <input type="password" placeholder="请输入密码" maxlength="16" v-model="pwd" @blur="checkPwd">
                            <span id="pwdRes">{{loginMsg}}</span>
                        </p> 
                        <p>
                            <input type="button" id="loginBtn" value="登 录" @click="login">
                        </p>
                        <p class="reg">
                            <router-link to="/register">注册</router-link>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data:function(){
        return{
            phone:'',   //手机号码
            phoneMsg:'', //手机号码提示
            phoneCanUse:false,
            pwd:'',
            pwdCanUse:false,
            loginMsg:''
        }
    },
    mounted:function(){
       document.title = "用户登录";
    },
    methods:{
        checkPhone:function(){
            if(this.phone.trim()==''){
                this.phoneCanUse = false;
                return;
            }
            var reg = /^1[34578]\d{9}$/;
            if(reg.test(this.phone)){
                this.phoneCanUse = true;
            }else{
                this.phoneMsg = '手机号码格式不正确';
                this.phoneCanUse = false;
            }
        },
        clearPhoneMsg:function(){
            this.phoneMsg = '';
        },
        checkPwd:function(){
            if(this.pwd.trim==""){
                this.pwdCanUse = false;
                return;
            }else{
                this.pwdCanUse = true;
            }
        },
        login:function(){
            if(this.phoneCanUse&&this.pwdCanUse&&this.pwd.trim()!=''){
                this.$http.post("http://127.0.0.1:3000/login",{phone:this.phone,pwd:this.pwd},{emulateJSON:true,credentials:true})
                    .then(function(res){
                        if(res.data.code==1){
                            this.$router.push('/index');
                        }else{
                            this.loginMsg = '用户名或密码错误';
                        }
                    })
            }else{
                alert('请输入完整信息');
            }
        }
    }
}
</script>

<style scoped>
    div.box{
        background: #f7f1cf !important;
    }

    .header{
        background-color: #f6f6f6;
    }

    .header>div{
        width: 1040px;
        height: 40px;
        line-height: 40px;
        padding: 9px 0;
        margin: 0 auto;
    }

    .header img{
        height: 38px;
    }

    .container{
        background: url(../assets/image/login/bg-login.png) no-repeat;
        width: 1040px;
    }

    .container>div{
        height: 562px;
        margin: 0 auto;
        position: relative;
    }

    .loginBox{
        width: 460px;
        height: 420px;
        overflow: hidden;
        background: #fff;
        position: absolute;
        top: 90px;
        right: 30px;
    }

    .loginBox>p{
        padding: 30px 0;
        text-align: center;
        font-size: 16px;
        color: #555;
    }

    .loginBox>.form{
        width: 360px;
        margin: 10px auto;
    }

    .loginBox>.form>p{
        margin-bottom: 26px;
    }

    .loginBox>.form>p>span{
        display: block;
        height: 20px;
        line-height: 20px;
        margin: 5px 0;
        font-size: 12px;
        color: #E41F19;
    }

    .loginBox>.form input{
        width: 100%;
        outline: 0;
        height: 40px;
        line-height: 40px;
        padding: 0 10px;
        box-sizing: border-box;
    }

    #loginBtn{
        border:0;
        outline: 0;
        background: #5aa700;
        color: #fff;
        cursor: pointer;
    }

    #loginBtn:hover{
        background: #63B700;
    }

    .loginBox>.form .reg{
        text-align: right;
        font-size: 14px;
    }
</style>
