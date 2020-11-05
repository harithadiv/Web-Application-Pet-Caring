var express = require("express");
var router = express.Router();
const sql_query = require("../sql");
const middleware = require("../auth/middleware");
const { Pool } = require("pg");

// Connect to database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Pet profile page
router.get("/:ownername/:petname", middleware(), function (req, res, next) {
    const ownername = req.params.ownername;
    const petname = req.params.petname;
    pool.query(sql_query.query.get_user, [ownername, petname], (err, data) => {
    res.render("pets",
        { name: petname,
        type: "test",
        owner_username: ownername,
        caretaker_username: "test",
        special_requirements: "test" });
  });
});

module.exports = router;
