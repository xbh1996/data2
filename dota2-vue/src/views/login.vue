<template>
    <div>
        <my-header></my-header>
        <main class="container-fluid" id="main">
        <!--登录界面-->
            <section id="login">
                <div id="loginview">
                    <div class="row p-0 pl-3 mb-3">
                        <h3 class="col-7 text-info text-left pt-3 ">欢迎指挥官</h3>
                        <router-link to="reg" title="新用户注册"  class="col-5 h5 text-danger text-center pt-4 ">英雄降临</router-link>
                    </div>
                    <div class="form-inline text-center">
                        <span class="ml-3 text-light h5">用户名:</span><input v-model="uname" placeholder="请输入您的名号" @focus="focus1" @blur="blur1"  class="form-control col-form-label form-text ml-4 w-50" />
                        <img src="../assets/img/index/yhm.png" alt="" class="ml-4"/>   
                    </div>
                    <p id="unametxt" >用户名必须为3~12位数字、字母或下划线，不能以数字开头</p>
                    <div class="form-inline text-center">
                        <span class="ml-3 text-light h5">密&nbsp;&nbsp;&nbsp;&nbsp;码:</span>
                        <input type="password" v-model="upwd" placeholder="请输入您的密码" @focus="focus2" @blur="blur2" class="form-control col-form-label form-text ml-4 w-50"/>
                        <img src="../assets/img/index/mm.png" alt="" class="ml-4"/>
                    </div>
                    <p id="upwdtxt">密码必须为6-12位数字或字母</p>
                    <div class="txt_position ">
                        <input type="checkbox" class=" float-left ml-4 mt-1" id="zdlogin"/><label for="zdlogin" class="text-light float-left ml-2">自动登录</label>
                        <a href="javascript:;" class="float-right mr-4 text-light">忘记密码?</a>
                    </div>
                    <div class="text-center">
                        <a  class="btn btn-primary  w-75 mt-4" @click="login">登&nbsp;&nbsp;&nbsp;录</a>
                    </div>
                </div>
            </section>
        </main>
        <my-footer></my-footer>
    </div>
</template>
<script>
export default {
    data(){
        return {
            uname:"",
            upwd:""
        }
    },
    methods:{
        focus1(){
            var utxt=document.getElementById("unametxt");
            utxt.style.display="block"
        },
        focus2(){
            var ptxt=document.getElementById("upwdtxt");
            var utxt=document.getElementById("unametxt");
            if(utxt.style.display=="block"){
                utxt.style.display=="none"
            }
            ptxt.style.display="block"
        },
        blur1(){
            var uname=this.uname;
            var utxt=document.getElementById("unametxt");
            var reg=/^[a-z]\w{2,11}$/i
            if(!reg.test(uname)){
                utxt.innerHTML="用户名格式不正确";
                this.uname=""
            }else{
                utxt.innerHTML="用户名输入成功"
            }
        },
        blur2(){
            var upwd=this.upwd;
            var ptxt=document.getElementById("upwdtxt");
            var reg=/^[0-9a-z]{6,12}$/i;
            if(!reg.test(upwd)){
                ptxt.innerHTML="密码格式不正确";
                this.upwd=""
            }else{
                ptxt.innerHTML="密码输入成功"
            }
        },
        login(){
            var ptxt=document.getElementById("upwdtxt");
            var utxt=document.getElementById("unametxt");
            ptxt.style.display="none";
            utxt.style.display="none";
            var uname=this.uname;
            var upwd=this.upwd;
            if(!uname){
                this.$messagebox("消息","用户名不能为空");
                return;
            }
            if(!upwd){
                this.$messagebox("消息","密码不能为空");
                return;
            }
            var url="login";
            var obj={params:{uname,upwd}};
            this.axios.get(url,obj).then(res=>{
                if(res.data.code==-1){
                    this.$toast("用户名或密码错误");
                    this.uname="";
                    this.upwd="";
                }else{
                    this.$toast("登陆成功");
                    this.$store.commit("login",this.uname);
                    sessionStorage.setItem('uname',this.uname);
                    sessionStorage.setItem('islogin',true);
                    this.$router.push("/");
                    
                }
            })
        }
    },
    created(){}
}
</script>
<style  scoped>
    #main{
        width:100%;height:800px;
        background: url('../assets/img/index/bg3.png') no-repeat fixed center center ;
        background-size:100% 1000px;
        position:relative;
    }
    #login{
        width:25%;height:50%;
        border-radius: 5px;
        position:absolute;
        top:25%;left:50%;
        background-color:rgba(51,51,51,0.7)
    }
    #loginview{
        display:flex;
        flex-direction: column
    }
    #loginview .txt_position{
        margin-right:2rem
    }
    #unametxt,#upwdtxt{
        font-size:12px;
        color:#fff;
        margin-bottom:0px;
        padding:10px 5px;
        display:none
    }
</style>