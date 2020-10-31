const express = require("express");
const router = express.Router();
const passport = require("passport");
const bcrypt = require("bcrypt");
const sql_query = require("../sql");
const { Pool } = require("pg");
const antiMiddleware = require("../auth/antimiddle.js");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Password hashing setup
const round = 10;
const salt = bcrypt.genSaltSync(round);

// Register
router.get("/register", antiMiddleware(), function (req, res, next) {
  res.render("register");
});

router.post("/register", antiMiddleware(), function (req, res, next) {
  var username = req.body.username;
  var password = bcrypt.hashSync(req.body.password, salt);
  var firstname = req.body.firstname;
  var lastname = req.body.lastname;
  var role = req.body.role;
  pool.query(sql_query.query.add_user, [
    username,
    password,
    firstname,
    lastname,
  ]);
  if (role == "petowner") {
    pool.query(sql_query.query.add_petowner, [username]);
  } else if (role == "caretaker") {
    pool.query(sql_query.query.add_caretaker, [username]);
  }
  res.redirect("/");
});

// Login
router.get("/login", antiMiddleware(), function (req, res, next) {
  res.render("login");
});

router.post("/login", antiMiddleware(), function (req, res, next) {
  passport.authenticate("local", function (err, user, info) {
    if (err) {
      return next(err);
    }
    if (!user) {
      return res.redirect("/auth/login");
    }
    req.logIn(user, function (err) {
      if (err) {
        return next(err);
      }
      console.log(user);
      return res.redirect("/users/" + user.username);
    });
  })(req, res, next);
});

module.exports = router;
