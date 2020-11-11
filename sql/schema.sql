DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS petowners CASCADE;
DROP TABLE IF EXISTS caretakers CASCADE;
DROP TABLE IF EXISTS parttime CASCADE;
DROP TABLE IF EXISTS fulltime CASCADE;
DROP TABLE IF EXISTS pets CASCADE;
DROP TABLE IF EXISTS admin CASCADE;
DROP TABLE IF EXISTS availability CASCADE;
DROP TABLE IF EXISTS bid_dates CASCADE;
DROP TABLE IF EXISTS bids CASCADE;
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS cares_for CASCADE;
DROP TABLE IF EXISTS takes_leave CASCADE;

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
    salary numeric DEFAULT 0,
    max_pets numeric DEFAULT 5
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
     num_of_pets numeric DEFAULT 0 CHECK (num_of_pets <= 5 AND num_of_pets >= 0), 
     PRIMARY KEY (username, avail_date)
);


CREATE TABLE bid_dates(
    s_date date,
    e_date date,
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
    payment_method varchar(64),
    review varchar(256),
    rating integer CHECK ((rating IS NULL) OR (rating >= 0 AND rating <=5)),
    FOREIGN KEY(pouname, name) REFERENCES pets(username, name),
    FOREIGN KEY(ctuname) REFERENCES caretakers(username),
    FOREIGN KEY(s_date, e_date) REFERENCES bid_dates(s_date, e_date),
    PRIMARY KEY(pouname, name, ctuname, s_date, e_date)
);

CREATE TABLE takes_leave(
    ctuname varchar(64) REFERENCES caretakers(username),
    s_date date, 
    e_date date,
    PRIMARY KEY(ctuname, s_date, e_date)
);


INSERT INTO users (username, password, first_name, last_name) VALUES ('admin', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Admin', 'Test');
INSERT INTO admin (username) VALUES ('admin');
INSERT INTO users (username, password, first_name, last_name) VALUES ('alice', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Alice', 'E');
INSERT INTO petowners (username) VALUES ('alice');
INSERT INTO users (username, password, first_name, last_name) VALUES ('bob', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Bob', 'Dylan');
INSERT INTO caretakers (username, salary) VALUES ('bob', 3000);
INSERT INTO fulltime (username) VALUES ('bob');
INSERT INTO users (username, password, first_name, last_name) VALUES ('cindy', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Cindy', 'Vi');
INSERT INTO caretakers (username, salary) VALUES ('cindy', 2000);
INSERT INTO parttime (username) VALUES ('cindy');
INSERT INTO users (username, password, first_name, last_name) VALUES ('max', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Max', 'Adam');
INSERT INTO petowners (username) VALUES ('max');
INSERT INTO users (username, password, first_name, last_name) VALUES ('a', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Ava', 'Clement');
INSERT INTO caretakers (username, salary) VALUES ('a', 3000);
INSERT INTO fulltime (username) VALUES ('a');
INSERT INTO users (username, password, first_name, last_name) VALUES ('b', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Ranna', 'Vaughton');
INSERT INTO caretakers (username, salary) VALUES ('b', 3000);
INSERT INTO fulltime (username) VALUES ('b');
INSERT INTO users (username, password, first_name, last_name) VALUES ('c', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Woody', 'Gayne');
INSERT INTO caretakers (username, salary) VALUES ('c', 3000);
INSERT INTO fulltime (username) VALUES ('c');
INSERT INTO users (username, password, first_name, last_name) VALUES ('d', '$2b$10$P1VnipQ.dJ1MFjD0ZVc44esU.QRxr2uG2mrx5NFRpU3JCXiWm5uc6', 'Ranique', 'Pan');
INSERT INTO caretakers (username, salary) VALUES ('d', 3000);
INSERT INTO fulltime (username) VALUES ('d');



INSERT INTO animals (a_type) VALUES ('cat');
INSERT INTO animals (a_type) VALUES ('dog');
INSERT INTO animals (a_type) VALUES ('mouse');

INSERT INTO pets (username, name, a_type) VALUES ('alice', 'tom', 'cat');
INSERT INTO pets (username, name, a_type) VALUES ('alice', 'jerry', 'mouse');
INSERT INTO pets (username, name, a_type) VALUES ('max', 'mickey', 'cat');
INSERT INTO pets (username, name, a_type) VALUES ('max', 'garfield', 'cat');



INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-05-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-06-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('bob', '2021-07-21', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('a', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('b', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('c', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('d', '2021-05-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('a', '2021-05-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('b', '2021-05-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('c', '2021-05-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('d', '2021-05-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('a', '2021-05-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('b', '2021-05-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('c', '2021-05-26', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('c', '2021-05-27', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('cindy', '2020-11-23', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('cindy', '2020-11-24', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('cindy', '2020-11-25', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('cindy', '2020-11-26', 0);
INSERT INTO availability (username, avail_date, num_of_pets) VALUES ('cindy', '2020-11-27', 0);





INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('bob', 'cat', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('a', 'cat', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('a', 'mouse', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('b', 'cat', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('c', 'mouse', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('c', 'cat', 12);
INSERT INTO cares_for (ctuname, a_type, a_price) VALUES ('c', 'dog', 12);
INSERT INTO bid_dates (s_date, e_date) VALUES ('2021-05-23', '2021-05-25');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2021-05-24', '2021-05-25');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2021-05-26', '2021-05-26');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2021-05-23', '2021-05-24');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2020-11-06', '2020-11-07');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2021-05-23', '2021-05-27');
INSERT INTO bid_dates (s_date, e_date) VALUES ('2020-11-23', '2020-11-27');





INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('alice', 'tom', 'bob', 20, NULL, '2021-05-23', '2021-05-25');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('alice', 'tom', 'a', 20, NULL, '2021-05-23', '2021-05-25');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('alice', 'tom', 'b', 20, NULL, '2021-05-23', '2021-05-25');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('alice', 'tom', 'c', 20, NULL, '2021-05-26', '2021-05-26');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('max', 'mickey', 'b', 20, NULL, '2021-05-23', '2021-05-24');
INSERT INTO bids (pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES ('max', 'garfield', 'a', 20, NULL, '2020-11-06', '2020-11-07');
INSERT INTO bids (is_win, pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES (TRUE, 'max', 'garfield', 'c', 30, NULL, '2020-11-23', '2020-11-27');
INSERT INTO bids (is_win, pouname, name, ctuname, price, transfer_method, s_date, e_date) VALUES (TRUE, 'max', 'mickey', 'cindy', 30, NULL, '2020-11-23', '2020-11-27');



CREATE TRIGGER is_win_update
AFTER UPDATE
ON bids
FOR EACH ROW
WHEN (NEW.is_win = TRUE)
EXECUTE PROCEDURE update_avail_pets();
 
CREATE OR REPLACE FUNCTION update_avail_pets()
RETURNS trigger AS
$$
BEGIN
UPDATE availability 
SET num_of_pets = num_of_pets + 1
WHERE availability.avail_date >= NEW.s_date AND availability.avail_date <= NEW.e_date AND availability.username = new.ctuname;
DELETE FROM bids
WHERE bids.name = new.name AND bids.pouname = new.pouname AND is_win = FALSE AND ((bids.s_date >= new.s_date AND bids.s_date <= new.e_date)
OR (bids.e_date >= new.s_date AND bids.e_date <= new.e_date)); 
RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

CREATE TRIGGER rating_update
BEFORE UPDATE 
ON bids
FOR EACH ROW
WHEN (NEW.rating IS NOT NULL)
EXECUTE PROCEDURE check_valid_rating();

CREATE OR REPLACE FUNCTION check_valid_rating() 
RETURNS TRIGGER AS 
$$ 
BEGIN
IF NOW() >= new.e_date AND new.is_win = TRUE THEN
	RETURN NEW;
ELSE 
	RETURN NULL;
END IF;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION remove_availability()
RETURNS trigger AS
$t$ BEGIN IF new.num_of_pets IN (SELECT max_pets FROM caretaker c  WHERE c.username = new.username) THEN  DELETE FROM availability WHERE availability.avail_date = new.avail_date AND availability.username = new.username; END IF; RETURN NULL; END; $t$
LANGUAGE plpgsql;

CREATE TRIGGER is_full
AFTER UPDATE
ON availability
FOR EACH ROW
EXECUTE PROCEDURE remove_availability();

CREATE TRIGGER is_win_fulltime_salary_update
AFTER INSERT
ON bids
FOR EACH ROW
WHEN (NEW.is_win = TRUE)
EXECUTE PROCEDURE update_fulltime_salary();
 
CREATE OR REPLACE FUNCTION update_fulltime_salary()
RETURNS TRIGGER AS $$
DECLARE sal numeric;
BEGIN
WITH pet_days AS (SELECT COALESCE(SUM(e_date - s_date + 1), 0) AS num_days FROM bids WHERE is_win = True AND ctuname = new.ctuname AND ((s_date >= (SELECT date_trunc('month', CURRENT_DATE)) AND s_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day')) OR (e_date >= (SELECT date_trunc('month', CURRENT_DATE)) AND e_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day')))) SELECT CASE WHEN (SELECT num_days FROM pet_days) <= 2 THEN 3000 ELSE 3000 +  (SELECT ((SELECT num_days FROM pet_days) - 2)* MAX(price)*0.8 FROM bids WHERE  is_win = True AND ctuname = new.ctuname AND ((s_date >= (SELECT date_trunc('month', CURRENT_DATE))AND s_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day')) OR (e_date >= (SELECT date_trunc('month', CURRENT_DATE)) AND e_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day')))) END into sal;
UPDATE caretakers
SET salary = sal
WHERE caretakers.username = new.ctuname AND new.ctuname IN (SELECT username FROM fulltime);
RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

CREATE TRIGGER is_win_parttime_salary_update
AFTER INSERT
ON bids
FOR EACH ROW
WHEN (NEW.is_win = TRUE)
EXECUTE PROCEDURE update_parttime_salary();
 
CREATE OR REPLACE FUNCTION update_parttime_salary()
RETURNS TRIGGER AS $$
DECLARE sal numeric;
BEGIN
SELECT 0.75 * SUM((e_date - s_date + 1) * price) 
FROM bids
WHERE is_win = TRUE AND ctuname = new.ctuname
AND ((s_date >= (SELECT date_trunc('month', CURRENT_DATE)) AND s_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day')) OR (e_date >= (SELECT date_trunc('month', CURRENT_DATE)) AND e_date <= (SELECT date_trunc('month', CURRENT_DATE) + interval '1 month - 1 day'))) into sal;
UPDATE caretakers
SET salary = sal
WHERE caretakers.username = new.ctuname AND new.ctuname IN (SELECT username FROM parttime);
RETURN NEW;
END;
$$
LANGUAGE plpgsql;