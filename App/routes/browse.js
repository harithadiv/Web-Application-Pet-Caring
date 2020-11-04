var express = require("express");
var router = express.Router();
const sql_query = require("../sql");

const { Pool } = require("pg");
const { middleware } = require("../auth");
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get("/", middleware(), function (req, res, next) {
  pool.query(sql_query.query.browse, [], (err, data) => {
    console.log(data.rows);
    var username = req.session.passport.user;
    res.render("browse", { avails: data.rows, username: username });
  });
});

module.exports = router;
