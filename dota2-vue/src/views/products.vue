<template>
    <div>
        <my-header></my-header>
        <main class="container-fluid" id="list">
            <nav>
                <img src="../assets/img/index/bg2.jpg" alt="" class="w-100 h-50 rounded"/>
            </nav>
            <!-- 商品分类检索栏 -->
            <div class="my_list_border" id="heros">
                <div class="row mx-0">
                    <div class="col-md-4 col-sm-6 px-0 my_border" id="strength">
                        <div class="navbar-brand text-center">
                            <p class="my_small text-light h5 font-weight-bold">Strength Heros</p>
                            <div class="row mx-0">
                                <a href="javascript:;" class="col-md-2 col-sm-3 px-1 mb-1" v-for="(hero,i) of sHeros" :key="i" >
                                    <img :src="`http://127.0.0.1:3000/${hero.pic}`" :alt="hero.hname" :title="hero.hname" class="w-100 " >
                                </a> 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 px-0 my_border" id="intel">
                        <div class="navbar-brand text-center">
                            <p class="my_small text-light h5 font-weight-bold">Intelligence Heros</p>
                            <div class="row mx-0">
                                <a href="javascript:;" class="col-md-2 col-sm-3 px-1 mb-1" v-for="(hero,i) of iHeros" :key="i">
                                    <img :src="`http://127.0.0.1:3000/${hero.pic}`" :alt="hero.hname" :title="hero.hname" class="w-100 ">
                                </a> 
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 px-0 my_border" id="agil">
                        <div class="navbar-brand text-center">
                            <p class="my_small text-light h5 font-weight-bold">Agility Heros</p>
                            <div class="row mx-0">
                                <a href="javascript:;" class="col-md-2 col-sm-3 px-1 mb-1" v-for="(hero,i) of aHeros" :key="i">
                                    <img :src="`http://127.0.0.1:3000/${hero.pic}`" :alt="hero.hname" :title="hero.hname" class="w-100 ">
                                </a> 
                            </div>
                        </div>
                    </div>        
                </div>
            </div>
            <section>
                <div class="row mx-0">
                <!--左侧商品列表-->
                <div class="col-md-9 col-sm-12 px-0">
                    <!--标题栏-->
                    <h6 class="bg-dark text-light p-2 pl-4 my_font20 pt-3 pb-3">饰品广场</h6>
                    <div class="row mx-0" @click="addcart">
                        <div class="col-lg-2 col-md-4 col-sm-6 px-0 card" v-for="(pro,i) of products" :key="i">
                            <router-link :to="`details/${pro.pid}`">
                                <img :src="`http://127.0.0.1:3000/${pro.pic}`" :alt="pro.pname" class="my_img_trans img-thumbnail "/>
                            </router-link>
                            <h6 class="text-warning my_font20 mt-3 mb-1  text-center">￥{{pro.price.toFixed(2)}}</h6>
                            <router-link :to="`details/${pro.pid}`" class=" py-2 text-center my_font18">{{pro.pname}}</router-link>
                            <div class="d-flex justify-content-center align-items-center py-2">
                                <button class="text-white font-weight-bold border-0 px-2 py-1 rounded" @click="add(-1,$event)">-</button>
                                <input type="text" value="1" class="w-10 border-0 text-center my_input_outline"/>
                                <button class="text-white font-weight-bold border-0 px-2 py-1 rounded mr-4" @click="add(+1,$event)">+</button>
                                <mt-button class="btn btn-primary text-center pt-2" :data-pid="pro.pid" :data-pname="pro.pname" :data-price="pro.price.toFixed(2)" :data-pic="pro.pic" data-name="cart">加入购物车</mt-button>
                            </div>
                        </div>
                    </div>
                    <!--分页-->
                    <h6 class="mb-3 p-2 text-muted my_small">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination mb-0 justify-content-end">
                                <li class="page-item" :class="{disabled:pno==0}">
                                    <a href="javascript:;" class="page-link bg-transparent" @click="change(-1,$event)">上一页</a>
                                </li>
                                <li class="page-item" v-for="i of pageCount" :key="i" :class="{active:i-1==pno}">
                                    <a href="javascript:;" v-text="i" class="page-link" :class="i-1==pno?'border':'bg-transparent'" @click="changepage(i-1)"></a>
                                </li>
                                <li class="page-item" :class="{disabled:pno==pageCount-1}">
                                    <a href="javascript:;" class="page-link bg-transparent" @click="change(+1,$event)">下一页</a>
                                </li>
                            </ul>
                        </nav>
                    </h6>
                </div>
                <!--右侧公告列表-->
                <div class="col-md-3 col-sm-12 pr-0 ">
                    <h6 class="bg_grey p-2 pl-4 text-muted my_font20 pt-3 mb-0">
                        <img src="img/foodstore_icon2.png" alt=""/>
                        商家公告
                    </h6>
                    <div class="bg-white p-4 my_small text-muted">
                        <p class="mb-1">本店推出全网最低价套餐，保证比其他平台的价格要低！</p>
                        <p class="mb-1">TI9国际邀请赛中国队加油！</p>
                        <p class="mb-1">LGD是不可战胜的！！</p>
                        <p class="mb-1">RUA!!!</p>
                    </div>
                    <!--购物车-->  
                    <div class="list-group mt-4 ">
                        <li class="list-group-item d-flex justify-content-around my_gray p-1 pt-3">
                            <span class="text-muted">购物车</span>
                            <label><input type="checkbox" @change="selectAll">全选</label>
                        </li>
                        <!-- 购物车中商品列表 -->
                        <li class="list-group-item d-flex justify-content-between border-top p-0 align-items-center" v-for="(item,index) of carts" :key="index">
                            <input type="checkbox" v-model="item.ischecked" class="ml-2">
                            <span class="input-group-text bg-white text-truncate border-0 p-0 my_small w-40 d-inline-block" v-text="item.pname"></span>
                            <div class="d-flex flex-row text-center">
                                <button class="border-0 text-white text-center my_input_size " @click="addc(-1,$event)">-</button>
                                <input type="text" v-model="item.count" class="form-control border-0 text-center my_input_size p-0" :data-i="index">
                                <button class="border-0 text-white text-center my_input_size " @click="addc(+1,$event)">+</button>
                            </div>
                            <span class="input-group-text bg-white my_small text-muted p-0 border-0">￥{{item.price}}</span>
                            <h6>￥{{(item.count*item.price).toFixed(2)}}</h6>
                            <mt-button @click="delItem" :data-id="item.id">x</mt-button><!--删除-->
                        </li>
                        <li class="list-group-item d-flex justify-content-around bg-muted p-0 border-top">
                            <mt-button @click="delItems" class="bg-transparent text-info btn pt-2">删除选中商品</mt-button>
                            <mt-button @click="clear" class="bg-transparent text-info btn pt-2">清空购物车</mt-button>
                        </li>
                        <!-- 商品总价及结算 -->
                        <li class="list-group-item d-flex justify-content-between bg-secondary p-0 border-top">
                            <h5 class="text-white mb-0 p-3">
                                <img src="../assets/img/index/foodstore_car_2.png" alt="" class="mr-3">￥{{total.toFixed(2)}}
                            </h5>
                            <a href="javascript:;" class="btn-primary text-white p-3  my_font20 " @click="gotocart">前往购物车结算</a>
                        </li>
                    </div>
                </div>
            </div>
        </section>
        </main>
        <my-aside></my-aside>
        <my-footer></my-footer>
    </div>
</template>
<script>
import { parse } from 'path';
export default {
    data(){
        return {
            sHeros:[],//力量英雄列表
            aHeros:[],//敏捷英雄列表
            iHeros:[],//智力英雄列表
            products:[
                {pid:0,pname:"",price:0,pic:""}
            ],//商品列表
            pno:0,
            pcount:0,
            pageCount:0,
            carts:[
                {price:0}
            ]
        }
    },
    props:["kw"],
    methods:{
        loadPro(pno=0){//组件创建成功后获取所有商品分页显示
            var url="products";
            var obj;
            if(!this.kw){
                obj={params:{pno}};
            }else{
                obj={params:{
                        kw:this.$route.params.kw,
                        pno
                    }}
            }
            this.axios.get(
                url,obj
            ).then(res=>{
                    this.products=res.data.data;
                    this.pno=res.data.pno;
                    this.pageCount=res.data.pageCount;
            })
            this.loadCart()
        },
        //向服务器请求获取英雄信息
        loadHeros(hpro,pno,pcount){
            var url="heros";
            var obj={params:{hpro,pno,pcount}};
            this.axios.get(url,obj).then(res=>{
                if(hpro=="strength"){
                    this.sHeros=res.data.data;
                    return;
                }else if(hpro=="agility"){
                    this.aHeros=res.data.data;
                    return;
                }else if(hpro=="intelligence"){
                    this.iHeros=res.data.data;
                    return;
                }  
            })
        },
        //页数绑定函数
        change(n,e){
            if(e.target.className.indexOf("disabled")==-1){
                this.changepage(parseInt(this.pno)+parseInt(n))
            }
        },
        //点击跳转到第几页
        changepage(i){
            this.loadPro(i)
        },
        //添加到购物车
        addcart(e){
            if(e.target.dataset.name=="cart"){
                var btn=e.target;
                //获取数据
                var pid=btn.dataset.pid;
                var price=btn.dataset.price;
                var pname=btn.dataset.pname;
                var pic=btn.dataset.pic;
                var pcount=parseInt(btn.parentNode.children[1].value)
                //创建url
                var url="addcart";
                var obj={params:{pid,pname,price,pcount,pic}};
                // 发送ajax请求获取响应
                this.axios.get(url,obj).then(res=>{
                    if(res.data.code==-1){
                        this.$messagebox("消息","用户尚未登录").then(res=>{
                            this.$router.push("login")
                        })
                    }else if(res.data.code==-2){
                            this.$messagebox("消息","添加失败")
                    }else{
                            this.$toast("添加成功");
                            this.loadCart();
                    }
                })
            }
        },
        //商品列表按钮加减
        add(i,e){
            if(e.target.nodeName=="BUTTON"){
                var input=e.target.parentNode.children[1];
                var p=input.dataset.i;
                var n=parseInt(input.value);
                if(n>=1){
                    n+=i;
                }else{
                    n=1;
                }
                input.value=n;
            }
        },
        //获取当前购物车列表
        loadCart(){
            var url="carts";
            this.axios.get(url).then(res=>{
                if(res.data.code==-1){
                    this.$messagebox("消息","用户尚未登录").then(this.$router.push("login"))
                }else{//获取服务器返回数据，添加一个新属性ischecked，用于判定当前项是否被选中
                    var rows=res.data.data;
                    for(var item of rows){
                        item.ischecked=false;
                    }
                    this.carts=rows;//再将新数组赋值给carts
                }
            })
        },
        //为全选按钮绑定事件，全选按钮的选中控制下方所有项的选中与否
        selectAll(e){
            //获取当前按钮状态
            var bool=e.target.checked;
            //创建循环遍历所有商品属性的ischecked，使其与全选按钮相同
            for(var item of this.carts){
                item.ischecked=bool;
            }
        },
        //为用户点击按钮完成删除指定商品任务
        delItem(e){
            this.$messagebox.confirm("是否删除本商品").then(res=>{//确认删除
                var id=e.target.dataset.id;
                var url="delItem";
                var obj={params:{id}};
                this.axios.get(url,obj).then(res=>{
                    if(res.data.code==1){
                        this.$toast("删除成功")
                        this.loadCart();
                    }else{
                        this.$toast("删除失败")
                    }
                })
            }).catch(err=>{})
        },
        //删除用户选中的多个商品
        delItems(){
            this.$messagebox("消息","是否确认删除选中商品").then(res=>{
                var id="";
                for(var item of this.carts){
                    if(item.ischecked){
                        id+=item.id+","
                    }
                }
                id=id.slice(0,-1);
                if(id==""){
                    this.$messagebox("消息","请选择需要删除的商品")
                    return;
                }
                var url="delItems";
                var obj={params:{id}};
                this.axios.get(url,obj).then(res=>{
                    if(res.data.code==1){
                        this.$toast("删除成功！");
                        this.loadCart();
                    }else{
                        this.$toast("删除失败")
                    }
                })
            }).catch(err=>{})
        },
        //清空购物车
        clear(){
            for(var item of this.carts){
                item.ischecked=true;
            }
            this.delItems();
        },
        //购物车商品加减
        //按钮加减
        addc(i,e){
            if(e.target.nodeName=="BUTTON"){
                var input=e.target.parentNode.children[1];
                var p=input.dataset.i;
                var n=parseInt(input.value);
                if(n>=1){
                    n+=i;
                }else{
                    n=1;
                }
                input.value=n;
                this.$set(this.carts[p],'count',n)
            }
        },
        // 前往购物车页面
        gotocart(){
            this.$router.push("Cart")
        }
    },
    created(){
        this.loadPro();
        this.loadHeros("strength",1,24);
        this.loadHeros("agility",1,24);
        this.loadHeros("intelligence",1,24);
    },
    watch:{
        kw(){
            this.loadPro()
        }
    },
    computed:{
        total(){
            return this.carts.filter(item=>item.ischecked).reduce(
            (prev,item)=>
              prev+item.price*item.count    
          ,0)
        }
    }
}
</script>
<style  scoped>
    #list .bg_grey{
    background-image:linear-gradient(to bottom,#f0f0f0,#e0e0e0);
    }
    #list a{
        text-decoration: none;
    }
    #list .my_font20{
    font-size:20px;
    }
    #list .my_img_trans{
    transition:all 1s;
    }
    #list .my_img_trans:hover{
    transform:scale(1.1);
    }
    #list .w-10{width:10%}
    #list .my_input_outline{
    outline:0
    }
    #list .my_font18{
    font-size:18px;
    color:#333;
    }
    #list .my_font18:hover{
    text-decoration: none;
    color:#ef7c01;
    }
    #list .pagination li+li{
    margin-left:0.5rem
    }
    #list .my_list_border{
    border:10px solid #c5c7d3
    }
    #list .my_div{
    width: 15px;
    height: 15px;
    display: inline-block;
    margin-right: 8px;
    }
    #list .my_border{
    background: #333
    }
    #list .hide{
    display:none
    }
    #heros img:hover{
    transform: scale(1.2);
    transition: all .5s linear;
    }
    #list+h6 .page-link{
        border-color:#bbb;
    }
    #list+h6 .page-link:hover{
        border-color:#007bff
    }
    #list+h6 .page-item.disabled{
        opacity:0.5
    }
    #list .my_gray{
        background: linear-gradient(to bottom,#f0f0f0,#e0e0e0);
    }
    #list .w-40{
        width:40%;
    }
    /*轮廓清0*/
    .my_input{outline: 0;width:10%;}
    /*分页条样式*/
    .page-item+.page-item{
        margin-left:0.5rem;
    }
    .page-link{border-radius: 0.5rem !important;}
    .border-top{border-style:dotted !important;}
    /*购物车小按钮宽高*/
    .my_input_size{
        width:1.2rem;height:1.2rem;
        line-height: 0.6rem;text-align: center;
        font-size:1.2rem;font-weight: normal;
    }
    #list .my_small{
        font-size: 0.8rem;
    }
</style>