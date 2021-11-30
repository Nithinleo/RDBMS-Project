--Creating Status Master TABLE
-- Giving status_id as PRIMARY KEY

CREATE TABLE status_master
(
	status_id	CHAR(1) CONSTRAINT status_id_pk PRIMARY KEY,
	status 		VARCHAR2(10)
);

--Inserting Values into it

INSERT INTO status_master VALUES('B','BOOKED');
INSERT INTO status_master VALUES('C','CANCELLED');
INSERT INTO status_master VALUES('S','SCRATCHED');