const express = require("express");
const router = express.Router();
const passport = require("passport");
const bcrypt = require("bcrypt");
const sql_query = require("../sql");
const parse = require('postgres-date')
const { Pool } = require("pg");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get("/", function (req, res, next) {
  res.render("add_pet");
});

router.post("/", function (req, res, next) {
  var username = req.user.username;
  var pet_name = req.body.inputName;
  var animal_type = req.body.inputAnimalType;
  var special_req = req.body.inputSpecialRequirement;
  console.log(req.body.inputName);
  console.log(req.body.inputAnimalType);
  console.log(req.body.inputSpecialRequirement);
  pool.query(sql_query.query.insert_pet,
    [username, pet_name, animal_type, special_req], (err, data) => {
      if (err) {
        return next(err);
      } else {
        return res.redirect("/petowners/" + req.user.username);
      }
    });
});

module.exports = router;
