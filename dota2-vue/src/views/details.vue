<template>
    <div>
        <my-header></my-header>
        <main class="container">
            <img src="../assets/img/index/bg2.jpg" alt="" class="w-100 h-75 mb-2">
            <nav aria-label="breadcrumb">
              <ol class="breadcrumb  bg-transparent m-0">
                <li class="breadcrumb-item">
                    <a class="text-dark font-weight-bold " href="javascript:;">首页</a>
                    </li>
                <li class="breadcrumb-item">
                    <a class="text-dark font-weight-bold " href="javascript:;">饰品市场</a>
                    </li>
                <li class="breadcrumb-item text-dark font-weight-bold  active" v-text="product.pname"></li>
              </ol>
            </nav>
            <div class=" mb-3 py-3"  id="details">
              <div class="row pr-3">
                <div id="preview" class="col-4 pr-0" >
                  <div class="card bg-transparent mr-5 position-absolute" >
                    <img class="card-img-top h-100 img-thumbnail" :src="`http://127.0.0.1:3000/${product.pic}`" alt="Card image cap" id="mImg">
                    <span class="h5 py-3 text-danger">所属英雄:{{this.hero}}</span> 
                    <p class="h5 pb-3">品质:<span class=" my_quo">{{product.qua}}</span> </p> 
                    <h5 class="d-flex justify-content-around">
                      <p>槽位:<span class="text-primary">{{product.slot}}</span></p>
                      <p>类型:<span class="text-primary">{{product.type}}</span> </p>
                    </h5> 
                  </div>
                </div>
                <div id="detail" class="col-8 pl-0 text-center">
                  <h3 id="pname" class="font-weight-bold text-info" v-text="product.pname">
                  </h3>
                  <div class="alert alert-primary " role="alert">
                    <div>
                      <h4>
                        <a class=" text-dark font-weight-bold small" href="javascript:;"  id="p_sub_title">助力Ti9，现在购买八折优惠</a>
                      </h4>
                      <span class="h4 text-dark font-weight-bold ">水友售价：</span>
                      <h2 class="d-inline text-primary font-weight-bold"  id="pprice" v-text="`￥${product.price.toFixed(2)}`"></h2>
                    </div>
                    <div class="py-2 text-dark h6 font-weight-bold">
                      <span>服务承诺：</span>
                      <span> *货真价实  *即买即发  *保证质量 </span>
                    </div>
                  </div>
                  <!-- 客服 -->
                  <div class="d-flex flex-row">
                    <div class=" h4 py-2 px-3">客服：</div>
                    <span class="h5 px-3 py-2">联系客服</span>
                    <img src="../assets/img/index/kefuf.gif" alt="" >
                  </div>
                  
                  <!-- 规格 -->
                  <div class="d-flex flex-row">
                    <div class="h4 py-2 px-3">规格：</div>
                    <div class="w-75">
                      <a class="btn  btn-outline-secondary active" href="javascript:;">LGD加油！CN DOTA, BEST DOTA!</a>
                    </div>
                  </div>
                  <!-- 数量 -->
                  <div class="d-flex flex-row">
                    <div class="h4 py-2 px-3">数量：</div>
                    <div class="input-group mb-3 w-25">
                      <div class="input-group-prepend">
                        <button class="btn btn-outline-secondary py-1 px-3" type="button" @click="add(-1,$event)">-</button>
                      </div>
                      <input  v-model="count" class="form-control w-25 text-center" >
                      <div class="input-group-append">
                        <button class="btn btn-outline-secondary py-1 px-3" type="button" @click="add(+1,$event)">+</button>
                      </div>
                    </div>
                    <div class="clearfix"></div>
                  </div>
                  <!-- 购买部分 -->
                  <div class="d-flex justify-content-around">
                    <a class="btn pt-3 pb-2 px-5 btn-primary" href="javascript:;"><h5>立即购买</h5></a>
                    <a class="btn btn-primary pt-3" href="javascript:;" @click="addcart"  :data-pid="product.pid" :data-pname="product.pname" :data-price="product.price.toFixed(2)" :data-pic="product.pic">
                      <h5><img src="../assets/img/index/foodstore_car_2.png" alt=""> 加入购物车</h5>
                    </a>
                    <a class="btn btn-primary pt-1 pb-1 collection" href="javascript:;" @click="gotocart">
                      <img src="../assets/img/index/product_detail_img6.png">
                      <br>
                      前往购物车
                    </a>
                  </div>
                </div>
              </div>
            </div>
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
            product:{price:0},
            hero:"",
            count:1
        }
    },
    props:["pid"],
    methods:{
        load(){
          
            (async ()=>{//在wx小程序中可省略
              var result=await this.axios.get(
                "/details",
                {
                  params:{
                    pid:this.$route.params.pid
                  }
                }
              );
              this.hero=result.data.data.hero;
              this.product=result.data.data.product;
              console.log(this.product)
              // --#所有饰品 0-普通 1-稀有 2-罕见  4-神话 5-不朽 6-传说 7-至宝  8-远古
              // --#可佩戴 --1   捆绑包--0
              var qua=this.product.qua
              var type=this.product.type
              switch(qua){
                case 0:
                  this.product.qua="普通";
                  break;
                case 1:
                  this.product.qua="稀有";
                  break;
                case 2:
                  this.product.qua="罕见";
                  break;
                case 4:
                  this.product.qua="神话";
                  break;
                case 5:
                  this.product.qua="不朽";
                  break;
                case 6:
                  this.product.qua="传说";
                  break;
                case 7:
                  this.product.qua="至宝";
                  break;
                default:
                  this.product.qua="远古";
              };
              if(type==1){
                this.product.type="可佩戴"
              }else{
                this.product.type="捆绑包"
              }
            })()//wx小程序也可省略
        },
        addcart(e){
          var btn=e.target;
          //获取数据 :data-pid="product.pid" :data-pname="product.pname" :data-price="product.price.toFixed(2)" 
          var pid=this.product.pid;
          var price=this.product.price;
          var pname=this.product.pname;
          var pcount=this.count;
          var pic=this.product.pic;
          //创建url
          var url="addcart";
          var obj={params:{pid,pname,price,pcount,pic}};
          // 发送ajax请求获取响应
          this.axios.get(url,obj).then(res=>{
              if(res.data.code==-1){
                  this.$messagebox("消息","用户尚未登录").then(res=>{
                      location.href="http://127.0.0.1:8080/index.html#/Login"
                  })
              }else if(res.data.code==-2){
                      this.$messagebox("消息","添加失败")
              }else{
                      this.$toast("添加成功");
              }
          })  
        },
        add(i,e){
          if(e.target.nodeName=="BUTTON"){
              var input=e.target.parentNode.parentNode.children[1];
              var n=parseInt(input.value);
              if(n>=1){
                  n+=i;
              }else{
                  n=1;
              }
              input.value=n
            }
        },
        gotocart(){
          location.href="http://127.0.0.1:8080/index.html#/Cart"
        }
    },
    created(){
      this.load();
    }
}
</script>
<style  scoped>
    #details img:hover{
        transform: scale(1.1);
        transition: all .5s linear;
    }
    #details{
      background:#c2c5cc;
    }
    .my_quo{
      color:#ef7c01
    }
</style>