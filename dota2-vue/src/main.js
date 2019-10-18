import Vue from 'vue'
import App from './App.vue'
import router from './router'
// import store from './store'
import 'element-ui/lib/theme-chalk/index.css'
//引入第三方组件库
//1.1 引入所有组件
import MintUI from "mint-ui"
//1.2 单引入mint-ui样式文件
import "mint-ui/lib/style.css"

//1.3将mint-ui 注册vue
Vue.use(MintUI)
//1.4引入图标字体样式文件
//import "./font/iconfont.css"
//2.1引入axios库
import axios from 'axios'
// 2.2配置axios，设置属性发送ajax请求时保存session信息
axios.defaults.withCredentials=true
//2.3设置ajax请求时的基本路径
axios.defaults.baseURL="http://127.0.0.1:3000/"
//2.4注册axios
Vue.prototype.axios=axios
//3.1 引入第三方模块vuex
import Vuex from 'vuex'
//3.2 注册实例
Vue.use(Vuex)
//3.3 创建存储对象
var store=new Vuex.Store({
  state:{//集中管理数据属性
    uname:"",
    islogin:false
  },
  mutations:{//集中 修改数据函数
    login(state,data){//登录
      state.uname=data;
      state.islogin=true;
    },
    signout(state){//注销
      state.uname="";
      state.islogin=false;
    },
    isLogin(state){
      if(!state.islogin){
        state.uname=sessionStorage.getItem('uname');
        state.islogin=sessionStorage.getItem('islogin')
      }
      return state.islogin;
    }
  },
  getters:{//集中 获取数据的函数
    getUser(state){
      var obj={uname:state.uname,islogin:state.islogin}
      return obj
    }
  },
  actions:{//保存函数，异步修改

  }
})
//引入全局变量MyHeader.vue   MyFooter.vue  MyAside.vue
import MyHeader from './components/MyHeader.vue'
import MyFooter from './components/MyFooter.vue'
import MyAside from './components/MyAside.vue'

Vue.component("my-header",MyHeader)
Vue.component("my-footer",MyFooter)
Vue.component("my-aside",MyAside)
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App),
  store//3.4 将存储对象添加到vue实例作为属性
}).$mount('#app')
