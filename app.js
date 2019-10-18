//使用express构建web服务器 
//将第三方模块引入到当前程序中
const express = require("express");
const bodyParser = require("body-parser");
const session=require("express-session");
//const index=require("./routes/index");
// const user=require("./routes/user");
// const details=require("./routes/details");
const cors=require("cors");
const mysql = require("mysql");
//3:创建数据库连接池
var pool=mysql.createPool({
  host:"127.0.0.1",
  port:3306,
  user:"root",
  password:"",
  database:"dota2",
  connectionLimit:20
});
var app = express();
app.listen(3000);
//添加cors中间件函数
//所有请求进入app.js时，先要经过cors函数
//统一为每个请求先修改响应头
app.use(cors({
  origin:["http://127.0.0.1:8080","http://localhost:8080"],//不能用*
  credentials:true
}));//从此所有响应，自动带Access-Control-Allow-Origin:http://127.0.0.1:3000
//万一客户端浏览器地址发生变化，只改这里origin一处即可！
//使用body-parser中间件
app.use(bodyParser.urlencoded({extended:false}));
//配置session
app.use(session({
  secret:"128位字符串",
  resave:true,
  saveUninitialized:true
}))
//托管静态资源到public目录下
app.use(express.static("public"));
/*使用路由器来管理路由*/
//app.use("/index",index);
// app.use("/user",user);
// app.use("/details",details);
//功能一、用户登录接口
app.get("/login",(req,res)=>{
  var u = req.query.uname;
  var p = req.query.upwd;
  var sql="select uid from dota2_user where uname = ? and upwd = ? "
  pool.query(sql,[u,p],(err,result)=>{
      if(err) throw err;
      if(result.length==0){
          res.send({code:-1,msg:"用户名或密码错误"})
      }else{
          var uid=result[0].uid;
          req.session.uid=uid;
          res.send({code:1,msg:"登陆成功",data:uid})
      }
  })
})
//功能二、验证注册用户名是否重复
app.get("/check",(req,res)=>{
  var u=req.query.uname;
  var sql="select uid from dota2_user where uname = ?"
  pool.query(sql,[u],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"用户名已存在"})
    }else{
      res.send({code:-1,msg:"用户名不存在"})
    }
  })
})
//功能三、用户注册
app.get("/reg",(req,res)=>{
  var obj=req.query;
  var sql="insert into dota2_user set ?"
  pool.query(sql,[obj],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:"注册成功"})
    }else{
      res.send({code:-1,msg:"注册失败"})
    }
  })
})
//功能四、请求获取轮播图
app.get("/getbanners",(req,res)=>{
  var sql="select rid,pic,url,title from dota2_rot_pic"
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    res.send({code:1,msg:"查询成功",data:result})
  })
})
//功能五、请求首页最新上架商品信息
app.get("/newpro",(req,res)=>{
    var sql=`select pid,img,pname,price from dota2_new_product`;
    pool.query(sql,(err,result)=>{
      if(err)throw err;
      if(result.length>0){
        res.send({code:1,msg:"查询成功",data:result});
      }else{
        res.send({code:-1,msg:"查询失败"});
      }
    })
})
//功能六、请求首页热销商品信息
app.get("/hotpro",(req,res)=>{
  var sql=`select pid,img,pname,price,number from dota2_hot_product`;
  pool.query(sql,(err,result)=>{
    if(err)throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",data:result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  })
})
//功能七、请求商品列表、分页查询、模糊查询
app.get("/products",(req,res)=>{
  var output={
    count:0,
    pageSize:24,
    pageCount:0,
    pno:req.query.pno||0,
    data:[]
  };
  function query(sql,params){
    return new Promise(function(open,err){
      pool.query(sql,params,(error,result)=>{
        if(error) err(error);
        else open(result); 
      })
    })
  }
  var kw=req.query.kw;
  if(!kw){
    var sql=`select pid,pname,price,pic from dota2_product`
    query(sql,[]).then(result=>{
      output.count=result.length;
      output.pageCount=
        Math.ceil(output.count/output.pageSize);
        sql+=` limit ?,?`;
        return query(sql,[output.pageSize*output.pno,output.pageSize]);
    }).then(result=>{
      output.data=result;
      res.send(output);
    }).catch(err=>{throw err})
  }else{
      var kws=kw.split(" ");
      kws.forEach((elem,i,arr)=>{
        arr[i]=` pname like '%${elem}%'`;
      })
      //join(" and ");
      var where=kws.join(" and ");
      var sql=`select pid,pname,price,pic from dota2_product where ${where}`;
      query(sql,[])
      .then(result=>{
        output.count=result.length;
        output.pageCount=
          Math.ceil(output.count/output.pageSize);
        sql+=` limit ?,?`;
        return query(sql,[output.pageSize*output.pno,output.pageSize]);
      })
      .then(result=>{
        output.data=result;
        res.send(output);
      }).catch(err=>{throw err})    
  }  
})
//功能八、请求数据库中所有英雄列表
app.get("/heros",(req,res)=>{
  var hpro=req.query.hpro;
  var pno=req.query.pno;
  var ps=req.query.pcount;
  pno=parseInt(pno);
  ps=parseInt(ps);
  var pstart=(pno-1)*ps;
  var sql="select hid,hname,pic from dota2_heros where hpro=? limit ?,?";
  pool.query(sql,[hpro,pstart,ps],(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",data:result})
    }else{
      res.send({code:-1,msg:"查询失败"})
    }
  })
})
//功能九、将商品添加至购物车
app.get("/addcart",(req,res)=>{
  var uid=req.session.uid;
  if(!uid){
    res.send({code:-1,msg:"请登录"});
    return;
  }
  var pid=req.query.pid;
  var price=req.query.price;
  var pname=req.query.pname;
  var count=req.query.pcount;
  var pic=req.query.pic;
  //创建查询sql语句，当前用户是否购买过此商品
  var sql="select id from dota2_cart where uid=? and pid=?";
  pool.query(sql,[uid,pid],(err,result)=>{
    if(err) throw err;
    if(result.length==0){//如果没购买过，添加到购物车
      var sql=`insert into dota2_cart values(null,${pid},${price},'${pname}',${count},${uid},'${pic}')`
    }else{//如果已经购买过，则更新当前购物车中商品的数量
      var sql=`update dota2_cart set count=count where uid=${uid} and pid=${pid}`
    }
    pool.query(sql,(err,result)=>{
      if(err) throw err;
      if(result.affectedRows>0){
        res.send({code:1,msg:"商品添加成功"})
      }else{
        res.send({msg:-2,msg:"添加失败"})
      }
    })
  })
})
//功能十、查询指定用户购物车信息
app.get("/carts",(req,res)=>{
  var uid=req.session.uid;
  if(!uid){
    res.send({code:-2,msg:"请登录"});
    return;
  }
  var sql="select id,pid,pname,price,count,pic from dota2_cart where uid=?"
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    res.send({code:1,msg:"查询成功",data:result});
  })
})
//功能十一、购物车中删除按钮
app.get("/delItem",(req,res)=>{
  var id=req.query.id;
  var sql="delete from dota2_cart where id=?"
  pool.query(sql,[id],(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:"删除成功"})
    }else{
      res.send({code:1,msg:"删除失败"})
    }
  })
})
//功能十二、删除购物车中多个商品
app.get("/delItems",(req,res)=>{
  var id=req.query.id;
  var sql=`delete from dota2_cart where id in (${id})`;
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.affectedRows>0){
      res.send({code:1,msg:"删除成功"});
    }else{
      res.send({code:1,msg:"删除失败"});
    }
  })
})
//功能十三/获取商品详情
app.get("/details",(req,res)=>{
  var pid=req.query.pid;
  var output={
    product:{},
    hero:""
  }
  var sql1="select pid,hid,pic,pname,qua,slot,type,price from dota2_product where pid=?"
    pool.query(sql1,[pid],(err,result)=>{
      if(err) throw err;
      if(result.length==0){
        res.send({code:-1,msg:"查询失败"})
      }else{
        output.product=result[0];
        var sql2=`select hname from dota2_heros where hid=${result[0].hid}`
        pool.query(sql2,(err,result)=>{
          if(err) throw err;
          output.hero=result[0].hname;
          res.send({code:1,msg:"查询成功",data:output})
        })
      }
    })
})
