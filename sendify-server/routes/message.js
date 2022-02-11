var express = require("express");
const { check } = require("express-validator/check");

var mysql = require("mysql");
var sync_mysql = require("sync-mysql");
var uniqkey = require("uniqid");
var router = express.Router();

router.get("/get_messages_list", function (req, res, next) {
  if (req.session.user_id == undefined) {
    res.end("acces denid");
    return;
  }
  
  let user = req.session.user_id;
  toDatabase(
    `   SELECT users.id,users.fname ,users.lname ,messages.
           content,messages.status,messages.date_ from users,
                 messages WHERE (sender_id =${user} and reciver_id=users.id) 
       or (reciver_id =${user} and sender_id=users.id)
             ORDER BY messages.date_ desc;
    `,
    (_) => {
            res.json({msg: _});
       
    }
  );
});

router.get("/get_convrersation/:id", function (req, res, next) {
    if (req.session.user_id == undefined) {
        res.end("acces denid");
        return;
      }       
      let user=req.session.user_id
      toDatabase(`select * from messages where (sender_id=${user} and reciver_id=${req.params.id}) or (reciver_id=${user} and sender_id=${req.params.id}) order by date_ desc`,(_)=>{
                res.json({msg_type:"succ",msg:_})
          
      })
});

router.post("/send_message", function (req, res, next) {
  if (req.session.user_id == undefined) {
    res.end("acces denid");
    return;
  }
  let user = req.session.user_id;
  let reciver = req.body.reciver_id;
  let content = req.body.content;
  check("reciver_id", "recievre should be integer").isNumeric();
  check("content", "message should be a string").isString();

  let err = req.validationErrors();
  if (err == 0) {

    toDatabase(
      `INSERT INTO sendify.messages
      (sender_id, reciver_id, content, status, date_, file)
      VALUES(${user}, ${reciver}, '${content}', 0, CURRENT_TIMESTAMP, ' ');`,
      (_) => {
        res.json({ msg_type: "succ"});
      }
    );
  } else res.json({ msg_type: "error", msg: err });
});

function toDatabase(sql, callback) {
  let con = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "@mine1997Amine",
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
