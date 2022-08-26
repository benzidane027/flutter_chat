var express = require("express");
var mysql = require("mysql");
var router = express.Router();


router.post("/i_am_here", function (req, res, next) {
    if(req.session.user_id==undefined) {
      res.end("acces denid")
      return
    }
    let user=req.session.user_id;
    toDatabase(`delete from status where user_id=${user}`,(_)=>{
      toDatabase(`insert into status(user_id)values(${user})`,(__)=>{
        res.json({msg_type:"succ_"})
      })
    })
  
  });
  router.get("/users_active",(req,res,next)=>{
    if(req.session.user_id==undefined) {
      res.end("acces denid")
      return
    }
    toDatabase(`SELECT users.id,lname,fname,username FROM status,users WHERE date_ >DATE_ADD(now(), interval
    -5 minute) and users.id=status.user_id;`,(_)=>{
      res.json({
        msg_type:"succ",
        msg:_
      })
    }) 
  
  })

  router.get("/user_active/:recive_id",(req,res,next)=>{
    if(req.session.user_id==undefined) {
      res.end("acces denid")
      return
    }

    let reciver_id=req.params.recive_id;
    toDatabase(`SELECT * FROM status WHERE date_ >DATE_ADD(now(), interval -5 minute) and user_id=${reciver_id};`,(_)=>{
      res.json({
        msg_type:"succ",
        msg:_
      })
    })
  
  })
  
  
  function toDatabase(sql, callback) {
    let con = mysql.createConnection({
      host: "localhost",
      port: 3306,
      user: "root",
      password: "Amine1997",
      database: "sendify",
      charset:"utf8mb4"
    });
  
    con.connect(function (err) {
      if (err) return "no data";
      con.query(sql, (err, resualt) => {
        if (err) throw err;
        callback(resualt);
        con.destroy();
      });
    });
  }
  module.exports = router;