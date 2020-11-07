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

// Bid
router.get("/", function (req, res, next) {
    console.log("##############################################Username here#######################################");
    console.log(req.user.username);
    console.log(req);
    res.render("bid", {username: req.user.username});
});

router.post("/", function (req, res, next) {
    console.log(req);
    var amount = req.body.amount;
    var pousername = req.body.pousername;
    var petname = req.body.petname;
    // Convert the date to the postgres date format
    var s_date = parse(req.body.startDate);
    console.log(s_date);
    var e_date = parse(req.body.endDate);
    console.log(e_date);
    var careTakerUsername = req.body.username;
    console.log("#########UserName##########");
    console.log(careTakerUsername);
    pool.query(sql_query.query.get_caretaker, [careTakerUsername], (err, data) => {
        if (err) {
            return next(err);
        } else {
            pool.query(sql_query.query.add_bid, [
                pousername,
                careTakerUsername,
                petname,
                s_date,
                e_date,
                amount,
              ]);
        }
    });
    return res.redirect("/petowners/" + pousername);
  });

module.exports = router;
