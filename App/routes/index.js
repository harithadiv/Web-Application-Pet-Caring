var express = require("express");
var router = express.Router();

// Home page
router.get("/", function (req, res, next) {
  var status = "notLoggedIn";
  if (req.isAuthenticated()) {
    var username = req.user.username;
    if (req.session.role == "petowner") {
      status = "petowner";
    } else if (req.session.role == "caretaker") {
      status = "caretaker";
    }
  }

  res.render("index", { status: status, username: username });
});

module.exports = router;
