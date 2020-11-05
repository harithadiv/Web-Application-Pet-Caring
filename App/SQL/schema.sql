DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS petowners CASCADE;
DROP TABLE IF EXISTS caretakers CASCADE;
DROP TABLE IF EXISTS parttime CASCADE;
DROP TABLE IF EXISTS fulltime CASCADE;
DROP TABLE IF EXISTS pets CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS availability CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS bids CASCADE;
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS cares_for CASCADE;

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
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username)
);

CREATE TABLE fulltime(
    username varchar(64) PRIMARY KEY REFERENCES caretakers(username)
);

CREATE TABLE animals(
    a_type varchar(64) PRIMARY KEY
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


CREATE TABLE transactions(
    s_date date,
    e_date date,
    payment_method varchar(64),
    review varchar(256),
    rating integer CHECK ((rating IS NULL) OR (rating >= 0 AND rating <=5)),
    PRIMARY KEY (s_date, e_date)
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


INSERT INTO users (username, password, first_name, last_name) VALUES ('admin', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO admin (username) VALUES ('admin');
INSERT INTO users (username, password, first_name, last_name) VALUES ('alice', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO petowners (username) VALUES ('alice');
INSERT INTO users (username, password, first_name, last_name) VALUES ('bob', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO caretakers (username, salary) VALUES ('bob', 3000);
INSERT INTO fulltime (username) VALUES ('bob');
INSERT INTO users (username, password, first_name, last_name) VALUES ('cindy', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO caretakers (username, salary) VALUES ('cindy', 2000);
INSERT INTO parttime (username) VALUES ('cindy');
INSERT INTO users (username, password, first_name, last_name) VALUES ('max', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO petowners (username) VALUES ('max');


INSERT INTO animals (a_type) VALUES ('cat');
INSERT INTO animals (a_type) VALUES ('mouse');

INSERT INTO pets (username, name, a_type) VALUES ('alice', 'tom', 'cat');
INSERT INTO pets (username, name, a_type) VALUES ('alice', 'jerry', 'mouse');
INSERT INTO pets (username, name, a_type) VALUES ('max', 'mickey', 'cat');
INSERT INTO pets (username, name, a_type) VALUES ('max', 'garfield', 'cat');


INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-06-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-07-21', 0);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('bob', 'cat', 12);
INSERT INTO transactions (s_date, e_date) VALUES ('2021-05-23', '2021-05-25');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, is_win, s_date, e_date) VALUES ('alice', 'tom', 'bob', 20, NULL, TRUE, '2021-05-23', '2021-05-25');








