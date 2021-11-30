/*
	Creating Customer Login Details TABLE to store Customer ID and Password.
*/

CREATE TABLE customer_login_dtls
(
	customer_id NUMBER (10) CONSTRAINT login_fk 
					REFERENCES customer_master (customer_id),
	password VARCHAR2(20)
);


--Inserting Values into Customer Login Details TABLE.
INSERT INTO customer_login_dtls VALUES (100,'nithinleo12');
INSERT INTO customer_login_dtls VALUES (101,'messi@leo');
INSERT INTO customer_login_dtls VALUES (102,'ronaldo@123');
INSERT INTO customer_login_dtls VALUES (103,'john_cena@@');
INSERT INTO customer_login_dtls VALUES (104,'88robert88');
INSERT INTO customer_login_dtls VALUES (105,'@@vin@@');
INSERT INTO customer_login_dtls VALUES (106,'@#michelle12');
INSERT INTO customer_login_dtls VALUES (107,'d@jhonson@#');
INSERT INTO customer_login_dtls VALUES (108,'hasham123@ali');
INSERT INTO customer_login_dtls VALUES (109,'nizam@#h');