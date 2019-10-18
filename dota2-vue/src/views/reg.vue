<template>
    <div>
        <my-header></my-header>
            <!--注册界面-->
        <main class="container-fluid" id="main">
            <section id="reg">
                <div id="regview">
                    <ul class="d-flex flex-column" >
                        <li>
                            <h3 class="text-primary text-left pt-3 float-left pl-4">欢迎阁下</h3>
                            <router-link to="login" title="老玩家登陆"  class="h5 text-danger text-center pt-4 float-right pr-4">王者归来</router-link>
                        </li>
                        <li>
                            <span>用户名:</span><input id="uname" placeholder="请输入您的名号" v-model="uname"  @blur="blur1"  @focus="focus1" class="p-2 mr-3 my-1"/> 
                        </li>
                        <li>
                            <p  id="n1" class="text-light ml-5 ">名号请为3~12位数字、字母或下划线，不能以数字开头</p> 
                            <p  id="n2" class="text-light ml-5 text-danger">用户名格式不正确</p>   
                            <p  id="n3" class=" ml-5 text-danger">用户名已存在</p>   
                            <p  id="n4" class=" ml-5 text-success">用户名可用</p>   
                        </li> 
                        <li>
                            <span>密&nbsp;&nbsp;&nbsp;&nbsp;码:</span><input type="password" id="upwd" v-model="upwd"  @blur="blur1"  @focus="focus1" placeholder="请输入您的密码" class="p-2 mr-3 my-1"/> 
                        </li>
                        <li>
                            <p id="u1" class="text-light ml-5 ">密码长度为6~12位数字、字母</p>  
                            <p id="u2" class=" ml-5 text-danger">密码格式不正确</p>  
                            <p id="u3" class=" ml-5 text-success">密码输入成功</p>  
                        </li>
                        <li>
                            <span>密&nbsp;&nbsp;&nbsp;&nbsp;码:</span><input type="password" id="cpwd"  @blur="blur1"  @focus="focus1" v-model="cpwd" placeholder="请再次输入您的密码" class="p-2 mr-3 my-1"/> 
                        </li>
                        <li>
                            <p id="t1" class="text-light ml-5 ">密码长度为6~12位数字、字母</p> 
                            <p id="t2" class=" ml-5 text-danger">两次密码输入不一致</p>
                            <p id="t3" class=" ml-5 text-success">两次密码输入一致</p>
                        </li>
                        <li>    
                            <span>邮&nbsp;&nbsp;&nbsp;&nbsp;箱:</span><input id="email" placeholder="请输入您的邮箱"  @blur="blur1" v-model="email" class="p-2 mr-3  mb-2"/> 
                        </li>
                        <li>
                            <p id="e1" class=" ml-5 text-danger">邮箱格式不正确</p>
                            <p id="e2" class=" ml-5 text-success">输入成功</p>
                        </li>
                        <li>    
                            <span>电&nbsp;&nbsp;&nbsp;&nbsp;话:</span><input id="phone" placeholder="请输入您的电话"  @blur="blur1" v-model="phone" class="p-2 mr-3 "/>  
                        </li>
                        <li>
                            <p id="p1" class="ml-5 text-danger">手机号格式不正确</p>
                            <p id="p2" class=" ml-5 text-success">输入成功</p>
                        </li>
                        <li class="text-center">
                            <a  class="btn btn-primary  my_w mt-4 ml-5" @click="reg">注&nbsp;&nbsp;&nbsp;册</a>
                        </li>
                    </ul>
                </div>
            </section>
        </main> 
        <my-footer></my-footer>
    </div>
</template>
<script>
import { setTimeout, clearTimeout } from 'timers';
export default {
    data(){
        return {
            uname:"",
            upwd:"",
            cpwd:"",
            email:"",
            phone:""
        }
    },
    methods:{
        focus1(e){
            var inp=e.target;
            if(inp.id=="uname"){
                n1.style.display="block";
            }else if(inp.id=="upwd"){
                u1.style.display="block"
            }else if(inp.id=="cpwd"){
                t1.style.display="block"
            }
        },
        blur1(e){
                var inp=e.target;
                if(inp.id=="uname"){
                    var u=this.uname;
                    var reg=/^[a-z]\w{2,11}$/i;
                    if(!reg.test(u)){
                        this.uname="";
                        uname.focus();
                        n1.style.display="none";
                        n2.style.display="block";
                        setTimeout(()=>{
                           n2.style.display="none";
                            n1.style.display="block";
                        },1000)
                        return;
                    }else{
                        var url="check";
                        var u=this.uname;
                        var obj={params:{uname:u}}
                        n1.style.display="none";
                        this.axios.get(url,obj).then(
                            res=>{
                                if(res.data.code==1){
                                    this.uname="";
                                    uname.focus();
                                    n3.style.display="block";
                                    setTimeout(()=>{
                                        n3.style.display="none";
                                    },2000)
                                    return;
                                }else{
                                    n4.style.display="block";
                                    setTimeout(()=>{
                                        n4.style.display="none";
                                    },2000)
                                }
                            }
                        )
                    }
                    return;
                }else if(inp.id=="upwd"){
                    var p=this.upwd;
                    var reg=/^[0-9a-z]{6,12}$/i;
                    if(!reg.test(p)){
                        this.upwd="";
                        u1.style.display="none";
                        u2.style.display="block";
                        setTimeout(()=>{
                           u2.style.display="none";
                        },1000)
                        return;
                    }else{
                        u1.style.display="none";
                        u3.style.display="block";
                        setTimeout(()=>{
                           u3.style.display="none";
                        },1000)
                    }
                    return;
                }else if(inp.id=="cpwd"){
                    var p=this.upwd;
                    var t=this.cpwd;
                    if(p!=t){
                        this.cpwd="";
                        t1.style.display="none";
                        t2.style.display="block";
                        setTimeout(()=>{
                           t2.style.display="none";
                           t1.style.display="block"
                        },1000)
                        return;
                    }else{
                        t1.style.display="none";
                        t3.style.display="block";
                        setTimeout(()=>{
                           t3.style.display="none";
                        },1000)
                    }
                    return;
                }else if(inp.id=="email"){
                    var e=this.email;
                    var reg=/^[0-9a-z]\w*@\w+\.\w+(\.cn)?$/i
                    if(reg.test(e)){
                        e2.style.display="block";
                        return;
                    }else{
                        e1.style.display="block";
                        setTimeout(()=>{
                            e1.style.display="none";
                        },1000)
                    }
                    return;
                }else if(inp.id=="phone"){
                    var ph=this.phone;
                    var reg=/^1[3-9]\d{9}$/;
                    if(reg.test(ph)){
                        p2.style.display="block";
                        return;
                    }else{
                        p1.style.display="block";
                        setTimeout(()=>{
                            p1.style.display="none";
                        },1000)
                    }
                    return;
                }
            
        },
        reg(){
            var name=this.uname;
            var pwd=this.upwd;
            var cp=this.cpwd;
            var em=this.email;
            var ph=this.phone;
            if(name==""){
                this.$messagebox("消息","用户名不能为空");
                uname.focus();
                return;
            }
            if(pwd==""){
                this.$messagebox("消息","密码不能为空");
                upwd.focus();
                return;
            }
            if(cp==""){
                this.$messagebox("消息","请进行密码验证");
                cpwd.focus();
                return;
            }
            if(em==""){
                this.$messagebox("消息","请输入您的邮箱");
                email.focus();
                return;
            }
            if(ph==""){
                this.$messagebox("消息","请输入您的联系方式");
                phone.focus();
                return;
            }
            var url="reg"
            var obj={params:{uname:name,upwd:pwd,email:em,phone:ph}}
            this.axios.get(url,obj).then(res=>{
                if(res.data.code==-1){
                    this.$messagebox("消息","注册失败,请重试").then(()=>{
                        this.$router.push("Reg");
                        uname.focus(); 
                    })
                }else{
                    this.$messagebox("消息","注册成功").then(this.$router.push("Index") )           
                }
            })
        }
    }
}
</script>
<style  scoped>
    #main{
        width:100%;height:800px;
        background: url('../assets/img/index/bg1.png') no-repeat fixed center center ;
        background-size:100% 1000px;
        position:relative;
    }
    #reg{
        width:25%;height:65%;
        border-radius: 5px;
        position:absolute;
        top:25%;left:50%;
        background-color:rgba(51,51,51,0.7)
    }
    #reg input{
        margin-left:10px;
        margin-top:5px;
    }
    #reg ul{
        list-style-type: none;
    }
    #reg .my_w{
        width:65%
    }
    #reg span{
        color:rgb(164, 8, 184);
        margin-right:2rem
    }
    #n1,#n2,#n3,#n4,#u1,#u2,#u3,#t1,#t2,#t3,#e1,#e2,#p1,#p2{
        display:none
    }
</style>