-- Creating Class Master TABLE
-- Giving class_id as PRIMARY KEY

CREATE TABLE class_master
(
	class_id NUMBER(2) CONSTRAINT class_id_pk	PRIMARY KEY,
	name VARCHAR2(25)
);

--Inserting values into class_master

INSERT INTO class_master VALUES(00,'Business/Economy Class');
INSERT INTO class_master VALUES(01,'Business Class');
INSERT INTO class_master VALUES(02,'Economy Class');