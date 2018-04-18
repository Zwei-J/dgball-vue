<template>
    <div>
        <div class="header">
            <div>
                <div>
                    <router-link to="/index">
                        <img src="../assets/image/header/logo.png" alt="logo">
                    </router-link>
                </div>
            </div>
        </div>
        <div class="container">
            <div>
                <div class="regBox">
                    <p>用户注册</p>
                    <div class="form">
                        <p>
                            <input type="text" placeholder="请输入您的手机号" v-model="phone" @focus="clearPhoneMsg" @blur="checkPhone">
                            <span class="phoneRes">{{phoneMsg}}</span>
                        </p>
                        <p>
                            <input type="text" placeholder="昵称(16个字符以内 不可更改)" maxlength="16" @focus="clearNameMsg" v-model="uName" @blur="checkUname">
                            <span class="nameRes">{{uNameMsg}}</span>
                        </p>
                        <p>
                            <input type="password" placeholder="设置密码(6-16位 包含字母和数字)" @focus="clearPwdMsg" @blur="checkPwd" v-model="pwd">
                            <span class="pwdRes">{{pwdMsg}}</span>
                        </p>
                        <p>
                            <input type="password" placeholder="确认密码" @focus="clearSamePwdMsg" @blur="checkPwdSame" v-model="pwdSame">
                            <span class="rPwdRes">{{samePwdMsg}}</span>
                        </p>
                        <span>
                            <input id="isChecked" v-model="userAgree" type="checkbox">
                            <label for="isChecked">同意本站用户协议</label>
                        </span>
                        <p>
                            <input type="button" id="register" value="注 册" @click="reg">
                        </p>
                        <div class="login">
                            <p>已有账号？去 <router-link to="/login">登录</router-link></p>
                        </div>
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
            phone:'',
            phoneMsg:'',
            uName:'',
            uNameMsg:'',
            pwd:'',
            pwdMsg:'',
            phoneCanUse:false,
            nameCanUse:false,
            pwdCanUse:false,
            pwdSame:'',
            samePwdMsg:'',
            userAgree:false
        }
    },
    beforeCreate: function(){
        document.body.className = "regBody";
    },
    mounted:function(){
       document.title = "用户注册";
    },
    beforeDestroy:function(){
        document.body.removeAttribute("class","regBody");
    },
    methods:{
        //检测手机号
        checkPhone:function(){
            var reg = /^1[34578]\d{9}$/;
            if(reg.test(this.phone)){
                this.$http.get("http://127.0.0.1:3000/reg/checkPhone/"+this.phone)
                    .then(function(res){
                        if(res.data.code==-1){
                            this.phoneMsg = '该手机号码已被注册';
                            this.phoneCanUse = false;
                        }else if(res.data.code==1){
                            this.phoneCanUse = true;
                        }
                    })
            }else{
                this.phoneMsg = '手机号码不合法';
                this.phoneCanUse = false;
            }
        },
        //清空手机号码消息提示
        clearPhoneMsg:function(){
            this.phoneMsg = '';
        },
        //检测用户名
        checkUname:function(){
            var uName = this.uName.trim();
            if(uName==''){
                this.uNameMsg = '请输入用户名';
                this.nameCanUse = false;
                return;
            }else{
                this.$http.get("http://127.0.0.1:3000/reg/checkUserName/"+uName)
                    .then(function(res){
                        if(res.data.code==-1){
                            this.uNameMsg = '该用户名已被注册';
                            this.nameCanUse = false;
                        }else if(res.data.code==1){
                            this.nameCanUse = true;
                        }
                    })  
            }
        },
        //清空用户名消息提示
        clearNameMsg:function(){
            this.uNameMsg = '';
        },
        //检查密码
        checkPwd:function(){
            var pwd = this.pwd;
            if(pwd==''){
                this.pwdMsg = '请输入密码';
                this.pwdCanUse = false;
            }else{
                var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
                if(!reg.test(pwd)){
                    this.pwdMsg = '密码强度太弱';
                    this.pwdCanUse = false;
                }
            }
        },
        //清空密码消息提示
        clearPwdMsg:function(){
            this.pwdMsg = '';
        },
        checkPwdSame:function(){
            if(this.pwdSame==this.pwd){
                this.pwdCanUse = true;
            }else{
                this.samePwdMsg = '两次密码不一致';
                this.pwdCanUse = false;
            }
        },
        clearSamePwdMsg:function(){
            this.samePwdMsg = '';
        },
        reg:function(){
            if(this.phoneCanUse&this.nameCanUse&this.pwdCanUse&this.userAgree){
                var phone = this.phone;
                var uName = this.uName;
                var pwd = this.pwd;
                                                                                            //追加头部
                this.$http.post('http://127.0.0.1:3000/reg',{phone:phone,uName:uName,pwd:pwd},{emulateJSON: true})
                    .then(function(res){
                        if(res.data.code == 1){
                            this.$router.push('/login');
                        }else{
                            alert("网络错误,请重试");
                        }
                    })
            }
        }
    }
}
</script>


<style scoped>
    .header{
        background-color: #fff;
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

    .container .regBox{
        width: 460px;
        height: 420px;
        background: #fff;
        margin: 40px auto 0;
        padding: 10px 0;
        box-shadow: 1px 2px 2px 2px  #ccc;
    }

    .regBox>p{
        padding: 13px 0;
        text-align: center;
        font-size: 16px;
        color: #555;
    }

    .regBox>.form{
        width: 360px;
        margin: 0 auto;
    }

    .regBox>.form>span{
        font-size: 12px;
        color: #444;
        margin-bottom: 5px;
    }

    .regBox>.form>span>input{
        margin: 0;
    }

    .regBox>.form>span>label{
        position: relative;
        top: -3px;
    }

    .regBox>.form p>input{
        width: 100%;
        outline: 0;
        height: 40px;
        padding: 0 10px;
        box-sizing: border-box;
    }

    .regBox>.form p>span{
        display: block;
        height: 20px;
        line-height: 20px;
        margin: 5px 0;
        font-size: 12px;
        color: #E41F19;
    }

    .regBox>.form div.login{
        text-align: right;
    }

    #register{
        border:0;
        outline: 0;
        background: #5aa700;
        color: #fff;
        cursor: pointer;
        border-radius: 3px;
        margin-top: 5px;
    }

    #register:hover{
        background: #63B700;
    }

    .regBox>.form .login{
        font-size: 12px;
        color: #555;
        margin-top: 5px;
    }
</style>
