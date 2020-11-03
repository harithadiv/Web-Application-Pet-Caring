var express = require("express");
var router = express.Router();

// Home page
router.get("/", function (req, res, next) {
  var status = "notLoggedIn";
  if (req.isAuthenticated()) {
    if (req.session.role == "petowner") {
      status = "petowner";
    } else if (req.session.role == "caretaker") {
      status = "caretaker";
    } else {
      res.next();
    }
  }

  res.render("index", { status: status });
});

module.exports = router;
