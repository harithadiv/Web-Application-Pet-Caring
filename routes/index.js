var express = require("express");
var router = express.Router();
const sql_query = require("../sql");
const { Pool } = require("pg");
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});


// Home page
router.get("/", function (req, res, next) {
  var status = "notLoggedIn";
  if (req.isAuthenticated()) {
    var username = req.user.username;
    if (req.session.role == "petowner") {
      status = "petowner";
    } else if (req.session.role == "caretaker") {
      status = "caretaker";
    }
  }
  res.render("index", { status: status, username: username });
});

//bids/job history page
router.get("/history", function (req, res, next) {
  var status = "notLoggedIn";
  if (req.isAuthenticated() && (req.session.role == "petowner" || req.session.role == "caretaker" )) {
    var username = req.user.username;
    if (req.session.role == "petowner") {
      status = "petowner";
      pool.query(sql_query.query.get_petowner_history, [username], (err, data) => {
        console.log(data.rows);
        console.log(data.rowCount);
       
        return res.render("history", {
          username: username,
          data: data.rows,
          status: status,
          size: data.rowCount
         })
      });

    } else if (req.session.role == "caretaker") {
      status = "caretaker";
      pool.query(sql_query.query.get_caretaker_history, [username], (err, data) => {
        console.log(data.rows);
        res.render("history", {
          username: username,
          data: data.rows,
          status: status,
          size: data.rowCount
         })
      });
    }
  } else {
    res.redirect("/");
  }

});

module.exports = router;
