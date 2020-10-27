const sql = {};

sql.query = {
  // Register
  add_user: "INSERT INTO users (username, password) VALUES ($1,$2)",

  // Login
  get_user: "SELECT * FROM users WHERE username=$1",
};

module.exports = sql;
