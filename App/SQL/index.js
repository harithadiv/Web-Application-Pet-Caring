const sql = {};

sql.query = {
  // register
  add_user:
    "INSERT INTO users (username, password, first_name, last_name) VALUES ($1,$2,$3,$4)",
  add_petowner: "INSERT INTO petowners (username) VALUES ($1)",
  add_caretaker: "INSERT INTO caretakers (username) VALUES ($1)",
  add_admin: "INSERT INTO admin (username) VALUES ($1)",
  // login
  get_user: "SELECT * FROM users WHERE username=$1",

  // pets
  get_pets: "SELECT * FROM pets WHERE username=$1",
  add_pet:
    "INSERT INTO pets (username, name, animal_type, special_requirement) VALUES ($1,$2,$3,$4)",

  // petowners
  get_petowner: "SELECT * FROM petowners WHERE username=$1",

  // caretakers
  get_caretaker: "SELECT * FROM caretakers WHERE username=$1",
  get_browsed_caretaker: "SELECT * FROM caretakers NATURAL JOIN users WHERE username=$1",

  browse: "SELECT * FROM availability JOIN users ON availability.username=users.username",
  
  // insert pet
  insert_pet: "INSERT INTO pets VALUES ($1, $2, $3, $4)",

  // admin
  get_admin: "SELECT * FROM admin WHERE username=$1",

  // register
  add_bid:
    "INSERT INTO bid (pouname, ctuname, name, s_date, e_date, price) VALUES ($1,$2,$3,$4,$5,$6)",

  // admin queries
  get_num_of_pets_within_month:
    "SELECT COUNT(DISTINCT name) FROM bids WHERE is_win = TRUE AND (s_date >= '2021-05-01' AND s_date <= '2021-05-31') OR (e_date >= '2021-05-01' AND e_date <= '2021-05-31');",
};

module.exports = sql;
