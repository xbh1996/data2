<template>
    <div id="banner"  :style="{width:innerWidth+'px'}" @mouseenter="stop" @mouseleave="start">
        <div id="btn-left" @click="move(-1)"></div>
        <!-- 1、轮播图片 -->
        <ul id="ul-imgs"  :class="ulClass" :style="ulStyle">
            <li v-for="(img,i) of imgs" :key="i"  :style="{width:innerWidth+'px'}">
                <a :href="img.url" :title="img.title">
                    <img :src="`http://127.0.0.1:3000/${img.pic}`" :style="{width:innerWidth+'px'}" alt="">
                </a>
            </li>
            <li  :style="{width:innerWidth+'px'}">
                <a :href="imgs[0].url" :title="imgs[0].title">
                    <img :src="`http://127.0.0.1:3000/${imgs[0].pic}`" :style="{width:innerWidth+'px'}" alt="">
                </a>
            </li>
        </ul>
        <!-- 3、轮播指示器 -->
        <ul id="ul-idxs">
            <li v-for="(img,index) of imgs" :key="index" :class="index==i?'active':''" @click="moveTo(index)"></li>
        </ul>
        <!-- 2、左右箭头 -->
        <div id="btn-right" @click="move(1)"></div>
    </div>
</template>
<script>
import { clearInterval, setInterval, setTimeout } from 'timers';
export default {
    data(){
        return {
            innerWidth:window.innerWidth,
            ulClass:{ hasTrans:true },
            i:0,
            imgs:[
                {pic:"",url:"",title:""}
            ],
            canClick:true,
            timer:null
        }
    },
    methods:{
        load(){
            var url="getbanners";
            this.axios.get(url).then(res=>{
                this.imgs=res.data.data
            })
        },
        stop(){
            clearInterval(this.timer)
        },
        start(){
            this.timer=setInterval(()=>{
                this.move(1)
            },3000)
        },
        move(i){
            if(this.canClick){
                this.canClick=false;
                if(i==-1&&this.i==0){
                    this.ulClass.hasTrans=false;
                    setTimeout(()=>{
                        this.i=this.imgs.length;
                        setTimeout(()=>{
                            this.ulClass.hasTrans=true;
                            this.i+=i;
                            setTimeout(()=>{
                                this.canClick=true;
                            },600)
                        },50)
                    },50)
                }else if(i==1&&this.i==this.imgs.length-1){
                    this.i+=i;
                    setTimeout(()=>{
                        this.ulClass.hasTrans=false;
                        setTimeout(()=>{
                            this.i=0;
                            setTimeout(()=>{
                                this.ulClass.hasTrans=true;
                                setTimeout(()=>{
                                    this.canClick=true
                                },600)
                            },50)
                        },50)
                    },600)
                }else{
                    this.i+=i;
                    setTimeout(()=>{
                        this.canClick=true
                    },600)
                }
            }
        },
        moveTo(i){
            if(this.canClick){
                this.i=i;
                this.canClick=false;
                setTimeout(()=>{
                    this.canClick=true;
                },300)
            }
        }
    },
    created(){
        this.load();
        window.addEventListener("resize",()=>{
            this.innerWidth=window.innerWidth;
        })
        this.start();
    },
    computed:{
        ulStyle(){
            var width=this.innerWidth*(this.imgs.length+1)+"px";
            var marginLeft=-this.i*this.innerWidth+"px";
            return {width,marginLeft}
        }
    }
}
</script>
<style  scoped>
   #banner{
        margin:0 auto;
        overflow: hidden;
        position:relative;
    }
    #ul-imgs{
        margin-left:0px;
        list-style:none;
        /* display: flex;
        flex-direction: row; */
    }
    #ul-imgs.hasTrans{
     transition:all .5s linear;
   }
    #ul-imgs li{
        float:left;
    } 
   
    #ul-idxs{
        margin:0 auto;
        list-style:none;
        position: absolute;
        bottom:35px;
        left:50%;
        margin-left:-50px;
    }
    #ul-idxs>li{
        float:left;
        width:10px;height:10px;
        background:#fff;
        border-radius:50%;
        margin:0 5px;
        cursor:pointer;
    }
    #ul-idxs>li.active{
        background: blue;
    }
    #btn-left,#btn-right{
        width:50px;height:100%;
        position: absolute;
        top:0;
        background-repeat: no-repeat;
        background-position: center;
        cursor: pointer;
    }
    #btn-left{
        left:20px;
        background-image: url("../assets/img/carousel/left_ar.png");
    }
    #btn-right{
        right:20px;
        background-image: url("../assets/img/carousel/right_ar.png");
    }
    #btn-left:hover,#btn-right:hover{
        background-size:30px 50px
    } 
</style>