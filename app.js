const createError = require("http-errors");
const express = require("express");
const path = require("path");
const cookieParser = require("cookie-parser");
const session = require("express-session");
const logger = require("morgan");
const passport = require("passport");
const bodyParser = require("body-parser");

const app = express();
require("dotenv").config();

// Routers
const indexRouter = require("./routes/index");
const authRouter = require("./routes/auth");
const bidRouter = require("./routes/bid");
const browseRouter = require("./routes/browse");
const addpetRouter = require("./routes/add_pet");
const petownersRouter = require("./routes/petowners");
const caretakersRouter = require("./routes/caretakers");
const petsRouter = require("./routes/pets");
const adminRouter = require("./routes/admin");

// authentication setup
require("./auth").init(app);
app.use(
  session({
    secret: "secret",
    resave: true,
    saveUninitialized: true,
  })
);

app.use(passport.initialize());
app.use(passport.session());

// Body Parser setup
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// View engine setup
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");

app.use(logger("dev"));
app.use(cookieParser());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

// Routes
app.use("/auth", authRouter);
app.use("/bid", bidRouter);
app.use("/browse", browseRouter);
app.use("/add_pet", addpetRouter);
app.use("/petowners", petownersRouter);
app.use("/caretakers", caretakersRouter);
app.use("/admin", adminRouter);
app.use("/pets", petsRouter);
app.use("/", indexRouter);

// Catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// Error handler
app.use(function (err, req, res, next) {
  // Set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // Render the error page
  res.status(err.status || 500);
  res.render("error");
});

module.exports = app;
