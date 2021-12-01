/*
	Creating a AIRLINE Masters TABLE
		Airline_code as PRIMARY KEY
*/

CREATE TABLE airline_master
(
	airline_code	CHAR(5) CONSTRAINT airl_code_pk	PRIMARY KEY,
	airline_name	VARCHAR2(20)
);

--Inserting values into Airline Masters TABLE

INSERT INTO airline_master VALUES ('IG','IndiGo');
INSERT INTO airline_master VALUES ('AI','Air India');
INSERT INTO airline_master VALUES ('SJ','Spice Jet');
INSERT INTO airline_master VALUES ('GF','Go First');
INSERT INTO airline_master VALUES ('V','Vistara');
INSERT INTO airline_master VALUES ('AA','AirAsia India');