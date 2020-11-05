DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS petowners;
DROP TABLE IF EXISTS caretakers;
DROP TABLE IF EXISTS parttime;
DROP TABLE IF EXISTS fulltime;
DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS admin;
DROP TABLE IF EXISTS availability;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS bids;
DROP TABLE IF EXISTS animals;

CREATE TABLE users(
    username varchar(64) PRIMARY KEY,
    password varchar(64) NOT NULL,
    first_name varchar(64),
    last_name varchar(64)
);

CREATE TABLE petowners(
    username varchar(64) PRIMARY KEY REFERENCES users(username),
    credit_card varchar(64)
);

CREATE TABLE caretakers(
    username varchar(64) PRIMARY KEY REFERENCES users(username),
    salary numeric DEFAULT 0
);


CREATE TABLE parttime(
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username),
);

CREATE TABLE fulltime(
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username),
);

CREATE TABLE animals(
    a_type varchar(64) PRIMARY KEY,
);

CREATE TABLE pets(
    username varchar(64) REFERENCES petowners(username)
                         ON DELETE cascade,
    name varchar(64),
    a_type varchar(64) REFERENCES animals(a_type),
    PRIMARY KEY(username, name)
);

CREATE TABLE cares_for(
    ctuname varchar(64) REFERENCES caretakers(username),
    a_type varchar(64) REFERENCES animals(a_type),
    a_price numeric DEFAULT 0,
    PRIMARY KEY (ctuname, a_type)
);


CREATE TABLE admin(
    username varchar(64) PRIMARY KEY REFERENCES users(username)
);

CREATE TABLE availability(
     username varchar(64) REFERENCES users(username)
                          ON DELETE cascade,
     avail_date date,
     num_of_pets numeric DEFAULT 0, 
     PRIMARY KEY (username, avail_date)
);

CREATE TABLE bids(
    pouname varchar(64),
    name varchar(64),
    ctuname varchar(64),
    price numeric NOT NULL,
    transfer_method varchar(64),
    is_win boolean DEFAULT FALSE,
    s_date date,
    e_date date,
    FOREIGN KEY(pouname, name) REFERENCES pets(username, name),
    FOREIGN KEY(ctuname) REFERENCES caretakers(username),
    FOREIGN KEY(s_date, e_date) REFERENCES transactions(s_date, e_date),
    PRIMARY KEY(pouname, name, ctuname, s_date, e_date)
);

CREATE TABLE transactions(
    s_date date,
    e_date date,
    payment_method varchar(64),
    review varchar(256),
    rating integer CHECK ((rating IS NULL) OR (rating >= 0 AND rating <=5)),
    PRIMARY KEY (s_date, e_date)
);



