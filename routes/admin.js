const sql_query = require("../sql");
var express = require("express");
var router = express.Router();
const { Pool } = require("pg");
const adminMiddleware = require("../auth/adminmiddle");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get("/:username", adminMiddleware(), function (req, res, next) {
  const username = req.params.username;
  pool.query(sql_query.query.get_user, [username], (err, data) => {
    if (err) {
      res.render("error", err);
    } else if (data.rows.length == 0) {
      res.send("User does not exist");
    } else {
      const firstName = data.rows[0].first_name;
      const lastName = data.rows[0].last_name;
      res.render("admin", {
        firstName: firstName,
        lastName: lastName,
        userName: username,
      });
    }
  });
});

module.exports = router;
