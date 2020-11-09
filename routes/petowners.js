var express = require("express");
var router = express.Router();
const sql_query = require("../sql");
const petMiddleware = require("../auth/petmiddle");
const { Pool } = require("pg");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Profile page
router.get("/:username", petMiddleware(), function (req, res, next) {
  const username = req.params.username;

  var pets = [];
  pool.query(sql_query.query.get_pets, [username], (err, data) => {
    pets = data.rows;
  });

  pool.query(sql_query.query.get_user, [username], (err, data) => {
    if (err) {
      res.next(err);
    } else if (data.rows.length == 0) {
      res.send("User does not exist");
    } else {
      const firstName = data.rows[0].first_name;
      const lastName = data.rows[0].last_name;
      res.render("petowners",
        {
          firstName: firstName,
          lastName: lastName,
          username: username,
          pets: pets
        });
    }
  });
});

module.exports = router;
