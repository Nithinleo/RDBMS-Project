/* Creating Customer EmailID Master TABLE

	Adding customer_id as FOREIGN KYE which references to 
		PRIMARY KEY(customer_id) in customer_master TABLE
		& Giving ON DELETE Constraint to it.

	Also, Adding UNIQUE and CHECK constraint to email_id variable
*/

CREATE TABLE customer_email
(
	customer_id	NUMBER(10) CONSTRAINT cust_email_fk 
				REFERENCES customer_master(customer_id) ON DELETE CASCADE,
	email_id1	VARCHAR2(30) NOT NULL UNIQUE CHECK(regexp_like(email_id1,'([a-z]|[0-9])?@[a-z]')) NOVALIDATE ,
	email_id2 	VARCHAR2(30) UNIQUE CHECK(regexp_like(email_id2,'([a-z]|[0-9])?@[a-z]')) NOVALIDATE
);


--Inserting Values into Customer Email Master TABLE.

INSERT INTO customer_email VALUES (100,'nithinleo@gmail.com','leo@yahoo.in');
INSERT INTO customer_email VALUES (101,'messi@gmail.com','');
INSERT INTO customer_email VALUES (102,'ronaldo@yahoo.in','');
INSERT INTO customer_email VALUES (103,'john_cena@edu.in','');
INSERT INTO customer_email VALUES (104,'robert_cool@edu.in','will123@gmail.com');
INSERT INTO customer_email VALUES (105,'vin_diesel@wipro.in','diesel_per@mail.in');
INSERT INTO customer_email VALUES (106,'michelle_ro@gmail.com','rotrigueze@ss.in');
INSERT INTO customer_email VALUES (107,'jhonson_dwane@yahoo.in','');
INSERT INTO customer_email VALUES (108,'hasham1233@gmail.com','');
INSERT INTO customer_email VALUES (109,'hyderr_n12@facebook.com','nizamh12@ed.in');
