var express = require("express");
var router = express.Router();
const sql_query = require("../sql");
const caretakerMiddleware = require("../auth/caremiddle");
const { Pool } = require("pg");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Profile page
router.get("/:username", caretakerMiddleware(), function (req, res, next) {
  const username = req.params.username;
  pool.query(sql_query.query.get_user, [username], (err, data) => {
    if (err) {
      res.render("error", err);
    } else if (data.rows.length == 0) {
      res.send("User does not exist");
    } else {
      const firstName = data.rows[0].first_name;
      const lastName = data.rows[0].last_name;
      res.render("caretakers", {
        firstName: firstName,
        lastName: lastName,
        userName: username,
      });
    }
  });
});

module.exports = router;
