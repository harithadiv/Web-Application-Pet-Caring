const sql_query = require("../sql");
var express = require("express");
var router = express.Router();
const { Pool } = require("pg");
const bcrypt = require("bcrypt");
const adminMiddleware = require("../auth/adminmiddle");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Password hashing setup
const round = 10;
const salt = bcrypt.genSaltSync(round);


router.get("/thankyouadmin", adminMiddleware(), function (req, res, next) {
  var username = req.user.username;
  res.render("thankyouadmin", {username: username});
});

// Register
router.get("/registeradmin", adminMiddleware(), function (req, res, next) {
  res.render("registeradmin");
});

router.post("/registeradmin", adminMiddleware(), async function (req, res, next) {
  var username = req.body.username;
  var password = bcrypt.hashSync(req.body.password, salt);
  var firstname = req.body.firstname;
  var lastname = req.body.lastname;
  console.log(username);
  await pool.query(sql_query.query.add_user, [
    username,
    password,
    firstname,
    lastname,
  ]);
    await pool.query(sql_query.query.add_admin, [username]);
  
  res.redirect("/admin/thankyouadmin");
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
      const totalSal = await pool.query(sql_query.query.get_total_earnings);
      const totalParttime = await pool.query(sql_query.query.get_parttime_caretakers_total_salary);
      const totalFulltime = await pool.query(sql_query.query.get_fulltime_caretakers_total_salary);
      const maxParttime = await pool.query(sql_query.query.get_parttime_caretaker_with_max_salary);
      const maxFulltime = await pool.query(sql_query.query.get_fulltime_caretaker_with_max_salary);
      const commission = await pool.query(sql_query.query.get_parttime_caretakers_total_salary);

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
        totalSal: totalSal.rows[0].sum,
        totalFulltime: totalFulltime.rows[0].sum,
        totalParttime: totalParttime.rows[0].sum,
        maxFulltime: maxFulltime.rows[0].username,
        maxFulltimesal:maxFulltime.rows[0].salary,
        maxParttimesal:maxParttime.rows[0].salary,
        maxParttime: maxParttime.rows[0].username,
        commission: commission.rows[0].sum/3,
      });
    }
  });
});




module.exports = router;
