var express = require("express");
var mysql = require("mysql");
var sync_mysql = require("sync-mysql");
var uniqkey = require("uniqid");
var router = express.Router();

//*****************************user */

router.post("/login", function (req, res, next) {
  req.check("username", "username should be a-z and 1-9").isAlphanumeric().trim();
  req.check("password", "password should big than 6").isLength({ min: 6 });
  let err = req.validationErrors();
  if (err == 0) {
    toDatabase(
      "select * from users where username='" +
        req.body.username +
        "' and password='" +
        req.body.password +
        "'",
      (_) => {
        if (_.length == 0) res.json({ msg_type: "not found", msg: "" });
        else {
          //res.json({ msg_type: "sucs", msg: _ });
          let _token = String(uniqkey("user:-"));
          toDatabase(`delete FROM token WHERE user_id=${_[0].id};`, (n) => {
            toDatabase(
              `INSERT into token(user_id,token_)values(${_[0].id},'${_token}')`,
              (__) => {
                req.session.user_id=_[0].id
                res.json({
                 msg_type: "succ",
                  id:    _[0].id,
                  fname: _[0].fname,
                  lname: _[0].lname,
                  token: _token,
                });
              }
            );
          });
        }
      }
    );
  } else res.json({ msg_type: "error", msg: err });
});

router.post("/singup", function (req, res, next) {
  req.check("fname", "fist name should be a-z").trim().isAlpha();
  req.check("lname", "last name should be a-z").trim().isAlpha();
  req.check("username", "username should be than 5 character").isLength({min:6});
  req.check("username", "username should be a-z and 1-9").isAlphanumeric();
  req.check("password", "password should big than 6").isLength({ min: 6 });
  req.check("username", "username already exist").custom((value) => {
    var mysql = new sync_mysql({
      host: "localhost",
      port: 3306,
      user: "root",
      password: "@mine1997Amine",
      database: "sendify",
    });
    let resualt = mysql.query(
      "select * from users where username='" + req.body.username + "'"
    );
    if (resualt.length == 0) return true;
    else return false;
  });

  let err = req.validationErrors();
  if (err == 0) {
    toDatabase(
      `insert into users(fname,lname,username,password)values('${req.body.fname}','${req.body.lname}','${req.body.username}','${req.body.password}')`,
      (_) => {
        res.json({ msg_type:"succ",msg:_});
      }
    );
  } else res.json({ msg_type: "error", msg: err });
});

router.post("/user_from_tokken", function (req, res, next) {
  toDatabase(
    `select user_id from token where token_='${req.body.token}'`,
    (_) => {      
      if (_.length == 0) {
        res.json({ msg_type: "error", msg: "user not found" });
        return;
      }
      toDatabase(`select * from users where id=${_[0].user_id}`, (__) => {
        req.session.user_id=__[0].id
        res.json({
          msg_type: "succ",
          fname: __[0].fname,
          lname: __[0].lname,
          username:__[0].username,
          token: req.body.token,
        });
      });
    }
  );
});

router.get("/all_user",(req,res,next)=>{
  if(req.session.user_id==undefined) {
    res.end("acces denid")
    return
  }
  toDatabase("select fname,lname,id,username from users",(_)=>{
    res.json({msg_type:"succ",msg:_})
  })
})

router.get("/user_from_id/:id",(req,res,next)=>{
  if(req.session.user_id==undefined) {
    res.end("acces denid")
    return
  }
  toDatabase(`select fname,lname,username from users where id=${req.params.id}`,(_)=>{
    res.json({msg_type:"succ",msg:_})
  })
})

router.get("/curr_user_info",(req,res,next)=>{
  if(req.session.user_id==undefined) {
    res.end("acces denid")
    return
  }
  
  toDatabase(`select fname,lname,username from users where id=${req.session.user_id}`,(_)=>{
    res.json({msg_type:"succ",msg:_})
  })
})

// tempory method
router.get("/i_am_here", function (req, res, next) {
  if(req.session.user_id==undefined) {
    res.end("acces denid")
    return
  }
  userreq.session.user_id
  toDatabase(`delete from status where user_id=${user}`,(_)=>{
    toDatabase(`insert into status(user_id)values(${user})`,(__)=>{
      res.json({msg_type:"succ"})
    })
  })
});

router.post("/disconnect",(req,res,next)=>{
  if(req.session.user_id==undefined) {
    res.end("acces denid")
    return
  }
  req.session.destroy()
  res.json({msg_type:"succ"})
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
