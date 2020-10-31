function careMiddleware() {
  return function (req, res, next) {
    if (req.isAuthenticated() && req.session.role == "caretaker") {
      return next();
    }
    res.redirect("/");
  };
}

module.exports = careMiddleware;
