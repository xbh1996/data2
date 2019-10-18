import Vue from 'vue'
import Router from 'vue-router'
import Index from './views/index.vue'
import Details from './views/details.vue'
import Products from './views/products.vue'
import Login from './views/login.vue'
import Reg from './views/reg.vue'
import News from './views/news.vue'
import AboutUs from './views/aboutus.vue'
import Forum from './views/forum.vue'
import Cart from './views/cart.vue'
import NotFound from './views/notfound.vue'
Vue.use(Router)

export default new Router({
  routes: [
    {path:"/",component:Index},
    {path:"/index",component:Index},
    {path:"/details/:pid",component:Details,props:true},
    {path:"/products/:kw",component:Products,props:true},
    {path:"/login",component:Login},
    {path:"/products",component:Products},
    {path:"/reg",component:Reg},
    {path:"/news",component:News},
    {path:"/forum",component:Forum},
    {path:"/cart",component:Cart},
    {path:"/aboutUs",component:AboutUs},
    {path:"/*",component:NotFound}
  ]
})
