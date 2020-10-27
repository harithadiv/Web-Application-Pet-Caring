const sql = {};

sql.query = {
  add_user: "INSERT INTO users (username, password) VALUES ($1,$2)",
};

module.exports = sql;
