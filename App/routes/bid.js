const express = require("express");
const router = express.Router();
const passport = require("passport");
const bcrypt = require("bcrypt");
const sql_query = require("../sql");
const { Pool } = require("pg");
const antiMiddleware = require("../auth/antimiddle");
const authMiddleware = require("../auth/middleware");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Register
router.get("/", antiMiddleware(), function (req, res, next) {
    res.render("bid");
  });
  
router.post("/bid", antiMiddleware(), function (req, res, next) {
    var amount = req.body.amount;
    var pousername = req.body.pousername;
    // Convert the date to the postgres date format
    var s_date = req.body.startDate;
    var e_date = req.body.endDate;
    var careTakerUsername = req.body.userName;
    // pool.query(sql_query.query.get_caretaker, [careTakerUsername], (err, data) => {
    //     if (err) {
    //         return next(err);
    //     } else {
    //         pool.query(sql_query.query.add_bid, [
    //             username,
    //             s_date,
    //             e_date,
    //             amount,
    //           ]);
    //     }
    // });
    // res.redirect("/caretakers/" + pousername);
    res.redirect("/");
  });

module.exports = router;
