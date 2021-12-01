/* Creating Customer_master TABLE */

CREATE TABLE customer_master
(
	customer_id	NUMBER(10) CONSTRAINT cust_id_pk PRIMARY KEY,
	first_name	VARCHAR2(20) NOT NULL,
	last_name	VARCHAR2(20) NOT NULL,
	gender CHAR(6) CONSTRAINT gender_ck CHECK (gender IN ('MALE','FEMALE')),
	age NUMBER(3)
);

--Creating Sequence
CREATE SEQUENCE my
	START WITH 100
	INCREMENT BY 1;

--Inserting Values into Customer Master TABLE.
INSERT INTO customer_master VALUES (my.NEXTVAL,'Nithin','Leo','MALE',22);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Messi','Leonel','MALE',45);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Ronaldo','Cristiano','MALE',55);
INSERT INTO customer_master VALUES (my.NEXTVAL,'John','Cena','MALE',50);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Robert','Wil','MALE',30);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Vin','Diesel','MALE',40);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Michelle','Rrotriguze','FEMALE',38);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Dwane','Jhonson','MALE',57);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Hasham','Ali','MALE',21);
INSERT INTO customer_master VALUES (my.NEXTVAL,'Nizam','Hyder','MALE',23);