<template>
    <div>
        <my-header></my-header>
        <main class="carts">
            <div class="selectall "><!-- 1、顶部复选框：全选-->
                <h4>我的购物车</h4>
                <label><input type="checkbox" @change="selectAll" id="chball">全选</label>
            </div>
            <!--/2、商品信息 -->
            <div class="cart-item" v-for="(item,i) of carts" :key="i">
                <div class="cart-txt">
                    <input type="checkbox" v-model="item.cb" @change="chbone">
                    <div class="mx-3"> 
                        <img :src="`http://127.0.0.1:3000/${item.pic}`" alt="" class="my-img">
                    </div>
                    <div v-text="item.pname" class="lname h5"></div>
                    <div v-text="`￥${item.price}`" class="lprice text-info"></div>
                    <div>
                        <mt-button @click="add(-1,$event)" class="my_btn ml-3">-</mt-button>
                        <input type="text" v-model="item.count" class="lcount  text-center h6" :data-i="i">
                        <mt-button @click="add(+1,$event)" class="my_btn mr-5">+</mt-button>
                    </div>
                    <p>小计：<span class="text-danger h6 ml-5">{{(item.count*item.price).toFixed(2)}}</span></p>
                </div>
                <mt-button @click="delItem" :data-id="item.id">删除</mt-button>
            </div>
            <!--/3、购物车中商品数量，删除选中商品，清空购物车 -->
            <div class="cart-bottom">
                <mt-button @click="delItems">删除选中商品</mt-button>
                <mt-button @click="clear">清空购物车</mt-button>
                <p>购物车中商品总价 <span style="color:red">￥{{total.toFixed(2)}}</span></p> 
            </div>
            <div class="cart-bottom">
                <mt-button @click="goto">继续购物</mt-button>
                <mt-button @click="pay">付款</mt-button>
            </div>
        </main>
        <my-aside></my-aside>
        <my-footer></my-footer>
    </div>
</template>
<script>
export default {
    data(){
        return {
            carts:[
                {price:0}
            ]
        }
    },
    methods:{
        load(){
            var url="carts";
            this.axios.get(url).then(res=>{
                if(res.data.code==-1){
                    this.$messagebox("消息","用户尚未登录")
                        .then(
                            this.$router.push("login")
                        );
                }else{//获取服务器返回数据，添加一个新属性cb，用于判定当前项是否被选中
                    var rows=res.data.data
                    for(var item of rows){
                        item.cb=false;
                    }
                    this.carts=rows;//再将新数组赋值给carts
                }
            })
        },
        selectAll(e){
            //获取当前按钮状态
            var bool=e.target.checked;
            //创建循环遍历所有商品属性的cb，使其与全选按钮相同
            for(var item of this.carts){
                item.cb=bool;
            }
        },
        chbone(e){
            var chball=document.getElementById("chball");
            var btn=e.target;
            var bool=e.target.cb;
            if(!bool){
                chball.checked=false;
            }else{
                if(document.querySelectorAll(".carts [type=checkbox]:not(:checked)").length==0){
                    chball.checked=true
                }
            }
        },
        add(i,e){
            var btn=e.target;
            var input=btn.parentNode.children[1];
            var p=input.dataset.i;
            var n=parseInt(input.value);
            if(n>=1){
                n+=i
            }else{
                n=1;
            };
            input.value=n;
            this.$set(this.carts[p],'count',n)
        },
        delItem(e){
            var btn=e.target;
            this.$messagebox.confirm("是否删除本商品").then(res=>{//确认删除
                var id=e.target.dataset.id;
                var url="delItem";
                var obj={params:{id}};
                this.axios.get(url,obj).then(res=>{
                    if(res.data.code==1){
                        this.$toast("删除成功")
                        this.load();
                        return;
                    }else{
                        this.$toast("删除失败")
                    }
                })
            }).catch(err=>{})
        },
        delItems(e){
            this.$messagebox.confirm("是否删除选中商品").then(res=>{
                var id="";
                for(var item of this.carts){
                    if(item.cb){
                        id+=item.id+","
                    }
                }
                var id=id.slice(0,-1);
                if(id==""){
                    this.$messagebox("消息","请选择要删除的商品");
                    return;
                }
                var url="delItems";
                var obj={params:{id}};
                this.axios.get(url,obj).then(res=>{
                    if(res.data.code==1){
                        this.$toast("删除成功！");
                        this.load();
                    }else{
                        this.$toast("删除失败")
                    }
                })
            }).catch(err=>{})
        },
        clear(){
            for(var item of this.carts){
                item.cb=true;
            }
            this.delItems();
        },
        goto(){
            this.$router.push("product")
        },
        pay(){}
    },
    created(){
        this.load();
    },
    computed:{
        total(){
            return this.carts.filter(item=>item.cb).reduce(
            (prev,item)=>
              prev+item.price*item.count    
          ,0)
        }
    }
}
</script>
<style scoped>
/* 1、商品项目元素 */
    .cart-item{
        display:flex;/*弹性 */
        justify-content: space-around;/* 两端对齐*/
        align-items: center;/*垂直居中 */
        border-bottom: 1px solid #ccc;/*底部边框 */
        margin-top:25px;/*上外边距 */
        padding-bottom:25px;/*下内边距*/
        font-size:18px;
    }
    /*每行商品左侧布局*/
    .cart-txt{
        display:flex;/*子元素水平对齐 */
        align-items: center;/*垂直居中 */
    }
    /*左侧内部布局*/
    .lname,.lprice,.lcount{
        margin-left:25px;
        margin-right:25px
    }
    .lcount{
        text-align: center;
        width:50px;height:30px;
        border:0
    }
    /*全选框*/
    .selectall{
        font-size:24px;
        margin:15px;
        display:flex;
        justify-content: space-between;
        padding:0 175px
    }
    /*底部布局*/
    .cart-bottom{
        display:flex;
        justify-content:space-around;
        margin-top:25px;
        font-size: 24px
    }
    .my-img{
        width:5rem;height:5rem;
    }
    .my_btn{
        text-align: center;
        border:1px solid #000;
        height:30px;
        line-height: 30px;

    }
</style>