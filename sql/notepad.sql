-- Vorbereitungen

SHOW DATABASES;
USE mydb -A;
SHOW TABLES;
SELECT * FROM mydb.employees;
SELECT * FROM mydb.countries;

-- Wer sind wir in MySQL?
SELECT user();

-- @root:

-- user-Tabelle
SHOW DATABASES;
USE mysql;
SHOW TABLES;
DESCRIBE mysql.user;

SELECT 
	user, 
	authentication_string 
FROM mysql.user;


-- USER admin ANLEGEN
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

-- Plugins anzeigen
SELECT 
	user, 
	plugin 
FROM mysql.user;

-- Rechte (Privilegien) @admin zuweisen
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

-- update der Berechtigungen
FLUSH PRIVILEGES;

-- als  @root abmelden
exit

-- Unter LINUX als admin in MySQL anmelden / @admin
mysql -u admin -p

-- @admin: welche Rechte habe ich?
SHOW GRANTS FOR 'admin'@'localhost';

 -- @admin:  Anlegen allg. USER max
 CREATE USER 'max'@'localhost' IDENTIFIED BY 'max';

-- Unter LINUX als max in MySQL anmelden
mysql -u max -p

SHOW GRANTS FOR 'max'@'localhost';


 -- @admin: Rechte hinzufügen
GRANT
	SHOW DATABASES, SELECT
	ON *.*
	TO 'max'@'localhost';

FLUSH PRIVILEGES;


-- login als max

 -- @max: OK
SHOW DATABASES;
SELECT * FROM mydb.employees;
SELECT * FROM mydb.countries;	
	
-- @max: keine Berechtigung
DROP TABLE mydb.employees; 

-- @admin
GRANT
	DROP
	ON mydb.*
	TO 'max'@'localhost';
	
FLUSH PRIVILEGES;

-- @max: OK
DROP TABLE mydb.employees; 

-- @admin: Löschberechtigung in mydb für user max wieder entziehen
REVOKE
	DROP
	ON mydb.*
	FROM 'max'@'localhost';
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'max'@'localhost';

-- @max: keine Berechtigung mehr 
DROP TABLE mydb.countries; 

-- @admin: User max löschen
DROP USER 'max'@'localhost';

