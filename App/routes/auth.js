var express = require("express");
var router = express.Router();
const passport = require("passport");
const bcrypt = require("bcrypt");
const sql_query = require("../sql");

const round = 10;
const salt = bcrypt.genSaltSync(round);

const { Pool } = require("pg");
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

router.get("/register", function (req, res, next) {
  res.render("register");
});

router.get("/login", function (req, res, next) {
  res.render("login");
});

router.post("/register", function (req, res, next) {
  var username = req.body.username;
  var password = bcrypt.hashSync(req.body.password, salt);
  var firstname = req.body.firstname;
  var lastname = req.body.lastname;
  pool.query(sql_query.query.add_user, [username, password]);
  res.redirect("/");
});

/* LOGIN */
router.post(
  "/login",
  passport.authenticate("local", {
    successRedirect: "/",
    failureRedirect: "/register",
  })
);

module.exports = router;
