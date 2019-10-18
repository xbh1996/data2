<template>
    <div>
        <my-header></my-header>
        <carousel></carousel>
        <main id="main" class="container-fluid">
            <!-- 页面主题 -->
            <section>
                <div class="row mx-0">
                    <!-- 主体商品界面 -->
                    <div class="col-lg-9 col-sm-12 px-0" id="product">
                        <!-- 最新上架 -->
                        <div class="d-flex justify-content-between bg_grey border-bottom border-primary pt-3 rounded">
                            <button class="btn my_new_btn btn-lg ">最新上架</button>
                            <router-link to="details" class="text-muted p-2">进入市场</router-link>
                        </div>
                        <!-- 商品列表 -->
                        <div class="row mx-0">
                            <div class="col-lg-3 col-md-6 col-sm-12  px-0 " v-for="(item,index) of newpros" :key="index">
                                <div class="bg-white my-3 text-center mr-lg-1">
                                    <router-link :to="`details/${item.pid}`">
                                        <img :src="`http://127.0.0.1:3000/${item.img}`" :alt="item.pname" :title="item.pname" class="w-100 my_img_tran p-1 img-thumbnail"/>
                                        <!-- <router-link :to="`http:127.0.0.1:3000/${item.img}`" tag="img"></router-link> -->
                                    </router-link>
                                    <router-link :to="`details/${item.pid}`" class="my_a py-3 d-block border-bottom" v-text="item.pname"></router-link>
                                    <div class="d-flex justify-content-around">
                                        <p class="price mt-2">¥{{item.price.toFixed(2)}}</p>
                                        <router-link :to="`details/${item.pid}`" class="btn btn-primary mb-2 mt-1">了解详情</router-link>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--热销商品-->
                        <!--热销商品文字行  -->
                        <div class="d-flex justify-content-between bg_grey border-bottom border-primary pt-3 rounded">
                            <button class="btn my_hot_btn btn-lg ">热销饰品</button>
                            <router-link to="details" class="text-muted p-2">进入市场</router-link>
                        </div>
                        <!--商品列表-->
                        <div class="row mx-0">
                            <div class="col-lg-3 col-md-6 col-sm-12   px-0 " v-for="(item,index) of hotpros" :key="index">
                                <div class="bg-white my-3 text-center mr-1">
                                    <router-link :to="`details/${item.pid}`">
                                        <img :src="`http://127.0.0.1:3000/${item.img}`" :alt="item.pname" :title="item.pname" class="w-100 my_img_tran p-1 img-thumbnail"/>
                                    </router-link>
                                    <router-link :to="`details/${item.pid}`" class="my_a py-3 d-block border-bottom" v-text="item.pname"></router-link>
                                    <div class="d-flex justify-content-around pt-3">
                                        <p class="price ">￥{{item.price.toFixed(2)}}</p>
                                        <span>交易量:</span>
                                        <input type="text" :value="item.number" class="border-0 text-center pb-3 input_num"/>
                                        <span>件</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--团购优惠-->
                        <!--团购优惠文字行-->
                        <div class="d-flex justify-content-between bg_grey border-bottom border-primary pt-3 rounded">
                            <button class="btn my_gro_btn btn-lg ">团购优惠</button>
                            <router-link to="details" class="text-muted p-2">进入市场</router-link>
                        </div>
                        <!--优惠列表-->
                        <img src="../assets/img/index/shouqing.png" alt="" class="w-100"/>
                    </div>
                    <!--商品主页侧边栏-->
                    <div class="col-lg-3 col-sm-12 pr-0" >
                        <div id="msg">
                            <!--标题栏-->
                            <div class="d-flex justify-content-between bg_grey border-bottom border-primary pt-3 rounded">
                                <button class="btn btn-primary btn-lg ">电竞资讯</button>
                                <!-- <router-link :to="news" class="text-dark p-2">了解更多</router-link> -->
                            </div>
                            <!--信息框-->
                            <ul class="list-group">
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="https://www.dota2.com.cn/article/details/20190721/206101.html" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="典藏宝瓶Ⅱ+祈求者身心——TI9总奖金突破3000万美元的秘密">
                                        典藏宝瓶Ⅱ+祈求者身心——TI9总奖金突破3000万美元的秘密
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="https://www.dota2.com.cn/article/details/20190727/206431.html" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="TI冠军+明星解说430、Faith_bian、Dove、AA亮相Chinajoy DOTA2展台">
                                        TI冠军+明星解说430、Faith_bian、Dove、AA亮相Chinajoy DOTA2展台
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="https://www.dota2.com.cn/article/details/20190726/206381.html" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="见证不朽 2019DOTA2国际邀请赛开幕式玩家招募限时开启">
                                        见证不朽 2019DOTA2国际邀请赛开幕式玩家招募限时开启
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="http://baijiahao.baidu.com/s?id=1640201305196699503&wfr=spider&for=pc" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="DOTA2：Pis再次怒喷国服高分“演员”！这次的演员学会了贼喊捉贼">
                                        DOTA2：Pis再次怒喷国服高分“演员”！这次的演员学会了贼喊捉贼
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="http://fight.pcgames.com.cn/750/7500975.html" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="TI9 中国军团再添一员，Newbee获财团支持收购FWD！">
                                        TI9 中国军团再添一员，Newbee获财团支持收购FWD！
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="http://fight.pcgames.com.cn/750/7500913.html" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="TI9原创作品征集大赛内容推荐第六弹：我的青春，都献给了刀塔">
                                        TI9原创作品征集大赛内容推荐第六弹：我的青春，都献给了刀塔
                                    </a>
                                </li>
                                <li class="list-group-item d-flex flex-column  p-2 border-bottom bg-dark">
                                    <a href="http://dota2.uuu9.com/" class="text-light input-group-text text-truncate my_text-decoration d-block border-0 bg-transparent"  target="_blank" title="DOTA2_DOTA2直播_刀塔2比赛视频_游久电竞">
                                        DOTA2_DOTA2直播_刀塔2比赛视频_游久电竞
                                    </a>
                                </li>
                            </ul>
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
import carousel from "../components/Carousel.vue"
export default {
    data(){
        return {
            newpros:[
                {pid:0,img:"",pname:"",price:0}
            ],
            hotpros:[
                {pid:0,img:"",pname:"",price:0,number:0}
            ]
        }
    },
    methods:{
        loadNew(){
            var url="newpro";
            this.axios.get(url).then(res=>{
                if(res.data.code==1){
                    this.newpros=res.data.data
                }else{
                    this.$router.push("/*")
                }
            })
        },
        loadhHot(){
            var url="hotpro";
            this.axios.get(url).then(res=>{
                if(res.data.code==1){
                    this.hotpros=res.data.data
                }else{
                    this.$router.push("/*")
                }
            })
        }
    },
    created(){
        this.loadNew();
        this.loadhHot()
    },
    components:{carousel}
}
</script>
<style  scoped>
    .bg_grey{
        background-image:linear-gradient(to bottom,#f0f0f0,#e0e0e0);
    }
    .my_img_tran{
        -webkit-transition: all 500ms linear;
        -moz-transition: all 500ms linear;
        -ms-transition: all 500ms linear;
        -o-transition: all 500ms linear;
        transition: all 500ms linear;
    }
    .my_img_tran:hover{
        -webkit-transform: scale(1.1);
        -moz-transform: scale(1.1);
        -ms-transform: scale(1.1);
        -o-transform: scale(1.1);
        transform: scale(1.1);
    }
    .my_a{
        color:#6c757d;
    }
    .my_a:hover{
        text-decoration: none;
        color: #ff0000;
    }
    .price{
        font:20px "Microsoft Yahei",arial;
        color:#ef7c01;
    }
    .input_num{
        width:25px !important;
    }
    .my_text-decoration:hover{
        color:#ff00ff;
        text-decoration:none;
    }
    .my_new_btn,.my_gro_btn,.my_hot_btn{
        color:#fefefe;
        background: url("../assets/img/index/new-put-bg.png") no-repeat top center;
        background-size: 100% 100%;
    }
    .my_hot_btn{
        background: url("../assets/img/index/hot-goods-bg.png") no-repeat top center;
    }
    .my_gro_btn{
        background: url("../assets/img/index/hot-group-bg.png") no-repeat top center;
    }
    #msg{

    }
</style>