function petMiddleware() {
  return function (req, res, next) {
    if (req.isAuthenticated() && req.session.role == "petowner") {
      return next();
    }
    res.redirect("/");
  };
}

module.exports = petMiddleware;
