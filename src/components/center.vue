<template>
   <div>
      <HeaderComponent @isLogin="isLogin"/>
      <div class="container">
         <div>
            <div class="banner">
               <img :src="avtPath">
               <span>{{userMsg?userMsg.name:'user'}}</span>
               <!--小图标noVip、vip-->
               <i :class="userMsg?userMsg.level=='2'?'vip':'noVip':'level'"></i>
            </div>
         </div>
         <div class="control">
            <h3>个人信息</h3>
            <div class="clear msg">
               <div class="lf avatar">
                  <form id="avtUpload">
                     <!--userMsg?require('../assets/'+userMsg.avatar):-->
                     <img :src="avtPath" id="img">
                     <div class="upload">
                        <a href="javascript:;">更换头像</a>
                        <input type="file" class="setAvt" ref="ulBox" @change="proload">
                     </div>
                     <input type="button" v-if="hasImg" @click="upload" value="确定" />
                  </form>
               </div>
               <div class="lf data">
                  <p>昵称：<span>{{userMsg?userMsg.name:'user'}}</span></p>
                  <p>手机号码：<span>{{userMsg?userMsg.phone:''}}</span></p>
                  <p>会员类型：<span>{{userMsg?userMsg.level=='2'?'会员':'非会员':''}}</span></p>
                  <p>UID：<span>{{userMsg?userMsg.uid:''}}</span></p>
               </div>
            </div>
            <h3>修改密码</h3>
            <div class="msg">
               <p>
                  <input type="password" placeholder="原密码" v-model="protoPwd">
               </p>
               <p>
                  <input type="password" placeholder="新密码" v-model="newPwd">
               </p>
               <p>
                  <input type="password" placeholder="确认密码" v-model="rePwd">
               </p>
               <p>
                  <a href="javascript:;" class="submit" @click="toChange">确认修改</a>
               </p>
            </div>
         </div>
      </div>
      <FooterComponent/>
   </div>
</template>

<script>
   import header from '@/components/header';
   import footer from '@/components/footer';
   export default {
      data:function(){
         return{
            uid:null,
            userMsg:null,
            avtPath:'#',
            loginState:false,
            protoPwd:'',
            newPwd:'',
            rePwd:'',
            hasImg:false
         }
      },
      watch:{
         'loginState':['jumpToLogin']
      },
      beforeMount:function(){
         this.$http.get("http://127.0.0.1:3000/isLogin",{credentials:true})
            .then(function(res){
               //console.log(res.data.code);
               if(res.data.code==1){ 
                  this.uid = res.data.data.uid;
                  this.getUserMsg();
               }else{
                  this.$router.push("/login");
               }
            })
      },
      mounted:function(){
         document.title = "修改个人信息";
      },
      methods:{
         isLogin:function(msg){
            this.loginState = msg;
         },
         getUserMsg:function(){
            this.$http.get("http://127.0.0.1:3000/getUserMsg/"+this.uid)
               .then(function(res){
                  this.userMsg = res.data;
                  // console.log(res.data.avatar);
                  if(res.data.avatar.indexOf("http")!==-1){
                     this.avtPath = res.data.avatar;
                  }else{
                     this.avtPath = require('../assets/'+res.data.avatar);
                  }
               })
         },
         jumpToLogin:function(){
            if(!this.loginState){
               this.$router.push("/login");
            }
         },
         toChange:function(){
            if(this.protoPwd.trim()!=''&&this.newPwd.trim()!=''&&this.rePwd.trim()!=''){
               var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
               if(reg.test(this.newPwd)){
                  if(this.newPwd===this.rePwd){
                     this.$http.post("http://127.0.0.1:3000/askOldPwd",{uid:this.uid,pwd:this.protoPwd},{emulateJSON: true})
                     .then(function(res){
                        if(res.data.code==1){
                           //TODO
                           var r = window.confirm("确定要修改为该密码吗？");
                           if(r){
                              this.$http.post("http://127.0.0.1:3000/updatePwd",{uid:this.uid,newPwd:this.newPwd},{emulateJSON:true})
                                 .then(function(res){
                                    if(res.data.code==1){
                                       this.protoPwd='';
                                       this.newPwd='';
                                       this.rePwd='';
                                       alert("修改成功!请牢记您的新密码");
                                    }else{
                                       alert("网络错误");
                                    }
                                 })
                           }
                        }else{
                           alert("原密码错误!");
                        }
                     })
                  }else{
                     alert('两次密码输入不一致');
                  }
               }else{
                  alert("密码不合法");
               }
            }else{
               alert("请填入完整信息");
            }
         },
         //图片预览
         proload:function(){
            var uploadEl = this.$refs.ulBox;
            var uploadImg = uploadEl.files[0];
            if(uploadImg){
               //console.log(uploadImg);
               if(uploadImg.type.indexOf("image")===-1){
                  alert("请选择正确的图片文件");
                  this.hasImg = false;
                  return;
               }
               if(uploadImg.size/1024>=512){
                  alert("图片应小于512kb");
                  this.hasImg = false;
                  return;
               }
               //h5
               this.hasImg = true;
               var reader = new FileReader();
               reader.readAsDataURL(uploadImg);  
               reader.onload = function(e){
                  $("#img").attr("src",e.target.result);
               }
            }
         },
         //头像上传
         upload:function(){
            if(this.hasImg){
               var uploadEl = this.$refs.ulBox;
               var uploadImg = uploadEl.files[0];
               var formData = new FormData();
               formData.append('myfile', uploadImg);
               var _this = this;
               $.ajax({
                  // url: 'http://127.0.0.1/14_HTML5/day06/day06/upload.php',
                  url: 'http://127.0.0.1:3000/upload',
                  type: 'POST',
                  cache: false,
                  data: formData,
                  processData: false,
                  success:function(res){
                     if(res.code==1){
                        var newPath = res.newPath;
                        _this.$http.post("http://127.0.0.1:3000/updateAvt",{uid:_this.uid,path:newPath},{emulateJSON:true})
                           .then(function(res){
                              if(res.data.code==1){
                                 this.getUserMsg();
                              }else{
                                 alert("网络错误");
                              }
                           })
                     }
                  },
                  contentType: false
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
      background: #fff;
      margin: 40px auto;
   }

   .banner{
      width: 280px;
      margin: 0 auto;
   }

   .banner>img{
      width: 100px;
      height: 100px;
      border-radius: 50%;
      border: 5px solid #eee;
      box-shadow: 2px 2px 2px #444;
      box-sizing: border-box;
      margin-right: 15px;
   }

   .banner>span{
      color: #444;
      display: inline-block;
      max-width: 120px;
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
   }

   .banner>i{
      display: inline-block;
      width: 22px;
      height: 18px;
      background: url(../assets/image/header/qyv-rank.png) no-repeat;
   }

   .banner>i.noVip{
      background-position: -210px -65px;
   }

   .banner>i.vip{
      background-position: -210px -40px;
   }

   .control>h3{
      line-height: 60px;
      color: #5ba605;
   }

   .control .avatar img{
      width: 60px;
      height: 60px;
      border: 2px solid #eee;
      box-sizing: border-box;
      border-radius: 50%;
      margin-bottom: 10px;
   }

   .control .avatar>form>input{
      width: 60px;
      height: 24px;
      color: #fff;
      background: #5ba605;
      font-size: 12px;
      border: none;
      text-align: center;
      line-height: 24px;
      margin-top: 5px;
      border-radius: 3px;
      cursor: pointer;
   }

   .control .avatar{
      margin-right: 40px;
   }

   .control .upload{
      width: 60px;
      height: 24px;
      position: relative;
   }

   .control .avatar a{
      position: absolute;
      top: 0;
      left: 0;
      display: block;
      width: 60px;
      height: 24px;
      text-align: center;
      line-height: 24px;
      font-size: 12px;
      background: #ccc;
      border-radius: 2px;
      color: #5ba605;
   }

   .control .avatar .setAvt{
      width: 60px;
      height: 24px;
      position: absolute;
      top: 0;
      left: 0;
      opacity: 0;
      filter: alpha(opacity=0);
      z-index: 10;
   }

   .control>.msg{
      width: 700px;
      margin: 0 auto;
   }

   .control .data{
      font-size: 14px;
      line-height: 26px;
   }
   
   .control .msg>p{
      margin-bottom: 20px;
   }

   .control .msg input{
      width: 280px;
      height: 26px;
      line-height: 26px;
      text-indent: 5px;
   }

   .control .msg a.submit{
      display: inline-block;
      width: 130px;
      height: 34px;
      font-size: 14px;
      text-align: center;
      line-height: 34px;
      border-radius: 2px;
      color: #fff;
      background: #5ba605;
   }
</style>