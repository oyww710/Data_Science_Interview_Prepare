-- 08 Updating Data
-- test.db

SELECT * FROM customer;
UPDATE customer SET address = '123 Music Avenue', zip = '98056' WHERE id = 5;
UPDATE customer SET address = '2603 S Washington St', zip = '98056' WHERE id = 5;
UPDATE customer SET address = NULL, zip = NULL WHERE id = 5;

-- 09 Deleting Data
-- test.db

SELECT * FROM customer WHERE id = 4;
DELETE FROM customer WHERE id = 4;
SELECT * FROM customer;
DELETE FROM customer WHERE id = 5;
SELECT * FROM customer;

-- 02 DROP TABLE
-- test.db

CREATE TABLE test ( a TEXT, b TEXT );
INSERT INTO test VALUES ( 'one', 'two' );
SELECT * FROM test;
DROP TABLE test;
DROP TABLE IF EXISTS test;

-- 04 DELETE FROM
-- test.db

SELECT * FROM test;
DELETE FROM test WHERE a = 3;
SELECT * FROM test WHERE a = 1;
DELETE FROM test WHERE a = 1;

-- 05 NULL
-- test.db

SELECT * FROM test;
SELECT * FROM test WHERE a = NULL;
SELECT * FROM test WHERE a IS NULL;
SELECT * FROM test WHERE a IS NOT NULL;
INSERT INTO test ( a, b, c ) VALUES ( 0, NULL, '' );
SELECT * FROM test WHERE b IS NULL;
SELECT * FROM test WHERE b = '';
SELECT * FROM test WHERE c = '';
SELECT * FROM test WHERE c IS NULL;

DROP TABLE IF EXISTS test;
CREATE TABLE test (
  a INTEGER NOT NULL,
  b TEXT NOT NULL,
  c TEXT
);

INSERT INTO test VALUES ( 1, 'this', 'that' );
SELECT * FROM test;

INSERT INTO test ( b, c ) VALUES ( 'one', 'two' );
INSERT INTO test ( a, c ) VALUES ( 1, 'two' );
INSERT INTO test ( a, b ) VALUES ( 1, 'two' );
DROP TABLE IF EXISTS test;


-- 07 ALTER TABLE
-- test.db

DROP TABLE IF EXISTS test;
CREATE TABLE test ( a TEXT, b TEXT, c TEXT );
INSERT INTO test VALUES ( 'one', 'two', 'three');
INSERT INTO test VALUES ( 'two', 'three', 'four');
INSERT INTO test VALUES ( 'three', 'four', 'five');
SELECT * FROM test;

ALTER TABLE test ADD d TEXT;
ALTER TABLE test ADD e TEXT DEFAULT 'panda';

DROP TABLE IF EXISTS test;

-- 02 LENGTH
-- world.db

SELECT LENGTH('string');
SELECT Name, LENGTH(Name) AS Len FROM City ORDER BY Len DESC;

-- 03 SUBSTR
-- album.db

SELECT SUBSTR('this string', 6);
SELECT SUBSTR('this string', 6, 3);
SELECT released,
    SUBSTR(released, 1, 4) AS year,
    SUBSTR(released, 6, 2) AS month,
    SUBSTR(released, 9, 2) AS day
  FROM album
  ORDER BY released
;

-- 04 TRIM

SELECT TRIM('   string   ');
SELECT LTRIM('   string   ');
SELECT RTRIM('   string   ');
SELECT TRIM('...string...', '.');

-- 02 DATE/TIME functions
-- :memory:

SELECT DATETIME('now');
SELECT DATE('now');
SELECT TIME('now');
SELECT DATETIME('now', '+1 day');
SELECT DATETIME('now', '+3 days');
SELECT DATETIME('now', '-1 month');
SELECT DATETIME('now', '+1 year');
SELECT DATETIME('now', '+3 hours', '+27 minutes', '-1 day', '+3 years');

-- 02 transactions
-- test.db

CREATE TABLE widgetInventory (
  id INTEGER PRIMARY KEY,
  description TEXT,
  onhand INTEGER NOT NULL
);

CREATE TABLE widgetSales (
  id INTEGER PRIMARY KEY,
  inv_id INTEGER,
  quan INTEGER,
  price INTEGER
);

INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'rock', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'paper', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'scissors', 25 );

SELECT * FROM widgetInventory;
SELECT * FROM widgetSales;

BEGIN TRANSACTION;
INSERT INTO widgetSales ( inv_id, quan, price ) VALUES ( 1, 5, 500 );
UPDATE widgetInventory SET onhand = ( onhand - 5 ) WHERE id = 1;
END TRANSACTION;

BEGIN TRANSACTION;
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'toy', 25 );
ROLLBACK;
SELECT * FROM widgetInventory;

-- restore database
DROP TABLE IF EXISTS widgetInventory;
DROP TABLE IF EXISTS widgetSales;

-- 03 performance
-- test.db

CREATE TABLE test ( id INTEGER PRIMARY KEY, data TEXT );

-- put this before the 1,000 INSERT statements
BEGIN TRANSACTION;

-- copy / paste 1,000 of these ...
INSERT INTO test ( data ) VALUES ( 'this is a good sized line of text.' );

-- put this after the 1,000 INSERT statements
END TRANSACTION;

SELECT COUNT(*) FROM test;

-- restore database
DROP TABLE test;

-- 01 update triggers
-- test.db

CREATE TABLE widgetCustomer ( id INTEGER PRIMARY KEY, name TEXT, last_order_id INT );
CREATE TABLE widgetSale ( id INTEGER PRIMARY KEY, item_id INT, customer_id INT, quan INT, price INT );

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');

SELECT * FROM widgetCustomer;

CREATE TRIGGER newWidgetSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetCustomer SET last_order_id = NEW.id WHERE widgetCustomer.id = NEW.customer_id;
    END
;

INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);
SELECT * FROM widgetSale;
SELECT * FROM widgetCustomer;

-- 02 preventing updates
-- test.db

DROP TABLE IF EXISTS widgetSale;

CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT,
    reconciled INT );
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (1, 3, 5, 1995, 0);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (2, 2, 3, 1495, 1);
INSERT INTO widgetSale (item_id, customer_id, quan, price, reconciled) VALUES (3, 1, 1, 2995, 0);
SELECT * FROM widgetSale;

CREATE TRIGGER updateWidgetSale BEFORE UPDATE ON widgetSale
    BEGIN
        SELECT RAISE(ROLLBACK, 'cannot update table "widgetSale"') FROM widgetSale
            WHERE id = NEW.id AND reconciled = 1;
    END
;

BEGIN TRANSACTION;
UPDATE widgetSale SET quan = 9 WHERE id = 2;
END TRANSACTION;

SELECT * FROM widgetSale;

-- 03 timestamps
-- test.db

DROP TABLE IF EXISTS widgetSale;
DROP TABLE IF EXISTS widgetCustomer;

CREATE TABLE widgetCustomer ( id integer primary key, name TEXT, last_order_id INT, stamp TEXT );
CREATE TABLE widgetSale ( id integer primary key, item_id INT, customer_id INTEGER, quan INT, price INT, stamp TEXT );
CREATE TABLE widgetLog ( id integer primary key, stamp TEXT, event TEXT, username TEXT, tablename TEXT, table_id INT);

INSERT INTO widgetCustomer (name) VALUES ('Bob');
INSERT INTO widgetCustomer (name) VALUES ('Sally');
INSERT INTO widgetCustomer (name) VALUES ('Fred');
SELECT * FROM widgetCustomer;

CREATE TRIGGER stampSale AFTER INSERT ON widgetSale
    BEGIN
        UPDATE widgetSale SET stamp = DATETIME('now') WHERE id = NEW.id;
        UPDATE widgetCustomer SET last_order_id = NEW.id, stamp = DATETIME('now')
            WHERE widgetCustomer.id = NEW.customer_id;
        INSERT INTO widgetLog (stamp, event, username, tablename, table_id)
            VALUES (DATETIME('now'), 'INSERT', 'TRIGGER', 'widgetSale', NEW.id);
    END
;

INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (1, 3, 5, 1995);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (2, 2, 3, 1495);
INSERT INTO widgetSale (item_id, customer_id, quan, price) VALUES (3, 1, 1, 2995);

SELECT * FROM widgetSale;
SELECT * FROM widgetCustomer;
SELECT * FROM widgetLog;

-- restore database
DROP TRIGGER IF EXISTS newWidgetSale;
DROP TRIGGER IF EXISTS updateWidgetSale;
DROP TRIGGER IF EXISTS stampSale;

DROP TABLE IF EXISTS widgetCustomer;
DROP TABLE IF EXISTS widgetSale;
DROP TABLE IF EXISTS widgetLog;


