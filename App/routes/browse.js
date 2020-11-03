var express = require("express");
var router = express.Router();
const sql_query = require("../sql");

const { Pool } = require("pg");
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get("/", function (req, res, next) {
  pool.query(sql_query.query.browse, [], (err, data) => {
    console.log(data.rows);
    res.render("browse", { avails: data.rows });
  });
});

module.exports = router;
