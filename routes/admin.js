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
  pool.query(sql_query.query.get_user, [username], async (err, data) => {
    if (err) {
      res.render("error", err);
    } else if (data.rows.length == 0) {
      res.send("User does not exist");
    } else {
      const numPets = await pool.query(sql_query.query.get_num_of_pets);
      const numPetowners = await pool.query(
        sql_query.query.get_num_of_petowners
      );
      const numFulltime = await pool.query(sql_query.query.get_num_of_fulltime);
      const numParttime = await pool.query(sql_query.query.get_num_of_parttime);

      const atypestats = await pool.query(sql_query.query.get_atype_stats);
      const firstName = data.rows[0].first_name;
      const lastName = data.rows[0].last_name;

      res.render("admin", {
        numPets: numPets.rows[0].count,
        numFulltime: numFulltime.rows[0].count,
        numParttime: numParttime.rows[0].count,
        numPetowners: numPetowners.rows[0].count,
        atypestats: atypestats.rows,
        atypelength: atypestats.rowCount,
        firstName: firstName,
        lastName: lastName,
        userName: username,
      });
    }
  });
});

module.exports = router;
