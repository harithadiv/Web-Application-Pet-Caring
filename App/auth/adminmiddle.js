function adminMiddleware() {
  return function (req, res, next) {
    if (req.isAuthenticated() && req.session.role == "admin") {
      return next();
    }
    res.redirect("/");
  };
}

module.exports = adminMiddleware;
