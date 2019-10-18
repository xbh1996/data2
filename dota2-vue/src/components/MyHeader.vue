<template>
    <div id="header" class="container-fluid mb-4">
        <!-- 页面顶部信息 -->
        <div class="row mt-5 ml-0 ">
            <div class="col-md-3 col-sm-12">
                <a href="index" class="navbar-brand btn pl-5">
                    <img src="../assets/img/header/logo1.png" alt="" class=" ml-md-3 m-sm-0" title="TP"/>
                    <h6 class="m-0 p-0 my_small"><em>刀友圈 Doter World</em></h6>
                </a>
            </div>  
            <div class="col-md-5 col-sm-12 input-group px-5">
                <input type="text" class="form-control p-0 pl-3 outline-o" placeholder="请输入你要搜索的内容" v-model="kw" @keydown.13="search">
                <div class="input-group-append " @click="search">
                    <img class="btn p-0" src="../assets/img/header/search.png">
                </div>
            </div>
            <div class="col-md-4 col-sm-12 mt-2 d-flex pl-5 ">
                <div id="d1" class="pt-3" style="display:block">
                    <router-link :to="{path:'Reg'}" class="text-muted pr-2" title="新兵报到">注册</router-link>
                    |
                    <router-link :to="{path:'Login'}" class="text-muted pl-2" title="王者归来">登录</router-link>
                </div>
                <div id="d2" class="pt-3"  style="display:none">
                    <span class="text-success pr-2">欢迎<span class="my_bigger px-2">{{this.uname}}</span>阁下</span> 
                    |
                    <a href="javascript:;" @click="gotocart" >
                            <img src="../assets/img/header/shop_car1.png" alt="" title="我的购物车" class="px-3"/>
                    </a>
                    |
                    <a href="javascript:;" @click="change" class="text-muted px-2">注销</a>
                </div>
            </div>
        </div>
        <!--导航栏-->
        <ul class="nav nav-justified  rounded p-2 my_justify">
            <li class="nav-item">
                <router-link :to="{path:'index'}" class="nav-link h3">首页</router-link>
            </li>
            <li class="nav-item">
                <router-link :to="{path:'products'}" class="nav-link h3" >曙光酒馆</router-link>
            </li>
            <li class="nav-item">
                <a href="#/forum" class="nav-link h3 ">冰封王座</a>
            </li>
            <li class="nav-item">
                <a href="#/news" class="nav-link h3 ">电竞资讯</a>
            </li>
            <li class="nav-item">
                <a href="#/aboutus" class="nav-link h3 ">关于我们</a>
            </li>
        </ul>
    </div>
</template>
<script>
export default {
   data(){
    return {
      kw:"",//利用双向绑定获得搜索文本框中用户输入的关键词
      uname:"",
      islogin:false
    }
    },
    methods:{
        //点击查询按钮或在文本框上按回车，都可以跳转到/products页面，并把输入的关键词传过去。
        search(){
            // if(this.kw==undefined){
            //     this.$router.push("products");
            //     return
            // }
            this.$router.replace("products/"+this.kw)   
        },
        change(){
            var d1=document.getElementById("d1");
            var d2=document.getElementById("d2");
            d1.style.display="block";
            d2.style.display="none";
            this.$store.commit("signout");
            sessionStorage.removeItem('uname');
            sessionStorage.removeItem('islogin');
        },
        begin(){
            var d1=document.getElementById("d1");
            var d2=document.getElementById("d2");
            if(this.islogin){//已登录
                d1.style.display="none";
                d2.style.display="block";
            }else{
                d1.style.display="block";
                d2.style.display="none";
            }
        },
        gotocart(){
            this.$router.push("cart")
        }
    },
    //如果地址栏中已经有用户输入的关键词参数kw，则自动获取到搜索文本框中保持同步
    created(){
        this.kw=this.$route.params.kw;
        this.$store.commit("isLogin")//改
        var user=this.$store.getters.getUser;
        this.islogin=user.islogin;
        this.uname=user.uname; 
    },
    mounted(){
        this.begin();
    },
    watch:{
        //如果地址栏中已经有用户输入的关键词参数kw，则自动获取到搜索文本框中保持同步
        $route(){
            this.kw=this.$route.params.kw; 
        }
    }
}
</script>
<style  scoped>
    @import url("../assets/css/comm.css");
    input,input:focus{
        outline:none;
    }
    #header{
        width:100%;
    }
    /*定义主导航当前导航项的字体颜色*/
    #header>.nav .nav-link.active,
    #header>.nav .nav-link:hover{
        font-weight:bold;
        background-color:#0aa1ed;
        border-bottom:1px solid #f00;
    }
    #header .breadcrumb-item + .breadcrumb-item::before {
        content: "|";
        align-items: center;
    }
    .my_justify{
        justify-content: center !important;
    }
    a{
        text-decoration: none
    }
    .my_bigger{
        font-size:20px;
        font-weight:600
         
    }
</style>