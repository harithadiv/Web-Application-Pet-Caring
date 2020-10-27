const sql_query = require("../sql");
var express = require("express");
var router = express.Router();

const round = 10;
const salt = bcrypt.genSaltSync(round);

router.get("/", function (req, res, next) {
  res.render("register");
});

router.post("/", function (req, res, next) {});

module.exports = router;
