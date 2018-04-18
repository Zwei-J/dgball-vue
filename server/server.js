const http = require("http");
const express = require("express");
const mysql = require("mysql");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const cors = require("cors");
const formidable = require('formidable');
const fs = require("fs");
//引入连接池
const pool = require("./pool");

//创建连接池 这里会阻塞
// var pool = mysql.createPool({
//    host:"127.0.0.1",
//    user:"root",
//    database:"lz",
//    password:"",
//    port:3306
// });

//let app = new express();
let app = express();
                              //返回字符串或Array
app.use(bodyParser.urlencoded({extended:false}));
// app.use(bodyParser());
app.use(cookieParser());
app.use(session({
   secret:"LinHR9608",
   resave:false,
   saveUninitialized:true
}));
app.use(cors({
   origin:["http://localhost:8080","http://127.0.0.1","http://localhost","http://176.116.33.219"],
   credentials:true
}));
// app.use(express,static("public"));

let server = http.createServer(app);
server.listen(3000);

app.get("/reg/checkPhone/:phone",(req,res)=>{
   let phone = req.params.phone;
   //从连接池中获取一个连接
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "SELECT * FROM lz_user WHERE phone = ?";
      conn.query(sql,[phone],(err,result)=>{
         if(err){
            throw err;
         }
         if(result.length==0){
            res.send({code:1,msg:"suc"});
         }else{
            res.send({code:-1,msg:"err"});
         }
         //释放连接对象->归还连接对象
         conn.release();
      })
   })
})

app.get("/reg/checkUserName/:uName",(req,res)=>{
   let uName = req.params.uName;
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "SELECT * FROM lz_user WHERE name = ?";
      conn.query(sql,[uName],(err,result)=>{
         if(err){
            throw err;
         }
         if(result.length==0){
            res.send({code:1,msg:"suc"});
         }else{
            res.send({code:-1,msg:"err"});
         }
         //释放连接对象->归还连接对象
         conn.release();
      })
   })
})

app.post("/reg",(req,res)=>{
   let phone = req.body.phone;
   let name = req.body.uName;
   let pwd = req.body.pwd;
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "INSERT INTO lz_user VALUES(NULL,?,?,md5(?),DEFAULT,DEFAULT)";
      conn.query(sql,[phone,name,pwd],(err,result)=>{
         if(err){
            throw err;
         }
         if(result.affectedRows>0){
            res.json({code:1,msg:"注册成功"});
         }else{
            res.json({code:-1,msg:"网络错误"});
         }
         conn.release();
      })
   })
})

app.post("/login",(req,res)=>{
   let phone = req.body.phone;
   let pwd = req.body.pwd;
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "SELECT uid FROM lz_user WHERE phone=? AND binary pwd=md5(?)";
      conn.query(sql,[phone,pwd],(err,result)=>{
         if(err){
            throw err;
         }
         if(result.length==1){
            req.session.user = result[0]; //存入session
            //console.log(req.session.user); //打印出用户信息
            res.json({code:1,msg:"登录成功"});
         }else{
            res.json({code:-1,msg:"用户名或密码错误"});
         }
      })
   })
})

app.get("/isLogin",(req,res)=>{
   let user = req.session.user;
   if(user){
       let sql = "SELECT uid,name,avatar FROM lz_user WHERE uid=?";
       pool.query(sql,[user.uid],(err,result)=>{
           if(err){
               throw err;
           }
           res.json({code:1,data:result[0]});
       })
   }else{
       res.json({code:-1});
   }
})

app.get("/logout",(req,res)=>{
    req.session.user = null;
    res.send({code:1,msg:"succ"});
})

app.get("/getCarousel",(req,res)=>{
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "SELECT src FROM carousel ORDER BY cid LIMIT 0,5";
      conn.query(sql,(err,result)=>{
         if(err){
            throw err;
         }
         res.json(result);
         conn.release();
      })
   })
})

app.get("/getSeries",(req,res)=>{
   pool.getConnection((err,conn)=>{
      if(err){
         throw err;
      }
      let sql = "SELECT seriesId,seriesLogo_lg,seriesName,pTime,area,type,lang,version,Akira,";
      sql += "(SELECT COUNT(vid) FROM videoList WHERE sid=seriesId) AS count,";
      sql += "(SELECT SUM(playCount) FROM videoList WHERE sid=seriesId) AS playCount,";
      sql += "introduce,start FROM lz_series ORDER BY hot DESC";
      conn.query(sql,(err,result)=>{
         if(err){
            throw err;
         }
         res.json(result);
         conn.release();
      })
   })
})

app.get("/detailMsg/:sid",(req,res)=>{
    let sid = req.params.sid;
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT seriesId,seriesName,pTime,area,type,lang,version,Akira,bgVideo,";
        sql += "(SELECT COUNT(vid) FROM videoList WHERE sid=seriesId) AS count,";
        sql += "(SELECT SUM(playCount) FROM videoList WHERE sid=seriesId) AS playCount,";
        sql += "introduce,start FROM lz_series WHERE seriesId = ?";
        conn.query(sql,[sid],(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result);
            conn.release();
        })
    })
})

app.get("/detailImg/:sid",(req,res)=>{
    let sid = req.params.sid;
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT source FROM seriesimg WHERE sid=? ORDER BY sImgId";
        conn.query(sql,[sid],(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result);
            conn.release();
        })
    })
})

app.get("/getRec",(req,res)=>{
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT seriesId,seriesName,seriesLogo_sm,";
        sql += "(SELECT COUNT(vid) FROM videoList WHERE sid=seriesId) AS count,";
        sql += "(SELECT SUM(playCount) FROM videoList WHERE sid=seriesId) AS playCount ";
        sql += "FROM lz_series ORDER BY hot DESC LIMIT 0,4";
        conn.query(sql,(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result);
            conn.release();
        })
    })
})

app.get("/loadDetail/:sid/:pno",(req,res)=>{
    let sid = req.params.sid;
    let pno = req.params.pno;
    //console.log(pno);
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT vid,sid,num,title,imgSrc,vTime FROM videoList WHERE sid=? LIMIT ?,?";
        conn.query(sql,[sid,(pno-1)*50,50],(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result);
            conn.release();
        })
    })
})

app.get("/loadTit/:sid",(req,res)=>{
    let sid = req.params.sid;
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT seriesId,seriesName,logo,introduce,";
        sql += "(SELECT COUNT(vid) FROM videoList WHERE sid=seriesId) AS count ";
        sql += "FROM lz_series WHERE seriesId=?";
        conn.query(sql,[sid],(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result[0]);
            conn.release();
        })
    })
})

app.get("/getVideoList/:sid/:vPno",(req,res)=>{
    let pno = req.params.vPno;
    let sid = req.params.sid;
    pool.getConnection((err,conn)=>{
        if(err){
            throw err;
        }
        let sql = "SELECT vid,num,title FROM videoList WHERE sid=? LIMIT ?,?";
        conn.query(sql,[sid,(pno-1)*50,50],(err,result)=>{
            if(err){
                throw err;
            }
            res.json(result);
            conn.release();
        })
    })  
})

app.get("/loadVideo/:vid",(req,res)=>{
    let vid = req.params.vid;
    // pool.getConnection((err,conn)=>{
    //     if(err){
    //         throw err;
    //     }
    let sql = "SELECT num,videoSrc,playCount,thumbUp FROM videoList WHERE vid=?";
    pool.query(sql,[vid],(err,result)=>{
        if(err){
            throw err;
        }
        res.json(result[0]);
        //conn.release();
    })
})

app.get("/getBarrage/:vid",(req,res)=>{
    let vid = req.params.vid;
    let sql = "SELECT msg,color,speed,top,showTime,leftOffset FROM barrage WHERE videoId=?";
    pool.query(sql,[vid],(err,result)=>{
        if(err){
            throw err;
        }
        res.json(result);
    })
})

app.get("/sendBarrage/:vid/:msg/:color/:speed/:top/:showTime/:leftOffset",(req,res)=>{
    let vid = req.params.vid;
    let msg = req.params.msg;
    let color = "#"+req.params.color;
    let speed = req.params.speed;
    let top = req.params.top;
    let showTime = req.params.showTime;
    let leftOffset = req.params.leftOffset;
    let sql = "INSERT INTO barrage VALUES(null,?,?,?,?,?,?,DEFAULT)";
    pool.query(sql,[vid,msg,color,speed,top,showTime,leftOffset],(err,result)=>{
        if(err){
            throw err;
        }
        if(result.affectedRows==1){
            res.send({code:1,msg:"succ"});
        }else{
            res.send({code:-1,msg:"err"});
        }
    })
})

app.get("/search/:kw/:pno",(req,res)=>{
    let kw = req.params.kw;
    let pno = req.params.pno;
    var totalCount = 0;
    var offset = 0;

    let sql = "SELECT count(*) AS count FROM videoList WHERE title LIKE ?";
    pool.query(sql,["%"+kw+"%"],(err,result)=>{
        if(err){
            throw err;
        }
        totalCount = result[0].count;
        //res.json(totalCount);
        pageCount = Math.ceil(totalCount/15);
        var offset = (pno-1)*15;
        //console.log(totalCount,pageCount,offset);
        sql = "SELECT vid,sid,title,playCount,(SELECT seriesName FROM lz_series WHERE seriesId=sid) AS sName ";
        sql += "FROM videoList WHERE title LIKE ? LIMIT ?,15";
        pool.query(sql,["%"+kw+"%",offset],(err,result)=>{
            if(err){
                throw err;
            }
            let output = {
                totalCount:totalCount,
                pageCount:pageCount,
                pno:pno,
                content:result
            }; 
            res.json(output);
        })
    })
})

app.get("/getComment/:vid",(req,res)=>{
    let vid = req.params.vid;
    let sql = `SELECT content,commTime,
        (SELECT uid FROM lz_user WHERE uid=commUid) AS uid,
        (SELECT name FROM lz_user WHERE uid=commUid) AS name,
        (SELECT avatar FROM lz_user WHERE uid=commUid) AS avatar
        FROM videocomments WHERE videoId=? ORDER BY commId DESC LIMIT 0,10`;
    pool.query(sql,[vid],(err,result)=>{
        if(err){
            throw err;
        }
        res.json(result);
    })
})

app.get("/comment/:vid/:uid/:content",(req,res)=>{
    let vid = req.params.vid,
        uid = req.params.uid,
        content = req.params.content;
    let now = new Date().getTime();
    //console.log(vid,uid,content);
    let sql = "INSERT INTO videocomments VALUES(null,?,?,?,?)";
    pool.query(sql,[vid,uid,content,now],(err,result)=>{
        if(err) throw err;
        if(result.affectedRows==1){
            res.json({code:1,msg:'succ'});
        }else{
            res.json({code:-1,msg:'err'});
        }
    })
})

app.get("/playCount/:vid",(req,res)=>{
    let vid = req.params.vid;
    let sql = "UPDATE videolist SET playCount=playCount+1 WHERE vid=?";
    pool.query(sql,[vid],(err,result)=>{
        if(err) throw err;
    })
})

app.get("/thumbUp/:vid",(req,res)=>{
    let vid = req.params.vid;
    let sql = "UPDATE videolist SET thumbUp=thumbUp+1 WHERE vid=?";
    pool.query(sql,[vid],(err,result)=>{
        if(err) throw err;
    })
})

app.get("/getUserMsg/:uid",(req,res)=>{
    let uid = req.params.uid;
    let sql = "SELECT uid,phone,name,avatar,level FROM lz_user WHERE uid=?";
    pool.query(sql,[uid],(err,result)=>{
        if(err) throw err;
        res.json(result[0]);
    })
})

//修改前原密码
app.post("/askOldPwd",(req,res)=>{
    let uid = req.body.uid;
    let pwd = req.body.pwd;
    let sql = "SELECT * FROM lz_user WHERE pwd=md5(?) AND uid=?";
    pool.query(sql,[pwd,uid],(err,result)=>{
        if(err) throw err;
        if(result.length==1){
            res.json({code:1,msg:'hasres'});
        }else{
            res.json({code:-1,msg:'noexit'});
        }
    })
})

//修改密码
app.post("/updatePwd",(req,res)=>{
    let uid = req.body.uid;
    let newPwd = req.body.newPwd;
    let sql = "UPDATE lz_user SET pwd=md5(?) WHERE uid=?";
    pool.query(sql,[newPwd,uid],(err,result)=>{
        if(err) throw err;
        if(result.affectedRows==1){
            res.json({code:1,msg:'succ'});
        }else{
            res.json({code:-1,msg:'fail'});
        }
    })
})

//头像上传
app.post('/upload', function(req, res) {
   const AVATAR_UPLOAD_FOLDER = "/avatar/";  //头像上传路径
   var form = new formidable.IncomingForm();   //创建上传表单
   form.encoding = 'utf-8';        //设置编辑
   form.uploadDir = 'public' + AVATAR_UPLOAD_FOLDER;     //设置上传目录
   form.keepExtensions = true;     //保留后缀
   form.maxFieldsSize = 2 * 1024 * 1024;   //文件大小

   form.parse(req, function(err, fields, files) {

      if (err) throw err;

      var extName = '';  //后缀名
      switch (files.myfile.type) {
         case 'image/pjpeg':
         extName = 'jpg';
         break;
         case 'image/jpeg':
         extName = 'jpg';
         break;
         case 'image/png':
         extName = 'png';
         break;
         case 'image/x-png':
         extName = 'png';
         break;
      }

      if(extName.length == 0){
         res.json({code:-1,msg:'type err'});
         return;
      }

      var avatarName = new Date().getTime() + parseInt(Math.random()*9000+1000) + '.' + extName;
      //图片写入地址；
      var newPath = form.uploadDir + avatarName;
      //显示地址；
      var showUrl = "http://127.0.0.1:3000" + AVATAR_UPLOAD_FOLDER + avatarName;
      //console.log("newPath",newPath);
      fs.renameSync(files.myfile.path, newPath);  //重命名
      res.json({code:1,newPath:showUrl});
   });
});

app.post("/updateAvt",(req,res)=>{
   let uid = req.body.uid;
   let path = req.body.path;
   let sql = "UPDATE lz_user SET avatar=? WHERE uid=?";
   pool.query(sql,[path,uid],(err,result)=>{
      if(err) throw err;
      if(result.affectedRows==1){
         res.json({code:1,msg:'succ'});
      }else{
         res.json({code:-1,msg:'fail'});         
      }
   })
})

app.get("/avatar/:pName",(req,res)=>{
   let picName = req.params.pName;
   res.sendFile(__dirname+"/public/avatar/"+picName);
})