/*
	Creating a Flight Masters TABLE
		Adding flight_no as PRIMARY KEY CONSTRAINT
		Airline_code as FOREIGN KEY which reference to Airline Master TABLE
		Class_id as FOREIGN KEY which references to Class Master TABLE.
		Smoking_sing Attribute with CHECK CONSTRAINT
*/

CREATE TABLE flight_master
(
	flight_no	VARCHAR2(10) CONSTRAINT flight_no_pk PRIMARY KEY,
	airline_code	CHAR(5) CONSTRAINT fairl_code_fk 
			REFERENCES airline_master(airline_code) ON DELETE CASCADE,
	class_id	NUMBER(2) CONSTRAINT f_classid_fk 
			REFERENCES class_master(class_id) ON DELETE CASCADE,
	smoking_sign	CHAR(3) CONSTRAINT smoke_ck CHECK(smoking_sign IN ('YES','NO'))
);

--Inserting Values INTO Flight Master TABLE

INSERT INTO flight_master VALUES ('A1001','IG',2,'NO');
INSERT INTO flight_master VALUES ('A1002','SJ',1,'NO');
INSERT INTO flight_master VALUES ('A1003','V',2,'YES');
INSERT INTO flight_master VALUES ('A1004','AI',1,'YES');
INSERT INTO flight_master VALUES ('A1005','AA',0,'YES');
INSERT INTO flight_master VALUES ('B1001','IG',1,'YES');
INSERT INTO flight_master VALUES ('B1002','AA',0,'NO');
INSERT INTO flight_master VALUES ('B1003','SJ',2,'NO');
INSERT INTO flight_master VALUES ('B1004','V',0,'NO');
INSERT INTO flight_master VALUES ('B1005','GF',2,'YES');