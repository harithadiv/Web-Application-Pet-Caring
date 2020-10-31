const sql = {};

sql.query = {
  // register
  add_user:
    "INSERT INTO users (username, password, first_name, last_name) VALUES ($1,$2,$3,$4)",
  add_petowner: "INSERT INTO petowners (username) VALUES ($1)",
  add_caretaker: "INSERT INTO caretakers (username) VALUES ($1)",
  // login
  get_user: "SELECT * FROM users WHERE username=$1",

  // pets
  get_pets: "SELECT * FROM pets WHERE username=$1",
  add_pet:
    "INSERT INTO pets (username, name, animal_type, special_requirement) VALUES ($1,$2,$3,$4)",
};

module.exports = sql;
