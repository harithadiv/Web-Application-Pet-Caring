CREATE TABLE users(
    username varchar(64) PRIMARY KEY,
    password varchar(64) NOT NULL,
    first_name varchar(64),
    last_name varchar(64)
);

CREATE TABLE petowners(
    username varchar(64) PRIMARY KEY REFERENCES users(username),
    address varchar(256)
);

CREATE TABLE caretakers(
    username varchar(64) PRIMARY KEY REFERENCES users(username),
    address varchar(256)
);


CREATE TABLE parttime(
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username),
    salary numeric DEFAULT 0
);

CREATE TABLE fulltime(
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username),
    salary numeric DEFAULT 3000
);

CREATE TABLE pets(
    username varchar(64) REFERENCES users(username)
                         ON DELETE cascade,
    name varchar(64),
    animal_type varchar(64),
    special_requirement varchar(256),
    PRIMARY KEY(username, name)
);

CREATE TABLE pcsadmin(
    username varchar(64) PRIMARY KEY REFERENCES users(username)
);


CREATE TABLE availability(
     username varchar(64) REFERENCES users(username)
                          ON DELETE cascade,
     s_date date,
     e_date date,
     PRIMARY KEY (username, s_date, e_date)
);

CREATE TABLE bid(
    pouname varchar(64),
    name varchar(64),
    ctuname varchar(64),
    s_date date,
    e_date date,
    price numeric NOT NULL,
    rating integer CHECK ((rating IS NULL) OR (rating >= 0 AND rating <=5)),
    review varchar(256),
    is_win boolean DEFAULT FALSE,
    FOREIGN KEY(pouname, name) REFERENCES pets(username, name),
    FOREIGN KEY(ctuname, s_date, e_date) REFERENCES availability(username, s_date, e_date),
    PRIMARY KEY(pouname, name, ctuname, s_date, e_date)
);

