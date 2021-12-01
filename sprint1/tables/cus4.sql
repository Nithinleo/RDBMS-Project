/* Creating Customer Phone Master TABLE
	 Adding customer_id as FOREIGN KEY which references to 
		PRIMARY KEY(customer_id) in customer_master TABLE
		Also, giving ON DELETE CONSTRAINT to it.
*/

CREATE TABLE customer_phn_mast
(
	customer_id NUMBER(10) CONSTRAINT cust_phn_fk 
				REFERENCES customer_master(customer_id) ON DELETE CASCADE,
	phone1	NUMBER NOT NULL,
	phone2	NUMBER
);


--Inserting Values into Customer Phone Master TABLE.

INSERT INTO customer_phn_mast VALUES (100,9391947194,7903018913);
INSERT INTO customer_phn_mast VALUES (101,7570129301,0571204103);
INSERT INTO customer_phn_mast VALUES (102,0128012839,4691293504);
INSERT INTO customer_phn_mast VALUES (103,8801293075,6649123059);
INSERT INTO customer_phn_mast VALUES (104,5712093122,'');
INSERT INTO customer_phn_mast VALUES (105,0021938472,5612983127);
INSERT INTO customer_phn_mast VALUES (106,6219309507,'');
INSERT INTO customer_phn_mast VALUES (107,0102834721,'');
INSERT INTO customer_phn_mast VALUES (108,7612300072,'');
INSERT INTO customer_phn_mast VALUES (109,4712397021,5012821490);